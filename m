Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC637D8B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbjJZWRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjJZWRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:17:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAAB91;
        Thu, 26 Oct 2023 15:17:35 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QM9PZ5010260;
        Thu, 26 Oct 2023 22:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=iGJxaPnWBwrWPTu8G/B2k5nK1md372Hn+qv6XIuKvf0=;
 b=X4MMLgHFp/Rx+GmMpHTvjTg8ULYtjV9S9U/ue/Ahkcoe9XYUGODbSKXTuSEBp3i28Z53
 orVcmGloCMiikFvjY3kaMuVUmsfUlUR0upPnP7wKhyOXdZehGuAp+OeWaiajBiytrgh9
 i3ORQ4vBH1TVigbUeiwwaVDZDlLz5ZAhrVUm8hBUlyHM1D9aXMWnPOsLyWBITW+fpb0G
 j55oo7Qg7c9xSX0wiPj37bELJS3rTfi3GjY8ksXK/IwAvsA+LD+JSaWIdpzVgyFVDNA1
 SZghcbp2zjk80NxxOj/dGKxC2YyarCvCyHq8bhcpiCKresIL2Wy7XayGRTCbFzD3mClN 9g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u00nhr9gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 22:17:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39QLsVkB011894;
        Thu, 26 Oct 2023 22:17:12 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tywqr107a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 22:17:12 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39QMHBgw12059236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 22:17:11 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4358658059;
        Thu, 26 Oct 2023 22:17:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2182158065;
        Thu, 26 Oct 2023 22:17:11 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Oct 2023 22:17:11 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 5652E740051; Thu, 26 Oct 2023 17:17:10 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] hwmon: (pmbus/max31785) Add delay between bus accesses
Date:   Thu, 26 Oct 2023 17:17:08 -0500
Message-Id: <20231026221708.1582518-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nJZvGawrEJWSN-hbQ4vpf-vCCPXgFSqR
X-Proofpoint-GUID: nJZvGawrEJWSN-hbQ4vpf-vCCPXgFSqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_21,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310260194
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX31785 has shown erratic behaviour across multiple system
designs, unexpectedly clock stretching and NAKing transactions.

Experimentation shows that this seems to be triggered by a register access
directly back to back with a previous register write. Experimentation also
shows that inserting a small delay after register writes makes the issue go
away.

Use a similar solution to what the max15301 driver does to solve the same
problem. Create a custom set of bus read and write functions that make sure
that the delay is added.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
V3 -> V4: Fixed warnings realted to this commit
V2 -> V3: Fixed the commit message
V1 -> V2:
- Changed the max31785_wait macro to a function, following the conventions
  used in other drivers that had the same issue.
- Changed the function names from max31785_i2c_smbus* to max31785_i2c_* and
  from max31785_pmbus_* to _max31785_*, making them more concise.

 drivers/hwmon/pmbus/max31785.c | 187 +++++++++++++++++++++++++++++----
 1 file changed, 166 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/pmbus/max31785.c b/drivers/hwmon/pmbus/max31785.c
index f9aa576495a5..cc9acd7bac37 100644
--- a/drivers/hwmon/pmbus/max31785.c
+++ b/drivers/hwmon/pmbus/max31785.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 IBM Corp.
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -23,19 +24,118 @@ enum max31785_regs {
 
 #define MAX31785_NR_PAGES		23
 #define MAX31785_NR_FAN_PAGES		6
+#define MAX31785_WAIT_DELAY_US		250
 
-static int max31785_read_byte_data(struct i2c_client *client, int page,
-				   int reg)
+struct max31785_data {
+	ktime_t access;			/* Chip access time */
+	struct pmbus_driver_info info;
+};
+
+#define to_max31785_data(x)  container_of(x, struct max31785_data, info)
+
+/*
+ * MAX31785 Driver Workaround
+ *
+ * The MAX31785 fan controller occasionally exhibits communication issues.
+ * These issues are not indicated by the device itself, except for occasional
+ * NACK responses during master transactions. No error bits are set in STATUS_BYTE.
+ *
+ * To address this, we introduce a delay of 250us between consecutive accesses
+ * to the fan controller. This delay helps mitigate communication problems by
+ * allowing sufficient time between accesses.
+ */
+static inline void max31785_wait(const struct max31785_data *data)
 {
-	if (page < MAX31785_NR_PAGES)
-		return -ENODATA;
+	s64 delta = ktime_us_delta(ktime_get(), data->access);
+
+	if (delta < MAX31785_WAIT_DELAY_US)
+		udelay(MAX31785_WAIT_DELAY_US - delta);
+}
+
+static int max31785_i2c_write_byte_data(struct i2c_client *client,
+					struct max31785_data *driver_data,
+					int command, u16 data)
+{
+	int rc;
+
+	max31785_wait(driver_data);
+	rc = i2c_smbus_write_byte_data(client, command, data);
+	driver_data->access = ktime_get();
+	return rc;
+}
+
+static int max31785_i2c_read_word_data(struct i2c_client *client,
+				       struct max31785_data *driver_data,
+				       int command)
+{
+	int rc;
+
+	max31785_wait(driver_data);
+	rc = i2c_smbus_read_word_data(client, command);
+	driver_data->access = ktime_get();
+	return rc;
+}
+
+static int _max31785_read_byte_data(struct i2c_client *client,
+				    struct max31785_data *driver_data,
+				    int page, int command)
+{
+	int rc;
+
+	max31785_wait(driver_data);
+	rc = pmbus_read_byte_data(client, page, command);
+	driver_data->access = ktime_get();
+	return rc;
+}
+
+static int _max31785_write_byte_data(struct i2c_client *client,
+				     struct max31785_data *driver_data,
+				     int page, int command, u16 data)
+{
+	int rc;
+
+	max31785_wait(driver_data);
+	rc = pmbus_write_byte_data(client, page, command, data);
+	driver_data->access = ktime_get();
+	return rc;
+}
+
+static int _max31785_read_word_data(struct i2c_client *client,
+				    struct max31785_data *driver_data,
+				    int page, int phase, int command)
+{
+	int rc;
+
+	max31785_wait(driver_data);
+	rc = pmbus_read_word_data(client, page, phase, command);
+	driver_data->access = ktime_get();
+	return rc;
+}
+
+static int _max31785_write_word_data(struct i2c_client *client,
+				     struct max31785_data *driver_data,
+				     int page, int command, u16 data)
+{
+	int rc;
+
+	max31785_wait(driver_data);
+	rc = pmbus_write_word_data(client, page, command, data);
+	driver_data->access = ktime_get();
+	return rc;
+}
+
+static int max31785_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct max31785_data *driver_data = to_max31785_data(info);
 
 	switch (reg) {
 	case PMBUS_VOUT_MODE:
 		return -ENOTSUPP;
 	case PMBUS_FAN_CONFIG_12:
-		return pmbus_read_byte_data(client, page - MAX31785_NR_PAGES,
-					    reg);
+		return _max31785_read_byte_data(client, driver_data,
+						page - MAX31785_NR_PAGES,
+						reg);
 	}
 
 	return -ENODATA;
@@ -102,16 +202,19 @@ static int max31785_get_pwm(struct i2c_client *client, int page)
 	return rv;
 }
 
-static int max31785_get_pwm_mode(struct i2c_client *client, int page)
+static int max31785_get_pwm_mode(struct i2c_client *client,
+				 struct max31785_data *driver_data, int page)
 {
 	int config;
 	int command;
 
-	config = pmbus_read_byte_data(client, page, PMBUS_FAN_CONFIG_12);
+	config = _max31785_read_byte_data(client, driver_data, page,
+					  PMBUS_FAN_CONFIG_12);
 	if (config < 0)
 		return config;
 
-	command = pmbus_read_word_data(client, page, 0xff, PMBUS_FAN_COMMAND_1);
+	command = _max31785_read_word_data(client, driver_data, page, 0xff,
+					   PMBUS_FAN_COMMAND_1);
 	if (command < 0)
 		return command;
 
@@ -129,6 +232,8 @@ static int max31785_get_pwm_mode(struct i2c_client *client, int page)
 static int max31785_read_word_data(struct i2c_client *client, int page,
 				   int phase, int reg)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct max31785_data *driver_data = to_max31785_data(info);
 	u32 val;
 	int rv;
 
@@ -157,7 +262,7 @@ static int max31785_read_word_data(struct i2c_client *client, int page,
 		rv = max31785_get_pwm(client, page);
 		break;
 	case PMBUS_VIRT_PWM_ENABLE_1:
-		rv = max31785_get_pwm_mode(client, page);
+		rv = max31785_get_pwm_mode(client, driver_data, page);
 		break;
 	default:
 		rv = -ENODATA;
@@ -188,8 +293,36 @@ static inline u32 max31785_scale_pwm(u32 sensor_val)
 	return (sensor_val * 100) / 255;
 }
 
-static int max31785_pwm_enable(struct i2c_client *client, int page,
-				    u16 word)
+static int max31785_update_fan(struct i2c_client *client,
+			       struct max31785_data *driver_data, int page,
+			       u8 config, u8 mask, u16 command)
+{
+	int from, rv;
+	u8 to;
+
+	from = _max31785_read_byte_data(client, driver_data, page,
+					PMBUS_FAN_CONFIG_12);
+	if (from < 0)
+		return from;
+
+	to = (from & ~mask) | (config & mask);
+
+	if (to != from) {
+		rv = _max31785_write_byte_data(client, driver_data, page,
+					       PMBUS_FAN_CONFIG_12, to);
+		if (rv < 0)
+			return rv;
+	}
+
+	rv = _max31785_write_word_data(client, driver_data, page,
+				       PMBUS_FAN_COMMAND_1, command);
+
+	return rv;
+}
+
+static int max31785_pwm_enable(struct i2c_client *client,
+			       struct max31785_data *driver_data, int page,
+			       u16 word)
 {
 	int config = 0;
 	int rate;
@@ -217,18 +350,23 @@ static int max31785_pwm_enable(struct i2c_client *client, int page,
 		return -EINVAL;
 	}
 
-	return pmbus_update_fan(client, page, 0, config, PB_FAN_1_RPM, rate);
+	return max31785_update_fan(client, driver_data, page, config,
+				   PB_FAN_1_RPM, rate);
 }
 
 static int max31785_write_word_data(struct i2c_client *client, int page,
 				    int reg, u16 word)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct max31785_data *driver_data = to_max31785_data(info);
+
 	switch (reg) {
 	case PMBUS_VIRT_PWM_1:
-		return pmbus_update_fan(client, page, 0, 0, PB_FAN_1_RPM,
-					max31785_scale_pwm(word));
+		return max31785_update_fan(client, driver_data, page, 0,
+					   PB_FAN_1_RPM,
+					   max31785_scale_pwm(word));
 	case PMBUS_VIRT_PWM_ENABLE_1:
-		return max31785_pwm_enable(client, page, word);
+		return max31785_pwm_enable(client, driver_data, page, word);
 	default:
 		break;
 	}
@@ -303,13 +441,16 @@ static int max31785_configure_dual_tach(struct i2c_client *client,
 {
 	int ret;
 	int i;
+	struct max31785_data *driver_data = to_max31785_data(info);
 
 	for (i = 0; i < MAX31785_NR_FAN_PAGES; i++) {
-		ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
+		ret = max31785_i2c_write_byte_data(client, driver_data,
+						   PMBUS_PAGE, i);
 		if (ret < 0)
 			return ret;
 
-		ret = i2c_smbus_read_word_data(client, MFR_FAN_CONFIG);
+		ret = max31785_i2c_read_word_data(client, driver_data,
+						  MFR_FAN_CONFIG);
 		if (ret < 0)
 			return ret;
 
@@ -329,6 +470,7 @@ static int max31785_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct pmbus_driver_info *info;
+	struct max31785_data *driver_data;
 	bool dual_tach = false;
 	int ret;
 
@@ -337,13 +479,16 @@ static int max31785_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	info = devm_kzalloc(dev, sizeof(struct pmbus_driver_info), GFP_KERNEL);
-	if (!info)
+	driver_data = devm_kzalloc(dev, sizeof(struct max31785_data), GFP_KERNEL);
+	if (!driver_data)
 		return -ENOMEM;
 
+	info = &driver_data->info;
+	driver_data->access = ktime_get();
 	*info = max31785_info;
 
-	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 255);
+	ret = max31785_i2c_write_byte_data(client, driver_data,
+					   PMBUS_PAGE, 255);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.2

