Return-Path: <linux-kernel+bounces-98566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B0877C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50461C20DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B95C2B9DC;
	Mon, 11 Mar 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q1a9WOJM"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E522B9C3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147519; cv=none; b=HW+Kr9XlHUgzUtdoEJ2VQU0g/ygXP6wxF3Rs0G1eqTnBySL/6+MKwPDMem700b4z4T8EkyfKYw7gP/d0VJ1l7LnmZIZD5Nv3d29IpMYZTaEeY3a+bphJlnd7EO3gdCS54W/1r2MFV0nUmI47H+yYixGTmzgishUy2sfXPiiWdYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147519; c=relaxed/simple;
	bh=pXovRMjeL4ByE/vpL205Xui8tHsOBRVHXcsA1vI1bRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7ZaXiwW3iPOd9+WebCDo2R6Ds5K9mszTNYmRIbeMJeLnp0DRoop7TPR8uQ6XXSkn+JdCuTF2ern3ZXJzzTAQtQ8nt6EoUZWB1rsIJoa3rAKP5246IvgZWKzuYEruY1gv10o7nwyKcZReN7Hlg17Dg+RatJ0hc7LGurHEXVGMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q1a9WOJM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710147516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpFxJ3SaUbuEjaQuODo+eOlkZ4g0ImTCeEIwDGa1hhA=;
	b=Q1a9WOJMkc6IbEnTNssVw0C/c+fyjJxbDseLI6wW8C0ScFVC3LHPQL2pRsybyFCO6kZuG3
	mUGJoDd7l3sI18d1hohdqwH/upk833TzmPftgrcXzlvbljTiJu3tledqhM1kfpd9bVQ4pZ
	4Zw9aruiMISUP9qQVBd/TUtAGUtFeXw=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Phong LE <ple@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v3 4/5] drm-bridge: it66121: Use fwnode API to acquire device properties
Date: Mon, 11 Mar 2024 16:56:58 +0800
Message-Id: <20240311085659.244043-5-sui.jingfeng@linux.dev>
In-Reply-To: <20240311085659.244043-1-sui.jingfeng@linux.dev>
References: <20240311085659.244043-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make this driver less DT-dependent by calling the freshly created helpers,
should be no functional changes for DT based systems. But open the door for
otherwise use cases. Even though there is no user emerged yet, this still
do no harms. In fact, we reduce boilerplate across drm bridge drivers.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 63 +++++++++++++++-------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 1c3433b5e366..a04d755fed4c 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -15,7 +15,6 @@
 #include <linux/bitfield.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-#include <linux/of_graph.h>
 #include <linux/gpio/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
@@ -1480,7 +1479,7 @@ static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
 
 	dev_dbg(dev, "%s\n", __func__);
 
-	if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
+	if (!fwnode_property_present(dev_fwnode(dev), "#sound-dai-cells")) {
 		dev_info(dev, "No \"#sound-dai-cells\", no audio\n");
 		return 0;
 	}
@@ -1503,13 +1502,36 @@ static const char * const it66121_supplies[] = {
 	"vcn33", "vcn18", "vrf12"
 };
 
+static int it66121_read_bus_width(struct fwnode_handle *fwnode, u32 *bus_width)
+{
+	struct fwnode_handle *endpoint;
+	u32 val;
+	int ret;
+
+	endpoint = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
+	if (!endpoint)
+		return -EINVAL;
+
+	ret = fwnode_property_read_u32(endpoint, "bus-width", &val);
+	fwnode_handle_put(endpoint);
+	if (ret)
+		return ret;
+
+	if (val != 12 && val != 24)
+		return -EINVAL;
+
+	*bus_width = val;
+
+	return 0;
+}
+
 static int it66121_probe(struct i2c_client *client)
 {
 	u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
-	struct device_node *ep;
 	int ret;
 	struct it66121_ctx *ctx;
 	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(dev, "I2C check functionality failed.\n");
@@ -1520,35 +1542,20 @@ static int it66121_probe(struct i2c_client *client)
 	if (!ctx)
 		return -ENOMEM;
 
-	ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
-	if (!ep)
-		return -EINVAL;
-
 	ctx->dev = dev;
 	ctx->client = client;
 	ctx->info = i2c_get_match_data(client);
 
-	of_property_read_u32(ep, "bus-width", &ctx->bus_width);
-	of_node_put(ep);
-
-	if (ctx->bus_width != 12 && ctx->bus_width != 24)
-		return -EINVAL;
-
-	ep = of_graph_get_remote_node(dev->of_node, 1, -1);
-	if (!ep) {
-		dev_err(ctx->dev, "The endpoint is unconnected\n");
-		return -EINVAL;
-	}
-
-	if (!of_device_is_available(ep)) {
-		of_node_put(ep);
-		dev_err(ctx->dev, "The remote device is disabled\n");
-		return -ENODEV;
-	}
+	ret = it66121_read_bus_width(fwnode, &ctx->bus_width);
+	if (ret)
+		return ret;
 
-	ctx->next_bridge = of_drm_find_bridge(ep);
-	of_node_put(ep);
-	if (!ctx->next_bridge) {
+	ctx->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
+	if (IS_ERR(ctx->next_bridge)) {
+		ret = PTR_ERR(ctx->next_bridge);
+		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
+		return ret;
+	} else if (!ctx->next_bridge) {
 		dev_dbg(ctx->dev, "Next bridge not found, deferring probe\n");
 		return -EPROBE_DEFER;
 	}
@@ -1584,9 +1591,9 @@ static int it66121_probe(struct i2c_client *client)
 	}
 
 	ctx->bridge.funcs = &it66121_bridge_funcs;
-	ctx->bridge.of_node = dev->of_node;
 	ctx->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	ctx->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
+	drm_bridge_set_node(&ctx->bridge, fwnode);
 
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,	it66121_irq_threaded_handler,
 					IRQF_ONESHOT, dev_name(dev), ctx);
-- 
2.34.1


