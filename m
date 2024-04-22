Return-Path: <linux-kernel+bounces-153905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D08AD4BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A081C21038
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79466155359;
	Mon, 22 Apr 2024 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="duhA1RQz"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3E155356
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813569; cv=none; b=neVC6ka8r88ZK/T+/HuXzk8kWPbKYkVHCprp81U0pGU+6B0GrftRSs8ppIXLU5+zeMrus5eSup3/a+x7FncpCegAaYwKBQtIU8iPOj32YTRou1+ho/mUws0j5VUD+idOgPr7kt6RC5TDgdJ6ykz319dheZwbp+MlrPlH+hmi9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813569; c=relaxed/simple;
	bh=g2uyYKP3fTMNqz1inMg+JCYrTWQJzGEy4xF64bwHe0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rs6NvisagyUN48LYUskCZC1cSJUOX+QwgW1Njz58UuvBXTHVdmMn5TXUeDewx6KiPgjS/UBtSwAiw89/0C+Uz6bLtwGMN0iXiqsWFOFuZp+gAqJPZk6MhlPz0g04eUYKwSc5L0J6jMlDopG/G2poxVccbr9Yj7eZrk/EXU1P//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=duhA1RQz; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713813566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdzVq0hSo8fS18z5xoeY8+4STJ0X8hxCUiiSMI/5/9M=;
	b=duhA1RQznC1J8pwivtIZfwp0dvGCXf1fBt5p4kOOd6DxGSSr0yi0YiaF3GxpDFV8SYKRCW
	xH86JxsMHtCe3To2cUKpvMFzu8R0CpyI+Qmlqifj+5IwsS/aP95n3tIfXwrN165NR7ahOJ
	ccklRIJwDIW5ymmuB4kVprvVOQ4f8eI=
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
Subject: [PATCH v4 2/9] drm/bridge: simple-bridge: Use fwnode API to acquire device properties
Date: Tue, 23 Apr 2024 03:18:56 +0800
Message-Id: <20240422191903.255642-3-sui.jingfeng@linux.dev>
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


