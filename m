Return-Path: <linux-kernel+bounces-6725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 990EF819C99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107741F28D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A3B22092;
	Wed, 20 Dec 2023 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SJMQLwjF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3D200D8;
	Wed, 20 Dec 2023 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 259085c89f2111eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jDWZYzNxYLpWt6P69LeihlPlUOU1CA18MHR7u96usNo=;
	b=SJMQLwjFMG/3FizIo9ErQmPeaP9d1jjGaPrhMrSyZerbwa117Xp7Nn6EbrHK9pQgfeq9OggdVSqVMMXwGtd6juaustyvZMnoRNKnPgZi7UqpOgcDOqEbwbyCjyS1xZuFs2b5X1IGzTDebAsr+l+48x1uNgC8+PfmaONeAbeMujg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:7991932a-d38a-4ce2-a80a-03a305d52a54,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:5971618d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 259085c89f2111eea5db2bebc7c28f94-20231220
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <moudy.ho@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1898639294; Wed, 20 Dec 2023 18:18:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
Subject: [PATCH v9 03/12] media: platform: mtk-mdp3: introduce more pipelines from MT8195
Date: Wed, 20 Dec 2023 18:18:29 +0800
Message-ID: <20231220101838.21510-4-moudy.ho@mediatek.com>
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
X-TM-AS-Result: No-10--8.000000-8.000000
X-TMASE-MatchedRID: m6rLaYghEfbPl7LciQedTmNW0DAjL5p++OI6XsK3BWHfUZT83lbkECKI
	UiL7FC/vARdN2JeGGT+tU0nd1OZo0uF/B1jEjV+6syw+ZJnFumQrHkgIan9a0R1jWjAZHoEn2Rq
	36Gwhut8WsZoa4AeM8YEo7LYf+/jBzB1CJ6qmdNp2aFFWhkT3QBkqnRJng/51w01zN1c0miKHxN
	U3crUDhDxOxTEbgyTygDLqnrRlXrZ8nn9tnqel2MprJP8FBOIanJt86X1EFeUYulnipJCKBIvP6
	F0UE9zmEkF37vSZTSBkfS+Bnqwnx8C+ksT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.000000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BB23611C2D32CC085199F56F84AB73D32102952F5711B84151BC7A53C55395122000:8
X-MTK: N

Increasing the number of sets built by MMSYS and MUTEX in MT8195
will enable the creation of more pipelines in MDP3.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 80 ++++++++++++-------
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  7 ++
 2 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 67c8fcc3eda9..31930ddbc828 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -50,6 +50,43 @@ static struct mtk_mutex *__get_mutex(const struct mdp_dev *mdp_dev,
 	return mdp_dev->mm_subsys[p->sub_id].mdp_mutex[p->mutex_id];
 }
 
+static enum mdp_pipe_id __get_pipe(const struct mdp_dev *mdp_dev,
+				   enum mtk_mdp_comp_id id)
+{
+	enum mdp_pipe_id pipe_id;
+
+	switch (id) {
+	case MDP_COMP_RDMA0:
+		pipe_id = MDP_PIPE_RDMA0;
+		break;
+	case MDP_COMP_ISP_IMGI:
+		pipe_id = MDP_PIPE_IMGI;
+		break;
+	case MDP_COMP_WPEI:
+		pipe_id = MDP_PIPE_WPEI;
+		break;
+	case MDP_COMP_WPEI2:
+		pipe_id = MDP_PIPE_WPEI2;
+		break;
+	case MDP_COMP_RDMA1:
+		pipe_id = MDP_PIPE_RDMA1;
+		break;
+	case MDP_COMP_RDMA2:
+		pipe_id = MDP_PIPE_RDMA2;
+		break;
+	case MDP_COMP_RDMA3:
+		pipe_id = MDP_PIPE_RDMA3;
+		break;
+	default:
+		/* Avoid exceptions when operating MUTEX */
+		pipe_id = MDP_PIPE_RDMA0;
+		dev_err(&mdp_dev->pdev->dev, "Unknown pipeline id %d", id);
+		break;
+	}
+
+	return pipe_id;
+}
+
 static int mdp_path_subfrm_require(const struct mdp_path *path,
 				   struct mdp_cmdq_cmd *cmd,
 				   struct mdp_pipe_info *p, u32 count)
@@ -57,7 +94,6 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 	const int p_id = path->mdp_dev->mdp_data->mdp_plat_id;
 	const struct mdp_comp_ctx *ctx;
 	const struct mtk_mdp_driver_data *data = path->mdp_dev->mdp_data;
-	struct device *dev = &path->mdp_dev->pdev->dev;
 	struct mtk_mutex *mutex;
 	int id, index;
 	u32 num_comp = 0;
@@ -66,23 +102,7 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 		num_comp = CFG_GET(MT8183, path->config, num_components);
 
 	/* Decide which mutex to use based on the current pipeline */
-	switch (path->comps[0].comp->public_id) {
-	case MDP_COMP_RDMA0:
-		index = MDP_PIPE_RDMA0;
-		break;
-	case MDP_COMP_ISP_IMGI:
-		index = MDP_PIPE_IMGI;
-		break;
-	case MDP_COMP_WPEI:
-		index = MDP_PIPE_WPEI;
-		break;
-	case MDP_COMP_WPEI2:
-		index = MDP_PIPE_WPEI2;
-		break;
-	default:
-		dev_err(dev, "Unknown pipeline and no mutex is assigned");
-		return -EINVAL;
-	}
+	index = __get_pipe(path->mdp_dev, path->comps[0].comp->public_id);
 	memcpy(p, &data->pipe_info[index], sizeof(struct mdp_pipe_info));
 	mutex = __get_mutex(path->mdp_dev, p);
 
@@ -336,11 +356,13 @@ static void mdp_auto_release_work(struct work_struct *work)
 	struct mdp_cmdq_cmd *cmd;
 	struct mdp_dev *mdp;
 	struct mtk_mutex *mutex;
+	enum mdp_pipe_id pipe_id;
 
 	cmd = container_of(work, struct mdp_cmdq_cmd, auto_release_work);
 	mdp = cmd->mdp;
 
-	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0]);
+	pipe_id = __get_pipe(mdp, cmd->comps[0].public_id);
+	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[pipe_id]);
 	mtk_mutex_unprepare(mutex);
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
@@ -361,6 +383,7 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 	struct cmdq_cb_data *data;
 	struct mdp_dev *mdp;
 	struct device *dev;
+	enum mdp_pipe_id pipe_id;
 
 	if (!mssg) {
 		pr_info("%s:no callback data\n", __func__);
@@ -388,7 +411,8 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 		struct mtk_mutex *mutex;
 
 		dev_err(dev, "%s:queue_work fail!\n", __func__);
-		mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0]);
+		pipe_id = __get_pipe(mdp, cmd->comps[0].public_id);
+		mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[pipe_id]);
 		mtk_mutex_unprepare(mutex);
 		mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 				    cmd->num_comps);
@@ -412,6 +436,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	struct device *dev = &mdp->pdev->dev;
 	const int p_id = mdp->mdp_data->mdp_plat_id;
 	struct mtk_mutex *mutex = NULL;
+	enum mdp_pipe_id pipe_id;
 	int i, ret;
 	u32 num_comp = 0;
 
@@ -449,13 +474,6 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		goto err_free_comps;
 	}
 
-	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0]);
-	ret = mtk_mutex_prepare(mutex);
-	if (ret) {
-		dev_err(dev, "Fail to enable mutex clk\n");
-		goto err_free_path;
-	}
-
 	path->mdp_dev = mdp;
 	path->config = param->config;
 	path->param = param->param;
@@ -475,6 +493,14 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		goto err_free_path;
 	}
 
+	pipe_id = __get_pipe(mdp, path->comps[0].comp->public_id);
+	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[pipe_id]);
+	ret = mtk_mutex_prepare(mutex);
+	if (ret) {
+		dev_err(dev, "Fail to enable mutex clk\n");
+		goto err_free_path;
+	}
+
 	ret = mdp_path_config(mdp, cmd, path);
 	if (ret) {
 		dev_err(dev, "mdp_path_config error\n");
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index fde2c0b95def..ece6509666fd 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -59,6 +59,13 @@ enum mdp_pipe_id {
 	MDP_PIPE_WPEI2,
 	MDP_PIPE_IMGI,
 	MDP_PIPE_RDMA0,
+	MDP_PIPE_RDMA1,
+	MDP_PIPE_RDMA2,
+	MDP_PIPE_RDMA3,
+	MDP_PIPE_SPLIT,
+	MDP_PIPE_SPLIT2,
+	MDP_PIPE_VPP0_SOUT,
+	MDP_PIPE_VPP1_SOUT,
 	MDP_PIPE_MAX
 };
 
-- 
2.18.0


