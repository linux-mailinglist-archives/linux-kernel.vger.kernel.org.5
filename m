Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8297DB818
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjJ3K3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjJ3K2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:28:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870928A56;
        Mon, 30 Oct 2023 03:06:39 -0700 (PDT)
X-UUID: fef6a77c770b11ee8051498923ad61e6-20231030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VU0P7jtKFjfrdN/6oK1QZVX4lB0rBAvGSeam6vQaBSc=;
        b=elv6uqwAKQ/WkY9wGa1Pw3e2F8wfYv+yAIbszqBj7TEgmo0yRGrCbL+hM/Zuw1LVJtGBoQHWKKankLtPOV+3PEDxoecnpZDwlxnpwd6be7qq+ifwbrIaMCxCmQnKR/3qZtid4eKHS8Ts1pXYZ5kNOiWYAh5qhZEykL8sgqMMaYs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:79d7e49f-88bb-4341-8a02-dc0efde738e7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:b8257bd7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fef6a77c770b11ee8051498923ad61e6-20231030
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1938941583; Mon, 30 Oct 2023 18:06:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Oct 2023 18:06:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Oct 2023 18:06:28 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v8 08/12] media: platform: mtk-mdp3: add support for blending multiple components
Date:   Mon, 30 Oct 2023 18:06:22 +0800
Message-ID: <20231030100626.12564-9-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231030100626.12564-1-moudy.ho@mediatek.com>
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.836800-8.000000
X-TMASE-MatchedRID: zGpV5UNF2R9ILSVPxvZJcHV895e/Bd2JO8xCfog1G6TfUZT83lbkECKI
        UiL7FC/vhVmF9kz2wxLhgM7lrVqO2A719kpOO37PJQI+kfsRJdq7nrAU9KQxUb/A+0D1to6PuiV
        mRyWjcdlMmm8bxtFZ3f1/2RbvJIzKGAdnzrnkM48URSScn+QSXt0H8LFZNFG7CKFCmhdu5cUuB3
        ljSHuvWKMYwz14Csz2Twfy6cSdl3jP9mDeyY7LboYVVh4aiLOBgl4oRJ2MSw08ceraTEO3y5sUJ
        oMU+z2/C8UOWOBQ4X0XRoPmWO3jekxwdkPqCq7vDEyN+J8hd+jCS9WgDXVPCp6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.836800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E7031C9054D4B4018536066351322A1BA53A635B2902874B5495B2BCE5CDA4282000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain chips can combine several components to form complex virtual
units with advanced functions.
These components require simultaneous configuration of their MODs and
clocks.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 10 ++++++-
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 29 +++++++++++++++++--
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  7 +++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index a81caf5f472c..f0c5f5abeb23 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -110,17 +110,25 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
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
index ed6092e1666f..e97630b7867c 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -864,12 +864,26 @@ int mdp_comp_clocks_on(struct device *dev, struct mdp_comp *comps, int num)
 	int i, ret;
 
 	for (i = 0; i < num; i++) {
+		struct mdp_dev *m = comps[i].mdp_dev;
+		enum mtk_mdp_comp_id id;
+		const struct mdp_comp_blend *b;
+
 		/* Bypass the dummy component*/
-		if (!comps[i].mdp_dev)
+		if (!m)
 			continue;
+
 		ret = mdp_comp_clock_on(dev, &comps[i]);
 		if (ret)
 			return ret;
+
+		id = comps[i].public_id;
+		b = &m->mdp_data->comp_data[id].blend;
+
+		if (b && b->aid_clk) {
+			ret = mdp_comp_clock_on(dev, m->comp[b->b_id]);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
@@ -880,10 +894,21 @@ void mdp_comp_clocks_off(struct device *dev, struct mdp_comp *comps, int num)
 	int i;
 
 	for (i = 0; i < num; i++) {
+		struct mdp_dev *m = comps[i].mdp_dev;
+		enum mtk_mdp_comp_id id;
+		const struct mdp_comp_blend *b;
+
 		/* Bypass the dummy component*/
-		if (!comps[i].mdp_dev)
+		if (!m)
 			continue;
+
 		mdp_comp_clock_off(dev, &comps[i]);
+
+		id = comps[i].public_id;
+		b = &m->mdp_data->comp_data[id].blend;
+
+		if (b && b->aid_clk)
+			mdp_comp_clock_off(dev, m->comp[b->b_id]);
 	}
 }
 
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
index e6cbc6ab6bae..3e5d2da1c807 100644
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

