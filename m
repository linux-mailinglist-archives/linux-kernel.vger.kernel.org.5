Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E38752EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjGNBiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjGNBiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C0B2D64;
        Thu, 13 Jul 2023 18:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3535961BB8;
        Fri, 14 Jul 2023 01:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583B5C433CC;
        Fri, 14 Jul 2023 01:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298684;
        bh=i3ZrSSDxreDrHnbdzjRZb/TFVdFo15zQGfDgEtGHAcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/KHAdAtEeObqX6VWEDk0ol/pRePLLW+O8wxczMFSV9tDyruFPRh8YIAYg/BOBWMm
         zQZoMi7hqMriC9HuMMsg4zqjCgcE1JLo2PzoXW17KBWwcTa6aTbKxbd2Kp3nst/n7y
         TYQlDs8Ih5PVu2M0hMXxZQ67BDEt2yF/mdtXL9fpq4CFSH5RkE7HUNRFj3Hx+lP5U4
         IQJVkYeTWW8FCHKSwVZV1vl81N+kRGL9ktzm3u9Kb1YsaxLzPqrF9egRnkDlmbAcXM
         KE66/6bAfqQZNYB63TLXcat4LNM5OvgQqbh89l2EZrWHRLqybOUOdf8Y4yADPY7hU2
         YClOTMMf8/wHQ==
Received: by mercury (Postfix, from userid 1000)
        id DD676106769A; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
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
Subject: [PATCH v3 08/19] drm/panel: sitronix-st7789v: avoid hardcoding mode info
Date:   Fri, 14 Jul 2023 03:37:45 +0200
Message-Id: <20230714013756.1546769-9-sre@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714013756.1546769-1-sre@kernel.org>
References: <20230714013756.1546769-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid hard-coding the default_mode and supply it from match data. One
additional layer of abstraction has been introduced, which will be
needed for specifying other panel information (e.g. bus flags) in the
next steps.

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../gpu/drm/panel/panel-sitronix-st7789v.c    | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index a6d6155ef45c..24c5bec6ce31 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -108,8 +108,13 @@
 			return val;		\
 	} while (0)
 
+struct st7789_panel_info {
+	const struct drm_display_mode *mode;
+};
+
 struct st7789v {
 	struct drm_panel panel;
+	const struct st7789_panel_info *info;
 	struct spi_device *spi;
 	struct gpio_desc *reset;
 	struct regulator *power;
@@ -160,16 +165,21 @@ static const struct drm_display_mode default_mode = {
 	.vtotal = 320 + 8 + 4 + 4,
 };
 
+static const struct st7789_panel_info default_panel = {
+	.mode = &default_mode,
+};
+
 static int st7789v_get_modes(struct drm_panel *panel,
 			     struct drm_connector *connector)
 {
+	struct st7789v *ctx = panel_to_st7789v(panel);
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_duplicate(connector->dev, &default_mode);
+	mode = drm_mode_duplicate(connector->dev, ctx->info->mode);
 	if (!mode) {
-		dev_err(panel->dev, "failed to add mode %ux%ux@%u\n",
-			default_mode.hdisplay, default_mode.vdisplay,
-			drm_mode_vrefresh(&default_mode));
+		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
+			ctx->info->mode->hdisplay, ctx->info->mode->vdisplay,
+			drm_mode_vrefresh(ctx->info->mode));
 		return -ENOMEM;
 	}
 
@@ -359,6 +369,8 @@ static int st7789v_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, ctx);
 	ctx->spi = spi;
 
+	ctx->info = device_get_match_data(&spi->dev);
+
 	drm_panel_init(&ctx->panel, dev, &st7789v_drm_funcs,
 		       DRM_MODE_CONNECTOR_DPI);
 
@@ -389,13 +401,13 @@ static void st7789v_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id st7789v_spi_id[] = {
-	{ "st7789v" },
+	{ "st7789v", (unsigned long) &default_panel },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, st7789v_spi_id);
 
 static const struct of_device_id st7789v_of_match[] = {
-	{ .compatible = "sitronix,st7789v" },
+	{ .compatible = "sitronix,st7789v", .data = &default_panel },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, st7789v_of_match);
-- 
2.40.1

