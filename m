Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B807F78A0C3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjH0R4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjH0R4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:56:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBAB102
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 10:56:16 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E5DE6607365;
        Sun, 27 Aug 2023 18:56:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693158975;
        bh=RdboBXyGBrh9C432+mMzN0orerGXkbDg2K/MlizItwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbpTgZ1I4DFQocP7yPu4rlmD4C8x2Rid7LuWQWs7LA8KPfHSxjoy7LAvIndsQAKiE
         1EDBi7Tiu1BltLtpmueGnk2uMc0t+ml/zC4JtVdskRWCatlh27ZSL6w+GGlbwFW7+v
         529BKE3f/+tG7BG/+BRHXLi29WC/2Mfob25B7IjugM2AETUPjGO42KfM2F/ndcSg/B
         OoL98Jx2xIELSBS/yd02tX58cetRZbsj04/ZrcwuEtWmlWnv9fyqXkD9xMZup/TOfq
         DcDGOPbZoKRiE/6TK6CKn13K4l5osK+9cEBEX8fr1xSnGuxsPoQAMo9wQ9pWtmfGqs
         3LchkWr/D6AVQ==
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
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v15 14/23] drm/shmem-helper: Add and use lockless drm_gem_shmem_get_pages()
Date:   Sun, 27 Aug 2023 20:54:40 +0300
Message-ID: <20230827175449.1766701-15-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
lock if pages_use_count is non-zero, leveraging from atomicity of the kref
counter. Make drm_gem_shmem_mmap() to utilize the new helper.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 5a2e37b3e51d..f386289c24fc 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -234,6 +234,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
 
+static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
+{
+	int ret;
+
+	if (kref_get_unless_zero(&shmem->pages_use_count))
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
@@ -616,10 +630,7 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
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

