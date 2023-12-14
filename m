Return-Path: <linux-kernel+bounces-7-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5545813AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1ACD282E74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECEB6978C;
	Thu, 14 Dec 2023 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5lxo8lA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61029692A5;
	Thu, 14 Dec 2023 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702581700; x=1734117700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LokdJSVPxQB366f7GnnDV7J2ROlBIOMUcu0P2Ocn6xw=;
  b=g5lxo8lA+IYFmG7BqvhiPMAn3mKVyJCfp2eK2huD9WGx59fCWkfQhoF9
   7NzEzq4PRlxEQPHOpqfl0xkdMLXSqFwJcr5zZaLL28t+DGLz0tz2meuXB
   2p4mEl/1oC/NROdqkyp95AVldFRyN55pfedBK/BbomlBi1yUWl3Hy1jUe
   /gRRMOBi2YfiKZZ5oel2cY4XAgaKOcDyADi3umskhA3z6wTWfpnjJvEo1
   FDnuJJpJSrnCpbBgqtVxix39RXBu96osrG0Ow686LmN1gTNeE4AoqCiGX
   Ebcao7ZA+48DHC30GyX0PbT0DgawoEJOL2UzaIw/Jl9h7lbKX2XXy3Oc7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2328261"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="2328261"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 11:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="774490674"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="774490674"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2023 11:21:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1ECD618E; Thu, 14 Dec 2023 21:21:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Pavel Machek <pavel@ucw.cz>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v1 1/1] leds: sun50i-a100: Convert to be agnostic to property provider
Date: Thu, 14 Dec 2023 21:21:31 +0200
Message-ID: <20231214192131.1309912-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver to be agnostic to the property provider.
LEDS subsytem is not dependent on OF, so no need to make drivers
be a such.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/Kconfig            |  2 +-
 drivers/leds/leds-sun50i-a100.c | 46 ++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index ef2bdf51ae91..8a1471a0b528 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -304,7 +304,7 @@ config LEDS_COBALT_RAQ
 
 config LEDS_SUN50I_A100
 	tristate "LED support for Allwinner A100 RGB LED controller"
-	depends on LEDS_CLASS_MULTICOLOR && OF
+	depends on LEDS_CLASS_MULTICOLOR
 	depends on ARCH_SUNXI || COMPILE_TEST
 	help
 	  This option enables support for the RGB LED controller found
diff --git a/drivers/leds/leds-sun50i-a100.c b/drivers/leds/leds-sun50i-a100.c
index 171cefd1ea0d..62d21c3a3575 100644
--- a/drivers/leds/leds-sun50i-a100.c
+++ b/drivers/leds/leds-sun50i-a100.c
@@ -15,10 +15,11 @@
 #include <linux/io.h>
 #include <linux/led-class-multicolor.h>
 #include <linux/leds.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
 
@@ -247,13 +248,13 @@ static const char *const sun50i_a100_ledc_formats[] = {
 	"rgb", "rbg", "grb", "gbr", "brg", "bgr",
 };
 
-static int sun50i_a100_ledc_parse_format(const struct device_node *np,
+static int sun50i_a100_ledc_parse_format(struct device *dev,
 					 struct sun50i_a100_ledc *priv)
 {
 	const char *format = "grb";
 	u32 i;
 
-	of_property_read_string(np, "allwinner,pixel-format", &format);
+	device_property_read_string(dev, "allwinner,pixel-format", &format);
 
 	for (i = 0; i < ARRAY_SIZE(sun50i_a100_ledc_formats); i++) {
 		if (!strcmp(format, sun50i_a100_ledc_formats[i])) {
@@ -262,7 +263,7 @@ static int sun50i_a100_ledc_parse_format(const struct device_node *np,
 		}
 	}
 
-	return dev_err_probe(priv->dev, -EINVAL, "Bad pixel format '%s'\n", format);
+	return dev_err_probe(dev, -EINVAL, "Bad pixel format '%s'\n", format);
 }
 
 static void sun50i_a100_ledc_set_format(struct sun50i_a100_ledc *priv)
@@ -283,18 +284,18 @@ static const struct sun50i_a100_ledc_timing sun50i_a100_ledc_default_timing = {
 	.treset_ns = 300000,
 };
 
-static int sun50i_a100_ledc_parse_timing(const struct device_node *np,
+static int sun50i_a100_ledc_parse_timing(struct device *dev,
 					 struct sun50i_a100_ledc *priv)
 {
 	struct sun50i_a100_ledc_timing *timing = &priv->timing;
 
 	*timing = sun50i_a100_ledc_default_timing;
 
-	of_property_read_u32(np, "allwinner,t0h-ns", &timing->t0h_ns);
-	of_property_read_u32(np, "allwinner,t0l-ns", &timing->t0l_ns);
-	of_property_read_u32(np, "allwinner,t1h-ns", &timing->t1h_ns);
-	of_property_read_u32(np, "allwinner,t1l-ns", &timing->t1l_ns);
-	of_property_read_u32(np, "allwinner,treset-ns", &timing->treset_ns);
+	device_property_read_u32(dev, "allwinner,t0h-ns", &timing->t0h_ns);
+	device_property_read_u32(dev, "allwinner,t0l-ns", &timing->t0l_ns);
+	device_property_read_u32(dev, "allwinner,t1h-ns", &timing->t1h_ns);
+	device_property_read_u32(dev, "allwinner,t1l-ns", &timing->t1l_ns);
+	device_property_read_u32(dev, "allwinner,treset-ns", &timing->treset_ns);
 
 	return 0;
 }
@@ -388,13 +389,12 @@ static void sun50i_a100_ledc_dma_cleanup(void *data)
 
 static int sun50i_a100_ledc_probe(struct platform_device *pdev)
 {
-	const struct device_node *np = pdev->dev.of_node;
 	struct dma_slave_config dma_cfg = {};
 	struct led_init_data init_data = {};
 	struct sun50i_a100_ledc_led *led;
 	struct device *dev = &pdev->dev;
 	struct sun50i_a100_ledc *priv;
-	struct device_node *child;
+	struct fwnode_handle *child;
 	struct resource *mem;
 	u32 max_addr = 0;
 	u32 num_leds = 0;
@@ -404,19 +404,19 @@ static int sun50i_a100_ledc_probe(struct platform_device *pdev)
 	 * The maximum LED address must be known in sun50i_a100_ledc_resume() before
 	 * class device registration, so parse and validate the subnodes up front.
 	 */
-	for_each_available_child_of_node(np, child) {
+	device_for_each_child_node(dev, child) {
 		u32 addr, color;
 
-		ret = of_property_read_u32(child, "reg", &addr);
+		ret = fwnode_property_read_u32(child, "reg", &addr);
 		if (ret || addr >= LEDC_MAX_LEDS) {
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return dev_err_probe(dev, -EINVAL, "'reg' must be between 0 and %d\n",
 					     LEDC_MAX_LEDS - 1);
 		}
 
-		ret = of_property_read_u32(child, "color", &color);
+		ret = fwnode_property_read_u32(child, "color", &color);
 		if (ret || color != LED_COLOR_ID_RGB) {
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return dev_err_probe(dev, -EINVAL, "'color' must be LED_COLOR_ID_RGB\n");
 		}
 
@@ -437,11 +437,11 @@ static int sun50i_a100_ledc_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->lock);
 	dev_set_drvdata(dev, priv);
 
-	ret = sun50i_a100_ledc_parse_format(np, priv);
+	ret = sun50i_a100_ledc_parse_format(dev, priv);
 	if (ret)
 		return ret;
 
-	ret = sun50i_a100_ledc_parse_timing(np, priv);
+	ret = sun50i_a100_ledc_parse_timing(dev, priv);
 	if (ret)
 		return ret;
 
@@ -504,11 +504,11 @@ static int sun50i_a100_ledc_probe(struct platform_device *pdev)
 		return ret;
 
 	led = priv->leds;
-	for_each_available_child_of_node(np, child) {
+	device_for_each_child_node(dev, child) {
 		struct led_classdev *cdev;
 
 		/* The node was already validated above. */
-		of_property_read_u32(child, "reg", &led->addr);
+		fwnode_property_read_u32(child, "reg", &led->addr);
 
 		led->subled_info[0].color_index = LED_COLOR_ID_RED;
 		led->subled_info[0].channel = 0;
@@ -524,7 +524,7 @@ static int sun50i_a100_ledc_probe(struct platform_device *pdev)
 		cdev->max_brightness = U8_MAX;
 		cdev->brightness_set = sun50i_a100_ledc_brightness_set;
 
-		init_data.fwnode = of_fwnode_handle(child);
+		init_data.fwnode = child;
 
 		ret = led_classdev_multicolor_register_ext(dev, &led->mc_cdev, &init_data);
 		if (ret) {
@@ -540,7 +540,7 @@ static int sun50i_a100_ledc_probe(struct platform_device *pdev)
 	return 0;
 
 err_put_child:
-	of_node_put(child);
+	fwnode_handle_put(child);
 	while (led-- > priv->leds)
 		led_classdev_multicolor_unregister(&led->mc_cdev);
 	sun50i_a100_ledc_suspend(&pdev->dev);
-- 
2.43.0.rc1.1.gbec44491f096


