Return-Path: <linux-kernel+bounces-153910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380638AD4C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71D51F2371B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926FC155326;
	Mon, 22 Apr 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tkeZhKjV"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60725155A50
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813593; cv=none; b=gsAXTBQaMinxDteRdC7FCYL16z+xLTY7fuNaVSY2jZTazSAnSHgUMHe2UO+9kv4XhCmfyk56D+9HrI6AVDt38s1fl+HXvyS5E/gxPxOx6Wsu69WRk+ULPIO+rojAFDvftKCRXumjTG9KZschki4dwNNPfii0cJWuEN9U0OovAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813593; c=relaxed/simple;
	bh=lmbOAIR4fhp7i68dhNsChCkO1KTe82Jsg7qFc9Zk+Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cj/yd6x9BS5Crn5l4s4ckzEjsbgTmfRKHABOvwHa4A0a2wqWjQfwP8/Ez6NvtHC2SKcFqTUDEsODVOZLZt4aQpWZJpX1WmMYUd4zVSeINl/qiIOz/hhgaSiSmvxFog1qKW2S/n81kXyfA7jWTdif59+zCJpbRwN6cWViaIjxkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tkeZhKjV; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713813590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqEhBcfnv9rUbWN96BkVZjg/A8+GnWYlmO3Ge72EuvE=;
	b=tkeZhKjVLuvfh6Foyzk3MbB2uAvEY5upHeSRQ+blEYlElqGcK63pkFZY0N3cCd3XH2JdF/
	huv7OpW7uxnTL+qtFVG+Isu7CoTzn8Exnttl2egWGTj0p3+3+NVSO6UbTvV0MLeRO0z4/u
	o2sk53FsT3BzwQVRuUBUpra9pTTgNjM=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Phong LE <ple@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v4 7/9] drm-bridge: it66121: Use fwnode API to acquire device properties
Date: Tue, 23 Apr 2024 03:19:01 +0800
Message-Id: <20240422191903.255642-8-sui.jingfeng@linux.dev>
In-Reply-To: <20240422191903.255642-1-sui.jingfeng@linux.dev>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make this driver DT-independent by calling the freshly created helpers,
which reduce boilerplate and open the door for otherwise use cases. No
functional changes for DT based systems.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 57 +++++++++++++++++-----------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 925e42f46cd8..688dc1830654 100644
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
@@ -1520,29 +1542,20 @@ static int it66121_probe(struct i2c_client *client)
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
@@ -1577,8 +1590,8 @@ static int it66121_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
+	drm_bridge_set_node(&ctx->bridge, fwnode);
 	ctx->bridge.funcs = &it66121_bridge_funcs;
-	ctx->bridge.of_node = dev->of_node;
 	ctx->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	ctx->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
 	if (client->irq > 0) {
-- 
2.34.1


