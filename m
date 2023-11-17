Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE47EF437
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346086AbjKQOOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjKQOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:14:08 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59A5C5;
        Fri, 17 Nov 2023 06:14:04 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AH8IefL017599;
        Fri, 17 Nov 2023 08:13:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=4HaIFMTOjpP+Ms2WViMv3zP8mKWXp14xrqThpoI5Tmk=; b=
        FebCxSaQtqPSDYbKMC77pRdLXoRez4P7O1oVYAGS7pT5SjmZUA8KdUtrU6gX83+I
        2Sj71ZYCZhm5LKl/lMbU1AhiAI25JhGSElRrEa27y9BzN1DEvg84I1eYterw3Fff
        LSOL0MCGn7xkT+P2ivcS76BZU2lhj3YmvLXN76BnCue/8GftIHoXkLQMnOrVs7/E
        xB50SCwn4KfgWy+768+WUGh58Krv3yB/GAL4ywhPFrIj5M2gb/XM1YIMpXxkYmdz
        c/MUTCsWwPWSSTyk5u5JYEPMvvdEzg2p4vLzq4g2G6dgUI122SyFKwplKjO+BQ31
        ybzgiSOa6ERXIkEF7VhwRw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ua7w2qj86-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 08:13:51 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 14:13:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Fri, 17 Nov 2023 14:13:47 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0C35F15A0;
        Fri, 17 Nov 2023 14:13:47 +0000 (UTC)
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH 5/7] ASoC: cs43130: Add handling of ACPI
Date:   Fri, 17 Nov 2023 14:13:42 +0000
Message-ID: <20231117141344.64320-6-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nuMHCH6S8fiWExjsj0QBkDLoHuYHp88z
X-Proofpoint-GUID: nuMHCH6S8fiWExjsj0QBkDLoHuYHp88z
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 sound/soc/codecs/cs43130.c | 44 ++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 447abbaa6f47..fd39328579fb 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -2400,14 +2400,12 @@ static const u16 cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
 	120,
 };
 
-static int cs43130_handle_device_data(struct i2c_client *i2c_client,
-				      struct cs43130_private *cs43130)
+static int cs43130_handle_device_data(struct cs43130_private *cs43130)
 {
-	struct device_node *np = i2c_client->dev.of_node;
 	unsigned int val;
 	int i;
 
-	if (of_property_read_u32(np, "cirrus,xtal-ibias", &val) < 0) {
+	if (device_property_read_u32(cs43130->dev, "cirrus,xtal-ibias", &val) < 0) {
 		/* Crystal is unused. System clock is used for external MCLK */
 		cs43130->xtal_ibias = CS43130_XTAL_UNUSED;
 		return 0;
@@ -2429,18 +2427,18 @@ static int cs43130_handle_device_data(struct i2c_client *i2c_client,
 		return -EINVAL;
 	}
 
-	cs43130->dc_meas = of_property_read_bool(np, "cirrus,dc-measure");
-	cs43130->ac_meas = of_property_read_bool(np, "cirrus,ac-measure");
+	cs43130->dc_meas = device_property_read_bool(cs43130->dev, "cirrus,dc-measure");
+	cs43130->ac_meas = device_property_read_bool(cs43130->dev, "cirrus,ac-measure");
 
-	if (of_property_read_u16_array(np, "cirrus,ac-freq", cs43130->ac_freq,
-					CS43130_AC_FREQ) < 0) {
+	if (!device_property_read_u16_array(cs43130->dev, "cirrus,ac-freq", cs43130->ac_freq,
+					CS43130_AC_FREQ)) {
 		for (i = 0; i < CS43130_AC_FREQ; i++)
 			cs43130->ac_freq[i] = cs43130_ac_freq[i];
 	}
 
-	if (of_property_read_u16_array(np, "cirrus,dc-threshold",
+	if (!device_property_read_u16_array(cs43130->dev, "cirrus,dc-threshold",
 				       cs43130->dc_threshold,
-				       CS43130_DC_THRESHOLD) < 0) {
+				       CS43130_DC_THRESHOLD)) {
 		for (i = 0; i < CS43130_DC_THRESHOLD; i++)
 			cs43130->dc_threshold[i] = cs43130_dc_threshold[i];
 	}
@@ -2469,11 +2467,12 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	if (cs43130->dev->of_node) {
-		ret = cs43130_handle_device_data(client, cs43130);
+	if (dev_fwnode(cs43130->dev)) {
+		ret = cs43130_handle_device_data(cs43130);
 		if (ret != 0)
 			return ret;
 	}
+
 	for (i = 0; i < ARRAY_SIZE(cs43130->supplies); i++)
 		cs43130->supplies[i].supply = cs43130_supply_names[i];
 
@@ -2704,6 +2703,7 @@ static const struct dev_pm_ops cs43130_runtime_pm = {
 			   NULL)
 };
 
+#if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id cs43130_of_match[] = {
 	{.compatible = "cirrus,cs43130",},
 	{.compatible = "cirrus,cs4399",},
@@ -2713,6 +2713,17 @@ static const struct of_device_id cs43130_of_match[] = {
 };
 
 MODULE_DEVICE_TABLE(of, cs43130_of_match);
+#endif
+
+#if IS_ENABLED(CONFIG_ACPI)
+static const struct acpi_device_id cs43130_acpi_match[] = {
+	{ "CSC4399", 0 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(acpi, cs43130_acpi_match);
+#endif
+
 
 static const struct i2c_device_id cs43130_i2c_id[] = {
 	{"cs43130", 0},
@@ -2726,9 +2737,10 @@ MODULE_DEVICE_TABLE(i2c, cs43130_i2c_id);
 
 static struct i2c_driver cs43130_i2c_driver = {
 	.driver = {
-		.name		= "cs43130",
-		.of_match_table	= cs43130_of_match,
-		.pm             = &cs43130_runtime_pm,
+		.name			= "cs43130",
+		.of_match_table		= of_match_ptr(cs43130_of_match),
+		.acpi_match_table	= ACPI_PTR(cs43130_acpi_match),
+		.pm			= &cs43130_runtime_pm,
 	},
 	.id_table	= cs43130_i2c_id,
 	.probe		= cs43130_i2c_probe,
-- 
2.34.1

