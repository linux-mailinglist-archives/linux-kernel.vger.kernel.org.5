Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B147DB0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjJ2XTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjJ2XTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:19:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290257AAA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:04:29 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C9B4D66073B5;
        Sun, 29 Oct 2023 23:02:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698620581;
        bh=9VDunboaNrQ0+alNzN87bJVPZTdu5GVJOSm1S5JwyL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhh/+dHtFNOZ+FbvkdBKZRTxqXNMGYB7HkZwXtTbvcOiloCDHK7FbKeKTYwRCJC5S
         DQfQ6yHaC9lXwa6bGT4FhqyI+LQWsa/O+PeOu/rbg1E3HdbDE8J8yafWKuXulU0kWV
         lX6AMEVMrKRxlXq9yfrIL3l7PN4T7kmFILpa8zRxz4Zq10QI1+v1jhWYOv75Vzq9Zd
         a0jrgWPsBfFpb8HeBjnl/JUhcssreG88iBdoAfi7WZalN1kVkdNi2HjdEAFEadTAXn
         J6TnaCgG+AR2jrUVVoF4lQkvcx/uRJ9M4ZH31cipraN5MwmtG+wwvXknrCeY6sZr7w
         YSqW/hqKf40kQ==
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
Subject: [PATCH v18 23/26] drm/virtio: Pin display framebuffer BO
Date:   Mon, 30 Oct 2023 02:02:02 +0300
Message-ID: <20231029230205.93277-24-dmitry.osipenko@collabora.com>
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

Prepare to addition of memory shrinker support by pinning display
framebuffer BO pages in memory while they are in use by display on host.
Shrinker is free to relocate framebuffer BO pages if it doesn't know that
pages are in use, thus pin the pages to disallow shrinker to move them.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 19 +++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 17 +++++++++++++++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 96365a772f77..56269814fb6d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -313,6 +313,8 @@ void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_put_free_delayed(struct virtio_gpu_device *vgdev,
 				       struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_put_free_work(struct work_struct *work);
+int virtio_gpu_gem_pin(struct virtio_gpu_object *bo);
+void virtio_gpu_gem_unpin(struct virtio_gpu_object *bo);
 
 /* virtgpu_vq.c */
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 7db48d17ee3a..625c05d625bf 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -294,3 +294,22 @@ void virtio_gpu_array_put_free_work(struct work_struct *work)
 	}
 	spin_unlock(&vgdev->obj_free_lock);
 }
+
+int virtio_gpu_gem_pin(struct virtio_gpu_object *bo)
+{
+	int err;
+
+	if (virtio_gpu_is_shmem(bo)) {
+		err = drm_gem_shmem_pin(&bo->base);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+void virtio_gpu_gem_unpin(struct virtio_gpu_object *bo)
+{
+	if (virtio_gpu_is_shmem(bo))
+		drm_gem_shmem_unpin(&bo->base);
+}
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a000..def57b01a826 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -238,20 +238,28 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_framebuffer *vgfb;
 	struct virtio_gpu_object *bo;
+	int err;
 
 	if (!new_state->fb)
 		return 0;
 
 	vgfb = to_virtio_gpu_framebuffer(new_state->fb);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
-	if (!bo || (plane->type == DRM_PLANE_TYPE_PRIMARY && !bo->guest_blob))
+
+	err = virtio_gpu_gem_pin(bo);
+	if (err)
+		return err;
+
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY && !bo->guest_blob)
 		return 0;
 
 	if (bo->dumb && (plane->state->fb != new_state->fb)) {
 		vgfb->fence = virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context,
 						     0);
-		if (!vgfb->fence)
+		if (!vgfb->fence) {
+			virtio_gpu_gem_unpin(bo);
 			return -ENOMEM;
+		}
 	}
 
 	return 0;
@@ -261,15 +269,20 @@ static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
 					struct drm_plane_state *state)
 {
 	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_object *bo;
 
 	if (!state->fb)
 		return;
 
 	vgfb = to_virtio_gpu_framebuffer(state->fb);
+	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
+
 	if (vgfb->fence) {
 		dma_fence_put(&vgfb->fence->f);
 		vgfb->fence = NULL;
 	}
+
+	virtio_gpu_gem_unpin(bo);
 }
 
 static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
-- 
2.41.0

