Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33A57DB16D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjJ2Xfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjJ2XJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:09:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FB359E0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:04:07 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 58CA4660738F;
        Sun, 29 Oct 2023 23:02:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620561;
        bh=YiUzWYhixjIFzHrYQzk+9I4gbvEVcmmLu1dRzQZfca8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bepg4tDeL6IToL2jrwVhA463pzPKixSi9MO+ENdVY784DZoUBfh2DTKI2JDt1Vz9A
         h5vfQRsA++vjOLAEnb2vSD7FnDurLGe3OiKg20HfUKh22sfamKbXt6KInBmFaz5+pU
         4eIawXZoTbbnsSwcGnQmR5V0v2wzWkdJ84gIgmh6AUTqE5vaT/CIFu1S8oO5W4Qde1
         kVCfS9jj50xvqjI81gVG8dJkGkd0ib/pvTUt1b0Zkx9a8FMmeS20oxus6vDvkFxOMO
         e15j2ipUSr7DCzlrUgBDfv6z6xg69ATDPzXJFWO3z2GqyFjFod/mRcW8/NSu3CjXkp
         JIXem/lGbuiKA==
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
Subject: [PATCH v18 10/26] drm/shmem-helper: Use refcount_t for vmap_use_count
Date:   Mon, 30 Oct 2023 02:01:49 +0300
Message-ID: <20231029230205.93277-11-dmitry.osipenko@collabora.com>
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
index 6f963c2c1ecc..08b5a57c59d8 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -144,7 +144,7 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 	} else {
 		dma_resv_lock(shmem->base.resv, NULL);
 
-		drm_WARN_ON(obj->dev, shmem->vmap_use_count);
+		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
 
 		if (shmem->sgt) {
 			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
@@ -344,23 +344,25 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 
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
@@ -373,8 +375,6 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 err_put_pages:
 	if (!obj->import_attach)
 		drm_gem_shmem_unpin_locked(shmem);
-err_zero_use:
-	shmem->vmap_use_count = 0;
 
 	return ret;
 }
@@ -402,14 +402,10 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
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
@@ -655,7 +651,7 @@ void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 
 	drm_printf_indent(p, indent, "pages_pin_count=%u\n", refcount_read(&shmem->pages_pin_count));
 	drm_printf_indent(p, indent, "pages_use_count=%u\n", refcount_read(&shmem->pages_use_count));
-	drm_printf_indent(p, indent, "vmap_use_count=%u\n", shmem->vmap_use_count);
+	drm_printf_indent(p, indent, "vmap_use_count=%u\n", refcount_read(&shmem->vmap_use_count));
 	drm_printf_indent(p, indent, "vaddr=%p\n", shmem->vaddr);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_print_info);
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index a6de11001048..e7b3f4c02bf5 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -82,7 +82,7 @@ struct drm_gem_shmem_object {
 	 * Reference count on the virtual address.
 	 * The address are un-mapped when the count reaches zero.
 	 */
-	unsigned int vmap_use_count;
+	refcount_t vmap_use_count;
 
 	/**
 	 * @pages_mark_dirty_on_put:
-- 
2.41.0

