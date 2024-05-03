Return-Path: <linux-kernel+bounces-168299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A778BB63D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4031C20AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A4134CF7;
	Fri,  3 May 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WmeVzNH8"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA2134CDC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772266; cv=none; b=h/ZXcjY4nnnZ1TkPPQUqSoymMchthO9LrEU3Lz6cCmi7jnWPLF9AkTtZelUjfEaUw1xNUTBaHhq0f9RxW3ohq6zm+bGLgAUGGb4HRh2Qse8zw4+lkV8BZoxld6+KiLsgTk5w/CmBzMzdqgywdiBMyrg4mSI78KJEszsiRyy7t4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772266; c=relaxed/simple;
	bh=0C7Ml53z9t79QGcTfL88T3+BhLGG1chLfgvfo7p+NnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouph/0bKk72b536YZHQISCSmcJYGHFSBW4ThlclihxiIBm2Pmw+CwtpN9amQKHjUDbfJjstKwU8kI/A8MR6GpOzAMcOWcbfk0Sf0FOM4NKHz6HVZVxEC4rR3WvAho3Zp+ZuSPZPB2+Fwg1Ze9gRVZHI4IIJ0m1z0tuZ3ec2osYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WmeVzNH8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eab16c8d83so861345ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772265; x=1715377065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZDXX5+LO4KCYTMyL9bFp7mWqxckeafU4NqU6b6Zl+A=;
        b=WmeVzNH8Qw1O7QZA00O3UJ7+L4wV/q02V8OYkwGFWcpTtFWNw1xrOwAYuY7F6L0fGI
         KinINz/AmRsMP48a+Gjc3qkgWndttBkfWXPoCkgGY7UV8b9UMQazenpm1TW9sEmDYygg
         ov5gVMO9L4JxoAqkcZrtp02lKO/qADcliGjYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772265; x=1715377065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZDXX5+LO4KCYTMyL9bFp7mWqxckeafU4NqU6b6Zl+A=;
        b=Tozqtf50xZLomiJ89NvvHelvELuGz4Y36GzibePznPnYeH+pW7+vYvBBGbPafklLIx
         dCM11e9NG+CBuevzkjoe1rr/xK3vW2WlZoDI5e+KL8jvI9zZ5T57Ij8sk41iU3XKoBjk
         1LCBUwtcdrXTvbU8P43lsAgAUJpyArcwrlm/+lUW12ER6Re0zix0qige3+6innsU9X4n
         H7KAQ8k3FJzecuW1Ubh2aXVHoOlLbQfT4ApjnG9CKTXTBpyE0lsejFmPf5m+pulfephI
         tDFpdHM4r3/GD62u/pfizZE2nJrA8++vc+C+mqF9pIDctYgKKxHgB+j7fThChJtehQS8
         C+pg==
X-Forwarded-Encrypted: i=1; AJvYcCWH8SU7qs3clNHV8/vP9UX4aYpyNYu67MO3W7KSN/YLoDh4ma9cpzcVyWS8nZ1UUpsDozFIzxsbMuilVW/8HnNwf5CvF3YfW0gRueUr
X-Gm-Message-State: AOJu0YzLUfq1TwFrZjoKS9sZ0zc7VNu+2/1SnC3ovwwwGisjRW8/O/km
	m6zxzxkcHeK96crgOthJZ5ggenHuLcYo2qPetBxFy9WVMmOIbag2O4y6c2/gdg==
X-Google-Smtp-Source: AGHT+IEM/QZtMkwvjlLIFbPnkF0+gcBny1uUrL28BGWnqjNaJ9gJCfvZsyvZC8Acyq8l9IiCgiHpFQ==
X-Received: by 2002:a17:903:41d1:b0:1ec:22ca:b290 with SMTP id u17-20020a17090341d100b001ec22cab290mr5158303ple.21.1714772264830;
        Fri, 03 May 2024 14:37:44 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:44 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Werner Johansson <werner.johansson@sonymobile.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 34/48] drm/panel: panasonic-vvx10f034n00: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:33:15 -0700
Message-ID: <20240503143327.RFT.v2.34.I7278e956ffd1cf686e737834578d4bb3ea527c7f@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503213441.177109-1-dianders@chromium.org>
References: <20240503213441.177109-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

Cc: Werner Johansson <werner.johansson@sonymobile.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../drm/panel/panel-panasonic-vvx10f034n00.c  | 35 +------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index 8ba6d8287938..822ca2f971eb 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -32,9 +32,6 @@ struct wuxga_nt_panel {
 
 	struct regulator *supply;
 
-	bool prepared;
-	bool enabled;
-
 	ktime_t earliest_wake;
 
 	const struct drm_display_mode *mode;
@@ -53,28 +50,16 @@ static int wuxga_nt_panel_on(struct wuxga_nt_panel *wuxga_nt)
 static int wuxga_nt_panel_disable(struct drm_panel *panel)
 {
 	struct wuxga_nt_panel *wuxga_nt = to_wuxga_nt_panel(panel);
-	int mipi_ret, bl_ret = 0;
-
-	if (!wuxga_nt->enabled)
-		return 0;
-
-	mipi_ret = mipi_dsi_shutdown_peripheral(wuxga_nt->dsi);
-
-	wuxga_nt->enabled = false;
 
-	return mipi_ret ? mipi_ret : bl_ret;
+	return mipi_dsi_shutdown_peripheral(wuxga_nt->dsi);
 }
 
 static int wuxga_nt_panel_unprepare(struct drm_panel *panel)
 {
 	struct wuxga_nt_panel *wuxga_nt = to_wuxga_nt_panel(panel);
 
-	if (!wuxga_nt->prepared)
-		return 0;
-
 	regulator_disable(wuxga_nt->supply);
 	wuxga_nt->earliest_wake = ktime_add_ms(ktime_get_real(), MIN_POFF_MS);
-	wuxga_nt->prepared = false;
 
 	return 0;
 }
@@ -85,9 +70,6 @@ static int wuxga_nt_panel_prepare(struct drm_panel *panel)
 	int ret;
 	s64 enablewait;
 
-	if (wuxga_nt->prepared)
-		return 0;
-
 	/*
 	 * If the user re-enabled the panel before the required off-time then
 	 * we need to wait the remaining period before re-enabling regulator
@@ -117,8 +99,6 @@ static int wuxga_nt_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	wuxga_nt->prepared = true;
-
 	return 0;
 
 poweroff:
@@ -127,18 +107,6 @@ static int wuxga_nt_panel_prepare(struct drm_panel *panel)
 	return ret;
 }
 
-static int wuxga_nt_panel_enable(struct drm_panel *panel)
-{
-	struct wuxga_nt_panel *wuxga_nt = to_wuxga_nt_panel(panel);
-
-	if (wuxga_nt->enabled)
-		return 0;
-
-	wuxga_nt->enabled = true;
-
-	return 0;
-}
-
 static const struct drm_display_mode default_mode = {
 	.clock = 164402,
 	.hdisplay = 1920,
@@ -178,7 +146,6 @@ static const struct drm_panel_funcs wuxga_nt_panel_funcs = {
 	.disable = wuxga_nt_panel_disable,
 	.unprepare = wuxga_nt_panel_unprepare,
 	.prepare = wuxga_nt_panel_prepare,
-	.enable = wuxga_nt_panel_enable,
 	.get_modes = wuxga_nt_panel_get_modes,
 };
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


