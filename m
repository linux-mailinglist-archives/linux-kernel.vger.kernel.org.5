Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D037A11C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjINX3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjINX3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:29:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC32738
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:29:13 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 18A936607358;
        Fri, 15 Sep 2023 00:29:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694734152;
        bh=H4//Ufjdpiez8DbccVn6AG/tNaxHtIsDVyQbjhwP95k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAQlPi7KeS+igUiEi/Xyrp4ykvqp34kPm2V/gfZSfw+V4ej4bIeMXFS5GxBbuKY9x
         vh2ais+pPNtCRH0EnQm0Do8a5WFFl1sXmYwl6R//WuZ0zdF70ZR9RGNSl59iFLv+J7
         F8QLVIACwLUpK3AD+4nW0u4wb48pQxxOHsTbtQQNhUxGDw1VfNuTYpol8022xLHlwx
         67STPwF0DANHhCrSZOWRUnBBSPD5fvK7CNRVS34B9MGClrwx/AZcYj2aQBhQE0tO/y
         SbCwnQdqG2qzgFo+uBKjpVmbdTSH5NFLggQTInoWRrhSRosKqzshedMy9jWRMJFcpb
         zjaV9+3VLjNuw==
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
Subject: [PATCH v17 10/18] drm/shmem-helper: Use refcount_t for vmap_use_count
Date:   Fri, 15 Sep 2023 02:27:13 +0300
Message-ID: <20230914232721.408581-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use refcount_t helper for vmap_use_count to make refcounting consistent
with pages_use_count and pages_pin_count that use refcount_t. This also
makes vmapping to benefit from the refcount_t's overflow checks.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 28 +++++++++++---------------
 include/drm/drm_gem_shmem_helper.h     |  2 +-
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e33810450324..e1fcb5154209 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -144,7 +144,7 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 	} else {
 		dma_resv_lock(shmem->base.resv, NULL);
 
-		drm_WARN_ON(obj->dev, shmem->vmap_use_count);
+		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
 
 		if (shmem->sgt) {
 			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
@@ -343,23 +343,25 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 
 		dma_resv_assert_held(shmem->base.resv);
 
-		if (shmem->vmap_use_count++ > 0) {
+		if (refcount_inc_not_zero(&shmem->vmap_use_count)) {
 			iosys_map_set_vaddr(map, shmem->vaddr);
 			return 0;
 		}
 
 		ret = drm_gem_shmem_pin_locked(shmem);
 		if (ret)
-			goto err_zero_use;
+			return ret;
 
 		if (shmem->map_wc)
 			prot = pgprot_writecombine(prot);
 		shmem->vaddr = vmap(shmem->pages, obj->size >> PAGE_SHIFT,
 				    VM_MAP, prot);
-		if (!shmem->vaddr)
+		if (!shmem->vaddr) {
 			ret = -ENOMEM;
-		else
+		} else {
 			iosys_map_set_vaddr(map, shmem->vaddr);
+			refcount_set(&shmem->vmap_use_count, 1);
+		}
 	}
 
 	if (ret) {
@@ -372,8 +374,6 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 err_put_pages:
 	if (!obj->import_attach)
 		drm_gem_shmem_unpin_locked(shmem);
-err_zero_use:
-	shmem->vmap_use_count = 0;
 
 	return ret;
 }
@@ -401,14 +401,10 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 	} else {
 		dma_resv_assert_held(shmem->base.resv);
 
-		if (drm_WARN_ON_ONCE(obj->dev, !shmem->vmap_use_count))
-			return;
-
-		if (--shmem->vmap_use_count > 0)
-			return;
-
-		vunmap(shmem->vaddr);
-		drm_gem_shmem_unpin_locked(shmem);
+		if (refcount_dec_and_test(&shmem->vmap_use_count)) {
+			vunmap(shmem->vaddr);
+			drm_gem_shmem_unpin_locked(shmem);
+		}
 	}
 
 	shmem->vaddr = NULL;
@@ -654,7 +650,7 @@ void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 
 	drm_printf_indent(p, indent, "pages_pin_count=%u\n", refcount_read(&shmem->pages_pin_count));
 	drm_printf_indent(p, indent, "pages_use_count=%u\n", refcount_read(&shmem->pages_use_count));
-	drm_printf_indent(p, indent, "vmap_use_count=%u\n", shmem->vmap_use_count);
+	drm_printf_indent(p, indent, "vmap_use_count=%u\n", refcount_read(&shmem->vmap_use_count));
 	drm_printf_indent(p, indent, "vaddr=%p\n", shmem->vaddr);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_print_info);
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 5b1ce7f7a39c..53dbd6a86edf 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -81,7 +81,7 @@ struct drm_gem_shmem_object {
 	 * Reference count on the virtual address.
 	 * The address are un-mapped when the count reaches zero.
 	 */
-	unsigned int vmap_use_count;
+	refcount_t vmap_use_count;
 
 	/**
 	 * @pages_mark_dirty_on_put:
-- 
2.41.0

