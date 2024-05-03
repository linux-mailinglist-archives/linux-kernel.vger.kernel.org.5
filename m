Return-Path: <linux-kernel+bounces-167615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C518BAC07
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDEFB21DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDD152DF4;
	Fri,  3 May 2024 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="hUD+9Oj5"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013914F9F9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737631; cv=none; b=YeNkZbGhAiIRm+TxxcvLUWMLhMXEOGRD7DEq847Li640+k3CIw4oQGvz2xJVlGDrJ5xIhgDg0+eFyf+pBOvqWGrJoNFbQ+q1eeizHosyt6LW/Sl/rqjGs5bGVSBsmr5G4WHmjpn+8uaUAG8hXWYGNxWt1I2kej4nLXrSStjvQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737631; c=relaxed/simple;
	bh=yJ5WEmD9asrt9+LP+4Z9bIRKxfwJydYtu0uUo6KF13w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmbINJ8BOEpHMknriABlKs01nwLzs0+e2xCiGRU8e9Oqz8GDelvd1mJ5cxCjk4i4IuLUFmbsQ1Be02lVE2X06PGorUP5RRCQTnlFlssPkf41jaI0ZMbWTCAUvIHfV56z3jJIe2Hbnkq6alV1CHppZaf0x0aRboYcV/CeCkfuRi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=hUD+9Oj5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599c55055dso42242866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1714737627; x=1715342427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2/K916Fa8u8Ra+NeVn+ipoHj85KxcB3+Z8xc+HZ3DI=;
        b=hUD+9Oj5djf0aa3oCErJFqRuArc9R6Ll/RV6FX8hCgUNpK6mk3S7fKkkTYaGZmpUZ0
         l8w+Rc5WK850kLXy51bxzkMtRUw6T9Ul2nbH4wlxcgGQSX01GnUJIrpZQ0pT1+0OVbs1
         JKW+0rwkRBVbInOcVkPKbrOvG7xfKHTnO4qH6erk/kteL53XXoUpVWL2FBfUQlTemCFQ
         /McXUb0IHoEWJxqXMipluedz928UH+r27SGNSReiQ8sq2XeKNJXBc0TBWQH6V4iiBUe3
         yyh/IcpI0pVWZ7MGxo2oro5Ey91txaNKtxflFIGP58OwUySAcXL/vt2b27/AsQX4LUcg
         /Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714737627; x=1715342427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2/K916Fa8u8Ra+NeVn+ipoHj85KxcB3+Z8xc+HZ3DI=;
        b=e8ZGRj55cOHRTs4BhCgzxDCPPHCWMPm2IA2OW0PbPLNU0On5edFdx4pLgGwtht5FbH
         1PBD/zYgyLhoEsTp/g7BppGCHQef0nK5c8AxooXVd4Qn/6h9bqvSv9sowRe9znyG0Pkl
         8OKhVSO45xzR1HeYDbMZtIDjfLjzQwijPTju2a+sgBdOhqjq7HfAw2AKeA09+uXroiW4
         W/t4aVuRk8sjTEtMQCLX/lbukafkFi197lls0yvP6Cpea7N/P2l84rCNc+fxbkRwj1dx
         vV/rQvBtscpmc5A1R+P1kSJvhE1MHsYDwaOBeeNUKbF4bcOG/jxbLTnEfQTjuRjwqGVX
         7u2A==
X-Forwarded-Encrypted: i=1; AJvYcCX+3IP2DdieDa1P4joLkFymlTR1I5SkjxzgpFvQBW0eD8gsyHJd/4OJo6sT8VKQtvwdHk2TvjNMkWkbYEZm45RWa2/PzDmp2j9Hpe6a
X-Gm-Message-State: AOJu0Yz4d04PhzY2IA+GCpbwpgTWJXgM/msKdFeITAKK7g/3AqT0UfTI
	yaBuGKPkNLP9JMIUCdznD4p48BDw9wp8MYLcdt8Kx5Ar6dtRU7sEgbwfUp5Jw7U=
X-Google-Smtp-Source: AGHT+IEmot1bFI3ngYi/Idsua+TkAkNolM5pyTKAsEchCSMh+1bhCF5sLisq+CihRoggCzzqP19Low==
X-Received: by 2002:a50:ccd3:0:b0:570:5e7e:474e with SMTP id b19-20020a50ccd3000000b005705e7e474emr1488238edj.22.1714737626690;
        Fri, 03 May 2024 05:00:26 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p12-20020a05640243cc00b0057059d26756sm1589117edc.76.2024.05.03.05.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:00:26 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] hwmon (max6639): Use regmap
Date: Fri,  3 May 2024 17:30:19 +0530
Message-ID: <20240503120020.3450972-1-naresh.solanki@9elements.com>
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
Changes in V4:
- Rename MAX6639_NDEV to MAX6639_NUM_CHANNELS
- Add comment for MAX6639_REG_TEMP register read
- Add MAX6639_REG_TARGTDUTY as volatile
- Remove unused variable ret in max6639_suspend function

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
 drivers/hwmon/max6639.c | 339 ++++++++++++++++++----------------------
 2 files changed, 150 insertions(+), 190 deletions(-)

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
index 5dd0349e8bd0..cbb595fe47aa 100644
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
 
+#define MAX6639_NUM_CHANNELS			2
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
@@ -92,90 +80,47 @@ struct max6639_data {
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
+
+	/*
+	 * Lock isn't needed as MAX6639_REG_TEMP wpnt change for at least 250ms after reading
+	 * MAX6639_REG_TEMP_EXT
+	 */
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
+	if (res < 0)
+		return res;
+
+	temp = val >> 5;
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP(attr->index), &val);
+	if (res < 0)
+		return res;
 
-	if (IS_ERR(data))
-		return PTR_ERR(data);
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
@@ -183,8 +128,14 @@ static ssize_t temp_max_show(struct device *dev,
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
@@ -193,7 +144,6 @@ static ssize_t temp_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -201,12 +151,8 @@ static ssize_t temp_max_store(struct device *dev,
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
 
@@ -215,8 +161,14 @@ static ssize_t temp_crit_show(struct device *dev,
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
@@ -225,7 +177,6 @@ static ssize_t temp_crit_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -233,12 +184,8 @@ static ssize_t temp_crit_store(struct device *dev,
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
 
@@ -248,8 +195,14 @@ static ssize_t temp_emergency_show(struct device *dev,
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
@@ -258,7 +211,6 @@ static ssize_t temp_emergency_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -266,12 +218,8 @@ static ssize_t temp_emergency_store(struct device *dev,
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
 
@@ -280,8 +228,14 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	unsigned int val;
+	int res;
 
-	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
+	res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), &val);
+	if (res < 0)
+		return res;
+
+	return sprintf(buf, "%d\n", val * 255 / 120);
 }
 
 static ssize_t pwm_store(struct device *dev,
@@ -290,7 +244,6 @@ static ssize_t pwm_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -300,38 +253,39 @@ static ssize_t pwm_store(struct device *dev,
 
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
@@ -401,6 +355,11 @@ static int rpm_range_to_reg(int range)
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
@@ -408,94 +367,76 @@ static int max6639_init_client(struct i2c_client *client,
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
+	for (i = 0; i < MAX6639_NUM_CHANNELS; i++) {
 
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
@@ -524,6 +465,32 @@ static void max6639_regulator_disable(void *data)
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
+	case MAX6639_REG_TARGTDUTY(0):
+	case MAX6639_REG_TARGTDUTY(1):
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
@@ -535,7 +502,11 @@ static int max6639_probe(struct i2c_client *client)
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
@@ -558,8 +529,6 @@ static int max6639_probe(struct i2c_client *client)
 		}
 	}
 
-	mutex_init(&data->update_lock);
-
 	/* Initialize the max6639 chip */
 	err = max6639_init_client(client, data);
 	if (err < 0)
@@ -573,23 +542,17 @@ static int max6639_probe(struct i2c_client *client)
 
 static int max6639_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	int ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
-
-	if (ret < 0)
-		return ret;
 
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
 
@@ -601,12 +564,8 @@ static int max6639_resume(struct device *dev)
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


