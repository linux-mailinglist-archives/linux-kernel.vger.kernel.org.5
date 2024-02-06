Return-Path: <linux-kernel+bounces-55376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267BD84BBE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE01D1F25F72
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124CF1426D;
	Tue,  6 Feb 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dvCnJRTV"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DDA13FE7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240515; cv=none; b=FiIn7dRV/xZ8zlj8A5JGDkzg1etEb3UvQ1CqT8hnULulGlomeRT8fK8U9hQcpG+U2g85vfMuTSi0k9+MeiaSu4cqgQ4HZCSo3g+wx/apcmsS/FC1eZWvaJlplwXai/U+hLnKd0OFuF+cwrw3+4ydnz8vXRRaK6xGf9bl2hO6nqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240515; c=relaxed/simple;
	bh=03yi27ExKzCdAz4CD/WXAaSXy3Go2ef741YE4yG2Vcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZqT+1iFOZz+6KJDAdSqpLS3ZnLh0Aw9ItTx1SbM1zE6XIP2UbjhW5Lj6ko+JBbOp73ZB0t5iokzwduhTk1kMAF343hXX7Q5pYKsmGSI/UowbMTDEYX7pzdfVlorNUTSkezlIfJWy0tl51b8tyur/5+HQQFgEgQosSpWE2XTD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dvCnJRTV; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707240511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0hdY76agQrzY+9gtVZaFHqY84LfFC9/R41cfmLOlh8=;
	b=dvCnJRTVEODFXuwOO7YyVPHVEEu1sDKKoH+z9Dc8yc7y0A+nMKTi+8arxlg+5p3Lnj+S29
	GpgdG3j7ZriNqqmz6xWa9RjvifOP2uLBlme0lZNYhINy9OcR/9VEfG2JrBHLxqt2u5taEb
	tXE6/8DzvG4NxsC3XmeerKEgsM0Y5ZU=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [etnaviv-next v13 5/7] drm/etnaviv: Replace the '&pdev->dev' with 'dev'
Date: Wed,  7 Feb 2024 01:27:57 +0800
Message-Id: <20240206172759.421737-6-sui.jingfeng@linux.dev>
In-Reply-To: <20240206172759.421737-1-sui.jingfeng@linux.dev>
References: <20240206172759.421737-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the etnaviv_pdev_probe() and the etnaviv_gpu_platform_probe() function,
the value of '&pdev->dev' has been cached to a local auto variable (which
is named as 'dev'), but part of caller functions use 'dev' as argument,
but the rest use '&pdev->dev'. To keep it consistent, use 'dev' uniformly.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++-----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index e3a05b8b9330..d5a5fcc30341 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -612,7 +612,7 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			if (!of_device_is_available(core_node))
 				continue;
 
-			drm_of_component_match_add(&pdev->dev, &match,
+			drm_of_component_match_add(dev, &match,
 						   component_compare_of, core_node);
 		}
 	} else {
@@ -635,9 +635,9 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 	 * bit to make sure we are allocating the command buffers and
 	 * TLBs in the lower 4 GiB address space.
 	 */
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(40)) ||
-	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32))) {
-		dev_dbg(&pdev->dev, "No suitable DMA available\n");
+	if (dma_set_mask(dev, DMA_BIT_MASK(40)) ||
+	    dma_set_coherent_mask(dev, DMA_BIT_MASK(32))) {
+		dev_dbg(dev, "No suitable DMA available\n");
 		return -ENODEV;
 	}
 
@@ -648,7 +648,7 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 	 */
 	first_node = etnaviv_of_first_available_node();
 	if (first_node) {
-		of_dma_configure(&pdev->dev, first_node, true);
+		of_dma_configure(dev, first_node, true);
 		of_node_put(first_node);
 	}
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 306973660653..3fd637c17797 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1903,7 +1903,7 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	if (!gpu)
 		return -ENOMEM;
 
-	gpu->dev = &pdev->dev;
+	gpu->dev = dev;
 	mutex_init(&gpu->lock);
 	mutex_init(&gpu->sched_lock);
 
@@ -1917,8 +1917,8 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	if (gpu->irq < 0)
 		return gpu->irq;
 
-	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
-			       dev_name(gpu->dev), gpu);
+	err = devm_request_irq(dev, gpu->irq, irq_handler, 0,
+			       dev_name(dev), gpu);
 	if (err) {
 		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
 		return err;
@@ -1937,13 +1937,13 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	 * autosuspend delay is rather arbitary: no measurements have
 	 * yet been performed to determine an appropriate value.
 	 */
-	pm_runtime_use_autosuspend(gpu->dev);
-	pm_runtime_set_autosuspend_delay(gpu->dev, 200);
-	pm_runtime_enable(gpu->dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 200);
+	pm_runtime_enable(dev);
 
-	err = component_add(&pdev->dev, &gpu_ops);
+	err = component_add(dev, &gpu_ops);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to register component: %d\n", err);
+		dev_err(dev, "failed to register component: %d\n", err);
 		return err;
 	}
 
-- 
2.34.1


