Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56637DB17B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjJ2XgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjJ2XJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:09:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179C759E8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:04:09 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E09E6607392;
        Sun, 29 Oct 2023 23:02:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620563;
        bh=yiD04P9CgkHzY0nKiv5L+yDOq2HcDAwa5da3tFP1xDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6voNmWv+XnQYeoygWZPgZN4ZykybdYJjp2jCYpFL43XMxSR0Vnxfrdfk9/aowgY+
         qsFTfaHOylP4a1gSazSif5Q7WRcmYcxshuPxpDa+pDFQ7t91S6709I3lMYyyn4k0WN
         V1yOJJlUwI9ovBVwOM+ViQRQBdAPDnHSUYH9uAFVAs85zl4sXZ3SHsmHb5ohGFA8n5
         qLpsjnvUrn78ytyiM7t9b+uIEQbr4kjrjQfU7rGvs9wogNk3COfU2Q2VUKqa/QEv7J
         0rqyGVVAIgITd/hRMQ5CnbYR4+3T22T2IoLdPwt8BBOZ4NtoW7ra6Lq/xrTkuFcqeD
         kmwrfeer6kROw==
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
Subject: [PATCH v18 11/26] drm/shmem-helper: Prepare drm_gem_shmem_free() to shrinker addition
Date:   Mon, 30 Oct 2023 02:01:50 +0300
Message-ID: <20231029230205.93277-12-dmitry.osipenko@collabora.com>
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

Prepare drm_gem_shmem_free() to addition of memory shrinker support
to drm-shmem by adding and using variant of put_pages() that doesn't
touch reservation lock. Reservation shouldn't be touched because lockdep
will trigger a bogus warning about locking contention with fs_reclaim
code paths that can't happen during the time when GEM is freed and
lockdep doesn't know about that.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 35 +++++++++++++-------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 08b5a57c59d8..24ff2b99e75b 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -128,6 +128,22 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
 
+static void
+drm_gem_shmem_free_pages(struct drm_gem_shmem_object *shmem)
+{
+	struct drm_gem_object *obj = &shmem->base;
+
+#ifdef CONFIG_X86
+	if (shmem->map_wc)
+		set_pages_array_wb(shmem->pages, obj->size >> PAGE_SHIFT);
+#endif
+
+	drm_gem_put_pages(obj, shmem->pages,
+			  shmem->pages_mark_dirty_on_put,
+			  shmem->pages_mark_accessed_on_put);
+	shmem->pages = NULL;
+}
+
 /**
  * drm_gem_shmem_free - Free resources associated with a shmem GEM object
  * @shmem: shmem GEM object to free
@@ -142,8 +158,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 	if (obj->import_attach) {
 		drm_prime_gem_destroy(obj, shmem->sgt);
 	} else {
-		dma_resv_lock(shmem->base.resv, NULL);
-
 		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
 
 		if (shmem->sgt) {
@@ -157,8 +171,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 
 		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
 		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
-
-		dma_resv_unlock(shmem->base.resv);
 	}
 
 	drm_gem_object_release(obj);
@@ -208,21 +220,10 @@ static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
  */
 void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
 {
-	struct drm_gem_object *obj = &shmem->base;
-
 	dma_resv_assert_held(shmem->base.resv);
 
-	if (refcount_dec_and_test(&shmem->pages_use_count)) {
-#ifdef CONFIG_X86
-		if (shmem->map_wc)
-			set_pages_array_wb(shmem->pages, obj->size >> PAGE_SHIFT);
-#endif
-
-		drm_gem_put_pages(obj, shmem->pages,
-				  shmem->pages_mark_dirty_on_put,
-				  shmem->pages_mark_accessed_on_put);
-		shmem->pages = NULL;
-	}
+	if (refcount_dec_and_test(&shmem->pages_use_count))
+		drm_gem_shmem_free_pages(shmem);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
 
-- 
2.41.0

