Return-Path: <linux-kernel+bounces-167917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C778BB114
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA49B231ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEE9156C51;
	Fri,  3 May 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OD7/09iq"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A1156C4F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754496; cv=none; b=u/T0aHEm/pDG3DqL+9NHzxOfzmtYt/4OtBgCM4T1ZWqIOBnOiE1aHxZpWhU+SE1QLH4443gzuL/q1froon5LyTS9L1245jkLHrAnnW7v9Q46w3MFDLL5q+QW1gwh+0O6A7mYYvAIiZ79bzfESQApQB48JszqLiO0X/SvATnfR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754496; c=relaxed/simple;
	bh=HnaVgBqe9m8+G1f8WS8ykVxfLU1a8bkftOe8Stppbbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmAPf0Ma4GGl2avr5j1fIFM/1UPQ2jOXylLylyvvRVpsDIX6xsBbbWob9W0e9cKiqz2sKJ0FPtDY6P1L01JPs7iwKIyjuq3M/BXTCwYOJ6XEaHyyzwfqSy1K13s7kgd1LWXiS6lguw496ohoMg8BlIVKRRTCcedg3EhkoMTG3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OD7/09iq; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714754493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwBGzApFewAP1R1hUA1C3ehCFcGWcTVW40ujUMpzuS4=;
	b=OD7/09iqlp+lq7/G60IBN4bu/UCFSvxHUn17exg+h7y0Ji5UE31gkhqQ463anTHGqEjVOX
	BId+qsybxqsSOQKgZaz1cA0QenFbSd7cHvidsQXuiSRauNgkWOc/QKgvv60zQzy+ojPGI9
	akvuAYNGDWMEYgDQy/nXiY7+fBU+to0=
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
Subject: [PATCH v5 03/10] drm/bridge: simple-bridge: Use fwnode APIs to acquire device properties
Date: Sat,  4 May 2024 00:40:59 +0800
Message-Id: <20240503164106.1172650-4-sui.jingfeng@linux.dev>
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

Make this driver less DT-dependent by calling the newly created helpers,
also switch to use fwnode APIs to acquire additional device properties.
A side benifit is that boilerplates get reduced, no functional changes
for DT-based systems.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 5813a2c4fc5e..865ddd38f371 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -8,8 +8,6 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
@@ -169,33 +167,32 @@ static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
 
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
@@ -209,8 +206,8 @@ static int simple_bridge_probe(struct platform_device *pdev)
 				     "Unable to retrieve enable GPIO\n");
 
 	/* Register the bridge. */
+	drm_bridge_set_node(&sbridge->bridge, fwnode);
 	sbridge->bridge.funcs = &simple_bridge_bridge_funcs;
-	sbridge->bridge.of_node = pdev->dev.of_node;
 	sbridge->bridge.timings = sbridge->info->timings;
 
 	drm_bridge_add(&sbridge->bridge);
-- 
2.34.1


