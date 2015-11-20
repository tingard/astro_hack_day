
library(FITSio)
library(sphereplot)
library(cosmoFns)
#install_github("rgl", "trestletech", "js-class") 

library(devtools)
devtools::install_github("rthreejs",username = "bwlewis")

library(threejs)

setwd("/home/chris/Projects/HackDayAstro/")



## Data set 1
# data <- read.csv("/home/chris/Projects/HackDayAstro/fits_data.csv", header = T)
#   
# data <- data[data$photo.z > 0 & data$photo.z < 9, ]
# 
# data$D.L <- cosmoFns::D.L(data$photo.z)
# 
# #plot(data$photo.z, data$D.L)
# 
# cart <- sphereplot::sph2car(long = data$RA, lat = data$DEC, radius = data$D.L, deg = TRUE)




## Data set 2
data.2 <- FITSio::readFITS("/home/chris/Projects/HackDayAstro/WP8_photoz_XMM_LSS.fits", hdu = 2)

dt <- data.frame(data.2$col)
names(dt) <- data.2$colNames

dt$z <- 10^(dt$alz) - 1

dt$D.L <- cosmoFns::D.L(dt$z)
#plot(dt$z, dt$D.L)

cart.2 <- sphereplot::sph2car(long = dt$RA, lat = dt$DEC, radius = dt$D.L, deg = TRUE)





# ignore data set 1 
cart.full <- data.frame(cart.2)
cart.full <- data.frame(cart.full,dt$alm)

# cart <- data.frame(cart)
# cart.2 <- data.frame(cart.2)
# cart.full <- merge(cart,cart.2,all = T)


## combine both data sets

write.csv(cart.full,file = "shinyHackDay/cart.csv")

# library(rgl)
# library(shinyRGL)

library(plotrix)
threejs::scatterplot3js(cart.full$x, cart.full$y, cart.full$z, bg = "black", flip.y = T)

#rgl::plot3d(cart.full$x, cart.full$y, cart.full$z, col = color.scale(cart.full$dt.alm))

