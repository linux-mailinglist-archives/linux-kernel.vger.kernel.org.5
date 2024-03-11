Return-Path: <linux-kernel+bounces-98564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302DC877C09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C691F21825
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450C1A708;
	Mon, 11 Mar 2024 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ywxh3D3S"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632118B15
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147506; cv=none; b=YDhlduS2B0Yd/jvtEPWlFAQVKyM6vNfrfXmnNSVcOoaVOppFf3kj/Ri7MQi+6/91lfgrboojZ8yTcRW1rd5a9S5oW1Y61t23C9UnxXJD+SdCRXfrLTyE+eL+gkUu7/foQyzA8yTzS98Z50N2b/fEVNqgf3RudJm+WdVM5AafjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147506; c=relaxed/simple;
	bh=g2uyYKP3fTMNqz1inMg+JCYrTWQJzGEy4xF64bwHe0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sA3CBo8UiKWayNGCPWSumWvkTBq+B3e6leVn2DtddnWGYL+GQGUAh/Ah9G1GsItcDopIxu9uX8WJuBclvczQuygEZWz7F+NkgkuQSh8IuqJjFo7brOb5+dNzD820FoEm0eipKxklLItP7grDZ3daaJxsYKUbnjRHYzGsnWJwDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ywxh3D3S; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710147503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdzVq0hSo8fS18z5xoeY8+4STJ0X8hxCUiiSMI/5/9M=;
	b=Ywxh3D3SbrIHx8AEv7gkKxSf5+SpuEuijnz6eh4LyUC/DpETfJQ2PqNRZK5hpW4G+2gp2d
	cMpUqMBV16jezAgqshRIwG7EJiTvGdCgMlwVkKHQZgzxitnpjeaJYKXhsByZCQJg8ODzsf
	niiBVJt6/TS1cdn8urUBCRGpIq2Ng6Q=
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
Subject: [PATCH v3 2/5] drm/bridge: simple-bridge: Use fwnode API to acquire device properties
Date: Mon, 11 Mar 2024 16:56:56 +0800
Message-Id: <20240311085659.244043-3-sui.jingfeng@linux.dev>
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
do no harms.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 5813a2c4fc5e..3b09bdd5ad4d 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -9,7 +9,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
@@ -169,33 +168,32 @@ static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
 
 static int simple_bridge_probe(struct platform_device *pdev)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
 	struct simple_bridge *sbridge;
-	struct device_node *remote;
+	int ret;
 
 	sbridge = devm_kzalloc(&pdev->dev, sizeof(*sbridge), GFP_KERNEL);
 	if (!sbridge)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, sbridge);
 
-	sbridge->info = of_device_get_match_data(&pdev->dev);
+	sbridge->info = device_get_match_data(&pdev->dev);
 
 	/* Get the next bridge in the pipeline. */
-	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
-	if (!remote)
-		return -EINVAL;
-
-	sbridge->next_bridge = of_drm_find_bridge(remote);
-	of_node_put(remote);
-
+	sbridge->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
 	if (!sbridge->next_bridge) {
 		dev_dbg(&pdev->dev, "Next bridge not found, deferring probe\n");
 		return -EPROBE_DEFER;
+	} else if (IS_ERR(sbridge->next_bridge)) {
+		ret = PTR_ERR(sbridge->next_bridge);
+		dev_err(&pdev->dev, "Error on finding the next bridge: %d\n", ret);
+		return ret;
 	}
 
 	/* Get the regulator and GPIO resources. */
 	sbridge->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
 	if (IS_ERR(sbridge->vdd)) {
-		int ret = PTR_ERR(sbridge->vdd);
+		ret = PTR_ERR(sbridge->vdd);
 		if (ret == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		sbridge->vdd = NULL;
@@ -210,9 +208,9 @@ static int simple_bridge_probe(struct platform_device *pdev)
 
 	/* Register the bridge. */
 	sbridge->bridge.funcs = &simple_bridge_bridge_funcs;
-	sbridge->bridge.of_node = pdev->dev.of_node;
 	sbridge->bridge.timings = sbridge->info->timings;
 
+	drm_bridge_set_node(&sbridge->bridge, fwnode);
 	drm_bridge_add(&sbridge->bridge);
 
 	return 0;
-- 
2.34.1


