Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3CC790D05
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbjICRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344501AbjICRIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:08:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB410D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:08:45 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 90A5966071EB;
        Sun,  3 Sep 2023 18:08:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693760923;
        bh=fRLodgl07tao4BtPSyoT/6xlg7PcCsmg2piBCDZKcAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QtGYq8O0g9C4ZYlxVdjzMixfcWByVNYNQUa22ApGRn5b8LkXa7O/c5kspKXsCBwSw
         s9dk4e3ZDApNNLRCWfGPAwMivujnr0zAyDEpWJDMj/F5HQOE7RaBphONIASDTtcLq+
         NpCM+TBVdp/ZSgJ0nxFEb4aRIEd7jikaRApz7yto3wqJsBjpjog7dmNg6EN395RUVS
         Um1k9oAaosLcAaPbDrV2ZTv8tlDXBhTpOrCX+Xjpcw4TkJTOeeoogJ2x0IOj4DDRUP
         OBDsuykbiQ+xItdm4k3THhDDQbiHkEp0qKPUU/y9u6aqgJaXqMtdln5WAd/QoG4vLZ
         n1qj2VjrFXq/Q==
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
Subject: [PATCH v16 05/20] drm/v3d: Replace open-coded drm_gem_shmem_free() with drm_gem_object_put()
Date:   Sun,  3 Sep 2023 20:07:21 +0300
Message-ID: <20230903170736.513347-6-dmitry.osipenko@collabora.com>
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

The drm_gem_shmem_free() doesn't put GEM's kref to zero, which becomes
important with addition of the shrinker support to drm-shmem that will
use kref=0 in order to prevent taking lock during special GEM-freeing
time in order to avoid spurious lockdep warning about locking ordering
vs fs_reclaim code paths.

Replace open-coded drm_gem_shmem_free() with drm_gem_object_put() that
drops kref to zero before freeing GEM.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 8b3229a37c6d..70c1095d6eec 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -33,16 +33,18 @@ void v3d_free_object(struct drm_gem_object *obj)
 	struct v3d_dev *v3d = to_v3d_dev(obj->dev);
 	struct v3d_bo *bo = to_v3d_bo(obj);
 
-	v3d_mmu_remove_ptes(bo);
+	if (drm_mm_node_allocated(&bo->node)) {
+		v3d_mmu_remove_ptes(bo);
 
-	mutex_lock(&v3d->bo_lock);
-	v3d->bo_stats.num_allocated--;
-	v3d->bo_stats.pages_allocated -= obj->size >> PAGE_SHIFT;
-	mutex_unlock(&v3d->bo_lock);
+		mutex_lock(&v3d->bo_lock);
+		v3d->bo_stats.num_allocated--;
+		v3d->bo_stats.pages_allocated -= obj->size >> PAGE_SHIFT;
+		mutex_unlock(&v3d->bo_lock);
 
-	spin_lock(&v3d->mm_lock);
-	drm_mm_remove_node(&bo->node);
-	spin_unlock(&v3d->mm_lock);
+		spin_lock(&v3d->mm_lock);
+		drm_mm_remove_node(&bo->node);
+		spin_unlock(&v3d->mm_lock);
+	}
 
 	/* GPU execution may have dirtied any pages in the BO. */
 	bo->base.pages_mark_dirty_on_put = true;
@@ -142,7 +144,7 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
 	return bo;
 
 free_obj:
-	drm_gem_shmem_free(shmem_obj);
+	drm_gem_object_put(&shmem_obj->base);
 	return ERR_PTR(ret);
 }
 
@@ -160,7 +162,7 @@ v3d_prime_import_sg_table(struct drm_device *dev,
 
 	ret = v3d_bo_create_finish(obj);
 	if (ret) {
-		drm_gem_shmem_free(&to_v3d_bo(obj)->base);
+		drm_gem_object_put(obj);
 		return ERR_PTR(ret);
 	}
 
-- 
2.41.0

