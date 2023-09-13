Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F092479EC97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbjIMPWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbjIMPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:22:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E491724;
        Wed, 13 Sep 2023 08:22:36 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38DDh9ei006883;
        Wed, 13 Sep 2023 11:22:16 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t2y8f562c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:22:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 38DFMFOQ004934
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 11:22:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 13 Sep
 2023 11:22:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 13 Sep 2023 11:22:14 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.230])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38DFLmjB007886;
        Wed, 13 Sep 2023 11:22:09 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 1/4] hwmon: max31827: Make code cleaner
Date:   Wed, 13 Sep 2023 18:21:31 +0300
Message-ID: <20230913152135.457892-2-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913152135.457892-1-daniel.matyas@analog.com>
References: <20230913152135.457892-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: M94kou5Mj2C1ZGBtuNV8XO3iKcEeyKBe
X-Proofpoint-GUID: M94kou5Mj2C1ZGBtuNV8XO3iKcEeyKBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_09,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309130125
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the wait time for one-shot is 140ms, instead of the old 141
(removed the 1ms error).

Used enums and while loops to replace switch for selecting and getting
update interval from conversion rate bits.

Divided the write_alarm_val function into 2 functions. The new function
is more generic: it can be used not only for alarm writes, but for any
kind of writes which require the device to be in shutdown mode.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---
 Documentation/hwmon/max31827.rst |   4 +-
 drivers/hwmon/max31827.c         | 127 ++++++++++++++-----------------
 2 files changed, 58 insertions(+), 73 deletions(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index b0971d05b8a4..9a1055a007cf 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -73,8 +73,8 @@ the conversion frequency to 1 conv/s. The conversion time varies depending on
 the resolution. The conversion time doubles with every bit of increased
 resolution. For 10 bit resolution 35ms are needed, while for 12 bit resolution
 (default) 140ms. When chip is in shutdown mode and a read operation is
-requested, one-shot is triggered, the device waits for 140 (conversion time) + 1
-(error) ms, and only after that is the temperature value register read.
+requested, one-shot is triggered, the device waits for 140 (conversion time) ms,
+and only after that is the temperature value register read.
 
 The LSB of the temperature values is 0.0625 degrees Celsius, but the values of
 the temperatures are displayed in milli-degrees. This means, that some data is
diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index 602f4e4f81ff..f05762219995 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -25,20 +25,32 @@
 #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
 #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
 
-#define MAX31827_12_BIT_CNV_TIME	141
-
-#define MAX31827_CNV_1_DIV_64_HZ	0x1
-#define MAX31827_CNV_1_DIV_32_HZ	0x2
-#define MAX31827_CNV_1_DIV_16_HZ	0x3
-#define MAX31827_CNV_1_DIV_4_HZ		0x4
-#define MAX31827_CNV_1_HZ		0x5
-#define MAX31827_CNV_4_HZ		0x6
-#define MAX31827_CNV_8_HZ		0x7
+#define MAX31827_12_BIT_CNV_TIME	140
 
 #define MAX31827_16_BIT_TO_M_DGR(x)	(sign_extend32(x, 15) * 1000 / 16)
 #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
 #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
 
+enum max31827_cnv {
+	MAX31827_CNV_1_DIV_64_HZ = 1,
+	MAX31827_CNV_1_DIV_32_HZ,
+	MAX31827_CNV_1_DIV_16_HZ,
+	MAX31827_CNV_1_DIV_4_HZ,
+	MAX31827_CNV_1_HZ,
+	MAX31827_CNV_4_HZ,
+	MAX31827_CNV_8_HZ,
+};
+
+static const u16 max31827_conversions[] = {
+	[MAX31827_CNV_1_DIV_64_HZ] = 64000,
+	[MAX31827_CNV_1_DIV_32_HZ] = 32000,
+	[MAX31827_CNV_1_DIV_16_HZ] = 16000,
+	[MAX31827_CNV_1_DIV_4_HZ] = 4000,
+	[MAX31827_CNV_1_HZ] = 1000,
+	[MAX31827_CNV_4_HZ] = 250,
+	[MAX31827_CNV_8_HZ] = 125,
+};
+
 struct max31827_state {
 	/*
 	 * Prevent simultaneous access to the i2c client.
@@ -54,15 +66,13 @@ static const struct regmap_config max31827_regmap = {
 	.max_register = 0xA,
 };
 
-static int write_alarm_val(struct max31827_state *st, unsigned int reg,
-			   long val)
+static int shutdown_write(struct max31827_state *st, unsigned int reg,
+			  unsigned int val)
 {
 	unsigned int cfg;
-	unsigned int tmp;
+	unsigned int cnv_rate;
 	int ret;
 
-	val = MAX31827_M_DGR_TO_16_BIT(val);
-
 	/*
 	 * Before the Temperature Threshold Alarm and Alarm Hysteresis Threshold
 	 * register values are changed over I2C, the part must be in shutdown
@@ -82,9 +92,10 @@ static int write_alarm_val(struct max31827_state *st, unsigned int reg,
 	if (ret)
 		goto unlock;
 
-	tmp = cfg & ~(MAX31827_CONFIGURATION_1SHOT_MASK |
+	cnv_rate = MAX31827_CONFIGURATION_CNV_RATE_MASK & cfg;
+	cfg = cfg & ~(MAX31827_CONFIGURATION_1SHOT_MASK |
 		      MAX31827_CONFIGURATION_CNV_RATE_MASK);
-	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, tmp);
+	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, cfg);
 	if (ret)
 		goto unlock;
 
@@ -92,13 +103,23 @@ static int write_alarm_val(struct max31827_state *st, unsigned int reg,
 	if (ret)
 		goto unlock;
 
-	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, cfg);
+	ret = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+				 MAX31827_CONFIGURATION_CNV_RATE_MASK,
+				 cnv_rate);
 
 unlock:
 	mutex_unlock(&st->lock);
 	return ret;
 }
 
+static int write_alarm_val(struct max31827_state *st, unsigned int reg,
+			   long val)
+{
+	val = MAX31827_M_DGR_TO_16_BIT(val);
+
+	return shutdown_write(st, reg, val);
+}
+
 static umode_t max31827_is_visible(const void *state,
 				   enum hwmon_sensor_types type, u32 attr,
 				   int channel)
@@ -243,32 +264,7 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 
 			uval = FIELD_GET(MAX31827_CONFIGURATION_CNV_RATE_MASK,
 					 uval);
-			switch (uval) {
-			case MAX31827_CNV_1_DIV_64_HZ:
-				*val = 64000;
-				break;
-			case MAX31827_CNV_1_DIV_32_HZ:
-				*val = 32000;
-				break;
-			case MAX31827_CNV_1_DIV_16_HZ:
-				*val = 16000;
-				break;
-			case MAX31827_CNV_1_DIV_4_HZ:
-				*val = 4000;
-				break;
-			case MAX31827_CNV_1_HZ:
-				*val = 1000;
-				break;
-			case MAX31827_CNV_4_HZ:
-				*val = 250;
-				break;
-			case MAX31827_CNV_8_HZ:
-				*val = 125;
-				break;
-			default:
-				*val = 0;
-				break;
-			}
+			*val = max31827_conversions[uval];
 		}
 		break;
 
@@ -284,6 +280,7 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 			  u32 attr, int channel, long val)
 {
 	struct max31827_state *st = dev_get_drvdata(dev);
+	int res = 1;
 	int ret;
 
 	switch (type) {
@@ -333,39 +330,27 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 			if (!st->enable)
 				return -EINVAL;
 
-			switch (val) {
-			case 125:
-				val = MAX31827_CNV_8_HZ;
-				break;
-			case 250:
-				val = MAX31827_CNV_4_HZ;
-				break;
-			case 1000:
-				val = MAX31827_CNV_1_HZ;
-				break;
-			case 4000:
-				val = MAX31827_CNV_1_DIV_4_HZ;
-				break;
-			case 16000:
-				val = MAX31827_CNV_1_DIV_16_HZ;
-				break;
-			case 32000:
-				val = MAX31827_CNV_1_DIV_32_HZ;
-				break;
-			case 64000:
-				val = MAX31827_CNV_1_DIV_64_HZ;
-				break;
-			default:
-				return -EINVAL;
-			}
+			/*
+			 * Convert the desired conversion rate into register
+			 * bits. res is already initialized with 1.
+			 *
+			 * This was inspired by lm73 driver.
+			 */
+			while (res < ARRAY_SIZE(max31827_conversions) &&
+			       val < max31827_conversions[res])
+				res++;
+
+			if (res == ARRAY_SIZE(max31827_conversions) ||
+			    val != max31827_conversions[res])
+				return -EOPNOTSUPP;
 
-			val = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
-					 val);
+			res = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
+					 res);
 
 			return regmap_update_bits(st->regmap,
 						  MAX31827_CONFIGURATION_REG,
 						  MAX31827_CONFIGURATION_CNV_RATE_MASK,
-						  val);
+						  res);
 		}
 		break;
 
-- 
2.34.1

