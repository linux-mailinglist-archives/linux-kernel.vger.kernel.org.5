Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EB779A1B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjIKDRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjIKDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:16:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB623110
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:16:49 -0700 (PDT)
X-UUID: a14dbd08505111eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0C3N7fE/tvZGh5zMmznktAGbJMG4wluUCFEK7cRhxCs=;
        b=gY9ZB09CYFzkcomBcbLbka3K/XE1keAnqdgMCLhPfcU+TsWoPWjH2TORpNqql/W7SzqA083KSEMMGJv2Bhj4gMZoGMQHHtNwStBb+jM0qOaXTpsTJ+wFzmDjtGFrd4tIz+j+0MCdKTqiyIAOt5h4qSQu8koFuCnfcRM5LwcxzV0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:cbf67473-0d65-45fd-9901-058218166d08,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:3622c813-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a14dbd08505111eea33bb35ae8d461a2-20230911
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 578485931; Mon, 11 Sep 2023 11:16:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 11:16:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 11:16:40 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v6 16/20] drm/mediatek: Make sure the power-on sequence of LARB and RDMA
Date:   Mon, 11 Sep 2023 11:16:26 +0800
Message-ID: <20230911031630.12613-17-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230911031630.12613-1-shawn.sung@mediatek.com>
References: <20230911031630.12613-1-shawn.sung@mediatek.com>
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

Since LARBs (Local ARBiter) have to be powered on before its users,
to ensure the power-on sequence, we created a device link between
RDMA and its LARB, and when pm_runtime_get_sync is called in RDMA,
system will guarantee the LARB is powered on before the RDMA.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
index c3adaeefd551..fce6fbb534b1 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
@@ -244,10 +244,23 @@ size_t mtk_mdp_rdma_get_num_formats(struct device *dev)

 int mtk_mdp_rdma_clk_enable(struct device *dev)
 {
+	int ret;
 	struct mtk_mdp_rdma *rdma = dev_get_drvdata(dev);

-	clk_prepare_enable(rdma->clk);
-	return 0;
+	/*
+	 * Since LARBs (Local ARBiter) have to be powered on before its users,
+	 * to ensure the power-on sequence, we created a device link between
+	 * RDMA and its LARB, and when pm_runtime_get_sync is called in RDMA,
+	 * system will make sure the LARB is powered on before the RDMA
+	 */
+	ret = pm_runtime_get_sync(dev);
+
+	if (ret < 0)
+		dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
+	else
+		ret = clk_prepare_enable(rdma->clk);
+
+	return ret;
 }

 void mtk_mdp_rdma_clk_disable(struct device *dev)
@@ -255,6 +268,9 @@ void mtk_mdp_rdma_clk_disable(struct device *dev)
 	struct mtk_mdp_rdma *rdma = dev_get_drvdata(dev);

 	clk_disable_unprepare(rdma->clk);
+
+	/* Same reason as when enabling clock, turn the LARB off */
+	pm_runtime_put(dev);
 }

 static int mtk_mdp_rdma_bind(struct device *dev, struct device *master,
--
2.18.0

