Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E67DB0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjJ2XWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjJ2XWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:22:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCFB7D8C
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:04:17 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6BC9E6607390;
        Sun, 29 Oct 2023 23:02:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620573;
        bh=Y38zEoY1/gjYYjrjDZs9Rr+zwqObmBjdBml3XtFCTzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vsu1u+Npxkp9e5ZNo9JZC5sEhd9r5AwEDu6nZCq3kKd+dbEAq44Z0f0Oq4nd5s9JJ
         IDidsJaAwKOwFEgHBx+rmabzyhrPrPquTmDzes50MPEQ2tnGo6txyw/C4mpuaNyb4n
         ixPslp3QLBnnLP96U5Hq2Q8dnX3TUSDXciHTZONuOYXT+4dhzug8t+dMCcNiEHMO+r
         Zgn+tjohtPFre1OJaf38Ybb4ckxki5HIJtmV/Knkn7lLgiij2m+3l8yenA4Aa6kr3R
         k/rmwBvcfH6L+9GiR1DzQrzVbaTADTKKvs4MejvOWFTLKeNFtLV+MerVAlTrLXGk1J
         UGR5T/2Kd5VGQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v18 18/26] drm/shmem-helper: Change sgt allocation policy
Date:   Mon, 30 Oct 2023 02:01:57 +0300
Message-ID: <20231029230205.93277-19-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 51 +++++++++++++-------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index f371ebc6f85c..1420d2166b76 100644
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
@@ -155,23 +163,12 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 
-	if (obj->import_attach) {
+	if (obj->import_attach)
 		drm_prime_gem_destroy(obj, shmem->sgt);
-	} else {
-		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
-
-		if (shmem->sgt) {
-			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
-					  DMA_BIDIRECTIONAL, 0);
-			sg_free_table(shmem->sgt);
-			kfree(shmem->sgt);
-		}
-		if (shmem->pages)
-			drm_gem_shmem_put_pages_locked(shmem);
 
-		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
-		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
-	}
+	drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
+	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
+	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
 
 	drm_gem_object_release(obj);
 	kfree(shmem);
@@ -705,6 +702,9 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
 
 	drm_WARN_ON(obj->dev, obj->import_attach);
 
+	if (drm_WARN_ON(obj->dev, !shmem->pages))
+		return ERR_PTR(-ENOMEM);
+
 	return drm_prime_pages_to_sg(obj->dev, shmem->pages, obj->size >> PAGE_SHIFT);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
@@ -720,15 +720,10 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
 
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
@@ -741,8 +736,6 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
 err_free_sgt:
 	sg_free_table(sgt);
 	kfree(sgt);
-err_put_pages:
-	drm_gem_shmem_put_pages_locked(shmem);
 	return ERR_PTR(ret);
 }
 
@@ -759,6 +752,14 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
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
  * Returns:
  * A pointer to the scatter/gather table of pinned pages or errno on failure.
  */
-- 
2.41.0

