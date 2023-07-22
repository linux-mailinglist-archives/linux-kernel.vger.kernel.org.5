Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EFE75DF60
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGVXxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGVXxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:53:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DBC1BDF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:53:12 -0700 (PDT)
Received: from workpc.. (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C31A866070F8;
        Sun, 23 Jul 2023 00:53:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690069991;
        bh=yf1OxZ1kcw6ZcPDejn11MXN/PmzY4shoXP9IlAqk44Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/ZQNDgkm40lUuYWIhCBmVE3vFSyUK3fDWISOSXcz31lOkRCX9qhC/MUamDPrxU0I
         go+1qUhLFzxhrzlaC81UjL0imtngyyfx9N3fbQ79eYOIik4FG2y9pS03G0/eClg/7c
         4hYIsTrPEUi55N3zYvs9Hj5/WgLTzAtUhPzRbkJJgMDRnZcbChJ9tWUsCiZeOYjNjG
         u9wfeRs3FMZV6KBwG4y+Vo5VpX2UpuzSqnr+9iaHZERNtq1/5lSqpdn8huvOx3NW+K
         BA67qNWKSJd2MRzssjXngjbXysO152dsRboY+PjG+eo4g6593itgELdh7ceoIEgCbc
         7Cvzzk25I/+0g==
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
Subject: [PATCH v14 06/12] drm/shmem-helper: Remove obsoleted is_iomem test
Date:   Sun, 23 Jul 2023 02:47:40 +0300
Message-ID: <20230722234746.205949-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
References: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everything that uses the mapped buffer should by agnostic to is_iomem.
The only reason for the is_iomem test is that we're setting shmem->vaddr
to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
the obsoleted is_iomem test to clean up the code.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 0b6c4f318da5..5aa85242071a 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -431,12 +431,6 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
 
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

