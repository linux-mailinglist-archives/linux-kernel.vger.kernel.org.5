Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1A7A11BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjINX30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjINX3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:29:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4B2729
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:29:10 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5255D6607354;
        Fri, 15 Sep 2023 00:29:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694734149;
        bh=Ux87TxMV5vy/PWBLrg20A7F+FmVwQrERrTwLmwymf+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcNyh7i8Q+Xk31Yh4mvNe9RQ4U/F+y1VwR034qHizz3ONttTiuRyiEKmvUpWZH/tB
         zlY6BqCDg4cyoR2LVRmGC5eI5eYOr2G4GwiRDy2AwOMHW4gQdMTsHYul43o5n69uyt
         fwdUxkb8A2tTiHV+zgnAQAMVUfFmgsWDUFM3XCNAJXEbZ3ILZk7FCqENJcZYJ4TFoI
         5/FWIwUP62pc8RdyYKcOR+DYsMcYjmhioyhqLYC7RxQ4IMBPgnrET6ZWcuL8NSY+bV
         ZRdnphvYM8fsa4vfISnkzGSie0FzJFUxwec3tPFFH7EwpMjt1aBD2hlg0ysDYFBIuR
         bhxcBMYxk9Ptg==
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
Subject: [PATCH v17 08/18] drm/shmem-helper: Add and use lockless drm_gem_shmem_get_pages()
Date:   Fri, 15 Sep 2023 02:27:11 +0300
Message-ID: <20230914232721.408581-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
lock if pages_use_count is non-zero, leveraging from atomicity of the
refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e9d9fbd52b34..a5964f347dda 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -225,6 +225,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
 
+static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
+{
+	int ret;
+
+	if (refcount_inc_not_zero(&shmem->pages_use_count))
+		return 0;
+
+	dma_resv_lock(shmem->base.resv, NULL);
+	ret = drm_gem_shmem_get_pages_locked(shmem);
+	dma_resv_unlock(shmem->base.resv);
+
+	return ret;
+}
+
 static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 {
 	int ret;
@@ -608,10 +622,7 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 		return ret;
 	}
 
-	dma_resv_lock(shmem->base.resv, NULL);
-	ret = drm_gem_shmem_get_pages_locked(shmem);
-	dma_resv_unlock(shmem->base.resv);
-
+	ret = drm_gem_shmem_get_pages(shmem);
 	if (ret)
 		return ret;
 
-- 
2.41.0

