Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80653752EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjGNBi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjGNBiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2782D66;
        Thu, 13 Jul 2023 18:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 353D161BB9;
        Fri, 14 Jul 2023 01:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581D1C433CB;
        Fri, 14 Jul 2023 01:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298684;
        bh=pHG+mTF3Sqq4Dyhp7e3fM2xvT8KCo3Hc4liBMTVZVOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcobtyHoeNyuILr2XEO5I4hFwKoTCvji/RQFFN4rJXcJn8ldgZrRtumRdxsmLzDAl
         TF3fWQFpUhlCtRfrI8NSYv7VHedxNEz6gAHWN5o7A2XFWwrckHcIctWvEhXjDGHfhR
         P/l1czEkG1foF2ESTVmjPtnLrbetDqZ1d3fmBPgb2w6ZUTbS4UqibPz25ye8E/27rj
         87CAO8XzMhJUo/yciroYpWw3s16fQO+VRNlBe7CHLDtedEciSv+Xx9Lbmb0pD3z9Yg
         sj4+cTkOpOcbQAHgsms06lQ4praeRHvGBVCPWXDc6+JyhyWi2bMslRc7Aisrm5YQhF
         8Rnho0zq6hUlg==
Received: by mercury (Postfix, from userid 1000)
        id E249B10676F2; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
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
Subject: [PATCH v3 10/19] drm/panel: sitronix-st7789v: add media bus format
Date:   Fri, 14 Jul 2023 03:37:47 +0200
Message-Id: <20230714013756.1546769-11-sre@kernel.org>
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

Add support for describing the media bus format in the
panel configuration and expose that to userspace. Since
both supported formats (RGB565 and RGB666) are using 6
bits per color also hardcode that information.

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../gpu/drm/panel/panel-sitronix-st7789v.c    | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index aa11a1dc0752..d05d7a9caefc 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -10,6 +10,7 @@
 #include <linux/spi/spi.h>
 
 #include <video/mipi_display.h>
+#include <linux/media-bus-format.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_modes.h>
@@ -110,6 +111,7 @@
 
 struct st7789_panel_info {
 	const struct drm_display_mode *mode;
+	u32 bus_format;
 };
 
 struct st7789v {
@@ -169,6 +171,7 @@ static const struct drm_display_mode default_mode = {
 
 static const struct st7789_panel_info default_panel = {
 	.mode = &default_mode,
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
 static int st7789v_get_modes(struct drm_panel *panel,
@@ -190,8 +193,11 @@ static int st7789v_get_modes(struct drm_panel *panel,
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 	drm_mode_probed_add(connector, mode);
 
+	connector->display_info.bpc = 6;
 	connector->display_info.width_mm = ctx->info->mode->width_mm;
 	connector->display_info.height_mm = ctx->info->mode->height_mm;
+	drm_display_info_set_bus_formats(&connector->display_info,
+					 &ctx->info->bus_format, 1);
 
 	return 1;
 }
@@ -199,8 +205,24 @@ static int st7789v_get_modes(struct drm_panel *panel,
 static int st7789v_prepare(struct drm_panel *panel)
 {
 	struct st7789v *ctx = panel_to_st7789v(panel);
+	u8 pixel_fmt;
 	int ret;
 
+	switch (ctx->info->bus_format) {
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		pixel_fmt = MIPI_DCS_PIXEL_FMT_18BIT;
+		break;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		pixel_fmt = MIPI_DCS_PIXEL_FMT_16BIT;
+		break;
+	default:
+		dev_err(panel->dev, "unsupported bus format: %d\n",
+			ctx->info->bus_format);
+		return -EINVAL;
+	}
+
+	pixel_fmt = (pixel_fmt << 4) | pixel_fmt;
+
 	ret = regulator_enable(ctx->power);
 	if (ret)
 		return ret;
@@ -221,9 +243,7 @@ static int st7789v_prepare(struct drm_panel *panel)
 
 	ST7789V_TEST(ret, st7789v_write_command(ctx,
 						MIPI_DCS_SET_PIXEL_FORMAT));
-	ST7789V_TEST(ret, st7789v_write_data(ctx,
-					     (MIPI_DCS_PIXEL_FMT_18BIT << 4) |
-					     (MIPI_DCS_PIXEL_FMT_18BIT)));
+	ST7789V_TEST(ret, st7789v_write_data(ctx, pixel_fmt));
 
 	ST7789V_TEST(ret, st7789v_write_command(ctx, ST7789V_PORCTRL_CMD));
 	ST7789V_TEST(ret, st7789v_write_data(ctx, 0xc));
-- 
2.40.1

