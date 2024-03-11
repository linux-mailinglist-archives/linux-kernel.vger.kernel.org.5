Return-Path: <linux-kernel+bounces-98565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10090877C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28FC1F21196
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AD2232A;
	Mon, 11 Mar 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o7SpAZM2"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61521115
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147511; cv=none; b=WELiWew3jZ7n1pLa447z5kPzxKm/DBExsvYtpP7Jf0VHiYhgMe7R86u4zYwmHVmt2cUjYEQJjoKrswoAj26QU4K2/lEgpQFgr/mMeVDVCjq0ODuNhWZsU5cdV/kacD2Fwq/xHyAatijUYtKcunfmy394lWSxiiFJ/aQyHyy4wGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147511; c=relaxed/simple;
	bh=vq9XBTBjoQZnocYnQAqv25NSvH4VWo7Rsys2n+nDlxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXsdyPPN2N4lYX6bx8jkiStBtydpY0L35gVj9Qz/M0Ti7L/W1NcrOajRzQMN8fP7Ju2mdmw7H/4AdS7jHlpGULiMrM6Z+KieiJ30mwz5XJmt0W0m0ZxzPMuknV7+JoZtbhQAuBt79Y21aiKgLIo7jCgPG+TjOGIJZ2UlvJEOJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o7SpAZM2; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710147507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aep+0Bx5dDl+omojFo37hiW07MeWApSc10wBdc6QHoM=;
	b=o7SpAZM20vIWA1feEu6Qmid7aZHNi34FMD0eBo819WVjEfZDH/7z2Ki4n50utYq2lw4Bw4
	JV0JLLp48M/TehOzS2WavoDaWfiba0/hR8DhKnL/D4fBdHWbr3sggprk2UWWBapGe1UanY
	6moYpT4qpUqeOh6JOqSTAh//Ko7PJSk=
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
Subject: [PATCH v3 3/5] drm-bridge: display-connector: Use fwnode API to acquire device properties
Date: Mon, 11 Mar 2024 16:56:57 +0800
Message-Id: <20240311085659.244043-4-sui.jingfeng@linux.dev>
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

Make this driver less DT-dependent by using the fwnode helper function,
should be no functional changes for DT based systems. Do the necessary
works before it can be truely subsystem independent, even though there
is no user yet, this still do no harms.

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


