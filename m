Return-Path: <linux-kernel+bounces-6727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68488819C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA2F1C20DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227942233D;
	Wed, 20 Dec 2023 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lo4WeT5G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76628208BB;
	Wed, 20 Dec 2023 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 258f4cb29f2111eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XdbtxmAuqKYhbfAOn4+uoFUsshkzlniDmgmCgfiUlZ4=;
	b=lo4WeT5G2qXlo5cA4hzodoAEl2VydMoPjLwjoLwa2A/vdAf/NQVBIAR0bnhAXEYgxDzvNHSZOPkLK0kbE78XBvrnI1YDyAdtn0pVuPn1CMwbOWMSy12BFKwJfsR5X0gX6qhNO1wKv78NnipO/9iostGAkXy+lRpfwUvxc1lGYGM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:3a5a2c21-a188-4a58-9e6a-6d6d7a6c5e12,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:76677a7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 258f4cb29f2111eea5db2bebc7c28f94-20231220
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <moudy.ho@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 655382298; Wed, 20 Dec 2023 18:18:40 +0800
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
Subject: [PATCH v9 02/12] media: platform: mtk-mdp3: add support second sets of MUTEX
Date: Wed, 20 Dec 2023 18:18:28 +0800
Message-ID: <20231220101838.21510-3-moudy.ho@mediatek.com>
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
X-TM-AS-Result: No-10--10.127700-8.000000
X-TMASE-MatchedRID: SxnEO+JKTxoMiTNbd7AZSUD6z8N1m1ALTJDl9FKHbrk1LB46LFAAkhfB
	mF7pasJaoB9KLeioyTVJoFXIuzqlwbhzq4QWtOF2dXz3l78F3Ym4vBuE2X0HlX5h6y4KCSJc2Us
	WvUfe8jwEtgPPYjUPdQGZLfTlpw3f2lUnG4pY3Gy+dJWHbg4ITl67veYUroY0DpCUEeEFm7Ar3f
	toV0Xlc0vuLUFcu0MoDXWbDjwr3eyBiU7YV+klbrdQIb8hCnY+GSqdEmeD/nVdlUpKWB7xbyMOu
	GtF4L1EhbjW39vH2+ihJHMXPR4MEInYeNMpd8GQHcQQBuf4ZFu8n1e+HkKZPpsoi2XrUn/JUTdY
	/mdfTXtJKW4mDlJsMcK21zBg2Klf/KO2LNTSuGPThaXiooN2SiUxa5Q5Zp8IrCXtvBhfHxyMHk2
	CQj0Dow==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.127700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DCF63A903E5918F825EF2A8437E109DF45429268DD93F3CEB80FB6F22D6473232000:8
X-MTK: N

After setting up the second set of MMSYS (VPPSYS1), it is necessary
to have a corresponding second set of MUTEX (MUTEX2) to assist in
handling SOF/EOF.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 57 +++++++++++--------
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 51 ++++++++++++-----
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  4 +-
 3 files changed, 74 insertions(+), 38 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 6adac857a477..67c8fcc3eda9 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -44,15 +44,21 @@ static bool is_output_disabled(int p_id, const struct img_compparam *param, u32
 	return (count < num) ? (dis_output || dis_tile) : true;
 }
 
+static struct mtk_mutex *__get_mutex(const struct mdp_dev *mdp_dev,
+				     const struct mdp_pipe_info *p)
+{
+	return mdp_dev->mm_subsys[p->sub_id].mdp_mutex[p->mutex_id];
+}
+
 static int mdp_path_subfrm_require(const struct mdp_path *path,
 				   struct mdp_cmdq_cmd *cmd,
-				   s32 *mutex_id, u32 count)
+				   struct mdp_pipe_info *p, u32 count)
 {
 	const int p_id = path->mdp_dev->mdp_data->mdp_plat_id;
 	const struct mdp_comp_ctx *ctx;
 	const struct mtk_mdp_driver_data *data = path->mdp_dev->mdp_data;
 	struct device *dev = &path->mdp_dev->pdev->dev;
-	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
+	struct mtk_mutex *mutex;
 	int id, index;
 	u32 num_comp = 0;
 
@@ -77,7 +83,8 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 		dev_err(dev, "Unknown pipeline and no mutex is assigned");
 		return -EINVAL;
 	}
-	*mutex_id = data->pipe_info[index].mutex_id;
+	memcpy(p, &data->pipe_info[index], sizeof(struct mdp_pipe_info));
+	mutex = __get_mutex(path->mdp_dev, p);
 
 	/* Set mutex mod */
 	for (index = 0; index < num_comp; index++) {
@@ -85,29 +92,28 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 		if (is_output_disabled(p_id, ctx->param, count))
 			continue;
 		id = ctx->comp->public_id;
-		mtk_mutex_write_mod(mutex[*mutex_id],
-				    data->mdp_mutex_table_idx[id], false);
+		mtk_mutex_write_mod(mutex, data->mdp_mutex_table_idx[id], false);
+
 	}
 
-	mtk_mutex_write_sof(mutex[*mutex_id],
-			    MUTEX_SOF_IDX_SINGLE_MODE);
+	mtk_mutex_write_sof(mutex, MUTEX_SOF_IDX_SINGLE_MODE);
 
 	return 0;
 }
 
 static int mdp_path_subfrm_run(const struct mdp_path *path,
 			       struct mdp_cmdq_cmd *cmd,
-			       s32 *mutex_id, u32 count)
+			       struct mdp_pipe_info *p, u32 count)
 {
 	const int p_id = path->mdp_dev->mdp_data->mdp_plat_id;
 	const struct mdp_comp_ctx *ctx;
 	struct device *dev = &path->mdp_dev->pdev->dev;
-	struct mtk_mutex **mutex = path->mdp_dev->mdp_mutex;
+	struct mtk_mutex *mutex;
 	int index;
 	u32 num_comp = 0;
 	s32 event;
 
-	if (-1 == *mutex_id) {
+	if (-1 == p->mutex_id) {
 		dev_err(dev, "Incorrect mutex id");
 		return -EINVAL;
 	}
@@ -127,7 +133,8 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 	}
 
 	/* Enable the mutex */
-	mtk_mutex_enable_by_cmdq(mutex[*mutex_id], (void *)&cmd->pkt);
+	mutex = __get_mutex(path->mdp_dev, p);
+	mtk_mutex_enable_by_cmdq(mutex, (void *)&cmd->pkt);
 
 	/* Wait SOF events and clear mutex modules (optional) */
 	for (index = 0; index < num_comp; index++) {
@@ -174,7 +181,7 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 	const struct img_mmsys_ctrl *ctrl = NULL;
 	const struct img_mux *set;
 	struct mdp_comp_ctx *ctx;
-	s32 mutex_id;
+	struct mdp_pipe_info pipe;
 	int index, ret;
 	u32 num_comp = 0;
 
@@ -185,7 +192,7 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 		ctrl = CFG_ADDR(MT8183, path->config, ctrls[count]);
 
 	/* Acquire components */
-	ret = mdp_path_subfrm_require(path, cmd, &mutex_id, count);
+	ret = mdp_path_subfrm_require(path, cmd, &pipe, count);
 	if (ret)
 		return ret;
 	/* Enable mux settings */
@@ -204,7 +211,7 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 			return ret;
 	}
 	/* Run components */
-	ret = mdp_path_subfrm_run(path, cmd, &mutex_id, count);
+	ret = mdp_path_subfrm_run(path, cmd, &pipe, count);
 	if (ret)
 		return ret;
 	/* Wait components done */
@@ -328,13 +335,13 @@ static void mdp_auto_release_work(struct work_struct *work)
 {
 	struct mdp_cmdq_cmd *cmd;
 	struct mdp_dev *mdp;
-	int id;
+	struct mtk_mutex *mutex;
 
 	cmd = container_of(work, struct mdp_cmdq_cmd, auto_release_work);
 	mdp = cmd->mdp;
 
-	id = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-	mtk_mutex_unprepare(mdp->mdp_mutex[id]);
+	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0]);
+	mtk_mutex_unprepare(mutex);
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 
@@ -354,7 +361,6 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 	struct cmdq_cb_data *data;
 	struct mdp_dev *mdp;
 	struct device *dev;
-	int id;
 
 	if (!mssg) {
 		pr_info("%s:no callback data\n", __func__);
@@ -379,9 +385,11 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 
 	INIT_WORK(&cmd->auto_release_work, mdp_auto_release_work);
 	if (!queue_work(mdp->clock_wq, &cmd->auto_release_work)) {
+		struct mtk_mutex *mutex;
+
 		dev_err(dev, "%s:queue_work fail!\n", __func__);
-		id = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-		mtk_mutex_unprepare(mdp->mdp_mutex[id]);
+		mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0]);
+		mtk_mutex_unprepare(mutex);
 		mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 				    cmd->num_comps);
 
@@ -403,6 +411,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	struct mdp_comp *comps = NULL;
 	struct device *dev = &mdp->pdev->dev;
 	const int p_id = mdp->mdp_data->mdp_plat_id;
+	struct mtk_mutex *mutex = NULL;
 	int i, ret;
 	u32 num_comp = 0;
 
@@ -440,8 +449,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		goto err_free_comps;
 	}
 
-	i = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-	ret = mtk_mutex_prepare(mdp->mdp_mutex[i]);
+	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0]);
+	ret = mtk_mutex_prepare(mutex);
 	if (ret) {
 		dev_err(dev, "Fail to enable mutex clk\n");
 		goto err_free_path;
@@ -506,8 +515,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 err_free_path:
-	i = mdp->mdp_data->pipe_info[MDP_PIPE_RDMA0].mutex_id;
-	mtk_mutex_unprepare(mdp->mdp_mutex[i]);
+	if (mutex)
+		mtk_mutex_unprepare(mutex);
 	kfree(path);
 err_free_comps:
 	kfree(comps);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 8cd0f11fc290..4802b20d7f20 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -146,8 +146,17 @@ void mdp_video_device_release(struct video_device *vdev)
 	vb2_dma_contig_clear_max_seg_size(&mdp->pdev->dev);
 
 	mdp_comp_destroy(mdp);
-	for (i = 0; i < MDP_PIPE_MAX; i++)
-		mtk_mutex_put(mdp->mdp_mutex[i]);
+	for (i = 0; i < mdp->mdp_data->pipe_info_len; i++) {
+		enum mdp_mm_subsys_id idx;
+		struct mtk_mutex *m;
+		u32 m_id;
+
+		idx = mdp->mdp_data->pipe_info[i].sub_id;
+		m_id = mdp->mdp_data->pipe_info[i].mutex_id;
+		m = mdp->mm_subsys[idx].mdp_mutex[m_id];
+		if (!IS_ERR_OR_NULL(m))
+			mtk_mutex_put(m);
+	}
 
 	mdp_vpu_shared_mem_free(&mdp->vpu);
 	v4l2_m2m_release(mdp->m2m_dev);
@@ -171,6 +180,9 @@ static int mdp_mm_subsys_deploy(struct mdp_dev *mdp, enum mdp_infra_id id)
 		case MDP_INFRA_MMSYS:
 			dev = &mdp->mm_subsys[i].mmsys;
 			break;
+		case MDP_INFRA_MUTEX:
+			dev = &mdp->mm_subsys[i].mutex;
+			break;
 		default:
 			dev_err(&mdp->pdev->dev, "Unknown infra id %d", id);
 			return -EINVAL;
@@ -214,18 +226,24 @@ static int mdp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_destroy_device;
 
-	mm_pdev = __get_pdev_by_id(pdev, NULL, MDP_INFRA_MUTEX);
-	if (WARN_ON(!mm_pdev)) {
-		ret = -ENODEV;
+	ret = mdp_mm_subsys_deploy(mdp, MDP_INFRA_MUTEX);
+	if (ret)
 		goto err_destroy_device;
-	}
+
 	for (i = 0; i < mdp->mdp_data->pipe_info_len; i++) {
+		enum mdp_mm_subsys_id idx;
+		struct mtk_mutex **m;
+
+		idx = mdp->mdp_data->pipe_info[i].sub_id;
 		mutex_id = mdp->mdp_data->pipe_info[i].mutex_id;
-		if (!IS_ERR_OR_NULL(mdp->mdp_mutex[mutex_id]))
+		m = &mdp->mm_subsys[idx].mdp_mutex[mutex_id];
+
+		if (!IS_ERR_OR_NULL(*m))
 			continue;
-		mdp->mdp_mutex[mutex_id] = mtk_mutex_get(&mm_pdev->dev);
-		if (IS_ERR(mdp->mdp_mutex[mutex_id])) {
-			ret = PTR_ERR(mdp->mdp_mutex[mutex_id]);
+
+		*m = mtk_mutex_get(mdp->mm_subsys[idx].mutex);
+		if (IS_ERR(*m)) {
+			ret = PTR_ERR(*m);
 			goto err_free_mutex;
 		}
 	}
@@ -309,9 +327,16 @@ static int mdp_probe(struct platform_device *pdev)
 err_deinit_comp:
 	mdp_comp_destroy(mdp);
 err_free_mutex:
-	for (i = 0; i < mdp->mdp_data->pipe_info_len; i++)
-		if (!IS_ERR_OR_NULL(mdp->mdp_mutex[i]))
-			mtk_mutex_put(mdp->mdp_mutex[i]);
+	for (i = 0; i < mdp->mdp_data->pipe_info_len; i++) {
+		enum mdp_mm_subsys_id idx;
+		struct mtk_mutex *m;
+
+		idx = mdp->mdp_data->pipe_info[i].sub_id;
+		mutex_id = mdp->mdp_data->pipe_info[i].mutex_id;
+		m = mdp->mm_subsys[idx].mdp_mutex[mutex_id];
+		if (!IS_ERR_OR_NULL(m))
+			mtk_mutex_put(m);
+	}
 err_destroy_device:
 	kfree(mdp);
 err_return:
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index 7a7cdd0ce968..fde2c0b95def 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -26,6 +26,7 @@ enum mdp_infra_id {
 	MDP_INFRA_MMSYS,
 	MDP_INFRA_MMSYS2,
 	MDP_INFRA_MUTEX,
+	MDP_INFRA_MUTEX2,
 	MDP_INFRA_SCP,
 	MDP_INFRA_MAX
 };
@@ -78,12 +79,13 @@ struct mtk_mdp_driver_data {
 
 struct mdp_mm_subsys {
 	struct device *mmsys;
+	struct device *mutex;
+	struct mtk_mutex *mdp_mutex[MDP_PIPE_MAX];
 };
 
 struct mdp_dev {
 	struct platform_device			*pdev;
 	struct mdp_mm_subsys			mm_subsys[MDP_MM_SUBSYS_MAX];
-	struct mtk_mutex			*mdp_mutex[MDP_PIPE_MAX];
 	struct mdp_comp				*comp[MDP_MAX_COMP_COUNT];
 	const struct mtk_mdp_driver_data	*mdp_data;
 
-- 
2.18.0


