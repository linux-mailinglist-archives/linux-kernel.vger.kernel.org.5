Return-Path: <linux-kernel+bounces-33697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378FC836D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16AF28C6D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F56EB52;
	Mon, 22 Jan 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TfmmHLC0"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CEE56466
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941154; cv=none; b=VFLqFiOO1wddI2jUWPGTW5Lq38MDC6NU/QZBbPDGDuLkFKkRuTFUo+z2RId4/pnQcfcNQwYItZMfpApQHCCu065SHHQ9UvQfVXmcSWxc79JehW93boyyjTLV+Y0vF2pJ03xD7Si4qNfpeCLMHWGcDIBZRhPwvfQ2HU1NsjN9VYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941154; c=relaxed/simple;
	bh=DwdD6zYzvMmBjpFbhFoxVjCRnvL6HtMflRTaIw5v7Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AodsWgs3hsCBmNK/Exn8PGdc8nn7dE7n+YKUcZZ96KwsBNDerBYRug8tF4u/VzA7d/qOpNqlEQX88JM/d6CAO7eyz7oPtV90Nkydx8zY/A1erTTu4jFzShuZQRrb/nXJDvcvJk0N9QNZLN92fMZ4L6sfKWHH3kUp6mhHDLUmUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TfmmHLC0; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705941150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZyqSCinvSiL4fDcqtQAts8Vz4wSQZ3zHH00t6lYeGc=;
	b=TfmmHLC0CAWOqzvzLqf1L/MTDspqvJzrDKRUwwMzj7inwa16XjnR2Tc2kGpy8/XOtAxC5y
	FZ/z5XqynfDN2uwB1h9t1103vC4umTIdhWDG2mMkQerFy1k2CqdwtFg5La3Azbyq64MW9l
	5EUs+pR2o4Mq+U2jhmcAvoamKOVYCRY=
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
Subject: [PATCH 1/5] drm/bridge: Add drm_bridge_find_by_fwnode() helper
Date: Tue, 23 Jan 2024 00:32:16 +0800
Message-Id: <20240122163220.110788-2-sui.jingfeng@linux.dev>
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

Because ACPI based systems only has the fwnode associated, the of_node
member of struct device is NULL. To order to move things forward, we add
drm_bridge_find_by_fwnode() to extend the support.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/drm_bridge.c | 33 +++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index cee3188adf3d..ffd969adc2fb 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1347,6 +1347,39 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
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
+ * A reference to the drm_bridge control structure if found, NULL on failure.
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
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
 MODULE_DESCRIPTION("DRM bridge infrastructure");
 MODULE_LICENSE("GPL and additional rights");
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index e39da5807ba7..fe3d5f4bf37f 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -720,6 +720,8 @@ struct drm_bridge {
 	struct list_head chain_node;
 	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
+	/** @fwnode: associated fwnode supplied by platform firmware */
+	struct fwnode_handle *fwnode;
 	/** @list: to keep track of all added bridges */
 	struct list_head list;
 	/**
@@ -796,6 +798,8 @@ static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 }
 #endif
 
+struct drm_bridge *drm_bridge_find_by_fwnode(struct fwnode_handle *fwnode);
+
 /**
  * drm_bridge_get_next_bridge() - Get the next bridge in the chain
  * @bridge: bridge object
-- 
2.25.1


