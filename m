Return-Path: <linux-kernel+bounces-168275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3078BB620
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C465B24E3F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD4B12EBFA;
	Fri,  3 May 2024 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UBgEKdDI"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093212C7FD
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772215; cv=none; b=tucUR5gcoHyEK6E5WQSPivtoscvFjpQGS04c7jhCV9FZaXV3vGwg9K8lCO++LldRRLdTDbI1kb5paOOW/b9th2AHhsjx0BwEUoasSxMWWQhweVoAQT4tp8Li4q0uiVLj3JwS857SibbKawRubrymdpkvloEdNt9UGaSLXBAv0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772215; c=relaxed/simple;
	bh=NzqglraYiL6N3znxl8ANLNzO3z0wT085E7fsKkcmN34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7PClL5CyAtTBdCKANfu8jyZSu/kbLiygJMkSzpgEEImE1L5BI5kyZEPzQFACvRPSPAFed2ZW6LSLN6Scp1zs+5lrNd+JdL40fStBbpWWyRgrw5geUOVzIVvCPdUq2/UU+4ZKKgxUYYUHPDWv8A79TKDRhfAXUs9qe98zivrqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UBgEKdDI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed835f3c3cso1038125ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772213; x=1715377013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIbC9LrwuAAq79Jeay6jAxq6GRcu3tw3vRcfcGuhdCM=;
        b=UBgEKdDI1ZHtsaGmHM9Mx3gEYjF39JjqLknDtVO0VOr8cG0G0rLrU3K40QvsW1vU66
         hSJYF2E1s93K7/6k802hTyS0zS+Ws3bZtDrJkn5580Y3YAmgqb00tUg1rI9sLVCujzec
         EOCS7UFc251wcXfqypJYS36V8BfNADtafJSDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772213; x=1715377013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIbC9LrwuAAq79Jeay6jAxq6GRcu3tw3vRcfcGuhdCM=;
        b=TPyBhdahB3z5T53dOlPN+Ws7jiZu4MpAFGqNgaE4rcv27/J5OoW1/WJ5D0r7JrRVDm
         1PR3Mh4O0tm1D/HB8X4nS0gXnsjqU6gEg2XP2yT13GiVeEAs4S9icXBWznjVtGJtD6OI
         dGrSl5b+klcN6oeOCWW5ZlrhjKAJAuKfNFKLBlf2kogXzjLIt6cRXGuNe4Mclue88ldw
         UeHPRbf6/zHHGvabaAnD4qtmnqkL40X4AfLWGqS52U8Sf7jGkcNpPvDarsFRrWkvwqhb
         5hFnQbaVpJcO9yBpfQP/tkDJJWrkGSnt88EIdIECqzOAItXaD8UkjWjeygM2aTVG3pdA
         uZnw==
X-Forwarded-Encrypted: i=1; AJvYcCV1SVH5sP1KsJWtS/thYECLx8grNdaBwpFdM3ItVD0yTXmppdkcbZGjUNAlSUx5IKwYfOATJfuCQ7VmQHETRjCae/3mwASfk+gylQPf
X-Gm-Message-State: AOJu0YzaOAo1ccfQNgUU4x+DT//h7ahkh4J0isXMRJm8ed0Rr+Wtj0Pr
	OI5le7sD28TiRN8KZBKibPljjZJaA15xv5O/XtPCM7JnKy9MUX2Qv1d9iXW6AA==
X-Google-Smtp-Source: AGHT+IEJVtpxW/vIwHLrsnoyEyV1IoA8JCw5mhGllbU5SBDs6pbVC07r9dJwje7IMXdKxtbI6jQipw==
X-Received: by 2002:a17:902:9f98:b0:1eb:6468:7fc3 with SMTP id g24-20020a1709029f9800b001eb64687fc3mr3513255plq.62.1714772213125;
        Fri, 03 May 2024 14:36:53 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:52 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Chris Zhong <zyw@rock-chips.com>,
	Nickey Yang <nickey.yang@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 12/48] drm/panel: kingdisplay-kd097d04: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:32:53 -0700
Message-ID: <20240503143327.RFT.v2.12.I711d07c4f4738df199697fd534c452cdfa46a21f@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503213441.177109-1-dianders@chromium.org>
References: <20240503213441.177109-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

Cc: Brian Norris <briannorris@chromium.org>
Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Nickey Yang <nickey.yang@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../drm/panel/panel-kingdisplay-kd097d04.c    | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 17f8d80cf2b3..88d775e000d4 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -23,9 +23,6 @@ struct kingdisplay_panel {
 
 	struct regulator *supply;
 	struct gpio_desc *enable_gpio;
-
-	bool prepared;
-	bool enabled;
 };
 
 struct kingdisplay_panel_cmd {
@@ -185,15 +182,10 @@ static int kingdisplay_panel_disable(struct drm_panel *panel)
 	struct kingdisplay_panel *kingdisplay = to_kingdisplay_panel(panel);
 	int err;
 
-	if (!kingdisplay->enabled)
-		return 0;
-
 	err = mipi_dsi_dcs_set_display_off(kingdisplay->link);
 	if (err < 0)
 		dev_err(panel->dev, "failed to set display off: %d\n", err);
 
-	kingdisplay->enabled = false;
-
 	return 0;
 }
 
@@ -202,9 +194,6 @@ static int kingdisplay_panel_unprepare(struct drm_panel *panel)
 	struct kingdisplay_panel *kingdisplay = to_kingdisplay_panel(panel);
 	int err;
 
-	if (!kingdisplay->prepared)
-		return 0;
-
 	err = mipi_dsi_dcs_enter_sleep_mode(kingdisplay->link);
 	if (err < 0) {
 		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
@@ -220,8 +209,6 @@ static int kingdisplay_panel_unprepare(struct drm_panel *panel)
 	if (err < 0)
 		return err;
 
-	kingdisplay->prepared = false;
-
 	return 0;
 }
 
@@ -231,9 +218,6 @@ static int kingdisplay_panel_prepare(struct drm_panel *panel)
 	int err, regulator_err;
 	unsigned int i;
 
-	if (kingdisplay->prepared)
-		return 0;
-
 	gpiod_set_value_cansleep(kingdisplay->enable_gpio, 0);
 
 	err = regulator_enable(kingdisplay->supply);
@@ -275,8 +259,6 @@ static int kingdisplay_panel_prepare(struct drm_panel *panel)
 	/* T7: 10ms */
 	usleep_range(10000, 11000);
 
-	kingdisplay->prepared = true;
-
 	return 0;
 
 poweroff:
@@ -289,18 +271,6 @@ static int kingdisplay_panel_prepare(struct drm_panel *panel)
 	return err;
 }
 
-static int kingdisplay_panel_enable(struct drm_panel *panel)
-{
-	struct kingdisplay_panel *kingdisplay = to_kingdisplay_panel(panel);
-
-	if (kingdisplay->enabled)
-		return 0;
-
-	kingdisplay->enabled = true;
-
-	return 0;
-}
-
 static const struct drm_display_mode default_mode = {
 	.clock = 229000,
 	.hdisplay = 1536,
@@ -341,7 +311,6 @@ static const struct drm_panel_funcs kingdisplay_panel_funcs = {
 	.disable = kingdisplay_panel_disable,
 	.unprepare = kingdisplay_panel_unprepare,
 	.prepare = kingdisplay_panel_prepare,
-	.enable = kingdisplay_panel_enable,
 	.get_modes = kingdisplay_panel_get_modes,
 };
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


