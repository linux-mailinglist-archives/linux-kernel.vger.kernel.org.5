Return-Path: <linux-kernel+bounces-115511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4098688A142
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D68B61DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A508E23A757;
	Mon, 25 Mar 2024 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9pPtA/v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7512B14F;
	Sun, 24 Mar 2024 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320963; cv=none; b=M98OX2XUcRePB2f+tbhk7UL2cdDqTfdrEVqsYmDxaOsK3w/PQr4Gc7gC8mVcALMS1hq23KoLjSuLvwCUq/OJWwajqB1Sm/JpS9QNFRI5pYVVFPhswnB+Avz1IdnAMeysxDEcrgExcLvswkYjEw3o0WZMC6RnklMV/ubG/jCXev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320963; c=relaxed/simple;
	bh=rgiZlLUltNQDY4/R2SiXzwENx3XKfYBgoDJHJnEjr6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDsFA12qmrOfxGavu8+qJReHthQ8QEz9/2cxXhPjVJeCuwPlJ0WY/pv40sqErdMgHY54XiQ3BE1PmyD6LQaNiKl/y4B+zI1D+Q8GIZc3NowUTzxB6EoSERxexyEt1hFc6uedWFzvv9mHvitRplVKw74P1+5wn9mwfU5GokUz1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9pPtA/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34CCC43330;
	Sun, 24 Mar 2024 22:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320963;
	bh=rgiZlLUltNQDY4/R2SiXzwENx3XKfYBgoDJHJnEjr6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9pPtA/vxPAXg0sxhpRQ4qqYXl1P/qpd6c9dN30Mra9umTvRE9q5YpBJTXGZuF7BE
	 JBKYpmd87B4KhhAatWjO4CkQNGbV8gz8jJFL87hMbCngmlAt7oGeSMjKnex+gwHcZK
	 KV6YeW6ZSnF+mQZD4KEdNEKpEvi3lGyZJ5PCYQN+P5GyjmbqmFDrLdPm5ap+shp/Pv
	 MAD8uF4FDrY3MsmlL+nDK1QHsz1Gk+LFHAA9LLgLzLW3lULtc1BuRq0Y86/JFXy4Eb
	 bT0dnkKHb9a27/ZEf4o1fdGthNk1B/BdMbeAE+TDGv2Q2WzKlTfNlDo9Yb9XZRgosY
	 bALcfJsUNWwYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 526/713] drm/mediatek: Fix a null pointer crash in mtk_drm_crtc_finish_page_flip
Date: Sun, 24 Mar 2024 18:44:12 -0400
Message-ID: <20240324224720.1345309-527-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index db43f9dff912e..d645b85f97215 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -95,11 +95,13 @@ static void mtk_drm_crtc_finish_page_flip(struct mtk_drm_crtc *mtk_crtc)
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


