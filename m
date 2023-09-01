Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596AE78F9B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348648AbjIAIKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348619AbjIAIKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:10:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DF210DE;
        Fri,  1 Sep 2023 01:10:03 -0700 (PDT)
X-UUID: ee50cca4489e11ee8051498923ad61e6-20230901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bY347xRJ3bTKnf91ngGP2C+KKqhB/LygiODggUiWE+s=;
        b=bVn2P0bNqgbEG9IUz5rNNF31QjNmZMdkfVtb0cjVP6bBpfgQeRCFUSeJz9NxoC1GP8dMsJzQDCr53BnNdNUx1lx/jF4jr9yGklUivWw2Vmdy8S3NEoRt6zHNMcvPDUjj3PjKgfR0ryrQ8mz9IBl/E/lBGTDsnI+5zPd2296h758=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:b99d9454-256c-4a8c-8e99-785b27a6bc79,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:fd6333ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ee50cca4489e11ee8051498923ad61e6-20230901
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 328595384; Fri, 01 Sep 2023 16:09:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Sep 2023 16:09:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Sep 2023 16:09:53 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Tinghan Shen" <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v17 11/14] remoteproc: mediatek: Handle MT8195 SCP core 1 watchdog timeout
Date:   Fri, 1 Sep 2023 16:09:32 +0800
Message-ID: <20230901080935.14571-12-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230901080935.14571-1-tinghan.shen@mediatek.com>
References: <20230901080935.14571-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8195 SCP core 1 watchdog timeout needs to be handled in the
SCP core 0 IRQ handler because the MT8195 SCP core 1 watchdog timeout
IRQ is wired on the same IRQ entry for core 0 watchdog timeout.
MT8195 SCP has a watchdog status register to identify the watchdog
timeout source when IRQ triggered.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_common.h |  5 +++++
 drivers/remoteproc/mtk_scp.c    | 25 ++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 3d6b53b9f374..6d7736a031f7 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -55,6 +55,10 @@
 #define MT8192_CORE0_WDT_IRQ		0x10030
 #define MT8192_CORE0_WDT_CFG		0x10034
 
+#define MT8195_SYS_STATUS		0x4004
+#define MT8195_CORE0_WDT		BIT(16)
+#define MT8195_CORE1_WDT		BIT(17)
+
 #define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
 
 #define MT8195_CPU1_SRAM_PD			0x1084
@@ -63,6 +67,7 @@
 #define MT8195_CORE1_SW_RSTN_CLR		0x20000
 #define MT8195_CORE1_SW_RSTN_SET		0x20004
 #define MT8195_CORE1_MEM_ATT_PREDEF		0x20008
+#define MT8195_CORE1_WDT_IRQ			0x20030
 #define MT8195_CORE1_WDT_CFG			0x20034
 
 #define MT8195_SEC_CTRL				0x85000
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index db5b15f5f8c1..49b2ca2b30b3 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -222,6 +222,29 @@ static void mt8192_scp_irq_handler(struct mtk_scp *scp)
 	}
 }
 
+static void mt8195_scp_irq_handler(struct mtk_scp *scp)
+{
+	u32 scp_to_host;
+
+	scp_to_host = readl(scp->cluster->reg_base + MT8192_SCP2APMCU_IPC_SET);
+
+	if (scp_to_host & MT8192_SCP_IPC_INT_BIT) {
+		scp_ipi_handler(scp);
+	} else {
+		u32 reason = readl(scp->cluster->reg_base + MT8195_SYS_STATUS);
+
+		if (reason & MT8195_CORE0_WDT)
+			writel(1, scp->cluster->reg_base + MT8192_CORE0_WDT_IRQ);
+
+		if (reason & MT8195_CORE1_WDT)
+			writel(1, scp->cluster->reg_base + MT8195_CORE1_WDT_IRQ);
+
+		scp_wdt_handler(scp, reason);
+	}
+
+	writel(scp_to_host, scp->cluster->reg_base + MT8192_SCP2APMCU_IPC_CLR);
+}
+
 static void mt8195_scp_c1_irq_handler(struct mtk_scp *scp)
 {
 	u32 scp_to_host;
@@ -1255,7 +1278,7 @@ static const struct mtk_scp_of_data mt8192_of_data = {
 static const struct mtk_scp_of_data mt8195_of_data = {
 	.scp_clk_get = mt8195_scp_clk_get,
 	.scp_before_load = mt8195_scp_before_load,
-	.scp_irq_handler = mt8192_scp_irq_handler,
+	.scp_irq_handler = mt8195_scp_irq_handler,
 	.scp_reset_assert = mt8192_scp_reset_assert,
 	.scp_reset_deassert = mt8192_scp_reset_deassert,
 	.scp_stop = mt8195_scp_stop,
-- 
2.18.0

