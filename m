Return-Path: <linux-kernel+bounces-76809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E1685FCE3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF241F276A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D817814E2DB;
	Thu, 22 Feb 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMRvnplW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C21586D5;
	Thu, 22 Feb 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616525; cv=none; b=sxSa02wZirBnpcJkilJCP0v+WI68ddtYmM3dyPoGkDXZMNR4b52hPZLvh8IgUhFxv5KMj1ASUpy+PZs9Z2CZEJhastAApmER3eiNQ0HFg5NaFcp+FFzMpPlRISu+5A/7XlsYvms/mHerDaMuZ/hN3KJkAGtWCe/I07mYxfr4jlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616525; c=relaxed/simple;
	bh=KgDcscSofoiJ56aGo6M+RgNx0sKZfbHtKRJhpGa5w9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QeP32PtRGHVbmLzCIoWfIPdk7JeBf39IlyJiUMKdx2/MgYaVWrixGnwcKebrc8Kj4tCGFL4Rf5iB/AuFHGlXPEAr5cunC+cd2xJaeGQ2+/kYVKQ4Sjr1iHx5BHPn/sfqPTExVY7MwAe2yQ1lG1vQZAgDY4j+NC0Q62v7oWz2X20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMRvnplW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC892C433C7;
	Thu, 22 Feb 2024 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616524;
	bh=KgDcscSofoiJ56aGo6M+RgNx0sKZfbHtKRJhpGa5w9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMRvnplWNr4x0m1A+BadooEBnvlrCUQoEAi8eDvoZ+gs9jt023jMYy/vdPgGMCIKI
	 x33RQJpFw+SxNgNabT81f1WfKax8FGGnF9UJnY9lu3j/U2X71coiWNQsTaXgfBGHWN
	 THMaQqWamo0XU3LXS/PgxKfbWZ6Cn0uYEsQb3XAE9MjtUtxVX79jxi6AwUMj8jKLuI
	 u82Q/MhXrWsx7vu0l+55IQ73dIjtFyP85ep2vjjpNpk9LnM9j2BlsKF7ZGvtnr4io2
	 psVBM4eLtJgkJ4EepXV4lNx0tVKVKwb0SK3RSNDeI419yC5tLFi4m/1f/Nu2HEDccJ
	 fN6JTn/mWt9Fw==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Moudy Ho <moudy.ho@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 11/12] media: platform: mtk-mdp3: Use cmdq_pkt_create() and cmdq_pkt_destroy()
Date: Thu, 22 Feb 2024 15:41:19 +0000
Message-Id: <20240222154120.16959-12-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222154120.16959-1-chunkuang.hu@kernel.org>
References: <20240222154120.16959-1-chunkuang.hu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use cmdq_pkt_create() and cmdq_pkt_destroy() common function
instead of implementing mdp3 version.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 45 ++-----------------
 1 file changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index b720e69b341d..c7a9f142102d 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -287,43 +287,6 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 	return 0;
 }
 
-static int mdp_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *pkt,
-			       size_t size)
-{
-	struct device *dev;
-	dma_addr_t dma_addr;
-
-	pkt->va_base = kzalloc(size, GFP_KERNEL);
-	if (!pkt->va_base)
-		return -ENOMEM;
-
-	pkt->buf_size = size;
-	pkt->cl = (void *)client;
-
-	dev = client->chan->mbox->dev;
-	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
-				  DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, dma_addr)) {
-		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
-		kfree(pkt->va_base);
-		return -ENOMEM;
-	}
-
-	pkt->pa_base = dma_addr;
-
-	return 0;
-}
-
-static void mdp_cmdq_pkt_destroy(struct cmdq_pkt *pkt)
-{
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
-	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
-			 DMA_TO_DEVICE);
-	kfree(pkt->va_base);
-	pkt->va_base = NULL;
-}
-
 static void mdp_auto_release_work(struct work_struct *work)
 {
 	struct mdp_cmdq_cmd *cmd;
@@ -341,7 +304,7 @@ static void mdp_auto_release_work(struct work_struct *work)
 	atomic_dec(&mdp->job_count);
 	wake_up(&mdp->callback_wq);
 
-	mdp_cmdq_pkt_destroy(&cmd->pkt);
+	cmdq_pkt_destroy(mdp->cmdq_clt, &cmd->pkt);
 	kfree(cmd->comps);
 	cmd->comps = NULL;
 	kfree(cmd);
@@ -388,7 +351,7 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 		atomic_dec(&mdp->job_count);
 		wake_up(&mdp->callback_wq);
 
-		mdp_cmdq_pkt_destroy(&cmd->pkt);
+		cmdq_pkt_destroy(mdp->cmdq_clt, &cmd->pkt);
 		kfree(cmd->comps);
 		cmd->comps = NULL;
 		kfree(cmd);
@@ -418,7 +381,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 		goto err_cancel_job;
 	}
 
-	ret = mdp_cmdq_pkt_create(mdp->cmdq_clt, &cmd->pkt, SZ_16K);
+	ret = cmdq_pkt_create(mdp->cmdq_clt, &cmd->pkt, SZ_16K);
 	if (ret)
 		goto err_free_cmd;
 
@@ -513,7 +476,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 err_free_comps:
 	kfree(comps);
 err_destroy_pkt:
-	mdp_cmdq_pkt_destroy(&cmd->pkt);
+	cmdq_pkt_destroy(mdp->cmdq_clt, &cmd->pkt);
 err_free_cmd:
 	kfree(cmd);
 err_cancel_job:
-- 
2.34.1


