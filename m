Return-Path: <linux-kernel+bounces-168271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C908BB61C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76551F21887
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701DB86252;
	Fri,  3 May 2024 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mOldH39n"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006758ABC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772206; cv=none; b=HfTvmVUpSzrKTFdYXiQDtKTPaIzKOQQpz8oJcPr54QTikh3SwMtwPB92WGPI4GX9CfDnZ6vkjZJkL+awxsFjKtvm9YsDL3TbAQwVo/MF7Z5DiWG5LnQGJwW4j+jAcnVZtnvOFtzYufmgkrwMSCm15uVf8Em4JD4VbGS0IuCASpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772206; c=relaxed/simple;
	bh=UFRhW7hFxmMjKYOVgXJWmGpqqggLO+iuoq5fYFD0R2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvW1ZWJn+pK+AEokTGoxqVs5xUqigzwz8H/qUstHPg2FpBMSOdz+VHo+rCnwKPlgiD+btKXnrpBHufpoLBLAZRoUfj+FouY3LEvEUmp97CvVynudOSR0B+yZLHo7U3VAK43os7Ar0RdeeNmx3ONZzk6wcNM/aY7jyh0RBxNWdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mOldH39n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3ca546d40so1023605ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772204; x=1715377004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paGqFOJ2nhC87MmLby9MgxTeHu7XKJBlCB1L6uiDNwg=;
        b=mOldH39nPA9cGqFTxg8kr220pral2lm7wmXU7LhY+hnCLG1lXJYHoyR+trqLu30/9b
         roGQKTGuIKIIMdrBlOqudWL/QqPXzDOfqD2y3TQZjDUTj+TbcC49FfP3zqp21w4f2JHB
         ocIbBSSk6byjkYUTdYSR7GDnL8ugUso9BlQ3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772204; x=1715377004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paGqFOJ2nhC87MmLby9MgxTeHu7XKJBlCB1L6uiDNwg=;
        b=gz4g5I0ng6ENNo9V1gf86KT+bb4xpM2U+6XaKn4JkWA5dlFdxVk+faXHRsqT10Ayaz
         zaws/aUE1N04Px/mPwtWyqylRUi05CswPKQ8AIndunQtpOMoCmyXgbcras3PlyTwVSvO
         m3ypSzO4ly1h7KOedEDizdvqtI+QuHNdPDqFoLvT2Mnq81BDU6M0KtmYxllNUhlc18UK
         WltBAo1PMUJBpk7k1buqJUlAAhNOsbl/gBHSl1/1v33kOZG1wHGAT1AZz7bv8JxjorzA
         XseUfXt0M3ka1a4XQ6xC90R7QNt999rVX9PpAoIbfKvgosmzb8HbTzaNbRQWDNEOX3vB
         1PWw==
X-Forwarded-Encrypted: i=1; AJvYcCWFrDBylhW1EunvrZVqcEKMx5LHuXNJvapNXltSw+VKIK/3N/fTjElnfly5DMNoKn1W1gk5dgaRqor/NA9iAwHwL3nEU43hwFAdj3uV
X-Gm-Message-State: AOJu0YzudEvWfUZpNavaIMKJg9foQ50XlU14Muy8y39hCbdK3CaAh6kq
	ayDi7L6B54tsspbdnjg+ZZSSrGwwuL02Z/w/+/Fnqf+3HfQax1srzdsg8Z7pog==
X-Google-Smtp-Source: AGHT+IEx3Ot96pqT0JZWFoeg3B/jPEk44kYlrdOtlaungPQljCh2vyyJ0lZPjiPjtxRQep5DNsRVJQ==
X-Received: by 2002:a17:902:c40c:b0:1e4:df0c:a570 with SMTP id k12-20020a170902c40c00b001e4df0ca570mr4139211plk.8.1714772204518;
        Fri, 03 May 2024 14:36:44 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:43 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Chris Zhong <zyw@rock-chips.com>,
	Lin Huang <hl@rock-chips.com>,
	Brian Norris <briannorris@chromium.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 08/48] drm/panel: innolux-p079zca: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:32:49 -0700
Message-ID: <20240503143327.RFT.v2.8.I99c73621fe3fba067a5e7ee6a1f6293c23371e1e@changeid>
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

Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Lin Huang <hl@rock-chips.com>
Cc: Brian Norris <briannorris@chromium.org>
Cc: "Heiko Stübner" <heiko@sntech.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 485178a99910..5833d3a0fc79 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -51,9 +51,6 @@ struct innolux_panel {
 
 	struct regulator_bulk_data *supplies;
 	struct gpio_desc *enable_gpio;
-
-	bool prepared;
-	bool enabled;
 };
 
 static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
@@ -61,26 +58,11 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
 	return container_of(panel, struct innolux_panel, base);
 }
 
-static int innolux_panel_disable(struct drm_panel *panel)
-{
-	struct innolux_panel *innolux = to_innolux_panel(panel);
-
-	if (!innolux->enabled)
-		return 0;
-
-	innolux->enabled = false;
-
-	return 0;
-}
-
 static int innolux_panel_unprepare(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
 	int err;
 
-	if (!innolux->prepared)
-		return 0;
-
 	err = mipi_dsi_dcs_set_display_off(innolux->link);
 	if (err < 0)
 		dev_err(panel->dev, "failed to set display off: %d\n", err);
@@ -104,8 +86,6 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 	if (err < 0)
 		return err;
 
-	innolux->prepared = false;
-
 	return 0;
 }
 
@@ -114,9 +94,6 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 	struct innolux_panel *innolux = to_innolux_panel(panel);
 	int err;
 
-	if (innolux->prepared)
-		return 0;
-
 	gpiod_set_value_cansleep(innolux->enable_gpio, 0);
 
 	err = regulator_bulk_enable(innolux->desc->num_supplies,
@@ -178,8 +155,6 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 	/* T7: 5ms */
 	usleep_range(5000, 6000);
 
-	innolux->prepared = true;
-
 	return 0;
 
 poweroff:
@@ -189,18 +164,6 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 	return err;
 }
 
-static int innolux_panel_enable(struct drm_panel *panel)
-{
-	struct innolux_panel *innolux = to_innolux_panel(panel);
-
-	if (innolux->enabled)
-		return 0;
-
-	innolux->enabled = true;
-
-	return 0;
-}
-
 static const char * const innolux_p079zca_supply_names[] = {
 	"power",
 };
@@ -407,10 +370,8 @@ static int innolux_panel_get_modes(struct drm_panel *panel,
 }
 
 static const struct drm_panel_funcs innolux_panel_funcs = {
-	.disable = innolux_panel_disable,
 	.unprepare = innolux_panel_unprepare,
 	.prepare = innolux_panel_prepare,
-	.enable = innolux_panel_enable,
 	.get_modes = innolux_panel_get_modes,
 };
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


