Return-Path: <linux-kernel+bounces-115231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031B4888DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F3B1F2A681
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112F3120B1;
	Mon, 25 Mar 2024 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzRfICY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60B297D7F;
	Sun, 24 Mar 2024 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324350; cv=none; b=K7GYzb6FWm5hW+HYrddowG1+rkYemphN8awQzyleopgDoAfFxoCIBqoiHJJZ9HkcJP5XXEdlG9EWi1BYYDwOpo1hfSh6umUwWWwhKClpQBae3nap8nl3unySBIraTV3H8qkHuQv1xuYjTlveMDDzup/ya41Iuo2v56nj08fc1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324350; c=relaxed/simple;
	bh=K2LQes7JjM0UFh5ceniDTXtDQaOnZxHXjD4dPexjMAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miioF8IVo6JEwM0ZEbNqrk0Zj12LpZNrgtE11DBGjJseZ6vTj9OOTLQGp2BDieJR/UrSwhnc73YwhFXD3WvmJWSAm7QMaqlApnqby9dOU1Ixk5wAhnhCfIGcXgEDcNjWgJNnq0JSIzj9jF/s1/NZCsz6QRF6qrLxZycSmZ+QHyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzRfICY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5CCC433C7;
	Sun, 24 Mar 2024 23:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324349;
	bh=K2LQes7JjM0UFh5ceniDTXtDQaOnZxHXjD4dPexjMAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzRfICY2h5vwuZ8hbKrnNNhupus1VeXpaKzuW12k5eiLV1bhkhCvDBEwE1fZ6SUNs
	 /CM/IMHeaq+cRfGWoWYxDgZ4Gw2o5a1ND3URWNMNY/DqUnzwiTPybVLaf+1Zz9X8KS
	 oyPAF5pQYa6mNwfu557y05D0ALgYCKtNezhPR4UHkGR5tSrIVV+YCF8/93WGvTuhYA
	 pZib8oAT5gaI7f29iQuX9ETD2Ku9pD6r6SYLX0vOjKNsCmZ92fGW8eVRDFCHZU7KfR
	 vN2Mf59OWHZy/WflMyjxM7TKTVbD3vxkv+oFsho0hJ9C2JMyan+lnk7x/uqvw09oyJ
	 PhmXkcAq8dwQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 118/148] drm/mediatek: Fix a null pointer crash in mtk_drm_crtc_finish_page_flip
Date: Sun, 24 Mar 2024 19:49:42 -0400
Message-ID: <20240324235012.1356413-119-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hsin-Yi Wang <hsinyi@chromium.org>

[ Upstream commit c958e86e9cc1b48cac004a6e245154dfba8e163b ]

It's possible that mtk_crtc->event is NULL in
mtk_drm_crtc_finish_page_flip().

pending_needs_vblank value is set by mtk_crtc->event, but in
mtk_drm_crtc_atomic_flush(), it's is not guarded by the same
lock in mtk_drm_finish_page_flip(), thus a race condition happens.

Consider the following case:

CPU1                              CPU2
step 1:
mtk_drm_crtc_atomic_begin()
mtk_crtc->event is not null,
                                  step 1:
                                  mtk_drm_crtc_atomic_flush:
                                  mtk_drm_crtc_update_config(
                                      !!mtk_crtc->event)
step 2:
mtk_crtc_ddp_irq ->
mtk_drm_finish_page_flip:
lock
mtk_crtc->event set to null,
pending_needs_vblank set to false
unlock
                                  pending_needs_vblank set to true,

                                  step 2:
                                  mtk_crtc_ddp_irq ->
                                  mtk_drm_finish_page_flip called again,
                                  pending_needs_vblank is still true
                                  //null pointer

Instead of guarding the entire mtk_drm_crtc_atomic_flush(), it's more
efficient to just check if mtk_crtc->event is null before use.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20240223212404.3709690-1-hsinyi@chromium.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index eac9caf322f90..fb7262ed9b699 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -79,11 +79,13 @@ static void mtk_drm_crtc_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
 	struct drm_crtc *crtc = &mtk_crtc->base;
 	unsigned long flags;
 
-	spin_lock_irqsave(&crtc->dev->event_lock, flags);
-	drm_crtc_send_vblank_event(crtc, mtk_crtc->event);
-	drm_crtc_vblank_put(crtc);
-	mtk_crtc->event = NULL;
-	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+	if (mtk_crtc->event) {
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
+		drm_crtc_send_vblank_event(crtc, mtk_crtc->event);
+		drm_crtc_vblank_put(crtc);
+		mtk_crtc->event = NULL;
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+	}
 }
 
 static void mtk_drm_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
-- 
2.43.0


