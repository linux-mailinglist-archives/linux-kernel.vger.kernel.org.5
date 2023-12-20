Return-Path: <linux-kernel+bounces-6729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22829819C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474CE1C21F84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB0224EA;
	Wed, 20 Dec 2023 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c8sxXpOE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273B208A8;
	Wed, 20 Dec 2023 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 26556f8c9f2111eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OTo6n5sCr9TWU7zdMCkXN73bsUtF53nr6nzcUlYlZ00=;
	b=c8sxXpOE1q57TWkHWhLYvhLXVY1RwYpjZp/ptmSm3BoHtUR03Nl6SHAwPn/LrEi3+mdMAq/gFzNRcH26kO8F4mR+U0KpIA531Eo0DTOLm0/1bEWX1xVDKQbK9dupReMENWCzNfYS7wkxD77ZhixPwILPJRMVPydgE7Y5Xf7Csmc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1a2ff8f2-bf40-4fbc-9814-74ed7622aed5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:79677a7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 26556f8c9f2111eeba30773df0976c77-20231220
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <moudy.ho@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 316243991; Wed, 20 Dec 2023 18:18:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
Subject: [PATCH v9 12/12] media: platform: mtk-mdp3: add support for parallel pipe to improve FPS
Date: Wed, 20 Dec 2023 18:18:38 +0800
Message-ID: <20231220101838.21510-13-moudy.ho@mediatek.com>
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

In some chips, MDP3 has the ability to utilize two pipelines to
parallelly process a single frame.
To enable this feature, multiple CMDQ clients and packets need to
be configured at the same time.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mediatek/mdp3/mdp_cfg_data.c     |   8 +
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 188 +++++++++++++-----
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  18 +-
 .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  12 +-
 .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  15 ++
 .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  18 ++
 .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |   1 +
 .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |   3 +-
 9 files changed, 208 insertions(+), 56 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
index 9ee3931d31e3..ecca52b45307 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
+++ b/drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
@@ -1060,6 +1060,11 @@ static const struct mdp_pipe_info mt8195_pipe_info[] = {
 	[MDP_PIPE_VPP0_SOUT] = {MDP_PIPE_VPP0_SOUT, MDP_MM_SUBSYS_1, 5},
 };
 
+static const struct v4l2_rect mt8195_mdp_pp_criteria = {
+	.width = 1920,
+	.height = 1080,
+};
+
 const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.mdp_plat_id = MT8183,
 	.mdp_con_res = 0x14001000,
@@ -1074,6 +1079,7 @@ const struct mtk_mdp_driver_data mt8183_mdp_driver_data = {
 	.def_limit = &mt8183_mdp_def_limit,
 	.pipe_info = mt8183_pipe_info,
 	.pipe_info_len = ARRAY_SIZE(mt8183_pipe_info),
+	.pp_used = MDP_PP_USED_1,
 };
 
 const struct mtk_mdp_driver_data mt8195_mdp_driver_data = {
@@ -1090,6 +1096,8 @@ const struct mtk_mdp_driver_data mt8195_mdp_driver_data = {
 	.def_limit = &mt8195_mdp_def_limit,
 	.pipe_info = mt8195_pipe_info,
 	.pipe_info_len = ARRAY_SIZE(mt8195_pipe_info),
+	.pp_criteria = &mt8195_mdp_pp_criteria,
+	.pp_used = MDP_PP_USED_2,
 };
 
 s32 mdp_cfg_get_id_inner(struct mdp_dev *mdp_dev, enum mtk_mdp_comp_id id)
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 8114c288da9c..1d64bac34b90 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -55,6 +55,16 @@ static struct mtk_mutex *__get_mutex(const struct mdp_dev *mdp_dev,
 	return mdp_dev->mm_subsys[p->sub_id].mdp_mutex[p->mutex_id];
 }
 
+static u8 __get_pp_num(enum mdp_stream_type type)
+{
+	switch (type) {
+	case MDP_STREAM_TYPE_DUAL_BITBLT:
+		return MDP_PP_USED_2;
+	default:
+		return MDP_PP_USED_1;
+	}
+}
+
 static enum mdp_pipe_id __get_pipe(const struct mdp_dev *mdp_dev,
 				   enum mtk_mdp_comp_id id)
 {
@@ -92,6 +102,44 @@ static enum mdp_pipe_id __get_pipe(const struct mdp_dev *mdp_dev,
 	return pipe_id;
 }
 
+static struct img_config *__get_config_offset(struct mdp_dev *mdp,
+					      struct mdp_cmdq_param *param,
+					      u8 pp_idx)
+{
+	const int p_id = mdp->mdp_data->mdp_plat_id;
+	struct device *dev = &mdp->pdev->dev;
+	void *cfg_c, *cfg_n;
+	long bound = mdp->vpu.config_size;
+
+	if (pp_idx >= mdp->mdp_data->pp_used)
+		goto err_param;
+
+	if (CFG_CHECK(MT8183, p_id))
+		cfg_c = CFG_OFST(MT8183, param->config, pp_idx);
+	else if (CFG_CHECK(MT8195, p_id))
+		cfg_c = CFG_OFST(MT8195, param->config, pp_idx);
+	else
+		goto err_param;
+
+	if (CFG_CHECK(MT8183, p_id))
+		cfg_n = CFG_OFST(MT8183, param->config, pp_idx + 1);
+	else if (CFG_CHECK(MT8195, p_id))
+		cfg_n = CFG_OFST(MT8195, param->config, pp_idx + 1);
+	else
+		goto err_param;
+
+	if ((long)cfg_n - (long)mdp->vpu.config > bound) {
+		dev_err(dev, "config offset %ld OOB %ld\n", (long)cfg_n, bound);
+		cfg_c = ERR_PTR(-EFAULT);
+	}
+
+	return (struct img_config *)cfg_c;
+
+err_param:
+	cfg_c = ERR_PTR(-EINVAL);
+	return (struct img_config *)cfg_c;
+}
+
 static int mdp_path_subfrm_require(const struct mdp_path *path,
 				   struct mdp_cmdq_cmd *cmd,
 				   struct mdp_pipe_info *p, u32 count)
@@ -476,8 +524,19 @@ static void mdp_auto_release_work(struct work_struct *work)
 	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 			    cmd->num_comps);
 
-	atomic_dec(&mdp->job_count);
-	wake_up(&mdp->callback_wq);
+	if (atomic_dec_and_test(&mdp->job_count)) {
+		if (cmd->mdp_ctx)
+			mdp_m2m_job_finish(cmd->mdp_ctx);
+
+		if (cmd->user_cmdq_cb) {
+			struct cmdq_cb_data user_cb_data;
+
+			user_cb_data.sta = cmd->data->sta;
+			user_cb_data.pkt = cmd->data->pkt;
+			cmd->user_cmdq_cb(user_cb_data);
+		}
+		wake_up(&mdp->callback_wq);
+	}
 
 	mdp_cmdq_pkt_destroy(&cmd->pkt);
 	kfree(cmd->comps);
@@ -501,20 +560,10 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 
 	data = (struct cmdq_cb_data *)mssg;
 	cmd = container_of(data->pkt, struct mdp_cmdq_cmd, pkt);
+	cmd->data = data;
 	mdp = cmd->mdp;
 	dev = &mdp->pdev->dev;
 
-	if (cmd->mdp_ctx)
-		mdp_m2m_job_finish(cmd->mdp_ctx);
-
-	if (cmd->user_cmdq_cb) {
-		struct cmdq_cb_data user_cb_data;
-
-		user_cb_data.sta = data->sta;
-		user_cb_data.pkt = data->pkt;
-		cmd->user_cmdq_cb(user_cb_data);
-	}
-
 	INIT_WORK(&cmd->auto_release_work, mdp_auto_release_work);
 	if (!queue_work(mdp->clock_wq, &cmd->auto_release_work)) {
 		struct mtk_mutex *mutex;
@@ -526,8 +575,8 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 		mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
 				    cmd->num_comps);
 
-		atomic_dec(&mdp->job_count);
-		wake_up(&mdp->callback_wq);
+		if (atomic_dec_and_test(&mdp->job_count))
+			wake_up(&mdp->callback_wq);
 
 		mdp_cmdq_pkt_destroy(&cmd->pkt);
 		kfree(cmd->comps);
@@ -537,31 +586,41 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 	}
 }
 
-int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
+static struct mdp_cmdq_cmd *mdp_cmdq_prepare(struct mdp_dev *mdp,
+					     struct mdp_cmdq_param *param,
+					     u8 pp_idx)
 {
 	struct mdp_path *path = NULL;
 	struct mdp_cmdq_cmd *cmd = NULL;
 	struct mdp_comp *comps = NULL;
 	struct device *dev = &mdp->pdev->dev;
 	const int p_id = mdp->mdp_data->mdp_plat_id;
+	struct img_config *config;
 	struct mtk_mutex *mutex = NULL;
 	enum mdp_pipe_id pipe_id;
-	int i, ret;
-	u32 num_comp = 0;
+	int i, ret = -ECANCELED;
+	u32 num_comp;
 
-	atomic_inc(&mdp->job_count);
-	if (atomic_read(&mdp->suspended)) {
-		atomic_dec(&mdp->job_count);
-		return -ECANCELED;
+	config = __get_config_offset(mdp, param, pp_idx);
+	if (IS_ERR(config)) {
+		ret = PTR_ERR(config);
+		goto err_uninit;
 	}
 
+	if (CFG_CHECK(MT8183, p_id))
+		num_comp = CFG_GET(MT8183, config, num_components);
+	else if (CFG_CHECK(MT8195, p_id))
+		num_comp = CFG_GET(MT8195, config, num_components);
+	else
+		goto err_uninit;
+
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd) {
 		ret = -ENOMEM;
-		goto err_cancel_job;
+		goto err_uninit;
 	}
 
-	ret = mdp_cmdq_pkt_create(mdp->cmdq_clt, &cmd->pkt, SZ_16K);
+	ret = mdp_cmdq_pkt_create(mdp->cmdq_clt[pp_idx], &cmd->pkt, SZ_16K);
 	if (ret)
 		goto err_free_cmd;
 
@@ -586,7 +645,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	}
 
 	path->mdp_dev = mdp;
-	path->config = param->config;
+	path->config = config;
 	path->param = param->param;
 	for (i = 0; i < param->param->num_outputs; i++) {
 		path->bounds[i].left = 0;
@@ -600,7 +659,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	}
 	ret = mdp_path_ctx_init(mdp, path);
 	if (ret) {
-		dev_err(dev, "mdp_path_ctx_init error\n");
+		dev_err(dev, "mdp_path_ctx_init error %d\n", pp_idx);
 		goto err_free_path;
 	}
 
@@ -608,13 +667,13 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	mutex = __get_mutex(mdp, &mdp->mdp_data->pipe_info[pipe_id]);
 	ret = mtk_mutex_prepare(mutex);
 	if (ret) {
-		dev_err(dev, "Fail to enable mutex clk\n");
+		dev_err(dev, "Fail to enable mutex %d clk\n", pp_idx);
 		goto err_free_path;
 	}
 
 	ret = mdp_path_config(mdp, cmd, path);
 	if (ret) {
-		dev_err(dev, "mdp_path_config error\n");
+		dev_err(dev, "mdp_path_config error %d\n", pp_idx);
 		goto err_free_path;
 	}
 	cmdq_pkt_finalize(&cmd->pkt);
@@ -633,7 +692,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		       sizeof(struct mdp_comp));
 	}
 
-	mdp->cmdq_clt->client.rx_callback = mdp_handle_cmdq_callback;
+	mdp->cmdq_clt[pp_idx]->client.rx_callback = mdp_handle_cmdq_callback;
 	cmd->mdp = mdp;
 	cmd->user_cmdq_cb = param->cmdq_cb;
 	cmd->user_cb_data = param->cb_data;
@@ -641,26 +700,9 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	cmd->num_comps = num_comp;
 	cmd->mdp_ctx = param->mdp_ctx;
 
-	ret = mdp_comp_clocks_on(&mdp->pdev->dev, cmd->comps, cmd->num_comps);
-	if (ret)
-		goto err_free_path;
-
-	dma_sync_single_for_device(mdp->cmdq_clt->chan->mbox->dev,
-				   cmd->pkt.pa_base, cmd->pkt.cmd_buf_size,
-				   DMA_TO_DEVICE);
-	ret = mbox_send_message(mdp->cmdq_clt->chan, &cmd->pkt);
-	if (ret < 0) {
-		dev_err(dev, "mbox send message fail %d!\n", ret);
-		goto err_clock_off;
-	}
-	mbox_client_txdone(mdp->cmdq_clt->chan, 0);
-
 	kfree(path);
-	return 0;
+	return cmd;
 
-err_clock_off:
-	mdp_comp_clocks_off(&mdp->pdev->dev, cmd->comps,
-			    cmd->num_comps);
 err_free_path:
 	if (mutex)
 		mtk_mutex_unprepare(mutex);
@@ -671,8 +713,58 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 	mdp_cmdq_pkt_destroy(&cmd->pkt);
 err_free_cmd:
 	kfree(cmd);
+err_uninit:
+	return ERR_PTR(ret);
+}
+
+int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
+{
+	struct mdp_cmdq_cmd *cmd[MDP_PP_MAX] = {NULL};
+	struct device *dev = &mdp->pdev->dev;
+	int i, ret;
+	u8 pp_used = __get_pp_num(param->param->type);
+
+	atomic_set(&mdp->job_count, pp_used);
+	if (atomic_read(&mdp->suspended)) {
+		atomic_set(&mdp->job_count, 0);
+		return -ECANCELED;
+	}
+
+	for (i = 0; i < pp_used; i++) {
+		cmd[i] = mdp_cmdq_prepare(mdp, param, i);
+		if (IS_ERR_OR_NULL(cmd[i])) {
+			ret = PTR_ERR(cmd[i]);
+			goto err_cancel_job;
+		}
+	}
+
+	for (i = 0; i < pp_used; i++) {
+		ret = mdp_comp_clocks_on(&mdp->pdev->dev, cmd[i]->comps, cmd[i]->num_comps);
+		if (ret)
+			goto err_clock_off;
+	}
+
+	for (i = 0; i < pp_used; i++) {
+		dma_sync_single_for_device(mdp->cmdq_clt[i]->chan->mbox->dev,
+					   cmd[i]->pkt.pa_base, cmd[i]->pkt.cmd_buf_size,
+					   DMA_TO_DEVICE);
+
+		ret = mbox_send_message(mdp->cmdq_clt[i]->chan, &cmd[i]->pkt);
+		if (ret < 0) {
+			dev_err(dev, "mbox send message fail %d!\n", ret);
+			i = pp_used;
+			goto err_clock_off;
+		}
+		mbox_client_txdone(mdp->cmdq_clt[i]->chan, 0);
+	}
+	return 0;
+
+err_clock_off:
+	while (--i >= 0)
+		mdp_comp_clocks_off(&mdp->pdev->dev, cmd[i]->comps,
+				    cmd[i]->num_comps);
 err_cancel_job:
-	atomic_dec(&mdp->job_count);
+	atomic_set(&mdp->job_count, 0);
 
 	return ret;
 }
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
index 43475b862ddb..53a30ad7e0b0 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
@@ -29,6 +29,7 @@ struct mdp_cmdq_cmd {
 	struct cmdq_pkt pkt;
 	s32 *event;
 	struct mdp_dev *mdp;
+	struct cmdq_cb_data *data;
 	void (*user_cmdq_cb)(struct cmdq_cb_data data);
 	void *user_cb_data;
 	struct mdp_comp *comps;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index a6c71fd9e5bf..5209f531ef8d 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -142,6 +142,10 @@ void mdp_video_device_release(struct video_device *vdev)
 	struct mdp_dev *mdp = (struct mdp_dev *)video_get_drvdata(vdev);
 	int i;
 
+	for (i = 0; i < mdp->mdp_data->pp_used; i++)
+		if (mdp->cmdq_clt[i])
+			cmdq_mbox_destroy(mdp->cmdq_clt[i]);
+
 	scp_put(mdp->scp);
 
 	destroy_workqueue(mdp->job_wq);
@@ -299,10 +303,12 @@ static int mdp_probe(struct platform_device *pdev)
 	mutex_init(&mdp->vpu_lock);
 	mutex_init(&mdp->m2m_lock);
 
-	mdp->cmdq_clt = cmdq_mbox_create(dev, 0);
-	if (IS_ERR(mdp->cmdq_clt)) {
-		ret = PTR_ERR(mdp->cmdq_clt);
-		goto err_put_scp;
+	for (i = 0; i < mdp->mdp_data->pp_used; i++) {
+		mdp->cmdq_clt[i] = cmdq_mbox_create(dev, i);
+		if (IS_ERR(mdp->cmdq_clt[i])) {
+			ret = PTR_ERR(mdp->cmdq_clt[i]);
+			goto err_mbox_destroy;
+		}
 	}
 
 	init_waitqueue_head(&mdp->callback_wq);
@@ -331,8 +337,8 @@ static int mdp_probe(struct platform_device *pdev)
 err_unregister_device:
 	v4l2_device_unregister(&mdp->v4l2_dev);
 err_mbox_destroy:
-	cmdq_mbox_destroy(mdp->cmdq_clt);
-err_put_scp:
+	while (--i >= 0)
+		cmdq_mbox_destroy(mdp->cmdq_clt[i]);
 	scp_put(mdp->scp);
 err_destroy_clock_wq:
 	destroy_workqueue(mdp->clock_wq);
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
index d6484d17b09f..8c09e984fd01 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
@@ -77,6 +77,14 @@ enum mdp_pipe_id {
 	MDP_PIPE_MAX
 };
 
+/* MDP parallel pipe control */
+enum {
+	MDP_PP_USED_1 = 1,
+	MDP_PP_USED_2 = 2,
+};
+
+#define MDP_PP_MAX MDP_PP_USED_2
+
 struct mtk_mdp_driver_data {
 	const int mdp_plat_id;
 	const resource_size_t mdp_con_res;
@@ -91,6 +99,8 @@ struct mtk_mdp_driver_data {
 	const struct mdp_limit *def_limit;
 	const struct mdp_pipe_info *pipe_info;
 	unsigned int pipe_info_len;
+	const struct v4l2_rect *pp_criteria;
+	const u8 pp_used;
 };
 
 struct mdp_mm_subsys {
@@ -115,7 +125,7 @@ struct mdp_dev {
 	s32					vpu_count;
 	u32					id_count;
 	struct ida				mdp_ida;
-	struct cmdq_client			*cmdq_clt;
+	struct cmdq_client			*cmdq_clt[MDP_PP_MAX];
 	wait_queue_head_t			callback_wq;
 
 	struct v4l2_device			v4l2_dev;
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
index a298c1b15b9e..35a8b059bde5 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
@@ -87,6 +87,9 @@ static void mdp_m2m_device_run(void *priv)
 	dst_vb = v4l2_m2m_next_dst_buf(ctx->m2m_ctx);
 	mdp_set_dst_config(&param.outputs[0], frame, &dst_vb->vb2_buf);
 
+	if (mdp_check_pp_enable(ctx->mdp_dev, frame))
+		param.type = MDP_STREAM_TYPE_DUAL_BITBLT;
+
 	ret = mdp_vpu_process(&ctx->mdp_dev->vpu, &param);
 	if (ret) {
 		dev_err(&ctx->mdp_dev->pdev->dev,
@@ -101,6 +104,18 @@ static void mdp_m2m_device_run(void *priv)
 	task.cb_data = NULL;
 	task.mdp_ctx = ctx;
 
+	if (atomic_read(&ctx->mdp_dev->job_count)) {
+		ret = wait_event_timeout(ctx->mdp_dev->callback_wq,
+					 !atomic_read(&ctx->mdp_dev->job_count),
+					 2 * HZ);
+		if (ret == 0) {
+			dev_err(&ctx->mdp_dev->pdev->dev,
+				"%d jobs not yet done\n",
+				atomic_read(&ctx->mdp_dev->job_count));
+			goto worker_end;
+		}
+	}
+
 	ret = mdp_cmdq_send(ctx->mdp_dev, &task);
 	if (ret) {
 		dev_err(&ctx->mdp_dev->pdev->dev,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
index 9b436b911d92..657356f87743 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
@@ -304,6 +304,24 @@ int mdp_check_scaling_ratio(const struct v4l2_rect *crop,
 	return 0;
 }
 
+bool mdp_check_pp_enable(struct mdp_dev *mdp, struct mdp_frame *frame)
+{
+	u32 s, r1, r2;
+
+	if (!mdp || !frame)
+		return false;
+
+	if (!mdp->mdp_data->pp_criteria)
+		return false;
+
+	s = mdp->mdp_data->pp_criteria->width *
+		mdp->mdp_data->pp_criteria->height;
+	r1 = frame->crop.c.width * frame->crop.c.height;
+	r2 = frame->compose.width * frame->compose.height;
+
+	return (r1 >= s || r2 >= s);
+}
+
 /* Stride that is accepted by MDP HW */
 static u32 mdp_fmt_get_stride(const struct mdp_format *fmt,
 			      u32 bytesperline, unsigned int plane)
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
index e9ab8ac2c0e8..b0c8f9f00820 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
@@ -368,6 +368,7 @@ int mdp_try_crop(struct mdp_m2m_ctx *ctx, struct v4l2_rect *r,
 int mdp_check_scaling_ratio(const struct v4l2_rect *crop,
 			    const struct v4l2_rect *compose, s32 rotation,
 	const struct mdp_limit *limit);
+bool mdp_check_pp_enable(struct mdp_dev *mdp, struct mdp_frame *frame);
 void mdp_set_src_config(struct img_input *in,
 			struct mdp_frame *frame, struct vb2_buffer *vb);
 void mdp_set_dst_config(struct img_output *out,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
index 49fc2e9d45dd..da3a892ad867 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
@@ -198,6 +198,7 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 	};
 	struct mdp_dev *mdp = vpu_to_mdp(vpu);
 	int err;
+	u8 pp_num = mdp->mdp_data->pp_used;
 
 	init_completion(&vpu->ipi_acked);
 	vpu->scp = scp;
@@ -211,7 +212,7 @@ int mdp_vpu_dev_init(struct mdp_vpu_dev *vpu, struct mtk_scp *scp,
 	mutex_lock(vpu->lock);
 	vpu->work_size = ALIGN(vpu->work_size, 64);
 	vpu->param_size = ALIGN(sizeof(struct img_ipi_frameparam), 64);
-	vpu->config_size = ALIGN(sizeof(struct img_config), 64);
+	vpu->config_size = ALIGN(sizeof(struct img_config) * pp_num, 64);
 	err = mdp_vpu_shared_mem_alloc(vpu);
 	mutex_unlock(vpu->lock);
 	if (err) {
-- 
2.18.0


