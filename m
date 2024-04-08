Return-Path: <linux-kernel+bounces-134776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFDB89B6BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4AD1F21435
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04C25680;
	Mon,  8 Apr 2024 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgN0fl4x"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C01CAAC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549539; cv=none; b=b3tsylYpDr+3MbxaZlWbdO+SZBFs91mvFLq2MRuV1ZrxrcZ80ZjVpRMhdsoauxsET5MW4xCTAtsxkLNr0qGp+Q7tLdLapk5jOiMR+pFSzlYDW/zqfWf7QnAOQzv/LCyE1HgEy1b0aw7SnKN0Nbq34JTUH52Uq9Wp9SDUsQrRgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549539; c=relaxed/simple;
	bh=OVTO7Zslu5D6nkoFCb675ngPBEtipPv4ybdfltH69Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IfrhAqNdMJ8Rlt7gSWcrcCY4HBUIXXMCOH/VJejVLcSUc/qxDed8/g1Rip7dSqhKkHNzqmVZTwX6sPee/f/aVnQWYpE4IaREF4QQUEh4qPjUda/5XOrUfXO/Rr9QNbdhsUWh5fVPV+fet8tA88OfshPBOx8NFfSe3UO39mxkq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgN0fl4x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0bec01232so31814815ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 21:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712549536; x=1713154336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMSQhLrDPilrzUC346KcRMtXyNYWEOyJ6WX8+UinkkA=;
        b=MgN0fl4xKk370dgzy+LnhoK+rUqkmEVIqdwrQIWOY/7n+4hS9cFEgD2nvbgg4DAnvN
         aUJ1te+/UDi7XmD20uc+m65atS2Jzo6ow/XuTfGa00ZsgoCtcowsf57EyM3LDeL6DY2k
         s4TaDi4K/XiqfHksfKOWNKvofeU8SB0g4PLGlELhenKGwzbhYBhNI1fFkC54RiVH8w2I
         zyUGJudw4HrONwGZ9GCh5GS5EQ7GpMwkmUbQl9LR0ir/i3u68l2dmBUpLR/LRgI8gtar
         mz5tWb+dYB7erNAvG3UksaOt6a8tPbevVJaVEKctWvIYuMHR/bbKtt2wtgZGOqdzuSYl
         WdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712549536; x=1713154336;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMSQhLrDPilrzUC346KcRMtXyNYWEOyJ6WX8+UinkkA=;
        b=m8VMwnodCRjnhAwdeQSLljrQa84yEYiXgHLFAI6Lpu8AiYG66oKxv6I3wlVZ7Ra8lD
         nY/y5mySzOIBMIQ+sgQwpcB2kY/f2BAtu5rmboBVBXHKIiQOUoCNMUnIRmFdoLUbaYXj
         LNoNXgzUbyvYQwPXphl4NKT693CedutSN6I4qHFEknyJQDB+QJUi0yVNO7VAbnLreQDz
         qdRi/wgl+OM4uUn+/VR/RnJXOTfa0Thu8LmaKfcpHYks2O7/BoFIEJoydougG+60uN18
         lpGtQAx7ua2zHC124Z/SvP+ziu1m9zDzKea+IQIwVvNytCPulqaYtWWmewUHJcfgH6ad
         CkDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaQFKtvC5pcoylpypV0g+TwXL8N4caIbTR3UkF+WHhTdyPNC4HQ6z0yxyMHOOfHe5BCWDxM6bVyMrQPwAHS64xH5yepOy1P6TKvgVQ
X-Gm-Message-State: AOJu0YxpkMAJy2YrOPPG2qIbLuGMlpCv7T4NY1OhVySWQH/niyfuzxcX
	OUqSyylAyvSCp/rW7eWkT2wvhERrahFsvn2Km4+UIiLm8HjrdBVVHbqezSdJ
X-Google-Smtp-Source: AGHT+IGJ2H/R5OdFFo2sWuPhTY0GzQYPe7tpoRBe4DrZ/4S9V3guChofxwL81b6WIsmX5otyZzTeOw==
X-Received: by 2002:a17:903:1ce:b0:1e4:4a3f:9a88 with SMTP id e14-20020a17090301ce00b001e44a3f9a88mr488986plh.46.1712549536492;
        Sun, 07 Apr 2024 21:12:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001e3f0cde2desm2474666ple.253.2024.04.07.21.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 21:12:16 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Subject: [PATCH 1/2] swiotlb: Remove alloc_size argument to swiotlb_tbl_map_single()
Date: Sun,  7 Apr 2024 21:11:41 -0700
Message-Id: <20240408041142.665563-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Currently swiotlb_tbl_map_single() takes alloc_align_mask and
alloc_size arguments to specify an swiotlb allocation that is
larger than mapping_size. This larger allocation is used solely
by iommu_dma_map_single() to handle untrusted devices that should
not have DMA visibility to memory pages that are partially used
for unrelated kernel data.

Having two arguments to specify the allocation is redundant. While
alloc_align_mask naturally specifies the alignment of the starting
address of the allocation, it can also implicitly specify the size
by rounding up the mapping_size to that alignment.

Additionally, the current approach has an edge case bug.
iommu_dma_map_page() already does the rounding up to compute the
alloc_size argument. But swiotlb_tbl_map_single() then calculates
the alignment offset based on the DMA min_align_mask, and adds
that offset to alloc_size. If the offset is non-zero, the addition
may result in a value that is larger than the max the swiotlb can
allocate. If the rounding up is done _after_ the alignment offset is
added to the mapping_size (and the original mapping_size conforms to
the value returned by swiotlb_max_mapping_size), then the max that the
swiotlb can allocate will not be exceeded.

In view of these issues, simplify the swiotlb_tbl_map_single() interface
by removing the alloc_size argument. Most call sites pass the same
value for mapping_size and alloc_size, and they pass alloc_align_mask
as zero. Just remove the redundant argument from these callers, as they
will see no functional change. For iommu_dma_map_page() also remove
the alloc_size argument, and have swiotlb_tbl_map_single() compute
the alloc_size by rounding up mapping_size after adding the offset
based on min_align_mask. This has the side effect of fixing the
edge case bug but with no other functional change.

Also add a sanity test on the alloc_align_mask. While IOMMU code
currently ensures the granule is not larger than PAGE_SIZE, if
that guarantee were to be removed in the future, the downstream
effect on the swiotlb might go unnoticed until strange allocation
failures occurred.

Tested on an ARM64 system with 16K page size and some kernel
test-only hackery to allow modifying the DMA min_align_mask and
the granule size that becomes the alloc_align_mask. Tested these
combinations with a variety of original memory addresses and
sizes, including those that reproduce the edge case bug:

* 4K granule and 0 min_align_mask
* 4K granule and 0xFFF min_align_mask (4K - 1)
* 16K granule and 0xFFF min_align_mask
* 64K granule and 0xFFF min_align_mask
* 64K granule and 0x3FFF min_align_mask (16K - 1)

With the changes, all combinations pass.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
I've haven't used any "Fixes:" tags. This patch really should be
backported only if all the other recent swiotlb fixes get backported,
and I'm unclear on whether that will happen.

I saw the brief discussion about removing the "dir" parameter from
swiotlb_tbl_map_single(). That removal could easily be done as part
of this patch, since it's already changing the swiotlb_tbl_map_single()
parameters. But I think the conclusion of the discussion was to leave
the "dir" parameter for symmetry with the swiotlb_sync_*() functions.
Please correct me if that's wrong, and I'll respin this patch to do
the removal.

 drivers/iommu/dma-iommu.c |  2 +-
 drivers/xen/swiotlb-xen.c |  2 +-
 include/linux/swiotlb.h   |  2 +-
 kernel/dma/swiotlb.c      | 56 +++++++++++++++++++++++++++++----------
 4 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 07d087eecc17..c21ef1388499 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1165,7 +1165,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		trace_swiotlb_bounced(dev, phys, size);
 
 		aligned_size = iova_align(iovad, size);
-		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
+		phys = swiotlb_tbl_map_single(dev, phys, size,
 					      iova_mask(iovad), dir, attrs);
 
 		if (phys == DMA_MAPPING_ERROR)
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 1c4ef5111651..6579ae3f6dac 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -216,7 +216,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	trace_swiotlb_bounced(dev, dev_addr, size);
 
-	map = swiotlb_tbl_map_single(dev, phys, size, size, 0, dir, attrs);
+	map = swiotlb_tbl_map_single(dev, phys, size, 0, dir, attrs);
 	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index ea23097e351f..14bc10c1bb23 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -43,7 +43,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 extern void __init swiotlb_update_mem_attributes(void);
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
-		size_t mapping_size, size_t alloc_size,
+		size_t mapping_size,
 		unsigned int alloc_aligned_mask, enum dma_data_direction dir,
 		unsigned long attrs);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a5e0dfc44d24..046da973a7e2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1340,15 +1340,40 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
 
 #endif /* CONFIG_DEBUG_FS */
 
+/**
+ * swiotlb_tbl_map_single() - bounce buffer map a single contiguous physical area
+ * @dev:		Device which maps the buffer.
+ * @orig_addr:		Original (non-bounced) physical IO buffer address
+ * @mapping_size:	Requested size of the actual bounce buffer, excluding
+ *			any pre- or post-padding for alignment
+ * @alloc_align_mask:	Required start and end alignment of the allocated buffer
+ * @dir:		DMA direction
+ * @attrs:		Optional DMA attributes for the map operation
+ *
+ * Find and allocate a suitable sequence of IO TLB slots for the request.
+ * The allocated space starts at an alignment specified by alloc_align_mask,
+ * and the size of the allocated space is rounded up so that the total amount
+ * of allocated space is a multiple of (alloc_align_mask + 1). If
+ * alloc_align_mask is zero, the allocated space may be at any alignment and
+ * the size is not rounded up.
+ *
+ * The returned address is within the allocated space and matches the bits
+ * of orig_addr that are specified in the DMA min_align_mask for the device. As
+ * such, this returned address may be offset from the beginning of the allocated
+ * space. The bounce buffer space starting at the returned address for
+ * mapping_size bytes is initialized to the contents of the original IO buffer
+ * area. Any pre-padding (due to an offset) and any post-padding (due to
+ * rounding-up the size) is not initialized.
+ */
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
-		size_t mapping_size, size_t alloc_size,
-		unsigned int alloc_align_mask, enum dma_data_direction dir,
-		unsigned long attrs)
+		size_t mapping_size, unsigned int alloc_align_mask,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned int offset;
 	struct io_tlb_pool *pool;
 	unsigned int i;
+	size_t size;
 	int index;
 	phys_addr_t tlb_addr;
 	unsigned short pad_slots;
@@ -1362,20 +1387,24 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
-	if (mapping_size > alloc_size) {
-		dev_warn_once(dev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
-			      mapping_size, alloc_size);
-		return (phys_addr_t)DMA_MAPPING_ERROR;
-	}
+	/*
+	 * The default swiotlb memory pool is allocated with PAGE_SIZE
+	 * alignment. If a mapping is requested with larger alignment,
+	 * the mapping may be unable to use the initial slot(s) in all
+	 * sets of IO_TLB_SEGSIZE slots. In such case, a mapping request
+	 * of or near the maximum mapping size would always fail.
+	 */
+	dev_WARN_ONCE(dev, alloc_align_mask > ~PAGE_MASK,
+		"Alloc alignment may prevent fulfilling requests with max mapping_size\n");
 
 	offset = swiotlb_align_offset(dev, alloc_align_mask, orig_addr);
-	index = swiotlb_find_slots(dev, orig_addr,
-				   alloc_size + offset, alloc_align_mask, &pool);
+	size = ALIGN(mapping_size + offset, alloc_align_mask + 1);
+	index = swiotlb_find_slots(dev, orig_addr, size, alloc_align_mask, &pool);
 	if (index == -1) {
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
 	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-				 alloc_size, mem->nslabs, mem_used(mem));
+				 size, mem->nslabs, mem_used(mem));
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
@@ -1388,7 +1417,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	offset &= (IO_TLB_SIZE - 1);
 	index += pad_slots;
 	pool->slots[index].pad_slots = pad_slots;
-	for (i = 0; i < nr_slots(alloc_size + offset); i++)
+	for (i = 0; i < (nr_slots(size) - pad_slots); i++)
 		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
 	tlb_addr = slot_addr(pool->start, index) + offset;
 	/*
@@ -1543,8 +1572,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
 
-	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, 0, dir,
-			attrs);
+	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
-- 
2.25.1


