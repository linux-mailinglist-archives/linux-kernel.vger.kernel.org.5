Return-Path: <linux-kernel+bounces-98563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD494877C07
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424B01F2152B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C262117548;
	Mon, 11 Mar 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mDOFhb/y"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5113AC4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147500; cv=none; b=CVROZIBPPE6Bz94qSooEel3mknPebb9tLtuVILBriiHhrqcXLVXMqWoTsUx0Ge2Nw9PSr+otT5aek7DTTGy6QkZXdGS2/sPcuFDXFK60NHhOoyu904N0pBnmGgwNW9DUMrHpulk9uZBAWK6lPubXtM59dbVQOcA6fIPElktxCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147500; c=relaxed/simple;
	bh=ddcyhwSvJwXB7FYvSYBSmbL0XpSvnL9leNwj9qrhD8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5nS1Gxjg2iCEgzcCfxw1Sk9LIRv81cX/c8fRP7esm1N00GXvvugRtd9BMRSCsDdj3GY9lfrKCWm2YFqNABnfsE8pG4XHbuXtOWEaHS46IZ8l40GmgCdNYC1CcjrUFiL94keiONmBVT5ehg6Kwu873g66qARmWaGbQebzpwToR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mDOFhb/y; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710147495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACbuVzqDGeY5B8aCLo+ycEpWur4XOQkFda8KsYe8re8=;
	b=mDOFhb/yw0YS3Ov2WeSr5X2tbx1OeqfTi2ChwZG6hVJkDe1Y6dHnlkgV2jMsRtt9eYSzEJ
	WOV922L0kD/7C4rj7Tpbmpjd6CiPFXdE1uPdyMGyLM923hkkK/oPTYVDP7lxdsYjMjSxfq
	+WPpEThoM1RvRsfRKpYmecZHLPZfJmk=
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
Subject: [PATCH v3 1/5] drm/bridge: Allow using fwnode API to get the next bridge
Date: Mon, 11 Mar 2024 16:56:55 +0800
Message-Id: <20240311085659.244043-2-sui.jingfeng@linux.dev>
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

Currently, the various drm bridge drivers relay on OF infrastructures to
works very well. Yet there are platforms and/or devices absence of OF
support. Such as virtual display drivers, USB display apapters and ACPI
based systems etc.

Add fwnode based helpers to fill the niche, this allows part of the drm
display bridge drivers to work across systems. As the fwnode based API
has wider coverage than DT and the fwnode graphs are compatible with
the OF graph, so the provided helpers can be used on all systems in theory.
Assumed that the system has valid fwnode graphs established before the
drm bridge driver is probed, and there is a fwnode assigned to the instance
of specific drm bridge driver.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_bridge.c | 72 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 16 ++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 28abe9aa99ca..ffc6162e2517 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1368,6 +1368,78 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
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
+ * Return:
+ * A reference to the drm_bridge if found, return NULL otherwise.
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
+ * that there has valid fwnode graph established.
+ *
+ * Return:
+ * A reference to the drm_bridge if found.
+ * %NULL if not found or the next bridge is not finish probe yet.
+ * A negative error code otherwise.
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
index 3606e1a7f965..d4c95afdd662 100644
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


