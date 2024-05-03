Return-Path: <linux-kernel+bounces-167915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246D8BB109
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75C51F224B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8D4156876;
	Fri,  3 May 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J8uOfXc+"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF444156891
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754487; cv=none; b=gjktSau97oy5FqTzXaZixrsyi8KrCGdLebBE8//23SyoEdiBKZYfcz+MR2OWGHVpVaaSthlg4TYSgmpBWqOVSmIyLg0mcFjZCnEFh/VCKYJjBF9v5MKPSeHIgvPRLs2soXaVwN7/45CmUg0TlGdPJDeVQ8JRpRQiHotKBVUHJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754487; c=relaxed/simple;
	bh=R7Zn0HW+ECEvfFslvMJ4McjMW5fFm9uyNNg0DIaeK4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QY41g26cz7u3anzm5fXEmlHWApilVoEpqZg+VE/gm8fLaUd8SvAwxjih4gIWmZkIedeUKGtNkWH4hw5fDPPFMfeTj3pKo8p3+EshrC4scYOvdoSFhZDV3YDXDpi0QCmQ9eHC09w8XcBXeY821LoL31nlxqLwAxoEQhHvY4DeEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J8uOfXc+; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714754484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dZRACv1mGtltLnFfXv8cRlXiLzMJI2QNtXc82HhDoA=;
	b=J8uOfXc+V1d/2OHNoBJh0QiVOOgt9GA9OIEd1aUZ5VWGSJmCXprAyi9ir3LXP/5Yl94Hlk
	n7IHseMWoqYiOsRCm5b3N5pVN30mxkb4Gr5SA0mQsH1OvrhaH5KqRSm5Kx5dSDjas0iWDR
	y/ItN03ne4HYBH8tHUrfTJkUSwmldKY=
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
Subject: [PATCH v5 01/10] drm/bridge: Allow using fwnode APIs to get the next bridge
Date: Sat,  4 May 2024 00:40:57 +0800
Message-Id: <20240503164106.1172650-2-sui.jingfeng@linux.dev>
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

The various display bridge drivers rely on 'OF' infrastructures to
works very well, yet there are some platforms and/or devices lack of
'OF' support. Such as virtual display drivers, USB display apapters
and ACPI based systems etc.

Add fwnode based helpers to fill the niche, this allows part of display
bridge drivers to work across systems. As the fwnode APIs has wider
coverage than DT counterpart, and fwnode graphs are compatible with
OF graphs. So the newly created helpers can be used on all systems
in theory, assumed that there has valid OF/fwnode graphs established.

Note, the involved drm bridge instance should also has the fwnode
assigned, so that the user of it could find it via the fwnode handle.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_bridge.c | 74 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     |  8 ++++
 2 files changed, 82 insertions(+)

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
index 4baca0d9107b..a1bb19425761 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -721,6 +721,8 @@ struct drm_bridge {
 	struct list_head chain_node;
 	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
+	/** @fwnode: fwnode pointer to the bridge */
+	struct fwnode_handle *fwnode;
 	/** @list: to keep track of all added bridges */
 	struct list_head list;
 	/**
@@ -797,6 +799,12 @@ static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
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


