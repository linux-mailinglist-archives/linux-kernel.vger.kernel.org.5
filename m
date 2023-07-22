Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85B975DF5E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGVXxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGVXxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:53:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5ABF2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:53:09 -0700 (PDT)
Received: from workpc.. (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 798A066070FF;
        Sun, 23 Jul 2023 00:53:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690069987;
        bh=cI78CArw4Vx0IB1wLw8Wv/IIOxfsrgAozvoWeW4FeAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfUNIK3Trnj5M+W2sNE167shRJ5shsblykTfIScQN43JeHRvWhjaxJXj10Mf6L+Xb
         6L6y0L+FfLLFN/m+x3urXj/oF0QDjl9NUXZWKOi6aiMqnfdwjqh97WavIvXAtY7j9a
         9FKLHJskxX/IDqrT7R/JeLyXsfbejNevOlfDfW0/guXvSAHD7kldDF81k02IhC5jkK
         Lw535adYEK/Dk5McoXx8cppP/oVtUDr+jO5fwlR2BfqWn8SwduhIWxKTJ9Jzguvf+y
         fTgQQ78hWPNt9XibIw9tHZyR3TaTSFa5M1IyxCoROTZpfVgfWDEgPE4BqQGUNzgv1E
         IF9nDWZQyQlGQ==
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
Subject: [PATCH v14 04/12] drm/shmem-helper: Factor out unpinning part from drm_gem_shmem_purge()
Date:   Sun, 23 Jul 2023 02:47:38 +0300
Message-ID: <20230722234746.205949-5-dmitry.osipenko@collabora.com>
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

Factor out pages unpinning code from drm_gem_shmem_purge() into new
drm_gem_shmem_unpin_pages(). This prepares code for addition of memory
shrinker support. The new common function will be used by shrinker for
eviction of shmem pages.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index c236ad835448..9e381b6dc712 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -485,25 +485,29 @@ int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
 }
 EXPORT_SYMBOL(drm_gem_shmem_madvise);
 
-void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
+static void drm_gem_shmem_unpin_pages(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 	struct drm_device *dev = obj->dev;
 
 	dma_resv_assert_held(shmem->base.resv);
 
-	drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
-
 	dma_unmap_sgtable(dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
+	drm_gem_shmem_release_pages(shmem);
+	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
+
 	sg_free_table(shmem->sgt);
 	kfree(shmem->sgt);
 	shmem->sgt = NULL;
+}
 
-	drm_gem_shmem_put_pages(shmem);
+void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
+{
+	struct drm_gem_object *obj = &shmem->base;
 
-	shmem->madv = -1;
+	drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
 
-	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
+	drm_gem_shmem_unpin_pages(shmem);
 	drm_gem_free_mmap_offset(obj);
 
 	/* Our goal here is to return as much of the memory as
@@ -514,6 +518,8 @@ void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
 	shmem_truncate_range(file_inode(obj->filp), 0, (loff_t)-1);
 
 	invalidate_mapping_pages(file_inode(obj->filp)->i_mapping, 0, (loff_t)-1);
+
+	shmem->madv = -1;
 }
 EXPORT_SYMBOL(drm_gem_shmem_purge);
 
-- 
2.41.0

