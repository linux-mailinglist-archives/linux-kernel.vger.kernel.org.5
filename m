Return-Path: <linux-kernel+bounces-66203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123B85587C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67431F22A39
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F66134BC;
	Thu, 15 Feb 2024 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pply8qty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F112B9C;
	Thu, 15 Feb 2024 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958221; cv=none; b=hgjKiP7opNaaNJizx8BF1AiPcIKg5eoDeLLrjB2KwmePcOuhkSAGJ22Tjjqe6yc00UKgVHTdk+LAIyYT4IADs+FxMWTmnom1FZ4/woumrlerYrBHKZEiZ0WBa5nKxiX+iQId9FQMSeYNL4QboKWTuzsOAh1rXC18O8po8iUbxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958221; c=relaxed/simple;
	bh=xJOjG1xcF7TMBorsm4SdyXtFrb+p13IDHenhHoOED0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IelxtBM/IWsGwy1iyQZtUggYrOZoYjtku3LT6tw2pWH2cXUtwdoAkQwOUdPHe9ki1wgRC3g3d58W66KhkPJk7cQiUeEfjgV8GcS8tBzJggHtwBRjmy7B2onrFN+ANspIWf8aLDJjPYkp8UT3caZ6st3iJzndZuqkhz3sCByvP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pply8qty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB44C433C7;
	Thu, 15 Feb 2024 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958220;
	bh=xJOjG1xcF7TMBorsm4SdyXtFrb+p13IDHenhHoOED0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pply8qtyHCycTwTDcxWtAAj78lAggMF7xQxPbnGPKhOJDJL3X9lm/72ENeLwGlGnW
	 T2W/JeE7YzAU0dT31xlYfp72sH+kiZn+jTo8fCVrEoy/+qPKUlwaipZ83ib/JrWplc
	 2RxsQYT3X1WZmgLNUOOVs574uLaigErmr8ERocCsy5AqwKnVS+Oji0zrBzRbzQuFGx
	 TH0gfJDOGvrFRC6rMAP9phcHjoOvbUTGBNf+X38JVfYzPaVR6NYL5CE9FCVEol5WlY
	 MKy1BuKRI5AQuxoOwm3HiVSYhZl0oix/MVP479BLS/FsyLA8nPxmY0EyW9TI0q3Vs4
	 shE9D8xkp/bpA==
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 8/9] drm/mediatek: Do not store struct cmdq_client in struct cmdq_pkt
Date: Thu, 15 Feb 2024 00:49:30 +0000
Message-Id: <20240215004931.3808-9-chunkuang.hu@kernel.org>
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

MediaTek drm driver has the struct cmdq_client information, so
it's not necessary to store this information in struct cmdq_pkt.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index df693fa268ce..0d54cbefee0b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -123,7 +123,6 @@ static int mtk_drm_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *
 		return -ENOMEM;
 
 	pkt->buf_size = size;
-	pkt->cl = (void *)client;
 
 	dev = client->chan->mbox->dev;
 	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
@@ -139,10 +138,8 @@ static int mtk_drm_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *
 	return 0;
 }
 
-static void mtk_drm_cmdq_pkt_destroy(struct cmdq_pkt *pkt)
+static void mtk_drm_cmdq_pkt_destroy(struct cmdq_client *client, struct cmdq_pkt *pkt)
 {
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
 	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
 			 DMA_TO_DEVICE);
 	kfree(pkt->va_base);
@@ -156,7 +153,7 @@ static void mtk_drm_crtc_destroy(struct drm_crtc *crtc)
 
 	mtk_mutex_put(mtk_crtc->mutex);
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
+	mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_client, &mtk_crtc->cmdq_handle);
 
 	if (mtk_crtc->cmdq_client.chan) {
 		mbox_free_channel(mtk_crtc->cmdq_client.chan);
-- 
2.34.1


