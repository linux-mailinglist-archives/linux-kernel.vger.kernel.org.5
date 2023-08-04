Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF00770A88
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjHDVJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjHDVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:08:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB014ECB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:07:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686efa1804eso1882935b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691183250; x=1691788050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL/sXBJdtn+1Uor6JvF4nJ5jjuwE/sb94QyRSIeFTvk=;
        b=NjgM8gn4+41Cl2kOZSDhkZdOjQsKJZkSC2KoMd9AQ/7c+FyUco3qIkYJMY8ThPH8E/
         RJ5PVgal91E/XthgoRC6cYkwVkTfj+eJKUzLcfdHTwur4fEaLZPCLLsnzXb9ktJSjIe5
         MYN/Dr/6x7zHt0dZU8gcVMu46BPJSaQWuFptk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183250; x=1691788050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL/sXBJdtn+1Uor6JvF4nJ5jjuwE/sb94QyRSIeFTvk=;
        b=OFiKCuy6H6YZSLQn4UiAHjKoTsOjHLpjnHEaITv1KHVjhepuCR/6hvWLPxV/cvu8Mt
         1PjV/7u/a1dsXnlA8FcRxXp9HCQqSEfJwSA2d3WI0qqo+5UwFripCBv/Ow1iJ0BzvkiH
         MFrI1R+R4CtUchAiqeGzyYU9jr+x8E9h6uNpWOMhgJXf7kLyOMpN4VsGOYozcWi6XW+g
         I3nURlrTgfMsF54QSrYqvmh4iUEJaZpUZmJZEfGkwSosPQ9lovlCQTZ3JUJo0f9uC0Fz
         wbgV//M3pfdpDalr60FurBAjL1sLgt1w0t+R1ooviQV7AV4un5jNojy1+MsnBiX1EGmZ
         huXg==
X-Gm-Message-State: AOJu0Yzek49bam4qWPvwakZfm/4csF+ovCB4iNnVE7boM7COED5U/XWc
        GOxmFfRxes6DEWi94WV/qL49bQ==
X-Google-Smtp-Source: AGHT+IEih+uOAkCq31go8vF6sdRAx2yYeDg6nXMEh1c23VwcSuWPhJLtT3stk87AFNkWc+s0luMorg==
X-Received: by 2002:a05:6a20:6a22:b0:134:6839:c497 with SMTP id p34-20020a056a206a2200b001346839c497mr2793784pzk.11.1691183250648;
        Fri, 04 Aug 2023 14:07:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e186:e5d2:e60:bad3])
        by smtp.gmail.com with ESMTPSA id n22-20020aa78a56000000b0068664ace38asm2037584pfa.19.2023.08.04.14.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:07:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/10] drm/panel: rm67191: Don't store+check enabled
Date:   Fri,  4 Aug 2023 14:06:11 -0700
Message-ID: <20230804140605.RFC.8.I20f82e9dd1597a14ae37a64c6b8275add60fbdb1@changeid>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230804210644.1862287-1-dianders@chromium.org>
References: <20230804210644.1862287-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

The conversion of the rm67191 panel driver follows many of the other
panel drivers but is separated out because it has a few differences
that need to be called out.

Like otm8009a, this panel also uses the "prepared" flag to prevent the
backlight functions from running when the panel is powered off. This
is probably not the safest thing to do but the old behavior was
preserved. See the discussion in the patch ("drm/panel: otm8009a:
Don't double check prepared/enabled"). Because of this, I've left the
driver tracking "prepared" but removed its tracking of "enabled".

This panel also used to directly call its disable/unprepare functions
at shutdown time instead of calling into drm_panel. Now we're calling
drm_panel_helper_shutdown() which in turn calls
drm_panel_unprepare()/drm_panel_disable(). That paves the way if
anyone wants to use a the panel follower APIs with this panel.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 21 ++-----------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index dbb1ed4efbed..fb378924c0b3 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -20,6 +20,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_panel_helper.h>
 
 /* Panel specific color-format bits */
 #define COL_FMT_16BPP 0x55
@@ -205,7 +206,6 @@ struct rad_panel {
 	unsigned int num_supplies;
 
 	bool prepared;
-	bool enabled;
 };
 
 static const struct drm_display_mode default_mode = {
@@ -267,9 +267,6 @@ static int rad_panel_prepare(struct drm_panel *panel)
 	struct rad_panel *rad = to_rad_panel(panel);
 	int ret;
 
-	if (rad->prepared)
-		return 0;
-
 	ret = regulator_bulk_enable(rad->num_supplies, rad->supplies);
 	if (ret)
 		return ret;
@@ -291,9 +288,6 @@ static int rad_panel_unprepare(struct drm_panel *panel)
 	struct rad_panel *rad = to_rad_panel(panel);
 	int ret;
 
-	if (!rad->prepared)
-		return 0;
-
 	/*
 	 * Right after asserting the reset, we need to release it, so that the
 	 * touch driver can have an active connection with the touch controller
@@ -322,9 +316,6 @@ static int rad_panel_enable(struct drm_panel *panel)
 	int color_format = color_format_from_dsi_format(dsi->format);
 	int ret;
 
-	if (rad->enabled)
-		return 0;
-
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
 	ret = rad_panel_push_cmd_list(dsi);
@@ -389,8 +380,6 @@ static int rad_panel_enable(struct drm_panel *panel)
 
 	backlight_enable(rad->backlight);
 
-	rad->enabled = true;
-
 	return 0;
 
 fail:
@@ -406,9 +395,6 @@ static int rad_panel_disable(struct drm_panel *panel)
 	struct device *dev = &dsi->dev;
 	int ret;
 
-	if (!rad->enabled)
-		return 0;
-
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
 	backlight_disable(rad->backlight);
@@ -429,8 +415,6 @@ static int rad_panel_disable(struct drm_panel *panel)
 		return ret;
 	}
 
-	rad->enabled = false;
-
 	return 0;
 }
 
@@ -633,8 +617,7 @@ static void rad_panel_shutdown(struct mipi_dsi_device *dsi)
 {
 	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
 
-	rad_panel_disable(&rad->panel);
-	rad_panel_unprepare(&rad->panel);
+	drm_panel_helper_shutdown(&rad->panel);
 }
 
 static const struct of_device_id rad_of_match[] = {
-- 
2.41.0.585.gd2178a4bd4-goog

