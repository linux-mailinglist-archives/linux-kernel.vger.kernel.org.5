Return-Path: <linux-kernel+bounces-147290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 302798A720F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0E32836F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D7D12AAE3;
	Tue, 16 Apr 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="gQqHNfl8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF841CFBC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287860; cv=none; b=gOda2lhf5oghBZBV9zyNRzYf3CHPDkSfdkKZN6vyp9iyduvsQcBueo7Q3gE1YZmj1Ly2DGyy7UsmJQ+QfmAMJ0PhvWsgGHpnt/MhaCTdoPn2D9tyhRWfZwnkl8iWEBwj0KdMx07DxQ4KNrbCAscwt88N8cwkD1Rj+c1lZnps5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287860; c=relaxed/simple;
	bh=/GxMiRdI/JMTI1kbhEn4+RjTeCislwirrmxHYfWYVH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jc1bXKnz7Dgw2rvSCJPedXWdr1qnqWzYip8oRefPMDK3/ykin8tzLF2Wz0reZuPo4q8VTnr7BblUTxhwomYwlkLWb6Tz7U7DZdDssuy9waHFjMoy6vU22TzVIV+ym67LBLi4hywVaPg4PE8jE8qBZCb6VZgatxzF0hQNvRoCmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=gQqHNfl8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41882c16824so11244735e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1713287857; x=1713892657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iyPmW5Ym/nFDwOVsvSG6SeSPNyoctNpvlwNiBL7nS1k=;
        b=gQqHNfl82laqKZ5zEsO+77iB83M3IVAqXvahb7xG9mQl3sPqce/2KVVSrMoL9U2th6
         GB6kJU/YKCdKZ5sCku93J43haw/s852PMOZFjkiK6GV15kUp4hmpI9JZqvOBT1ag4kH4
         3z5HISQklGuUxUSvX7x989gjV/k6zwHS/extKVQXxQpxOAIcCCCqEcHSJWFWrVnH/Jg3
         bRssHxqFxlOF5rXU80RcB16XPxSuVRIPm5pV2fTo9hEIykQCuAxf5Hz1Ux/v8vr6e+7g
         M5tKVEe+y2XZzMU1+PeA32jhXyKyQjuZQJHbLZd2otHOUlGP/mWeq64n6ijE2p5q3rZE
         YN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713287857; x=1713892657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyPmW5Ym/nFDwOVsvSG6SeSPNyoctNpvlwNiBL7nS1k=;
        b=Pi3fHqKHNebTc1Xu3JY9/rv/WPh/4hu7qzVk8Pe2S1G0UZWBkGNfvZjEnirrcMP1vr
         DsDl9WEcqPshQFhsQUvyxzwifStqmbtzYIBCSXUKfsuc2q7fsoXrU2teygFRj9CogzBk
         SUUmjK3Y9VBXiA4sRpQrcRQd+lcm1YMlrTLCpmH8tk5kAIj66bNVnbsydL4roNyQ1VQW
         IGvi0q49J0KrsN7H4kcCz7adOu2JGDREZWQuycaX+Y5q+S8OaSxhknpLm3G8ph1Ih+Z7
         Ru+0M8FpWD0aJsollgVZAp/mjrHMq54tkU/F2AxKBRa+U8nfiL92a5G5Ps82tRzuNop/
         C9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVWCQdrPASQLFnQqMilVZT4cb6YqTMw71NQFsTIZL3kxHIL3wF43evQrBvGVq0OYpycysvaMgYHE7G1AsGmGr+7ui5kVklOJVJuNwi
X-Gm-Message-State: AOJu0YyTU0efryq+H8Myfqc7vMFJMCZBNn54dxXB1OT7QHsSGfYj95X7
	HJwyMUHrmPAtJG02Wy1aMgnvQ10HiwMSGEt95InFcbh6qosjyrUZZFtNJnIGUzM=
X-Google-Smtp-Source: AGHT+IF1JswyXjwjHrX1jMZoPN8PRlavj5b5c6CJ9+eL+NbUpkwdszk6wxvEFJrQmiNsS7YQD+Bbhg==
X-Received: by 2002:a05:600c:1907:b0:418:2636:ab4c with SMTP id j7-20020a05600c190700b004182636ab4cmr7933279wmq.6.1713287856844;
        Tue, 16 Apr 2024 10:17:36 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b004182fab5098sm13016326wmo.20.2024.04.16.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:17:36 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Guenter Roeck <linux@roeck-us.net>,
	krzysztof.kozlowski+dt@linaro.org,
	u.kleine-koenig@pengutronix.de,
	Jean Delvare <jdelvare@suse.com>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] hwmon (max6639): Use regmap
Date: Tue, 16 Apr 2024 22:47:14 +0530
Message-ID: <20240416171720.2875916-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add regmap support.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/max6639.c | 157 ++++++++++++++++++++--------------------
 2 files changed, 80 insertions(+), 78 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c89776d91795..257ec5360e35 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1223,6 +1223,7 @@ config SENSORS_MAX6621
 config SENSORS_MAX6639
 	tristate "Maxim MAX6639 sensor chip"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the MAX6639
 	  sensor chips.
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index aa7f21ab2395..1af93fc53cb5 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/platform_data/max6639.h>
+#include <linux/regmap.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
@@ -57,6 +58,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 
 #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
 
+#define MAX6639_NDEV				2
+
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
 #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
@@ -67,7 +70,7 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
  * Client data (each client gets its own)
  */
 struct max6639_data {
-	struct i2c_client *client;
+	struct regmap *regmap;
 	struct mutex update_lock;
 	bool valid;		/* true if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -95,9 +98,8 @@ struct max6639_data {
 static struct max6639_data *max6639_update_device(struct device *dev)
 {
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	struct max6639_data *ret = data;
-	int i;
+	int i, err;
 	int status_reg;
 
 	mutex_lock(&data->update_lock);
@@ -105,39 +107,35 @@ static struct max6639_data *max6639_update_device(struct device *dev)
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		int res;
 
-		dev_dbg(&client->dev, "Starting max6639 update\n");
+		dev_dbg(dev, "Starting max6639 update\n");
 
-		status_reg = i2c_smbus_read_byte_data(client,
-						      MAX6639_REG_STATUS);
-		if (status_reg < 0) {
-			ret = ERR_PTR(status_reg);
+		err = regmap_read(data->regmap, MAX6639_REG_STATUS, &status_reg);
+		if (err < 0) {
+			ret = ERR_PTR(err);
 			goto abort;
 		}
 
 		data->status = status_reg;
 
 		for (i = 0; i < 2; i++) {
-			res = i2c_smbus_read_byte_data(client,
-					MAX6639_REG_FAN_CNT(i));
-			if (res < 0) {
-				ret = ERR_PTR(res);
+			err = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(i), &res);
+			if (err < 0) {
+				ret = ERR_PTR(err);
 				goto abort;
 			}
 			data->fan[i] = res;
 
-			res = i2c_smbus_read_byte_data(client,
-					MAX6639_REG_TEMP_EXT(i));
-			if (res < 0) {
-				ret = ERR_PTR(res);
+			err = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(i), &res);
+			if (err < 0) {
+				ret = ERR_PTR(err);
 				goto abort;
 			}
 			data->temp[i] = res >> 5;
 			data->temp_fault[i] = res & 0x01;
 
-			res = i2c_smbus_read_byte_data(client,
-					MAX6639_REG_TEMP(i));
-			if (res < 0) {
-				ret = ERR_PTR(res);
+			err = regmap_read(data->regmap, MAX6639_REG_TEMP(i), &res);
+			if (err < 0) {
+				ret = ERR_PTR(err);
 				goto abort;
 			}
 			data->temp[i] |= res << 3;
@@ -193,7 +191,6 @@ static ssize_t temp_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -203,9 +200,8 @@ static ssize_t temp_max_store(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	data->temp_therm[attr->index] = TEMP_LIMIT_TO_REG(val);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_THERM_LIMIT(attr->index),
-				  data->temp_therm[attr->index]);
+	regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index),
+		     data->temp_therm[attr->index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -225,7 +221,6 @@ static ssize_t temp_crit_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -235,9 +230,8 @@ static ssize_t temp_crit_store(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	data->temp_alert[attr->index] = TEMP_LIMIT_TO_REG(val);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_ALERT_LIMIT(attr->index),
-				  data->temp_alert[attr->index]);
+	regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index),
+		     data->temp_alert[attr->index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -258,7 +252,6 @@ static ssize_t temp_emergency_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -268,9 +261,7 @@ static ssize_t temp_emergency_store(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	data->temp_ot[attr->index] = TEMP_LIMIT_TO_REG(val);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_OT_LIMIT(attr->index),
-				  data->temp_ot[attr->index]);
+	regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), data->temp_ot[attr->index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -290,7 +281,6 @@ static ssize_t pwm_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -302,9 +292,7 @@ static ssize_t pwm_store(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	data->pwm[attr->index] = (u8)(val * 120 / 255);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_TARGTDUTY(attr->index),
-				  data->pwm[attr->index]);
+	regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), data->pwm[attr->index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -411,8 +399,7 @@ static int max6639_init_client(struct i2c_client *client,
 	int err;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
-	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
-				  MAX6639_GCONFIG_POR);
+	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
 	if (err)
 		goto exit;
 
@@ -431,26 +418,21 @@ static int max6639_init_client(struct i2c_client *client,
 	for (i = 0; i < 2; i++) {
 
 		/* Set Fan pulse per revolution */
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_PPR(i),
-				data->ppr << 6);
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_PPR(i), data->ppr << 6);
 		if (err)
 			goto exit;
 
 		/* Fans config PWM, RPM */
-		err = i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG1(i),
-			MAX6639_FAN_CONFIG1_PWM | rpm_range);
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG1(i),
+				   MAX6639_FAN_CONFIG1_PWM | rpm_range);
 		if (err)
 			goto exit;
 
 		/* Fans PWM polarity high by default */
 		if (max6639_info && max6639_info->pwm_polarity == 0)
-			err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x00);
+			err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
 		else
-			err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x02);
+			err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
 		if (err)
 			goto exit;
 
@@ -458,9 +440,8 @@ static int max6639_init_client(struct i2c_client *client,
 		 * /THERM full speed enable,
 		 * PWM frequency 25kHz, see also GCONFIG below
 		 */
-		err = i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG3(i),
-			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG3(i),
+				   MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
 		if (err)
 			goto exit;
 
@@ -468,32 +449,26 @@ static int max6639_init_client(struct i2c_client *client,
 		data->temp_therm[i] = 80;
 		data->temp_alert[i] = 90;
 		data->temp_ot[i] = 100;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_THERM_LIMIT(i),
-				data->temp_therm[i]);
+		err = regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(i), data->temp_therm[i]);
 		if (err)
 			goto exit;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_ALERT_LIMIT(i),
-				data->temp_alert[i]);
+		err = regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(i), data->temp_alert[i]);
 		if (err)
 			goto exit;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
+		err = regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
 		if (err)
 			goto exit;
 
 		/* PWM 120/120 (i.e. 100%) */
 		data->pwm[i] = 120;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
+		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
 		if (err)
 			goto exit;
 	}
 	/* Start monitoring */
-	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
-		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
-		MAX6639_GCONFIG_PWM_FREQ_HI);
+	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG,
+			   MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
+			   MAX6639_GCONFIG_PWM_FREQ_HI);
 exit:
 	return err;
 }
@@ -524,6 +499,30 @@ static void max6639_regulator_disable(void *data)
 	regulator_disable(data);
 }
 
+static bool max6639_regmap_is_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX6639_REG_TEMP(0):
+	case MAX6639_REG_TEMP_EXT(0):
+	case MAX6639_REG_TEMP(1):
+	case MAX6639_REG_TEMP_EXT(1):
+	case MAX6639_REG_STATUS:
+	case MAX6639_REG_FAN_CNT(0):
+	case MAX6639_REG_FAN_CNT(1):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config max6639_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX6639_REG_DEVREV,
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_reg = max6639_regmap_is_volatile,
+};
+
 static int max6639_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -535,7 +534,11 @@ static int max6639_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &max6639_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev,
+				     PTR_ERR(data->regmap),
+				     "regmap initialization failed\n");
 
 	data->reg = devm_regulator_get_optional(dev, "fan");
 	if (IS_ERR(data->reg)) {
@@ -573,25 +576,24 @@ static int max6639_probe(struct i2c_client *client)
 
 static int max6639_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	int ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
+	int ret, err;
+
+	err = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &ret);
 
-	if (ret < 0)
-		return ret;
+	if (err < 0)
+		return err;
 
 	if (data->reg)
 		regulator_disable(data->reg);
 
-	return i2c_smbus_write_byte_data(client,
-			MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDBY);
+	return regmap_write(data->regmap, MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDBY);
 }
 
 static int max6639_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	int ret;
+	int ret, err;
 
 	if (data->reg) {
 		ret = regulator_enable(data->reg);
@@ -601,12 +603,11 @@ static int max6639_resume(struct device *dev)
 		}
 	}
 
-	ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
-	if (ret < 0)
-		return ret;
+	err = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &ret);
+	if (err < 0)
+		return err;
 
-	return i2c_smbus_write_byte_data(client,
-			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
+	return regmap_write(data->regmap, MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
 }
 
 static const struct i2c_device_id max6639_id[] = {

base-commit: db85dba9fee5fed54e2c37eed465f8fd243a92e8
-- 
2.42.0


