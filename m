Return-Path: <linux-kernel+bounces-114601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EAF888BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C073B2B144
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FD129F6DA;
	Sun, 24 Mar 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjtzFzcR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A152319F9;
	Sun, 24 Mar 2024 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322249; cv=none; b=h9EUR+Skqk8DsCpKwXFFfYYSVZqrJoZQ+9UzPJsAH0QokjXDAP2KT9SaYqP66xiMoUOSqQaGoCjeHNisI/2kTVGlEV4tczWRarxPxtGiJiFXz1bIw3mcrSyiWmyV4sws0hGL4XvYal+AwFINgzEdBXvnjS1b7u6bq4eJIkdWF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322249; c=relaxed/simple;
	bh=+cppP47C2kH8155iAsn7GBfaimEltlIPM7HNR1hx8hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1dwwUT8JZ+dlh76OJcuYzu/xcn9srbCY4cx11VMzrtMoRrgX3hTlS7RfwHx8Vn9pblILCZKKoQQxUESKosUWOwE4p1YTLHMRWxU690g9+k0GpgfVTjxB9TJ51hm+PP3xCdg5n+QrGnEMsw9ULrNwT1WnxJezk5TLfyAQ663Rp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjtzFzcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA802C433F1;
	Sun, 24 Mar 2024 23:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322248;
	bh=+cppP47C2kH8155iAsn7GBfaimEltlIPM7HNR1hx8hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjtzFzcRkIp5J1uy0oYrbel01RwzbWTGCKq/gqwkGoflrS1JebxT6jDrJIuKrKyOo
	 FA3YW1NJjQPQT5Evwh2OPWUILDymv//xnRE+oZk5A+6QBU7lkb5Gtx3dq9gWhC4h6q
	 Yi8MGx11mJgUEEu7pTqYMbn6Go7MNG+9kzt/3KQKZWIQbM5eEUH/nIeDmHnBLNM3fw
	 3otglHaY2MMStjggWIZMfFv3esJUDo2WfYNRXBM7vIzsEwCQMMHaFfuZHdBeT8Jx1b
	 UIB0dYpAGLVRQP27Es7W4wUEKfbGVzKx5bdLft9GxnT8IwzRjlVJsCitV0g7regvND
	 iHKPkHZQtK71Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 330/451] drm/mediatek: Fix a null pointer crash in mtk_drm_crtc_finish_page_flip
Date: Sun, 24 Mar 2024 19:10:06 -0400
Message-ID: <20240324231207.1351418-331-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 558000db4a100..beaaf44004cfd 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -91,11 +91,13 @@ static void mtk_drm_crtc_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
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


