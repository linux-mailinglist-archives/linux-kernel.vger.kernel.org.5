Return-Path: <linux-kernel+bounces-153909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936248AD4C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14160B24073
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F0155353;
	Mon, 22 Apr 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="grekojdB"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A360155741
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813588; cv=none; b=kPkcbz9lHRaWgI+AHtLMn4PqLW0y9TmVuWEuCk/rU7EItPCj+Jbpz7Tlhbc6W7WElSisH5YOm2TKwFIZ61ZGwEM3w3ZPs0xq3KhvUAKYlTs9HxYdxeQSWIA5YkS27EdRhmQxKk2llasMBenn2IMdYb2rKINU3HetR1cEHEH7VY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813588; c=relaxed/simple;
	bh=0z4jA9IGwkMpbvi/J7KFVTEV+EWhthH8+LkBoy3vb4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tcdB6yDwyQVfU3+FApXbSgJWLxuszsbssL85+V3W+PngdTC6hxM+jJmCwWecHLD52jTjOQFnmn/ciTWmky2xWIxRZNGnlQa5Es7Y9M7a52j06EVoJdGQIT90Fn+0LphVpDRD17mIPD4VWZevAw7EzngA7ID62WY3TplFNOXk2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=grekojdB; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713813585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tEoow3QlZGEbyC23DthOGK7n4k2QNy+D7Afpqn4m4E=;
	b=grekojdBfk5IRS1AuUtJx9mglk/CpIRleMxyBUxlK5LaySMjdhQaMGbN6vbnhyBdbFTznE
	RK2njiinQPUzemCRsUx6Pa4vGXlQYvb/9ybEQhBv17JNscdUsW7M9I5td3VipSkIMuzC5a
	o/ZnnMZ8lZCzvy0oyynUBDOnPvslrII=
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
Subject: [PATCH v4 6/9] drm-bridge: sii902x: Use fwnode API to acquire device properties
Date: Tue, 23 Apr 2024 03:19:00 +0800
Message-Id: <20240422191903.255642-7-sui.jingfeng@linux.dev>
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

Make this driver less DT-dependent by calling the freshly created helper
functions, which reduce boilerplate. Should be no functional changes for
DT based systems.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/sii902x.c | 43 +++++++++++---------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 8f84e98249c7..04436f318c7f 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -827,20 +827,19 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 		.spdif = 0,
 		.max_i2s_channels = 0,
 	};
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	u8 lanes[4];
 	int num_lanes, i;
 
-	if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
+	if (!fwnode_property_present(fwnode, "#sound-dai-cells")) {
 		dev_dbg(dev, "%s: No \"#sound-dai-cells\", no audio\n",
 			__func__);
 		return 0;
 	}
 
-	num_lanes = of_property_read_variable_u8_array(dev->of_node,
-						       "sil,i2s-data-lanes",
-						       lanes, 1,
-						       ARRAY_SIZE(lanes));
-
+	num_lanes = fwnode_property_read_u8_array(fwnode,
+						  "sil,i2s-data-lanes",
+						  lanes, ARRAY_SIZE(lanes));
 	if (num_lanes == -EINVAL) {
 		dev_dbg(dev,
 			"%s: No \"sil,i2s-data-lanes\", use default <0>\n",
@@ -1097,13 +1096,13 @@ static int sii902x_init(struct sii902x *sii902x)
 		goto err_unreg_audio;
 
 	sii902x->bridge.funcs = &sii902x_bridge_funcs;
-	sii902x->bridge.of_node = dev->of_node;
 	sii902x->bridge.timings = &default_sii902x_timings;
 	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
 
 	if (sii902x->i2c->irq > 0)
 		sii902x->bridge.ops |= DRM_BRIDGE_OP_HPD;
 
+	drm_bridge_set_node(&sii902x->bridge, dev_fwnode(dev));
 	drm_bridge_add(&sii902x->bridge);
 
 	return 0;
@@ -1118,7 +1117,6 @@ static int sii902x_init(struct sii902x *sii902x)
 static int sii902x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct device_node *endpoint;
 	struct sii902x *sii902x;
 	static const char * const supplies[] = {"iovcc", "cvcc12"};
 	int ret;
@@ -1147,27 +1145,14 @@ static int sii902x_probe(struct i2c_client *client)
 		return PTR_ERR(sii902x->reset_gpio);
 	}
 
-	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
-	if (endpoint) {
-		struct device_node *remote = of_graph_get_remote_port_parent(endpoint);
-
-		of_node_put(endpoint);
-		if (!remote) {
-			dev_err(dev, "Endpoint in port@1 unconnected\n");
-			return -ENODEV;
-		}
-
-		if (!of_device_is_available(remote)) {
-			dev_err(dev, "port@1 remote device is disabled\n");
-			of_node_put(remote);
-			return -ENODEV;
-		}
-
-		sii902x->next_bridge = of_drm_find_bridge(remote);
-		of_node_put(remote);
-		if (!sii902x->next_bridge)
-			return dev_err_probe(dev, -EPROBE_DEFER,
-					     "Failed to find remote bridge\n");
+	sii902x->next_bridge = drm_bridge_find_next_bridge_by_fwnode(dev_fwnode(dev), 1);
+	if (!sii902x->next_bridge) {
+		return dev_err_probe(dev, -EPROBE_DEFER,
+				     "Failed to find the next bridge\n");
+	} else if (IS_ERR(sii902x->next_bridge)) {
+		ret = PTR_ERR(sii902x->next_bridge);
+		dev_err(dev, "Error on find the next bridge: %d\n", ret);
+		return ret;
 	}
 
 	mutex_init(&sii902x->mutex);
-- 
2.34.1


