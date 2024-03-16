Return-Path: <linux-kernel+bounces-105252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C687DB15
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08731B21EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0E91C694;
	Sat, 16 Mar 2024 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zy/cUnpk"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574601C684
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710610100; cv=none; b=rTc2/wi4LbfQ1OZXq/CCFQtqT7VguEr/aNh43u/HTQSZPElHe0/LgxDj/dsoZTdxQZUzZ2TjrSXsGMSUJUllc4gsZKCE5m29KCAuD9cdLAW7RR8E7MRgRsQJQpHxYXEKztrYB3Sbdqei79Qoy/r5HEc+Gbdi05efwjMTUFa8E/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710610100; c=relaxed/simple;
	bh=3cGDUBnZFBGebjNEphHzWwlKl8McZ21twUdcBFIdMxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RpcMIwj0jZ9AuR/L+l/VGnQ6F0VKe7lgKXcJhiBB/3NW3jg8H5QxFa17xUILR9U8xqFV9+TMm2LDQaSq4cipED0oNkFys/9WI/0zQ0gsZQlcjIDBE/j1dKBYF1L+QDQNMG9Rc8NQzqldjJ6eLK/PrHBU9sax+eJbIZJy19XO7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zy/cUnpk; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710610096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ceT0A5OpKZsmi5o1ZFkhltR2cGi15QKceRNYBtO/4yU=;
	b=Zy/cUnpk+3+aY0gUZps4ug+ZdXWwzfkIX6erIJnCile2KVmsc70ZSh2DH8hc+tudPd3s4m
	1usqtT6xHolvv2r4Gc4vWMpH7Kyk8LvlmYjNGL+x4Jn6D25Tu2PLhgoGa5XpHlEaQhc0V9
	ufG8jDPFoJkT4ie6NTooiG4gooiP71k=
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
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm: bridge: thc63lvd1024: Switch to use of_graph_get_remote_node()
Date: Sun, 17 Mar 2024 01:28:00 +0800
Message-Id: <20240316172800.1168390-1-sui.jingfeng@linux.dev>
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
 drivers/gpu/drm/bridge/thc63lvd1024.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
index d4c1a601bbb5..5f99f9724081 100644
--- a/drivers/gpu/drm/bridge/thc63lvd1024.c
+++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
@@ -123,28 +123,10 @@ static int thc63_parse_dt(struct thc63_dev *thc63)
 	struct device_node *endpoint;
 	struct device_node *remote;
 
-	endpoint = of_graph_get_endpoint_by_regs(thc63->dev->of_node,
-						 THC63_RGB_OUT0, -1);
-	if (!endpoint) {
-		dev_err(thc63->dev, "Missing endpoint in port@%u\n",
-			THC63_RGB_OUT0);
-		return -ENODEV;
-	}
-
-	remote = of_graph_get_remote_port_parent(endpoint);
-	of_node_put(endpoint);
-	if (!remote) {
-		dev_err(thc63->dev, "Endpoint in port@%u unconnected\n",
-			THC63_RGB_OUT0);
+	remote = of_graph_get_remote_node(thc63->dev->of_node,
+					  THC63_RGB_OUT0, -1);
+	if (!remote)
 		return -ENODEV;
-	}
-
-	if (!of_device_is_available(remote)) {
-		dev_err(thc63->dev, "port@%u remote endpoint is disabled\n",
-			THC63_RGB_OUT0);
-		of_node_put(remote);
-		return -ENODEV;
-	}
 
 	thc63->next = of_drm_find_bridge(remote);
 	of_node_put(remote);
-- 
2.34.1


