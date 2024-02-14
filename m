Return-Path: <linux-kernel+bounces-64831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749C85435F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DCA1F240CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744BB11709;
	Wed, 14 Feb 2024 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UCWbp50Y"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A010A2C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895488; cv=none; b=di6e7zzqZsaRMnP5cqVbdvn5HJplq5V8n6i0TX0QNqvxEnzVlyc0LlQOu0dwu3dWH6MUj8rarbtE/3F9k1jw5rDglmplXrAEFX4D/TsqY+FcZRISjg11c5D0+ngd5Sxl4BLKsgnGYIRQnSEiNofzHVFzaXuCC14HoYGo4AR8xTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895488; c=relaxed/simple;
	bh=XMsYQSn4+iYQiua8f57NL1Mz4S82ZkbiMxdXhjqPYio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nn9BllDxO94rAhKSYpGAPDK+6g0C88P5K8WBtHTNn6VEUhsj9Ixwi7t2bLr9DVnOPvvGgfGaZQ9LjWu2m0tuo8qfs2omLEUIaDAavnBYIRX123eD7IJXAAeKlJbZ0lrP3DvL4cJtMTpEsMn1jP92bqocjcrUnhD3QKBdBiGVnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UCWbp50Y; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e10e50179bso107083b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707895486; x=1708500286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sg/3QYKNiqClt5O0Rsi2fxy3eaHE++NDSM8zl4s0ReY=;
        b=UCWbp50YFwEzKIK86LI/gXG1qbtiLDN9aMGQUEZX+OWEJEveaz1FJkeFDnucBWbW5d
         CUnmCNR+LRR1eGQctjTyUQJddI+/n+w/hOH1gmVvYcWmI5PZ5swB76buUIBR5ODls9Fw
         xnwyy97/WUTT02v+QRZIDJWrYmIi+/kA1Syxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707895486; x=1708500286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sg/3QYKNiqClt5O0Rsi2fxy3eaHE++NDSM8zl4s0ReY=;
        b=lEv8vhf4a1EcjSr8KEcB+So1fizM1uol9B3eHYiN/HdwhOg8yM0xfsvIqZrfxvG91W
         w8tWbKB9BH660Ypqe7PPSV8g0vr7Rcx/+I0K/jWGGV2cfIYItM4jzFlPTv/GRYeNR8jQ
         VPKDnjGGPamPRj4ueaTdV7obziUxACzvSEunrdYdMbcw8mvDpJs7QYQByR+FFrE7xV6i
         GbA3Hz9rCVNDLG/QStTNgbyN6s2WPGeW+DP6RtYGBLDt0cjx6s/Kh+NAxDj3s6A5+BRu
         tO6wG7KphVUAhy4PjACJeDLtJZsSaewg5xX0Pfw8/nmO250b8KwP9J86mxmqhdjOtrVj
         2rVA==
X-Forwarded-Encrypted: i=1; AJvYcCXQDXZ+U5hm5fa6z4wcVOnfsB4iGsWnuURfmsqdbVQ8zMPcXfbTDFcG8EM8zp1FCNMyeZqiyhmeQ4Kn9Ls1JJPGRvfcpBPXfITY4Qa0
X-Gm-Message-State: AOJu0Yzq24Ojq4m8q+atY+2+DMFOL1FdDv/acbYhA1B37CX4uhxSO7fR
	ZXKgCWGa/qIrGIWJiyRyeHLxO7PiKVFulzqgqRJwGOGirh59kaNcuRuMwHeung==
X-Google-Smtp-Source: AGHT+IHWbMtV63iwSm28tHkn/2uPWUswzI/yZYK3Z2XzyqiZ9BVUhRH9TCq/XmElpxGcwmayReWaZg==
X-Received: by 2002:a05:6a00:80ce:b0:6de:3b41:2845 with SMTP id ei14-20020a056a0080ce00b006de3b412845mr1267315pfb.32.1707895486644;
        Tue, 13 Feb 2024 23:24:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4/g6RttGYyHt4IsNRLuOZdesxIRm+ez9N3te0y7PNHNxkbAq/gfLjGQNAA8z6y+2HAxio50rLlkidsgRuThahQI8gXckBUsWdA7WZSzQiAcxb9SpIVyMkSsKgMzrtEAlr3TgSM7nIUhWLvxGINc8amjEYn+9pFOzlyVoI4HYAKPM4UERGfxjzs7RVfiojfETdZdXgnKWA3WDuMfCwjahbDVCNano0PFs6wUC99uaefO1NT3sek53MrBW3QXKnSJfKtt1NcCV77IleVY0RoP5BaLqylO0kcdhmOzn8T6x6/F+JSQ8hVsMM6v3fakLTpryWxM6hDn+4NZdHBuQklWp/1ewEIyZWPif76A==
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:3a01:e2cd:4e75:f52d])
        by smtp.gmail.com with ESMTPSA id n8-20020aa78a48000000b006e03bc76711sm8548314pfa.165.2024.02.13.23.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 23:24:46 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drm/panel-edp: Add auo_b116xa3_mode"
Date: Tue, 13 Feb 2024 23:22:54 -0800
Message-ID: <20240214072435.1496536-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 70e0d5550f5cec301ad116703b840a539fe985dc.

The overridden mode fixes the panel glitching issue on mt8186 chromebook.
However, it causes the internal display not working on mt8173 chromebook.
Revert the overridden mode for now to let mt8173 have a functional display.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 7d556b1bfa82..bd71d239272a 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1002,19 +1002,6 @@ static const struct panel_desc auo_b101ean01 = {
 	},
 };
 
-static const struct drm_display_mode auo_b116xa3_mode = {
-	.clock = 70589,
-	.hdisplay = 1366,
-	.hsync_start = 1366 + 40,
-	.hsync_end = 1366 + 40 + 40,
-	.htotal = 1366 + 40 + 40 + 32,
-	.vdisplay = 768,
-	.vsync_start = 768 + 10,
-	.vsync_end = 768 + 10 + 12,
-	.vtotal = 768 + 10 + 12 + 6,
-	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
-};
-
 static const struct drm_display_mode auo_b116xak01_mode = {
 	.clock = 69300,
 	.hdisplay = 1366,
@@ -1963,12 +1950,10 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116XTN02.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140HAN04.0"),
-	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0",
-			 &auo_b116xa3_mode),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
-	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1",
-			 &auo_b116xa3_mode),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
-- 
2.43.0.687.g38aa6559b0-goog


