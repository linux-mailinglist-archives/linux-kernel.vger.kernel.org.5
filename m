Return-Path: <linux-kernel+bounces-95930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F943875512
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63CC6B22F75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369A3130AF1;
	Thu,  7 Mar 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h2AcDTLW"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFA412F5BD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832238; cv=none; b=Hcagtt9MkVtmO6xQloT5ZoTqh2Lp5hYTPNs4jvqusKe28y4uJ1rOScEeykXQ8KILnzdtG7dxGGk74ej4M4ZIl3qQY/ZTH2mPSi1HaDris5UNnpzZBQLotlHW8kHQ6yX5uFH2VmXwQVPX0emcEI6GnxkS7w2KmhrY+SzsT11OsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832238; c=relaxed/simple;
	bh=qhcF1UELVGRHGCtWnmowVM0gXYyiG/L4Do76LSnKvLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TP9O/F1H8Sq/d86uyTWb0KooCRfK4trTipzdywIno6AwovT4wuO+ZMpx91IyofDUYfKNUFhHdwnN83KpeVo7S1lc8/E4CSkJUSkkHS4zRpxC5uBiApFxkEnflhyfA8qnKvglCd5ldtX0bDswyWIr7Q/BpdH0ZqpwxW7jCsaLBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h2AcDTLW; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709832234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFPpWk/ghK4bMODKXJQzeUIUy7/KrcEBzJBz6IayowQ=;
	b=h2AcDTLWaeMcmm2GIk2af83G2gqEekuNeXQt+at56K4e0UBrszGDRaFhFLvtDBL2FLqH/t
	j2zZSbGYQ8axn0d2fNuueh4rxAeKlFsoWxYpFxlfx2X8VcbRF9NBmN1Dj5PviDt1IXWAs8
	J6wc4UQ7ACnzsOFDZZV1crljqIdOJX4=
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
Subject: [PATCH v2 1/4] drm/bridge: Add fwnode based helpers to get the next bridge
Date: Fri,  8 Mar 2024 01:23:31 +0800
Message-Id: <20240307172334.1753343-2-sui.jingfeng@linux.dev>
In-Reply-To: <20240307172334.1753343-1-sui.jingfeng@linux.dev>
References: <20240307172334.1753343-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the various drm bridge drivers relay on OF infrastructures to
works very well. Yet there are platforms and/or don not has OF support.
Such as virtual display drivers, USB display apapters and ACPI based
systems etc. Add fwnode based helpers to fill the niche, this may allows
part of the drm display bridge drivers to work across systems. As the
fwnode based API has wider coverage than DT, it can be used on all systems
in theory. Assumed that the system has valid fwnode graphs established
before drm bridge driver is probed, the fwnode graphs are compatible with
the OF graph.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_bridge.c | 68 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 16 +++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 521a71c61b16..1b2d3b89a61d 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1348,6 +1348,74 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 EXPORT_SYMBOL(of_drm_find_bridge);
 #endif
 
+/**
+ * drm_bridge_find_by_fwnode - Find the bridge corresponding to the associated fwnode
+ *
+ * @fwnode: fwnode for which to find the matching drm_bridge
+ *
+ * This function looks up a drm_bridge based on its associated fwnode.
+ *
+ * RETURNS:
+ * A reference to the drm_bridge if found, otherwise return NULL.
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
+EXPORT_SYMBOL(drm_bridge_find_by_fwnode);
+
+/**
+ * drm_bridge_find_next_bridge_by_fwnode - get the next bridge by fwnode
+ * @fwnode: fwnode pointer to the current bridge.
+ * @port: identifier of the port node of the next bridge is connected.
+ *
+ * This function find the next bridge at the current bridge node, assumed
+ * that there has valid fwnode graph established.
+ *
+ * RETURNS:
+ * A reference to the drm_bridge if found, %NULL if not found.
+ * Otherwise return a negative error code.
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
+EXPORT_SYMBOL(drm_bridge_find_next_bridge_by_fwnode);
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


