Return-Path: <linux-kernel+bounces-55377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B1384BBE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F5AB22829
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4E416431;
	Tue,  6 Feb 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bj9f6nPN"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14914A81
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240519; cv=none; b=Jt7es5nZUmGM2Fk52ClYRvhr5rFCy1olBEofL5q3fQfXVNAiqWwj5pgxgvezE/zOjtvLWXrwCCGtpbIzy1WmrA2dIgYlerxeqpt6qCs1cSa+N8rAicHp7S5w0qEvnUa7Es29VuU0Te6LUy2phdfj6v8105M23vmNGgs0exyeXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240519; c=relaxed/simple;
	bh=ckxXDAMdL+HGgVVf2k5qWXyty13TiKMKkVY5UlvzvTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SbbDI1Im5ikABZxPsTP1rZBWlSrdy8rCBoCZZzjme9RrpYahXZCfBcdKGz8a0M5MlBcH7Of/kdtL9vemlomlCOeKsU9bAQDLwJo7IR1VsLfeAM1fgVcH0APwGlRHmcA3iJUfZCzScqG2SE2gq6kYHP+oLYrL+NSEpRuJynHTr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bj9f6nPN; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707240516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmVPFCNKCEoxyfP5fWPRoMeSPbEbmBVNboqHaLmwopU=;
	b=bj9f6nPNUnvNreGxSEJL4GRanUU7epVcP9jtGuoNULXnMXPcYRC8wNMLn1F/9NdkMVaYxx
	rsABrTZTT8ee69ohJDd7pIwPlD9xmEuQnkNVKaOW4GFfph5FtQCL9dcx2Rc6ilrBkL+lc7
	W6tnQifptQj4MMRWcdDpGe/xKyH8moI=
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
Subject: [etnaviv-next v13 6/7] drm/etnaviv: Update the implement of etnaviv_create_platform_device()
Date: Wed,  7 Feb 2024 01:27:58 +0800
Message-Id: <20240206172759.421737-7-sui.jingfeng@linux.dev>
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

Because we need this function to create virtial child.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 33 +++++++++++++++++++++++----
 drivers/gpu/drm/etnaviv/etnaviv_drv.h |  9 ++++++++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index d5a5fcc30341..5f65f2dead44 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -670,16 +670,36 @@ static struct platform_driver etnaviv_platform_driver = {
 	},
 };
 
-static int etnaviv_create_platform_device(const char *name,
-					  struct platform_device **ppdev)
+int etnaviv_create_platform_device(struct device *parent,
+				   const char *name, int id,
+				   struct resource *pres,
+				   void *data,
+				   struct platform_device **ppdev)
 {
 	struct platform_device *pdev;
 	int ret;
 
-	pdev = platform_device_alloc(name, PLATFORM_DEVID_NONE);
+	pdev = platform_device_alloc(name, id);
 	if (!pdev)
 		return -ENOMEM;
 
+	pdev->dev.parent = parent;
+
+	if (pres) {
+		ret = platform_device_add_resources(pdev, pres, 1);
+		if (ret) {
+			platform_device_put(pdev);
+			return ret;
+		}
+	}
+
+	if (data) {
+		void *pdata = kmalloc(sizeof(void *), GFP_KERNEL);
+
+		*(void **)pdata = data;
+		pdev->dev.platform_data = pdata;
+	}
+
 	ret = platform_device_add(pdev);
 	if (ret) {
 		platform_device_put(pdev);
@@ -691,7 +711,7 @@ static int etnaviv_create_platform_device(const char *name,
 	return 0;
 }
 
-static void etnaviv_destroy_platform_device(struct platform_device **ppdev)
+void etnaviv_destroy_platform_device(struct platform_device **ppdev)
 {
 	struct platform_device *pdev = *ppdev;
 
@@ -728,7 +748,10 @@ static int __init etnaviv_init(void)
 	if (np) {
 		of_node_put(np);
 
-		ret = etnaviv_create_platform_device("etnaviv", &etnaviv_drm);
+		ret = etnaviv_create_platform_device(NULL, "etnaviv",
+						     PLATFORM_DEVID_NONE,
+						     NULL, NULL,
+						     &etnaviv_drm);
 		if (ret)
 			goto unregister_platform_driver;
 	}
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index 9c05f503747a..bd8ac64dbaf3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/mm_types.h>
+#include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/time64.h>
 #include <linux/types.h>
@@ -97,6 +98,14 @@ bool etnaviv_cmd_validate_one(struct etnaviv_gpu *gpu,
 	u32 *stream, unsigned int size,
 	struct drm_etnaviv_gem_submit_reloc *relocs, unsigned int reloc_size);
 
+int etnaviv_create_platform_device(struct device *parent,
+				   const char *name, int id,
+				   struct resource *pres,
+				   void *data,
+				   struct platform_device **ppdev);
+
+void etnaviv_destroy_platform_device(struct platform_device **ppdev);
+
 #ifdef CONFIG_DEBUG_FS
 void etnaviv_gem_describe_objects(struct etnaviv_drm_private *priv,
 	struct seq_file *m);
-- 
2.34.1


