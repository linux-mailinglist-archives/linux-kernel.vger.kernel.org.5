Return-Path: <linux-kernel+bounces-105239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D787DAF5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A166282371
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60231BDCD;
	Sat, 16 Mar 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oiRVoymT"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CD1BC41
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710608742; cv=none; b=BkqoipURATdZiNOJwL6JXEcwaVlWaiXKx7/z8Xl2kj4vqX18sDeAzjhOHrJ4l6N8dAEl8djd9/lNJDhwgeuzZ68A6WyJgFeQd00RE1OXrYyR1vMKHVHXZNypVeaLUcvNSLDluc45rEYkteQWaqqn0MShq0T8OWhaDNOYOmzzxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710608742; c=relaxed/simple;
	bh=DQRBaBsKmt6Xv5cMCll9mcDgeA1I1nTM7iEy+iYKZ6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HMKcDL8fOQhtnZd68DH92kEJzzRIAma9BUFHhkfGCro23orDydPlkTO8c6y7bA8w+Pg+Mlh3nDzlHWyUGSwR/CYE/B9s4PwunsTKRYC4HoI4wXH5toyWTIioMA9bTauflVDux6nFg9AChdjXnitwNHeH/b2Oxj98BlssG+E+AQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oiRVoymT; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710608738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zL4myksVicIour6XUMzWlw8VhqJACYKy3DZPBN3+yT8=;
	b=oiRVoymTTXBAKlQAorVIVE6dkSEUWzfJJuFLJJkodKHUmpixANv/zxf/QbaufNMN8OCAkz
	sYqmD7PazJLMUOalwXCJwT+fMIbl1XnQBGnkKkolkrYNwWRmeKcFPNYQBVIH1ur2L2vLqf
	aPCs8ybVKSp79Nvu79iqVoynEG6lNiM=
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
	Jani Nikula <jani.nikula@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Sandor Yu <Sandor.yu@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm: bridge: dw_hdmi: Switch to of_graph_get_remote_node()
Date: Sun, 17 Mar 2024 01:05:13 +0800
Message-Id: <20240316170513.1159724-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To reduce boilerplate, use of_graph_get_remote_node() helper instead of
the hand-rolling code.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 31 +++--------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index cceb5aab6c83..9f2bc932c371 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3291,40 +3291,17 @@ static void dw_hdmi_init_hw(struct dw_hdmi *hdmi)
 
 static int dw_hdmi_parse_dt(struct dw_hdmi *hdmi)
 {
-	struct device_node *endpoint;
 	struct device_node *remote;
 
 	if (!hdmi->plat_data->output_port)
 		return 0;
 
-	endpoint = of_graph_get_endpoint_by_regs(hdmi->dev->of_node,
-						 hdmi->plat_data->output_port,
-						 -1);
-	if (!endpoint) {
-		/*
-		 * On platforms whose bindings don't make the output port
-		 * mandatory (such as Rockchip) the plat_data->output_port
-		 * field isn't set, so it's safe to make this a fatal error.
-		 */
-		dev_err(hdmi->dev, "Missing endpoint in port@%u\n",
-			hdmi->plat_data->output_port);
-		return -ENODEV;
-	}
 
-	remote = of_graph_get_remote_port_parent(endpoint);
-	of_node_put(endpoint);
-	if (!remote) {
-		dev_err(hdmi->dev, "Endpoint in port@%u unconnected\n",
-			hdmi->plat_data->output_port);
+	remote = of_graph_get_remote_node(hdmi->dev->of_node,
+					  hdmi->plat_data->output_port,
+					  -1);
+	if (!remote)
 		return -ENODEV;
-	}
-
-	if (!of_device_is_available(remote)) {
-		dev_err(hdmi->dev, "port@%u remote device is disabled\n",
-			hdmi->plat_data->output_port);
-		of_node_put(remote);
-		return -ENODEV;
-	}
 
 	hdmi->next_bridge = of_drm_find_bridge(remote);
 	of_node_put(remote);
-- 
2.34.1


