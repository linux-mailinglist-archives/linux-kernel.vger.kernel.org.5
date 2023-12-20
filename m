Return-Path: <linux-kernel+bounces-6730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B0819C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3851F292B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DF4225D6;
	Wed, 20 Dec 2023 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Rn+3v8GG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEF20DCC;
	Wed, 20 Dec 2023 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 253c17409f2111eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mRmkEoGzC/2ZuTRSrQxg+RXzdvtGyoRr9TXd9zrr4SE=;
	b=Rn+3v8GGENlT3BVvPoWekCbnAs+GK6xKsgBOS1Sfl6FrYsiZjN14wemLXOTfVSIWQ64Ea8uqnTNhu7p6gsUdHXVgvfANAncE3J8VJrVOGS3/JL+Z/PjXtjCDJ4V9qPuiBP8a7FtVd+tLVbKet63YNVwE92DFT25o+V74I53YRUY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:380917d7-eecb-4439-a820-4f3dade42c13,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:e48ffa81-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 253c17409f2111eea5db2bebc7c28f94-20231220
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <moudy.ho@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1892059634; Wed, 20 Dec 2023 18:18:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 18:18:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 18:18:39 +0800
From: Moudy Ho <moudy.ho@mediatek.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v9 01/12] media: platform: mtk-mdp3: add support second sets of MMSYS
Date: Wed, 20 Dec 2023 18:18:27 +0800
Message-ID: <20231220101838.21510-2-moudy.ho@mediatek.com>
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
X-MTK: N

The MT8195 chipset features two MMSYS subsets: VPPSYS0 and VPPSYS1.
These subsets coordinate and control the clock, power, and
register settings required for the components of MDP3.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mediatek/mdp3/mdp_cfg_data.c     | 44 ++++++-------
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  1 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 61 ++++++++++++++++---
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    | 18 +++++-
 4 files changed, 92 insertions(+), 32 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index 502eeae0bfdc..fcc582292b77 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -73,75 +73,75 @@ static const u32 mt8183_mutex_idx[MDP_MAX_COMP_COUNT] = {
 
 static const struct mdp_comp_data mt8183_mdp_comp_data[MDP_MAX_COMP_COUNT] = {
 	[MDP_COMP_WPEI] = {
-		{MDP_COMP_TYPE_WPEI, 0, MT8183_MDP_COMP_WPEI},
+		{MDP_COMP_TYPE_WPEI, 0, MT8183_MDP_COMP_WPEI, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WPEO] = {
-		{MDP_COMP_TYPE_EXTO, 2, MT8183_MDP_COMP_WPEO},
+		{MDP_COMP_TYPE_EXTO, 2, MT8183_MDP_COMP_WPEO, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WPEI2] = {
-		{MDP_COMP_TYPE_WPEI, 1, MT8183_MDP_COMP_WPEI2},
+		{MDP_COMP_TYPE_WPEI, 1, MT8183_MDP_COMP_WPEI2, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WPEO2] = {
-		{MDP_COMP_TYPE_EXTO, 3, MT8183_MDP_COMP_WPEO2},
+		{MDP_COMP_TYPE_EXTO, 3, MT8183_MDP_COMP_WPEO2, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_ISP_IMGI] = {
-		{MDP_COMP_TYPE_IMGI, 0, MT8183_MDP_COMP_ISP_IMGI},
+		{MDP_COMP_TYPE_IMGI, 0, MT8183_MDP_COMP_ISP_IMGI, MDP_MM_SUBSYS_0},
 		{0, 0, 4}
 	},
 	[MDP_COMP_ISP_IMGO] = {
-		{MDP_COMP_TYPE_EXTO, 0, MT8183_MDP_COMP_ISP_IMGO},
+		{MDP_COMP_TYPE_EXTO, 0, MT8183_MDP_COMP_ISP_IMGO, MDP_MM_SUBSYS_0},
 		{0, 0, 4}
 	},
 	[MDP_COMP_ISP_IMG2O] = {
-		{MDP_COMP_TYPE_EXTO, 1, MT8183_MDP_COMP_ISP_IMG2O},
+		{MDP_COMP_TYPE_EXTO, 1, MT8183_MDP_COMP_ISP_IMG2O, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_CAMIN] = {
-		{MDP_COMP_TYPE_DL_PATH, 0, MT8183_MDP_COMP_CAMIN},
+		{MDP_COMP_TYPE_DL_PATH, 0, MT8183_MDP_COMP_CAMIN, MDP_MM_SUBSYS_0},
 		{2, 2, 1}
 	},
 	[MDP_COMP_CAMIN2] = {
-		{MDP_COMP_TYPE_DL_PATH, 1, MT8183_MDP_COMP_CAMIN2},
+		{MDP_COMP_TYPE_DL_PATH, 1, MT8183_MDP_COMP_CAMIN2, MDP_MM_SUBSYS_0},
 		{2, 4, 1}
 	},
 	[MDP_COMP_RDMA0] = {
-		{MDP_COMP_TYPE_RDMA, 0, MT8183_MDP_COMP_RDMA0},
+		{MDP_COMP_TYPE_RDMA, 0, MT8183_MDP_COMP_RDMA0, MDP_MM_SUBSYS_0},
 		{2, 0, 0}
 	},
 	[MDP_COMP_CCORR0] = {
-		{MDP_COMP_TYPE_CCORR, 0, MT8183_MDP_COMP_CCORR0},
+		{MDP_COMP_TYPE_CCORR, 0, MT8183_MDP_COMP_CCORR0, MDP_MM_SUBSYS_0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_RSZ0] = {
-		{MDP_COMP_TYPE_RSZ, 0, MT8183_MDP_COMP_RSZ0},
+		{MDP_COMP_TYPE_RSZ, 0, MT8183_MDP_COMP_RSZ0, MDP_MM_SUBSYS_0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_RSZ1] = {
-		{MDP_COMP_TYPE_RSZ, 1, MT8183_MDP_COMP_RSZ1},
+		{MDP_COMP_TYPE_RSZ, 1, MT8183_MDP_COMP_RSZ1, MDP_MM_SUBSYS_0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_TDSHP0] = {
-		{MDP_COMP_TYPE_TDSHP, 0, MT8183_MDP_COMP_TDSHP0},
+		{MDP_COMP_TYPE_TDSHP, 0, MT8183_MDP_COMP_TDSHP0, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_PATH0_SOUT] = {
-		{MDP_COMP_TYPE_PATH, 0, MT8183_MDP_COMP_PATH0_SOUT},
+		{MDP_COMP_TYPE_PATH, 0, MT8183_MDP_COMP_PATH0_SOUT, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_PATH1_SOUT] = {
-		{MDP_COMP_TYPE_PATH, 1, MT8183_MDP_COMP_PATH1_SOUT},
+		{MDP_COMP_TYPE_PATH, 1, MT8183_MDP_COMP_PATH1_SOUT, MDP_MM_SUBSYS_0},
 		{0, 0, 0}
 	},
 	[MDP_COMP_WROT0] = {
-		{MDP_COMP_TYPE_WROT, 0, MT8183_MDP_COMP_WROT0},
+		{MDP_COMP_TYPE_WROT, 0, MT8183_MDP_COMP_WROT0, MDP_MM_SUBSYS_0},
 		{1, 0, 0}
 	},
 	[MDP_COMP_WDMA] = {
-		{MDP_COMP_TYPE_WDMA, 0, MT8183_MDP_COMP_WDMA},
+		{MDP_COMP_TYPE_WDMA, 0, MT8183_MDP_COMP_WDMA, MDP_MM_SUBSYS_0},
 		{1, 0, 0}
 	},
 };
@@ -402,10 +402,10 @@ static const struct mdp_limit mt8183_mdp_def_limit = {
 };
 
 static const struct mdp_pipe_info mt8183_pipe_info[] = {
-	[MDP_PIPE_WPEI] = {MDP_PIPE_WPEI, 0},
-	[MDP_PIPE_WPEI2] = {MDP_PIPE_WPEI2, 1},
-	[MDP_PIPE_IMGI] = {MDP_PIPE_IMGI, 2},
-	[MDP_PIPE_RDMA0] = {MDP_PIPE_RDMA0, 3}
+	[MDP_PIPE_WPEI] = {MDP_PIPE_WPEI, MDP_MM_SUBSYS_0, 0},
+	[MDP_PIPE_WPEI2] = {MDP_PIPE_WPEI2, MDP_MM_SUBSYS_0, 1},
+	[MDP_PIPE_IMGI] = {MDP_PIPE_IMGI, MDP_MM_SUBSYS_0, 2},
+	[MDP_PIPE_RDMA0] = {MDP_PIPE_RDMA0, MDP_MM_SUBSYS_0, 3}
 };
 
 const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
index 20d2bcb77ef9..e89c51e1edb7 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
@@ -138,6 +138,7 @@ struct mdp_comp_match {
 	enum mdp_comp_type type;
 	u32 alias_id;
 	s32 inner_id;
+	s32 subsys_id;
 };
 
 /* Used to describe the item order in MDP property */
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 94f4ed78523b..8cd0f11fc290 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -26,9 +26,10 @@ static const struct of_device_id mdp_of_ids[] = {
 MODULE_DEVICE_TABLE(of, mdp_of_ids);
 
 static struct platform_device *__get_pdev_by_id(struct platform_device *pdev,
+						struct platform_device *from,
 						enum mdp_infra_id id)
 {
-	struct device_node *node;
+	struct device_node *node, *f = NULL;
 	struct platform_device *mdp_pdev = NULL;
 	const struct mtk_mdp_driver_data *mdp_data;
 	const char *compat;
@@ -46,9 +47,14 @@ static struct platform_device *__get_pdev_by_id(struct platform_device *pdev,
 		dev_err(&pdev->dev, "have no driver data to find node\n");
 		return NULL;
 	}
+
 	compat = mdp_data->mdp_probe_infra[id].compatible;
+	if (strlen(compat) == 0)
+		return NULL;
 
-	node = of_find_compatible_node(NULL, NULL, compat);
+	if (from)
+		f = from->dev.of_node;
+	node = of_find_compatible_node(f, NULL, compat);
 	if (WARN_ON(!node)) {
 		dev_err(&pdev->dev, "find node from id %d failed\n", id);
 		return NULL;
@@ -148,6 +154,46 @@ void mdp_video_device_release(struct video_device *vdev)
 	kfree(mdp);
 }
 
+static int mdp_mm_subsys_deploy(struct mdp_dev *mdp, enum mdp_infra_id id)
+{
+	struct platform_device *mm_pdev = NULL;
+	struct device **dev;
+	int i;
+
+	if (!mdp)
+		return -EINVAL;
+
+	for (i = 0; i < MDP_MM_SUBSYS_MAX; i++) {
+		const char *compat;
+		enum mdp_infra_id sub_id = id + i;
+
+		switch (id) {
+		case MDP_INFRA_MMSYS:
+			dev = &mdp->mm_subsys[i].mmsys;
+			break;
+		default:
+			dev_err(&mdp->pdev->dev, "Unknown infra id %d", id);
+			return -EINVAL;
+		}
+
+		/*
+		 * Not every chip has multiple multimedia subsystems, so
+		 * the config may be null.
+		 */
+		compat = mdp->mdp_data->mdp_probe_infra[sub_id].compatible;
+		if (strlen(compat) == 0)
+			continue;
+
+		mm_pdev = __get_pdev_by_id(mdp->pdev, mm_pdev, sub_id);
+		if (WARN_ON(!mm_pdev))
+			return -ENODEV;
+
+		*dev = &mm_pdev->dev;
+	}
+
+	return 0;
+}
+
 static int mdp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -164,14 +210,11 @@ static int mdp_probe(struct platform_device *pdev)
 	mdp->pdev = pdev;
 	mdp->mdp_data = of_device_get_match_data(&pdev->dev);
 
-	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_MMSYS);
-	if (!mm_pdev) {
-		ret = -ENODEV;
+	ret = mdp_mm_subsys_deploy(mdp, MDP_INFRA_MMSYS);
+	if (ret)
 		goto err_destroy_device;
-	}
-	mdp->mdp_mmsys = &mm_pdev->dev;
 
-	mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_MUTEX);
+	mm_pdev = __get_pdev_by_id(pdev, NULL, MDP_INFRA_MUTEX);
 	if (WARN_ON(!mm_pdev)) {
 		ret = -ENODEV;
 		goto err_destroy_device;
@@ -210,7 +253,7 @@ static int mdp_probe(struct platform_device *pdev)
 
 	mdp->scp = scp_get(pdev);
 	if (!mdp->scp) {
-		mm_pdev = __get_pdev_by_id(pdev, MDP_INFRA_SCP);
+		mm_pdev = __get_pdev_by_id(pdev, NULL, MDP_INFRA_SCP);
 		if (WARN_ON(!mm_pdev)) {
 			dev_err(&pdev->dev, "Could not get scp device\n");
 			ret = -ENODEV;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 7e21d226ceb8..7a7cdd0ce968 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -19,12 +19,23 @@
 #define MDP_PHANDLE_NAME	"mediatek,mdp3"
 
 enum mdp_infra_id {
+	/*
+	 * Due to the sequential nature of function "mdp_mm_subsys_deploy",
+	 * adding new enum. necessitates careful consideration.
+	 */
 	MDP_INFRA_MMSYS,
+	MDP_INFRA_MMSYS2,
 	MDP_INFRA_MUTEX,
 	MDP_INFRA_SCP,
 	MDP_INFRA_MAX
 };
 
+enum mdp_mm_subsys_id {
+	MDP_MM_SUBSYS_0,
+	MDP_MM_SUBSYS_1,
+	MDP_MM_SUBSYS_MAX,
+};
+
 enum mdp_buffer_usage {
 	MDP_BUFFER_USAGE_HW_READ,
 	MDP_BUFFER_USAGE_MDP,
@@ -65,9 +76,13 @@ struct mtk_mdp_driver_data {
 	unsigned int pipe_info_len;
 };
 
+struct mdp_mm_subsys {
+	struct device *mmsys;
+};
+
 struct mdp_dev {
 	struct platform_device			*pdev;
-	struct device				*mdp_mmsys;
+	struct mdp_mm_subsys			mm_subsys[MDP_MM_SUBSYS_MAX];
 	struct mtk_mutex			*mdp_mutex[MDP_PIPE_MAX];
 	struct mdp_comp				*comp[MDP_MAX_COMP_COUNT];
 	const struct mtk_mdp_driver_data	*mdp_data;
@@ -96,6 +111,7 @@ struct mdp_dev {
 
 struct mdp_pipe_info {
 	enum mdp_pipe_id pipe_id;
+	enum mdp_mm_subsys_id sub_id;
 	u32 mutex_id;
 };
 
-- 
2.18.0


