Return-Path: <linux-kernel+bounces-168307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD3B8BB648
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F4D287471
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE8A136E2A;
	Fri,  3 May 2024 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wt7wtQzG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB56136E11
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772283; cv=none; b=CKHCKyuSMgjl/Zbn5Uf2NgFiFiyz7NqORTJ4MTENfQftfSqGIWvWUqreWu4i3YJAhTbVh/jQnzHPq1rdUNbm/02Y5/rxfGJzCxAME+Ujua0qGSAO8FCQjHXFVU1d3dR1AxCY1Iu7BKK1HXe3CT9yt7ln4Woi75c919yUMrCTaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772283; c=relaxed/simple;
	bh=p2r3mEXPVq4U9AmL2VfNexuyR3rhW1JY39L1T4gDQwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JldSM3EVCSRtJX3Ut1nArGpskvefMPpvQJLttlSVueXzYvRM34EeWeuF92EQikhFJ7iVWiI4dfSgXrjiB66J3H877MdZhLDjr/jrDumL34KRUQbA99oRL1OT5BgdJSe30zaWWtynD5AuONCBcnIt7nfpMyU8rJrJXXRXRKMaODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wt7wtQzG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so1229475ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772281; x=1715377081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOvFNgXxe6qEzRRoKPzkEzJ39gwB1A9FbXbUkRknuEw=;
        b=Wt7wtQzGDvK67/PxUMmf/aMBIQ7IgpIhA6djyCoAobXGV+Ak9nDiFRq0AjmDEeLmdC
         jpPe5BbLVFohJsmQbk7onue2NepTLTUrRbYi7e/N3BDxum7Fp4ZkNmmkp/4SooYaaOKB
         o55k3e978ZlgYwovqEitAzWuRiUeCUEFlGxdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772281; x=1715377081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOvFNgXxe6qEzRRoKPzkEzJ39gwB1A9FbXbUkRknuEw=;
        b=XmCpqOdItBdwxt72BIjUS0yU25e00vfJ18kZsIBeuOW+VkuHSyWK8KdCvFE6PtNLuD
         ErBbbxf0UaafKCIZ+ZTYs+f3DelYWbYZge83Ds8vYJmA7HCPim+ImvQVOUr++Vzz6adN
         R7rEXZ+Vpdv/JXo112tCVPC6f/hWc2ktccCjcJ8YKDCU8vclaqZzGTL4DD8FFEP4Jqph
         jdWMEYGlYXw5HSP9BHFIyVUOWUXhf9SMQwZGDs6tScDBDyitScvvvkSmZJ1IMPzL334y
         DPogMTkxDK1nag8wJ8FwmCWfAmEjlYAmWt97S65WWjOFhaNO+Rtin9BUScyL+8jIkvPk
         P9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKWD2ZvJiXI/B0Znf0Z37q92EGflRlysUcQyLjfkKtic6dECxfIgLEHMFTJZuZZVjbmhljOTxQF6zrsdCMtuYUsPau3XlJ5wz4zw0y
X-Gm-Message-State: AOJu0YyTk2eL6GSoCxQVDvq9DtZu+aZuJK4Jr4qHsagC4kbKqlEKfBkH
	CH+ca/YKcZKNRpIwb2CJVFBKCXGNErxTtp60/A9t/hixTMySBhU8wuZr8FwvRA==
X-Google-Smtp-Source: AGHT+IHrBPFGeCVyz9PhiRgLD7O2XHD+TE0AOUrKe6M9eH4/MHjdlKw55SmMJ/LL6GSiVhzwWHgbFw==
X-Received: by 2002:a17:902:f70b:b0:1ec:ad62:fe87 with SMTP id h11-20020a170902f70b00b001ecad62fe87mr4441606plo.56.1714772281144;
        Fri, 03 May 2024 14:38:01 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:38:00 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Frank Oltmanns <frank@oltmanns.dev>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Purism Kernel Team <kernel@puri.sm>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 42/48] drm/panel: sitronix-st7703: Stop tracking prepared
Date: Fri,  3 May 2024 14:33:23 -0700
Message-ID: <20240503143327.RFT.v2.42.Ifc436b262d72f1a33ddef10adfd7578d4acb60d8@changeid>
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

One thing to note for st7703 is that it has a special "allpixelson"
debugfs file. When this file is written the driver hacks a
disable/unprepare and then a prepare/enable to try to reset the
panel. Potentially that might have been relying on the old booleans we
removed. It'll still "work" because of the checks in the core but it
deserves a comment. This debugfs file didn't appear to be particularly
safe to use even before this patch since it would cause a
disabled/unprepared panel to become prepared/enabled.

Cc: "Guido Günther" <agx@sigxcpu.org>
Cc: "Ondřej Jirman" <megi@xff.cz>
Cc: Chris Morgan <macromorgan@hotmail.com>
Cc: Frank Oltmanns <frank@oltmanns.dev>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 7d8302cca091..6b2d940640ca 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -58,7 +58,6 @@ struct st7703 {
 	struct gpio_desc *reset_gpio;
 	struct regulator *vcc;
 	struct regulator *iovcc;
-	bool prepared;
 
 	struct dentry *debugfs;
 	const struct st7703_panel_desc *desc;
@@ -752,13 +751,9 @@ static int st7703_unprepare(struct drm_panel *panel)
 {
 	struct st7703 *ctx = panel_to_st7703(panel);
 
-	if (!ctx->prepared)
-		return 0;
-
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	regulator_disable(ctx->iovcc);
 	regulator_disable(ctx->vcc);
-	ctx->prepared = false;
 
 	return 0;
 }
@@ -768,9 +763,6 @@ static int st7703_prepare(struct drm_panel *panel)
 	struct st7703 *ctx = panel_to_st7703(panel);
 	int ret;
 
-	if (ctx->prepared)
-		return 0;
-
 	dev_dbg(ctx->dev, "Resetting the panel\n");
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 
@@ -793,8 +785,6 @@ static int st7703_prepare(struct drm_panel *panel)
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 	usleep_range(15000, 20000);
 
-	ctx->prepared = true;
-
 	return 0;
 }
 
@@ -854,7 +844,13 @@ static int allpixelson_set(void *data, u64 val)
 	dev_dbg(ctx->dev, "Setting all pixels on\n");
 	mipi_dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
 	msleep(val * 1000);
-	/* Reset the panel to get video back */
+
+	/*
+	 * Reset the panel to get video back. NOTE: This isn't a
+	 * particularly safe thing to do in general because it assumes
+	 * that the screen was on to begin with, but this is just a
+	 * debugfs file so it's not a huge deal.
+	 */
 	drm_panel_disable(&ctx->panel);
 	drm_panel_unprepare(&ctx->panel);
 	drm_panel_prepare(&ctx->panel);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


