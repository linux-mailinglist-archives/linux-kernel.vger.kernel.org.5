Return-Path: <linux-kernel+bounces-167919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424A38BB117
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84A7282588
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D688156F2A;
	Fri,  3 May 2024 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kR4prRwM"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116BE156C73
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754505; cv=none; b=Rc+Xwbl4BvmEb+q2/kqGqn5eiK2xF6qBsycJpdezoe1kXjOzwfresllrqfCJ+ikkSIPefEISF88WMNSoeprDHPFdidOHAYFXVdEyuqgKcWI4WldYjXRktpLV1bF8AsxrkU3c0NtpXdHyEoudLHOzHC9D10CwhzutKLJlLAIwt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754505; c=relaxed/simple;
	bh=738etampJ9m37JMTtzzW2+WYdjJ/ZGAALPaqCLoaW6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dk2TpWsuXqfsuaHAnILROWcO7MIa64ngQv+/CvzhOIRsn+tebz+ZCwaV3Wcnhz0bThCETGd6kNI3lx3pFKjdUB8l9p5ghj23pUiIUm5mUoqmetorZ/wDo84dSIRasw2AZpOdTVyN612vQGk2HkUuXXpngTJ6FglrVsz1/ayBCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kR4prRwM; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714754502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PB1TUtuAuL++SWCo4tYuatJMpIlybQp31QpILaCl8YA=;
	b=kR4prRwMmpHQXCSr8gv/7Yz6tg6VXOJNY1k/nESj4xHi/P/SX6BWWQ3C2zKcmEAZOl4fjA
	3ZPaVhGJHRIV8RRyuxYLqXxV1pT1IbOtU5k0w5MAcuqPQ4Wl+7WKCTQSt6clsStAcFPxb+
	3C5HxHqBOs0Omx4kf1Lx8YU9RWgLilA=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v5 05/10] drm/bridge: sii902x: Switch to use fwnode APIs to acquire device properties
Date: Sat,  4 May 2024 00:41:01 +0800
Message-Id: <20240503164106.1172650-6-sui.jingfeng@linux.dev>
In-Reply-To: <20240503164106.1172650-1-sui.jingfeng@linux.dev>
References: <20240503164106.1172650-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make this driver less DT-dependent by calling the freshly created helpers,
also switch to use fwnode APIs to acquire additional device properties.
One side benifit is that boilerplates get reduced, no functional changes
for DT-based systems.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/sii902x.c | 45 ++++++++++++--------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 8f84e98249c7..bc906b71c793 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -827,20 +827,17 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
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
+	num_lanes = fwnode_property_count_u8(fwnode, "sil,i2s-data-lanes");
 	if (num_lanes == -EINVAL) {
 		dev_dbg(dev,
 			"%s: No \"sil,i2s-data-lanes\", use default <0>\n",
@@ -852,7 +849,11 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 			"%s: Error gettin \"sil,i2s-data-lanes\": %d\n",
 			__func__, num_lanes);
 		return num_lanes;
+	} else {
+		fwnode_property_read_u8_array(fwnode, "sil,i2s-data-lanes",
+					      lanes, num_lanes);
 	}
+
 	codec_data.max_i2s_channels = 2 * num_lanes;
 
 	for (i = 0; i < num_lanes; i++)
@@ -1096,8 +1097,8 @@ static int sii902x_init(struct sii902x *sii902x)
 	if (ret)
 		goto err_unreg_audio;
 
+	drm_bridge_set_node(&sii902x->bridge, dev_fwnode(dev));
 	sii902x->bridge.funcs = &sii902x_bridge_funcs;
-	sii902x->bridge.of_node = dev->of_node;
 	sii902x->bridge.timings = &default_sii902x_timings;
 	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
 
@@ -1118,7 +1119,6 @@ static int sii902x_init(struct sii902x *sii902x)
 static int sii902x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct device_node *endpoint;
 	struct sii902x *sii902x;
 	static const char * const supplies[] = {"iovcc", "cvcc12"};
 	int ret;
@@ -1147,27 +1147,14 @@ static int sii902x_probe(struct i2c_client *client)
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


