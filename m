Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2F7FEE58
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbjK3L5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjK3L5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:57:12 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9532C1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:57:17 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AU794XJ032229;
        Thu, 30 Nov 2023 05:57:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=N
        tFQuocGttnIajSdKYSpTCmuQEI2QHar+zUsgsyY7YE=; b=B4vlZeXTFgRbE2KvY
        znsFGnEAAf5O+q9mR8147PdVonDLrTlLRhTx20IkuSFH6+Ep1W4fCNbS2QoSyNDN
        +4me/IgKXVLFDvn+p/V4ILaAbZBGniz8njKmVEFrAO3cSxTmG9G7uX4iNaUnP9w+
        IM67lDgNbrnlwuMMWIFzARwH/VAvkY9m4DmFfL42KQS5/EB4GLQM1MkWHrJgYOiA
        9USARlZS6XH6f65wfUU4w562LKNukIaDseL/wH/0duV/Q7Izca5qjclOa8MYSN0S
        FucfLfEV/6os3XLi4xBEN5u89FcG90hT40bic47XCpT3U5dOZ9wTsyKa8x1SiN6z
        a1EUQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3unvhpa1rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 05:57:14 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 30 Nov
 2023 11:57:12 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Thu, 30 Nov 2023 11:57:12 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5EDB2B12;
        Thu, 30 Nov 2023 11:57:12 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] mfd: cs42l43: Correct SoundWire port list
Date:   Thu, 30 Nov 2023 11:57:11 +0000
Message-ID: <20231130115712.669180-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xWXFMxnVYq85dCEUvwsZxKy7rG9xeM_3
X-Proofpoint-ORIG-GUID: xWXFMxnVYq85dCEUvwsZxKy7rG9xeM_3
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two ports are missing from the port list, and the wrong port is set
to 4 channels. Also the attempt to list them by function is rather
misguided, there is nothing in the hardware that fixes a particular
port to one function. Factor out the port properties to an actual
struct, fixing the missing ports and correcting the port set to 4
channels.

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Generate the port mask from the port list rather than the other way
   around.

Thanks,
Charles

 drivers/mfd/cs42l43-sdw.c | 74 +++++++++++++++------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/drivers/mfd/cs42l43-sdw.c b/drivers/mfd/cs42l43-sdw.c
index 7392b3d2e6b96..4be4df9dd8cf1 100644
--- a/drivers/mfd/cs42l43-sdw.c
+++ b/drivers/mfd/cs42l43-sdw.c
@@ -17,13 +17,12 @@
 
 #include "cs42l43.h"
 
-enum cs42l43_sdw_ports {
-	CS42L43_DMIC_DEC_ASP_PORT = 1,
-	CS42L43_SPK_TX_PORT,
-	CS42L43_SPDIF_HP_PORT,
-	CS42L43_SPK_RX_PORT,
-	CS42L43_ASP_PORT,
-};
+#define CS42L43_SDW_PORT(port, chans) { \
+	.num = port, \
+	.max_ch = chans, \
+	.type = SDW_DPN_FULL, \
+	.max_word = 24, \
+}
 
 static const struct regmap_config cs42l43_sdw_regmap = {
 	.reg_bits		= 32,
@@ -42,65 +41,48 @@ static const struct regmap_config cs42l43_sdw_regmap = {
 	.num_reg_defaults	= ARRAY_SIZE(cs42l43_reg_default),
 };
 
+static const struct sdw_dpn_prop cs42l43_src_port_props[] = {
+	CS42L43_SDW_PORT(1, 4),
+	CS42L43_SDW_PORT(2, 2),
+	CS42L43_SDW_PORT(3, 2),
+	CS42L43_SDW_PORT(4, 2),
+};
+
+static const struct sdw_dpn_prop cs42l43_sink_port_props[] = {
+	CS42L43_SDW_PORT(5, 2),
+	CS42L43_SDW_PORT(6, 2),
+	CS42L43_SDW_PORT(7, 2),
+};
+
 static int cs42l43_read_prop(struct sdw_slave *sdw)
 {
 	struct sdw_slave_prop *prop = &sdw->prop;
 	struct device *dev = &sdw->dev;
-	struct sdw_dpn_prop *dpn;
-	unsigned long addr;
-	int nval;
 	int i;
-	u32 bit;
 
 	prop->use_domain_irq = true;
 	prop->paging_support = true;
 	prop->wake_capable = true;
-	prop->source_ports = BIT(CS42L43_DMIC_DEC_ASP_PORT) | BIT(CS42L43_SPK_TX_PORT);
-	prop->sink_ports = BIT(CS42L43_SPDIF_HP_PORT) |
-			   BIT(CS42L43_SPK_RX_PORT) | BIT(CS42L43_ASP_PORT);
 	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY |
 			      SDW_SCP_INT1_IMPL_DEF;
 
-	nval = hweight32(prop->source_ports);
-	prop->src_dpn_prop = devm_kcalloc(dev, nval, sizeof(*prop->src_dpn_prop),
-					  GFP_KERNEL);
+	for (i = 0; i < ARRAY_SIZE(cs42l43_src_port_props); i++)
+		prop->source_ports |= BIT(cs42l43_src_port_props[i].num);
+
+	prop->src_dpn_prop = devm_kmemdup(dev, cs42l43_src_port_props,
+					  sizeof(cs42l43_src_port_props), GFP_KERNEL);
 	if (!prop->src_dpn_prop)
 		return -ENOMEM;
 
-	i = 0;
-	dpn = prop->src_dpn_prop;
-	addr = prop->source_ports;
-	for_each_set_bit(bit, &addr, 32) {
-		dpn[i].num = bit;
-		dpn[i].max_ch = 2;
-		dpn[i].type = SDW_DPN_FULL;
-		dpn[i].max_word = 24;
-		i++;
-	}
-	/*
-	 * All ports are 2 channels max, except the first one,
-	 * CS42L43_DMIC_DEC_ASP_PORT.
-	 */
-	dpn[CS42L43_DMIC_DEC_ASP_PORT].max_ch = 4;
+	for (i = 0; i < ARRAY_SIZE(cs42l43_sink_port_props); i++)
+		prop->sink_ports |= BIT(cs42l43_sink_port_props[i].num);
 
-	nval = hweight32(prop->sink_ports);
-	prop->sink_dpn_prop = devm_kcalloc(dev, nval, sizeof(*prop->sink_dpn_prop),
-					   GFP_KERNEL);
+	prop->sink_dpn_prop = devm_kmemdup(dev, cs42l43_sink_port_props,
+					   sizeof(cs42l43_sink_port_props), GFP_KERNEL);
 	if (!prop->sink_dpn_prop)
 		return -ENOMEM;
 
-	i = 0;
-	dpn = prop->sink_dpn_prop;
-	addr = prop->sink_ports;
-	for_each_set_bit(bit, &addr, 32) {
-		dpn[i].num = bit;
-		dpn[i].max_ch = 2;
-		dpn[i].type = SDW_DPN_FULL;
-		dpn[i].max_word = 24;
-		i++;
-	}
-
 	return 0;
 }
 
-- 
2.39.2

