Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8017CA5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjJPKlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjJPKka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:40:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBF1FD;
        Mon, 16 Oct 2023 03:40:27 -0700 (PDT)
X-UUID: 654adbb26c1011eea33bb35ae8d461a2-20231016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pacP5LZW3vzgC3Z6DBMZenKCut8yM7RX/yjXv/4OVzw=;
        b=PtoTTIIqtCDQ+HqXZ2KX6Cc66OiaS80+YE6PkCIyA91B0A+6GnvycXEVQLrjwwe7vT1boq1uMCbkO7+BdY+27vVxetof+Zwfdh2e9V25aWxjUJqYF2contvQ9Nwa4zymystIdsEDSiBGUEO9q8ZHpeUlTXU6LYNOJ/o1ra2VBW0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:021059f3-b1fe-497c-82d8-b731fd3ef918,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:6dfad8f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 654adbb26c1011eea33bb35ae8d461a2-20231016
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2064593984; Mon, 16 Oct 2023 18:40:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Oct 2023 18:40:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Oct 2023 18:40:15 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "CK Hu" <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Fei Shao <fshao@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Johnson Wang <johnson.wang@mediatek.corp-partner.google.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        "Hsiao Chien Sung" <shawn.sung@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 15/23] drm/mediatek: Manage component's clock with function pointers
Date:   Mon, 16 Oct 2023 18:40:02 +0800
Message-ID: <20231016104010.3270-16-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231016104010.3270-1-shawn.sung@mediatek.com>
References: <20231016104010.3270-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.901800-8.000000
X-TMASE-MatchedRID: uYOEf1I6Oo0b7D0aLEL5Ob2xWbKjBfWPy1y/jIuoZZ4x3z93vsEFGlaP
        6AhhdqyDkPk8oBU71Swz42d4hTjtM6h+3Rlbev+JkDpLRKO9xhSZ2scyRQcer19eTSR8I6du4uR
        3pP7Rlrc+1MUqk5HN+7u2F2cs3EHUIkzJoP2DD5eeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8hxKp
        vEGAbTDh+5h3eNot2ZG8Y/G3RLR859ZCE9NdYEbRO7t5IIJTe1RMmnt19ykuB8R3mNYe3fpq6mF
        oav3WmOgh/JX3cyUSn6kLGPI+Kv2HmVKZusLp922v9OjYWA2uMMswg45VMfPXY3pGDmoik6
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.901800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: C04CEED41E5EC516CA8FC0E34D4BF764B2D156B564F778A8E166FF70A9A835902000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By registering component related functions to the pointers,
we can easily manage them within a for-loop and simplify the
logic of clock control significantly.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 111 +++++++-----------
 1 file changed, 44 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 60e5dfe9ef0d..fffef2a4f919 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -53,6 +53,7 @@ struct ovl_adaptor_comp_match {
 	enum mtk_ovl_adaptor_comp_type type;
 	enum mtk_ddp_comp_id comp_id;
 	int alias_id;
+	const struct mtk_ddp_comp_funcs *funcs;
 };
 
 struct mtk_disp_ovl_adaptor {
@@ -67,20 +68,35 @@ static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
 	[OVL_ADAPTOR_TYPE_MERGE]	= "merge",
 };
 
+static const struct mtk_ddp_comp_funcs _ethdr = {
+	.clk_enable = mtk_ethdr_clk_enable,
+	.clk_disable = mtk_ethdr_clk_disable,
+};
+
+static const struct mtk_ddp_comp_funcs _merge = {
+	.clk_enable = mtk_merge_clk_enable,
+	.clk_disable = mtk_merge_clk_disable,
+};
+
+static const struct mtk_ddp_comp_funcs _rdma = {
+	.clk_enable = mtk_mdp_rdma_clk_enable,
+	.clk_disable = mtk_mdp_rdma_clk_disable,
+};
+
 static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_MAX] = {
-	[OVL_ADAPTOR_ETHDR0] = { OVL_ADAPTOR_TYPE_ETHDR, DDP_COMPONENT_ETHDR_MIXER, 0 },
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
+	[OVL_ADAPTOR_ETHDR0] = { OVL_ADAPTOR_TYPE_ETHDR, DDP_COMPONENT_ETHDR_MIXER, 0, &_ethdr },
+	[OVL_ADAPTOR_MDP_RDMA0] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA0, 0, &_rdma },
+	[OVL_ADAPTOR_MDP_RDMA1] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA1, 1, &_rdma },
+	[OVL_ADAPTOR_MDP_RDMA2] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA2, 2, &_rdma },
+	[OVL_ADAPTOR_MDP_RDMA3] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA3, 3, &_rdma },
+	[OVL_ADAPTOR_MDP_RDMA4] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA4, 4, &_rdma },
+	[OVL_ADAPTOR_MDP_RDMA5] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA5, 5, &_rdma },
+	[OVL_ADAPTOR_MDP_RDMA6] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA6, 6, &_rdma },
+	[OVL_ADAPTOR_MDP_RDMA7] = { OVL_ADAPTOR_TYPE_MDP_RDMA, DDP_COMPONENT_MDP_RDMA7, 7, &_rdma },
+	[OVL_ADAPTOR_MERGE0] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE1, 1, &_merge },
+	[OVL_ADAPTOR_MERGE1] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE2, 2, &_merge },
+	[OVL_ADAPTOR_MERGE2] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE3, 3, &_merge },
+	[OVL_ADAPTOR_MERGE3] = { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_MERGE4, 4, &_merge },
 };
 
 void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
@@ -186,73 +202,34 @@ void mtk_ovl_adaptor_stop(struct device *dev)
 
 int mtk_ovl_adaptor_clk_enable(struct device *dev)
 {
-	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
-	struct device *comp;
-	int ret;
 	int i;
-
-	for (i = 0; i < OVL_ADAPTOR_MERGE0; i++) {
-		comp = ovl_adaptor->ovl_adaptor_comp[i];
-		ret = pm_runtime_get_sync(comp);
-		if (ret < 0) {
-			dev_err(dev, "Failed to enable power domain %d, err %d\n", i, ret);
-			goto pwr_err;
-		}
-	}
+	int ret;
+	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
 
 	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
-		comp = ovl_adaptor->ovl_adaptor_comp[i];
-
-		if (i < OVL_ADAPTOR_MERGE0)
-			ret = mtk_mdp_rdma_clk_enable(comp);
-		else if (i < OVL_ADAPTOR_ETHDR0)
-			ret = mtk_merge_clk_enable(comp);
-		else
-			ret = mtk_ethdr_clk_enable(comp);
+		dev = ovl_adaptor->ovl_adaptor_comp[i];
+		if (!dev)
+			continue;
+		ret = comp_matches[i].funcs->clk_enable(dev);
 		if (ret) {
-			dev_err(dev, "Failed to enable clock %d, err %d\n", i, ret);
-			goto clk_err;
+			while (--i >= 0)
+				comp_matches[i].funcs->clk_disable(dev);
+			return ret;
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
-	while (--i >= 0)
-		pm_runtime_put(ovl_adaptor->ovl_adaptor_comp[i]);
-
-	return ret;
+	return 0;
 }
 
 void mtk_ovl_adaptor_clk_disable(struct device *dev)
 {
-	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
-	struct device *comp;
 	int i;
+	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
 
 	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
-		comp = ovl_adaptor->ovl_adaptor_comp[i];
-
-		if (i < OVL_ADAPTOR_MERGE0) {
-			mtk_mdp_rdma_clk_disable(comp);
-			pm_runtime_put(comp);
-		} else if (i < OVL_ADAPTOR_ETHDR0) {
-			mtk_merge_clk_disable(comp);
-		} else {
-			mtk_ethdr_clk_disable(comp);
-		}
+		dev = ovl_adaptor->ovl_adaptor_comp[i];
+		if (!dev)
+			continue;
+		comp_matches[i].funcs->clk_disable(dev);
 	}
 }
 
-- 
2.18.0

