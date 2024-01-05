Return-Path: <linux-kernel+bounces-18250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B01825A9B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C181C235A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1A38DEC;
	Fri,  5 Jan 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aVeYBhwZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981A381D1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480423;
	bh=xi7umfn3odK5/kuqYD+1GYoRfQ0wyb5ZdiidzOwD6Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVeYBhwZRIhsDGR8JNg4W1K4IyB5of3osKSyffgpHpmO7cUAD1oSr6XDnxCxplEGt
	 cbbPrZH8nlbs87hGn59EXGf+0cQikhVOXvLjnXqTEMhsQQmeXU2TOprdWPaqmKQU2Y
	 S4xcYlV6Z5xpnLTyRXl+NS75Akvw9m3E1XRZh8n79DDi/WFqzdtCkqQKYi1WwPNDEv
	 yOmMAYeaUOYaM5VGQsj3+pkIc+qjgOOfsC+L6yRRpZRu5Ztns/KvU4Zz2X8wnPYJNx
	 9Hz4sv675X/aEWT/iAeIqa+5ZYk0hgvY78HCj09JEyy+RhzHeff/yYtuvAT1PiC4WJ
	 WYUY8nQfqD1Aw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B0083782042;
	Fri,  5 Jan 2024 18:47:02 +0000 (UTC)
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
Subject: [PATCH v19 12/30] drm/shmem-helper: Prepare drm_gem_shmem_free() to shrinker addition
Date: Fri,  5 Jan 2024 21:46:06 +0300
Message-ID: <20240105184624.508603-13-dmitry.osipenko@collabora.com>
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

Prepare drm_gem_shmem_free() to addition of memory shrinker support
to drm-shmem by adding and using variant of put_pages() that doesn't
touch reservation lock. Reservation shouldn't be touched because lockdep
will trigger a bogus warning about locking contention with fs_reclaim
code paths that can't happen during the time when GEM is freed and
lockdep doesn't know about that.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 40 ++++++++++++++------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 3403700780c3..799a3c5015ad 100644
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
@@ -152,13 +166,12 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 			sg_free_table(shmem->sgt);
 			kfree(shmem->sgt);
 		}
-		if (shmem->pages)
-			drm_gem_shmem_put_pages_locked(shmem);
+		if (shmem->pages &&
+		    refcount_dec_and_test(&shmem->pages_use_count))
+			drm_gem_shmem_free_pages(shmem);
 
 		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
 		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
-
-		dma_resv_unlock(shmem->base.resv);
 	}
 
 	drm_gem_object_release(obj);
@@ -208,21 +221,10 @@ static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
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
2.43.0


