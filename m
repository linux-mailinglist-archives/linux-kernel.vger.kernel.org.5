Return-Path: <linux-kernel+bounces-165794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62478B91B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BDD28319E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39A012D76F;
	Wed,  1 May 2024 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXMa4HhT"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5743AC3;
	Wed,  1 May 2024 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603494; cv=none; b=pFK4dLx5Az4C9yimFuLoqu2iS5SHV+OhRwEpP3cnTIw+RQHi6IHvbatg/hInG2rCUQdjO8naRHevNLgiJ39SnkRqUDDRgPYAgyebCPXsFh+E6a/XsoEAzbtSrjaUFSmG4DwtNIIMRSUZOcfCqyDEatUv2UIoznM8BC4enD2g9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603494; c=relaxed/simple;
	bh=ka/dkbDUHeRwZ1uylgFnlXvQZzDKHnHlTs5kR/GWE6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F2L/w2dTrMo/A0emzJhdmL2f9T6JZ+Tw8tbnNfbe4eW9OELVsUDnlZspLhmGh/VCP6TdTp+qoySbzjnGVlfyzmQYWpXi0yQbyyupkVqfsszJc8Xcr9tPm+jJC8K62ZataiovPIlMq1jJk/SUBauPkYfULQ2i0Gvty1VtEriBRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXMa4HhT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5c7d087e1so62837025ad.0;
        Wed, 01 May 2024 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714603491; x=1715208291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bfUn5USG+8Z0Ccf/OZ2gNBnf1Qf7akcUFjPVmm+lQ/s=;
        b=UXMa4HhTdj7Vk1sm2MhXq4QL6Vtgm44JfAocXIp9M2Hxx3eVaK7vSEEjevJO3/hHDt
         zXvfPUQlK8BswWQXIybIQ0d7qBIiHtKRcB/RQWthGZt4ZyP4eRNjXcZ3T+CXqasEUZuw
         xodxFAxVcZ2TE5dxJTIQJHlXAUIzL5FS6SMG9AkYcdg6bNhrFrKTKtJr0rbzMAheE3Re
         xQp1/1Lp3MJOXsrn5raNNZwHU+d54ORX5wB2hma31Xm5hJROjymSr2bRnBOwv4uVW1nK
         +Hs8cpOpj1e41Uk0vDhM91vPca1MuQuyhwxYT/XxQL0QwOBasCdbDx+rB7aHRkD1Ko0K
         rjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714603491; x=1715208291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfUn5USG+8Z0Ccf/OZ2gNBnf1Qf7akcUFjPVmm+lQ/s=;
        b=PkCIeiPe47DjKHW8V6XS6x+n+nvJaiY220aJ/KOe53q6vnOXfwFzbWxnOE1REdrUT9
         VWAD+xTWGme2ovZ3xLYEwjw76XhS4ABmcyDFif1iStvePbbSee69a3YTFvv7brIANPaB
         dghdtow41ml0lKSTQnU3spssRjYEKUGKWqrkK3KpF8iIvYW0JxrX4BlFTfpfMbO/boUB
         0by+ZW9TsIG4hUa/7t8/6aExBdiD0UVBtueACipIJBaU3kkGSG4JOW6J608zOUFCQ+iQ
         IvENtV3lxbvKBMvgFBSZltiUsQlvHQVw60Ru/sa0BLmpq8qkbhXB04iwNwgzelMtAk+n
         yynQ==
X-Gm-Message-State: AOJu0YxcRFmTNh4QBO4nSP5IKnZz7RZeqgdY+Y+G88HBXNc4xQB0kp/P
	8qK0c1vtQ1mzj7NZ1jUN994hlzTtNdku/Ar/dyM/4Jbb6k599/1hxd6OSg==
X-Google-Smtp-Source: AGHT+IG9ysrGVPpivYkuL7ib6ltoKtGFKyXF4SbcUGMddn8hOObam9lDvvi29LhKTU7u/QUGkp3o0Q==
X-Received: by 2002:a17:902:654e:b0:1eb:5403:b16 with SMTP id d14-20020a170902654e00b001eb54030b16mr297570pln.0.1714603490178;
        Wed, 01 May 2024 15:44:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902704800b001e868e29fabsm24582377plt.251.2024.05.01.15.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 15:44:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Lars Petter Mostad <lars.petter.mostad@appear.net>
Subject: [RTF PATCH] hwmon: (emc1403) Convert to with_info API
Date: Wed,  1 May 2024 15:44:47 -0700
Message-Id: <20240501224447.735869-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert driver to register with the hwmon subsystem using
devm_hwmon_device_register_with_info() instead of
devm_hwmon_device_register_with_groups() to simplify the code
and to reduce its size. As side effect, this also fixes a couple
of overflow problems when writing limit and hysteresis registers.

Cc: Lars Petter Mostad <lars.petter.mostad@appear.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
RFT: Module tested only.

 drivers/hwmon/emc1403.c | 576 ++++++++++++++++++++--------------------
 1 file changed, 281 insertions(+), 295 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index d370efd6f986..308811aa8417 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -27,294 +27,47 @@
 enum emc1403_chip { emc1402, emc1403, emc1404 };
 
 struct thermal_data {
+	enum emc1403_chip chip;
 	struct regmap *regmap;
 	struct mutex mutex;
-	const struct attribute_group *groups[4];
 };
 
-static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static ssize_t power_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
 	struct thermal_data *data = dev_get_drvdata(dev);
 	unsigned int val;
 	int retval;
 
-	retval = regmap_read(data->regmap, sda->index, &val);
+	retval = regmap_read(data->regmap, 0x03, &val);
 	if (retval < 0)
 		return retval;
-	return sprintf(buf, "%d000\n", val);
+	return sprintf(buf, "%d\n", !!(val & BIT(6)));
 }
 
-static ssize_t bit_show(struct device *dev, struct device_attribute *attr,
-			char *buf)
+static ssize_t power_state_store(struct device *dev, struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
-	struct sensor_device_attribute_2 *sda = to_sensor_dev_attr_2(attr);
-	struct thermal_data *data = dev_get_drvdata(dev);
-	unsigned int val;
-	int retval;
-
-	retval = regmap_read(data->regmap, sda->nr, &val);
-	if (retval < 0)
-		return retval;
-	return sprintf(buf, "%d\n", !!(val & sda->index));
-}
-
-static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
-{
-	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
 	struct thermal_data *data = dev_get_drvdata(dev);
 	unsigned long val;
 	int retval;
 
 	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
-	retval = regmap_write(data->regmap, sda->index,
-			      DIV_ROUND_CLOSEST(val, 1000));
+
+	retval = regmap_update_bits(data->regmap, 0x03, BIT(6),
+				    val ? BIT(6) : 0);
 	if (retval < 0)
 		return retval;
 	return count;
 }
 
-static ssize_t bit_store(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count)
-{
-	struct sensor_device_attribute_2 *sda = to_sensor_dev_attr_2(attr);
-	struct thermal_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int retval;
-
-	if (kstrtoul(buf, 10, &val))
-		return -EINVAL;
-
-	retval = regmap_update_bits(data->regmap, sda->nr, sda->index,
-				    val ? sda->index : 0);
-	if (retval < 0)
-		return retval;
-	return count;
-}
-
-static ssize_t show_hyst_common(struct device *dev,
-				struct device_attribute *attr, char *buf,
-				bool is_min)
-{
-	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
-	struct thermal_data *data = dev_get_drvdata(dev);
-	struct regmap *regmap = data->regmap;
-	unsigned int limit;
-	unsigned int hyst;
-	int retval;
-
-	retval = regmap_read(regmap, sda->index, &limit);
-	if (retval < 0)
-		return retval;
-
-	retval = regmap_read(regmap, 0x21, &hyst);
-	if (retval < 0)
-		return retval;
-
-	return sprintf(buf, "%d000\n", is_min ? limit + hyst : limit - hyst);
-}
-
-static ssize_t hyst_show(struct device *dev, struct device_attribute *attr,
-			 char *buf)
-{
-	return show_hyst_common(dev, attr, buf, false);
-}
-
-static ssize_t min_hyst_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
-{
-	return show_hyst_common(dev, attr, buf, true);
-}
-
-static ssize_t hyst_store(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
-{
-	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
-	struct thermal_data *data = dev_get_drvdata(dev);
-	struct regmap *regmap = data->regmap;
-	unsigned int limit;
-	int retval;
-	int hyst;
-	unsigned long val;
-
-	if (kstrtoul(buf, 10, &val))
-		return -EINVAL;
-
-	mutex_lock(&data->mutex);
-	retval = regmap_read(regmap, sda->index, &limit);
-	if (retval < 0)
-		goto fail;
-
-	hyst = limit * 1000 - val;
-	hyst = clamp_val(DIV_ROUND_CLOSEST(hyst, 1000), 0, 255);
-	retval = regmap_write(regmap, 0x21, hyst);
-	if (retval == 0)
-		retval = count;
-fail:
-	mutex_unlock(&data->mutex);
-	return retval;
-}
-
-/*
- *	Sensors. We pass the actual i2c register to the methods.
- */
-
-static SENSOR_DEVICE_ATTR_RW(temp1_min, temp, 0x06);
-static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, 0x05);
-static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp, 0x20);
-static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0x00);
-static SENSOR_DEVICE_ATTR_2_RO(temp1_min_alarm, bit, 0x36, 0x01);
-static SENSOR_DEVICE_ATTR_2_RO(temp1_max_alarm, bit, 0x35, 0x01);
-static SENSOR_DEVICE_ATTR_2_RO(temp1_crit_alarm, bit, 0x37, 0x01);
-static SENSOR_DEVICE_ATTR_RO(temp1_min_hyst, min_hyst, 0x06);
-static SENSOR_DEVICE_ATTR_RO(temp1_max_hyst, hyst, 0x05);
-static SENSOR_DEVICE_ATTR_RW(temp1_crit_hyst, hyst, 0x20);
-
-static SENSOR_DEVICE_ATTR_RW(temp2_min, temp, 0x08);
-static SENSOR_DEVICE_ATTR_RW(temp2_max, temp, 0x07);
-static SENSOR_DEVICE_ATTR_RW(temp2_crit, temp, 0x19);
-static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 0x01);
-static SENSOR_DEVICE_ATTR_2_RO(temp2_fault, bit, 0x1b, 0x02);
-static SENSOR_DEVICE_ATTR_2_RO(temp2_min_alarm, bit, 0x36, 0x02);
-static SENSOR_DEVICE_ATTR_2_RO(temp2_max_alarm, bit, 0x35, 0x02);
-static SENSOR_DEVICE_ATTR_2_RO(temp2_crit_alarm, bit, 0x37, 0x02);
-static SENSOR_DEVICE_ATTR_RO(temp2_min_hyst, min_hyst, 0x08);
-static SENSOR_DEVICE_ATTR_RO(temp2_max_hyst, hyst, 0x07);
-static SENSOR_DEVICE_ATTR_RO(temp2_crit_hyst, hyst, 0x19);
-
-static SENSOR_DEVICE_ATTR_RW(temp3_min, temp, 0x16);
-static SENSOR_DEVICE_ATTR_RW(temp3_max, temp, 0x15);
-static SENSOR_DEVICE_ATTR_RW(temp3_crit, temp, 0x1A);
-static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 0x23);
-static SENSOR_DEVICE_ATTR_2_RO(temp3_fault, bit, 0x1b, 0x04);
-static SENSOR_DEVICE_ATTR_2_RO(temp3_min_alarm, bit, 0x36, 0x04);
-static SENSOR_DEVICE_ATTR_2_RO(temp3_max_alarm, bit, 0x35, 0x04);
-static SENSOR_DEVICE_ATTR_2_RO(temp3_crit_alarm, bit, 0x37, 0x04);
-static SENSOR_DEVICE_ATTR_RO(temp3_min_hyst, min_hyst, 0x16);
-static SENSOR_DEVICE_ATTR_RO(temp3_max_hyst, hyst, 0x15);
-static SENSOR_DEVICE_ATTR_RO(temp3_crit_hyst, hyst, 0x1A);
-
-static SENSOR_DEVICE_ATTR_RW(temp4_min, temp, 0x2D);
-static SENSOR_DEVICE_ATTR_RW(temp4_max, temp, 0x2C);
-static SENSOR_DEVICE_ATTR_RW(temp4_crit, temp, 0x30);
-static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 0x2A);
-static SENSOR_DEVICE_ATTR_2_RO(temp4_fault, bit, 0x1b, 0x08);
-static SENSOR_DEVICE_ATTR_2_RO(temp4_min_alarm, bit, 0x36, 0x08);
-static SENSOR_DEVICE_ATTR_2_RO(temp4_max_alarm, bit, 0x35, 0x08);
-static SENSOR_DEVICE_ATTR_2_RO(temp4_crit_alarm, bit, 0x37, 0x08);
-static SENSOR_DEVICE_ATTR_RO(temp4_min_hyst, min_hyst, 0x2D);
-static SENSOR_DEVICE_ATTR_RO(temp4_max_hyst, hyst, 0x2C);
-static SENSOR_DEVICE_ATTR_RO(temp4_crit_hyst, hyst, 0x30);
-
-static SENSOR_DEVICE_ATTR_2_RW(power_state, bit, 0x03, 0x40);
-
-static struct attribute *emc1402_attrs[] = {
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit.dev_attr.attr,
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
-
-	&sensor_dev_attr_temp2_min.dev_attr.attr,
-	&sensor_dev_attr_temp2_max.dev_attr.attr,
-	&sensor_dev_attr_temp2_crit.dev_attr.attr,
-	&sensor_dev_attr_temp2_input.dev_attr.attr,
-	&sensor_dev_attr_temp2_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
-
-	&sensor_dev_attr_power_state.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group emc1402_group = {
-		.attrs = emc1402_attrs,
-};
+static DEVICE_ATTR_RW(power_state);
 
 static struct attribute *emc1403_attrs[] = {
-	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
-
-	&sensor_dev_attr_temp2_fault.dev_attr.attr,
-	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
-
-	&sensor_dev_attr_temp3_min.dev_attr.attr,
-	&sensor_dev_attr_temp3_max.dev_attr.attr,
-	&sensor_dev_attr_temp3_crit.dev_attr.attr,
-	&sensor_dev_attr_temp3_input.dev_attr.attr,
-	&sensor_dev_attr_temp3_fault.dev_attr.attr,
-	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp3_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp3_crit_hyst.dev_attr.attr,
+	&dev_attr_power_state.attr,
 	NULL
 };
-
-static const struct attribute_group emc1403_group = {
-	.attrs = emc1403_attrs,
-};
-
-static struct attribute *emc1404_attrs[] = {
-	&sensor_dev_attr_temp4_min.dev_attr.attr,
-	&sensor_dev_attr_temp4_max.dev_attr.attr,
-	&sensor_dev_attr_temp4_crit.dev_attr.attr,
-	&sensor_dev_attr_temp4_input.dev_attr.attr,
-	&sensor_dev_attr_temp4_fault.dev_attr.attr,
-	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp4_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp4_crit_hyst.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group emc1404_group = {
-	.attrs = emc1404_attrs,
-};
-
-/*
- * EMC14x2 uses a different register and different bits to report alarm and
- * fault status. For simplicity, provide a separate attribute group for this
- * chip series.
- * Since we can not re-use the same attribute names, create a separate attribute
- * array.
- */
-static struct sensor_device_attribute_2 emc1402_alarms[] = {
-	SENSOR_ATTR_2_RO(temp1_min_alarm, bit, 0x02, 0x20),
-	SENSOR_ATTR_2_RO(temp1_max_alarm, bit, 0x02, 0x40),
-	SENSOR_ATTR_2_RO(temp1_crit_alarm, bit, 0x02, 0x01),
-
-	SENSOR_ATTR_2_RO(temp2_fault, bit, 0x02, 0x04),
-	SENSOR_ATTR_2_RO(temp2_min_alarm, bit, 0x02, 0x08),
-	SENSOR_ATTR_2_RO(temp2_max_alarm, bit, 0x02, 0x10),
-	SENSOR_ATTR_2_RO(temp2_crit_alarm, bit, 0x02, 0x02),
-};
-
-static struct attribute *emc1402_alarm_attrs[] = {
-	&emc1402_alarms[0].dev_attr.attr,
-	&emc1402_alarms[1].dev_attr.attr,
-	&emc1402_alarms[2].dev_attr.attr,
-	&emc1402_alarms[3].dev_attr.attr,
-	&emc1402_alarms[4].dev_attr.attr,
-	&emc1402_alarms[5].dev_attr.attr,
-	&emc1402_alarms[6].dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group emc1402_alarm_group = {
-	.attrs = emc1402_alarm_attrs,
-};
+ATTRIBUTE_GROUPS(emc1403);
 
 static int emc1403_detect(struct i2c_client *client,
 			struct i2c_board_info *info)
@@ -389,51 +142,255 @@ static const struct regmap_config emc1403_regmap_config = {
 	.volatile_reg = emc1403_regmap_is_volatile,
 };
 
-static const struct i2c_device_id emc1403_idtable[];
+enum emc1403_reg_map {temp_min, temp_max, temp_crit, temp_input};
 
-static int emc1403_probe(struct i2c_client *client)
+static u8 ema1403_temp_map[] = {
+	[hwmon_temp_min] = temp_min,
+	[hwmon_temp_max] = temp_max,
+	[hwmon_temp_crit] = temp_crit,
+	[hwmon_temp_input] = temp_input,
+};
+
+static u8 emc1403_temp_regs[][4] = {
+	[0] = {
+		[temp_min] = 0x06,
+		[temp_max] = 0x05,
+		[temp_crit] = 0x20,
+		[temp_input] = 0x00,
+	},
+	[1] = {
+		[temp_min] = 0x08,
+		[temp_max] = 0x07,
+		[temp_crit] = 0x19,
+		[temp_input] = 0x01,
+	},
+	[2] = {
+		[temp_min] = 0x16,
+		[temp_max] = 0x15,
+		[temp_crit] = 0x1a,
+		[temp_input] = 0x23,
+	},
+	[3] = {
+		[temp_min] = 0x2d,
+		[temp_max] = 0x2c,
+		[temp_crit] = 0x30,
+		[temp_input] = 0x2a,
+	},
+};
+
+static int emc1403_get_hyst(struct thermal_data *data, int temp_reg, bool min,
+			    long *val)
 {
-	struct thermal_data *data;
-	struct device *hwmon_dev;
-	const struct i2c_device_id *id = i2c_match_id(emc1403_idtable, client);
+	int limit, hyst;
+	int ret;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct thermal_data),
-			    GFP_KERNEL);
-	if (data == NULL)
-		return -ENOMEM;
+	mutex_lock(&data->mutex);
+	ret = regmap_read(data->regmap, temp_reg, &limit);
+	if (ret < 0)
+		goto unlock;
+	ret = regmap_read(data->regmap, 0x21, &hyst);
+	if (ret < 0)
+		goto unlock;
+	if (min)
+		*val = (limit + hyst) * 1000;
+	else
+		*val = (limit - hyst) * 1000;
+unlock:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
 
-	data->regmap = devm_regmap_init_i2c(client, &emc1403_regmap_config);
-	if (IS_ERR(data->regmap))
-		return PTR_ERR(data->regmap);
+static int emc1403_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct thermal_data *data = dev_get_drvdata(dev);
+	unsigned int regval;
+	int ret, map;
 
-	mutex_init(&data->mutex);
-
-	switch (id->driver_data) {
-	case emc1404:
-		data->groups[2] = &emc1404_group;
-		fallthrough;
-	case emc1403:
-		data->groups[1] = &emc1403_group;
-		fallthrough;
-	case emc1402:
-		data->groups[0] = &emc1402_group;
+	switch (attr) {
+	case hwmon_temp_min:
+	case hwmon_temp_max:
+	case hwmon_temp_crit:
+	case hwmon_temp_input:
+		map = ema1403_temp_map[attr];
+		ret = regmap_read(data->regmap, emc1403_temp_regs[channel][map], &regval);
+		if (ret < 0)
+			return ret;
+		*val = regval * 1000;
+		break;
+	case hwmon_temp_min_hyst:
+		ret = emc1403_get_hyst(data, emc1403_temp_regs[channel][temp_min], true, val);
+		if (ret < 0)
+			return ret;
+		break;
+	case hwmon_temp_max_hyst:
+		ret = emc1403_get_hyst(data, emc1403_temp_regs[channel][temp_max], false, val);
+		if (ret < 0)
+			return ret;
+		break;
+	case hwmon_temp_crit_hyst:
+		ret = emc1403_get_hyst(data, emc1403_temp_regs[channel][temp_crit], false, val);
+		if (ret < 0)
+			return ret;
+		break;
+	case hwmon_temp_min_alarm:
+		if (data->chip == emc1402) {
+			ret = regmap_read(data->regmap, 0x02, &regval);
+			if (ret < 0)
+				return ret;
+			*val = !!(regval & BIT(5 - 2 * channel));
+		} else {
+			ret = regmap_read(data->regmap, 0x36, &regval);
+			if (ret < 0)
+				return ret;
+			*val = !!(regval & BIT(channel));
+		}
+		break;
+	case hwmon_temp_max_alarm:
+		if (data->chip == emc1402) {
+			ret = regmap_read(data->regmap, 0x02, &regval);
+			if (ret < 0)
+				return ret;
+			*val = !!(regval & BIT(6 - 2 * channel));
+		} else {
+			ret = regmap_read(data->regmap, 0x35, &regval);
+			if (ret < 0)
+				return ret;
+			*val = !!(regval & BIT(channel));
+		}
+		break;
+	case hwmon_temp_crit_alarm:
+		if (data->chip == emc1402) {
+			ret = regmap_read(data->regmap, 0x02, &regval);
+			if (ret < 0)
+				return ret;
+			*val = !!(regval & BIT(channel));
+		} else {
+			ret = regmap_read(data->regmap, 0x37, &regval);
+			if (ret < 0)
+				return ret;
+			*val = !!(regval & BIT(channel));
+		}
+		break;
+	case hwmon_temp_fault:
+		ret = regmap_read(data->regmap, 0x1b, &regval);
+		if (ret < 0)
+			return ret;
+		*val = !!(regval & BIT(channel));
+		break;
+	default:
+		return -EOPNOTSUPP;
 	}
-
-	if (id->driver_data == emc1402)
-		data->groups[1] = &emc1402_alarm_group;
-
-	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
-							   client->name, data,
-							   data->groups);
-	if (IS_ERR(hwmon_dev))
-		return PTR_ERR(hwmon_dev);
-
-	dev_info(&client->dev, "%s Thermal chip found\n", id->name);
 	return 0;
 }
 
-static const unsigned short emc1403_address_list[] = {
-	0x18, 0x1c, 0x29, 0x3c, 0x4c, 0x4d, 0x5c, I2C_CLIENT_END
+static int emc1403_set_hyst(struct thermal_data *data, long val)
+{
+	unsigned int limit;
+	int hyst, ret;
+
+	val = clamp_val(val, 0, 255000);
+
+	mutex_lock(&data->mutex);
+	ret = regmap_read(data->regmap, 0x20, &limit);
+	if (ret < 0)
+		goto unlock;
+
+	hyst = limit * 1000 - val;
+	hyst = clamp_val(DIV_ROUND_CLOSEST(hyst, 1000), 0, 255);
+	ret = regmap_write(data->regmap, 0x21, hyst);
+unlock:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int emc1403_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	struct thermal_data *data = dev_get_drvdata(dev);
+	unsigned int regval;
+	int map;
+
+	switch (attr) {
+	case hwmon_temp_min:
+	case hwmon_temp_max:
+	case hwmon_temp_crit:
+		map = ema1403_temp_map[attr];
+		regval = DIV_ROUND_CLOSEST(clamp_val(val, 0, 255000), 1000);
+		return regmap_write(data->regmap, emc1403_temp_regs[channel][map], regval);
+	case hwmon_temp_crit_hyst:
+		return emc1403_set_hyst(data, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t emc1403_is_visible(const void *_data, enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	const struct thermal_data *data = _data;
+
+	if (type != hwmon_temp)
+		return 0;
+
+	if (data->chip == emc1402 && channel > 1)
+		return 0;
+	if (data->chip == emc1403 && channel > 2)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_min_alarm:
+	case hwmon_temp_max_alarm:
+	case hwmon_temp_crit_alarm:
+	case hwmon_temp_fault:
+	case hwmon_temp_min_hyst:
+	case hwmon_temp_max_hyst:
+		return 0444;
+	case hwmon_temp_min:
+	case hwmon_temp_max:
+	case hwmon_temp_crit:
+		return 0644;
+	case hwmon_temp_crit_hyst:
+		if (channel == 0)
+			return 0644;
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_channel_info * const emc1403_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_HYST | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_HYST | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_HYST | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_HYST | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM | HWMON_T_FAULT
+			   ),
+	NULL
+};
+
+static const struct hwmon_ops emc1403_hwmon_ops = {
+	.is_visible = emc1403_is_visible,
+	.read = emc1403_read,
+	.write = emc1403_write,
+};
+
+static const struct hwmon_chip_info emc1403_chip_info = {
+	.ops = &emc1403_hwmon_ops,
+	.info = emc1403_info,
 };
 
 /* Last digit of chip name indicates number of channels */
@@ -452,6 +409,35 @@ static const struct i2c_device_id emc1403_idtable[] = {
 };
 MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
 
+static int emc1403_probe(struct i2c_client *client)
+{
+	struct thermal_data *data;
+	struct device *hwmon_dev;
+	const struct i2c_device_id *id = i2c_match_id(emc1403_idtable, client);
+
+	data = devm_kzalloc(&client->dev, sizeof(struct thermal_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->chip = id->driver_data;
+	data->regmap = devm_regmap_init_i2c(client, &emc1403_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	mutex_init(&data->mutex);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev,
+							 client->name, data,
+							 &emc1403_chip_info,
+							 emc1403_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const unsigned short emc1403_address_list[] = {
+	0x18, 0x1c, 0x29, 0x3c, 0x4c, 0x4d, 0x5c, I2C_CLIENT_END
+};
+
 static struct i2c_driver sensor_emc1403 = {
 	.class = I2C_CLASS_HWMON,
 	.driver = {
-- 
2.39.2


