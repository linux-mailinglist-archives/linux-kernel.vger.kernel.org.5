Return-Path: <linux-kernel+bounces-113389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F4A8883F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE42A28356A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E661A2128;
	Sun, 24 Mar 2024 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dbq/uSZA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71291A1A79;
	Sun, 24 Mar 2024 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320191; cv=none; b=Ed3rYTL9EL4414GXK8xvixeSMQ04PPZ+F+1OITMt8M/9gKzVC4fMlAbojDG5noLe+xHXvTiVyBNtPDsKAqoIze2nXwhn+1gJOtmhulK23OhakPi/SlvVzBdqPhbCZFBgQXzmOExIqAkSQsWACHSV9TrsMiUE26Nks4uE4CcY7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320191; c=relaxed/simple;
	bh=U3bsBoW5R9uLm8pCwqeekjmg/fPe++eB4CD1hfRCU+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzqwdNSEPXAENCiEXDLKLRcU5MuvOBRWko0jDPulx9VyMsKD+oDKLIcqsV1gzLJfu+/KHw6nsofUJX1GZovCw24/aTWTtn+QWiZ97FY7iMZhES2OpRjIlDZa9s70+pW0TknPNIlNTycMzqu1EkP8oqNE4s6uvlOlPV7Ak6jsUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dbq/uSZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4F0C433B2;
	Sun, 24 Mar 2024 22:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320190;
	bh=U3bsBoW5R9uLm8pCwqeekjmg/fPe++eB4CD1hfRCU+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dbq/uSZABuahqWdAvBzJrOEZCzFi+FVqkQrPFqSg+uPR9l0juWmTETeKq8vi5/wIc
	 x76tEZcZYVBq5u4VuMupN7w8AOs57S4gegrnEhdPpDilqE51c9+QsmwKkTx4X3ZLUb
	 G9Qjvxiv4uhhznDtkUOlodV/WRLy+ZIMVt2DJZT5ISafUgrD7fejV7u2yAF0FGsDLb
	 SW357jzEnYKEnCX+KG/em4yzM17TBARPJXj6Yxg1LQkzp4yxuTrM6b+AFCW3lNu/hz
	 OFvABkIoLEnsW2s/MqCkjCo9TyQBVZpPqILQnat8lKxGn3wlxnA0ddc+fYW8z5/sLw
	 9EzGQj8BaTlqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 498/715] drm/mediatek: Fix a null pointer crash in mtk_drm_crtc_finish_page_flip
Date: Sun, 24 Mar 2024 18:31:17 -0400
Message-ID: <20240324223455.1342824-499-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index c729af3b98224..3d17de34d72bd 100644
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


