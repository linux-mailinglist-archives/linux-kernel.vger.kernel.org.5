Return-Path: <linux-kernel+bounces-166841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A1F8BA0A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379B61F225DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479DC174EF4;
	Thu,  2 May 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="I5WsvHJQ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F700173335
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675114; cv=none; b=bEY3/8g5pNn6o+S5lJ88pMMqY/1+6bFInnP4lbbSQmtqZTRpV4wqbkOpX0nLaAsbUt/gTL4d/RxHZteyQO53skPCfMetEdwyUSlrDvLuZPiXeWtAZCEFLGyLd80Y2a9d488EZAdpn6MlbrR9FmZb5cD2fmYS+DYGNJijC/Z8elw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675114; c=relaxed/simple;
	bh=DYO6wp2PNJs1oAaYKgMhSDrUyVMp5LZ9ZlmLMbT7jiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G830ypazwegINdJ766ay5bQ8aoB0ugJYAYtngPgmBuc5omUCQim8o+HdCj1Rctk7u6CwaK7521+RnUZk4XJiCp2XnxfRJinY9c6/Wczwu1rnrQr2m8B2795F+a8R/L/yRS9GSlNChQ5rr6+Dq/7X9ksTy6gwtnnAxrDl/HNrXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=I5WsvHJQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a556d22fa93so976519566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1714675111; x=1715279911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YuY4zhDtxeWScv5v7eDvNS0kexkpLQe9RRT0brEVWeo=;
        b=I5WsvHJQ1uRRxhgLvWiK0RKQ53VSzyT7lCYiWX8YJNEjg4AWMb+Z75QEBdMkBQ59qd
         9eFFKv6kc2jKfEn6YRy4e1VtppmRaq9qwan+8byc4in8jrQoDf/KkoFw0nj03XcZ7AzO
         Ew4XbCJbUzwGATzvlXJRfxxaFEWyspGcVWRFSfkqsAJuf0H3mpyyrRsgpfYgX9i1ThdR
         tR6eYuxhp+jzxLnpIHei4z5NbOVFHVv9oLNQrjZFY52J50q7izP5XgO69EnszRo8nCo+
         B7IpHxPdCsMtniZRRsltSaHE8mTn6VIeF5UAzmvz/us57KdfHrGdbw4HgyPg4GqfumnB
         qS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714675111; x=1715279911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuY4zhDtxeWScv5v7eDvNS0kexkpLQe9RRT0brEVWeo=;
        b=jGYm9qdBAcWettsK3jVAgPIWkwnXmUfwIzXytOy3vZ9OMjv8iQOom2Q86cbvp9+Ap1
         9ef711ZFXoVj1bloD7gL3BWbHaq92lfQPM/9mAj0WxkCwADFpxw/T4YBBzUHXsVzyJmk
         EkszTlWVOy2OOoiQiVIHOHUFGRoWKbQ6s3roGcaxkhPuyz8peq8Js1/q93HIK8t/nMJX
         QayNygTUJeQ2noUTIvSoku9xxfMTk/mY1r/nQHW45iIacyDQHtFJHDAbBdSdUtgMP5c0
         Mg157D48GD/81daxqBVkE5bCgLJjs33FCjS9v2nnc+FNbUvPGR4/IoQRnX0Oz4uzobAp
         ZAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsAiCP3//LWSywlCfhK3U6hzFd+8aWkNdYxunJCU8D2svaVG2zjELzrRaFyXdLTntu8yMhLGGXi9gcdm8vQWxgSiZLmVc2DJedlPO0
X-Gm-Message-State: AOJu0YyiV2uH+3TTFLKl74bl9tnCp+LAXt2eXBlT5Ozvx1PdF/KKEozZ
	rsbFtoFE9PMG20zLb1vP8IvUO07wmJkPI9GMFJOh0hzGZxrWEMm1skHICtnto7DfwFh4ZoZkkGo
	0
X-Google-Smtp-Source: AGHT+IGufSKu2OJTlPmOnxFSmiHgsF4s4z8q3sAaen10nyp/83bwDPFckXBD3u70yxLvhQ1ubBYZZg==
X-Received: by 2002:a17:906:414c:b0:a58:c63b:3b85 with SMTP id l12-20020a170906414c00b00a58c63b3b85mr186920ejk.1.1714675110643;
        Thu, 02 May 2024 11:38:30 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090638c600b00a4e03823107sm810768ejd.210.2024.05.02.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 11:38:30 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon (max6639): Use regmap
Date: Fri,  3 May 2024 00:06:02 +0530
Message-ID: <20240502183604.1216576-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add regmap support & remove local caching.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
Changes in V3:
- Remove mutex lock
- Remove caching of variable pwm in max6639_data
- Use regmap_write_bits in suspend & resume
- Remove error check for data in attrube show/store functions.
- Remove goto

Changes in V2:
- Remove local caching in max6639_data struct.
- Use define MAX6639_NDEV wherever possible
---
 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/max6639.c | 334 +++++++++++++++++-----------------------
 2 files changed, 145 insertions(+), 190 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index bafc0058c728..e14ae18a973b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1233,6 +1233,7 @@ config SENSORS_MAX6621
 config SENSORS_MAX6639
 	tristate "Maxim MAX6639 sensor chip"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the MAX6639
 	  sensor chips.
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 5dd0349e8bd0..f914f1500c96 100644
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
@@ -67,22 +70,7 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
  * Client data (each client gets its own)
  */
 struct max6639_data {
-	struct i2c_client *client;
-	struct mutex update_lock;
-	bool valid;		/* true if following fields are valid */
-	unsigned long last_updated;	/* In jiffies */
-
-	/* Register values sampled regularly */
-	u16 temp[2];		/* Temperature, in 1/8 C, 0..255 C */
-	bool temp_fault[2];	/* Detected temperature diode failure */
-	u8 fan[2];		/* Register value: TACH count for fans >=30 */
-	u8 status;		/* Detected channel alarms and fan failures */
-
-	/* Register values only written to */
-	u8 pwm[2];		/* Register value: Duty cycle 0..120 */
-	u8 temp_therm[2];	/* THERM Temperature, 0..255 C (->_max) */
-	u8 temp_alert[2];	/* ALERT Temperature, 0..255 C (->_crit) */
-	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
+	struct regmap *regmap;
 
 	/* Register values initialized only once */
 	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
@@ -92,90 +80,43 @@ struct max6639_data {
 	struct regulator *reg;
 };
 
-static struct max6639_data *max6639_update_device(struct device *dev)
-{
-	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-	struct max6639_data *ret = data;
-	int i;
-	int status_reg;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
-		int res;
-
-		dev_dbg(&client->dev, "Starting max6639 update\n");
-
-		status_reg = i2c_smbus_read_byte_data(client,
-						      MAX6639_REG_STATUS);
-		if (status_reg < 0) {
-			ret = ERR_PTR(status_reg);
-			goto abort;
-		}
-
-		data->status = status_reg;
-
-		for (i = 0; i < 2; i++) {
-			res = i2c_smbus_read_byte_data(client,
-					MAX6639_REG_FAN_CNT(i));
-			if (res < 0) {
-				ret = ERR_PTR(res);
-				goto abort;
-			}
-			data->fan[i] = res;
-
-			res = i2c_smbus_read_byte_data(client,
-					MAX6639_REG_TEMP_EXT(i));
-			if (res < 0) {
-				ret = ERR_PTR(res);
-				goto abort;
-			}
-			data->temp[i] = res >> 5;
-			data->temp_fault[i] = res & 0x01;
-
-			res = i2c_smbus_read_byte_data(client,
-					MAX6639_REG_TEMP(i));
-			if (res < 0) {
-				ret = ERR_PTR(res);
-				goto abort;
-			}
-			data->temp[i] |= res << 3;
-		}
-
-		data->last_updated = jiffies;
-		data->valid = true;
-	}
-abort:
-	mutex_unlock(&data->update_lock);
-
-	return ret;
-}
-
 static ssize_t temp_input_show(struct device *dev,
 			       struct device_attribute *dev_attr, char *buf)
 {
 	long temp;
-	struct max6639_data *data = max6639_update_device(dev);
+	struct max6639_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	unsigned int val;
+	int res;
 
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
+	if (res < 0)
+		return res;
+
+	temp = val >> 5;
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP(attr->index), &val);
+	if (res < 0)
+		return res;
+
+	temp |= val << 3;
+	temp *= 125;
 
-	temp = data->temp[attr->index] * 125;
 	return sprintf(buf, "%ld\n", temp);
 }
 
 static ssize_t temp_fault_show(struct device *dev,
 			       struct device_attribute *dev_attr, char *buf)
 {
-	struct max6639_data *data = max6639_update_device(dev);
+	struct max6639_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	unsigned int val;
+	int res;
 
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
+	if (res < 0)
+		return res;
 
-	return sprintf(buf, "%d\n", data->temp_fault[attr->index]);
+	return sprintf(buf, "%d\n", val & 1);
 }
 
 static ssize_t temp_max_show(struct device *dev,
@@ -183,8 +124,14 @@ static ssize_t temp_max_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	unsigned int val;
+	int res;
 
-	return sprintf(buf, "%d\n", (data->temp_therm[attr->index] * 1000));
+	res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index), &val);
+	if (res < 0)
+		return res;
+
+	return sprintf(buf, "%d\n", (val * 1000));
 }
 
 static ssize_t temp_max_store(struct device *dev,
@@ -193,7 +140,6 @@ static ssize_t temp_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -201,12 +147,8 @@ static ssize_t temp_max_store(struct device *dev,
 	if (res)
 		return res;
 
-	mutex_lock(&data->update_lock);
-	data->temp_therm[attr->index] = TEMP_LIMIT_TO_REG(val);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_THERM_LIMIT(attr->index),
-				  data->temp_therm[attr->index]);
-	mutex_unlock(&data->update_lock);
+	regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index),
+		     TEMP_LIMIT_TO_REG(val));
 	return count;
 }
 
@@ -215,8 +157,14 @@ static ssize_t temp_crit_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	unsigned int val;
+	int res;
+
+	res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index), &val);
+	if (res < 0)
+		return res;
 
-	return sprintf(buf, "%d\n", (data->temp_alert[attr->index] * 1000));
+	return sprintf(buf, "%d\n", (val * 1000));
 }
 
 static ssize_t temp_crit_store(struct device *dev,
@@ -225,7 +173,6 @@ static ssize_t temp_crit_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -233,12 +180,8 @@ static ssize_t temp_crit_store(struct device *dev,
 	if (res)
 		return res;
 
-	mutex_lock(&data->update_lock);
-	data->temp_alert[attr->index] = TEMP_LIMIT_TO_REG(val);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_ALERT_LIMIT(attr->index),
-				  data->temp_alert[attr->index]);
-	mutex_unlock(&data->update_lock);
+	regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index),
+		     TEMP_LIMIT_TO_REG(val));
 	return count;
 }
 
@@ -248,8 +191,14 @@ static ssize_t temp_emergency_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	unsigned int val;
+	int res;
+
+	res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), &val);
+	if (res < 0)
+		return res;
 
-	return sprintf(buf, "%d\n", (data->temp_ot[attr->index] * 1000));
+	return sprintf(buf, "%d\n", (val * 1000));
 }
 
 static ssize_t temp_emergency_store(struct device *dev,
@@ -258,7 +207,6 @@ static ssize_t temp_emergency_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -266,12 +214,8 @@ static ssize_t temp_emergency_store(struct device *dev,
 	if (res)
 		return res;
 
-	mutex_lock(&data->update_lock);
-	data->temp_ot[attr->index] = TEMP_LIMIT_TO_REG(val);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_OT_LIMIT(attr->index),
-				  data->temp_ot[attr->index]);
-	mutex_unlock(&data->update_lock);
+	regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), TEMP_LIMIT_TO_REG(val));
+
 	return count;
 }
 
@@ -280,8 +224,14 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	unsigned int val;
+	int res;
+
+	res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), &val);
+	if (res < 0)
+		return res;
 
-	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
+	return sprintf(buf, "%d\n", val * 255 / 120);
 }
 
 static ssize_t pwm_store(struct device *dev,
@@ -290,7 +240,6 @@ static ssize_t pwm_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -300,38 +249,39 @@ static ssize_t pwm_store(struct device *dev,
 
 	val = clamp_val(val, 0, 255);
 
-	mutex_lock(&data->update_lock);
-	data->pwm[attr->index] = (u8)(val * 120 / 255);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_TARGTDUTY(attr->index),
-				  data->pwm[attr->index]);
-	mutex_unlock(&data->update_lock);
+	regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), val * 120 / 255);
+
 	return count;
 }
 
 static ssize_t fan_input_show(struct device *dev,
 			      struct device_attribute *dev_attr, char *buf)
 {
-	struct max6639_data *data = max6639_update_device(dev);
+	struct max6639_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	unsigned int val;
+	int res;
 
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+	res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(attr->index), &val);
+	if (res < 0)
+		return res;
 
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->rpm_range));
+	return sprintf(buf, "%d\n", FAN_FROM_REG(val, data->rpm_range));
 }
 
 static ssize_t alarm_show(struct device *dev,
 			  struct device_attribute *dev_attr, char *buf)
 {
-	struct max6639_data *data = max6639_update_device(dev);
+	struct max6639_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	unsigned int val;
+	int res;
 
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+	res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
+	if (res < 0)
+		return res;
 
-	return sprintf(buf, "%d\n", !!(data->status & (1 << attr->index)));
+	return sprintf(buf, "%d\n", !!(val & (1 << attr->index)));
 }
 
 static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
@@ -401,6 +351,11 @@ static int rpm_range_to_reg(int range)
 	return 1; /* default: 4000 RPM */
 }
 
+static int max6639_set_ppr(struct max6639_data *data, u8 channel, u8 ppr)
+{
+	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr << 6);
+}
+
 static int max6639_init_client(struct i2c_client *client,
 			       struct max6639_data *data)
 {
@@ -408,94 +363,76 @@ static int max6639_init_client(struct i2c_client *client,
 		dev_get_platdata(&client->dev);
 	int i;
 	int rpm_range = 1; /* default: 4000 RPM */
-	int err;
+	int err, ppr;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
-	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
-				  MAX6639_GCONFIG_POR);
+	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
 	if (err)
-		goto exit;
+		return err;
 
 	/* Fans pulse per revolution is 2 by default */
 	if (max6639_info && max6639_info->ppr > 0 &&
 			max6639_info->ppr < 5)
-		data->ppr = max6639_info->ppr;
+		ppr = max6639_info->ppr;
 	else
-		data->ppr = 2;
-	data->ppr -= 1;
+		ppr = 2;
+	ppr -= 1;
 
 	if (max6639_info)
 		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
 	data->rpm_range = rpm_range;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < MAX6639_NDEV; i++) {
 
 		/* Set Fan pulse per revolution */
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_PPR(i),
-				data->ppr << 6);
+		err = max6639_set_ppr(data, i, ppr);
 		if (err)
-			goto exit;
+			return err;
 
 		/* Fans config PWM, RPM */
-		err = i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG1(i),
-			MAX6639_FAN_CONFIG1_PWM | rpm_range);
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG1(i),
+				   MAX6639_FAN_CONFIG1_PWM | rpm_range);
 		if (err)
-			goto exit;
+			return err;
 
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
-			goto exit;
+			return err;
 
 		/*
 		 * /THERM full speed enable,
 		 * PWM frequency 25kHz, see also GCONFIG below
 		 */
-		err = i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG3(i),
-			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG3(i),
+				   MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
 		if (err)
-			goto exit;
+			return err;
 
 		/* Max. temp. 80C/90C/100C */
-		data->temp_therm[i] = 80;
-		data->temp_alert[i] = 90;
-		data->temp_ot[i] = 100;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_THERM_LIMIT(i),
-				data->temp_therm[i]);
+		err = regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(i), 80);
 		if (err)
-			goto exit;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_ALERT_LIMIT(i),
-				data->temp_alert[i]);
+			return err;
+		err = regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(i), 90);
 		if (err)
-			goto exit;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
+			return err;
+		err = regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(i), 100);
 		if (err)
-			goto exit;
+			return err;
 
 		/* PWM 120/120 (i.e. 100%) */
-		data->pwm[i] = 120;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
+		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
 		if (err)
-			goto exit;
+			return err;
 	}
 	/* Start monitoring */
-	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
-		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
-		MAX6639_GCONFIG_PWM_FREQ_HI);
-exit:
-	return err;
+	return regmap_write(data->regmap, MAX6639_REG_GCONFIG,
+			    MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
+			    MAX6639_GCONFIG_PWM_FREQ_HI);
+
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
@@ -524,6 +461,30 @@ static void max6639_regulator_disable(void *data)
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
@@ -535,7 +496,11 @@ static int max6639_probe(struct i2c_client *client)
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
@@ -558,8 +523,6 @@ static int max6639_probe(struct i2c_client *client)
 		}
 	}
 
-	mutex_init(&data->update_lock);
-
 	/* Initialize the max6639 chip */
 	err = max6639_init_client(client, data);
 	if (err < 0)
@@ -573,23 +536,18 @@ static int max6639_probe(struct i2c_client *client)
 
 static int max6639_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	int ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
-
-	if (ret < 0)
-		return ret;
+	int ret;
 
 	if (data->reg)
 		regulator_disable(data->reg);
 
-	return i2c_smbus_write_byte_data(client,
-			MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDBY);
+	return regmap_write_bits(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_STANDBY,
+				 MAX6639_GCONFIG_STANDBY);
 }
 
 static int max6639_resume(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct max6639_data *data = dev_get_drvdata(dev);
 	int ret;
 
@@ -601,12 +559,8 @@ static int max6639_resume(struct device *dev)
 		}
 	}
 
-	ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
-	if (ret < 0)
-		return ret;
-
-	return i2c_smbus_write_byte_data(client,
-			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
+	return regmap_write_bits(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_STANDBY,
+				 ~MAX6639_GCONFIG_STANDBY);
 }
 
 static const struct i2c_device_id max6639_id[] = {

base-commit: 1d4d6733594d407e54153b8e031ba6356ceba81e
-- 
2.42.0


