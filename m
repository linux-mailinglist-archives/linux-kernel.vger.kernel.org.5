Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B6D79C911
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjILH7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjILH6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:58:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF46710DC;
        Tue, 12 Sep 2023 00:58:16 -0700 (PDT)
X-UUID: 1d1a230e514211ee8051498923ad61e6-20230912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SLDPYgykG/ylH9odZXDm18XdYzdZAtMfBSycDMTdUoU=;
        b=DpHiAx7srkeUeQ++NwZt8WJcpl3VX3cHVr/wWZ/erXDa4SszW0qrU/JUrI6USGSmTzWylsk7wJ/d5fAzVMyc88mXZy8uD7JUSQYdJkivWM0arAIff4u7pxS64c2LXz9aJthvDSOwZFhWD27a19tW5zGhGdfjMKFTPVNyEqL7RFI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:ff41b685-7eb3-4819-9703-4e8c303f84c5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:d2a9edc2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1d1a230e514211ee8051498923ad61e6-20230912
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 75351414; Tue, 12 Sep 2023 15:58:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Sep 2023 15:58:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Sep 2023 15:58:07 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Moudy Ho" <moudy.ho@mediatek.com>
Subject: [PATCH v5 10/14] media: platform: mtk-mdp3: add support for blending multiple components
Date:   Tue, 12 Sep 2023 15:58:01 +0800
Message-ID: <20230912075805.11432-11-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230912075805.11432-1-moudy.ho@mediatek.com>
References: <20230912075805.11432-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.812300-8.000000
X-TMASE-MatchedRID: 0yRi1y1TdgNILSVPxvZJcHV895e/Bd2JO8xCfog1G6TfUZT83lbkECKI
        UiL7FC/vhVmF9kz2wxLhgM7lrVqO2A719kpOO37PJQI+kfsRJdq7nrAU9KQxUb/A+0D1to6PuiV
        mRyWjcdnZoTly3PGW4LBkcxB01tpxHxPMjOKY7A9t1O49r1VEa8RB0bsfrpPI0PU0TdJoUtf114
        F5uvDyyGmZo5DkrTqBTqdBdI2oRFeJnGBdrk1OOkT/GPPAuo9eJhkLJF1zRV1e58Hmpqutcnvdk
        zxvYSOlukuQNVVOlnuOh+wyNBrFXDJiNuKohDcKzKSG3JdyKAPqtV2AGMNPavWdclq8lU1q
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.812300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8764E7F17C4615DDFC8CB77844CFC9255BF4E0A561A64417B469DEDAA798A0262000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain chips can combine several components to form complex virtual
units with advanced functions.
These components require simultaneous configuration of their MODs and
clocks.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 10 +++++++++-
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 20 ++++++++++++++++++-
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  7 +++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 6204173ecc5d..9c2afd002e7c 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -117,17 +117,25 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 	/* Set mutex mod */
 	for (index = 0; index < num_comp; index++) {
 		s32 inner_id = MDP_COMP_NONE;
+		const u32 *mutex_idx;
+		const struct mdp_comp_blend *b;
 
 		if (CFG_CHECK(MT8183, p_id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
 		if (mdp_cfg_comp_is_dummy(path->mdp_dev, inner_id))
 			continue;
+
 		ctx = &path->comps[index];
 		if (is_output_disabled(p_id, ctx->param, count))
 			continue;
+
+		mutex_idx = data->mdp_mutex_table_idx;
 		id = ctx->comp->public_id;
-		mtk_mutex_write_mod(mutex, data->mdp_mutex_table_idx[id], false);
+		mtk_mutex_write_mod(mutex, mutex_idx[id], false);
 
+		b = &data->comp_data[id].blend;
+		if (b && b->aid_mod)
+			mtk_mutex_write_mod(mutex, mutex_idx[b->b_id], false);
 	}
 
 	mtk_mutex_write_sof(mutex, MUTEX_SOF_IDX_SINGLE_MODE);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index ec296d4fd0c5..bb21fa2f5c3b 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -858,9 +858,19 @@ int mdp_comp_clocks_on(struct device *dev, struct mdp_comp *comps, int num)
 	int i, ret;
 
 	for (i = 0; i < num; i++) {
+		struct mdp_dev *mdp_dev = comps[i].mdp_dev;
+		enum mtk_mdp_comp_id id = comps[i].public_id;
+		const struct mdp_comp_blend *b = &mdp_dev->mdp_data->comp_data[id].blend;
+
 		ret = mdp_comp_clock_on(dev, &comps[i]);
 		if (ret)
 			return ret;
+
+		if (b && b->aid_clk) {
+			ret = mdp_comp_clock_on(dev, mdp_dev->comp[id]);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
@@ -870,8 +880,16 @@ void mdp_comp_clocks_off(struct device *dev, struct mdp_comp *comps, int num)
 {
 	int i;
 
-	for (i = 0; i < num; i++)
+	for (i = 0; i < num; i++) {
+		struct mdp_dev *mdp_dev = comps[i].mdp_dev;
+		enum mtk_mdp_comp_id id = comps[i].public_id;
+		const struct mdp_comp_blend *b = &mdp_dev->mdp_data->comp_data[id].blend;
+
 		mdp_comp_clock_off(dev, &comps[i]);
+
+		if (b && b->aid_clk)
+			mdp_comp_clock_off(dev, mdp_dev->comp[id]);
+	}
 }
 
 static int mdp_get_subsys_id(struct mdp_dev *mdp, struct device *dev,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
index 09e46dfe4f02..e31e1f088b32 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
@@ -201,9 +201,16 @@ struct mdp_comp_info {
 	u32 dts_reg_ofst;
 };
 
+struct mdp_comp_blend {
+	enum mtk_mdp_comp_id b_id;
+	bool aid_mod;
+	bool aid_clk;
+};
+
 struct mdp_comp_data {
 	struct mdp_comp_match match;
 	struct mdp_comp_info info;
+	struct mdp_comp_blend blend;
 };
 
 struct mdp_comp_ops;
-- 
2.18.0

