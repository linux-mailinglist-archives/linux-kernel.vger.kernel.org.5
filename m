Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B27A5E24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjISJgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjISJf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:35:59 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E43F0;
        Tue, 19 Sep 2023 02:35:53 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38J8INjd008768;
        Tue, 19 Sep 2023 05:35:34 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t5s7kn4hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 05:35:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 38J9ZVLJ054846
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 05:35:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 19 Sep
 2023 05:35:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Sep 2023 05:35:30 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.230])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38J9Z1dA030605;
        Tue, 19 Sep 2023 05:35:22 -0400
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
Subject: [PATCH v4 5/7] hwmon: max31827: Add support for max31828 and max31829
Date:   Tue, 19 Sep 2023 12:34:53 +0300
Message-ID: <20230919093456.10592-5-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919093456.10592-1-daniel.matyas@analog.com>
References: <20230919093456.10592-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 3ubTJ8VRv7rsnRNW8ewvIpTwXmQBufND
X-Proofpoint-ORIG-GUID: 3ubTJ8VRv7rsnRNW8ewvIpTwXmQBufND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309190080
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adi,flt-q and/or adi,alrm-pol are not mentioned,
the default configuration is loaded.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---

v3 -> v4: No change.

v3: Added patch.

 drivers/hwmon/max31827.c | 68 +++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index 2bddca60666d..d4127440ee32 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -46,12 +46,17 @@
 #define MAX31827_12_BIT_CNV_TIME	140
 
 #define MAX31827_ALRM_POL_LOW	0x0
+#define MAX31827_ALRM_POL_HIGH	0x1
+
 #define MAX31827_FLT_Q_1	0x0
+#define MAX31827_FLT_Q_4	0x2
 
 #define MAX31827_16_BIT_TO_M_DGR(x)	(sign_extend32(x, 15) * 1000 / 16)
 #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
 #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
 
+enum chips { max31827, max31828, max31829 };
+
 enum max31827_cnv {
 	MAX31827_CNV_1_DIV_64_HZ = 1,
 	MAX31827_CNV_1_DIV_32_HZ,
@@ -383,12 +388,21 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
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
 				struct fwnode_handle *fwnode)
 {
 	bool prop;
 	u32 data, lsb_idx;
 	unsigned int res = 0;
+	enum chips type;
 	int ret;
 
 	st->enable = true;
@@ -402,6 +416,11 @@ static int max31827_init_client(struct max31827_state *st,
 	prop = fwnode_property_read_bool(fwnode, "adi,timeout-enable");
 	res |= FIELD_PREP(MAX31827_CONFIGURATION_TIMEOUT_MASK, !prop);
 
+	if (st->client->dev.of_node)
+		type = (enum chips)of_device_get_match_data(&st->client->dev);
+	else
+		type = i2c_match_id(max31827_i2c_ids, st->client)->driver_data;
+
 	if (fwnode_property_present(fwnode, "adi,alarm-pol")) {
 		ret = fwnode_property_read_u32(fwnode, "adi,alarm-pol", &data);
 		if (ret)
@@ -409,8 +428,19 @@ static int max31827_init_client(struct max31827_state *st,
 
 		res |= FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK, !!data);
 	} else {
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
@@ -429,8 +459,19 @@ static int max31827_init_client(struct max31827_state *st,
 
 		res |= FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK, lsb_idx);
 	} else {
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
@@ -492,14 +533,19 @@ static int max31827_probe(struct i2c_client *client)
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

