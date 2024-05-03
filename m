Return-Path: <linux-kernel+bounces-168295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1798BB638
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6D11C23C32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D242F134423;
	Fri,  3 May 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJTtGeG4"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4D13343F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772258; cv=none; b=YQqO75STdXYhZAEA56DSZdjZJCCUb7Cc51nWLfd1IOmIrMQuvbCydT28q97AxSlPJMAiweDtaobcJugbNtOyEgVX5GghFAGoB0Lmvlyf6L8+zIMsJ0msU9NK0bOxSHgym5Ak7MVmI595PY5fBc0ckQxHTsgcY60jIKXofsm0XiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772258; c=relaxed/simple;
	bh=DzF0LuqgWgJiKJScMe6Jcg8gTZgCyWUsbhFN4tw2nSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXVOM5bsKCj9T7T3n8+vYrjusbgxo9TiulqBVt3/TeB9j9/iRoRVvqcNtr+5Qy73aj/J8H16hI9vd3Zxs7+hogM1nWkZMw79Q1nNml1M7pKGQPOlNdcY8S1m9jnfi3GUb7FM7UuwmpTlYv5tXi1L1kRMeHzpvlU38A/f2HUmXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BJTtGeG4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so1227255ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772256; x=1715377056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiw1xydznhtSh3tRBtRhpS0zYaaoLUo2meLrU+lEUtM=;
        b=BJTtGeG4h0a8kZ+e7/uqU3aAN54RtbR9+ZrHgPA3yztRVTJcSzzzCfev6cJb5NRZ+j
         5JtV3UxplkGCANX8auKLp9OI7SjgSBeeRQgAFe7hSA3r4yAVHrSNN5s6L681TnumBquX
         2hKjKT5jniLKaE0KUCRAojaoS6TkSsK/J4ngI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772256; x=1715377056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiw1xydznhtSh3tRBtRhpS0zYaaoLUo2meLrU+lEUtM=;
        b=dJIWNnGXRwtQF8LnaJowTOw14zf50RAE8NE2wq9n0QVVAtMzvGuueV3d2doQHBnGMY
         vNQJEfOhByfw7FvXgz52pk858fi6w041vIdWrWVUPV991WD1920Wgfdc602xn7iVNx/7
         J9/KIGbi8BEqu7u6BUXccU39OdtDY2yKbKEUeQL9n3ShYWdaTok0xlJym717I55gGm4e
         wvi2ZRGqpOPoIZt7JVz718GZKQ9K6Rr9A93QtS1Ok21o1tfV6M5Cle2cVziAPoqVxzXy
         +OBdyOSTVarWuJrxjR1FksvxTJ7bAtK1WgBqNKI/bY2poTET9a9CI7nwTMDKZynqGm+M
         8Lqw==
X-Forwarded-Encrypted: i=1; AJvYcCXoP41wkhumlUh7RnD+/rnNGNlI0WGfPPf1LHJEWqaGU8PU/6bFT1FihyTiIsR6uYDt8sP+CoiqjuMbASEbN3GjhMXJJF2eoF/YvgIj
X-Gm-Message-State: AOJu0YzCJbfeOhcOiWx20DDNbDp0mva9AIxVvnAYkbisAyZo6tW8n4fd
	snX2KuNioIyMwEdVUaqbdbsmqN+BSM9Gkz8GyrP3nIiFlR9U+tOf5SMULbRazX9EL0sR5LPDUO2
	AHg==
X-Google-Smtp-Source: AGHT+IFe81rGj8McqUJlsjyFTCj7SugLiyekq3wZXTXyN5wCjggXDovNiqeay6g57DA6tB8RQd7/nQ==
X-Received: by 2002:a17:902:e750:b0:1e7:b7a7:9f20 with SMTP id p16-20020a170902e75000b001e7b7a79f20mr5609022plf.59.1714772256078;
        Fri, 03 May 2024 14:37:36 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:35 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 30/48] drm/panel: xinpeng-xpp055c272: Stop tracking prepared
Date: Fri,  3 May 2024 14:33:11 -0700
Message-ID: <20240503143327.RFT.v2.30.I2145be78ce28327f4588c2c21370f22fd79d28b8@changeid>
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

Cc: "Heiko Stübner" <heiko@sntech.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
index 8670386498a4..8262c00670cf 100644
--- a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
+++ b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
@@ -52,7 +52,6 @@ struct xpp055c272 {
 	struct gpio_desc *reset_gpio;
 	struct regulator *vci;
 	struct regulator *iovcc;
-	bool prepared;
 };
 
 static inline struct xpp055c272 *panel_to_xpp055c272(struct drm_panel *panel)
@@ -136,9 +135,6 @@ static int xpp055c272_unprepare(struct drm_panel *panel)
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	int ret;
 
-	if (!ctx->prepared)
-		return 0;
-
 	ret = mipi_dsi_dcs_set_display_off(dsi);
 	if (ret < 0)
 		dev_err(ctx->dev, "failed to set display off: %d\n", ret);
@@ -152,8 +148,6 @@ static int xpp055c272_unprepare(struct drm_panel *panel)
 	regulator_disable(ctx->iovcc);
 	regulator_disable(ctx->vci);
 
-	ctx->prepared = false;
-
 	return 0;
 }
 
@@ -163,9 +157,6 @@ static int xpp055c272_prepare(struct drm_panel *panel)
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	int ret;
 
-	if (ctx->prepared)
-		return 0;
-
 	dev_dbg(ctx->dev, "Resetting the panel\n");
 	ret = regulator_enable(ctx->vci);
 	if (ret < 0) {
@@ -209,8 +200,6 @@ static int xpp055c272_prepare(struct drm_panel *panel)
 
 	msleep(50);
 
-	ctx->prepared = true;
-
 	return 0;
 
 disable_iovcc:
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


