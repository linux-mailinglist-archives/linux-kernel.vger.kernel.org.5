Return-Path: <linux-kernel+bounces-167924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E48BB11F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE4C1C212F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D015688B;
	Fri,  3 May 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qE76TYkP"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5BE157A6F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754528; cv=none; b=FoniozG5qk6v759y8n/gnaS6iSKwkoFKrVwpXwGkWm/GnzvNmiif4rfGJvuaSjbZ5BByCp6v7KKkpaftNImG2foPkz4iUYKlUD9aMBnUZR581WV6wHCF23OheUJHxZwY69FtFgdFIjKwr/Hae4j2G2wWutvliIEid+y9nTJEOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754528; c=relaxed/simple;
	bh=+eGA1cF+XAUjkSFaGVgBosoqGaUoncSVeVGoQcbc6U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Isp0fQ4B0/RVqoZ63cKLlmfn7C8irjgoaryKtt7XYteRbS0W2IKT7eGFQAUHchhHHRqF6/3IyYpYGjphdU6FJsmDNEAnhAvZjvAmQYa6sVlZdByGbH6oyksE5kn15+fMYqLBjCu/vLPXPKYvwo/Dp4qREXN0m9m3BM8jbl7IEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qE76TYkP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714754525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGxG50yC0CK36/qDO6i3sCZYl6lVuSyFdQFoLVbb7hE=;
	b=qE76TYkPHJUNZX0+NzadigGzNT+dJbx7TLDCism8XE63avWp7zQ2Ll64tuUAT0e809Zxvk
	w6GIX3DQ5ltVk2kn6xhbqjeyZQMLNu49hrHDyG571z0mA2Z6OkE+5R7GZLxwRg/ECB0u79
	vG+vltyYLhipnwHrO6T6B1xvdvVi0xI=
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
Subject: [PATCH v5 10/10] drm/bridge: anx7688: Switch to use drm_bridge_set_node() helper
Date: Sat,  4 May 2024 00:41:06 +0800
Message-Id: <20240503164106.1172650-11-sui.jingfeng@linux.dev>
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

Switch to use the freshly created drm_bridge_set_node() helper, because
fwnode APIs can be used to abstract DT dependent APIs away. As the fwnode
APIs has wider coverage than DT counterpart, driver don't have to bear
the burden of "OF dependent", let the core take the resposibility. No
functional changes.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/cros-ec-anx7688.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cros-ec-anx7688.c b/drivers/gpu/drm/bridge/cros-ec-anx7688.c
index c8abd9920fee..30b27b808e02 100644
--- a/drivers/gpu/drm/bridge/cros-ec-anx7688.c
+++ b/drivers/gpu/drm/bridge/cros-ec-anx7688.c
@@ -98,6 +98,7 @@ static const struct drm_bridge_funcs cros_ec_anx7688_bridge_funcs = {
 static int cros_ec_anx7688_bridge_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct cros_ec_anx7688 *anx7688;
 	u16 vendor, device, fw_version;
 	u8 buffer[4];
@@ -143,7 +144,7 @@ static int cros_ec_anx7688_bridge_probe(struct i2c_client *client)
 	fw_version = (u16)buffer[0] << 8 | buffer[1];
 	dev_info(dev, "ANX7688 firmware version 0x%04x\n", fw_version);
 
-	anx7688->bridge.of_node = dev->of_node;
+	drm_bridge_set_node(&anx7688->bridge, fwnode);
 
 	/* FW version >= 0.85 supports bandwidth/lane count registers */
 	if (fw_version >= ANX7688_MINIMUM_FW_VERSION)
-- 
2.34.1


