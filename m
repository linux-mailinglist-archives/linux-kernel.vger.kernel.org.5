Return-Path: <linux-kernel+bounces-66204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B785587E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AFF1C22926
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67CD13AFB;
	Thu, 15 Feb 2024 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA9i2nL5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82F17C9;
	Thu, 15 Feb 2024 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958223; cv=none; b=cDxAu97ObkaHDUN4DJkDtvEmTs0EPXVhh/1SMfk76KxDVg6WkiN6dHJGBI/JdQdp6mmZtoIs7Ow5ojV16vpUriLX3OGESzokjDKcMCCAuPS3ZdGSXgE90LualFw62LclULK3K/NA0KM+HUkkHLgTiIsMl/J3ynuca+70E9D2XXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958223; c=relaxed/simple;
	bh=Nd1NDjS7PBGCZG08y1pbAZotjpMonshTocV35vaQvPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReuxusgrJGmRxvNPcCwP69frpM4sIE+ZSrhEHTE7qu7b8fq5WHFJBV+TrWmap4NeU2LP+bSdLKthMzX5bdPCfsSyztIyUPOYiqQDCHpU9vC0RpjR7tqxGA7ud7Ilhaqxe7uOUTNflAQ7u5KgRgGs1aQRAvPerHx6IEmWoAu8F6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA9i2nL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3104C43390;
	Thu, 15 Feb 2024 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958222;
	bh=Nd1NDjS7PBGCZG08y1pbAZotjpMonshTocV35vaQvPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sA9i2nL58Za9xrOfR+gqXKLVZ0NKkmamnkgCtT0P5X4TWIOo6ibmYISUE7llg9e+u
	 tuCatNrBIrc6+xUJfvduqvXb2nBh0JUYUq2BWQlA4FzjD1bMRLelrwrrTWPmEpWNLK
	 bYN+RU6kIpY5wdWugtL3RfkFhThv/2LMw1ZrO2+iao7mk0JT8t4mdZ8rn9ANWMW0aI
	 eiVdeCSWceN6PO5VZSK7X77B7ZTAYKrmV+OYbPbGl1VcQv1sxoVnJ38OUBET1ZRcSX
	 ewu0//pYNU77x6grOglmUCuv+FYRUODlSfu4xvn24rvLrtDSVbEFee1m7YbLXzFmIw
	 4vO8WodC74HXw==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 9/9] media: platform: mtk-mdp3: do not store struct cmdq_client in struct cmdq_pkt
Date: Thu, 15 Feb 2024 00:49:31 +0000
Message-Id: <20240215004931.3808-10-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215004931.3808-1-chunkuang.hu@kernel.org>
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MediaTek mdp3 driver has the struct cmdq_client information, so
it's not necessary to store struct cmdq_client in struct cmdq_pkt.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index a420d492d879..6aa32ab018b4 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -298,7 +298,6 @@ static int mdp_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *pkt,
 		return -ENOMEM;
 
 	pkt->buf_size = size;
-	pkt->cl = (void *)client;
 
 	dev = client->chan->mbox->dev;
 	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
@@ -314,10 +313,8 @@ static int mdp_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *pkt,
 	return 0;
 }
 
-static void mdp_cmdq_pkt_destroy(struct cmdq_pkt *pkt)
+static void mdp_cmdq_pkt_destroy(struct cmdq_client *client, struct cmdq_pkt *pkt)
 {
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
 	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
 			 DMA_TO_DEVICE);
 	kfree(pkt->va_base);
@@ -341,7 +338,7 @@ static void mdp_auto_release_work(struct work_struct *work)
 	atomic_dec(&mdp->job_count);
 	wake_up(&mdp->callback_wq);
 
-	mdp_cmdq_pkt_destroy(&cmd->pkt);
+	mdp_cmdq_pkt_destroy(mdp->cmdq_clt, &cmd->pkt);
 	kfree(cmd->comps);
 	cmd->comps = NULL;
 	kfree(cmd);
@@ -388,7 +385,7 @@ static void mdp_handle_cmdq_callback(struct mbox_client *cl, void *mssg)
 		atomic_dec(&mdp->job_count);
 		wake_up(&mdp->callback_wq);
 
-		mdp_cmdq_pkt_destroy(&cmd->pkt);
+		mdp_cmdq_pkt_destroy(mdp->cmdq_clt, &cmd->pkt);
 		kfree(cmd->comps);
 		cmd->comps = NULL;
 		kfree(cmd);
@@ -513,7 +510,7 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 err_free_comps:
 	kfree(comps);
 err_destroy_pkt:
-	mdp_cmdq_pkt_destroy(&cmd->pkt);
+	mdp_cmdq_pkt_destroy(mdp->cmdq_clt, &cmd->pkt);
 err_free_cmd:
 	kfree(cmd);
 err_cancel_job:
-- 
2.34.1


