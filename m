Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07587864B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbjHXBg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbjHXBg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:36:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A3610F2;
        Wed, 23 Aug 2023 18:36:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5EF536607272;
        Thu, 24 Aug 2023 02:36:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692840980;
        bh=GUXvdyR6u3Xe6oaqA/WtFkOugeqKUkkyoFDijY6U+8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+fzzt0MqDOAUXOKFl4MwiQCSs8owdjOV7Mxo43xwn4YvkqmC6tBO4lKY5pi97spz
         Vo17Q/bHg5E8peRiB9Yqs4/wpRrSNUmbhmBb6+JwF06a5YMDiMg4tvEzuuUad6uHNO
         7zw+bncpEf5lPYTv/yla5k/gxu44xdCRWepb5FyHTjDXtbWTdnfypWqnofm3jy7oox
         t3CCM1v9HS1mZc4z6mjzEdEZsMdR0AiH+2ppExvymIByoxh2DLgxRKbWFZMFLCOxHk
         y+S2+yhrDn9bVukI4Upuq8lBCUaEAYCwKpM7A1AJhCBz4/WF6/dA2b3KiicwlIA11S
         ji8XJerdJkyVg==
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
        kernel@collabora.com
Subject: [PATCH v2 5/6] drm/panfrost: Implement generic DRM object RSS reporting function
Date:   Thu, 24 Aug 2023 02:34:48 +0100
Message-ID: <20230824013604.466224-6-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824013604.466224-1-adrian.larumbe@collabora.com>
References: <20230824013604.466224-1-adrian.larumbe@collabora.com>
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

BO's RSS is updated every time new pages are allocated and mapped for the
object, either in its entirety at creation time for non-heap buffers, or
else on demand for heap buffers at GPU page fault's IRQ handler.

Same calculations had to be done for imported PRIME objects, since backing
storage for it might have already been allocated by the exporting driver.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.h |  5 +++++
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 16 +++++++++++-----
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index aea16b0e4dda..c6bd1f16a6d4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -206,6 +206,17 @@ static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_object *obj
 
 	return res;
 }
+
+size_t panfrost_gem_rss(struct drm_gem_object *obj)
+{
+	struct panfrost_gem_object *bo = to_panfrost_bo(obj);
+
+	if (!bo->base.pages)
+		return 0;
+
+	return bo->rss_size;
+}
+
 static const struct drm_gem_object_funcs panfrost_gem_funcs = {
 	.free = panfrost_gem_free_object,
 	.open = panfrost_gem_open,
@@ -218,6 +229,7 @@ static const struct drm_gem_object_funcs panfrost_gem_funcs = {
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = drm_gem_shmem_object_mmap,
 	.status = panfrost_gem_status,
+	.rss = panfrost_gem_rss,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
@@ -274,13 +286,23 @@ panfrost_gem_prime_import_sg_table(struct drm_device *dev,
 {
 	struct drm_gem_object *obj;
 	struct panfrost_gem_object *bo;
+	struct scatterlist *sgl;
+	unsigned int count;
+	size_t total = 0;
 
 	obj = drm_gem_shmem_prime_import_sg_table(dev, attach, sgt);
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 
+	for_each_sgtable_dma_sg(sgt, sgl, count) {
+		size_t len = sg_dma_len(sgl);
+
+		total += len;
+	}
+
 	bo = to_panfrost_bo(obj);
 	bo->noexec = true;
+	bo->rss_size = total;
 
 	return obj;
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
index e06f7ceb8f73..e2a7c46403c7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
@@ -36,6 +36,11 @@ struct panfrost_gem_object {
 	 */
 	atomic_t gpu_usecount;
 
+	/*
+	 * Object chunk size currently mapped onto physical memory
+	 */
+	size_t rss_size;
+
 	bool noexec		:1;
 	bool is_heap		:1;
 	bool is_purgable	:1;
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index c0123d09f699..e03a5a9da06f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -285,17 +285,19 @@ static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
 	pm_runtime_put_autosuspend(pfdev->dev);
 }
 
-static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
+static size_t mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 		      u64 iova, int prot, struct sg_table *sgt)
 {
 	unsigned int count;
 	struct scatterlist *sgl;
 	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
 	u64 start_iova = iova;
+	size_t total = 0;
 
 	for_each_sgtable_dma_sg(sgt, sgl, count) {
 		unsigned long paddr = sg_dma_address(sgl);
 		size_t len = sg_dma_len(sgl);
+		total += len;
 
 		dev_dbg(pfdev->dev, "map: as=%d, iova=%llx, paddr=%lx, len=%zx", mmu->as, iova, paddr, len);
 
@@ -315,7 +317,7 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 
 	panfrost_mmu_flush_range(pfdev, mmu, start_iova, iova - start_iova);
 
-	return 0;
+	return total;
 }
 
 int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
@@ -326,6 +328,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
 	struct sg_table *sgt;
 	int prot = IOMMU_READ | IOMMU_WRITE;
+	size_t mapped_size;
 
 	if (WARN_ON(mapping->active))
 		return 0;
@@ -337,9 +340,10 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	if (WARN_ON(IS_ERR(sgt)))
 		return PTR_ERR(sgt);
 
-	mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
+	mapped_size = mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
 		   prot, sgt);
 	mapping->active = true;
+	bo->rss_size += mapped_size;
 
 	return 0;
 }
@@ -447,6 +451,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	pgoff_t page_offset;
 	struct sg_table *sgt;
 	struct page **pages;
+	size_t mapped_size;
 
 	bomapping = addr_to_mapping(pfdev, as, addr);
 	if (!bomapping)
@@ -518,10 +523,11 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	if (ret)
 		goto err_map;
 
-	mmu_map_sg(pfdev, bomapping->mmu, addr,
-		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
+	mapped_size = mmu_map_sg(pfdev, bomapping->mmu, addr,
+				 IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
 
 	bomapping->active = true;
+	bo->rss_size += mapped_size;
 
 	dev_dbg(pfdev->dev, "mapped page fault @ AS%d %llx", as, addr);
 
-- 
2.42.0

