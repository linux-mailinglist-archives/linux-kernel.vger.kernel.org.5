Return-Path: <linux-kernel+bounces-18259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F02825AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8791F22317
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37B23A29E;
	Fri,  5 Jan 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L4TOndeX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536A3A1C6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480438;
	bh=TqXT2PdRKdsfVWfuHdIUz5qWMXCVZU9Nx7RXrVE6nQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4TOndeX4uNvvr+jO3tvm5FF6uhPCkatj8ub4WMpwmcWSjb8nntV6FCGfNHR8+jgB
	 7X22VUvb7tAVulKPH6afTNYJYIxsPkkwCD8AdJko/lxApBmxy4wC157P9HWRwk5Crg
	 sGFQipdQDyfZvFsKUZlPfnpsJ8LX7E6r8PpC63LH+dyUXY4N936NnWKPnWweKUC5Bp
	 n6G/sal2sxhPJGAxdzOmdivhzFMV0EJdpRUT3uD+iyDuI53cQf8S4xWEkzb1tqtIH9
	 SeRCg1ArebDe5Qs7hTwAOzQw7j/2W3IT2Bd3eqIJ1ntDmpFOQ0+chg16NeOXax/plZ
	 5CgG0uJUFk9gA==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DF24F378204D;
	Fri,  5 Jan 2024 18:47:16 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Emma Anholt <emma@anholt.net>,
	Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v19 21/30] drm/shmem-helper: Change sgt allocation policy
Date: Fri,  5 Jan 2024 21:46:15 +0300
Message-ID: <20240105184624.508603-22-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a preparation to addition of drm-shmem memory shrinker support, change
the SGT allocation policy in this way:

1. SGT can be allocated only if shmem pages are pinned at the
time of allocation, otherwise allocation fails.

2. Drivers must ensure that pages are pinned during the time of SGT usage
and should get new SGT if pages were unpinned.

This new policy is required by the shrinker because it will move pages
to/from SWAP unless pages are pinned, invalidating SGT pointer once pages
are relocated.

Previous patches prepared drivers to the new policy.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 55 ++++++++++++++------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index c7357110ca76..ff5437ab2c95 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -133,6 +133,14 @@ drm_gem_shmem_free_pages(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 
+	if (shmem->sgt) {
+		dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
+				  DMA_BIDIRECTIONAL, 0);
+		sg_free_table(shmem->sgt);
+		kfree(shmem->sgt);
+		shmem->sgt = NULL;
+	}
+
 #ifdef CONFIG_X86
 	if (shmem->map_wc)
 		set_pages_array_wb(shmem->pages, obj->size >> PAGE_SHIFT);
@@ -155,24 +163,12 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 
-	if (obj->import_attach) {
+	if (obj->import_attach)
 		drm_prime_gem_destroy(obj, shmem->sgt);
-	} else {
-		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
 
-		if (shmem->sgt) {
-			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
-					  DMA_BIDIRECTIONAL, 0);
-			sg_free_table(shmem->sgt);
-			kfree(shmem->sgt);
-		}
-		if (shmem->pages &&
-		    refcount_dec_and_test(&shmem->pages_use_count))
-			drm_gem_shmem_free_pages(shmem);
-
-		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
-		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
-	}
+	drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
+	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
+	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
 
 	drm_gem_object_release(obj);
 	kfree(shmem);
@@ -722,6 +718,9 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
 
 	drm_WARN_ON(obj->dev, obj->import_attach);
 
+	if (drm_WARN_ON(obj->dev, !shmem->pages))
+		return ERR_PTR(-ENOMEM);
+
 	return drm_prime_pages_to_sg(obj->dev, shmem->pages, obj->size >> PAGE_SHIFT);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
@@ -737,15 +736,10 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
 
 	drm_WARN_ON(obj->dev, obj->import_attach);
 
-	ret = drm_gem_shmem_get_pages_locked(shmem);
-	if (ret)
-		return ERR_PTR(ret);
-
 	sgt = drm_gem_shmem_get_sg_table(shmem);
-	if (IS_ERR(sgt)) {
-		ret = PTR_ERR(sgt);
-		goto err_put_pages;
-	}
+	if (IS_ERR(sgt))
+		return sgt;
+
 	/* Map the pages for use by the h/w. */
 	ret = dma_map_sgtable(obj->dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
 	if (ret)
@@ -758,8 +752,6 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
 err_free_sgt:
 	sg_free_table(sgt);
 	kfree(sgt);
-err_put_pages:
-	drm_gem_shmem_put_pages_locked(shmem);
 	return ERR_PTR(ret);
 }
 
@@ -776,6 +768,17 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
  * and difference between dma-buf imported and natively allocated objects.
  * drm_gem_shmem_get_sg_table() should not be directly called by drivers.
  *
+ * Drivers should adhere to these SGT usage rules:
+ *
+ * 1. SGT should be allocated only if shmem pages are pinned at the
+ *    time of allocation, otherwise allocation will fail.
+ *
+ * 2. Drivers should ensure that pages are pinned during the time of
+ *    SGT usage and should get new SGT if pages were unpinned.
+ *
+ * Drivers don't own returned SGT and must take care of the SGT pointer
+ * lifetime. SGT is valid as long as GEM pages that backing SGT are pinned.
+ *
  * Returns:
  * A pointer to the scatter/gather table of pinned pages or errno on failure.
  */
-- 
2.43.0


