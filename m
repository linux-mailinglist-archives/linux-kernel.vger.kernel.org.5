Return-Path: <linux-kernel+bounces-168278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBDE8BB624
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE37828640E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F8F130A4B;
	Fri,  3 May 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GsjJYihF"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5B130491
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772220; cv=none; b=u6wd/nM7k+laZK+STxTNOum+JsVg8PvR92CcUl/Ss7JArTU7f8mJ/ZcF+FQK893AeRjoS03Qp6DOYdVKh95MEedUsj9nq8PlmVvgnfXdSQAq5D7iK8cmw2r14IRXoy5ICgLPNE7EFC0bIZAo6byoWQNQfRtGXQQvlaCcWKDkIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772220; c=relaxed/simple;
	bh=pUdvl+CJe8eK0rPum/1lmKmhajDiQ4Bck5/6AuBlyNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcAl/XRX4HJcSCR9+5goTfHl2xaY0LxCWHu8VP9FrCC7f7iM21JTQcd72I/EPPzEhCldgMyHz2l5nr7DbfOZ6umq6t3x4vEHOHlbUeMKyMBhIqjPbsBOVFlkEgR7mkSRERHCUQ8MiMJM7swJxyC6rsSccaU+swDP5JjtRJoMRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GsjJYihF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-61bbb208ea5so98697a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772218; x=1715377018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xn3kmqG9n+u6RTxNsaXpW9ople5vt6wNE5CodtGeIeA=;
        b=GsjJYihFgTGGCHIljXbubUgByrew70L9VSqGx7fx6axVdmsx2Hg3TluPTJUFedjRt7
         ZV+rMIjNITiTL4PjESrH+sbbEFvx4Kh08hfrxDlO6Wv2mCOx9OE5610OhfcKfiuV+kfT
         QVm/M8m8Ky4nknLJTZiNG8+kZxiBN0VR+D7vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772218; x=1715377018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn3kmqG9n+u6RTxNsaXpW9ople5vt6wNE5CodtGeIeA=;
        b=YPHWsQGRYx98XcyyyBnSosiFy1kqsQSZbW/w+LEwenfGDUwlfU9we5ubwd9dbYb5SD
         j4DcCa8/aRp/1BgIf1XTA3s9Z9L6CwxqQf65yUIOhN8e2VQz2K1C92UoBjDqmWl0yTz+
         OlqbwNqNEN7Fbq+NJA3MMOHTw0wKXWJ5CAXA6MWjI8oKFvHSMaEyLIWGjI/6FPlbE3zG
         zv5AoXQHdsOlT1uVuSeBs7DyI1QIajEYzxtt2qQbK/Fp3Qo8nVururtNj94Ae2kOiel8
         9CqDgmMyBCz24Ee7M4xAmw/4u5kp/ybO5ywc6fbw+CW06Z2jCIiXBNwnRg4FqH03UVzb
         gjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUYcVclLMzAzXZyT4aYRecPAmSgwZtvjEp/5kqs2jtGrF0qM0ML7us1hd//sLGevIhW+QWMLwssHRxzhtL/gYm93/RMpsAfrC9uSSZ
X-Gm-Message-State: AOJu0YyPQNR8WRlxTxh2yxjm6Y0WTUl9lvpMTJhsRy/0O6z8c4GRJEhK
	Wd9TqI3IrG4uEvuyiqpcyOaSJx4LR91KI9wMhG7vfvcttpeqjwNhnQiJqO4M5g==
X-Google-Smtp-Source: AGHT+IHU+zTKbiqkq2N+BAjsxHc3GvfIh424IhHaVXyvXNqc/r0rVspgmWUaRIVseSK1shOdJ8cBgw==
X-Received: by 2002:a17:90b:400b:b0:2b2:9b67:198a with SMTP id ie11-20020a17090b400b00b002b29b67198amr4603020pjb.34.1714772218223;
        Fri, 03 May 2024 14:36:58 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:57 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 14/48] drm/panel: ltk050h3146w: Stop tracking prepared
Date: Fri,  3 May 2024 14:32:55 -0700
Message-ID: <20240503143327.RFT.v2.14.I264417152e65b4a2e374666010666fa1c2d973fc@changeid>
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
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 1a26205701b5..5894bf30524a 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -36,7 +36,6 @@ struct ltk050h3146w {
 	struct regulator *vci;
 	struct regulator *iovcc;
 	const struct ltk050h3146w_desc *panel_desc;
-	bool prepared;
 };
 
 static const struct ltk050h3146w_cmd page1_cmds[] = {
@@ -521,9 +520,6 @@ static int ltk050h3146w_unprepare(struct drm_panel *panel)
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	int ret;
 
-	if (!ctx->prepared)
-		return 0;
-
 	ret = mipi_dsi_dcs_set_display_off(dsi);
 	if (ret < 0) {
 		dev_err(ctx->dev, "failed to set display off: %d\n", ret);
@@ -539,8 +535,6 @@ static int ltk050h3146w_unprepare(struct drm_panel *panel)
 	regulator_disable(ctx->iovcc);
 	regulator_disable(ctx->vci);
 
-	ctx->prepared = false;
-
 	return 0;
 }
 
@@ -550,9 +544,6 @@ static int ltk050h3146w_prepare(struct drm_panel *panel)
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	int ret;
 
-	if (ctx->prepared)
-		return 0;
-
 	dev_dbg(ctx->dev, "Resetting the panel\n");
 	ret = regulator_enable(ctx->vci);
 	if (ret < 0) {
@@ -593,8 +584,6 @@ static int ltk050h3146w_prepare(struct drm_panel *panel)
 
 	msleep(50);
 
-	ctx->prepared = true;
-
 	return 0;
 
 disable_iovcc:
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


