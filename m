Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87641790D06
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344848AbjICRIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344548AbjICRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:08:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B6D110
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:08:46 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F26C660729F;
        Sun,  3 Sep 2023 18:08:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693760925;
        bh=+AikQZciT7OSpx2D1soEKFZvpuAqTt4uGz0mu/TZmic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKhnpdYjng/k1JWea/NPG2sjHP2rZ9h8RlXm09C/98a0X5pY3Qvj2UOyFCWhM2qWd
         60Ui5Dzzn/0jfTQaSxPms97xG9KZ0yE7IhEW6uor+W8DfG9C0bI1bcYEW7W2ecq8qA
         nXLE++xOzvKZc5iH1S6vwCn2lfSVE0ciMjqXjxhpteN9nIeaA0NifvFlzH1P9h27/G
         EaTVOdfqFHyrn0+KKJbv/nNg+8Ayn9S0cR5VffGgAb2Go7L8x7e/9NFVoZUkPLmUv2
         YRJB3BFQloXWOaD/py0NIHZ5fJsMMtRCKtkReDI3CIqEvZFHgu6SRzv8LZWImW+DWw
         6TDDhBhV4xcGw==
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
Subject: [PATCH v16 06/20] drm/virtio: Replace drm_gem_shmem_free() with drm_gem_object_put()
Date:   Sun,  3 Sep 2023 20:07:22 +0300
Message-ID: <20230903170736.513347-7-dmitry.osipenko@collabora.com>
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

Prepare virtio_gpu_object_create() to addition of memory shrinker support
by replacing open-coded drm_gem_shmem_free() with drm_gem_object_put() that
decrements GEM refcount to 0, which becomes important for drm-shmem because
it will start to use GEM's refcount during the shmem's BO freeing time in
order to prevent spurious lockdep warning about resv lock ordering vs
fs_reclaim code paths.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index c7e74cf13022..343b13428125 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -244,6 +244,6 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 err_put_id:
 	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
 err_free_gem:
-	drm_gem_shmem_free(shmem_obj);
+	drm_gem_object_put(&bo->base.base);
 	return ret;
 }
-- 
2.41.0

