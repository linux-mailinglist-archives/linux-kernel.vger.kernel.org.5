Return-Path: <linux-kernel+bounces-153907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A7B8AD4C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F41D281CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244DC1553A3;
	Mon, 22 Apr 2024 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qSraONwL"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA18155395
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813579; cv=none; b=GcI3Sf7+Y7TBJrosD1042P4BPbDvc9z6qDG23nSR3IK01UuGajkCjhhcgN0wtoAj4LQfDpSsDI6byrPfmWsFvtNpfIt3oRV8iBC2iKtyC1wudGMlHs4aGfAYBC9JOneSplo0jXH01HqBtYoV+1OriSlzM4sDK/tRiofvodAzSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813579; c=relaxed/simple;
	bh=vI2s5Y19GW65v9houQ7QfCCe1zrcqK8CrjdGxI7ePgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGep3r6ICPDG2mqUreUzRqJJDzfUvk478MVio8Cbbkdd8qlbRaGf/GhvC5Q8ELMUFxfPrEOntoFi2vgRKm3eQvJp/Vxjd1mVPNEQqCYJTq9ku1NbjVk+XC6cPfRDJKmhB3QzBbR7nviji+etEEwQ5sQ0/eez2GCvhE/+n6OuOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qSraONwL; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713813576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDnO3d01ba8EKeTRxUnybEgU0P9s3FIBjxuth5gpvfI=;
	b=qSraONwLgI3jpDo2bLo4jIdqpNxFtitYRxfs3hBAgtPZa6He9cCjPBxhupTAfY3i7bh52z
	fMFdtoGleN4jg7SSkerocc9h7ThE56E7QFmHPmCvDdH0l+hlLQiobk95GAXrv0yjUVHTPg
	uZkLLilua+PVEZ2M/K1md+ubOVEOaF8=
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
Subject: [PATCH v4 4/9] drm-bridge: display-connector: Use fwnode API to acquire device properties
Date: Tue, 23 Apr 2024 03:18:58 +0800
Message-Id: <20240422191903.255642-5-sui.jingfeng@linux.dev>
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

Make this driver less DT-dependent by using the fwnode helper functions,
should be no functional changes for DT based systems. Do the necessary
works before it can be truely DT-independent, this patch do no harms even
though there is no user yet.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/display-connector.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index ab8e00baf3f1..d80cb7bc59e6 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -204,6 +204,7 @@ static int display_connector_get_supply(struct platform_device *pdev,
 
 static int display_connector_probe(struct platform_device *pdev)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
 	struct display_connector *conn;
 	unsigned int type;
 	const char *label = NULL;
@@ -215,15 +216,15 @@ static int display_connector_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, conn);
 
-	type = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	type = (uintptr_t)device_get_match_data(&pdev->dev);
 
 	/* Get the exact connector type. */
 	switch (type) {
 	case DRM_MODE_CONNECTOR_DVII: {
 		bool analog, digital;
 
-		analog = of_property_read_bool(pdev->dev.of_node, "analog");
-		digital = of_property_read_bool(pdev->dev.of_node, "digital");
+		analog = fwnode_property_present(fwnode, "analog");
+		digital = fwnode_property_present(fwnode, "digital");
 		if (analog && !digital) {
 			conn->bridge.type = DRM_MODE_CONNECTOR_DVIA;
 		} else if (!analog && digital) {
@@ -240,8 +241,7 @@ static int display_connector_probe(struct platform_device *pdev)
 	case DRM_MODE_CONNECTOR_HDMIA: {
 		const char *hdmi_type;
 
-		ret = of_property_read_string(pdev->dev.of_node, "type",
-					      &hdmi_type);
+		ret = fwnode_property_read_string(fwnode, "type", &hdmi_type);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "HDMI connector with no type\n");
 			return -EINVAL;
@@ -271,7 +271,7 @@ static int display_connector_probe(struct platform_device *pdev)
 	conn->bridge.interlace_allowed = true;
 
 	/* Get the optional connector label. */
-	of_property_read_string(pdev->dev.of_node, "label", &label);
+	fwnode_property_read_string(fwnode, "label", &label);
 
 	/*
 	 * Get the HPD GPIO for DVI, HDMI and DP connectors. If the GPIO can provide
@@ -309,12 +309,12 @@ static int display_connector_probe(struct platform_device *pdev)
 	if (type == DRM_MODE_CONNECTOR_DVII ||
 	    type == DRM_MODE_CONNECTOR_HDMIA ||
 	    type == DRM_MODE_CONNECTOR_VGA) {
-		struct device_node *phandle;
+		struct fwnode_handle *phandle;
 
-		phandle = of_parse_phandle(pdev->dev.of_node, "ddc-i2c-bus", 0);
-		if (phandle) {
-			conn->bridge.ddc = of_get_i2c_adapter_by_node(phandle);
-			of_node_put(phandle);
+		phandle = fwnode_find_reference(fwnode, "ddc-i2c-bus", 0);
+		if (!IS_ERR_OR_NULL(phandle)) {
+			conn->bridge.ddc = i2c_get_adapter_by_fwnode(phandle);
+			fwnode_handle_put(phandle);
 			if (!conn->bridge.ddc)
 				return -EPROBE_DEFER;
 		} else {
@@ -358,7 +358,7 @@ static int display_connector_probe(struct platform_device *pdev)
 	}
 
 	conn->bridge.funcs = &display_connector_bridge_funcs;
-	conn->bridge.of_node = pdev->dev.of_node;
+	drm_bridge_set_node(&conn->bridge, fwnode);
 
 	if (conn->bridge.ddc)
 		conn->bridge.ops |= DRM_BRIDGE_OP_EDID
-- 
2.34.1


