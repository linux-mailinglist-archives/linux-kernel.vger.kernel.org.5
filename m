Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6557DB0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjJ2XJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjJ2XJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:09:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5585465BC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:03:56 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 298FC6607388;
        Sun, 29 Oct 2023 23:02:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620555;
        bh=kRBcrLAj4D2pvg6jvqHxVmGBnWprZUgp4H9azTfbRYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIcrT91R2KsnfqEJqrzr/8g5XvCiRTG15pQZrSdsY7CjrthMuTV7UzFCNftZBg1Kx
         BzICvJKEVCKLmItWaM3WtIcqVa7F6dbGZfLe6jAAXWpiMWZl1i3+1O8K+Ype8kWrOz
         R6zoBWI0WE2fxtmAVZ/QiFlmaqzr3yxhekXoIplfhC5oEQOTfVjZM1pgxrDQuYi+ca
         Htl/XMDw1kRYVtEv8jT3+GblNjOo069yvUlg0ld4ec99SHby87w0OznehkfMW/UDZJ
         et6pZ+ZDDBdzgezCpqkps5G+ApbO/NCPzb3BWIF5c+spZLGgtYOyxzsUNDY8//cQkK
         io8K/I6piPBhA==
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
Subject: [PATCH v18 06/26] drm/shmem-helper: Add and use pages_pin_count
Date:   Mon, 30 Oct 2023 02:01:45 +0300
Message-ID: <20231029230205.93277-7-dmitry.osipenko@collabora.com>
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

Add separate pages_pin_count for tracking of whether drm-shmem pages are
moveable or not. With the addition of memory shrinker support to drm-shmem,
the pages_use_count will no longer determine whether pages are hard-pinned
in memory, but whether pages exist and are soft-pinned (and could be swapped
out). The pages_pin_count > 1 will hard-pin pages in memory.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 25 +++++++++++++++++--------
 include/drm/drm_gem_shmem_helper.h     | 11 +++++++++++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 2cc0601865f6..b9b71a1a563a 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -156,6 +156,7 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 			drm_gem_shmem_put_pages_locked(shmem);
 
 		drm_WARN_ON(obj->dev, shmem->pages_use_count);
+		drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
 
 		dma_resv_unlock(shmem->base.resv);
 	}
@@ -234,18 +235,16 @@ static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 
 	dma_resv_assert_held(shmem->base.resv);
 
+	if (refcount_inc_not_zero(&shmem->pages_pin_count))
+		return 0;
+
 	ret = drm_gem_shmem_get_pages_locked(shmem);
+	if (!ret)
+		refcount_set(&shmem->pages_pin_count, 1);
 
 	return ret;
 }
 
-static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
-{
-	dma_resv_assert_held(shmem->base.resv);
-
-	drm_gem_shmem_put_pages_locked(shmem);
-}
-
 /**
  * drm_gem_shmem_pin - Pin backing pages for a shmem GEM object
  * @shmem: shmem GEM object
@@ -263,6 +262,9 @@ int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem)
 
 	drm_WARN_ON(obj->dev, obj->import_attach);
 
+	if (refcount_inc_not_zero(&shmem->pages_pin_count))
+		return 0;
+
 	ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
 	if (ret)
 		return ret;
@@ -286,8 +288,14 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
 
 	drm_WARN_ON(obj->dev, obj->import_attach);
 
+	if (refcount_dec_not_one(&shmem->pages_pin_count))
+		return;
+
 	dma_resv_lock(shmem->base.resv, NULL);
-	drm_gem_shmem_unpin_locked(shmem);
+
+	if (refcount_dec_and_test(&shmem->pages_pin_count))
+		drm_gem_shmem_put_pages_locked(shmem);
+
 	dma_resv_unlock(shmem->base.resv);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_unpin);
@@ -632,6 +640,7 @@ void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 	if (shmem->base.import_attach)
 		return;
 
+	drm_printf_indent(p, indent, "pages_pin_count=%u\n", refcount_read(&shmem->pages_pin_count));
 	drm_printf_indent(p, indent, "pages_use_count=%u\n", shmem->pages_use_count);
 	drm_printf_indent(p, indent, "vmap_use_count=%u\n", shmem->vmap_use_count);
 	drm_printf_indent(p, indent, "vaddr=%p\n", shmem->vaddr);
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 6ee4a4046980..5088bd623518 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -39,6 +39,17 @@ struct drm_gem_shmem_object {
 	 */
 	unsigned int pages_use_count;
 
+	/**
+	 * @pages_pin_count:
+	 *
+	 * Reference count on the pinned pages table.
+	 *
+	 * Pages are hard-pinned and reside in memory if count
+	 * greater than zero. Otherwise, when count is zero, the pages are
+	 * allowed to be evicted and purged by memory shrinker.
+	 */
+	refcount_t pages_pin_count;
+
 	/**
 	 * @madv: State for madvise
 	 *
-- 
2.41.0

