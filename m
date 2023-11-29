Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326747FDBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbjK2Pmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbjK2Pmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:42:36 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C9E10CB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:42:40 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AT7p5UF020236;
        Wed, 29 Nov 2023 09:42:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=o
        JfDIgJxIxNVx6DuCUVuoM5WQyc3iSScBpILkDDyjPo=; b=VNtu5uD2Chex/s5I/
        MMp2GYIViTdrFyCZYbi+BwEHgKC5IUhLmAjpDTii10v6cK0L3rwVlHafuEe7Zv3r
        en7GF7KibWqZwJtq8Blaa2iXeHfT6+tSb1OFd9lm22u1j7xEyIBjyhMDJk1NFQ1T
        yvAv7axLQhpWwGrOmYuxE7WwYbAADZrzOAjn0c/VxbPaGaLunhYxRy6X2gVwyvGW
        Lgv3b040aWDkOxcDqizCheqghvdbadC2v3dTPAEO49ebKVmv/N6N1viiUqz/yCUt
        p5F0z2YdEQR+p7ag1/VdLj+cQ0d+Nu7xBEn9X+SaTRfoZ78/sr+5wYQHYdo3Ty2+
        Zx7kA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3unvhp8ngg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 09:42:32 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 29 Nov
 2023 15:42:30 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Wed, 29 Nov 2023 15:42:30 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 55319B38;
        Wed, 29 Nov 2023 15:42:30 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mfd: cs42l43: Correct SoundWire port list
Date:   Wed, 29 Nov 2023 15:42:30 +0000
Message-ID: <20231129154230.470705-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 12Xpb4liXXBBB_e-9lAgRUnQRRq_0l0P
X-Proofpoint-ORIG-GUID: 12Xpb4liXXBBB_e-9lAgRUnQRRq_0l0P
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two ports are missing from the port list, and the wrong port is set
to 4 channels. Also the attempt to list them by function is rather
misguided, there is nothing in the hardware that fixes a particular
port to one function. Fix the missing ports, correct the port set to 4
channels and add a define to get the port mask for each port.

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Use a macro for the ports
 - Add correction to the port being marked as 4 channels

Thanks,
Charles

 drivers/mfd/cs42l43-sdw.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/cs42l43-sdw.c b/drivers/mfd/cs42l43-sdw.c
index 7392b3d2e6b96..96f74f7a318cb 100644
--- a/drivers/mfd/cs42l43-sdw.c
+++ b/drivers/mfd/cs42l43-sdw.c
@@ -17,13 +17,7 @@
 
 #include "cs42l43.h"
 
-enum cs42l43_sdw_ports {
-	CS42L43_DMIC_DEC_ASP_PORT = 1,
-	CS42L43_SPK_TX_PORT,
-	CS42L43_SPDIF_HP_PORT,
-	CS42L43_SPK_RX_PORT,
-	CS42L43_ASP_PORT,
-};
+#define CS42L43_SDW_PORT(port) BIT(port)
 
 static const struct regmap_config cs42l43_sdw_regmap = {
 	.reg_bits		= 32,
@@ -55,9 +49,10 @@ static int cs42l43_read_prop(struct sdw_slave *sdw)
 	prop->use_domain_irq = true;
 	prop->paging_support = true;
 	prop->wake_capable = true;
-	prop->source_ports = BIT(CS42L43_DMIC_DEC_ASP_PORT) | BIT(CS42L43_SPK_TX_PORT);
-	prop->sink_ports = BIT(CS42L43_SPDIF_HP_PORT) |
-			   BIT(CS42L43_SPK_RX_PORT) | BIT(CS42L43_ASP_PORT);
+	prop->source_ports = CS42L43_SDW_PORT(1) | CS42L43_SDW_PORT(2) |
+			     CS42L43_SDW_PORT(3) | CS42L43_SDW_PORT(4);
+	prop->sink_ports = CS42L43_SDW_PORT(5) | CS42L43_SDW_PORT(6) |
+			   CS42L43_SDW_PORT(7);
 	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY |
 			      SDW_SCP_INT1_IMPL_DEF;
@@ -78,11 +73,8 @@ static int cs42l43_read_prop(struct sdw_slave *sdw)
 		dpn[i].max_word = 24;
 		i++;
 	}
-	/*
-	 * All ports are 2 channels max, except the first one,
-	 * CS42L43_DMIC_DEC_ASP_PORT.
-	 */
-	dpn[CS42L43_DMIC_DEC_ASP_PORT].max_ch = 4;
+	/* All ports are 2 channels max, except the first one. */
+	dpn[0].max_ch = 4;
 
 	nval = hweight32(prop->sink_ports);
 	prop->sink_dpn_prop = devm_kcalloc(dev, nval, sizeof(*prop->sink_dpn_prop),
-- 
2.39.2

