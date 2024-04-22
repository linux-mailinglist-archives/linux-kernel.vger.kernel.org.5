Return-Path: <linux-kernel+bounces-153904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651218AD4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3BA281C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975C155342;
	Mon, 22 Apr 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U7kkZy04"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E890155339
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813565; cv=none; b=hCI1AHryhMVt3Zzl+PyUE8HyBryHwxmBV8AEeCbBbaHz53sMrfNdXqvimn7ZDP/FKtQn0k+8S98dHTv7DPUsRBWwriVKOU00bdM6h6qCRsRhXfxNGNsFvFaXdzDBFSksdeDvw61e961ljWOCmGr+zvZ8hixjIp++Uijynu5NLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813565; c=relaxed/simple;
	bh=lTMOjiI32YHsA1qANNB3UWZCb7HKBLJSfrYd6mjnAGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkWHUOLJw1koQQgTT3+Yj9V4H+NG2E6gbptOPQ8ZJYQIuFWDlQpt3kofjZPiXk/MzP9KcTmT1zTQeIlq30jwl3cIXkN9oRezrIP+iM0vYdHJeJxc0se55+l/EDzxiEXrXxtEI+tdoxeRWHfrSt61q6DpkKZvRotyKWBEvQkhdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U7kkZy04; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713813562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qkfsiav14z/13YCmF9WtxhNZzgVPszO86+CmRUhDZg=;
	b=U7kkZy04nAeUMoysfji3yq6jhBRqIPxmzTYDkdnFwVBepV4v3h5vj/nRJMMY6jXKQBmzZx
	Rlne9IAo5VyH6ntxyTFPpZ/A3udCag5m4PViPTbJQET94Ec2KYtAfu8d2bQX69RhlUq4lH
	XOCO2+UcAbO894J7ouzNYiQfP1y9EIU=
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
Subject: [PATCH v4 1/9] drm/bridge: Allow using fwnode API to get the next bridge
Date: Tue, 23 Apr 2024 03:18:55 +0800
Message-Id: <20240422191903.255642-2-sui.jingfeng@linux.dev>
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

Currently, the various display bridge drivers rely on OF infrastructures
to works very well, yet there are platforms and/or devices absence of 'OF'
support. Such as virtual display drivers, USB display apapters and ACPI
based systems etc.

Add fwnode based helpers to fill the niche, this allows part of the display
bridge drivers to work across systems. As the fwnode API has wider coverage
than DT counterpart and the fwnode graphs are compatible with the OF graph,
so the provided helpers can be used on all systems in theory. Assumed that
the system has valid fwnode graphs established before drm bridge drivers
are probed, and there has fwnode assigned to involved drm bridge instance.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_bridge.c | 74 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 16 ++++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 28abe9aa99ca..fc1a314140e7 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1368,6 +1368,80 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
+/**
+ * drm_bridge_find_by_fwnode - Find the bridge corresponding to the fwnode
+ *
+ * @fwnode: fwnode for which to find the matching drm_bridge
+ *
+ * This function looks up a drm_bridge in the global bridge list, based on
+ * its associated fwnode. Drivers who want to use this function should has
+ * fwnode handle assigned to the fwnode member of the struct drm_bridge
+ * instance.
+ *
+ * Returns:
+ *  * A reference to the requested drm_bridge object on success, or
+ *  * %NULL otherwise (object does not exist or the driver of requested
+ *    bridge not probed yet).
+ */
+struct drm_bridge *drm_bridge_find_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct drm_bridge *ret = NULL;
+	struct drm_bridge *bridge;
+
+	if (!fwnode)
+		return NULL;
+
+	mutex_lock(&bridge_lock);
+
+	list_for_each_entry(bridge, &bridge_list, list) {
+		if (bridge->fwnode == fwnode) {
+			ret = bridge;
+			break;
+		}
+	}
+
+	mutex_unlock(&bridge_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(drm_bridge_find_by_fwnode);
+
+/**
+ * drm_bridge_find_next_bridge_by_fwnode - Find the next bridge by fwnode
+ * @fwnode: fwnode pointer to the current device.
+ * @port: identifier of the port node of the next bridge is connected.
+ *
+ * This function find the next bridge at the current node, it assumed that
+ * there has valid fwnode graph established.
+ *
+ * Returns:
+ *  * A reference to the requested drm_bridge object on success, or
+ *  * -%EINVAL or -%ENODEV if the fwnode graph or OF graph is not complete, or
+ *  * %NULL if object does not exist or the next bridge is not probed yet.
+ */
+struct drm_bridge *
+drm_bridge_find_next_bridge_by_fwnode(struct fwnode_handle *fwnode, u32 port)
+{
+	struct drm_bridge *bridge;
+	struct fwnode_handle *ep;
+	struct fwnode_handle *remote;
+
+	ep = fwnode_graph_get_endpoint_by_id(fwnode, port, 0, 0);
+	if (!ep)
+		return ERR_PTR(-EINVAL);
+
+	remote = fwnode_graph_get_remote_port_parent(ep);
+	fwnode_handle_put(ep);
+	if (!remote)
+		return ERR_PTR(-ENODEV);
+
+	bridge = drm_bridge_find_by_fwnode(remote);
+	fwnode_handle_put(remote);
+
+	return bridge;
+}
+EXPORT_SYMBOL_GPL(drm_bridge_find_next_bridge_by_fwnode);
+
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
 MODULE_DESCRIPTION("DRM bridge infrastructure");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 4baca0d9107b..a3f5d12a308c 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -26,6 +26,7 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_encoder.h>
@@ -721,6 +722,8 @@ struct drm_bridge {
 	struct list_head chain_node;
 	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
+	/** @fwnode: fwnode pointer to the bridge */
+	struct fwnode_handle *fwnode;
 	/** @list: to keep track of all added bridges */
 	struct list_head list;
 	/**
@@ -788,6 +791,13 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		      struct drm_bridge *previous,
 		      enum drm_bridge_attach_flags flags);
 
+static inline void
+drm_bridge_set_node(struct drm_bridge *bridge, struct fwnode_handle *fwnode)
+{
+	bridge->fwnode = fwnode;
+	bridge->of_node = to_of_node(fwnode);
+}
+
 #ifdef CONFIG_OF
 struct drm_bridge *of_drm_find_bridge(struct device_node *np);
 #else
@@ -797,6 +807,12 @@ static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 }
 #endif
 
+struct drm_bridge *
+drm_bridge_find_by_fwnode(struct fwnode_handle *fwnode);
+
+struct drm_bridge *
+drm_bridge_find_next_bridge_by_fwnode(struct fwnode_handle *fwnode, u32 port);
+
 /**
  * drm_bridge_get_next_bridge() - Get the next bridge in the chain
  * @bridge: bridge object
-- 
2.34.1


