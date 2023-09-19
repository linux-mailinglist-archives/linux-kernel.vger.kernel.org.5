Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0847A6F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjISXg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjISXgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:36:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D289C0;
        Tue, 19 Sep 2023 16:36:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7D4B566071A3;
        Wed, 20 Sep 2023 00:36:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695166566;
        bh=D8FJsJmU8pGFx+LOiGoEx6ey1t/Dq5oamCR5JeST1eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCYqfPyetEQv6KYvkVIOrIdkxnPy2Hcc2l9PSOFksuwp59HyGtjFay7IV5ca4jjGY
         JGFH5A0wMriM+Ew5F3IZXMpjTDtDFrobT4KwMs34gy9LcqaAcjUfEt+KC+JK4je3BT
         bb+tF1+EwCr5G5yh2VH3KEBgOGx80IJsbuQXkzO+UxcB814wKf0YU1dUpXcvyeWOv0
         +d67z+WcaJecv+45WCTmYYK1fm4sHFIijzaPs6pYwo8F1v6xZeI6E4OKCiW0et7obi
         +b0zUzgPl3JqPtXmyx/KMPseKccsOQImlMKkj3k+k2qCSNzm+nk2lgbpBL+ZJlLZ1v
         POf6zVZGikmNQ==
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
        kernel@collabora.com,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v6 5/6] drm/panfrost: Implement generic DRM object RSS reporting function
Date:   Wed, 20 Sep 2023 00:34:53 +0100
Message-ID: <20230919233556.1458793-6-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
References: <20230919233556.1458793-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index d54d4e7b2195..7b1490cdaa48 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -522,6 +522,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
 
 	bomapping->active = true;
+	bo->heap_rss_size += SZ_2;
 
 	dev_dbg(pfdev->dev, "mapped page fault @ AS%d %llx", as, addr);
 
-- 
2.42.0

