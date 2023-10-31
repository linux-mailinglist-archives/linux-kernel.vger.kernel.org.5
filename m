Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A147DD888
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjJaWlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjJaWk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:40:57 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03288F9;
        Tue, 31 Oct 2023 15:40:55 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39VM9GJJ004517;
        Tue, 31 Oct 2023 18:40:40 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3u38jds73p-929
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 18:40:40 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 39VIMI0L034703
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Oct 2023 14:22:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 31 Oct
 2023 14:22:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 31 Oct 2023 14:22:17 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.198])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39VIM1d3022309;
        Tue, 31 Oct 2023 14:22:10 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/5] hwmon: max31827: Add support for max31828 and max31829
Date:   Tue, 31 Oct 2023 20:21:54 +0200
Message-ID: <20231031182158.124608-2-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031182158.124608-1-daniel.matyas@analog.com>
References: <20231031182158.124608-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: aBKzbCIm_ns0zUnHY6Uo3oFg1iP81WHu
X-Proofpoint-ORIG-GUID: aBKzbCIm_ns0zUnHY6Uo3oFg1iP81WHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_09,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2310240000
 definitions=main-2310310186
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Created of_match_table and id_table entries for max31828 and max31829.

When adi,flt-q and/or adi,alrm-pol are not mentioned,
the default configuration is loaded based on the type of the chip.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---

v5 -> v6: Selecting default value for adi,fault-q and adi,alarm-pol with
switch() statement. Used device_get_match_data() to get data more
generally. Now max31827 = 1 in enum.

v4 -> v5: Passed i2c_client to init_client(), because I needed it to
retrieve device id.
Used a simple if to load default configuration. No more switch.

v3 -> v4: No change.

v3: Added patch.

 drivers/hwmon/max31827.c | 64 +++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index bc201a8fcd5b..738ce5ca6e39 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -32,7 +32,9 @@
 #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
 
 #define MAX31827_ALRM_POL_LOW	0x0
+#define MAX31827_ALRM_POL_HIGH	0x1
 #define MAX31827_FLT_Q_1	0x0
+#define MAX31827_FLT_Q_4	0x2
 
 #define MAX31827_12_BIT_CNV_TIME	140
 
@@ -40,6 +42,8 @@
 #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
 #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
 
+enum chips { max31827 = 1, max31828, max31829 };
+
 enum max31827_cnv {
 	MAX31827_CNV_1_DIV_64_HZ = 1,
 	MAX31827_CNV_1_DIV_32_HZ,
@@ -370,12 +374,21 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 	return -EOPNOTSUPP;
 }
 
+static const struct i2c_device_id max31827_i2c_ids[] = {
+	{ "max31827", max31827 },
+	{ "max31828", max31828 },
+	{ "max31829", max31829 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
+
 static int max31827_init_client(struct max31827_state *st,
 				struct device *dev)
 {
 	struct fwnode_handle *fwnode;
 	unsigned int res = 0;
 	u32 data, lsb_idx;
+	enum chips type;
 	bool prop;
 	int ret;
 
@@ -392,6 +405,8 @@ static int max31827_init_client(struct max31827_state *st,
 	prop = fwnode_property_read_bool(fwnode, "adi,timeout-enable");
 	res |= FIELD_PREP(MAX31827_CONFIGURATION_TIMEOUT_MASK, !prop);
 
+	type = (enum chips)(uintptr_t)device_get_match_data(dev);
+
 	if (fwnode_property_present(fwnode, "adi,alarm-pol")) {
 		ret = fwnode_property_read_u32(fwnode, "adi,alarm-pol", &data);
 		if (ret)
@@ -402,8 +417,19 @@ static int max31827_init_client(struct max31827_state *st,
 		/*
 		 * Set default value.
 		 */
-		res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK,
-				  MAX31827_ALRM_POL_LOW);
+		switch (type) {
+		case max31827:
+		case max31828:
+			res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK,
+					  MAX31827_ALRM_POL_LOW);
+			break;
+		case max31829:
+			res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK,
+					  MAX31827_ALRM_POL_HIGH);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 	}
 
 	if (fwnode_property_present(fwnode, "adi,fault-q")) {
@@ -427,8 +453,19 @@ static int max31827_init_client(struct max31827_state *st,
 		/*
 		 * Set default value.
 		 */
-		res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK,
-				  MAX31827_FLT_Q_1);
+		switch (type) {
+		case max31827:
+			res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK,
+					  MAX31827_FLT_Q_1);
+			break;
+		case max31828:
+		case max31829:
+			res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK,
+					  MAX31827_FLT_Q_4);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 	}
 
 	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
@@ -486,14 +523,19 @@ static int max31827_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-static const struct i2c_device_id max31827_i2c_ids[] = {
-	{ "max31827", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
-
 static const struct of_device_id max31827_of_match[] = {
-	{ .compatible = "adi,max31827" },
+	{
+		.compatible = "adi,max31827",
+		.data = (void *)max31827
+	},
+	{
+		.compatible = "adi,max31828",
+		.data = (void *)max31828
+	},
+	{
+		.compatible = "adi,max31829",
+		.data = (void *)max31829
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max31827_of_match);
-- 
2.34.1

