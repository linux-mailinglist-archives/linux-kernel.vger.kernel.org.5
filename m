Return-Path: <linux-kernel+bounces-168280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293588BB626
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949E51F213EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1A176023;
	Fri,  3 May 2024 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxghZ9NU"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA85130A77
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772224; cv=none; b=ZiR42a/80Ghycc++ySFUMwYiOcsp4G8juS+KHhnz1EN2WeKjYqbFO2kC4P7Xi1oXcbxi55F2pSwME0IOVTQRDIxsVwgRJxF3F1N5CBgtWKHpqmsQFLe4tzpI01xjuG4pOQRdDtZnt0y+9OQClaF/EuflvSc8il0BuZYR2Uy9584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772224; c=relaxed/simple;
	bh=btGKXLjURzhe5xM/tx4DR6oxHtKq4a2amrCKwZa0vtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8RDIuxuYYwPhIDYXqDkVFPaL/bzsHG8z/CcTX0iv6gHMCXnC9hGxD3x/WZvGP8JdZFhX9PxCYMbrscRTAYwraxe745LUNPvDScEcgpD1yo6Cxv2EnoeTbjBG+1pG+O0S746oO5BrJY8XCRR9ALzorBNMxjCUdtruCplV3sOU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VxghZ9NU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ecff927a45so1150465ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772223; x=1715377023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGe/o9E+2J3mWXQ+Ut7332ISLmsjuHNvcfhFlYYK3u0=;
        b=VxghZ9NUwz8oXKAK0uJYfGXv8cZTORQWDqKrr1JpGbWsjpm0R/+nJ5FzeBbUSFpmrh
         DEnqI7NuS0yfMBZhhFpfk7Mtg7OJyliKFsd3uYh57UyhL0F0tQB4M+j5IhjmcYJzq5nP
         G+B9DFMueq/nB8R+ZxkgV0W6chIWGSduDcQe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772223; x=1715377023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGe/o9E+2J3mWXQ+Ut7332ISLmsjuHNvcfhFlYYK3u0=;
        b=YuLfzjgoHJOlijAPrpgyxO1WDATxBzkqVtBf90fJFuJMCRnHpdqc+tj5WpfwQvqe5E
         Jg90eaMijdx1Ra0Jm9JgPsNkw+OwCw2cOMs7QANRBhC17IVz2VBr6R4UM8egqDM23leb
         X2zEuueMtozkX58QoDIk358aVDIJKlN9ST3MFx6p6/FqyvyrIleu3wr1wD6Kh8cEK4sZ
         EEkqSyuazIwZoRIMrB+iAv30dmkSqVnvf1MyUXc1yIAcAOidZv6b50GV36m//50i7Dau
         5Elin7sdeLFRe3SGRLthKVUo8Lna6bSv/fOxvbsgG8DmBM0vGsKyEyTA7rz7jqxDnxmH
         YAsA==
X-Forwarded-Encrypted: i=1; AJvYcCX7QYjajAd05JqUTEpJ921K6DziFyNHwnVZ9JdwJ9NVrMh1i7CWCQ/bSz5IOqUPiMhzzm93qE2gkAcTZeVPh1CPBWsMvwB3I1up5smR
X-Gm-Message-State: AOJu0Yw//tpEOtQ9fevsM3oOlocgtvC1XQk3ytFNztqD2ZOdCuGYpKFS
	MNAi1/AVTyfCm60sORQYAIhuMmZbGthW5/cBtMl+rw8cvVRItUyAymlRGLnkgw==
X-Google-Smtp-Source: AGHT+IEgRFrCTmA76ZQ+ZA/ZsnLrxvKdZ+FvjBO/HzwbNFAg+uY38D+QTINvkSf/bzeDzCo33IN3pA==
X-Received: by 2002:a17:902:d386:b0:1e7:d492:1206 with SMTP id e6-20020a170902d38600b001e7d4921206mr4129620pld.53.1714772222926;
        Fri, 03 May 2024 14:37:02 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:02 -0700 (PDT)
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
Subject: [RFT PATCH v2 16/48] drm/panel: ltk500hd1829: Stop tracking prepared
Date: Fri,  3 May 2024 14:32:57 -0700
Message-ID: <20240503143327.RFT.v2.16.I4f574b87fe24765ddd4424437159b37a6481aa1a@changeid>
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

 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
index a4c9a5cb9811..ef27cab08f1d 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
@@ -40,7 +40,6 @@ struct ltk500hd1829 {
 	struct regulator *vcc;
 	struct regulator *iovcc;
 	const struct ltk500hd1829_desc *panel_desc;
-	bool prepared;
 };
 
 static const struct ltk500hd1829_cmd ltk101b4029w_init[] = {
@@ -492,9 +491,6 @@ static int ltk500hd1829_unprepare(struct drm_panel *panel)
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	int ret;
 
-	if (!ctx->prepared)
-		return 0;
-
 	ret = mipi_dsi_dcs_set_display_off(dsi);
 	if (ret < 0)
 		dev_err(panel->dev, "failed to set display off: %d\n", ret);
@@ -510,8 +506,6 @@ static int ltk500hd1829_unprepare(struct drm_panel *panel)
 	regulator_disable(ctx->iovcc);
 	regulator_disable(ctx->vcc);
 
-	ctx->prepared = false;
-
 	return 0;
 }
 
@@ -522,9 +516,6 @@ static int ltk500hd1829_prepare(struct drm_panel *panel)
 	unsigned int i;
 	int ret;
 
-	if (ctx->prepared)
-		return 0;
-
 	ret = regulator_enable(ctx->vcc);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Failed to enable vci supply: %d\n", ret);
@@ -568,8 +559,6 @@ static int ltk500hd1829_prepare(struct drm_panel *panel)
 		goto disable_iovcc;
 	}
 
-	ctx->prepared = true;
-
 	return 0;
 
 disable_iovcc:
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


