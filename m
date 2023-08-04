Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD1770A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjHDVIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjHDVIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:08:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36D655A5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:07:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686f94328a4so1744043b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691183239; x=1691788039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs0Gv4Fg+9bXbPDS+x5MeuiOn4j7KTC6rQDcvADWb+8=;
        b=TFhIf+Y92Yutq1q3r5QXOVtSDF6+EmNeMvB5c54nDo5/RLID3p2uAWC+vf3ZkgRLgr
         5lVq8JsIHNr5sA1uIXxUjC0RY8/VDxXP02vT4SK9+Cx6ej0mEB22eYcCWFY8MFDlmbTm
         vgGaUnrtDEb268mi/DcLufyaS3DzHeChCP1/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183239; x=1691788039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs0Gv4Fg+9bXbPDS+x5MeuiOn4j7KTC6rQDcvADWb+8=;
        b=iyWLiisJ/j5v/2sgzI/cXQQGRjK48JZsm8ZVskDUID4frFKViEJn1yOG8i8BIGI+WF
         ldZhpSNScahEv/1WpvfudSyQTwd+R8M2bjtiD8cTwmC7jziCUN+j9mgMp9SYTDBfI6cC
         Fezn7cjAQs6ER20BjbmEg1y3wK9YNPERbN1nQgywjYhG40b3E1bxwM1uwfBKLk64uH2l
         DG8eRkV/HwnBNOlEJfWcsz6kaHWYjbjt+90nFsoRVx/gCazURakEQ9k8vJmSFGxDI/dS
         xwX9LG0MKi/KsHC1kqBGUcEFyJ/CDzJZNXAoVaCvYFIRKMkyjXecBMiFGhsJ5s32dahB
         4Cjg==
X-Gm-Message-State: AOJu0YwWcx9nIJmyuqyI/0feaSluUo3BGTki9TdHGF+yAqKKe0xTR1Fv
        S8gtPZGUtcXEA5uTAvwdogq2mQ==
X-Google-Smtp-Source: AGHT+IH+1u2vz/+hPiEdDmFCaY5UcWnHhuoQ/4+7m/iN7gksQgGInNJt1xM7GfEqn1Jrxnt9mXGsqw==
X-Received: by 2002:a05:6a20:2587:b0:137:c971:6a0c with SMTP id k7-20020a056a20258700b00137c9716a0cmr852950pzd.31.1691183238826;
        Fri, 04 Aug 2023 14:07:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e186:e5d2:e60:bad3])
        by smtp.gmail.com with ESMTPSA id n22-20020aa78a56000000b0068664ace38asm2037584pfa.19.2023.08.04.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:07:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/10] drm/panel: otm8009a: Don't double check prepared/enabled
Date:   Fri,  4 Aug 2023 14:06:06 -0700
Message-ID: <20230804140605.RFC.3.I6a4a3c81c78acf5acdc2e5b5d936e19bf57ec07a@changeid>
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

For the "otm8009a" driver we fully remove the storing of the "enabled"
state and we remove the double-checking, but we still keep the storing
of the "prepared" state since the backlight code in the driver checks
it. This backlight code may not be perfectly safe since there doesn't
appear to be sufficient synchronization between the backlight driver
(which userspace can call into directly) and the code that's
unpreparing the panel. However, this lack of safety is not new and can
be addressed in a future patch.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
From quick inspection, I think the right way to handle the backlight
properly is:
1. Start calling backlight_get_brightness() instead of directly
   getting "bd->props.brightness" and bd->props.power. This should
   return 0 for a disabled (or blanked or powered off) backlight.
2. Cache the backlight level in "struct otm8009a"
3. If the backlight isn't changing compared to the cached value, make
   otm8009a_backlight_update_status() a no-op.
4. Remove the caching of the "prepared" value.

That should work and always be safe because we always enable/disable
the backlight in the panel's enable() and disable() functions. The
backlight core has proper locking in this case. A disabled backlight
will always return a level of 0 which will always make the backlight's
update_status a no-op when the panel is disabled and keep us from
trying to talk to the panel when it's off. Userspace can't directly
cause a backlight to be enabled/disabled, it can only affect the other
blanking modes.

 .../gpu/drm/panel/panel-orisetech-otm8009a.c    | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 898b892f1143..93183f30d7d6 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -70,7 +70,6 @@ struct otm8009a {
 	struct gpio_desc *reset_gpio;
 	struct regulator *supply;
 	bool prepared;
-	bool enabled;
 };
 
 static const struct drm_display_mode modes[] = {
@@ -267,9 +266,6 @@ static int otm8009a_disable(struct drm_panel *panel)
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	int ret;
 
-	if (!ctx->enabled)
-		return 0; /* This is not an issue so we return 0 here */
-
 	backlight_disable(ctx->bl_dev);
 
 	ret = mipi_dsi_dcs_set_display_off(dsi);
@@ -282,8 +278,6 @@ static int otm8009a_disable(struct drm_panel *panel)
 
 	msleep(120);
 
-	ctx->enabled = false;
-
 	return 0;
 }
 
@@ -291,9 +285,6 @@ static int otm8009a_unprepare(struct drm_panel *panel)
 {
 	struct otm8009a *ctx = panel_to_otm8009a(panel);
 
-	if (!ctx->prepared)
-		return 0;
-
 	if (ctx->reset_gpio) {
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 		msleep(20);
@@ -311,9 +302,6 @@ static int otm8009a_prepare(struct drm_panel *panel)
 	struct otm8009a *ctx = panel_to_otm8009a(panel);
 	int ret;
 
-	if (ctx->prepared)
-		return 0;
-
 	ret = regulator_enable(ctx->supply);
 	if (ret < 0) {
 		dev_err(panel->dev, "failed to enable supply: %d\n", ret);
@@ -341,13 +329,8 @@ static int otm8009a_enable(struct drm_panel *panel)
 {
 	struct otm8009a *ctx = panel_to_otm8009a(panel);
 
-	if (ctx->enabled)
-		return 0;
-
 	backlight_enable(ctx->bl_dev);
 
-	ctx->enabled = true;
-
 	return 0;
 }
 
-- 
2.41.0.585.gd2178a4bd4-goog

