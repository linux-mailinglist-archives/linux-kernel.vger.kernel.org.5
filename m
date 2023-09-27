Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7737B0E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjI0Vb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjI0Vbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:31:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4A511D;
        Wed, 27 Sep 2023 14:31:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C1AC660731C;
        Wed, 27 Sep 2023 22:31:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695850303;
        bh=CB6ICECbKTTeSKPhCGXQhQWGMbw/5Maak1ypn1Cqkv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LotmHznXzELi5lHQTvfdQR+qqvop2dNtz0zuuZQj5vgyx1D11Y8KuMZvqILjmmnkA
         fial6mqUq3qPxleuqNE6iSiJjlpvNnR+hVnbREEQ03BTU6RJDtIuadyIrMwpWHJ5w2
         hUV4c5P98RKWTyVsSmilUMiRF4w95LDfiHP+jPVLh0nK9/W8zeKXq+UhuLOhjWsB+M
         bT1KzAkzjxyfBnR9Cj1I3zBQllBYg/GPA1AJEvy7TKBqft3By8NC4/TqXJLSUS4pZs
         Qhh6b3PSzFxwkgOO1bArMNoe5X77MamURj7aIfrN6VcM97jwd9u+g2RbNGy3HqV6Mm
         E1MbyiVIQHM8A==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     adrian.larumbe@collabora.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com, tvrtko.ursulin@linux.intel.com,
        boris.brezillon@collabora.com
Subject: [PATCH v7 5/5] drm/panfrost: Implement generic DRM object RSS reporting function
Date:   Wed, 27 Sep 2023 22:29:59 +0100
Message-ID: <20230927213133.1651169-6-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927213133.1651169-1-adrian.larumbe@collabora.com>
References: <20230927213133.1651169-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BO's RSS is updated every time new pages are allocated on demand and mapped
for the object at GPU page fault's IRQ handler, but only for heap buffers.
The reason this is unnecessary for non-heap buffers is that they are mapped
onto the GPU's VA space and backed by physical memory in their entirety at
BO creation time.

This calculation is unnecessary for imported PRIME objects, since heap
buffers cannot be exported by our driver, and the actual BO RSS size is the
one reported in its attached dmabuf structure.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 15 +++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.h |  5 +++++
 drivers/gpu/drm/panfrost/panfrost_mmu.c |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 7d8f83d20539..4365434b48db 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -208,6 +208,20 @@ static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj
 	return res;
 }
 
+static size_t panfrost_gem_rss(struct drm_gem_object *obj)
+{
+	struct panfrost_gem_object *bo = to_panfrost_bo(obj);
+
+	if (bo->is_heap) {
+		return bo->heap_rss_size;
+	} else if (bo->base.pages) {
+		WARN_ON(bo->heap_rss_size);
+		return bo->base.base.size;
+	} else {
+		return 0;
+	}
+}
+
 static const struct drm_gem_object_funcs panfrost_gem_funcs = {
 	.free = panfrost_gem_free_object,
 	.open = panfrost_gem_open,
@@ -220,6 +234,7 @@ static const struct drm_gem_object_funcs panfrost_gem_funcs = {
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = drm_gem_shmem_object_mmap,
 	.status = panfrost_gem_status,
+	.rss = panfrost_gem_rss,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
index ad2877eeeccd..13c0a8149c3a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
@@ -36,6 +36,11 @@ struct panfrost_gem_object {
 	 */
 	atomic_t gpu_usecount;
 
+	/*
+	 * Object chunk size currently mapped onto physical memory
+	 */
+	size_t heap_rss_size;
+
 	bool noexec		:1;
 	bool is_heap		:1;
 };
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index d54d4e7b2195..846dd697c410 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -522,6 +522,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
 
 	bomapping->active = true;
+	bo->heap_rss_size += SZ_2M;
 
 	dev_dbg(pfdev->dev, "mapped page fault @ AS%d %llx", as, addr);
 
-- 
2.42.0

