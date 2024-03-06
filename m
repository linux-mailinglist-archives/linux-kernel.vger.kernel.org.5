Return-Path: <linux-kernel+bounces-93179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FA9872BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B33A1F21C15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0914267;
	Wed,  6 Mar 2024 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbHntp/1"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B1DDA8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685837; cv=none; b=UjvOOL7KzUufAGWH0c3fymyrt23phbgOElfmq5oabyYsyfMZdSBZB9pcA8Os5Uhcjn62tRLmYOtRK2k+xXEJ98JE4+VnhZp9APiREEfkUejap4fqzbp44vg12bptiVnTWVjrUbOZTUdnzLlLXZCUJXPJ2zcUwiw8cOZz/UhU6wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685837; c=relaxed/simple;
	bh=ZB+JxsmgjsLXjT4A8pwUfLxc5wjMafQmYvaibiZNEjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS5zVa5uGI7WKkc82EPJNQy1s9rB4uted8gg+3bFYJ2ibbRhpE29c/kltvY4e5AwW1ckMFTFyAkpzcbHFnTRi4kJCgp/+J+Di4QD8PkfKeGmVWgTOTM2YUK8OqZnlyOriERxqElX1GpI6/0JvvNJCjiJTSlXyBSbk4lArafZAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hbHntp/1; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c1ea5e54d3so189247b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709685835; x=1710290635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYTrgZgcMnGwzTHQ0raTPV6Zr3av/0t0vLxqDGbq+dE=;
        b=hbHntp/1YrXqW9cbxg90cWvzXqLiYgkFUO4bncJG0w+ndfLEmBcEJXaHUnNSbNR0b/
         p6quUhsteDsjpZ4k1eWzVZZXrcu5gFmQMIb6YHT7KQJv/0FNZ9ELYE5ehMpjoRDQ9utC
         AM0FcFdkpBH+5hWm9qNz9B2MKi2/454RGtXws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709685835; x=1710290635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYTrgZgcMnGwzTHQ0raTPV6Zr3av/0t0vLxqDGbq+dE=;
        b=bw8itGOMuyLm6gtnsSZ6DBWaa6fhhnF2RVDxn+xyFg4hhmmIajneHipVSF64Z8/UvL
         FnTuFl3nfNezxggPqYjOgUvBhv5HjStTRnfcxLx3IYmnhAcsly1cBwfn12Wuf14mV89X
         HpI99exSfVWLaYbGQDTPSdAXTGW/ymr3ptW9LEP+UZaTH6H/SUhpT+PxBfSr2SPIz0F6
         e8PWbLvjelQ47mn0vr2znOg0jVuuPpte3MEnnMJPJoBnsVZMPo0LVxFUBoBBzA+v4Fvd
         DFA3WEdCV0+xgfXnV2c9YXYnBA3ojfjNnISZ8jB/CUWYuZI1U2eJKpGQvCgUa+GoTien
         3VRA==
X-Forwarded-Encrypted: i=1; AJvYcCUBDK+jm8G+ONYrAY/NOwS7f208RArMlngmZylPc3WW8blMpZxrBFpnwzVLaJKEco3kjfiNUrL8/lNo6tW9tM3gStRmoIEHKs08zW/U
X-Gm-Message-State: AOJu0YxS78eh0l9nTrJKT6Qg8NivAG3vTWsW05YgS1YFG56ozYyF2OLc
	NacIOb+u2Mxiyz3NEj66HVNqHSE84mhUWeKLmHAoaK8Z/QGndzFYQ4vY+Y8Cqg==
X-Google-Smtp-Source: AGHT+IEnBwCzfwvZftrY1cUSm8yx44TS6umhWaiFT1TsIPhxo+eKQUM29yFatyjGk7F35NHZ6+gzsQ==
X-Received: by 2002:a05:6808:9b0:b0:3c1:db6b:aa7c with SMTP id e16-20020a05680809b000b003c1db6baa7cmr3045373oig.1.1709685835241;
        Tue, 05 Mar 2024 16:43:55 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:29bc:b3d:1ba8:cf52])
        by smtp.gmail.com with ESMTPSA id x37-20020a631725000000b005dc48e56191sm8512885pgl.11.2024.03.05.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 16:43:54 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] drm/panel-edp: Fix AUO 0x405c panel naming and add a variant
Date: Tue,  5 Mar 2024 16:34:05 -0800
Message-ID: <20240306004347.974304-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240306004347.974304-1-hsinyi@chromium.org>
References: <20240306004347.974304-1-hsinyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 different AUO panels using the same panel id. One of the
variants requires using overridden modes to resolve glitching issue as
described in commit 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode").
Other variants should use the modes parsed from EDID.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v4->v5: no change
---
 drivers/gpu/drm/panel/panel-edp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index fb70e97a2e71..9db04457fb4d 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1007,6 +1007,19 @@ static const struct panel_desc auo_b101ean01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b116xa3_mode = {
+	.clock = 70589,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 40,
+	.hsync_end = 1366 + 40 + 40,
+	.htotal = 1366 + 40 + 40 + 32,
+	.vdisplay = 768,
+	.vsync_start = 768 + 10,
+	.vsync_end = 768 + 10 + 12,
+	.vtotal = 768 + 10 + 12 + 6,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
 static const struct drm_display_mode auo_b116xak01_mode = {
 	.clock = 69300,
 	.hdisplay = 1366,
@@ -1966,7 +1979,9 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116XTN02.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140HAN04.0"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAN04.0"),
+	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0 ",
+			 &auo_b116xa3_mode),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
-- 
2.44.0.278.ge034bb2e1d-goog


