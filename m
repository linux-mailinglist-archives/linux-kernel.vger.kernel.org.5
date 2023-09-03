Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEA1790D02
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbjICRIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjICRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:08:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CF2106
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:08:38 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F115A66071E6;
        Sun,  3 Sep 2023 18:08:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693760917;
        bh=2QMQsm3VuaBAzd2hf1hxEcuNZ98u5n7d6ZnuVfXHKfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhhkhEvoJCogGkvyvWoHKhm+xTpekckfX0h1BUlFSzo2oC+wM13wVgjzpP0K4SZ43
         36WLbDwz7rId3hVhXCJ/44Y09/VIgougM+g15V6Ogjh6fVZSfQtcxFco/S3iqTguJK
         17bE4GUJGx4jvyKfDqk32xVt+DbRAeMA9jX9JFpGvcZTaMmRuqJlDbH1s+UGt+zgzF
         z7pdyckT6jAm00almLgjV+Vp460nuoE1bdJvqcEJzIYauX8ZOLa9FOlgPYKLEDUq7f
         +O+MICMUrNd2+KfEsaHKXV/O96oOPGbm2aP4SC3ZI8M7Kpf+MZOYLRCC0HMfDb4Cp9
         rGJP9xyZtrpAA==
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
Subject: [PATCH v16 01/20] drm/shmem-helper: Fix UAF in error path when freeing SGT of imported GEM
Date:   Sun,  3 Sep 2023 20:07:17 +0300
Message-ID: <20230903170736.513347-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
References: <20230903170736.513347-1-dmitry.osipenko@collabora.com>
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

Freeing drm-shmem GEM right after creating it using
drm_gem_shmem_prime_import_sg_table() frees SGT of the imported dma-buf
and then dma-buf frees this SGT second time.

The v3d_prime_import_sg_table() is example of a error code path where
dma-buf's SGT is freed by drm-shmem and then it's freed second time by
dma_buf_unmap_attachment() in drm_gem_prime_import_dev().

Add drm-shmem GEM flag telling that this is imported SGT shall not be
treated as own SGT, fixing the use-after-free bug.

Cc: stable@vger.kernel.org
Fixes: 2194a63a818d ("drm: Add library for shmem backed GEM objects")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 13 ++++++++++++-
 include/drm/drm_gem_shmem_helper.h     |  7 +++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e435f986cd13..6693d4061ca1 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -141,7 +141,7 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 
 	if (obj->import_attach) {
 		drm_prime_gem_destroy(obj, shmem->sgt);
-	} else {
+	} else if (!shmem->imported_sgt) {
 		dma_resv_lock(shmem->base.resv, NULL);
 
 		drm_WARN_ON(obj->dev, shmem->vmap_use_count);
@@ -765,6 +765,17 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
 
 	shmem->sgt = sgt;
 
+	/*
+	 * drm_gem_shmem_prime_import_sg_table() can be called from a
+	 * driver specific ->import_sg_table() implementations that
+	 * may fail, in that case drm_gem_shmem_free() will be invoked
+	 * without assigned drm_gem_object::import_attach.
+	 *
+	 * This flag lets drm_gem_shmem_free() differentiate whether
+	 * SGT belongs to dmabuf and shall not be freed by drm-shmem.
+	 */
+	shmem->imported_sgt = true;
+
 	drm_dbg_prime(dev, "size = %zu\n", size);
 
 	return &shmem->base;
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index bf0c31aa8fbe..ec70a98a8fe1 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -73,6 +73,13 @@ struct drm_gem_shmem_object {
 	 */
 	unsigned int vmap_use_count;
 
+	/**
+	 * @imported_sgt:
+	 *
+	 * True if SG table belongs to imported dma-buf.
+	 */
+	bool imported_sgt : 1;
+
 	/**
 	 * @pages_mark_dirty_on_put:
 	 *
-- 
2.41.0

