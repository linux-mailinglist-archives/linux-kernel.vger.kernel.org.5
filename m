Return-Path: <linux-kernel+bounces-79206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2417D861EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A814728BB24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ED714939E;
	Fri, 23 Feb 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="abnqJsqt"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4C149382
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723453; cv=none; b=EYOMO/QsDCuz4MD5JdRNk/cPxvXo/oOxXipN+HxMH0552IM1ylFyzj/C9LmulxPgbXn0q2FWmiQ3tYlxtdmEN2+7BuAMAE5WfRLvSS3cN3UkllsXa5BQkR3JqIuyZouwdp/APxqZYSUd/PhkAqrblr9+5fIGzVwr6d1VjOPpDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723453; c=relaxed/simple;
	bh=M33J+0Pv453G1Jv4haCud5wnpPj0c4hnwqkFQXtoS4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DM1CxDdIf/exU1tVggra8SwsUJoU35H+lYbnLOuYcuMqhKBmEryi0wLQDQuYU+Dr1kPPU95q2/u0lJAqG9Fwx3JaC8Y0MiZw5IBApVI1h6el6W8C8168485nHFARK0SlgN09+TvL3Ez8qkrVJU9ugwP/R7nK/V+8MMSubNYEnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=abnqJsqt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d911c2103aso5665295ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708723449; x=1709328249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0M8Ho4hghHsHT9QadaKTfyu0riwtgTi9mQkpLqOU5Dg=;
        b=abnqJsqtEtnNmLwzBbNfqyuQh0+hAXypX/EBmTXcPvICdLmMrgH51gDJUyWXJKZoJW
         xcB1n6M1+QJxxr3LliUivrxFqX4vPn1CS8qH0ufNKhHpe7B3u6zWXBVCXwNFB5iHr542
         6RaoMpZsefpv9P40SwtCE92S1s2UKBiyk5OVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723449; x=1709328249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0M8Ho4hghHsHT9QadaKTfyu0riwtgTi9mQkpLqOU5Dg=;
        b=k8PZj3rtfhw34LVercLbw8pfihxlKxzSeonBZFciMTTVm+AzgvPRBrTPG3iopsaFhx
         656tkA28+74e3L7RN9bQeyB9J6pl7nrFgnkyfeHcLSu1YgwvDYoEANyLGYiEjffBAqU9
         7hV9KB+yGtlIuXv/gV+U+yDT3XiSyVEuF3qcpVh6tiW1ujltm+p4/rRuOatD/l6lKvBQ
         6BEbTwHxhz+Cqs+HtNlInXwZX25DXM15uXiumPVRRi21m49GVO9I7iT1wsAQjfXR5vna
         TnrMD/DbQuu3K7MLf8fhq5SiXZEItR0dlaFHYL9WLUM65lgqPfA9JO3P138OsUu1OlNE
         zJCw==
X-Forwarded-Encrypted: i=1; AJvYcCVrFs6g7a0WHv9mpzLVpuSMlx8jS9opjqYETOo+0aGSJxCK1X4RDGaDLBazfclyh75THLHC+o8MeW8FucUVWzSDoJ1zTZblwPsEyHcS
X-Gm-Message-State: AOJu0YxLwbn5SkoZ4cRDeH6BGribwqgzgmEzagoOQvwt2+ymPzDRE17T
	ySkrfxerB0D5eZRpmfbZ2M6cjtszreO0D8QH5mRrOktsuWqsuEaFFpM5iA+GIA==
X-Google-Smtp-Source: AGHT+IF/iOCf8G84HtjaG5OPfPAZChzYV76riZA2G3uYSX6UcLKBg0B+sc+slfUuIZE19uyFrsPkxw==
X-Received: by 2002:a17:902:7b87:b0:1d9:a2b1:8693 with SMTP id w7-20020a1709027b8700b001d9a2b18693mr1106969pll.23.1708723449437;
        Fri, 23 Feb 2024 13:24:09 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:8ff9:a089:c05c:9af])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001db4b3769f6sm11970413plg.280.2024.02.23.13.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:24:09 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/mediatek: Fix a null pointer crash in mtk_drm_crtc_finish_page_flip
Date: Fri, 23 Feb 2024 13:23:29 -0800
Message-ID: <20240223212404.3709690-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index db43f9dff912..d645b85f9721 100644
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
2.44.0.rc0.258.g7320e95886-goog


