Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D781278F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443293AbjLNGAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjLNF7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:59:47 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261418B;
        Wed, 13 Dec 2023 21:59:01 -0800 (PST)
X-UUID: db22954c9a4511eea5db2bebc7c28f94-20231214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Twmmag5MwvkgiILdQ8ML6Ne9q0reVvpGkR+7v4r1CTw=;
        b=af1/zlILspE0EgFL067PYHHRFFKeiD3KbVVLQenUW5acNj6BuPi9Bzxtlan5ss/VYcqUoQSBg9mbiCpgLjbnIaZbpzxoCGKFPXF9SuNe+8/+eBX2Ht0+udAb4pIBPp0Hft0u3HTVmDjWWVOUwCt3k7UJEsi65Jj66UBuxDqO3Pc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:37caccca-f583-4359-90db-b3d191f3614d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:8b5fc673-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: db22954c9a4511eea5db2bebc7c28f94-20231214
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1560131738; Thu, 14 Dec 2023 13:58:51 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Dec 2023 13:58:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Dec 2023 13:58:50 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        "Roy-CW . Yeh" <roy-cw.yeh@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        xinlei lee <xinlei.lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v12 13/23] drm/mediatek: Manage component's clock with function pointers
Date:   Thu, 14 Dec 2023 13:58:37 +0800
Message-ID: <20231214055847.4936-14-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231214055847.4936-1-shawn.sung@mediatek.com>
References: <20231214055847.4936-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By registering component related functions to the pointers,
we can easily manage them within a for-loop and simplify the
logic of clock control significantly.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 89 +++++++++----------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 9f569d0f52b3..a815dc8e2110 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -54,6 +54,7 @@ struct ovl_adaptor_comp_match {
 	enum mtk_ovl_adaptor_comp_type type;
 	enum mtk_ddp_comp_id comp_id;
 	int alias_id;
+	const struct mtk_ddp_comp_funcs *funcs;
 };
 
 struct mtk_disp_ovl_adaptor {
@@ -68,20 +69,35 @@ static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
 	[OVL_ADAPTOR_TYPE_ETHDR]	= "ethdr",
 };
 
+static const struct mtk_ddp_comp_funcs ethdr = {
+	.clk_enable = mtk_ethdr_clk_enable,
+	.clk_disable = mtk_ethdr_clk_disable,
+};
+
+static const struct mtk_ddp_comp_funcs merge = {
+	.clk_enable = mtk_merge_clk_enable,
+	.clk_disable = mtk_merge_clk_disable,
+};
+
+static const struct mtk_ddp_comp_funcs rdma = {
+	.clk_enable = mtk_mdp_rdma_clk_enable,
+	.clk_disable = mtk_mdp_rdma_clk_disable,
+};
+
 static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_MAX] = {
-	[OVL_ADAPTOR_MDP_RDMA0] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA0, 0 },
-	[OVL_ADAPTOR_MDP_RDMA1] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA1, 1 },
-	[OVL_ADAPTOR_MDP_RDMA2] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA2, 2 },
-	[OVL_ADAPTOR_MDP_RDMA3] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA3, 3 },
-	[OVL_ADAPTOR_MDP_RDMA4] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA4, 4 },
-	[OVL_ADAPTOR_MDP_RDMA5] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA5, 5 },
-	[OVL_ADAPTOR_MDP_RDMA6] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA6, 6 },
-	[OVL_ADAPTOR_MDP_RDMA7] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA7, 7 },
-	[OVL_ADAPTOR_MERGE0] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE1, 1 },
-	[OVL_ADAPTOR_MERGE1] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE2, 2 },
-	[OVL_ADAPTOR_MERGE2] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE3, 3 },
-	[OVL_ADAPTOR_MERGE3] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE4, 4 },
-	[OVL_ADAPTOR_ETHDR0] = { OVL_ADAPTOR_TYPE_ETHDR, DDP_COMPONENT_ETHDR_MIXER, 0 },
+	[OVL_ADAPTOR_MDP_RDMA0] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA0, 0, &rdma },
+	[OVL_ADAPTOR_MDP_RDMA1] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA1, 1, &rdma },
+	[OVL_ADAPTOR_MDP_RDMA2] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA2, 2, &rdma },
+	[OVL_ADAPTOR_MDP_RDMA3] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA3, 3, &rdma },
+	[OVL_ADAPTOR_MDP_RDMA4] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA4, 4, &rdma },
+	[OVL_ADAPTOR_MDP_RDMA5] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA5, 5, &rdma },
+	[OVL_ADAPTOR_MDP_RDMA6] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA6, 6, &rdma },
+	[OVL_ADAPTOR_MDP_RDMA7] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA7, 7, &rdma },
+	[OVL_ADAPTOR_MERGE0] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE1, 1, &merge },
+	[OVL_ADAPTOR_MERGE1] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE2, 2, &merge },
+	[OVL_ADAPTOR_MERGE2] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE3, 3, &merge },
+	[OVL_ADAPTOR_MERGE3] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE4, 4, &merge },
+	[OVL_ADAPTOR_ETHDR0] = { OVL_ADAPTOR_TYPE_ETHDR, DDP_COMPONENT_ETHDR_MIXER, 0, &ethdr },
 };
 
 void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
@@ -197,40 +213,25 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
 		ret = pm_runtime_get_sync(comp);
 		if (ret < 0) {
 			dev_err(dev, "Failed to enable power domain %d, err %d\n", i, ret);
-			goto pwr_err;
+			goto error;
 		}
 	}
 
 	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
 		comp = ovl_adaptor->ovl_adaptor_comp[i];
-
-		if (i < OVL_ADAPTOR_MERGE0)
-			ret = mtk_mdp_rdma_clk_enable(comp);
-		else if (i < OVL_ADAPTOR_ETHDR0)
-			ret = mtk_merge_clk_enable(comp);
-		else
-			ret = mtk_ethdr_clk_enable(comp);
+		if (!comp || !comp_matches[i].funcs->clk_enable)
+			continue;
+		ret = comp_matches[i].funcs->clk_enable(comp);
 		if (ret) {
 			dev_err(dev, "Failed to enable clock %d, err %d\n", i, ret);
-			goto clk_err;
+			while (--i >= 0)
+				comp_matches[i].funcs->clk_disable(comp);
+			i = OVL_ADAPTOR_MERGE0;
+			goto error;
 		}
 	}
-
-	return ret;
-
-clk_err:
-	while (--i >= 0) {
-		comp = ovl_adaptor->ovl_adaptor_comp[i];
-		if (i < OVL_ADAPTOR_MERGE0)
-			mtk_mdp_rdma_clk_disable(comp);
-		else if (i < OVL_ADAPTOR_ETHDR0)
-			mtk_merge_clk_disable(comp);
-		else
-			mtk_ethdr_clk_disable(comp);
-	}
-	i = OVL_ADAPTOR_MERGE0;
-
-pwr_err:
+	return 0;
+error:
 	while (--i >= 0)
 		pm_runtime_put(ovl_adaptor->ovl_adaptor_comp[i]);
 
@@ -245,15 +246,11 @@ void mtk_ovl_adaptor_clk_disable(struct device *dev)
 
 	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
 		comp = ovl_adaptor->ovl_adaptor_comp[i];
-
-		if (i < OVL_ADAPTOR_MERGE0) {
-			mtk_mdp_rdma_clk_disable(comp);
+		if (!comp || !comp_matches[i].funcs->clk_disable)
+			continue;
+		comp_matches[i].funcs->clk_disable(comp);
+		if (i < OVL_ADAPTOR_MERGE0)
 			pm_runtime_put(comp);
-		} else if (i < OVL_ADAPTOR_ETHDR0) {
-			mtk_merge_clk_disable(comp);
-		} else {
-			mtk_ethdr_clk_disable(comp);
-		}
 	}
 }
 
-- 
2.18.0

