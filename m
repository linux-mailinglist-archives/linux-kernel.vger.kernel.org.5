Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC51978F9B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjIAIKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348615AbjIAIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:10:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C0E1708;
        Fri,  1 Sep 2023 01:10:03 -0700 (PDT)
X-UUID: eeb03428489e11eea33bb35ae8d461a2-20230901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JinC7Bb2PVa8HrO1FW4navqRVoz1EFqkU53gUdtyeis=;
        b=ngCLUNKBUjH2Pi6QFdb/duF/seALtDhkIiCM/545NcsuauDhuf2Lypsg69ACkg51tWq+WkZGmdbpkj4TS6nHNE4p/MekFIYNbJncqJJ7H50g0IeUloxD+c7Uo2giuRzoUSTbvmfH+POtkujy3PDUYjvhLdn8kz54Lj731XZbKFg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:6372e511-8c47-45de-9c85-251b6b4a062f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:842d7113-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eeb03428489e11eea33bb35ae8d461a2-20230901
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1475225310; Fri, 01 Sep 2023 16:09:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Sep 2023 16:09:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Sep 2023 16:09:52 +0800
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
Subject: [PATCH v17 09/14] remoteproc: mediatek: Remove dependency of MT8195 SCP L2TCM power control on dual-core SCP
Date:   Fri, 1 Sep 2023 16:09:30 +0800
Message-ID: <20230901080935.14571-10-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230901080935.14571-1-tinghan.shen@mediatek.com>
References: <20230901080935.14571-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, SCP core 0 controlled the power of L2TCM and dictated that
SCP core 1 could only boot after SCP core 0. To address this constraint,
extracted the power control flow of L2TCM and made it shared
between both cores, enabling support for arbitrary boot order.

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
index 685e2c2bb6ee..59d9182a8d1e 100644
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
 
@@ -1108,6 +1147,7 @@ static int scp_probe(struct platform_device *pdev)
 	}
 
 	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
+	mutex_init(&scp_cluster->cluster_lock);
 
 	ret = devm_of_platform_populate(dev);
 	if (ret)
@@ -1131,6 +1171,7 @@ static void scp_remove(struct platform_device *pdev)
 		rproc_del(scp->rproc);
 		scp_free(scp);
 	}
+	mutex_destroy(&scp_cluster->cluster_lock);
 }
 
 static const struct mtk_scp_of_data mt8183_of_data = {
-- 
2.18.0

