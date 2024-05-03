Return-Path: <linux-kernel+bounces-168263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDDA8BB5E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A346D1F24018
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56A358ADD;
	Fri,  3 May 2024 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gLdR0Ljo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34517C66
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772187; cv=none; b=VXMKLyxase7SvM1/1ErMWeZXFdh+ZgnF8f12sfs52qR2A1Q2BslAQ3R4yvk5GIZyRW9O/BTN7KpMtY749SMtLXem96PD7DOFAPiau3orMznkt3V14ZnQDULwopXhLzcu2VxdzkGlvwmI/bA51RTAWYNONPRnj8cyaBLx0C3esR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772187; c=relaxed/simple;
	bh=6eKY39M68/49dXV9yzY99XqInd1/An5lKqtN9hFr4eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwmQQose3P7prGbs3yjACQN41IU0/87/vU9nr1YL/H5h9QwhwTjDFOXRR6WlcQzLvCsz1XoOm/JZla6FLC4HMMRSHJfTAE0hWoPiU7+fyxrAoTTT5oQADohVVuJH+dlvYAa8tdSywJRhd8nLlX6TBeMSYG5cQhAN58dDOWb0BEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gLdR0Ljo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ecd9dab183so19696595ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772185; x=1715376985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+m8p2+fwwMHEcaYlRhsoMqeDao9Xs+fgyRTTXxpyQQ=;
        b=gLdR0Ljo8e8+WliE57Au+b5S4xMrWZ5Pnxvsk+UmcMeLF7PNiWFVS83UjL3JsY7M6n
         ZDeWr44H2tnekNUSpW8xo/aQq/nrHO5zJzvERD9es3Xc3dMzVNAu3+ythI/xzx17g+tI
         jRvuFEr97Xs/LBf4XUvhRsFd5c2mD8MA3E0V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772185; x=1715376985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+m8p2+fwwMHEcaYlRhsoMqeDao9Xs+fgyRTTXxpyQQ=;
        b=uH/kI5mc2qlywFRDFOXh/u46Xdc6Jt05J0ihTIc2N2XMBziBnGVAEsYstV/ImAnzGZ
         FKkESO7C1rGCU6bk41EY/2YIysdyMZGtxMARzPp42Gx3V8oi6ZEFXEBjVRAdz1G/G01i
         Ib1PbQp87cDxPwOsf5oinwfLrN1oNWc98+ORSHGDdD/fbUXoLiDgRlm7EayfLbmECsqb
         Z+bvTVUUZ87oBORd2yT6kOGi4WIKuDmrMYRGvRZpwzc7HUBw4lujHDibDrXEvmNv/X5z
         hVAf2AjtJ/8C0pK6pkyoGiWbgqcl1kFGGybloOPK+yZAOfeRWMmlNlWGbsSTviE/90gD
         zTGA==
X-Forwarded-Encrypted: i=1; AJvYcCURXoNszNgHVHtFOWx1kdHAWaTaNWYuUeJjED8+RgHBCFxJKsuxe102iTJfjvGgj9DTJYFcy2ftR1Jc+fkjQe2CygwV37G7OEslzJCH
X-Gm-Message-State: AOJu0Yx41ad+65IEDEu5BfiihBTxtpO9uNj/WLwZWAtQRHjiwI/FqI9U
	P3ORp1Eaam2AgPz+Z46VD0X8/R9PvRsVMnfGBvJQKOCAehiZj+PuUSB/iQpL6g==
X-Google-Smtp-Source: AGHT+IEe8XlbR/2YlPVfssvvzVEwgr7rfoy9E26NkJtjDWBN5xy4JZSBQ68VuPVn9y4gwaS+LyUeIg==
X-Received: by 2002:a17:902:c407:b0:1e5:e676:4b09 with SMTP id k7-20020a170902c40700b001e5e6764b09mr5664110plk.25.1714772185179;
        Fri, 03 May 2024 14:36:25 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:24 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 01/48] drm/panel: raydium-rm692e5: Stop tracking prepared
Date: Fri,  3 May 2024 14:32:42 -0700
Message-ID: <20240503143327.RFT.v2.1.I784238de4810658212a5786b219f128460562a37@changeid>
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

Cc: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- New

 drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
index a613ba5b816c..21d97f6b8a2f 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
@@ -23,7 +23,6 @@ struct rm692e5_panel {
 	struct drm_dsc_config dsc;
 	struct regulator_bulk_data supplies[3];
 	struct gpio_desc *reset_gpio;
-	bool prepared;
 };
 
 static inline struct rm692e5_panel *to_rm692e5_panel(struct drm_panel *panel)
@@ -171,9 +170,6 @@ static int rm692e5_prepare(struct drm_panel *panel)
 	struct device *dev = &ctx->dsi->dev;
 	int ret;
 
-	if (ctx->prepared)
-		return 0;
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable regulators: %d\n", ret);
@@ -213,8 +209,6 @@ static int rm692e5_prepare(struct drm_panel *panel)
 
 	mipi_dsi_generic_write_seq(ctx->dsi, 0xfe, 0x00);
 
-	ctx->prepared = true;
-
 	return 0;
 }
 
@@ -222,13 +216,9 @@ static int rm692e5_unprepare(struct drm_panel *panel)
 {
 	struct rm692e5_panel *ctx = to_rm692e5_panel(panel);
 
-	if (!ctx->prepared)
-		return 0;
-
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
 
-	ctx->prepared = false;
 	return 0;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


