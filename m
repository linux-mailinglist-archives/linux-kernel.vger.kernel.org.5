Return-Path: <linux-kernel+bounces-145512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A318A5736
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DF51C22977
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74F80C03;
	Mon, 15 Apr 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="UD4u7RiQ"
Received: from mail.mainlining.org (mainlining.org [94.241.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483E80046;
	Mon, 15 Apr 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.241.141.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197481; cv=none; b=L9Xx53W5bw6PLwJKJTWYgaI4+sXAYXe1a3D/yF/mI887swLUJwxkYb4Z8XKUXmXUb7F42f/Pf5RhNshqnuY7Hv5dYQRIoIPfwD64Y3x8k1cWYp8yXwopYEeqBMzrfrpJDzs4mN8b2Gry6pdkfHxK0iUv7WAb6NVucZhbbZZMGKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197481; c=relaxed/simple;
	bh=f146FF+WI/o35KCCFTLt43epAmIWYp+fcu5cws731ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FNw/hyUJ71PmNk4LpSMBbvG6W/eYWTn+/PLXQ4ROPCMcFNAiuI4A/MCSQR3ghTnPkdct3QkNtqgzoguDE3uX8BEkB6dtm9+hxhVBvinEkIXWpq4aZP+jiD4MGQrHzLAnv7yVeoN0PJGg/AVVws6u70U+jp0hmyyyrkq6DtDx/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=UD4u7RiQ; arc=none smtp.client-ip=94.241.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from david-ryuzu.localdomain (ipbcc3a836.dynamic.kabel-deutschland.de [188.195.168.54])
	by mail.mainlining.org (Postfix) with ESMTPSA id 8A558E20AF;
	Mon, 15 Apr 2024 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1713197471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iz36PtCFN7oUoO4KwjFHJcJtW5hVGeHAgAE4GO3+PDw=;
	b=UD4u7RiQOEN6AyjqMdJ9Y3HL9OUCj1KS33y5rLrub/eSkGCFsDECd3tiHkGoTNyRp52yF9
	XKkCP1oeOy8k5FS1wWs3+sl8PGRZGslGbKmSlEbNSxw87H/1yTwWS/cC3Lkh6t64VDsv7Z
	39cpiCLrutoKfWxKEnUO1GFF/SQUeGioCor7g3rEnU6Q6WvV1ECWMILavheahfSFok6vFC
	usJWgdg62DXHLq3wtvOJ5iTjwzEztrv4c0eyYvgmeU3OtxHQM3gUAAomBS2haPOb0xL3uZ
	jRYdA25nUpZEi1Da9L9pMr005h0EWQqH8Oxypyle8srbwvmUE/IysK0HqAsciA==
From: David Wronek <david@mainlining.org>
Date: Mon, 15 Apr 2024 18:10:42 +0200
Subject: [PATCH v2 2/2] drm/panel: Add driver for EDO RM69380 OLED panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-raydium-rm69380-driver-v2-2-524216461306@mainlining.org>
References: <20240415-raydium-rm69380-driver-v2-0-524216461306@mainlining.org>
In-Reply-To: <20240415-raydium-rm69380-driver-v2-0-524216461306@mainlining.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, David Wronek <david@mainlining.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713197467; l=12303;
 i=david@mainlining.org; s=20240121; h=from:subject:message-id;
 bh=f146FF+WI/o35KCCFTLt43epAmIWYp+fcu5cws731ic=;
 b=8FHvipBkbhmJJlNTQkm1FNqBx+tQz0CZTVKYLiyik8Oc8pAseHIVDxgtm0Vva82kBcel35nAX
 4+ERID+oKm3AVubBUd/xJE+6dpg3AdxP6J7x+eCcf3vsrPaCQvu/+4H
X-Developer-Key: i=david@mainlining.org; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

Add support for the 2560x1600@90Hz OLED panel by EDO bundled with a
Raydium RM69380 controller, as found on the Lenovo Xiaoxin Pad Pro 2021.

Signed-off-by: David Wronek <david@mainlining.org>
---
 drivers/gpu/drm/panel/Kconfig                 |  14 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm69380.c | 366 ++++++++++++++++++++++++++
 3 files changed, 381 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 154f5bf82980..5b3eeb93b1a2 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -542,6 +542,20 @@ config DRM_PANEL_RAYDIUM_RM692E5
 	  Say Y here if you want to enable support for Raydium RM692E5-based
 	  display panels, such as the one found in the Fairphone 5 smartphone.
 
+config DRM_PANEL_RAYDIUM_RM69380
+	tristate "Raydium RM69380-based DSI panel"
+	depends on BACKLIGHT_CLASS_DEVICE
+	depends on DRM_DISPLAY_DP_HELPER
+	depends on DRM_DISPLAY_HELPER
+	depends on DRM_MIPI_DSI
+	depends on OF
+	help
+	  Say Y here if you want to enable support for Raydium RM69380-based
+	  display panels.
+
+	  This panel controller can be found in the Lenovo Xiaoxin Pad Pro 2021
+	  in combination with an EDO OLED panel.
+
 config DRM_PANEL_RONBO_RB070D30
 	tristate "Ronbo Electronics RB070D30 panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 24a02655d726..e2a2807d4ef0 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) += panel-raspberrypi-touchscreen
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM67191) += panel-raydium-rm67191.o
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM692E5) += panel-raydium-rm692e5.o
+obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM69380) += panel-raydium-rm69380.o
 obj-$(CONFIG_DRM_PANEL_RONBO_RB070D30) += panel-ronbo-rb070d30.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20) += panel-samsung-atna33xc20.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_DB7430) += panel-samsung-db7430.o
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm69380.c b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
new file mode 100644
index 000000000000..253b9a1c2800
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree.
+ * Copyright (c) 2024 David Wronek <david@mainlining.org>
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+struct rm69380_panel {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi[2];
+	struct regulator_bulk_data supplies[2];
+	struct gpio_desc *reset_gpio;
+	bool prepared;
+};
+
+static inline
+struct rm69380_panel *to_rm69380_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct rm69380_panel, panel);
+}
+
+static void rm69380_reset(struct rm69380_panel *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(15000, 16000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	msleep(30);
+}
+
+static int rm69380_on(struct rm69380_panel *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi[0];
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+	if (ctx->dsi[1])
+		ctx->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd4);
+	mipi_dsi_dcs_write_seq(dsi, 0x00, 0x80);
+	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd0);
+	mipi_dsi_dcs_write_seq(dsi, 0x48, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x26);
+	mipi_dsi_dcs_write_seq(dsi, 0x75, 0x3f);
+	mipi_dsi_dcs_write_seq(dsi, 0x1d, 0x1a);
+	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0x53, 0x28);
+	mipi_dsi_dcs_write_seq(dsi, 0xc2, 0x08);
+	mipi_dsi_dcs_write_seq(dsi, 0x35, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0x51, 0x07, 0xff);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
+	msleep(20);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display on: %d\n", ret);
+		return ret;
+	}
+	msleep(36);
+
+	return 0;
+}
+
+static int rm69380_off(struct rm69380_panel *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi[0];
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	if (ctx->dsi[1])
+		ctx->dsi[1]->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display off: %d\n", ret);
+		return ret;
+	}
+	msleep(35);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
+		return ret;
+	}
+	msleep(20);
+
+	return 0;
+}
+
+static int rm69380_prepare(struct drm_panel *panel)
+{
+	struct rm69380_panel *ctx = to_rm69380_panel(panel);
+	struct device *dev = &ctx->dsi[0]->dev;
+	int ret;
+
+	if (ctx->prepared)
+		return 0;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	rm69380_reset(ctx);
+
+	ret = rm69380_on(ctx);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rm69380_unprepare(struct drm_panel *panel)
+{
+	struct rm69380_panel *ctx = to_rm69380_panel(panel);
+	struct device *dev = &ctx->dsi[0]->dev;
+	int ret;
+
+	if (!ctx->prepared)
+		return 0;
+
+	ret = rm69380_off(ctx);
+	if (ret < 0)
+		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+
+	ctx->prepared = false;
+	return 0;
+}
+
+static const struct drm_display_mode rm69380_mode = {
+	.clock = (2560 + 32 + 12 + 38) * (1600 + 20 + 4 + 8) * 90 / 1000,
+	.hdisplay = 2560,
+	.hsync_start = 2560 + 32,
+	.hsync_end = 2560 + 32 + 12,
+	.htotal = 2560 + 32 + 12 + 38,
+	.vdisplay = 1600,
+	.vsync_start = 1600 + 20,
+	.vsync_end = 1600 + 20 + 4,
+	.vtotal = 1600 + 20 + 4 + 8,
+	.width_mm = 248,
+	.height_mm = 155,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int rm69380_get_modes(struct drm_panel *panel,
+					struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &rm69380_mode);
+}
+
+static const struct drm_panel_funcs rm69380_panel_funcs = {
+	.prepare = rm69380_prepare,
+	.unprepare = rm69380_unprepare,
+	.get_modes = rm69380_get_modes,
+};
+
+static int rm69380_bl_update_status(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness = backlight_get_brightness(bl);
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return 0;
+}
+
+static int rm69380_bl_get_brightness(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness;
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_get_display_brightness_large(dsi, &brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return brightness;
+}
+
+static const struct backlight_ops rm69380_bl_ops = {
+	.update_status = rm69380_bl_update_status,
+	.get_brightness = rm69380_bl_get_brightness,
+};
+
+static struct backlight_device *
+rm69380_create_backlight(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = 2047,
+		.max_brightness = 2047,
+	};
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+					      &rm69380_bl_ops, &props);
+}
+
+static int rm69380_probe(struct mipi_dsi_device *dsi)
+{
+	struct mipi_dsi_host *dsi_sec_host;
+	struct rm69380_panel *ctx;
+	struct device *dev = &dsi->dev;
+	struct device_node *dsi_sec;
+	int ret, i;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->supplies[0].supply = "vddio";
+	ctx->supplies[1].supply = "avdd";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
+				      ctx->supplies);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	dsi_sec = of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
+
+	if (dsi_sec) {
+		dev_dbg(dev, "Using Dual-DSI\n");
+
+		const struct mipi_dsi_device_info info = { "RM69380", 0,
+							   dsi_sec };
+
+		dev_dbg(dev, "Found second DSI `%s`\n", dsi_sec->name);
+
+		dsi_sec_host = of_find_mipi_dsi_host_by_node(dsi_sec);
+		of_node_put(dsi_sec);
+		if (!dsi_sec_host) {
+			return dev_err_probe(dev, -EPROBE_DEFER,
+					     "Cannot get secondary DSI host\n");
+		}
+
+		ctx->dsi[1] =
+			mipi_dsi_device_register_full(dsi_sec_host, &info);
+		if (IS_ERR(ctx->dsi[1])) {
+			return dev_err_probe(dev, PTR_ERR(ctx->dsi[1]),
+					     "Cannot get secondary DSI node\n");
+		}
+
+		dev_dbg(dev, "Second DSI name `%s`\n", ctx->dsi[1]->name);
+		mipi_dsi_set_drvdata(ctx->dsi[1], ctx);
+	} else {
+		dev_dbg(dev, "Using Single-DSI\n");
+	}
+
+	ctx->dsi[0] = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	drm_panel_init(&ctx->panel, dev, &rm69380_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+	ctx->panel.prepare_prev_first = true;
+
+	ctx->panel.backlight = rm69380_create_backlight(dsi);
+	if (IS_ERR(ctx->panel.backlight))
+		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
+				     "Failed to create backlight\n");
+
+	drm_panel_add(&ctx->panel);
+
+	for (i = 0; i < ARRAY_SIZE(ctx->dsi); i++) {
+		if (!ctx->dsi[i])
+			continue;
+
+		dev_dbg(&ctx->dsi[i]->dev, "Binding DSI %d\n", i);
+
+		ctx->dsi[i]->lanes = 4;
+		ctx->dsi[i]->format = MIPI_DSI_FMT_RGB888;
+		ctx->dsi[i]->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
+					  MIPI_DSI_CLOCK_NON_CONTINUOUS;
+
+		ret = mipi_dsi_attach(ctx->dsi[i]);
+		if (ret < 0) {
+			drm_panel_remove(&ctx->panel);
+			return dev_err_probe(dev, ret,
+					     "Failed to attach to DSI%d\n", i);
+		}
+	}
+
+	return 0;
+}
+
+static void rm69380_remove(struct mipi_dsi_device *dsi)
+{
+	struct rm69380_panel *ctx = mipi_dsi_get_drvdata(dsi);
+	int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(ctx->dsi); i++) {
+		if (!ctx->dsi[i])
+			continue;
+
+		ret = mipi_dsi_detach(ctx->dsi[i]);
+		if (ret < 0)
+			dev_err(&dsi->dev, "Failed to detach from DSI%d host: %d\n", i, ret);
+	}
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id rm69380_of_match[] = {
+	{ .compatible = "lenovo,j716f-edo-rm69380" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rm69380_of_match);
+
+static struct mipi_dsi_driver rm69380_panel_driver = {
+	.probe = rm69380_probe,
+	.remove = rm69380_remove,
+	.driver = {
+		.name = "panel-raydium-rm69380",
+		.of_match_table = rm69380_of_match,
+	},
+};
+module_mipi_dsi_driver(rm69380_panel_driver);
+
+MODULE_AUTHOR("David Wronek <david@mainlining.org");
+MODULE_DESCRIPTION("DRM driver for Raydium RM69380-equipped DSI panels");
+MODULE_LICENSE("GPL");

-- 
2.44.0


