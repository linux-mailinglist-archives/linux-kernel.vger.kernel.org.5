Return-Path: <linux-kernel+bounces-55375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6D84BBE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FBD1C2362A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916B13ADD;
	Tue,  6 Feb 2024 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CBSJ6Qu0"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03AC134C1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240511; cv=none; b=N+24sn/GOZ3poXanswjL0GxmteqYXuv2dnJQeoJHJ+tTeqnpAHNkMsPHRidYVX91e3Yi6l7bFPIO8f2xlyHNxd/tVb+ypTII2czD01oJpk785Df3S+gPeNRXp4siHunD7p+nvKIkf2wd034U4/KeIozbKkFiFwlf//suiQl2rpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240511; c=relaxed/simple;
	bh=G4vOW0cc6Sv9nxhDLNT0Pe4VnPsarPhEmrxuUpplrfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ll1XsPw4aVcRTyyq7Q9P2Zhybz8oXGVZEKi0ZpaIst89RXxzm31UqMNpK7sQlBbLCctNkQDt19PV8mgR1hExsPViw+ZVE4nriANxpZiM4PnfNrVqZbldmxmfnjGTeWinjwzmaeryqjjBUf8kjhnAAFHJcxiKnXkoMWbWrfyF0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CBSJ6Qu0; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707240508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVVAqRzMJsdMeT1oOUAb65qyjBdxIyQ/VJBw576jp8g=;
	b=CBSJ6Qu0yJEpGwXujNr8pa0XwekuOg2d0/VV3w1I289ams5E59ep2xR/nyVFM6UYx0qUO8
	/Uf+1eNfcC4j1cK+E16/5jvKTM2f3vxIZ2CBkJBpC95681X9ifZpg2pr+13T8kQQ4Xg1Us
	AL6jNDSBBuP4gDk4MPYOc2p1Mfmc7uQ=
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
Subject: [etnaviv-next v13 4/7] drm/etnaviv: Add support for cached coherent caching mode
Date: Wed,  7 Feb 2024 01:27:56 +0800
Message-Id: <20240206172759.421737-5-sui.jingfeng@linux.dev>
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

In the etnaviv_gem_vmap_impl(), update the page property from writecombine
to PAGE_KERNEL on cached mapping. Previously, it use writecombine page
property to vmap cached buffer unconditionally. Many modern CPUs choose to
define the peripheral devices as DMA coherent by default, to be specific,
the peripheral devices are capable of snooping CPU's cache. Therefore,
cached buffers should be accessed with cached mapping.

While at it, probe cached coherent support at the host platform with the
dev_is_dma_coherent() function. This allows userspace to query on the
runtime, which avoid compile-time macros (#ifdefs). Modern CPUs choose to
define the peripheral devices as DMA coherent by default, In other words,
the peripheral devices are capable of snooping CPU's cache. This means
that device drivers do not need to maintain the coherency issue between
a processor and an peripheral I/O for the cached mapping buffers. Such a
hardware feature is implementation-defined by host CPU platform, not the
vivante GPU IP core itself. X86-64, LoongArch and Loongson Mips CPU and
some ARM64 CPU has the hardware maintain cache coherency, but ARM CPU is
not. So provide mechanism to let userspace know.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c |  3 +++
 drivers/gpu/drm/etnaviv/etnaviv_drv.h |  8 ++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 16 ++++++++++++++--
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  4 ++++
 include/uapi/drm/etnaviv_drm.h        |  1 +
 5 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 5ba2b3a386b3..e3a05b8b9330 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -5,6 +5,7 @@
 
 #include <linux/component.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -57,6 +58,8 @@ static int etnaviv_private_init(struct device *dev,
 		return -ENOMEM;
 	}
 
+	priv->cached_coherent = dev_is_dma_coherent(dev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index 1f9b50b5a6aa..9c05f503747a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -46,6 +46,14 @@ struct etnaviv_drm_private {
 	struct xarray active_contexts;
 	u32 next_context_id;
 
+	/*
+	 * If true, the cached mapping is consistent for all CPU cores and
+	 * peripheral bus masters in the system. It means that vboth of the
+	 * CPU and GPU will see the same data if the buffer being access is
+	 * cached. And coherency is guaranteed by the arch specific hardware.
+	 */
+	bool cached_coherent;
+
 	/* list of GEM objects: */
 	struct mutex gem_lock;
 	struct list_head gem_list;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index aa95a5e98374..eed98bb9e446 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -342,6 +342,7 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
 static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 {
 	struct page **pages;
+	pgprot_t prot;
 
 	lockdep_assert_held(&obj->lock);
 
@@ -349,8 +350,19 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 	if (IS_ERR(pages))
 		return NULL;
 
-	return vmap(pages, obj->base.size >> PAGE_SHIFT,
-			VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+	switch (obj->flags) {
+	case ETNA_BO_CACHED:
+		prot = PAGE_KERNEL;
+		break;
+	case ETNA_BO_UNCACHED:
+		prot = pgprot_noncached(PAGE_KERNEL);
+		break;
+	case ETNA_BO_WC:
+	default:
+		prot = pgprot_writecombine(PAGE_KERNEL);
+	}
+
+	return vmap(pages, obj->base.size >> PAGE_SHIFT, VM_MAP, prot);
 }
 
 static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index a407c2c9e140..306973660653 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -184,6 +184,10 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
 		*value = gpu->identity.axi_sram_size;
 		break;
 
+	case ETNAVIV_PARAM_CACHED_COHERENT:
+		*value = priv->cached_coherent;
+		break;
+
 	default:
 		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
 		return -EINVAL;
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index d87410a8443a..7c5d988a5b9f 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -82,6 +82,7 @@ struct drm_etnaviv_timespec {
 #define ETNAVIV_PARAM_GPU_TP_CORE_COUNT             0x21
 #define ETNAVIV_PARAM_GPU_ON_CHIP_SRAM_SIZE         0x22
 #define ETNAVIV_PARAM_GPU_AXI_SRAM_SIZE             0x23
+#define ETNAVIV_PARAM_CACHED_COHERENT               0x24
 
 #define ETNA_MAX_PIPES 4
 
-- 
2.34.1


