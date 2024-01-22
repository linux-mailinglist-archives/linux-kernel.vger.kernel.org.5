Return-Path: <linux-kernel+bounces-33703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE11836D79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5630B1F247E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25CA74E01;
	Mon, 22 Jan 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IfhvQlpG"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D80745EB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941167; cv=none; b=SsDHXjzFCourhIgwYVUdMkp3lkMv8/obJ6GuaV+hEO7R+30O1sLnC49FpcvqdmvBMbJVgeKIJVAp1ohj24+xIZz+ijc1TLqycc/mCnGiZcPzelQ9E6DQaLxTnOKt+4FpjmWgeog+YClH5puJ+RQwt/O+CgXkimoBnRwzsnD9VFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941167; c=relaxed/simple;
	bh=daoJsQAfP2xBV0kNNJW/Stmycgsu9aQruTbKytRGKp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tq9O4RKCn65p6k/XXmKzbLO/nVYNhVGYNHFpL+Jcgz0gVDxk9vG8sjgvw5EIoooqkXIHpkPib4CN5sdrmTuZM+MUvjoHC7v8w+5/B4QMfGok8gnr6Bg67vebaMFimLCpOl/OWv0IEq2lFihW4x/ZZJLFfCRdrsQIblR5cFffWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IfhvQlpG; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705941163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SaW0Gpay7iBfH7QtKRfcxFikX4DDF/x/sLLBI1Dwvao=;
	b=IfhvQlpGNlQH5yBLfh+N0DpfnsOJwHsPBE+HPFPkGI36lhsRVKljNc2gz732ufGYS1a8N/
	Cp1np5uq5zTMjfcXhxUR5Q8HOnYcgFSem8OOOG6jd0ad3tj35dzAL+Lrj1rEARoUqnLRPB
	dcCzHGrWbN+29ww2QrD4poINOgtdrAI=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: David Airlie <airlied@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 5/5] drm-bridge: display-connector: Switch to use fwnode API
Date: Tue, 23 Jan 2024 00:32:20 +0800
Message-Id: <20240122163220.110788-6-sui.jingfeng@linux.dev>
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

From: Sui Jingfeng <suijingfeng@loongson.cn>

Because API has wider coverage, it can be used on non-DT systems as well.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/bridge/display-connector.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index eb7e194e7735..2c3e54a458e8 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -243,8 +243,8 @@ static int display_connector_probe(struct platform_device *pdev)
 	case DRM_MODE_CONNECTOR_DVII: {
 		bool analog, digital;
 
-		analog = of_property_read_bool(pdev->dev.of_node, "analog");
-		digital = of_property_read_bool(pdev->dev.of_node, "digital");
+		analog = fwnode_property_present(pdev->dev.fwnode, "analog");
+		digital = fwnode_property_present(pdev->dev.fwnode, "digital");
 		if (analog && !digital) {
 			conn->bridge.type = DRM_MODE_CONNECTOR_DVIA;
 		} else if (!analog && digital) {
@@ -261,8 +261,8 @@ static int display_connector_probe(struct platform_device *pdev)
 	case DRM_MODE_CONNECTOR_HDMIA: {
 		const char *hdmi_type;
 
-		ret = of_property_read_string(pdev->dev.of_node, "type",
-					      &hdmi_type);
+		ret = fwnode_property_read_string(pdev->dev.fwnode, "type",
+						  &hdmi_type);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "HDMI connector with no type\n");
 			return -EINVAL;
@@ -292,7 +292,7 @@ static int display_connector_probe(struct platform_device *pdev)
 	conn->bridge.interlace_allowed = true;
 
 	/* Get the optional connector label. */
-	of_property_read_string(pdev->dev.of_node, "label", &label);
+	fwnode_property_read_string(pdev->dev.fwnode, "label", &label);
 
 	/*
 	 * Get the HPD GPIO for DVI, HDMI and DP connectors. If the GPIO can provide
@@ -330,12 +330,13 @@ static int display_connector_probe(struct platform_device *pdev)
 	if (type == DRM_MODE_CONNECTOR_DVII ||
 	    type == DRM_MODE_CONNECTOR_HDMIA ||
 	    type == DRM_MODE_CONNECTOR_VGA) {
-		struct device_node *phandle;
+		struct fwnode_handle *fwnode;
 
-		phandle = of_parse_phandle(pdev->dev.of_node, "ddc-i2c-bus", 0);
-		if (phandle) {
-			conn->bridge.ddc = of_get_i2c_adapter_by_node(phandle);
-			of_node_put(phandle);
+		fwnode = fwnode_find_reference(pdev->dev.fwnode, "ddc-i2c-bus", 0);
+		if (!IS_ERR_OR_NULL(fwnode)) {
+			dev_info(&pdev->dev, "has I2C bus property\n");
+			conn->bridge.ddc = i2c_get_adapter_by_fwnode(fwnode);
+			fwnode_handle_put(fwnode);
 			if (!conn->bridge.ddc)
 				return -EPROBE_DEFER;
 		} else {
@@ -380,6 +381,7 @@ static int display_connector_probe(struct platform_device *pdev)
 
 	conn->bridge.funcs = &display_connector_bridge_funcs;
 	conn->bridge.of_node = pdev->dev.of_node;
+	conn->bridge.fwnode = pdev->dev.fwnode;
 
 	if (conn->bridge.ddc)
 		conn->bridge.ops |= DRM_BRIDGE_OP_EDID
-- 
2.25.1


