Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97457D8DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjJ0ErH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0ErE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:47:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1D8186;
        Thu, 26 Oct 2023 21:47:01 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R4eESi011634;
        Fri, 27 Oct 2023 04:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JEai+xYL0exRitVg/sATL2GEvvL4tkPSvlWMqOUgntY=;
 b=dB1w85NRza8q4TQFBD6c1fhco5ZuA47jT/zpxL3JQpAlJja3c7yM1HgCHOjC0wQwUW1c
 2vDmTReo1cNVQm83Mg5cygelEoBPA+hVKjxjrpsMYCsvYWSy/Ghr17Umd6OOc3J9e9uk
 FXYLhP5v4feGJI5mBONjBAd6qnntZb37fem0JE4ic6zt52Ag9EGhyRCKosO4nSIiHNYr
 /JDOInYgUmVgdQ+9BMUELLX502MgXFsroipIRes77rAHzwDgMadgm8Luyu3+QYH7ljIU
 qlC6lN5lABVzQrfBNXU65D+j/lS9flwcTc+4Uvs8MN2K1UhEIyjMZK5Cl+wtvVw/9uxO Gw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u06cjr2c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 04:46:39 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39R4Swhf025046;
        Fri, 27 Oct 2023 04:43:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tywqrtpaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 04:43:49 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39R4hn4V36831614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 04:43:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E37E858055;
        Fri, 27 Oct 2023 04:43:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C644F58043;
        Fri, 27 Oct 2023 04:43:48 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 27 Oct 2023 04:43:48 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 2D012740051; Thu, 26 Oct 2023 23:43:48 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] hwmon: (pmbus/max31785) Add delay between bus accesses
Date:   Thu, 26 Oct 2023 23:43:46 -0500
Message-Id: <20231027044346.2167548-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: okRMIwo0kr5tdEnefdEozrK6s3joAzUG
X-Proofpoint-ORIG-GUID: okRMIwo0kr5tdEnefdEozrK6s3joAzUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_02,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270040
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
V4 -> V5: Changed udelay() to usleep_range() 
V3 -> V4: Fixed warnings related to this commit
V2 -> V3: Fixed the commit message
V1 -> V2:
- Changed the max31785_wait macro to a function, following the conventions
  used in other drivers that had the same issue.
- Changed the function names from max31785_i2c_smbus* to max31785_i2c_* and
  from max31785_pmbus_* to _max31785_*, making them more concise.

 drivers/hwmon/pmbus/max31785.c | 188 +++++++++++++++++++++++++++++----
 1 file changed, 167 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/pmbus/max31785.c b/drivers/hwmon/pmbus/max31785.c
index f9aa576495a5..5d13bbfc8f47 100644
--- a/drivers/hwmon/pmbus/max31785.c
+++ b/drivers/hwmon/pmbus/max31785.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 IBM Corp.
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -23,19 +24,119 @@ enum max31785_regs {
 
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
+		usleep_range(MAX31785_WAIT_DELAY_US - delta,
+			     MAX31785_WAIT_DELAY_US);
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
@@ -102,16 +203,19 @@ static int max31785_get_pwm(struct i2c_client *client, int page)
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
 
@@ -129,6 +233,8 @@ static int max31785_get_pwm_mode(struct i2c_client *client, int page)
 static int max31785_read_word_data(struct i2c_client *client, int page,
 				   int phase, int reg)
 {
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct max31785_data *driver_data = to_max31785_data(info);
 	u32 val;
 	int rv;
 
@@ -157,7 +263,7 @@ static int max31785_read_word_data(struct i2c_client *client, int page,
 		rv = max31785_get_pwm(client, page);
 		break;
 	case PMBUS_VIRT_PWM_ENABLE_1:
-		rv = max31785_get_pwm_mode(client, page);
+		rv = max31785_get_pwm_mode(client, driver_data, page);
 		break;
 	default:
 		rv = -ENODATA;
@@ -188,8 +294,36 @@ static inline u32 max31785_scale_pwm(u32 sensor_val)
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
@@ -217,18 +351,23 @@ static int max31785_pwm_enable(struct i2c_client *client, int page,
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
@@ -303,13 +442,16 @@ static int max31785_configure_dual_tach(struct i2c_client *client,
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
 
@@ -329,6 +471,7 @@ static int max31785_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct pmbus_driver_info *info;
+	struct max31785_data *driver_data;
 	bool dual_tach = false;
 	int ret;
 
@@ -337,13 +480,16 @@ static int max31785_probe(struct i2c_client *client)
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

