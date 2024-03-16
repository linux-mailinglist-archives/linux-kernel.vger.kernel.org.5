Return-Path: <linux-kernel+bounces-105221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E0B87DAAE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741D41F21217
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E41BC26;
	Sat, 16 Mar 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQAfczqn"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6C1B95B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710605155; cv=none; b=q2DJZxPs8tcDGnTeZtg0CXhRUvLgrjbnFD2Emn43hv/Zyxv+BIBfTw8dDvhcbYrcOxIYevtF56pb7QGqfOHmMpaCHA6dCMRIQCZ/wFxzUifQa2zWU9iHwZmu1MtX4Z4s6KXmcFTyZmZcTvaEzH6qWTL7G/rXts7GoUM/o5rH0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710605155; c=relaxed/simple;
	bh=/svi0NJ7KD08TdC4uzCf3af98Bb0v1OrST7PIaxoQ0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QXAdGCtBcR0lZc0Ym0zqPkQTCAB4lMnUFbNTlGACPw384Qgx3spZdHsjsvshzeKXiEg/w/0QBFF3GYM9qBYaOmoWIvGJ9y33qSSh/cU11P3GDXgWrd9cOztJEmfvqeQcHe7hCygKEq8fTe+5vNUOHGBPNnl5QlOZUTFoFb8wzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQAfczqn; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710605151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Mq/6HxdR67XTNnr1mfKX0S56ljquTrLxh/6FJkkRZY=;
	b=PQAfczqnBDSKaqj6dXm4XielO0qFiCvfWtyR/Mz4cEKzUA9ou5mIouLXmoJXG5GcukQgU3
	/SUE7e5CAo6H4NYazTk/e90kUKva0CttZke1+fh9MSX0kHBZ5ZilWnKwStzD9ckXjCeXTw
	vg7Br6bwub5vXAhREs1k7YtDBDGbkSA=
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
Subject: [PATCH] drm/bridge: ite66121: Register HPD interrupt handler only when 'client->irq > 0'
Date: Sun, 17 Mar 2024 00:05:36 +0800
Message-Id: <20240316160536.1051513-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If a specific design doesn't wire IT66121's interrupt signal output pin up
to the display controller side, then we should not register the interrupt
handler. Such a decision is valid usage, as we can fall back to polling
mode. So, don't make the assumption that a specific board always supports
HPD. Carry out a sanity check on 'client->irq' before using it, fall back
to polling mode if client->irq < 0 is true. Such a design increases the
overall flexibility.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 1c3433b5e366..052884058644 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1586,13 +1586,18 @@ static int it66121_probe(struct i2c_client *client)
 	ctx->bridge.funcs = &it66121_bridge_funcs;
 	ctx->bridge.of_node = dev->of_node;
 	ctx->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
-	ctx->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
-
-	ret = devm_request_threaded_irq(dev, client->irq, NULL,	it66121_irq_threaded_handler,
-					IRQF_ONESHOT, dev_name(dev), ctx);
-	if (ret < 0) {
-		dev_err(dev, "Failed to request irq %d:%d\n", client->irq, ret);
-		return ret;
+	ctx->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	if (client->irq > 0) {
+		ctx->bridge.ops |= DRM_BRIDGE_OP_HPD;
+
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						it66121_irq_threaded_handler,
+						IRQF_ONESHOT, dev_name(dev),
+						ctx);
+		if (ret < 0) {
+			dev_err(dev, "Failed to request irq %d:%d\n", client->irq, ret);
+			return ret;
+		}
 	}
 
 	it66121_audio_codec_init(ctx, dev);
-- 
2.34.1


