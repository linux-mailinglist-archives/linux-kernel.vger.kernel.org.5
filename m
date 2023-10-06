Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E127BC253
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjJFWpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjJFWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:45:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BEC10A;
        Fri,  6 Oct 2023 15:44:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E078DC433D9;
        Fri,  6 Oct 2023 22:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632298;
        bh=rsuLvtPZieeVynmOZTmnXXStTu0E/YWo9FrSL29+J+0=;
        h=From:To:Cc:Subject:Date:From;
        b=rtgrXkkccCWrEHzNN1qR0Mb39Oz+p6/BMAKxtnSvAvquuyZl/F+ydp9wD5zYljRDi
         mOnCIi9gYtyHPSVq769iI9zCYgZoPi8c6EIH1sfWp18HgdJ9c+eFMT8z3/leu8zc1+
         SV3Ody2D2rNQt9MuV8oZ87asSn7SWi/NZyXjpvT1nX0WyKyZW6dTQaWRDaa5kSGVPZ
         VLIQzEY+loh6mD8iViQ0bbFTBPosN5fiN4uVYtV9l8k1InADt+00Q8/zqyG4k5yHhA
         bqLZkoNeHoNHjfnm21exnDUp2NMYXPB7GkK38SyTwMgEgDajbA1Nb0pWF+kfHrnfaQ
         i1yMj6CNgki1A==
Received: (nullmailer pid 443258 invoked by uid 1000);
        Fri, 06 Oct 2023 22:44:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: Use i2c_get_match_data()
Date:   Fri,  6 Oct 2023 17:44:52 -0500
Message-Id: <20231006224452.443154-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred i2c_get_match_data() instead of of_match_device() and
i2c_match_id() to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/hwmon/max6650.c       |  8 +++-----
 drivers/hwmon/nct6775-i2c.c   | 14 ++------------
 drivers/hwmon/nct6775.h       |  2 +-
 drivers/hwmon/pmbus/lm25066.c | 14 +++-----------
 4 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index cc8428a3045d..9649c6611d5f 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -26,7 +26,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/thermal.h>
 
 /*
@@ -763,8 +763,6 @@ static int max6650_probe(struct i2c_client *client)
 {
 	struct thermal_cooling_device *cooling_dev;
 	struct device *dev = &client->dev;
-	const struct of_device_id *of_id =
-		of_match_device(of_match_ptr(max6650_dt_match), dev);
 	struct max6650_data *data;
 	struct device *hwmon_dev;
 	int err;
@@ -776,8 +774,8 @@ static int max6650_probe(struct i2c_client *client)
 	data->client = client;
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
-	data->nr_fans = of_id ? (int)(uintptr_t)of_id->data :
-				i2c_match_id(max6650_id, client)->driver_data;
+
+	data->nr_fans = (uintptr_t)i2c_get_match_data(client);
 
 	/*
 	 * Initialize the max6650 chip
diff --git a/drivers/hwmon/nct6775-i2c.c b/drivers/hwmon/nct6775-i2c.c
index 87a4fc78c571..63b669d511f4 100644
--- a/drivers/hwmon/nct6775-i2c.c
+++ b/drivers/hwmon/nct6775-i2c.c
@@ -21,7 +21,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include "nct6775.h"
 
@@ -155,23 +155,13 @@ static const struct regmap_config nct6775_i2c_regmap_config = {
 static int nct6775_i2c_probe(struct i2c_client *client)
 {
 	struct nct6775_data *data;
-	const struct of_device_id *of_id;
-	const struct i2c_device_id *i2c_id;
 	struct device *dev = &client->dev;
 
-	of_id = of_match_device(nct6775_i2c_of_match, dev);
-	i2c_id = i2c_match_id(nct6775_i2c_id, client);
-
-	if (of_id && (unsigned long)of_id->data != i2c_id->driver_data)
-		dev_notice(dev, "Device mismatch: %s in device tree, %s detected\n",
-			   of_id->name, i2c_id->name);
-
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->kind = i2c_id->driver_data;
-
+	data->kind = (enum kinds)i2c_get_match_data(client);
 	data->read_only = true;
 	data->driver_data = client;
 	data->driver_init = nct6775_i2c_probe_init;
diff --git a/drivers/hwmon/nct6775.h b/drivers/hwmon/nct6775.h
index 296eff99d003..d31e7a030216 100644
--- a/drivers/hwmon/nct6775.h
+++ b/drivers/hwmon/nct6775.h
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 
-enum kinds { nct6106, nct6116, nct6775, nct6776, nct6779, nct6791, nct6792,
+enum kinds { nct6106 = 1, nct6116, nct6775, nct6776, nct6779, nct6791, nct6792,
 	     nct6793, nct6795, nct6796, nct6797, nct6798, nct6799 };
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
 
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 929fa6d34efd..bd43457094a6 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -14,10 +14,10 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/log2.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "pmbus.h"
 
-enum chips { lm25056, lm25066, lm5064, lm5066, lm5066i };
+enum chips { lm25056 = 1, lm25066, lm5064, lm5066, lm5066i };
 
 #define LM25066_READ_VAUX		0xd0
 #define LM25066_MFR_READ_IIN		0xd1
@@ -468,8 +468,6 @@ static int lm25066_probe(struct i2c_client *client)
 	struct lm25066_data *data;
 	struct pmbus_driver_info *info;
 	const struct __coeff *coeff;
-	const struct of_device_id *of_id;
-	const struct i2c_device_id *i2c_id;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
@@ -484,14 +482,8 @@ static int lm25066_probe(struct i2c_client *client)
 	if (config < 0)
 		return config;
 
-	i2c_id = i2c_match_id(lm25066_id, client);
+	data->id = (enum chips)i2c_get_match_data(client);
 
-	of_id = of_match_device(lm25066_of_match, &client->dev);
-	if (of_id && (unsigned long)of_id->data != i2c_id->driver_data)
-		dev_notice(&client->dev, "Device mismatch: %s in device tree, %s detected\n",
-			   of_id->name, i2c_id->name);
-
-	data->id = i2c_id->driver_data;
 	info = &data->info;
 
 	info->pages = 1;
-- 
2.40.1

