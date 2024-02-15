Return-Path: <linux-kernel+bounces-66489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E5E855D68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA7B1C21C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD201BDE0;
	Thu, 15 Feb 2024 09:05:27 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C801BDCF;
	Thu, 15 Feb 2024 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987927; cv=none; b=C/uEZneRaqZQAOsQHsI1KRnQCWwst4V86n/G9MHh2fO1wzap3EvNALOyQtkUzfpqHgioXrRUw9riUSpNnMLcAs6EtiJe7xSEBme961PphP8Y47bArd6/uOBLjlRfOivB3+MB2cTyn/mHc8OdsyT5Qo5IRd5q6qITwalytCtXc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987927; c=relaxed/simple;
	bh=lAzSHTM1F9Quj28n3IhTiJ2ehA9WUC/bfmzjKyrRUjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KzFiGFEZf1ROHrAd/optytLGGaB5e0wX5FvbPUco3AmChHFF5up9pPHadmO2Ca7ucJU8hlQFJGx7eZ7iDjwZ9s2nom4A6O75+JMNhJlyag7d0Q429b+fSKcdz8+tawFtRqHPGGaE4zve/5dsYugSKpPBUNeCmD4/LKJKDIqESXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1raXgD-0002M4-K8; Thu, 15 Feb 2024 10:05:17 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/3] drm/panel: ltk500hd1829: make room for more similar panels
Date: Thu, 15 Feb 2024 10:05:13 +0100
Message-Id: <20240215090515.3513817-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215090515.3513817-1-heiko@sntech.de>
References: <20240215090515.3513817-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

There exist more dsi-panels from Leadtek sharing supplies and timings
with only the panel-mode and init commands differing.

So make room in the driver to also keep variants here instead of
requiring additional drivers per panel.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../drm/panel/panel-leadtek-ltk500hd1829.c    | 73 ++++++++++++-------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
index 39e408c9f762f..42f4e2584af18 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
 #include <video/mipi_display.h>
@@ -21,25 +22,32 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
+struct ltk500hd1829_cmd {
+	char cmd;
+	char data;
+};
+
+struct ltk500hd1829_desc {
+	const struct drm_display_mode *mode;
+	const struct ltk500hd1829_cmd *init;
+	unsigned int num_init;
+};
+
 struct ltk500hd1829 {
 	struct device *dev;
 	struct drm_panel panel;
 	struct gpio_desc *reset_gpio;
 	struct regulator *vcc;
 	struct regulator *iovcc;
+	const struct ltk500hd1829_desc *panel_desc;
 	bool prepared;
 };
 
-struct ltk500hd1829_cmd {
-	char cmd;
-	char data;
-};
-
 /*
  * There is no description in the Reference Manual about these commands.
  * We received them from the vendor, so just use them as is.
  */
-static const struct ltk500hd1829_cmd init_code[] = {
+static const struct ltk500hd1829_cmd ltk500hd1829_init[] = {
 	{ 0xE0, 0x00 },
 	{ 0xE1, 0x93 },
 	{ 0xE2, 0x65 },
@@ -260,6 +268,26 @@ static const struct ltk500hd1829_cmd init_code[] = {
 	{ 0x35, 0x00 },
 };
 
+static const struct drm_display_mode ltk500hd1829_mode = {
+	.hdisplay	= 720,
+	.hsync_start	= 720 + 50,
+	.hsync_end	= 720 + 50 + 50,
+	.htotal		= 720 + 50 + 50 + 50,
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 30,
+	.vsync_end	= 1280 + 30 + 4,
+	.vtotal		= 1280 + 30 + 4 + 12,
+	.clock		= 69217,
+	.width_mm	= 62,
+	.height_mm	= 110,
+};
+
+static const struct ltk500hd1829_desc ltk500hd1829_data = {
+	.mode = &ltk500hd1829_mode,
+	.init = ltk500hd1829_init,
+	.num_init = ARRAY_SIZE(ltk500hd1829_init),
+};
+
 static inline
 struct ltk500hd1829 *panel_to_ltk500hd1829(struct drm_panel *panel)
 {
@@ -324,8 +352,8 @@ static int ltk500hd1829_prepare(struct drm_panel *panel)
 	/* tRT: >= 5ms */
 	usleep_range(5000, 6000);
 
-	for (i = 0; i < ARRAY_SIZE(init_code); i++) {
-		ret = mipi_dsi_generic_write(dsi, &init_code[i],
+	for (i = 0; i < ctx->panel_desc->num_init; i++) {
+		ret = mipi_dsi_generic_write(dsi, &ctx->panel_desc->init[i],
 					     sizeof(struct ltk500hd1829_cmd));
 		if (ret < 0) {
 			dev_err(panel->dev, "failed to write init cmds: %d\n", ret);
@@ -359,31 +387,17 @@ static int ltk500hd1829_prepare(struct drm_panel *panel)
 	return ret;
 }
 
-static const struct drm_display_mode default_mode = {
-	.hdisplay	= 720,
-	.hsync_start	= 720 + 50,
-	.hsync_end	= 720 + 50 + 50,
-	.htotal		= 720 + 50 + 50 + 50,
-	.vdisplay	= 1280,
-	.vsync_start	= 1280 + 30,
-	.vsync_end	= 1280 + 30 + 4,
-	.vtotal		= 1280 + 30 + 4 + 12,
-	.clock		= 69217,
-	.width_mm	= 62,
-	.height_mm	= 110,
-};
-
 static int ltk500hd1829_get_modes(struct drm_panel *panel,
 				  struct drm_connector *connector)
 {
 	struct ltk500hd1829 *ctx = panel_to_ltk500hd1829(panel);
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_duplicate(connector->dev, &default_mode);
+	mode = drm_mode_duplicate(connector->dev, ctx->panel_desc->mode);
 	if (!mode) {
 		dev_err(ctx->dev, "failed to add mode %ux%u@%u\n",
-			default_mode.hdisplay, default_mode.vdisplay,
-			drm_mode_vrefresh(&default_mode));
+			ctx->panel_desc->mode->hdisplay, ctx->panel_desc->mode->vdisplay,
+			drm_mode_vrefresh(ctx->panel_desc->mode));
 		return -ENOMEM;
 	}
 
@@ -413,6 +427,10 @@ static int ltk500hd1829_probe(struct mipi_dsi_device *dsi)
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->panel_desc = of_device_get_match_data(dev);
+	if (!ctx->panel_desc)
+		return -EINVAL;
+
 	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio)) {
 		dev_err(dev, "cannot get reset gpio\n");
@@ -492,7 +510,10 @@ static void ltk500hd1829_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id ltk500hd1829_of_match[] = {
-	{ .compatible = "leadtek,ltk500hd1829", },
+	{
+		.compatible = "leadtek,ltk500hd1829",
+		.data = &ltk500hd1829_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ltk500hd1829_of_match);
-- 
2.39.2


