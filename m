Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E175F7DB0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjJ2XTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjJ2XTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:19:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2611E3C25
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:04:19 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5EC9C6607393;
        Sun, 29 Oct 2023 23:02:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620576;
        bh=C6bLQO2M1JgrOXqUoLdrTRyEvFb4mUnAejhijhITpos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwCYSqNLb93JTFlRcJlgindrqbXEZBOKUYuRVjW2+vUf3pQcs3JaNCzWR3bHfkS9e
         YmxOIc2fiL+ei/n0nDzPzU9DVngHBpTSUcwEUvmE24DKYUAsFpoi+5QUmySAvs13NG
         huHNCs7NIwgAMW68EbODX2i6ni//z24rZjSqu3GlvuY/Y14DVBfRrP35QoCNhNEoWh
         XuKt4w03ulVTNcFi4rSoUIHjp5KtE5ZAc7Mrn99jh+suOe4JJ249oHWWMS9HigVYC/
         JtqV+PJQIO1oak0vtAC8b4JaiKz0hTbNd1pkG+NVnpG/bBVvrd4zpdxC5FM6UruXKh
         7iJJ6gsMHlc+A==
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
Subject: [PATCH v18 20/26] drm/shmem-helper: Export drm_gem_shmem_get_pages_sgt_locked()
Date:   Mon, 30 Oct 2023 02:01:59 +0300
Message-ID: <20231029230205.93277-21-dmitry.osipenko@collabora.com>
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

Export drm_gem_shmem_get_pages_sgt_locked() that will be used by virtio-gpu
shrinker during GEM swap-in operation done under the held reservation lock.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 22 +++++++++++++++++++++-
 include/drm/drm_gem_shmem_helper.h     |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 007521bea302..560ce565f376 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -872,12 +872,31 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
 
-static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem)
+/**
+ * drm_gem_shmem_get_pages_sgt_locked - Provide a scatter/gather table of pinned
+ *                                      pages for a shmem GEM object
+ * @shmem: shmem GEM object
+ *
+ * This is a locked version of @drm_gem_shmem_get_sg_table that exports a
+ * scatter/gather table suitable for PRIME usage by calling the standard
+ * DMA mapping API.
+ *
+ * Drivers must hold GEM's reservation lock when using this function.
+ *
+ * Drivers who need to acquire an scatter/gather table for objects need to call
+ * drm_gem_shmem_get_pages_sgt() instead.
+ *
+ * Returns:
+ * A pointer to the scatter/gather table of pinned pages or error pointer on failure.
+ */
+struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 	int ret;
 	struct sg_table *sgt;
 
+	dma_resv_assert_held(shmem->base.resv);
+
 	if (shmem->sgt)
 		return shmem->sgt;
 
@@ -901,6 +920,7 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
 	kfree(sgt);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages_sgt_locked);
 
 /**
  * drm_gem_shmem_get_pages_sgt - Pin pages, dma map them, and return a
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 3bb70616d095..6ac77c2082ed 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -149,6 +149,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem);
 
 struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem);
 struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem);
+struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem);
 
 void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 			      struct drm_printer *p, unsigned int indent);
-- 
2.41.0

