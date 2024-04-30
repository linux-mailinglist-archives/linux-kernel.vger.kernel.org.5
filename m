Return-Path: <linux-kernel+bounces-164727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A26A8B81C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8625F1F247AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618431A0B07;
	Tue, 30 Apr 2024 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="XfOYa4oY"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A41A0AF9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714511114; cv=none; b=an/IVnQLFkrNwj98jJea7srnQeaNje3I+cYhln8smQSScfv/r+36XwpxrPLY9W9nE1RibcBCYPWFfTxZKxjthOxLZ+TNdYYYk41fZKE1yky17ZtnaMCpsTvIPN5a0s47cfjVjbXnOqOSoNsGWM3oH18ZCw3DS9ix/Z6sj58Hif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714511114; c=relaxed/simple;
	bh=KLcb0NDwuIx241UKNfejyZb12C0ZDY+GzOzoqmfyoPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1KmHWoO10rLDQhgQqTDbhASQomey7V1LtpdU8/kIZoQx31z9u9ZdxnAMAhzVqvvQ+1zMt8xFW31tCHocBRuta7ZAQkbe7upW7ymAQv9mNp8d0tIP+a8zssSMXJUQAeHi4iuNOJEcrQWSHL9bjNe1VHqIg9lYWj2uqZnZbPF0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=XfOYa4oY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso46552445e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1714511111; x=1715115911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdXbVOf7X2hgQ5AxJONB1g2nuUIOvffE/hB/3N0SbRs=;
        b=XfOYa4oY1Q0HHl6Lz6UmMWJwD4/B0tuC+J5EB9y2V8H7yOfT7ybh2u1D1RBZ8OlDGB
         Ux1NKRbbxruEl94bAtGAdJCUJTn8Nd82v0Fu9zfPir0CJhPq6cA+Vdvgspdl5zrBnhDI
         SmTEUqgZ+PKiyKwZoFRwcsGh4ZKlYHHctDC3P2RglpevC4pHczdbjaiVl535PQM0+0ob
         mdeT+9dFE1K6srWPTtlA5djfryFNHE9wVBAQK08AoOo2qYze0O3kksAwLsNAWgu6hIQt
         u/PYVhmWeOM0uE33aY6CpWyM2tTDsml1tJjs2HfuqoPu0RjYnQb9+QNjpsgWMAPu9UUG
         nbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714511111; x=1715115911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdXbVOf7X2hgQ5AxJONB1g2nuUIOvffE/hB/3N0SbRs=;
        b=goFT/9faqzxQTiMuyjgS6vvZE3ZDiijcHYfCrYvn5ZbaSLAuM7i4B1drIsMwm1jCMD
         j1zsu3ReW6cQ7EQXZVTlPuwFDmOuTqW3/HioV++zBAhwR78XG7KFiI6bSTlbgXy7MJxR
         lFBSZ/1zMs+ZgcyJI6Ig+nrrz856UDP1dnnXQtw1OqG6FTI9hZiXXN3JEdgYuNx6ztKw
         L2uVdW+0FN+p540fVa4LGk3FG0nBuLNcDQ1aS6AsQHXmjDFyERSlfuHgZxi4uLRTyLIi
         J1sPHdb9cH8hxCcg/GoIq43EWQjWn6g1bFJS+KHIFhZtrmuLHHFoA2IdcL2F4xCz1XMl
         Y4mg==
X-Forwarded-Encrypted: i=1; AJvYcCU3oGgbjSxKKH9jsRekyKSl5uZY2p3oUpSpVz8N1tBz5b3opn9r562hK0x0hMP1RsmuRq19PChUEMSR/KV1tnLsfZIIqDBi35cRD28t
X-Gm-Message-State: AOJu0YzEK7uB6CzKXfZO+P3uxe9T1bAV2LDXQ86EHOgp9aDVLC6Xxuno
	1QNAY/rOIFFmGdkPlKqUlmJ7gCWh/elcDAQzDgQMT2+aYbmn89pKHAX1jKePONS9zOvEwM6JbHv
	b
X-Google-Smtp-Source: AGHT+IE+7DWRjQpVtGTda+vGPW5eV5S3JzHNGr03qYh+97XaXRzClMLmgjn3RXQpZpA2WRK8ZzSAvg==
X-Received: by 2002:a05:600c:450b:b0:41b:8660:c530 with SMTP id t11-20020a05600c450b00b0041b8660c530mr469363wmo.5.1714511110555;
        Tue, 30 Apr 2024 14:05:10 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id b7-20020adff907000000b0034b3394f0e1sm22414491wrr.10.2024.04.30.14.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:05:10 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon (max6639): Use regmap
Date: Wed,  1 May 2024 02:35:07 +0530
Message-ID: <20240430210508.934882-1-naresh.solanki@9elements.com>
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
 drivers/hwmon/Kconfig   |   1 +
 drivers/hwmon/max6639.c | 310 ++++++++++++++++++++--------------------
 2 files changed, 154 insertions(+), 157 deletions(-)

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
index 5dd0349e8bd0..b12d2098e259 100644
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
@@ -67,22 +70,11 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
  * Client data (each client gets its own)
  */
 struct max6639_data {
-	struct i2c_client *client;
+	struct regmap *regmap;
 	struct mutex update_lock;
-	bool valid;		/* true if following fields are valid */
-	unsigned long last_updated;	/* In jiffies */
-
-	/* Register values sampled regularly */
-	u16 temp[2];		/* Temperature, in 1/8 C, 0..255 C */
-	bool temp_fault[2];	/* Detected temperature diode failure */
-	u8 fan[2];		/* Register value: TACH count for fans >=30 */
-	u8 status;		/* Detected channel alarms and fan failures */
 
 	/* Register values only written to */
-	u8 pwm[2];		/* Register value: Duty cycle 0..120 */
-	u8 temp_therm[2];	/* THERM Temperature, 0..255 C (->_max) */
-	u8 temp_alert[2];	/* ALERT Temperature, 0..255 C (->_crit) */
-	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
+	u8 pwm[MAX6639_NDEV];		/* Register value: Duty cycle 0..120 */
 
 	/* Register values initialized only once */
 	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
@@ -92,90 +84,58 @@ struct max6639_data {
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
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	temp = data->temp[attr->index] * 125;
+	mutex_lock(&data->update_lock);
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
+	if (res < 0)
+		goto exit;
+
+	temp = val >> 5;
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP(attr->index), &val);
+	if (res < 0)
+		goto exit;
+
+	temp |= val << 3;
+	temp *= 125;
+
+exit:
+	mutex_unlock(&data->update_lock);
+	if (res < 0)
+		return res;
+
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
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return sprintf(buf, "%d\n", data->temp_fault[attr->index]);
+	mutex_lock(&data->update_lock);
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
+	mutex_unlock(&data->update_lock);
+
+	if (res < 0)
+		return res;
+
+	return sprintf(buf, "%d\n", val & 1);
 }
 
 static ssize_t temp_max_show(struct device *dev,
@@ -183,8 +143,17 @@ static ssize_t temp_max_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	unsigned int val;
+	int res;
 
-	return sprintf(buf, "%d\n", (data->temp_therm[attr->index] * 1000));
+	mutex_lock(&data->update_lock);
+	res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index), &val);
+	mutex_unlock(&data->update_lock);
+
+	if (res < 0)
+		return res;
+
+	return sprintf(buf, "%d\n", (val * 1000));
 }
 
 static ssize_t temp_max_store(struct device *dev,
@@ -193,7 +162,6 @@ static ssize_t temp_max_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -202,10 +170,8 @@ static ssize_t temp_max_store(struct device *dev,
 		return res;
 
 	mutex_lock(&data->update_lock);
-	data->temp_therm[attr->index] = TEMP_LIMIT_TO_REG(val);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_THERM_LIMIT(attr->index),
-				  data->temp_therm[attr->index]);
+	regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index),
+		     TEMP_LIMIT_TO_REG(val));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -215,8 +181,17 @@ static ssize_t temp_crit_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	unsigned int val;
+	int res;
+
+	mutex_lock(&data->update_lock);
+	res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index), &val);
+	mutex_unlock(&data->update_lock);
 
-	return sprintf(buf, "%d\n", (data->temp_alert[attr->index] * 1000));
+	if (res < 0)
+		return res;
+
+	return sprintf(buf, "%d\n", (val * 1000));
 }
 
 static ssize_t temp_crit_store(struct device *dev,
@@ -225,7 +200,6 @@ static ssize_t temp_crit_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -234,10 +208,8 @@ static ssize_t temp_crit_store(struct device *dev,
 		return res;
 
 	mutex_lock(&data->update_lock);
-	data->temp_alert[attr->index] = TEMP_LIMIT_TO_REG(val);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_ALERT_LIMIT(attr->index),
-				  data->temp_alert[attr->index]);
+	regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index),
+		     TEMP_LIMIT_TO_REG(val));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -248,8 +220,17 @@ static ssize_t temp_emergency_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
+	unsigned int val;
+	int res;
 
-	return sprintf(buf, "%d\n", (data->temp_ot[attr->index] * 1000));
+	mutex_lock(&data->update_lock);
+	res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), &val);
+	mutex_unlock(&data->update_lock);
+
+	if (res < 0)
+		return res;
+
+	return sprintf(buf, "%d\n", (val * 1000));
 }
 
 static ssize_t temp_emergency_store(struct device *dev,
@@ -258,7 +239,6 @@ static ssize_t temp_emergency_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -267,10 +247,7 @@ static ssize_t temp_emergency_store(struct device *dev,
 		return res;
 
 	mutex_lock(&data->update_lock);
-	data->temp_ot[attr->index] = TEMP_LIMIT_TO_REG(val);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_OT_LIMIT(attr->index),
-				  data->temp_ot[attr->index]);
+	regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), TEMP_LIMIT_TO_REG(val));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -290,7 +267,6 @@ static ssize_t pwm_store(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int res;
 
@@ -299,12 +275,9 @@ static ssize_t pwm_store(struct device *dev,
 		return res;
 
 	val = clamp_val(val, 0, 255);
-
-	mutex_lock(&data->update_lock);
 	data->pwm[attr->index] = (u8)(val * 120 / 255);
-	i2c_smbus_write_byte_data(client,
-				  MAX6639_REG_TARGTDUTY(attr->index),
-				  data->pwm[attr->index]);
+	mutex_lock(&data->update_lock);
+	regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), data->pwm[attr->index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -312,26 +285,35 @@ static ssize_t pwm_store(struct device *dev,
 static ssize_t fan_input_show(struct device *dev,
 			      struct device_attribute *dev_attr, char *buf)
 {
-	struct max6639_data *data = max6639_update_device(dev);
+	struct max6639_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
+	unsigned int val;
+	int res;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->rpm_range));
+	res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(attr->index), &val);
+	if (res < 0)
+		return res;
+
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
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return sprintf(buf, "%d\n", !!(data->status & (1 << attr->index)));
+	res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
+
+	return sprintf(buf, "%d\n", !!(val & (1 << attr->index)));
 }
 
 static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
@@ -401,6 +383,11 @@ static int rpm_range_to_reg(int range)
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
@@ -408,49 +395,43 @@ static int max6639_init_client(struct i2c_client *client,
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
 		goto exit;
 
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
 
@@ -458,42 +439,31 @@ static int max6639_init_client(struct i2c_client *client,
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
 
 		/* Max. temp. 80C/90C/100C */
-		data->temp_therm[i] = 80;
-		data->temp_alert[i] = 90;
-		data->temp_ot[i] = 100;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_THERM_LIMIT(i),
-				data->temp_therm[i]);
+		err = regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(i), 80);
 		if (err)
 			goto exit;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_ALERT_LIMIT(i),
-				data->temp_alert[i]);
+		err = regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(i), 90);
 		if (err)
 			goto exit;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
+		err = regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(i), 100);
 		if (err)
 			goto exit;
 
 		/* PWM 120/120 (i.e. 100%) */
-		data->pwm[i] = 120;
-		err = i2c_smbus_write_byte_data(client,
-				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
+		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
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
@@ -524,6 +494,30 @@ static void max6639_regulator_disable(void *data)
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
@@ -535,7 +529,11 @@ static int max6639_probe(struct i2c_client *client)
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
@@ -573,25 +571,24 @@ static int max6639_probe(struct i2c_client *client)
 
 static int max6639_suspend(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	int ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
+	int ret, err;
 
-	if (ret < 0)
-		return ret;
+	err = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &ret);
+
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
@@ -601,12 +598,11 @@ static int max6639_resume(struct device *dev)
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

base-commit: 8b3aa2c488653fa1e127cf6e11499a8cbbaccad0
-- 
2.42.0


