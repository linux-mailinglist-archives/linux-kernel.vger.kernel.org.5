Return-Path: <linux-kernel+bounces-33698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE10F836D70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12CC1C242A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5956EB72;
	Mon, 22 Jan 2024 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L7/FAapq"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE826EB5D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941157; cv=none; b=mvHA7HKPHif+EHhWTeNXLUXv9PJ0n4YIihqQgvlMY89Xjo3dRdrO2NT59O6n5hlSABmMcZkWfoSfG6xlA6g8OB9m/YkzKfaIUwZjrRqxRU6gPbD0gphkmC0mt6WAHctMiR8GiPCntBhV/AzT0/JHR4xLTQNIQA1cbJfHEd4eNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941157; c=relaxed/simple;
	bh=JhvObS4GQ8Qdgb5wl3GUWBFziCFrID5vp3TWqC6dgJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXYNSaunkumPAR++wEf6nPstdAb6gqfpC1gtUfAWAvOAEk1mxRFYU+UHWntH7SCb63fSRM1/IBOhN5F+Urn639FREdXW4bf5qtLOamVzdiBMMfQ+L8ychtkRg7nT6WMT0fYy8kmDPdl7L18EpiyYPXR8EK40m4jlUUWp5VWNnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L7/FAapq; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705941154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOQVFSKw3j/viuJ1r9uwPrf0VlEptyybu7p5hJGtU4I=;
	b=L7/FAapq5/GA78moIR9tbDqaLl+KwawdazCvL79VK9uJYNJjZeHurgVE3jowYQvTiIOyFV
	GSBgDlmh2QUmpkYssS3+2mBzDVU7Ns2GYjvfvVs9cAaa+EBtpknfHqgWfkkT9sBJFoXNEz
	wcaIH5I6UVRBIFL9gZo/ycf5uHSXYKw=
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
Subject: [PATCH 2/5] drm/bridge: simple-bridge: Extend match support for non-DT based systems
Date: Tue, 23 Jan 2024 00:32:17 +0800
Message-Id: <20240122163220.110788-3-sui.jingfeng@linux.dev>
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

Which is intended to be used on non-DT environment, where the simple-bridge
platform device is created by either the display controller driver side or
platform firmware subsystem. To avoid duplication and to keep consistent,
we choose to reuse the OF match tables. Because the potentional user may
not has a of_node attached, nor a ACPI match id. If this is the case,
a software node string property can be provide to fill the niche.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index cbe8e778d7c7..595f672745b9 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -166,6 +166,24 @@ static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
 	.disable	= simple_bridge_disable,
 };
 
+static const void *simple_bridge_get_match_data(const struct device *dev)
+{
+	const struct of_device_id *matches = dev->driver->of_match_table;
+
+	/* Try to get the match data by software node */
+	while (matches) {
+		if (!matches->compatible[0])
+			break;
+
+		if (device_is_compatible(dev, matches->compatible))
+			return matches->data;
+
+		matches++;
+	}
+
+	return NULL;
+}
+
 static int simple_bridge_probe(struct platform_device *pdev)
 {
 	struct simple_bridge *sbridge;
@@ -176,7 +194,10 @@ static int simple_bridge_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, sbridge);
 
-	sbridge->info = of_device_get_match_data(&pdev->dev);
+	if (pdev->dev.of_node)
+		sbridge->info = of_device_get_match_data(&pdev->dev);
+	else
+		sbridge->info = simple_bridge_get_match_data(&pdev->dev);
 
 	/* Get the next bridge in the pipeline. */
 	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
@@ -309,3 +330,4 @@ module_platform_driver(simple_bridge_driver);
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_DESCRIPTION("Simple DRM bridge driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:simple-bridge");
-- 
2.25.1


