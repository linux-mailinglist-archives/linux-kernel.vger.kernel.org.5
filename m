Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C087DB0BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjJ2XKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjJ2XJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:09:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D859CB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:04:07 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D7FE96607387;
        Sun, 29 Oct 2023 23:02:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620560;
        bh=ih31JcNUpLNYCcpJ32jBP51vfnpgNdQgzCQ0RrzRDWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1+Y6dZP3fY4uMO+pqyCfgwQ7hDgFCQo/u7MWZtJcKTUHXEij+CQdEzjDqxlywHRL
         rHK4RZMKZRwpEq5x/gLfs0H0O8dVe1yMRorow86lsdVpz9YeWoVq3fkZOGCTUAiawa
         LRnfeoyUN/2On+AVhn6d7lfPdFyDjsOtnmFeoHTo5BU5EPbi3E9IlXjQJ14gz6LZpl
         hIsxTHNtQbF3+b9UgXAyszXvQL8unAQvKHW3LTXO/32VD4WpdZdBsuLpWQQldnIAXi
         yGkudz326ldeXY0VIqw9xJSzeFYBZaDCyR2kLD+G38r3R3D/W9I3sYmEHhvANoY8mH
         XVC0AJB8a5CYw==
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
Subject: [PATCH v18 09/26] drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
Date:   Mon, 30 Oct 2023 02:01:48 +0300
Message-ID: <20231029230205.93277-10-dmitry.osipenko@collabora.com>
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

The vmapped pages shall be pinned in memory and previously get/put_pages()
were implicitly hard-pinning/unpinning the pages. This will no longer be
the case with addition of memory shrinker because pages_use_count > 0 won't
determine anymore whether pages are hard-pinned (they will be soft-pinned),
while the new pages_pin_count will do the hard-pinning. Switch the
vmap/vunmap() to use pin/unpin() functions in a preparation of addition
of the memory shrinker support to drm-shmem.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 19 ++++++++++++-------
 include/drm/drm_gem_shmem_helper.h     |  2 +-
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 41b749bedb11..6f963c2c1ecc 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -256,6 +256,14 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 	return ret;
 }
 
+static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
+{
+	dma_resv_assert_held(shmem->base.resv);
+
+	if (refcount_dec_and_test(&shmem->pages_pin_count))
+		drm_gem_shmem_put_pages_locked(shmem);
+}
+
 /**
  * drm_gem_shmem_pin - Pin backing pages for a shmem GEM object
  * @shmem: shmem GEM object
@@ -303,10 +311,7 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
 		return;
 
 	dma_resv_lock(shmem->base.resv, NULL);
-
-	if (refcount_dec_and_test(&shmem->pages_pin_count))
-		drm_gem_shmem_put_pages_locked(shmem);
-
+	drm_gem_shmem_unpin_locked(shmem);
 	dma_resv_unlock(shmem->base.resv);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_unpin);
@@ -344,7 +349,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 			return 0;
 		}
 
-		ret = drm_gem_shmem_get_pages_locked(shmem);
+		ret = drm_gem_shmem_pin_locked(shmem);
 		if (ret)
 			goto err_zero_use;
 
@@ -367,7 +372,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 
 err_put_pages:
 	if (!obj->import_attach)
-		drm_gem_shmem_put_pages_locked(shmem);
+		drm_gem_shmem_unpin_locked(shmem);
 err_zero_use:
 	shmem->vmap_use_count = 0;
 
@@ -404,7 +409,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 			return;
 
 		vunmap(shmem->vaddr);
-		drm_gem_shmem_put_pages_locked(shmem);
+		drm_gem_shmem_unpin_locked(shmem);
 	}
 
 	shmem->vaddr = NULL;
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index bd3596e54abe..a6de11001048 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -124,7 +124,7 @@ int drm_gem_shmem_madvise_locked(struct drm_gem_shmem_object *shmem, int madv);
 static inline bool drm_gem_shmem_is_purgeable(struct drm_gem_shmem_object *shmem)
 {
 	return (shmem->madv > 0) &&
-		!shmem->vmap_use_count && shmem->sgt &&
+		!refcount_read(&shmem->pages_pin_count) && shmem->sgt &&
 		!shmem->base.dma_buf && !shmem->base.import_attach;
 }
 
-- 
2.41.0

