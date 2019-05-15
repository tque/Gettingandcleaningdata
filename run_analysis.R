library(dplyr)
library(tidyr)


setwd("C:\\Users\\TQ\\Desktop\\UCI HAR Dataset")




##
##

X_train <- read.table("C:/Users/TQ/Desktop/UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
y_train <- read.table("C:/Users/TQ/Desktop/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("C:/Users/TQ/Desktop/UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("C:/Users/TQ/Desktop/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/Users/TQ/Desktop/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("C:/Users/TQ/Desktop/UCI HAR Dataset/test/subject_test.txt")

feature_name <- read.table("C:/Users/TQ/Desktop/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

activity_label <- read.table("C:/Users/TQ/Desktop/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

##

names <- c("subject_id", feature_name$V2, "activity_id")
merge_train <- cbind(subject_train, X_train, y_train)
merge_test <- cbind(subject_test, X_test, y_test)
mergedata <- rbind(merge_train, merge_test)
colnames(mergedata) <- names

colnames(activity_label) <- c("activity_id", "activity_name")

##

feature_mean_std <- mergedata[, grepl("subject_id|activity_id|mean|std", names)]

##

feature_named_act <- merge(feature_mean_std, activity_label, by = "activity_id")
feature_named_act$"activity_id" = NULL

##

unique_act_sub <- aggregate(. ~ subject_id + activity_name, feature_named_act, FUN = mean)
unique_act_sub <- arrange(unique_act_sub, subject_id, activity_name)
write.table(unique_act_sub, "unique_act_sub.txt", row.names = FALSE)
str(unique_act_sub)
unique_act_sub
