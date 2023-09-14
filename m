Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8001C7A11C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjINX3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjINX3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:29:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E072D47
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:29:11 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9CC4C6607361;
        Fri, 15 Sep 2023 00:29:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694734150;
        bh=95RvGfyJ8q6zGTTDbjPVGjLvvotKmfU2Ktoc4dGTUKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJDAivmpg/D+DaEAG229AKQ7UmZIT61e/n0KyYcX1e+9ozi6FpRQX9xYrzL3K1U51
         5tWAJBHIgbacmJA2z5RORt3iW0NM9tq3miw5EiDAaz9EmmKsfIkGjJfoGBbSn5bOAH
         zY2HBF/TX9YGBQJwt05dOCEgRojEELEU/V00gPLGBeg8fX3K+JfwgWpDVqREwUS3pY
         GrjRWVYu+eSUCSkxNQYZmMfkf9V+MfPRSgL+YDVLi2gGI6tN+Hxl4yxPBvFJeo4RCy
         q4yyaX0YAC/edn8qHd2zm2TtHq7qKFC53VsMqX1rHM438cBtrYnpJC0OHvSg8L0YHI
         0VkhUEm2ZAbJw==
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
Subject: [PATCH v17 09/18] drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
Date:   Fri, 15 Sep 2023 02:27:12 +0300
Message-ID: <20230914232721.408581-10-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index a5964f347dda..e33810450324 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -255,6 +255,14 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
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
@@ -302,10 +310,7 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
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
@@ -343,7 +348,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 			return 0;
 		}
 
-		ret = drm_gem_shmem_get_pages_locked(shmem);
+		ret = drm_gem_shmem_pin_locked(shmem);
 		if (ret)
 			goto err_zero_use;
 
@@ -366,7 +371,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 
 err_put_pages:
 	if (!obj->import_attach)
-		drm_gem_shmem_put_pages_locked(shmem);
+		drm_gem_shmem_unpin_locked(shmem);
 err_zero_use:
 	shmem->vmap_use_count = 0;
 
@@ -403,7 +408,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 			return;
 
 		vunmap(shmem->vaddr);
-		drm_gem_shmem_put_pages_locked(shmem);
+		drm_gem_shmem_unpin_locked(shmem);
 	}
 
 	shmem->vaddr = NULL;
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 3947f5c6bff7..5b1ce7f7a39c 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -123,7 +123,7 @@ int drm_gem_shmem_madvise_locked(struct drm_gem_shmem_object *shmem, int madv);
 static inline bool drm_gem_shmem_is_purgeable(struct drm_gem_shmem_object *shmem)
 {
 	return (shmem->madv > 0) &&
-		!shmem->vmap_use_count && shmem->sgt &&
+		!refcount_read(&shmem->pages_pin_count) && shmem->sgt &&
 		!shmem->base.dma_buf && !shmem->base.import_attach;
 }
 
-- 
2.41.0

