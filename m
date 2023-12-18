Return-Path: <linux-kernel+bounces-3000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A667D8165CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA281C21482
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DEC63B1;
	Mon, 18 Dec 2023 04:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDv/VUDi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656DF5671;
	Mon, 18 Dec 2023 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4260ba19a57so30292251cf.3;
        Sun, 17 Dec 2023 20:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702875223; x=1703480023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSwu6xy1q8rHEwXEuWcu18fqodsLh+KDPx4QWvbItl8=;
        b=kDv/VUDi2DwaohdLEjPZEsLK3xIgO+iKuZ8dpZ60hPPxqym4iXwELcUtTq9P5mG56s
         SGRJGSiO1uJ4ZneXuvY2bWkyDovBbvVAYuTyOg42JC+fnIJsEG0wS9d4bDMVY3KFDT+x
         24/4WOMrqgETh8nxDZVqX8Nv3uv7F7pGaq1ERtuYLDAvHcUN+0W6ffasXd+CaTWG8rSR
         j+Lc/OVknz7wLc9mKa98ooZoYeiYS8WPGU6LTNyZIjfX2gPSmzN/tMiEUjPREedgl7hc
         l+MiipC8uRIcoeLwV3e8TUgJaFkMrLNu2/KJMd/OopIdnI43L8NDOKBa3gKejUS23+SL
         X5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702875223; x=1703480023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSwu6xy1q8rHEwXEuWcu18fqodsLh+KDPx4QWvbItl8=;
        b=SlcfRLcOV7pIMvxUNn9+SNV2xq9pXoFz4hWKaj+dtxn5T6f6cvaDeDDLbYmg0BVr9P
         nMpDZ5habc+AOs7RQ17HxVQR/0CRVKegPTqIJ4E1HYVs/63T9u6WdEEC8AEGLyyRV1es
         e/4AuELa21SZ6Hq5zxz1Br2GHTdNd8yATDYUS8Mxl1FO2lqRYWrYPvm12Sf3ilS8RRRV
         ou8AGSCUCQCTbzK9un1c8nf9Ri+8xkc12Oc9uECJFJcI+sSoxOR/zPPTmAoWd4Al8+4g
         6ICngsze9KP8XTorgUMlsYnSE2FSoOnvv5deSz7vyb7YX7buhjgeAtes0k4TWlwnMG1l
         9jSg==
X-Gm-Message-State: AOJu0YxD7141qYdImghTao+O+3+l+/MWRFeAfHRVywaiZSTl5VkkGVGM
	k5FaWG/2ds6IYlzJUrgQN5g=
X-Google-Smtp-Source: AGHT+IFgvRF7jhnQjmZXNo/oBGJeAPea00yqhXVceGALYf0iaiwD1Q1/x1VmfmiTTuzpszSy50ugdQ==
X-Received: by 2002:ac8:5fce:0:b0:425:4043:5f26 with SMTP id k14-20020ac85fce000000b0042540435f26mr22621750qta.100.1702875223109;
        Sun, 17 Dec 2023 20:53:43 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id fv5-20020a05622a4a0500b004275e9cdf15sm716571qtb.11.2023.12.17.20.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 20:53:42 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Abdel Alkuor <alkuor@gmail.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (lm75) Add AMS AS6200 temperature sensor
Date: Sun, 17 Dec 2023 23:52:28 -0500
Message-Id: <a71ac5106e022b526bef9fc375bd5d3f547eb19d.1702874115.git.alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>
References: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

as6200 is a temperature sensor with 0.0625°C resolution and a
range between -40°C to 125°C.

By default, the driver configures as6200 as following:
- Converstion rate: 8 Hz
- Conversion mode: continuous
- Consecutive fault counts: 4 samples
- Alert state: high polarity
- Alert mode: comparator mode

Interrupt is supported for the alert pin.

Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
Changes in v2:
  - Incorporate as6200 into lm75 driver

 Documentation/hwmon/lm75.rst |  10 +++
 drivers/hwmon/lm75.c         | 132 +++++++++++++++++++++++++++++------
 2 files changed, 122 insertions(+), 20 deletions(-)

diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index 8d0ab4ad5fb5..6adab608dd05 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -133,6 +133,16 @@ Supported chips:
 
                https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
 
+  * AMS OSRAM AS6200
+
+    Prefix: 'as6200'
+
+    Addresses scanned: none
+
+    Datasheet: Publicly available at the AMS website
+
+               https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
+
 Author: Frodo Looijaard <frodol@dds.nl>
 
 Description
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 5b2ea05c951e..2d153f6729e0 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
@@ -25,6 +26,7 @@
 
 enum lm75_type {		/* keep sorted in alphabetical order */
 	adt75,
+	as6200,
 	at30ts74,
 	ds1775,
 	ds75,
@@ -55,6 +57,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 
 /**
  * struct lm75_params - lm75 configuration parameters.
+ * @config_reg_16bits	Configure register size is 2 bytes.
  * @set_mask:		Bits to set in configuration register when configuring
  *			the chip.
  * @clr_mask:		Bits to clear in configuration register when configuring
@@ -75,17 +78,20 @@ enum lm75_type {		/* keep sorted in alphabetical order */
  * @sample_times:	All the possible sample times to be set. Mandatory if
  *			num_sample_times is larger than 1. If set, number of
  *			entries must match num_sample_times.
+ * @alarm		Alarm is supported.
  */
 
 struct lm75_params {
-	u8			set_mask;
-	u8			clr_mask;
+	bool			config_reg_16bits;
+	u16			set_mask;
+	u16			clr_mask;
 	u8			default_resolution;
 	u8			resolution_limits;
 	const u8		*resolutions;
 	unsigned int		default_sample_time;
 	u8			num_sample_times;
 	const unsigned int	*sample_times;
+	bool			alarm;
 };
 
 /* Addresses scanned */
@@ -104,8 +110,8 @@ struct lm75_data {
 	struct i2c_client		*client;
 	struct regmap			*regmap;
 	struct regulator		*vs;
-	u8				orig_conf;
-	u8				current_conf;
+	u16				orig_conf;
+	u16				current_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
 	unsigned int			sample_time;	/* In ms */
 	enum lm75_type			kind;
@@ -128,6 +134,15 @@ static const struct lm75_params device_params[] = {
 		.default_resolution = 12,
 		.default_sample_time = MSEC_PER_SEC / 10,
 	},
+	[as6200] = {
+		.config_reg_16bits = true,
+		.set_mask = 0x94C0,	/* 8 sample/s, 4 CF, positive polarity */
+		.default_resolution = 12,
+		.default_sample_time = 125,
+		.num_sample_times = 4,
+		.sample_times = (unsigned int []){ 125, 250, 1000, 4000 },
+		.alarm = true,
+	},
 	[at30ts74] = {
 		.set_mask = 3 << 5,	/* 12-bit mode*/
 		.default_resolution = 12,
@@ -317,20 +332,23 @@ static inline long lm75_reg_to_mc(s16 temp, u8 resolution)
 	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
 }
 
-static int lm75_write_config(struct lm75_data *data, u8 set_mask,
-			     u8 clr_mask)
+static int lm75_write_config(struct lm75_data *data, u16 set_mask,
+			     u16 clr_mask)
 {
-	u8 value;
+	unsigned int value;
 
-	clr_mask |= LM75_SHUTDOWN;
+	clr_mask |= LM75_SHUTDOWN << (8 * data->params->config_reg_16bits);
 	value = data->current_conf & ~clr_mask;
 	value |= set_mask;
 
 	if (data->current_conf != value) {
 		s32 err;
-
-		err = i2c_smbus_write_byte_data(data->client, LM75_REG_CONF,
-						value);
+		if (data->params->config_reg_16bits)
+			err = regmap_write(data->regmap, LM75_REG_CONF, value);
+		else
+			err = i2c_smbus_write_byte_data(data->client,
+							LM75_REG_CONF,
+							value);
 		if (err)
 			return err;
 		data->current_conf = value;
@@ -338,6 +356,33 @@ static int lm75_write_config(struct lm75_data *data, u8 set_mask,
 	return 0;
 }
 
+static int lm75_read_config(struct lm75_data *data, u16 *config)
+{
+	int ret;
+	unsigned int status;
+
+	if (data->params->config_reg_16bits) {
+		ret = regmap_read(data->regmap, LM75_REG_CONF, &status);
+	} else {
+		ret = i2c_smbus_read_byte_data(data->client, LM75_REG_CONF);
+		status = ret;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	*config = status;
+	return 0;
+}
+
+static irqreturn_t lm75_alarm_handler(int irq, void *private)
+{
+	struct device *hwmon_dev = private;
+
+	hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_alarm, 0);
+	return IRQ_HANDLED;
+}
+
 static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 		     u32 attr, int channel, long *val)
 {
@@ -366,6 +411,9 @@ static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_temp_max_hyst:
 			reg = LM75_REG_HYST;
 			break;
+		case hwmon_temp_alarm:
+			reg = LM75_REG_CONF;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -373,7 +421,17 @@ static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 		if (err < 0)
 			return err;
 
-		*val = lm75_reg_to_mc(regval, data->resolution);
+		if (attr == hwmon_temp_alarm) {
+			switch (data->kind) {
+			case as6200:
+				*val = (regval >> 5) & 0x1;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else {
+			*val = lm75_reg_to_mc(regval, data->resolution);
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -436,6 +494,7 @@ static int lm75_update_interval(struct device *dev, long val)
 			data->resolution = data->params->resolutions[index];
 		break;
 	case tmp112:
+	case as6200:
 		err = regmap_read(data->regmap, LM75_REG_CONF, &reg);
 		if (err < 0)
 			return err;
@@ -503,6 +562,9 @@ static umode_t lm75_is_visible(const void *data, enum hwmon_sensor_types type,
 		case hwmon_temp_max:
 		case hwmon_temp_max_hyst:
 			return 0644;
+		case hwmon_temp_alarm:
+			if (config_data->params->alarm)
+				return 0444;
 		}
 		break;
 	default:
@@ -515,7 +577,8 @@ static const struct hwmon_channel_info * const lm75_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST),
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_ALARM),
 	NULL
 };
 
@@ -574,7 +637,7 @@ static int lm75_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct lm75_data *data;
-	int status, err;
+	int err;
 	enum lm75_type kind;
 
 	if (client->dev.of_node)
@@ -623,13 +686,13 @@ static int lm75_probe(struct i2c_client *client)
 		return err;
 
 	/* Cache original configuration */
-	status = i2c_smbus_read_byte_data(client, LM75_REG_CONF);
-	if (status < 0) {
-		dev_dbg(dev, "Can't read config? %d\n", status);
-		return status;
+	err = lm75_read_config(data, &data->current_conf);
+	if (err) {
+		dev_dbg(dev, "Can't read config? %d\n", err);
+		return err;
 	}
-	data->orig_conf = status;
-	data->current_conf = status;
+
+	data->orig_conf = data->current_conf;
 
 	err = lm75_write_config(data, data->params->set_mask,
 				data->params->clr_mask);
@@ -646,6 +709,30 @@ static int lm75_probe(struct i2c_client *client)
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
 
+	if (client->irq) {
+		if (data->params->alarm) {
+			err = devm_request_threaded_irq(dev,
+							client->irq,
+							NULL,
+							&lm75_alarm_handler,
+							IRQF_ONESHOT,
+							client->name,
+							hwmon_dev);
+			if (err)
+				return err;
+		} else {
+			/*
+			 * Currently, alarm is only supported for chips with
+			 * alarm bit.
+			 * In the future, if alarm is needed for chips with
+			 * no alarm bit, current temp needs to be compared
+			 * against the max and max hyst values to set/clear
+			 * the alarm state.
+			 */
+			dev_warn(dev, "alarm interrupt is not supported\n");
+		}
+	}
+
 	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
 
 	return 0;
@@ -654,6 +741,7 @@ static int lm75_probe(struct i2c_client *client)
 static const struct i2c_device_id lm75_ids[] = {
 	{ "adt75", adt75, },
 	{ "at30ts74", at30ts74, },
+	{ "as6200", as6200, },
 	{ "ds1775", ds1775, },
 	{ "ds75", ds75, },
 	{ "ds7505", ds7505, },
@@ -689,6 +777,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
 		.compatible = "adi,adt75",
 		.data = (void *)adt75
 	},
+	{
+		.compatible = "ams,as6200",
+		.data = (void *)as6200
+	},
 	{
 		.compatible = "atmel,at30ts74",
 		.data = (void *)at30ts74
-- 
2.34.1


