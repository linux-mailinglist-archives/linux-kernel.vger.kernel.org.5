Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1387978A0CC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjH0R4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjH0R4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:56:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A2F102
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 10:56:19 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E0EA16607290;
        Sun, 27 Aug 2023 18:56:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693158978;
        bh=h5zA3QI6jLEZ04+CP8fo0PuRIMQ8t88TtCG2qT9Ffo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNSLxgqeiOzrV7VF4qOrkWsdZCcWTuFLRrgcZCerj/ELf3jnTGlBOGcdBAwdbbV4M
         LxQRiFJDoIik2S5Mg5DeDD8nXez4oPLNRkByEi4uL0mnSyQdkI/7vxizflqS3pLmHP
         bKatwdAxCtUKg9KKLCt9VSWQJlQwP2is/SdpyYXy8GBAn1IIHXmKLI8EUqtpNnY2dR
         fLs9waVIfpYJdEm6AwmzeT8k4iBxuw+n6cH+kxkaBuWXvgRTS3RW0hB+Xf4Yc4fTv5
         oQpbrMIXU/X7HN1iz+7Rj1arfSLy3/4vXakAAYjguctPqTCOw4KBdnk+gfJ33suU1A
         pBzCP7to1zYsA==
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
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v15 16/23] drm/shmem-helper: Use kref for vmap_use_count
Date:   Sun, 27 Aug 2023 20:54:42 +0300
Message-ID: <20230827175449.1766701-17-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kref helper for vmap_use_count to make refcounting consistent with
pages_use_count and pages_pin_count that use kref. This will allow to
optimize unlocked vmappings by skipping reservation locking if refcnt > 1.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 37 ++++++++++++++------------
 include/drm/drm_gem_shmem_helper.h     |  2 +-
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 17a0177acb5d..d96fee3d6166 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -144,7 +144,7 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 	} else if (!shmem->imported_sgt) {
 		dma_resv_lock(shmem->base.resv, NULL);
 
-		drm_WARN_ON(obj->dev, shmem->vmap_use_count);
+		drm_WARN_ON(obj->dev, kref_read(&shmem->vmap_use_count));
 
 		if (shmem->sgt) {
 			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
@@ -359,23 +359,25 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 
 		dma_resv_assert_held(shmem->base.resv);
 
-		if (shmem->vmap_use_count++ > 0) {
+		if (kref_get_unless_zero(&shmem->vmap_use_count)) {
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
+			kref_init(&shmem->vmap_use_count);
+		}
 	}
 
 	if (ret) {
@@ -388,13 +390,22 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 err_put_pages:
 	if (!obj->import_attach)
 		drm_gem_shmem_unpin_locked(shmem);
-err_zero_use:
-	shmem->vmap_use_count = 0;
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_vmap_locked);
 
+static void drm_gem_shmem_kref_vunmap(struct kref *kref)
+{
+	struct drm_gem_shmem_object *shmem;
+
+	shmem = container_of(kref, struct drm_gem_shmem_object,
+			     vmap_use_count);
+
+	vunmap(shmem->vaddr);
+	drm_gem_shmem_unpin_locked(shmem);
+}
+
 /*
  * drm_gem_shmem_vunmap_locked - Unmap a virtual mapping for a shmem GEM object
  * @shmem: shmem GEM object
@@ -416,15 +427,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 		dma_buf_vunmap(obj->import_attach->dmabuf, map);
 	} else {
 		dma_resv_assert_held(shmem->base.resv);
-
-		if (drm_WARN_ON_ONCE(obj->dev, !shmem->vmap_use_count))
-			return;
-
-		if (--shmem->vmap_use_count > 0)
-			return;
-
-		vunmap(shmem->vaddr);
-		drm_gem_shmem_unpin_locked(shmem);
+		kref_put(&shmem->vmap_use_count, drm_gem_shmem_kref_vunmap);
 	}
 
 	shmem->vaddr = NULL;
@@ -663,7 +666,7 @@ void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 		return;
 
 	drm_printf_indent(p, indent, "pages_use_count=%u\n", kref_read(&shmem->pages_use_count));
-	drm_printf_indent(p, indent, "vmap_use_count=%u\n", shmem->vmap_use_count);
+	drm_printf_indent(p, indent, "vmap_use_count=%u\n", kref_read(&shmem->vmap_use_count));
 	drm_printf_indent(p, indent, "vaddr=%p\n", shmem->vaddr);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_print_info);
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 400ecd63f45f..0e0ccd380f66 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -81,7 +81,7 @@ struct drm_gem_shmem_object {
 	 * Reference count on the virtual address.
 	 * The address are un-mapped when the count reaches zero.
 	 */
-	unsigned int vmap_use_count;
+	struct kref vmap_use_count;
 
 	/**
 	 * @got_sgt:
-- 
2.41.0

