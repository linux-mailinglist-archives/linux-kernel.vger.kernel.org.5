Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B134B790D1E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbjICRJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbjICRJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:09:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD0F1711
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:08:56 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B46C66072B5;
        Sun,  3 Sep 2023 18:08:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693760934;
        bh=Beunc+mcO9wcz3oaeRK21W7oP8OXFEtJrBh9G3jJNXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISdjD8eE29K3nwkheXywz+1PkycH+ZX+hGqDg9w6Hl0jWQ+vGyjy+G9B+9Q92mrPn
         aVjxBK5qcdKRcU1nIVRi82VydWmhfgkGIjGYMtK6AlUQT2b0ZcctVNI8G5OBjnUgqR
         ynHvQLApwnUsfrAhq5R7t8QU1bnWmvxQbpdmi7qX0+VdTUqsqweem0KPUtIbqReK8h
         dqH/GjVvUa/3GvBgBWEXzBdUJ8rwy5oxERCUbH9UsItVrwcyQ62tvZwDOVDE1ZRXEl
         yz5u2PPB/K6xnvvn4U2PXbuWkhpPMvGSid8CrAdwOWpszUDRf6dt9apK0Lm2vvA1j8
         23ZawegxyzDrA==
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
Subject: [PATCH v16 12/20] drm/shmem-helper: Add and use lockless drm_gem_shmem_get_pages()
Date:   Sun,  3 Sep 2023 20:07:28 +0300
Message-ID: <20230903170736.513347-13-dmitry.osipenko@collabora.com>
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

Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
lock if pages_use_count is non-zero, leveraging from atomicity of the
refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index a0faef3e762d..d93ebfef20c7 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -227,6 +227,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
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
@@ -610,10 +624,7 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
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

