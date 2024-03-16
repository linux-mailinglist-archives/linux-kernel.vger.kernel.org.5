Return-Path: <linux-kernel+bounces-105257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645F87DB21
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA54CB21C89
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57541C68A;
	Sat, 16 Mar 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GSq4pmUO"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386901C2B3
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710611076; cv=none; b=qoOqniQ1q2Jwtc6DEA3STwHksm4USG0DUfp2OSEU0hZ/sig0dhji5PLSTcj52xH1259M5T+9ilGAMXuaUToZGs/Q7TRXcub6D56+bzMINEixEZZCproP/PsjSRV+ENJfbe6h3OS4iXQE9ze7ddxcUslIYCnV6DTpbclkLmW/CHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710611076; c=relaxed/simple;
	bh=17I7+xN31aGL47sdNNPTOAveYbwP0lz2c41kUbuC0HU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fg5w4y2HsVyh60cbS5yBxN2t0PRU2RHENT72zbE7ri6j4n+ghwVsCr+Y+7bS4gvI4Qt4WS5wXE5FOG1dm7b8B59tHB8IjDH2Pi9nmVUEE5VypEBEWhMhdNkjvpAlyzCWcm6XhK9WbFPkD26GVtcGgv6+GufzrQiBA8HPFc9aH2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GSq4pmUO; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710611072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B+NevW13746f0XIq/LdjwmE8okigxhPH+0/l69++YC0=;
	b=GSq4pmUObr7TsiOVSFshbPBrAOuZ6xtZP89u7O+sPuDaeg9rTtYA6A22GbM76f9ipmyNOl
	L77npPGKQEoEYFtyMbBD4nwVCTDgWzBUmZdH14koanjCdyihf+ppegWyZfwL6GWz4gG3ix
	wHpjTiCiX1L8z+ZbVr32lAo7bph0X3M=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Phong LE <ple@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
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
Subject: [PATCH] drm/bridge: it66121: Remove a duplicated invoke of of_device_is_available()
Date: Sun, 17 Mar 2024 01:44:19 +0800
Message-Id: <20240316174419.1170460-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The calling of of_device_is_available() in it66121_probe() is duplicated,
as the of_graph_get_remote_node() has already do the check for us. There
is no need to call it again, thus delete the later one.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 052884058644..925e42f46cd8 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1540,12 +1540,6 @@ static int it66121_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	if (!of_device_is_available(ep)) {
-		of_node_put(ep);
-		dev_err(ctx->dev, "The remote device is disabled\n");
-		return -ENODEV;
-	}
-
 	ctx->next_bridge = of_drm_find_bridge(ep);
 	of_node_put(ep);
 	if (!ctx->next_bridge) {
-- 
2.34.1


