Return-Path: <linux-kernel+bounces-134777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512889B6BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819F71C20E34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF10F567F;
	Mon,  8 Apr 2024 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlUUvuE6"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CAA1D540
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549540; cv=none; b=VvjMqw90u3fAh48ujpv5aDbQc92oR8e5bNFx5547YvYsOlnSKGHHiGnooW/gnhtEyT2ShPVlWRJ6cEBc/Ivt97VE+UVjVM3CL7uCuNp+bhKs/Fnl5nDSMVK/uDmObImMetedUiIHLpob29ZKB+CbIMH3g83lXkJOZ1s6Wq8Y7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549540; c=relaxed/simple;
	bh=Id1MZoVrSSM3hObMgDp0MUvlPMjMRmawf9jxYCMg/d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6M4E8Cjm3e4wsqHC2PxTKXQJg2LkRNDRegX6MP8FPMN5513VDPbKaT7rGHlvHfsNPrItcZk5wItGOlr0oYpLl06DMunlY3HlGKNHu6PL1xCo+17Ye9xg0macvyGEJ/D/GDHo4T6oSjdRdFMy3U4dlVb8LiVucawbAdb0WAV4Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlUUvuE6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dc949f998fso2662747a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 21:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712549538; x=1713154338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SjsV4HsSTItvj/ELiLD1hTF0cgJwLOFyNGElV0Kd8Z8=;
        b=RlUUvuE6y9GWdfqb4gqP4H6cH59V0FcBSjkJHAnN0emHKne6u6yUYjCoc5WjUkB6E/
         s3ynRcuYZ2mWa2Gf1889dBxphII9jddkDpZxHSHr85F/KKJbyB/BJBm3S6Ro/mpzwcMF
         QTj5FWpNxFGcRCBjUMLE6iiH3K3TMD0Yv3pdxlRT37akhwNKcpNQZGed5cX6KNABgjnu
         ztjBc83uun3x+w6sQWluDpR8al8LCpxhn0HMH1EH63SlO/Zmrgq+76qSUdG8mRizOmaO
         c/6BbVHAc6gxLBdI5JS/ONjRxFgLj6NFD5a37AOQoo9SzCYLNaM2Fx7jvZhkRJDWQh4R
         tcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712549538; x=1713154338;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SjsV4HsSTItvj/ELiLD1hTF0cgJwLOFyNGElV0Kd8Z8=;
        b=Njp0MZvEnm+RUH+tVwYZSwfDn8DHxhl1fCv+qCh1oRJelTY4ihFMkR/4UGBg0qpgxg
         gv8mvqhk9HIsMs93yjus+Se15+Dra08YxeIgLxGDqRHzgjp8zDP6cMj9v2MFxjIWTLQG
         JSpHS5uLQZUgqDWvbMTqZFDBrDWyOnzSRdMtCmAVuEQ0yW75kNb5tivfT9BadMwoafWj
         48BpdCzfFSLsmetN3IRKF97lv6YQithvJbqA74j5sqiUVjj+z9k8wNYkYXWpNLy/2Sji
         xlnv5q9qKfHm2KWKLk6XTv45fa5AbThxbeI9ep8hxUlj4Jwiz6QgaPsa/hh2kxWCafAU
         aqRA==
X-Forwarded-Encrypted: i=1; AJvYcCXSfEWafjJeNCl3lJtij2nFmItK7vV1+W/mgdvFJ+SuFA72h3/FY9X15qpnoHO0M2Gt+4APnux8pcHkmD0uwPO5j7sfyrdCVeDGFNfP
X-Gm-Message-State: AOJu0Yy1WYpMb+ZwB8MYRc8OoogcyZQWb9b2YN35fRr8/hwKQ0lou+8C
	Emgt6+MjSx4iJ5zB6NqgKFbmPWLwCF05kyy9hpYpdD1vG6+xC8Ml
X-Google-Smtp-Source: AGHT+IEj4y4ne2ojXfNRa+AYfBs5hBPbD1UVM1VUfINpDFwALspJKDqHWO1VwvTTYi56XGeWrvjrIg==
X-Received: by 2002:a17:903:246:b0:1e2:6b80:95b0 with SMTP id j6-20020a170903024600b001e26b8095b0mr7483729plh.6.1712549537683;
        Sun, 07 Apr 2024 21:12:17 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001e3f0cde2desm2474666ple.253.2024.04.07.21.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 21:12:17 -0700 (PDT)
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
Subject: [PATCH 2/2] iommu/dma: Fix zero'ing of bounce buffer padding used by untrusted devices
Date: Sun,  7 Apr 2024 21:11:42 -0700
Message-Id: <20240408041142.665563-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408041142.665563-1-mhklinux@outlook.com>
References: <20240408041142.665563-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

iommu_dma_map_page() allocates swiotlb memory as a bounce buffer when
an untrusted device wants to map only part of the memory in an
granule. The goal is to disallow the untrusted device having
DMA access to unrelated kernel data that may be sharing the granule.
To meet this goal, the bounce buffer itself is zero'ed, and any
additional swiotlb memory up to alloc_size after the bounce buffer
end (i.e., "post-padding") is also zero'ed.

However, as of commit 901c7280ca0d ("Reinstate some of "swiotlb: rework
"fix info leak with DMA_FROM_DEVICE"""), swiotlb_tbl_map_single()
always initializes the contents of the bounce buffer to the original
memory. Zero'ing the bounce buffer is redundant and probably wrong per
the discussion in that commit. Only the post-padding needs to be
zero'ed.

Also, when the DMA min_align_mask is non-zero, the allocated bounce
buffer space may not start on a granule boundary. The swiotlb memory
from the granule boundary to the start of the allocated bounce buffer
might belong to some unrelated bounce buffer. So as described in the
"second issue" in [1], it can't be zero'ed to protect against untrusted
devices. But as of commit XXXXXXXXXXXX ("swiotlb: extend buffer
pre-padding to alloc_align_mask if necessary"), swiotlb_tbl_map_single()
allocates pre-padding slots when necessary to meet min_align_mask
requirements, making it possible to zero the pre-padding area as well.

Finally, iommu_dma_map_page() uses the swiotlb for untrusted devices
and also for certain kmalloc() memory. Current code does the zero'ing
for both cases, but it is needed only for the untrusted device case.

Fix all of this by updating iommu_dma_map_page() to zero both the
pre-padding and post-padding areas, but not the actual bounce buffer.
Do this only in the case where the bounce buffer is used because
of an untrusted device.

[1] https://lore.kernel.org/all/20210929023300.335969-1-stevensd@google.com/

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
I've wondered if this code for zero'ing the pre- and post-padding
should go in swiotlb_tbl_map_single(). The bounce buffer proper is
already being initialized there. But swiotlb_tbl_map_single()
would need to test for an untrusted device (or have a "zero the
padding" flag passed in as part of the "attrs" argument), which
adds complexity. Thoughts?

The commit ID of Petr's patch is X'ed out above because Petr's patch
hasn't gone into Linus' tree yet. We can add the real commit ID once
this patch is ready to go in.

Also I've haven't used any "Fixes:" tags. This patch really should
be backported only if all the other recent swiotlb fixes get
backported, and I'm unclear on whether that will happen.

 drivers/iommu/dma-iommu.c | 29 ++++++++++++++++-------------
 include/linux/iova.h      |  5 +++++
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c21ef1388499..ecac39b3190d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1154,9 +1154,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 */
 	if (dev_use_swiotlb(dev, size, dir) &&
 	    iova_offset(iovad, phys | size)) {
-		void *padding_start;
-		size_t padding_size, aligned_size;
-
 		if (!is_swiotlb_active(dev)) {
 			dev_warn_once(dev, "DMA bounce buffers are inactive, unable to map unaligned transaction.\n");
 			return DMA_MAPPING_ERROR;
@@ -1164,24 +1161,30 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 
 		trace_swiotlb_bounced(dev, phys, size);
 
-		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size,
 					      iova_mask(iovad), dir, attrs);
 
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
 
-		/* Cleanup the padding area. */
-		padding_start = phys_to_virt(phys);
-		padding_size = aligned_size;
+		/*
+		 * Untrusted devices should not see padding areas with random
+		 * leftover kernel data, so zero the pre- and post-padding.
+		 * swiotlb_tbl_map_single() has initialized the bounce buffer
+		 * proper to the contents of the original memory buffer.
+		 */
+		if (dev_is_untrusted(dev)) {
+			size_t start, virt = (size_t)phys_to_virt(phys);
 
-		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-		    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
-			padding_start += size;
-			padding_size -= size;
-		}
+			/* Pre-padding */
+			start = iova_align_down(iovad, virt);
+			memset((void *)start, 0, virt - start);
 
-		memset(padding_start, 0, padding_size);
+			/* Post-padding */
+			start = virt + size;
+			memset((void *)start, 0,
+			       iova_align(iovad, start) - start);
+		}
 	}
 
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 83c00fac2acb..d2c4fd923efa 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -65,6 +65,11 @@ static inline size_t iova_align(struct iova_domain *iovad, size_t size)
 	return ALIGN(size, iovad->granule);
 }
 
+static inline size_t iova_align_down(struct iova_domain *iovad, size_t size)
+{
+	return ALIGN_DOWN(size, iovad->granule);
+}
+
 static inline dma_addr_t iova_dma_addr(struct iova_domain *iovad, struct iova *iova)
 {
 	return (dma_addr_t)iova->pfn_lo << iova_shift(iovad);
-- 
2.25.1


