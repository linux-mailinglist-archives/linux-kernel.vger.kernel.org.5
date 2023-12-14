Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93939813351
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573534AbjLNOha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573505AbjLNOhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:37:25 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5850A7;
        Thu, 14 Dec 2023 06:37:30 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BEBOb7q026794;
        Thu, 14 Dec 2023 09:37:08 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3uy905p8y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:37:07 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3BEEb6VF003512
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Dec 2023 09:37:06 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 14 Dec
 2023 09:37:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 14 Dec 2023 09:37:05 -0500
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.152])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BEEaqwd017595;
        Thu, 14 Dec 2023 09:36:54 -0500
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
Subject: [PATCH 1/3] hwmon: max31827: Add PEC support
Date:   Thu, 14 Dec 2023 16:36:45 +0200
Message-ID: <20231214143648.175336-1-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 8ss27Uad35oU5kGN88cY07AfjKw7MuDo
X-Proofpoint-ORIG-GUID: 8ss27Uad35oU5kGN88cY07AfjKw7MuDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140102
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed regmap and used my functions to read, write and update bits. In
these functions i2c_smbus_ helper functions are used. These check if
there were any PEC errors during read. In the write function, if PEC is
enabled, I check for PEC Error bit, to see if there were any errors.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---
 Documentation/hwmon/max31827.rst |  14 +-
 drivers/hwmon/max31827.c         | 219 +++++++++++++++++++++++--------
 2 files changed, 171 insertions(+), 62 deletions(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index 44ab9dc064cb..ecbc1ddba6a7 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -131,7 +131,13 @@ The Fault Queue bits select how many consecutive temperature faults must occur
 before overtemperature or undertemperature faults are indicated in the
 corresponding status bits.
 
-Notes
------
-
-PEC is not implemented.
+PEC (packet error checking) can be enabled from the "pec" device attribute.
+If PEC is enabled, a PEC byte is appended to the end of each message transfer.
+This is a CRC-8 byte that is calculated on all of the message bytes (including
+the address/read/write byte). The last device to transmit a data byte also
+transmits the PEC byte. The master transmits the PEC byte after a write
+transaction, and the MAX31827 transmits the PEC byte after a read transaction.
+
+The read PEC error is handled inside the i2c_smbus_read_word_swapped() function.
+To check if the write had any PEC error a read is performed on the configuration
+register, to check the PEC Error bit.
\ No newline at end of file
diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index 71ad3934dfb6..db93492193bd 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -11,8 +11,8 @@
 #include <linux/hwmon.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
-#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/of_device.h>
 
 #define MAX31827_T_REG			0x0
@@ -24,11 +24,13 @@
 
 #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
 #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
+#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
 #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
 #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
 #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
 #define MAX31827_CONFIGURATION_COMP_INT_MASK	BIT(9)
 #define MAX31827_CONFIGURATION_FLT_Q_MASK	GENMASK(11, 10)
+#define MAX31827_CONFIGURATION_PEC_ERR_MASK	BIT(13)
 #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
 #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
 
@@ -94,23 +96,67 @@ struct max31827_state {
 	 * Prevent simultaneous access to the i2c client.
 	 */
 	struct mutex lock;
-	struct regmap *regmap;
 	bool enable;
 	unsigned int resolution;
 	unsigned int update_interval;
+	struct i2c_client *client;
 };
 
-static const struct regmap_config max31827_regmap = {
-	.reg_bits = 8,
-	.val_bits = 16,
-	.max_register = 0xA,
-};
+static int max31827_reg_read(struct i2c_client *client, u8 reg, u16 *val)
+{
+	u16 tmp = i2c_smbus_read_word_swapped(client, reg);
+
+	if (tmp < 0)
+		return tmp;
+
+	*val = tmp;
+	return 0;
+}
+
+static int max31827_reg_write(struct i2c_client *client, u8 reg, u16 val)
+{
+	u16 cfg;
+	int ret;
+
+	ret = i2c_smbus_write_word_swapped(client, reg, val);
+	if (ret)
+		return ret;
+
+	// If PEC is not enabled, return with success
+	if (!(client->flags & I2C_CLIENT_PEC))
+		return 0;
+
+	ret = max31827_reg_read(client, MAX31827_CONFIGURATION_REG, &cfg);
+	if (ret)
+		return ret;
+
+	if (cfg & MAX31827_CONFIGURATION_PEC_ERR_MASK)
+		return -EBADMSG;
+
+	return 0;
+}
+
+static int max31827_update_bits(struct i2c_client *client, u8 reg,
+				u16 mask, u16 val)
+{
+	u16 tmp;
+	int ret;
+
+	ret = max31827_reg_read(client, reg, &tmp);
+	if (ret)
+		return ret;
+
+	tmp = (tmp & ~mask) | (val & mask);
+	ret = max31827_reg_write(client, reg, tmp);
+
+	return ret;
+}
 
 static int shutdown_write(struct max31827_state *st, unsigned int reg,
 			  unsigned int mask, unsigned int val)
 {
-	unsigned int cfg;
-	unsigned int cnv_rate;
+	u16 cfg;
+	u16 cnv_rate;
 	int ret;
 
 	/*
@@ -125,34 +171,34 @@ static int shutdown_write(struct max31827_state *st, unsigned int reg,
 
 	if (!st->enable) {
 		if (!mask)
-			ret = regmap_write(st->regmap, reg, val);
+			ret = max31827_reg_write(st->client, reg, val);
 		else
-			ret = regmap_update_bits(st->regmap, reg, mask, val);
+			ret = max31827_update_bits(st->client, reg, mask, val);
 		goto unlock;
 	}
 
-	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &cfg);
+	ret = max31827_reg_read(st->client, MAX31827_CONFIGURATION_REG, &cfg);
 	if (ret)
 		goto unlock;
 
 	cnv_rate = MAX31827_CONFIGURATION_CNV_RATE_MASK & cfg;
 	cfg = cfg & ~(MAX31827_CONFIGURATION_1SHOT_MASK |
 		      MAX31827_CONFIGURATION_CNV_RATE_MASK);
-	ret = regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, cfg);
+	ret = max31827_reg_write(st->client, MAX31827_CONFIGURATION_REG, cfg);
 	if (ret)
 		goto unlock;
 
 	if (!mask)
-		ret = regmap_write(st->regmap, reg, val);
+		ret = max31827_reg_write(st->client, reg, val);
 	else
-		ret = regmap_update_bits(st->regmap, reg, mask, val);
+		ret = max31827_update_bits(st->client, reg, mask, val);
 
 	if (ret)
 		goto unlock;
 
-	ret = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
-				 MAX31827_CONFIGURATION_CNV_RATE_MASK,
-				 cnv_rate);
+	ret = max31827_update_bits(st->client, MAX31827_CONFIGURATION_REG,
+				   MAX31827_CONFIGURATION_CNV_RATE_MASK,
+				   cnv_rate);
 
 unlock:
 	mutex_unlock(&st->lock);
@@ -198,15 +244,16 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 			 u32 attr, int channel, long *val)
 {
 	struct max31827_state *st = dev_get_drvdata(dev);
-	unsigned int uval;
+	u16 uval;
 	int ret = 0;
 
 	switch (type) {
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_enable:
-			ret = regmap_read(st->regmap,
-					  MAX31827_CONFIGURATION_REG, &uval);
+			ret = max31827_reg_read(st->client,
+						MAX31827_CONFIGURATION_REG,
+						&uval);
 			if (ret)
 				break;
 
@@ -226,10 +273,10 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 				 * be changed during the conversion process.
 				 */
 
-				ret = regmap_update_bits(st->regmap,
-							 MAX31827_CONFIGURATION_REG,
-							 MAX31827_CONFIGURATION_1SHOT_MASK,
-							 1);
+				ret = max31827_update_bits(st->client,
+							   MAX31827_CONFIGURATION_REG,
+							   MAX31827_CONFIGURATION_1SHOT_MASK,
+							   1);
 				if (ret) {
 					mutex_unlock(&st->lock);
 					return ret;
@@ -246,7 +293,8 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 			    st->update_interval == 125)
 				usleep_range(15000, 20000);
 
-			ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
+			ret = max31827_reg_read(st->client, MAX31827_T_REG,
+						&uval);
 
 			mutex_unlock(&st->lock);
 
@@ -257,23 +305,26 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 
 			break;
 		case hwmon_temp_max:
-			ret = regmap_read(st->regmap, MAX31827_TH_REG, &uval);
+			ret = max31827_reg_read(st->client, MAX31827_TH_REG,
+						&uval);
 			if (ret)
 				break;
 
 			*val = MAX31827_16_BIT_TO_M_DGR(uval);
 			break;
 		case hwmon_temp_max_hyst:
-			ret = regmap_read(st->regmap, MAX31827_TH_HYST_REG,
-					  &uval);
+			ret = max31827_reg_read(st->client,
+						MAX31827_TH_HYST_REG,
+						&uval);
 			if (ret)
 				break;
 
 			*val = MAX31827_16_BIT_TO_M_DGR(uval);
 			break;
 		case hwmon_temp_max_alarm:
-			ret = regmap_read(st->regmap,
-					  MAX31827_CONFIGURATION_REG, &uval);
+			ret = max31827_reg_read(st->client,
+						MAX31827_CONFIGURATION_REG,
+						&uval);
 			if (ret)
 				break;
 
@@ -281,23 +332,25 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 					 uval);
 			break;
 		case hwmon_temp_min:
-			ret = regmap_read(st->regmap, MAX31827_TL_REG, &uval);
+			ret = max31827_reg_read(st->client, MAX31827_TL_REG,
+						&uval);
 			if (ret)
 				break;
 
 			*val = MAX31827_16_BIT_TO_M_DGR(uval);
 			break;
 		case hwmon_temp_min_hyst:
-			ret = regmap_read(st->regmap, MAX31827_TL_HYST_REG,
-					  &uval);
+			ret = max31827_reg_read(st->client, MAX31827_TL_HYST_REG,
+						&uval);
 			if (ret)
 				break;
 
 			*val = MAX31827_16_BIT_TO_M_DGR(uval);
 			break;
 		case hwmon_temp_min_alarm:
-			ret = regmap_read(st->regmap,
-					  MAX31827_CONFIGURATION_REG, &uval);
+			ret = max31827_reg_read(st->client,
+						MAX31827_CONFIGURATION_REG,
+						&uval);
 			if (ret)
 				break;
 
@@ -313,8 +366,9 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 
 	case hwmon_chip:
 		if (attr == hwmon_chip_update_interval) {
-			ret = regmap_read(st->regmap,
-					  MAX31827_CONFIGURATION_REG, &uval);
+			ret = max31827_reg_read(st->client,
+						MAX31827_CONFIGURATION_REG,
+						&uval);
 			if (ret)
 				break;
 
@@ -355,11 +409,11 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 
 			st->enable = val;
 
-			ret = regmap_update_bits(st->regmap,
-						 MAX31827_CONFIGURATION_REG,
-						 MAX31827_CONFIGURATION_1SHOT_MASK |
-						 MAX31827_CONFIGURATION_CNV_RATE_MASK,
-						 MAX31827_DEVICE_ENABLE(val));
+			ret = max31827_update_bits(st->client,
+						   MAX31827_CONFIGURATION_REG,
+						   MAX31827_CONFIGURATION_1SHOT_MASK |
+						   MAX31827_CONFIGURATION_CNV_RATE_MASK,
+						   MAX31827_DEVICE_ENABLE(val));
 
 			mutex_unlock(&st->lock);
 
@@ -402,10 +456,10 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 			res = FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
 					 res);
 
-			ret = regmap_update_bits(st->regmap,
-						 MAX31827_CONFIGURATION_REG,
-						 MAX31827_CONFIGURATION_CNV_RATE_MASK,
-						 res);
+			ret = max31827_update_bits(st->client,
+						   MAX31827_CONFIGURATION_REG,
+						   MAX31827_CONFIGURATION_CNV_RATE_MASK,
+						   res);
 			if (ret)
 				return ret;
 
@@ -425,10 +479,10 @@ static ssize_t temp1_resolution_show(struct device *dev,
 				     char *buf)
 {
 	struct max31827_state *st = dev_get_drvdata(dev);
-	unsigned int val;
+	u16 val;
 	int ret;
 
-	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &val);
+	ret = max31827_reg_read(st->client, MAX31827_CONFIGURATION_REG, &val);
 	if (ret)
 		return ret;
 
@@ -473,10 +527,63 @@ static ssize_t temp1_resolution_store(struct device *dev,
 	return ret ? ret : count;
 }
 
+static ssize_t pec_show(struct device *dev, struct device_attribute *devattr,
+			char *buf)
+{
+	struct max31827_state *st = dev_get_drvdata(dev);
+	struct i2c_client *client = st->client;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
+}
+
+static ssize_t pec_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
+{
+	struct max31827_state *st = dev_get_drvdata(dev);
+	struct i2c_client *client = st->client;
+	unsigned int val;
+	u16 val2;
+	int err;
+
+	err = kstrtouint(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val2 = FIELD_PREP(MAX31827_CONFIGURATION_PEC_EN_MASK, val);
+
+	if (err)
+		return err;
+
+	switch (val) {
+	case 0:
+		client->flags &= ~I2C_CLIENT_PEC;
+		err = max31827_update_bits(client, MAX31827_CONFIGURATION_REG,
+					   MAX31827_CONFIGURATION_PEC_EN_MASK,
+					   val2);
+		if (err)
+			return err;
+		break;
+	case 1:
+		err = max31827_update_bits(client, MAX31827_CONFIGURATION_REG,
+					   MAX31827_CONFIGURATION_PEC_EN_MASK,
+					   val2);
+		if (err)
+			return err;
+		client->flags |= I2C_CLIENT_PEC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(temp1_resolution);
+static DEVICE_ATTR_RW(pec);
 
 static struct attribute *max31827_attrs[] = {
 	&dev_attr_temp1_resolution.attr,
+	&dev_attr_pec.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(max31827);
@@ -489,9 +596,9 @@ static const struct i2c_device_id max31827_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
 
-static int max31827_init_client(struct max31827_state *st,
-				struct device *dev)
+static int max31827_init_client(struct max31827_state *st)
 {
+	struct device *dev = &st->client->dev;
 	struct fwnode_handle *fwnode;
 	unsigned int res = 0;
 	u32 data, lsb_idx;
@@ -575,7 +682,7 @@ static int max31827_init_client(struct max31827_state *st,
 		}
 	}
 
-	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
+	return max31827_reg_write(st->client, MAX31827_CONFIGURATION_REG, res);
 }
 
 static const struct hwmon_channel_info *max31827_info[] = {
@@ -613,17 +720,13 @@ static int max31827_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	mutex_init(&st->lock);
-
-	st->regmap = devm_regmap_init_i2c(client, &max31827_regmap);
-	if (IS_ERR(st->regmap))
-		return dev_err_probe(dev, PTR_ERR(st->regmap),
-				     "Failed to allocate regmap.\n");
+	st->client = client;
 
 	err = devm_regulator_get_enable(dev, "vref");
 	if (err)
 		return dev_err_probe(dev, err, "failed to enable regulator\n");
 
-	err = max31827_init_client(st, dev);
+	err = max31827_init_client(st);
 	if (err)
 		return err;
 
-- 
2.34.1

