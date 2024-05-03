Return-Path: <linux-kernel+bounces-167923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B3D8BB11E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA93283483
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA09157A43;
	Fri,  3 May 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UNr4E4FS"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8984157472
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754524; cv=none; b=LvoOpAo8UH91bvBN0eYyXSDkdVUZduHC+TSdzGRBezXO2eKp7su45SO74PjV9QrmAktio4KVaCd9EFPvG6PDi8AB/3RfT40UvM29p7TIMmhLrfGNmdOLHRO5txnwaN7ZqEXfcpUAGMsWMyczpZ4ZiYygH1wO9BjhEspRuJbDz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754524; c=relaxed/simple;
	bh=5KQULLxyxu/ooDB/SLMB2DQ5twNYvG3KmWr+5XCmfw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVe3mqZIZSWOLlkVnuNovuUkhCcvu23UgC7CYipWLNOWAtuv1yKWYJnRlyfe3xCD74c14A12NZQy6Jh2C5mmly4fBhUbqgFPOqBYuFJRlFaUsvNBHKGuZVNgUijcGVLX/tdP3Ljeg9vhrc2CoLjkBJsyWU7dfobBv8r4KetAkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UNr4E4FS; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714754521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXsXWgPRCBE+gQiOjOKdcnsB3GxdmAh+Hr/Bm86MRo8=;
	b=UNr4E4FSFKlIa3SVv2RjJPn9HwLYSYiEMt4GQpa0BZblh+8PiJSYT9E8O/xcZJZnTD1X9x
	BsWtaJpDEEWBGBWstY0TGNmqK+k6RGlG5eQMPUT6DwwbWScA529MqNlSGgKpsVQYZjc5V7
	4Tlyfch7TEZcVSOcfYmJ9xHqv2+0mIo=
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
Subject: [PATCH v5 09/10] drm/bridge: ch7033: Switch to use fwnode based APIs
Date: Sat,  4 May 2024 00:41:05 +0800
Message-Id: <20240503164106.1172650-10-sui.jingfeng@linux.dev>
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

Use the freshly created helper to replace the use of DT-dependent APIs,
also print error log if the fwnode graph is not complete which is benefit
to debug.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/chrontel-ch7033.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index c83486cf6b15..d856ad0987cc 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -531,6 +531,7 @@ static const struct regmap_config ch7033_regmap_config = {
 static int ch7033_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct ch7033_priv *priv;
 	unsigned int val;
 	int ret;
@@ -541,10 +542,15 @@ static int ch7033_probe(struct i2c_client *client)
 
 	dev_set_drvdata(dev, priv);
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, -1, NULL,
-					  &priv->next_bridge);
-	if (ret)
+	priv->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
+	if (IS_ERR(priv->next_bridge)) {
+		ret = PTR_ERR(priv->next_bridge);
+		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
 		return ret;
+	} else if (!priv->next_bridge) {
+		dev_dbg(dev, "Next bridge not found, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
 
 	priv->regmap = devm_regmap_init_i2c(client, &ch7033_regmap_config);
 	if (IS_ERR(priv->regmap)) {
@@ -575,7 +581,7 @@ static int ch7033_probe(struct i2c_client *client)
 
 	INIT_LIST_HEAD(&priv->bridge.list);
 	priv->bridge.funcs = &ch7033_bridge_funcs;
-	priv->bridge.of_node = dev->of_node;
+	drm_bridge_set_node(&priv->bridge, fwnode);
 	drm_bridge_add(&priv->bridge);
 
 	dev_info(dev, "Chrontel CH7033 Video Encoder\n");
-- 
2.34.1


