Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE9F770A82
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHDVIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjHDVIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:08:07 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D1E559E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:07:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f090310dso2442063b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691183237; x=1691788037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K4pAadzRZN083YWndwfDzadQIgjy+stzVGii5iIJGU=;
        b=T1UYVJsN721ozkISMV86q9Yazgfhma0y3bUeJgLTkokFM2FXoQfsXSElONE+8QorfW
         6KJCMyYa6HwgGob86Pamhm3mAAKLOuEG/C24hVShpaprAQaj9ga275WVxyVBsuNTp4Xq
         4YsIw1eOx9vVerNFIlXmAaIu6WLUGVO5/Ovsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183237; x=1691788037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+K4pAadzRZN083YWndwfDzadQIgjy+stzVGii5iIJGU=;
        b=kWaxTDyHtCTTLteBhMDbTbBTzVLB1/vedAyePrz3q11FIRLR4QJiZOnyyCSl/ydM7c
         05tOm0JijHFtB9w44cPcj0IRkrVRRkgjjWm4H7/CdNftYVFbp+J5Xt8wtlnPsJO/LxZg
         0Hm2swsKfSt3xYAGjFrxLGXM9+qVAC87JO/OPptwaEufiw3Cb/g0aV/38SF7KxWolK9w
         FR/ryZxbI6l+EErfrzRtqWbWul3HSi/rXWu4swBJ7HT/dKIUTBGXjopKjDFQyOuKH3eR
         D8foJ3U9sQrCzBtomsMF1nUoO3t4jP+NeXkM9fSGOA+epzftQ02RJk6cwKbqnENcL13v
         zbAg==
X-Gm-Message-State: AOJu0YxpBjoaMkxq8cirCi/Fw1cwucTcOyC8MSI3K5iSI7J+mNvRwBLu
        s1wjsT34jxk69q0nhqGsUWxCxw==
X-Google-Smtp-Source: AGHT+IGmH6I8v9mGTkjyzHcFPAzmzyunDSLA0TNtyofGKN5WngoOgQ9qT4q8whBF8qocjpEoAnGaUA==
X-Received: by 2002:a05:6a21:7189:b0:133:f860:ac42 with SMTP id wq9-20020a056a21718900b00133f860ac42mr3100626pzb.34.1691183236984;
        Fri, 04 Aug 2023 14:07:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e186:e5d2:e60:bad3])
        by smtp.gmail.com with ESMTPSA id n22-20020aa78a56000000b0068664ace38asm2037584pfa.19.2023.08.04.14.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:07:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/10] drm/panel: s6e63m0: Don't store+check prepared/enabled
Date:   Fri,  4 Aug 2023 14:06:05 -0700
Message-ID: <20230804140605.RFC.2.Iabafd062e70f6b6b554cf23eeb75f57a80f7e985@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230804210644.1862287-1-dianders@chromium.org>
References: <20230804210644.1862287-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

For the s6e63m0 panel driver, this actually fixes a subtle/minor error
handling bug in s6e63m0_prepare(). In one error case s6e63m0_prepare()
called s6e63m0_unprepare() directly if there was an error. This call
to s6e63m0_unprepare() would have been a no-op since ctx->prepared
wasn't set yet.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
index b34fa4d5de07..a0e5698275a5 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
@@ -270,9 +270,6 @@ struct s6e63m0 {
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *reset_gpio;
 
-	bool prepared;
-	bool enabled;
-
 	/*
 	 * This field is tested by functions directly accessing bus before
 	 * transfer, transfer is skipped if it is set. In case of transfer
@@ -502,9 +499,6 @@ static int s6e63m0_disable(struct drm_panel *panel)
 {
 	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
 
-	if (!ctx->enabled)
-		return 0;
-
 	backlight_disable(ctx->bl_dev);
 
 	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_SET_DISPLAY_OFF);
@@ -512,8 +506,6 @@ static int s6e63m0_disable(struct drm_panel *panel)
 	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_ENTER_SLEEP_MODE);
 	msleep(120);
 
-	ctx->enabled = false;
-
 	return 0;
 }
 
@@ -522,17 +514,12 @@ static int s6e63m0_unprepare(struct drm_panel *panel)
 	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
 	int ret;
 
-	if (!ctx->prepared)
-		return 0;
-
 	s6e63m0_clear_error(ctx);
 
 	ret = s6e63m0_power_off(ctx);
 	if (ret < 0)
 		return ret;
 
-	ctx->prepared = false;
-
 	return 0;
 }
 
@@ -541,9 +528,6 @@ static int s6e63m0_prepare(struct drm_panel *panel)
 	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
 	int ret;
 
-	if (ctx->prepared)
-		return 0;
-
 	ret = s6e63m0_power_on(ctx);
 	if (ret < 0)
 		return ret;
@@ -564,8 +548,6 @@ static int s6e63m0_prepare(struct drm_panel *panel)
 	if (ret < 0)
 		s6e63m0_unprepare(panel);
 
-	ctx->prepared = true;
-
 	return ret;
 }
 
@@ -573,9 +555,6 @@ static int s6e63m0_enable(struct drm_panel *panel)
 {
 	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
 
-	if (ctx->enabled)
-		return 0;
-
 	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_EXIT_SLEEP_MODE);
 	msleep(120);
 	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_SET_DISPLAY_ON);
@@ -588,8 +567,6 @@ static int s6e63m0_enable(struct drm_panel *panel)
 
 	backlight_enable(ctx->bl_dev);
 
-	ctx->enabled = true;
-
 	return 0;
 }
 
@@ -709,8 +686,6 @@ int s6e63m0_probe(struct device *dev, void *trsp,
 	dev_set_drvdata(dev, ctx);
 
 	ctx->dev = dev;
-	ctx->enabled = false;
-	ctx->prepared = false;
 
 	ret = device_property_read_u32(dev, "max-brightness", &max_brightness);
 	if (ret)
-- 
2.41.0.585.gd2178a4bd4-goog

