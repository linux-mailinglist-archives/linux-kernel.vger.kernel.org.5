Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBC78A0C7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjH0R4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjH0R4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:56:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A7102
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 10:56:21 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F72766073A1;
        Sun, 27 Aug 2023 18:56:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693158980;
        bh=VhX33TYAAg+dJ/TxzMS+7aTR0gptdB20NZJfyVWD51s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfk3k6qXwyky5OMtU3XhLc4eAo4b9Cz+rMN5Iv1Ktx+C/wIdA3tqiNvTZ3QUS7ecD
         E1NBnx+ZzL/xsp+j608CQaJC7Mk/8cdwCl/9Fw/l+RvbyRmo09gTLPLYE9S19J5Vxa
         ss0aRcZP7qO4mSzNW4+L+zutl/Rnb0jKYyAlzL00NYRcppPM6ve4mJrEjVqcDWEMb2
         OrgfmwaKI/dv/FStX6lbCg0tPB/I33uxG1yx0ojJU4TJpzVotk+H8+8uchB7Hg+aaj
         nFRXxUvQw8NarUtb/BqH1CDPYPWd2oJ59a4CCewhjusv3S2sII6Zy7mMGkEjgYZ3as
         qhpMQdGVZhr8w==
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
Subject: [PATCH v15 17/23] drm/shmem-helper: Add and use drm_gem_shmem_resv_assert_held() helper
Date:   Sun, 27 Aug 2023 20:54:43 +0300
Message-ID: <20230827175449.1766701-18-dmitry.osipenko@collabora.com>
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

In a preparation of adding drm-shmem memory shrinker, move all reservation
locking lockdep checks to use new drm_gem_shmem_resv_assert_held() that
will resolve spurious lockdep warning about wrong locking order vs
fs_reclam code paths during freeing of shmem GEM, where lockdep isn't
aware that it's impossible to have locking contention with the fs_reclam
at this special time.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 37 +++++++++++++++++---------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index d96fee3d6166..ca5da976aafa 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -128,6 +128,23 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
 
+static void drm_gem_shmem_resv_assert_held(struct drm_gem_shmem_object *shmem)
+{
+	/*
+	 * Destroying the object is a special case.. drm_gem_shmem_free()
+	 * calls many things that WARN_ON if the obj lock is not held.  But
+	 * acquiring the obj lock in drm_gem_shmem_free() can cause a locking
+	 * order inversion between reservation_ww_class_mutex and fs_reclaim.
+	 *
+	 * This deadlock is not actually possible, because no one should
+	 * be already holding the lock when drm_gem_shmem_free() is called.
+	 * Unfortunately lockdep is not aware of this detail.  So when the
+	 * refcount drops to zero, we pretend it is already locked.
+	 */
+	if (kref_read(&shmem->base.refcount))
+		drm_gem_shmem_resv_assert_held(shmem);
+}
+
 /**
  * drm_gem_shmem_free - Free resources associated with a shmem GEM object
  * @shmem: shmem GEM object to free
@@ -142,8 +159,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 	if (obj->import_attach) {
 		drm_prime_gem_destroy(obj, shmem->sgt);
 	} else if (!shmem->imported_sgt) {
-		dma_resv_lock(shmem->base.resv, NULL);
-
 		drm_WARN_ON(obj->dev, kref_read(&shmem->vmap_use_count));
 
 		if (shmem->sgt) {
@@ -156,8 +171,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 			drm_gem_shmem_put_pages_locked(shmem);
 
 		drm_WARN_ON(obj->dev, kref_read(&shmem->pages_use_count));
-
-		dma_resv_unlock(shmem->base.resv);
 	}
 
 	drm_gem_object_release(obj);
@@ -170,7 +183,7 @@ static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
 	struct drm_gem_object *obj = &shmem->base;
 	struct page **pages;
 
-	dma_resv_assert_held(shmem->base.resv);
+	drm_gem_shmem_resv_assert_held(shmem);
 
 	if (kref_get_unless_zero(&shmem->pages_use_count))
 		return 0;
@@ -228,7 +241,7 @@ static void drm_gem_shmem_kref_release_pages(struct kref *kref)
  */
 void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
 {
-	dma_resv_assert_held(shmem->base.resv);
+	drm_gem_shmem_resv_assert_held(shmem);
 
 	kref_put(&shmem->pages_use_count, drm_gem_shmem_kref_release_pages);
 }
@@ -252,7 +265,7 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 {
 	int ret;
 
-	dma_resv_assert_held(shmem->base.resv);
+	drm_gem_shmem_resv_assert_held(shmem);
 
 	if (kref_get_unless_zero(&shmem->pages_pin_count))
 		return 0;
@@ -276,7 +289,7 @@ static void drm_gem_shmem_kref_unpin_pages(struct kref *kref)
 
 static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
 {
-	dma_resv_assert_held(shmem->base.resv);
+	drm_gem_shmem_resv_assert_held(shmem);
 
 	kref_put(&shmem->pages_pin_count, drm_gem_shmem_kref_unpin_pages);
 }
@@ -357,7 +370,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
-		dma_resv_assert_held(shmem->base.resv);
+		drm_gem_shmem_resv_assert_held(shmem);
 
 		if (kref_get_unless_zero(&shmem->vmap_use_count)) {
 			iosys_map_set_vaddr(map, shmem->vaddr);
@@ -426,7 +439,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 	if (obj->import_attach) {
 		dma_buf_vunmap(obj->import_attach->dmabuf, map);
 	} else {
-		dma_resv_assert_held(shmem->base.resv);
+		drm_gem_shmem_resv_assert_held(shmem);
 		kref_put(&shmem->vmap_use_count, drm_gem_shmem_kref_vunmap);
 	}
 
@@ -462,7 +475,7 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
  */
 int drm_gem_shmem_madvise_locked(struct drm_gem_shmem_object *shmem, int madv)
 {
-	dma_resv_assert_held(shmem->base.resv);
+	drm_gem_shmem_resv_assert_held(shmem);
 
 	if (shmem->madv >= 0)
 		shmem->madv = madv;
@@ -478,7 +491,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem)
 	struct drm_gem_object *obj = &shmem->base;
 	struct drm_device *dev = obj->dev;
 
-	dma_resv_assert_held(shmem->base.resv);
+	drm_gem_shmem_resv_assert_held(shmem);
 
 	drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
 
-- 
2.41.0

