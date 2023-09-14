Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40CF7A113C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjINWqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINWqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:46:07 -0400
X-Greylist: delayed 364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 15:46:02 PDT
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88F326B7;
        Thu, 14 Sep 2023 15:46:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 2E848828548A;
        Thu, 14 Sep 2023 17:39:57 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NSBzXeeNdZnd; Thu, 14 Sep 2023 17:39:56 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id DDAF582855BB;
        Thu, 14 Sep 2023 17:39:55 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com DDAF582855BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1694731195; bh=4wWmRk9vKnyCrbEIxInvXUMcBh4lG6WiQHGocKH4Sis=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=mumuRQ+Z+P+pn/JRSjSlfVfVffAHGssB17QTsDkNPQI8bQ3c4xgpRgHddmPagJ1Gx
         qbK3DHZ5M0wMaQuqGZVzgx8IyTZLMvhh38K4B5z0VsJomqUEXMrupDVpI9QaIwEWPq
         /sT2Mg5Bz6Ib3mnzqp7OVJG3QHqfGFhGYedTuP/g=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CY7GKcQXnydf; Thu, 14 Sep 2023 17:39:55 -0500 (CDT)
Received: from raptor-ewks-026.rptsys.com (5.edge.rptsys.com [23.155.224.38])
        by mail.rptsys.com (Postfix) with ESMTPSA id 65CB1828548A;
        Thu, 14 Sep 2023 17:39:55 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: [PATCH] hwmon: (adt7475) Add support for Imon readout on ADT7490
Date:   Thu, 14 Sep 2023 17:39:47 -0500
Message-Id: <20230914223947.829025-1-tpearson@raptorengineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ADT7490's Imon voltage readout. It is handled
largely the same way as the existing Vtt readout.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
Co-developed-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
---
 Documentation/hwmon/adt7475.rst |  3 +-
 drivers/hwmon/adt7475.c         | 68 ++++++++++++++++++++++++++++++---
 2 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/adt7475.rst b/Documentation/hwmon/adt7475.rst
index ef3ea1ea9bc1..f90f769d82d6 100644
--- a/Documentation/hwmon/adt7475.rst
+++ b/Documentation/hwmon/adt7475.rst
@@ -90,7 +90,7 @@ ADT7476:
 
 ADT7490:
   * 6 voltage inputs
-  * 1 Imon input (not implemented)
+  * 1 Imon input
   * PECI support (not implemented)
   * 2 GPIO pins (not implemented)
   * system acoustics optimizations (not implemented)
@@ -107,6 +107,7 @@ in2  VCC    (4)  VCC    (4)  VCC  (4)  VCC  (3)
 in3  5VIN   (20) 5VIN   (20)
 in4  12VIN  (21) 12VIN  (21)
 in5  VTT    (8)
+in6  Imon   (19)
 ==== =========== =========== ========= ==========
 
 Special Features
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 03acadc3a6cb..4224ffb30483 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -43,6 +43,7 @@
 /* 7475 Common Registers */
 
 #define REG_DEVREV2		0x12	/* ADT7490 only */
+#define REG_IMON		0x1D	/* ADT7490 only */
 
 #define REG_VTT			0x1E	/* ADT7490 only */
 #define REG_EXTEND3		0x1F	/* ADT7490 only */
@@ -103,6 +104,9 @@
 #define REG_VTT_MIN		0x84	/* ADT7490 only */
 #define REG_VTT_MAX		0x86	/* ADT7490 only */
 
+#define REG_IMON_MIN		0x85	/* ADT7490 only */
+#define REG_IMON_MAX		0x87	/* ADT7490 only */
+
 #define VID_VIDSEL		0x80	/* ADT7476 only */
 
 #define CONFIG2_ATTN		0x20
@@ -123,7 +127,7 @@
 
 /* ADT7475 Settings */
 
-#define ADT7475_VOLTAGE_COUNT	5	/* Not counting Vtt */
+#define ADT7475_VOLTAGE_COUNT	5	/* Not counting Vtt or Imon */
 #define ADT7475_TEMP_COUNT	3
 #define ADT7475_TACH_COUNT	4
 #define ADT7475_PWM_COUNT	3
@@ -204,7 +208,7 @@ struct adt7475_data {
 	u8 has_fan4:1;
 	u8 has_vid:1;
 	u32 alarms;
-	u16 voltage[3][6];
+	u16 voltage[3][7];
 	u16 temp[7][3];
 	u16 tach[2][4];
 	u8 pwm[4][3];
@@ -215,7 +219,7 @@ struct adt7475_data {
 
 	u8 vid;
 	u8 vrm;
-	const struct attribute_group *groups[9];
+	const struct attribute_group *groups[10];
 };
 
 static struct i2c_driver adt7475_driver;
@@ -273,13 +277,14 @@ static inline u16 rpm2tach(unsigned long rpm)
 }
 
 /* Scaling factors for voltage inputs, taken from the ADT7490 datasheet */
-static const int adt7473_in_scaling[ADT7475_VOLTAGE_COUNT + 1][2] = {
+static const int adt7473_in_scaling[ADT7475_VOLTAGE_COUNT + 2][2] = {
 	{ 45, 94 },	/* +2.5V */
 	{ 175, 525 },	/* Vccp */
 	{ 68, 71 },	/* Vcc */
 	{ 93, 47 },	/* +5V */
 	{ 120, 20 },	/* +12V */
 	{ 45, 45 },	/* Vtt */
+	{ 45, 45 },	/* Imon */
 };
 
 static inline int reg2volt(int channel, u16 reg, u8 bypass_attn)
@@ -369,11 +374,16 @@ static ssize_t voltage_store(struct device *dev,
 			reg = VOLTAGE_MIN_REG(sattr->index);
 		else
 			reg = VOLTAGE_MAX_REG(sattr->index);
-	} else {
+	} else if (sattr->index == 5) {
 		if (sattr->nr == MIN)
 			reg = REG_VTT_MIN;
 		else
 			reg = REG_VTT_MAX;
+	} else {
+		if (sattr->nr == MIN)
+			reg = REG_IMON_MIN;
+		else
+			reg = REG_IMON_MAX;
 	}
 
 	i2c_smbus_write_byte_data(client, reg,
@@ -1104,6 +1114,10 @@ static SENSOR_DEVICE_ATTR_2_RO(in5_input, voltage, INPUT, 5);
 static SENSOR_DEVICE_ATTR_2_RW(in5_max, voltage, MAX, 5);
 static SENSOR_DEVICE_ATTR_2_RW(in5_min, voltage, MIN, 5);
 static SENSOR_DEVICE_ATTR_2_RO(in5_alarm, voltage, ALARM, 31);
+static SENSOR_DEVICE_ATTR_2_RO(in6_input, voltage, INPUT, 6);
+static SENSOR_DEVICE_ATTR_2_RW(in6_max, voltage, MAX, 6);
+static SENSOR_DEVICE_ATTR_2_RW(in6_min, voltage, MIN, 6);
+static SENSOR_DEVICE_ATTR_2_RO(in6_alarm, voltage, ALARM, 30);
 static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, INPUT, 0);
 static SENSOR_DEVICE_ATTR_2_RO(temp1_alarm, temp, ALARM, 0);
 static SENSOR_DEVICE_ATTR_2_RO(temp1_fault, temp, FAULT, 0);
@@ -1294,6 +1308,14 @@ static struct attribute *in5_attrs[] = {
 	NULL
 };
 
+static struct attribute *in6_attrs[] = {
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in6_max.dev_attr.attr,
+	&sensor_dev_attr_in6_min.dev_attr.attr,
+	&sensor_dev_attr_in6_alarm.dev_attr.attr,
+	NULL
+};
+
 static struct attribute *vid_attrs[] = {
 	&dev_attr_cpu0_vid.attr,
 	&dev_attr_vrm.attr,
@@ -1307,6 +1329,7 @@ static const struct attribute_group in0_attr_group = { .attrs = in0_attrs };
 static const struct attribute_group in3_attr_group = { .attrs = in3_attrs };
 static const struct attribute_group in4_attr_group = { .attrs = in4_attrs };
 static const struct attribute_group in5_attr_group = { .attrs = in5_attrs };
+static const struct attribute_group in6_attr_group = { .attrs = in6_attrs };
 static const struct attribute_group vid_attr_group = { .attrs = vid_attrs };
 
 static int adt7475_detect(struct i2c_client *client,
@@ -1389,6 +1412,18 @@ static int adt7475_update_limits(struct i2c_client *client)
 		data->voltage[MAX][5] = ret << 2;
 	}
 
+	if (data->has_voltage & (1 << 6)) {
+		ret = adt7475_read(REG_IMON_MIN);
+		if (ret < 0)
+			return ret;
+		data->voltage[MIN][6] = ret << 2;
+
+		ret = adt7475_read(REG_IMON_MAX);
+		if (ret < 0)
+			return ret;
+		data->voltage[MAX][6] = ret << 2;
+	}
+
 	for (i = 0; i < ADT7475_TEMP_COUNT; i++) {
 		/* Adjust values so they match the input precision */
 		ret = adt7475_read(TEMP_MIN_REG(i));
@@ -1663,7 +1698,7 @@ static int adt7475_probe(struct i2c_client *client)
 		revision = adt7475_read(REG_DEVID2) & 0x07;
 		break;
 	case adt7490:
-		data->has_voltage = 0x3e;	/* in1 to in5 */
+		data->has_voltage = 0x7e;	/* in1 to in6 */
 		revision = adt7475_read(REG_DEVID2) & 0x03;
 		if (revision == 0x03)
 			revision += adt7475_read(REG_DEVREV2);
@@ -1775,6 +1810,9 @@ static int adt7475_probe(struct i2c_client *client)
 	if (data->has_voltage & (1 << 5)) {
 		data->groups[group_num++] = &in5_attr_group;
 	}
+	if (data->has_voltage & (1 << 6)) {
+		data->groups[group_num++] = &in6_attr_group;
+	}
 	if (data->has_vid) {
 		data->vrm = vid_which_vrm();
 		data->groups[group_num] = &vid_attr_group;
@@ -1960,6 +1998,24 @@ static int adt7475_update_measure(struct device *dev)
 			((ext >> 4) & 3);
 	}
 
+	if (data->has_voltage & (1 << 6)) {
+		ret = adt7475_read(REG_STATUS4);
+		if (ret < 0)
+			return ret;
+		data->alarms |= ret << 24;
+
+		ret = adt7475_read(REG_EXTEND3);
+		if (ret < 0)
+			return ret;
+		ext = ret;
+
+		ret = adt7475_read(REG_IMON);
+		if (ret < 0)
+			return ret;
+		data->voltage[INPUT][6] = ret << 2 |
+			((ext >> 6) & 3);
+	}
+
 	for (i = 0; i < ADT7475_TACH_COUNT; i++) {
 		if (i == 3 && !data->has_fan4)
 			continue;
-- 
2.30.2

