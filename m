Return-Path: <linux-kernel+bounces-6724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707DB819C93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FB21F28121
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057F210E5;
	Wed, 20 Dec 2023 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qHDUzL5/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439BF2031D;
	Wed, 20 Dec 2023 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 259193f09f2111eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hyYnoqNGoSTTbIxf1opsH0bdkk2hskuSdMmZlWWvdeE=;
	b=qHDUzL5/JfKYFu3YH6r+JhuHgY/dJcAr/Q4UTEIunt9WpjJAVoBQYw/jDBFHfuJ8fxQnGdqYEPLRdX4gnu22ZGJq3s2QTpekTEkCczlcT7H5wr9TEoMzJ/GWR2l8XuYzWt/Le6VEhl4MGIARi9rcfBwF3wgvf4JJB7oC8SjRD4Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:aae6af37-1da0-4fb6-b405-729e74cd3795,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:30da4b2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 259193f09f2111eea5db2bebc7c28f94-20231220
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <moudy.ho@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 235987117; Wed, 20 Dec 2023 18:18:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 18:18:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 18:18:40 +0800
From: Moudy Ho <moudy.ho@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v9 08/12] media: platform: mtk-mdp3: add support for blending multiple components
Date: Wed, 20 Dec 2023 18:18:34 +0800
Message-ID: <20231220101838.21510-9-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231220101838.21510-1-moudy.ho@mediatek.com>
References: <20231220101838.21510-1-moudy.ho@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.879000-8.000000
X-TMASE-MatchedRID: KlFhDc9v5J5ILSVPxvZJcHV895e/Bd2J1KoSW5Ji1Xv/evmlVf9xZpeS
	PuHyHNrhlTJXKqh1ne29cOdjc/43len2wHlv5vGudXu122+iJtoEa8g1x8eqF08vg1FXaj1omPw
	bEvJgAefCFUdoPtcptMfW2dzExL8C/16F1o/rJO7hG1IOMb7PsH0tCKdnhB58I/9UW5M5dRN3A3
	6JhZ4tNfcUt5lc1lLgjMejjvPkBr7EKputfZBfQMUedzTwMFPo5ATKJjWFuPBd9A+8AE1s3zMr+
	lwPT/UeRAKRId7FA5h8TTcKUOgXlBcaD2m2fFe6RBRiZYZplB95lSmbrC6fdtr/To2FgNrjDLMI
	OOVTHz2nbLeYgH6K31Zca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.879000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	09D00D7E8EFE7674FAFAE6BB8D6E4A00D9443F2C780E5841E18C2F853C72CA532000:8
X-MTK: N

Certain chips can combine several components to form complex virtual
units with advanced functions.
These components require simultaneous configuration of their MODs and
clocks.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


