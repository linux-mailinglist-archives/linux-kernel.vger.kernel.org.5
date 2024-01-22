Return-Path: <linux-kernel+bounces-33700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E8836E13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A35B31E38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDB873194;
	Mon, 22 Jan 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hRUoIKsM"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3743E6EB7E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941160; cv=none; b=RLr8sc3fq9Pm3zQqoxcM8mmVHguUKuVu3XMExDGJh9m6HLwuge1bapWDo74ci9/VFufqVqezsnsXo3/OoglZZmdfav2dQW2nLRNyrr721t5JKEvWKHFz1qyqnBEvTInSyB1r5w76yZ4oz5DPixTW0AUdmtu2GtKpnReUncKHEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941160; c=relaxed/simple;
	bh=NUwOnB7z3Jkgn5qG2ac0cxgyuyamotCv2+iPCv6JTE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTizMc62P81X3YZWJsw07D86UlaIleZfn1jrXz5/2dwaRGYDxTJ0tEdNmmLHE3/vj/b6nUQIBYgGez5quuTGStzNjBsNmx1R9hl3t59QUwthbQh38H1kuzssl6OGp+Wgp5Fnyod/IcrZHxmT/PWDRPJZVxtos9Y2vROjd89YRB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hRUoIKsM; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705941157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npqubJ7Bj7Hp+PXoNaKT0QhmaM+1u+5VldbVzcNqcKI=;
	b=hRUoIKsMG7O90bNfo9wUm9cKlyUIAfVjI4dIh3/xy6G+8thfA1pGQs/f/I5Oi++EeXrUn9
	0XAc430aKgJPelbVcykvQoJGZFSURld61Ju7l2nauidb8/x/9f3JpOpcrLltpKuC7wjU7K
	tmZ7Z3BqE4EdU1baTkmqgktMCMufG78=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: David Airlie <airlied@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 3/5] drm/bridge: simple-bridge: Allow acquiring the next bridge with fwnode API
Date: Tue, 23 Jan 2024 00:32:18 +0800
Message-Id: <20240122163220.110788-4-sui.jingfeng@linux.dev>
In-Reply-To: <20240122163220.110788-1-sui.jingfeng@linux.dev>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Which make it possible to use this driver on non-DT based systems,
meanwhile, made no functional changes for DT based systems.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 51 ++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 595f672745b9..cfea5a67cc5b 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -184,6 +184,39 @@ static const void *simple_bridge_get_match_data(const struct device *dev)
 	return NULL;
 }
 
+static int simple_bridge_get_next_bridge_by_fwnode(struct device *dev,
+						   struct drm_bridge **next_bridge)
+{
+	struct drm_bridge *bridge;
+	struct fwnode_handle *ep;
+	struct fwnode_handle *remote;
+
+	ep = fwnode_graph_get_endpoint_by_id(dev->fwnode, 1, 0, 0);
+	if (!ep) {
+		dev_err(dev, "The endpoint is unconnected\n");
+		return -EINVAL;
+	}
+
+	remote = fwnode_graph_get_remote_port_parent(ep);
+	fwnode_handle_put(ep);
+	if (!remote) {
+		dev_err(dev, "No valid remote node\n");
+		return -ENODEV;
+	}
+
+	bridge = drm_bridge_find_by_fwnode(remote);
+	fwnode_handle_put(remote);
+
+	if (!bridge) {
+		dev_warn(dev, "Next bridge not found, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
+
+	*next_bridge = bridge;
+
+	return 0;
+}
+
 static int simple_bridge_probe(struct platform_device *pdev)
 {
 	struct simple_bridge *sbridge;
@@ -199,14 +232,17 @@ static int simple_bridge_probe(struct platform_device *pdev)
 	else
 		sbridge->info = simple_bridge_get_match_data(&pdev->dev);
 
-	/* Get the next bridge in the pipeline. */
-	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
-	if (!remote)
-		return -EINVAL;
-
-	sbridge->next_bridge = of_drm_find_bridge(remote);
-	of_node_put(remote);
+	if (pdev->dev.of_node) {
+		/* Get the next bridge in the pipeline. */
+		remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
+		if (!remote)
+			return -EINVAL;
 
+		sbridge->next_bridge = of_drm_find_bridge(remote);
+		of_node_put(remote);
+	} else {
+		simple_bridge_get_next_bridge_by_fwnode(&pdev->dev, &sbridge->next_bridge);
+	}
 	if (!sbridge->next_bridge) {
 		dev_dbg(&pdev->dev, "Next bridge not found, deferring probe\n");
 		return -EPROBE_DEFER;
@@ -231,6 +267,7 @@ static int simple_bridge_probe(struct platform_device *pdev)
 	/* Register the bridge. */
 	sbridge->bridge.funcs = &simple_bridge_bridge_funcs;
 	sbridge->bridge.of_node = pdev->dev.of_node;
+	sbridge->bridge.fwnode = pdev->dev.fwnode;
 	sbridge->bridge.timings = sbridge->info->timings;
 
 	drm_bridge_add(&sbridge->bridge);
-- 
2.25.1


