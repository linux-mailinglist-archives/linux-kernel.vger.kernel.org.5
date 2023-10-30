Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAAD7DB7D1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjJ3KTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjJ3KTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:19:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09F78A51;
        Mon, 30 Oct 2023 03:06:37 -0700 (PDT)
X-UUID: fe5ad25c770b11eea33bb35ae8d461a2-20231030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=W4fChxXWjEqipdLVfa/wlv7t54t+I/P3naA+3L+8CcA=;
        b=tk6iEb/Ht3cS6IT96HGuXS/Z/riTL835+cwiy0yYlRcWE1wRyVPOXh7CTj4i3WBCSkG+M1yT7lMudcuAvnDNhRdrusOFWAcLjVkBw1No5kdAW/+hWC4VWPHIP69wsJ6oGl+DYLppcOrgD7Rz4+PJkqZJpR7aRkImTViWcilCCLE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:d8a6f461-f3c7-49f0-94a3-a5dcdc7d431a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:ac257bd7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe5ad25c770b11eea33bb35ae8d461a2-20231030
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 486475564; Mon, 30 Oct 2023 18:06:29 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Oct 2023 18:06:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Oct 2023 18:06:27 +0800
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
Subject: [PATCH v8 02/12] media: platform: mtk-mdp3: add support second sets of MUTEX
Date:   Mon, 30 Oct 2023 18:06:16 +0800
Message-ID: <20231030100626.12564-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231030100626.12564-1-moudy.ho@mediatek.com>
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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

After setting up the second set of MMSYS (VPPSYS1), it is necessary
to have a corresponding second set of MUTEX (MUTEX2) to assist in
handling SOF/EOF.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
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
index fa59f8ab1b47..8959f83eb5b5 100644
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
@@ -305,9 +323,16 @@ static int mdp_probe(struct platform_device *pdev)
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

