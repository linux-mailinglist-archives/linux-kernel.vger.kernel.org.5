Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD075BC87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGUCmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGUCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:42:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44BF272E;
        Thu, 20 Jul 2023 19:42:02 -0700 (PDT)
X-UUID: 2614bf56277011eeb20a276fd37b9834-20230721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kAspR0wWeZoliaIV3QvLm4BZEi5TVS59OMJhYgToGBY=;
        b=Ym0WX0ZxrWefhrFOd6i1aWOCpo3aBHqpFoGNOCdtBn+Eiyjw5nqJQIEQC32FW92oNfzXdneC/DPLGJtc2ykUDO9oI7WVzwf/2WoypOXbEbMq84ylxa03jHbhekmtF25zYA/DWc9c1joe1r9UrFPDzeqr/EDwnE9a1x9CGI9VUk0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:f57ffa9c-080b-4eee-9b69-f6d09d75165b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:7c8df44c-06c1-468b-847d-5b62d44dbb9b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2614bf56277011eeb20a276fd37b9834-20230721
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 751393263; Fri, 21 Jul 2023 10:41:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jul 2023 10:41:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jul 2023 10:41:51 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v15 08/13] remoteproc: mediatek: Remove dependency of MT8195 SCP L2TCM power control on dual-core SCP
Date:   Fri, 21 Jul 2023 10:41:27 +0800
Message-ID: <20230721024132.6548-9-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230721024132.6548-1-tinghan.shen@mediatek.com>
References: <20230721024132.6548-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, SCP core 0 controlled the power of L2TCM and dictated that
SCP core 1 could only boot after SCP core 0. To address this constraint,
extracted the power control flow of L2TCM and made it shared
between both cores, enabling support of arbitrary boot order.

The flow for controlling L2TCM power has been incorporated into the
mt8195_scp_before_load() and mt8195_scp_stop() APIs, which are
respectively invoked during the rproc->ops->start() and
rproc->ops->stop() operations. These APIs effectively serve the same
purpose as the rproc prepare()/unprepare() APIs."

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |  3 ++
 drivers/remoteproc/mtk_scp.c    | 71 ++++++++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 1438159ae736..fea05bbba9aa 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -106,6 +106,9 @@ struct mtk_scp_of_cluster {
 	size_t l1tcm_size;
 	phys_addr_t l1tcm_phys;
 	struct list_head mtk_scp_list;
+	/* Prevent concurrent operations of this structure and L2TCM power control. */
+	struct mutex cluster_lock;
+	u32 l2tcm_refcnt;
 };
 
 struct mtk_scp {
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 34095a461e15..c624f9c3db17 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -454,19 +454,37 @@ static int mt8192_scp_before_load(struct mtk_scp *scp)
 	return 0;
 }
 
-static int mt8195_scp_before_load(struct mtk_scp *scp)
+static int mt8195_scp_l2tcm_on(struct mtk_scp *scp)
 {
-	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
-	writel(0xff, scp->cluster->reg_base + MT8192_SCP2SPM_IPC_CLR);
+	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
+
+	mutex_lock(&scp_cluster->cluster_lock);
+
+	if (scp_cluster->l2tcm_refcnt == 0) {
+		/* clear SPM interrupt, SCP2SPM_IPC_CLR */
+		writel(0xff, scp->cluster->reg_base + MT8192_SCP2SPM_IPC_CLR);
+
+		/* Power on L2TCM */
+		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
+		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
+		scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
+		scp_sram_power_on(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN,
+				  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
+	}
+
+	scp_cluster->l2tcm_refcnt += 1;
 
+	mutex_unlock(&scp_cluster->cluster_lock);
+
+	return 0;
+}
+
+static int mt8195_scp_before_load(struct mtk_scp *scp)
+{
 	writel(1, scp->cluster->reg_base + MT8192_CORE0_SW_RSTN_SET);
 
-	/* enable SRAM clock */
-	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
-	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
-	scp_sram_power_on(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
-	scp_sram_power_on(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN,
-			  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
+	mt8195_scp_l2tcm_on(scp);
+
 	scp_sram_power_on(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
 
 	/* enable MPU for all memory regions */
@@ -479,6 +497,8 @@ static int mt8195_scp_c1_before_load(struct mtk_scp *scp)
 {
 	scp->data->scp_reset_assert(scp);
 
+	mt8195_scp_l2tcm_on(scp);
+
 	scp_sram_power_on(scp->cluster->reg_base + MT8195_CPU1_SRAM_PD, 0);
 
 	/* enable MPU for all memory regions */
@@ -645,14 +665,31 @@ static void mt8192_scp_stop(struct mtk_scp *scp)
 	writel(0, scp->cluster->reg_base + MT8192_CORE0_WDT_CFG);
 }
 
+static void mt8195_scp_l2tcm_off(struct mtk_scp *scp)
+{
+	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
+
+	mutex_lock(&scp_cluster->cluster_lock);
+
+	if (scp_cluster->l2tcm_refcnt > 0)
+		scp_cluster->l2tcm_refcnt -= 1;
+
+	if (scp_cluster->l2tcm_refcnt == 0) {
+		/* Power off L2TCM */
+		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
+		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
+		scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
+		scp_sram_power_off(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN,
+				   MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
+	}
+
+	mutex_unlock(&scp_cluster->cluster_lock);
+}
+
 static void mt8195_scp_stop(struct mtk_scp *scp)
 {
-	/* Disable SRAM clock */
-	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
-	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
-	scp_sram_power_off(scp->cluster->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
-	scp_sram_power_off(scp->cluster->reg_base + MT8192_L1TCM_SRAM_PDN,
-			   MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
+	mt8195_scp_l2tcm_off(scp);
+
 	scp_sram_power_off(scp->cluster->reg_base + MT8192_CPU0_SRAM_PD, 0);
 
 	/* Disable SCP watchdog */
@@ -661,6 +698,8 @@ static void mt8195_scp_stop(struct mtk_scp *scp)
 
 static void mt8195_scp_c1_stop(struct mtk_scp *scp)
 {
+	mt8195_scp_l2tcm_off(scp);
+
 	/* Power off CPU SRAM */
 	scp_sram_power_off(scp->cluster->reg_base + MT8195_CPU1_SRAM_PD, 0);
 
@@ -1103,6 +1142,7 @@ static int scp_probe(struct platform_device *pdev)
 	}
 
 	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
+	mutex_init(&scp_cluster->cluster_lock);
 
 	ret = devm_of_platform_populate(dev);
 	if (ret)
@@ -1126,6 +1166,7 @@ static void scp_remove(struct platform_device *pdev)
 		rproc_del(scp->rproc);
 		scp_free(scp);
 	}
+	mutex_destroy(&scp_cluster->cluster_lock);
 }
 
 static const struct mtk_scp_of_data mt8183_of_data = {
-- 
2.18.0

