Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB87A11B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjINX3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjINX3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:29:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA70272D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:29:05 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0214B660735A;
        Fri, 15 Sep 2023 00:29:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694734144;
        bh=JEnVqea8F9PfIoRTIpDPPiewdAcM8Ofed+XPNsSrPBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOQ0tsSdceMU7HvEbLQRYMgWqtCnxFl4esHI8AcTbZQR6nDUb6yVJT3pmwfE9UMBL
         4QjPBLGQ6KtJE0L18a568A7vMa41mbN7YmbYtyTaMfWS5X7INMaectSveaJSW1d8x3
         XtC4YiOvvDnevNPy1A/gpuyif/Gys8DGPRbGyzNtIr8M2EuWKLV4bHtdNlTZ1Aga7e
         lPJjQ3SUZaAvGAP4GnVHOgfh41HOsGJypcYAaHWs8R4Byldp27vIImE/msa/mbl9g0
         rLL+vHKezdcO+cF8Owz/V4Ogp3kMw3absJdfypa3yxQLZTLVaYhpo7JbNl9qfuK2aT
         fWjMdZ01NeEZQ==
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
Subject: [PATCH v17 05/18] drm/shmem-helper: Remove obsoleted is_iomem test
Date:   Fri, 15 Sep 2023 02:27:08 +0300
Message-ID: <20230914232721.408581-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
References: <20230914232721.408581-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everything that uses the mapped buffer should be agnostic to is_iomem.
The only reason for the is_iomem test is that we're setting shmem->vaddr
to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
the obsoleted is_iomem test to clean up the code.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 154585ddae08..2cc0601865f6 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -315,12 +315,6 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 
 	if (obj->import_attach) {
 		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
-		if (!ret) {
-			if (drm_WARN_ON(obj->dev, map->is_iomem)) {
-				dma_buf_vunmap(obj->import_attach->dmabuf, map);
-				return -EIO;
-			}
-		}
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
-- 
2.41.0

