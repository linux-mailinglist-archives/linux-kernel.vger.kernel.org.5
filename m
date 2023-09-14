Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB63F7A11C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjINX3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjINX3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:29:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2722717
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:29:15 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 88FB26607355;
        Fri, 15 Sep 2023 00:29:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694734153;
        bh=NYBZUXkwlnba9uS/DTRAc0OWLbbAgnC6TGMpLFWWzHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FESwGYWauB9XDkampwVrtcAARQwz/q5ArfDM/gjc0/eFIbRZwrm4BYzrX3SgAI+HI
         atAeblijs3Ca98BkeNuNUOffwt/bEamEQe1/wIexmpdLLnAT0caUrQTLsvqqaY5ToO
         1wqoAuTIaJNGvI6aaizAgZlQ/ySdvIyAVAeXQHIQyBDZuuneLDG5Cfliy5HfuNHoyp
         ii2C3suH9aYRQzcaovq2tM30/et7ypoUW/mlATxK+K246U1ORytwv7fXr4dX9c0kKW
         JXHKK1tl5pceKSI7Gq5D4Uq57b5qkak0+uTuTYqBDHm1qUpf9poFbvjOj3CxvzoPej
         XYjNeuM7cIWNg==
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
Subject: [PATCH v17 11/18] drm/shmem-helper: Improve drm_gem_shmem_vmap_locked() error handling
Date:   Fri, 15 Sep 2023 02:27:14 +0300
Message-ID: <20230914232721.408581-12-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove error unwinding from drm_gem_shmem_vmap_locked() making error
paths consistent for both dmabuf and non-dmabuf cases and improving
readability of the code. Often it's preferred to do the explicit error
unwinding, but this multi-path function is an exception.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e1fcb5154209..8a8eab4d0332 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -334,7 +334,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 			      struct iosys_map *map)
 {
 	struct drm_gem_object *obj = &shmem->base;
-	int ret = 0;
+	int ret;
 
 	if (obj->import_attach) {
 		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
@@ -357,6 +357,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 		shmem->vaddr = vmap(shmem->pages, obj->size >> PAGE_SHIFT,
 				    VM_MAP, prot);
 		if (!shmem->vaddr) {
+			drm_gem_shmem_unpin_locked(shmem);
 			ret = -ENOMEM;
 		} else {
 			iosys_map_set_vaddr(map, shmem->vaddr);
@@ -364,16 +365,8 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 		}
 	}
 
-	if (ret) {
+	if (ret)
 		drm_dbg_kms(obj->dev, "Failed to vmap pages, error %d\n", ret);
-		goto err_put_pages;
-	}
-
-	return 0;
-
-err_put_pages:
-	if (!obj->import_attach)
-		drm_gem_shmem_unpin_locked(shmem);
 
 	return ret;
 }
-- 
2.41.0

