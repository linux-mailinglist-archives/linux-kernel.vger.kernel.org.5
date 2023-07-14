Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589BF752EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjGNBiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjGNBiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5ED2D65;
        Thu, 13 Jul 2023 18:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A7C461BBA;
        Fri, 14 Jul 2023 01:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C228C433C7;
        Fri, 14 Jul 2023 01:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298684;
        bh=MOWpJ/g3+vAITpFiVZXxc8UxPAL4534GqthAG24iYJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/I6Z+ie7CrQHGTcboX42cW4KKZH5VsQzo7dIabYJcksLessxZ2FiLvjnz4eYGFRW
         3KMhD+QZyLRI60Bw3BdMV7/1TP2nGh5mQlYnKDHM7oK34+Kb9b9cPDIKC7JrJvMj6f
         cn/WAqCHAso7u/U2ooKKUjNw4n2lu1Qa1qpcbgfeYkuRiSz1ZiHAN0yQyPyPfe+aPF
         Qtyji+d6H/DlXLTHpI4lCPGMk15Tmr9u2TI+WynBAQ8lXQSVAgHDp94nr+FD4/LcdB
         bw0fKjZBUkRgSBrTCsECla8F1C2UakNiWWCuIFR0O/KryFjpDuxsW3nRR3xF/eY8iz
         NjUoDKjFDSIrA==
Received: by mercury (Postfix, from userid 1000)
        id E832610676F4; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 12/19] drm/panel: sitronix-st7789v: avoid hardcoding polarity info
Date:   Fri, 14 Jul 2023 03:37:49 +0200
Message-Id: <20230714013756.1546769-13-sre@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714013756.1546769-1-sre@kernel.org>
References: <20230714013756.1546769-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add polarity information via mode and bus flags, so that they are no
longer hardcoded and forward the information to the DRM stack. This is
required for adding panels with different settings.

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../gpu/drm/panel/panel-sitronix-st7789v.c    | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index ee84d7a9019e..94c805c79d05 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -28,6 +28,7 @@
 #define ST7789V_RGBCTRL_VSYNC_HIGH		BIT(3)
 #define ST7789V_RGBCTRL_HSYNC_HIGH		BIT(2)
 #define ST7789V_RGBCTRL_PCLK_HIGH		BIT(1)
+#define ST7789V_RGBCTRL_DE_LOW			BIT(0)
 #define ST7789V_RGBCTRL_VBP(n)			((n) & 0x7f)
 #define ST7789V_RGBCTRL_HBP(n)			((n) & 0x1f)
 
@@ -112,6 +113,7 @@
 struct st7789_panel_info {
 	const struct drm_display_mode *mode;
 	u32 bus_format;
+	u32 bus_flags;
 	bool invert_mode;
 };
 
@@ -168,12 +170,15 @@ static const struct drm_display_mode default_mode = {
 	.vtotal = 320 + 8 + 4 + 4,
 	.width_mm = 61,
 	.height_mm = 103,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
 };
 
 static const struct st7789_panel_info default_panel = {
 	.mode = &default_mode,
 	.invert_mode = true,
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
+		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
 };
 
 static int st7789v_get_modes(struct drm_panel *panel,
@@ -198,6 +203,7 @@ static int st7789v_get_modes(struct drm_panel *panel,
 	connector->display_info.bpc = 6;
 	connector->display_info.width_mm = ctx->info->mode->width_mm;
 	connector->display_info.height_mm = ctx->info->mode->height_mm;
+	connector->display_info.bus_flags = ctx->info->bus_flags;
 	drm_display_info_set_bus_formats(&connector->display_info,
 					 &ctx->info->bus_format, 1);
 
@@ -207,7 +213,7 @@ static int st7789v_get_modes(struct drm_panel *panel,
 static int st7789v_prepare(struct drm_panel *panel)
 {
 	struct st7789v *ctx = panel_to_st7789v(panel);
-	u8 pixel_fmt;
+	u8 pixel_fmt, polarity;
 	int ret;
 
 	switch (ctx->info->bus_format) {
@@ -225,6 +231,16 @@ static int st7789v_prepare(struct drm_panel *panel)
 
 	pixel_fmt = (pixel_fmt << 4) | pixel_fmt;
 
+	polarity = 0;
+	if (ctx->info->mode->flags & DRM_MODE_FLAG_PVSYNC)
+		polarity |= ST7789V_RGBCTRL_VSYNC_HIGH;
+	if (ctx->info->mode->flags & DRM_MODE_FLAG_PHSYNC)
+		polarity |= ST7789V_RGBCTRL_HSYNC_HIGH;
+	if (ctx->info->bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE)
+		polarity |= ST7789V_RGBCTRL_PCLK_HIGH;
+	if (ctx->info->bus_flags & DRM_BUS_FLAG_DE_LOW)
+		polarity |= ST7789V_RGBCTRL_DE_LOW;
+
 	ret = regulator_enable(ctx->power);
 	if (ret)
 		return ret;
@@ -340,9 +356,7 @@ static int st7789v_prepare(struct drm_panel *panel)
 	ST7789V_TEST(ret, st7789v_write_command(ctx, ST7789V_RGBCTRL_CMD));
 	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_RGBCTRL_WO |
 					     ST7789V_RGBCTRL_RCM(2) |
-					     ST7789V_RGBCTRL_VSYNC_HIGH |
-					     ST7789V_RGBCTRL_HSYNC_HIGH |
-					     ST7789V_RGBCTRL_PCLK_HIGH));
+					     polarity));
 	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_RGBCTRL_VBP(8)));
 	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_RGBCTRL_HBP(20)));
 
-- 
2.40.1

