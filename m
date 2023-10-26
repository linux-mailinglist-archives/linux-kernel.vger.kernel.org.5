Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38F7D8506
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbjJZOoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345293AbjJZOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:44:51 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189CD1AB;
        Thu, 26 Oct 2023 07:44:49 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39QCuGQU010512;
        Thu, 26 Oct 2023 10:44:35 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tyepmc5yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:44:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 39QEiXqC009119
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Oct 2023 10:44:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 26 Oct
 2023 10:44:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 26 Oct 2023 10:44:32 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.198])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39QEiEj0031489;
        Thu, 26 Oct 2023 10:44:27 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/4] hwmon: max31827: Add custom attribute for resolution
Date:   Thu, 26 Oct 2023 17:44:04 +0300
Message-ID: <20231026144405.546822-4-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026144405.546822-1-daniel.matyas@analog.com>
References: <20231026144405.546822-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: plwGlJe-h5lX11mBPReA6mfoUmJpFmWM
X-Proofpoint-ORIG-GUID: plwGlJe-h5lX11mBPReA6mfoUmJpFmWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_13,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310260127
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added custom channel-specific (temp1) attribute for resolution. The wait
time for a conversion in one-shot mode (enable = 0) depends on the
resolution.

When resolution is 12-bit, the conversion time is 140ms, but the minimum
update_interval is 125ms. Handled this problem by waiting an additional
15ms (125ms + 15ms = 140ms).

Added 'mask' parameter to the shutdown_write() function. Now it can
either write or update bits, depending on the value of mask. This is
needed, because for alarms a write is necessary, but for resolution only
the resolution bits should be updated.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---

v4 -> v5: No change.

v3 -> v4: No change.

v2 -> v3: Fixed indentation problems in .rst.

v1 -> v2: Changed subject. Separated patch. Removed timeout sysfs
attribute and kept only resolution. Added temp1_ prefix to resolution.
Changed value of resolution from bits to milli-degrees Celsius. Added
appropriate documentation.


 Documentation/hwmon/max31827.rst |  29 ++++++--
 drivers/hwmon/max31827.c         | 121 ++++++++++++++++++++++++++++---
 2 files changed, 134 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index a8bbfb85dd02..44ab9dc064cb 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -90,11 +90,28 @@ the data sheet are:
 
 Enabling the device when it is already enabled has the side effect of setting
 the conversion frequency to 1 conv/s. The conversion time varies depending on
-the resolution. The conversion time doubles with every bit of increased
-resolution. For 10 bit resolution 35ms are needed, while for 12 bit resolution
-(default) 140ms. When chip is in shutdown mode and a read operation is
-requested, one-shot is triggered, the device waits for 140 (conversion time) ms,
-and only after that is the temperature value register read.
+the resolution.
+
+The conversion time doubles with every bit of increased resolution. The
+available resolutions are:
+
+- 8 bit -> 8.75 ms conversion time
+- 9 bit -> 17.5 ms conversion time
+- 10 bit -> 35 ms conversion time
+- 12 bit (default) -> 140 ms conversion time
+
+There is a temp1_resolution attribute which indicates the unit change in the
+input temperature in milli-degrees C.
+
+- 1000 mC -> 8 bit
+- 500 mC -> 9 bit
+- 250 mC -> 10 bit
+- 62 mC -> 12 bit (default) - actually this is 62.5, but the fil returns 62
+
+When chip is in shutdown mode and a read operation is requested, one-shot is
+triggered, the device waits for <conversion time> ms, and only after that is
+the temperature value register read. Note that the conversion times are rounded
+up to the nearest possible integer.
 
 The LSB of the temperature values is 0.0625 degrees Celsius, but the values of
 the temperatures are displayed in milli-degrees. This means, that some data is
@@ -117,4 +134,4 @@ corresponding status bits.
 Notes
 -----
 
-PEC and resolution are not implemented.
+PEC is not implemented.
diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index 8ba387b51157..c9fa6d4d6194 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -37,6 +37,9 @@
 #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
 #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
 
+#define MAX31827_8_BIT_CNV_TIME		9
+#define MAX31827_9_BIT_CNV_TIME		18
+#define MAX31827_10_BIT_CNV_TIME	35
 #define MAX31827_12_BIT_CNV_TIME	140
 
 #define MAX31827_ALRM_POL_HIGH	0x1
@@ -68,6 +71,27 @@ static const u16 max31827_conversions[] = {
 	[MAX31827_CNV_8_HZ] = 125,
 };
 
+enum max31827_resolution {
+	MAX31827_RES_8_BIT = 0,
+	MAX31827_RES_9_BIT,
+	MAX31827_RES_10_BIT,
+	MAX31827_RES_12_BIT,
+};
+
+static const u16 max31827_resolutions[] = {
+	[MAX31827_RES_8_BIT] = 1000,
+	[MAX31827_RES_9_BIT] = 500,
+	[MAX31827_RES_10_BIT] = 250,
+	[MAX31827_RES_12_BIT] = 62,
+};
+
+static const u16 max31827_conv_times[] = {
+	[MAX31827_RES_8_BIT] = MAX31827_8_BIT_CNV_TIME,
+	[MAX31827_RES_9_BIT] = MAX31827_9_BIT_CNV_TIME,
+	[MAX31827_RES_10_BIT] = MAX31827_10_BIT_CNV_TIME,
+	[MAX31827_RES_12_BIT] = MAX31827_12_BIT_CNV_TIME,
+};
+
 struct max31827_state {
 	/*
 	 * Prevent simultaneous access to the i2c client.
@@ -75,6 +99,8 @@ struct max31827_state {
 	struct mutex lock;
 	struct regmap *regmap;
 	bool enable;
+	unsigned int resolution;
+	unsigned int update_interval;
 };
 
 static const struct regmap_config max31827_regmap = {
@@ -91,9 +117,9 @@ static int shutdown_write(struct max31827_state *st, unsigned int reg,
 	int ret;
 
 	/*
-	 * Before the Temperature Threshold Alarm and Alarm Hysteresis Threshold
-	 * register values are changed over I2C, the part must be in shutdown
-	 * mode.
+	 * Before the Temperature Threshold Alarm, Alarm Hysteresis Threshold
+	 * and Resolution bits from Configuration register are changed over I2C,
+	 * the part must be in shutdown mode.
 	 *
 	 * Mutex is used to ensure, that some other process doesn't change the
 	 * configuration register.
@@ -211,9 +237,18 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 					mutex_unlock(&st->lock);
 					return ret;
 				}
-
-				msleep(MAX31827_12_BIT_CNV_TIME);
+				msleep(max31827_conv_times[st->resolution]);
 			}
+
+			/*
+			 * For 12-bit resolution the conversion time is 140 ms,
+			 * thus an additional 15 ms is needed to complete the
+			 * conversion: 125 ms + 15 ms = 140 ms
+			 */
+			if (max31827_resolutions[st->resolution] == 12 &&
+			    st->update_interval == 125)
+				usleep_range(15000, 20000);
+
 			ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
 
 			mutex_unlock(&st->lock);
@@ -371,10 +406,14 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 			res = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
 					 res);
 
-			return regmap_update_bits(st->regmap,
-						  MAX31827_CONFIGURATION_REG,
-						  MAX31827_CONFIGURATION_CNV_RATE_MASK,
-						  res);
+			ret = regmap_update_bits(st->regmap,
+						 MAX31827_CONFIGURATION_REG,
+						 MAX31827_CONFIGURATION_CNV_RATE_MASK,
+						 res);
+			if (ret)
+				return ret;
+
+			st->update_interval = val;
 		}
 		break;
 
@@ -385,6 +424,68 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 	return -EOPNOTSUPP;
 }
 
+static ssize_t temp1_resolution_show(struct device *dev,
+				     struct device_attribute *devattr,
+				     char *buf)
+{
+	struct max31827_state *st = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(MAX31827_CONFIGURATION_RESOLUTION_MASK, val);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", max31827_resolutions[val]);
+}
+
+static ssize_t temp1_resolution_store(struct device *dev,
+				      struct device_attribute *devattr,
+				      const char *buf, size_t count)
+{
+	struct max31827_state *st = dev_get_drvdata(dev);
+	unsigned int idx = 0;
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Convert the desired resolution into register
+	 * bits. idx is already initialized with 0.
+	 *
+	 * This was inspired by lm73 driver.
+	 */
+	while (idx < ARRAY_SIZE(max31827_resolutions) &&
+	       val < max31827_resolutions[idx])
+		idx++;
+
+	if (idx == ARRAY_SIZE(max31827_resolutions) ||
+	    val != max31827_resolutions[idx])
+		return -EOPNOTSUPP;
+
+	st->resolution = idx;
+
+	ret = shutdown_write(st, MAX31827_CONFIGURATION_REG,
+			     MAX31827_CONFIGURATION_RESOLUTION_MASK,
+			     FIELD_PREP(MAX31827_CONFIGURATION_RESOLUTION_MASK,
+					idx));
+
+	return (ret) ? ret : count;
+}
+
+static DEVICE_ATTR_RW(temp1_resolution);
+
+static struct attribute *max31827_attrs[] = {
+	&dev_attr_temp1_resolution.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(max31827);
+
 static const struct i2c_device_id max31827_i2c_ids[] = {
 	{ "max31827", max31827 },
 	{ "max31828", max31828 },
@@ -501,7 +602,7 @@ static int max31827_probe(struct i2c_client *client)
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, st,
 							 &max31827_chip_info,
-							 NULL);
+							 max31827_groups);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
-- 
2.34.1

