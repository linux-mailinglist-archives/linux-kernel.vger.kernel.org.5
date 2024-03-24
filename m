Return-Path: <linux-kernel+bounces-115117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D61D9889315
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E182953A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B00513E6B1;
	Mon, 25 Mar 2024 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFkW1kTR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EABF181D14;
	Sun, 24 Mar 2024 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324145; cv=none; b=R5HCWSa59aj8M0QWoXFt+FlrDSZKFezJGGtB3hwyGMjlQFh+s2PoYn06ZNUO4mGYTvuCGupGIhiAaEmQvVU1ANWYDYgy1gh3f/TRvJxUHaKrDDhFxcpQ4C3YhAkJZj+jbydYK7h16YbWIMst5fTMLMNInvIravG+jrvF+iyhuak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324145; c=relaxed/simple;
	bh=+gT7l8HpU8Uq4f+qx3MRIipMm61GVqvFsyy4BLwDIJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TO0vxL4bi0zwBuFn/qsOVXRq1nsCG3Ri4ebA9Lx/Nw5Xv5M/KEa788C+Kn95njCcateGqlsZsizoU6elVZYfUb/hoLfwM5oIBy1yz/kGONPszhiC6i9fB+xdNdtXk+UIug21vDc2fyigbSv0z0E/Naz7QtBE/nF4m/sBarzk17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFkW1kTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C748AC433B1;
	Sun, 24 Mar 2024 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324144;
	bh=+gT7l8HpU8Uq4f+qx3MRIipMm61GVqvFsyy4BLwDIJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XFkW1kTRMx39KV4xsIkvYY6qxXfszWU7qUb1rSrgNhpYmalt+7vF/yZ4gh/KtPVVj
	 5+jtRUE2p3Yb9Lspzf0Wn/mTpA97Bz4/Cfu9R/uZm+LqrVfRYRWW5Z4uIqfdGq6JWe
	 qJf1mTgDgBnPqrVtwzCzhjn0uJH0Rrv2zXtssKA9eoS9ZNyf/LG320tnDkJUNYR9DF
	 iBKNQ4GViI6sVmFOZ+mU5M4zp0n1nOnNRGoqIX29NhmgeWk4xCqpGiCjRI5EOnNv8p
	 elccfgMH5Qt50qssduXEFuL9sRDNoqtEcqAWTa6Roax1GiKsM8Kv70qu49MwL4q7Tf
	 PfDkM2XbzynfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 140/183] drm/mediatek: Fix a null pointer crash in mtk_drm_crtc_finish_page_flip
Date: Sun, 24 Mar 2024 19:45:53 -0400
Message-ID: <20240324234638.1355609-141-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index f370d41b3d041..9bbad33500691 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -73,11 +73,13 @@ static void mtk_drm_crtc_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
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


