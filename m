Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497EB7E9F74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjKMPCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKMPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:02:35 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E01A6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:02:32 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ADBm2NR010353;
        Mon, 13 Nov 2023 09:02:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=b
        T2cvUALCr2mMqdFMGZ2tjqVY+gzP0v0q78ZiKI5mS8=; b=bL9qBvWc6yvuR50BY
        ZSS+pBS6m9bAvIlW6DRnRoHkFGFOOKqCAWR4DKAPgY6WTVCB+L/dO6+Jy+i20aDr
        r7uez1d0HDk65XeygwnXqf7Jt0Zs+/C/IxOGd0u8fFGZhuMfDLrLCSi0QlXMyYd+
        eOj2ka1wxLkB0hEFffUGedNIrRSz3qCt6kHImUqnJRPVJdzNXq8WkMZ8GAhIVfuR
        pZdZ8+vw7yE/mVt5SAtS7t6ehsYiBDQuWN/e2mmQqSDFUvQWm8U8Be46xIoXRaor
        V04QZLLFrL6jw2RuZ1VphndjY3pTcrWfuoP4X5+9h044wpvihZ2cHaE2T+bYCE+c
        AnQDQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ua6wpa05h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 09:02:22 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 13 Nov
 2023 15:02:20 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Mon, 13 Nov 2023 15:02:20 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 76AFA11A8;
        Mon, 13 Nov 2023 15:02:20 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: cs42l43: Correct SoundWire port list
Date:   Mon, 13 Nov 2023 15:02:20 +0000
Message-ID: <20231113150220.1472294-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sBuuQEMPcXTqsCaYhD7kLAMkpOP7nb-w
X-Proofpoint-ORIG-GUID: sBuuQEMPcXTqsCaYhD7kLAMkpOP7nb-w
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two ports are missing from the port list. Also the attempt to list
them by function is rather misguided, there is nothing in the hardware
that fixes a particular port to one function. Fix the missing ports
and change to just listing them by the DPx naming scheme that is used
throughout the rest of the driver.

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43-sdw.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/cs42l43-sdw.c b/drivers/mfd/cs42l43-sdw.c
index 7392b3d2e6b96..6d67020396fb5 100644
--- a/drivers/mfd/cs42l43-sdw.c
+++ b/drivers/mfd/cs42l43-sdw.c
@@ -18,11 +18,13 @@
 #include "cs42l43.h"
 
 enum cs42l43_sdw_ports {
-	CS42L43_DMIC_DEC_ASP_PORT = 1,
-	CS42L43_SPK_TX_PORT,
-	CS42L43_SPDIF_HP_PORT,
-	CS42L43_SPK_RX_PORT,
-	CS42L43_ASP_PORT,
+	CS42L43_DP1 = 1,
+	CS42L43_DP2,
+	CS42L43_DP3,
+	CS42L43_DP4,
+	CS42L43_DP5,
+	CS42L43_DP6,
+	CS42L43_DP7,
 };
 
 static const struct regmap_config cs42l43_sdw_regmap = {
@@ -55,9 +57,9 @@ static int cs42l43_read_prop(struct sdw_slave *sdw)
 	prop->use_domain_irq = true;
 	prop->paging_support = true;
 	prop->wake_capable = true;
-	prop->source_ports = BIT(CS42L43_DMIC_DEC_ASP_PORT) | BIT(CS42L43_SPK_TX_PORT);
-	prop->sink_ports = BIT(CS42L43_SPDIF_HP_PORT) |
-			   BIT(CS42L43_SPK_RX_PORT) | BIT(CS42L43_ASP_PORT);
+	prop->source_ports = BIT(CS42L43_DP1) | BIT(CS42L43_DP2) |
+			     BIT(CS42L43_DP3) | BIT(CS42L43_DP4);
+	prop->sink_ports = BIT(CS42L43_DP5) | BIT(CS42L43_DP6) | BIT(CS42L43_DP7);
 	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY |
 			      SDW_SCP_INT1_IMPL_DEF;
@@ -78,11 +80,8 @@ static int cs42l43_read_prop(struct sdw_slave *sdw)
 		dpn[i].max_word = 24;
 		i++;
 	}
-	/*
-	 * All ports are 2 channels max, except the first one,
-	 * CS42L43_DMIC_DEC_ASP_PORT.
-	 */
-	dpn[CS42L43_DMIC_DEC_ASP_PORT].max_ch = 4;
+	/* All ports are 2 channels max, except the first one. */
+	dpn[CS42L43_DP1].max_ch = 4;
 
 	nval = hweight32(prop->sink_ports);
 	prop->sink_dpn_prop = devm_kcalloc(dev, nval, sizeof(*prop->sink_dpn_prop),
-- 
2.39.2

