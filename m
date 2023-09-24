Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB27AC845
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjIXNPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIXNPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:15:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC629103;
        Sun, 24 Sep 2023 06:15:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61D9C433C8;
        Sun, 24 Sep 2023 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561340;
        bh=8DYGUGem+TUaWfokUKRqaH7U17xkWPnjb2uqmMrbhZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/9xpYMFXjNN1mW3fe5KmDAua52687fsGp0r48P+vUosDnVfIuH2rCABr/JahXHkq
         vFhu0BiBeIdVfmRUSMw3xGHJ/oFi441XfycAsO+ouE2dh2xSM93tfcQ0c8Og2lXW7O
         PRGIRl3pQ4GmsHvu4aJP6KCd0b1AP2xAu0TFEWOIgfvd/q3bm2KwX17BzHqcf0Nnh+
         zrbC23AQ2Hm56TETqi6lJMK2rIDOqaA8wnsl3CYPceJ5P2wEio7HUVh4sIrqSbGUYy
         0rFZQr3ddUDm4QeTUc+3fMIEiXpHTHH1iIHUOmZL0HnedIWveL/O47lIn2hyeOeeXT
         u0NmFTEU13WKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com, linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 04/41] parisc: ccio-dma: Fix sparse warnings
Date:   Sun, 24 Sep 2023 09:14:52 -0400
Message-Id: <20230924131529.1275335-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit 9a47a710cf517801a8b4fff9949c4cecb5fd019a ]

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/parisc/ccio-dma.c      | 18 +++++++++---------
 drivers/parisc/iommu-helpers.h |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 10e846286f4ef..623707fc6ff1c 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -222,7 +222,7 @@ struct ioa_registers {
 struct ioc {
 	struct ioa_registers __iomem *ioc_regs;  /* I/O MMU base address */
 	u8  *res_map;	                /* resource map, bit == pdir entry */
-	u64 *pdir_base;	                /* physical base address */
+	__le64 *pdir_base;		/* physical base address */
 	u32 pdir_size;			/* bytes, function of IOV Space size */
 	u32 res_hint;			/* next available IOVP -
 					   circular search */
@@ -347,7 +347,7 @@ ccio_alloc_range(struct ioc *ioc, struct device *dev, size_t size)
 	BUG_ON(pages_needed == 0);
 	BUG_ON((pages_needed * IOVP_SIZE) > DMA_CHUNK_SIZE);
 
-	DBG_RES("%s() size: %d pages_needed %d\n",
+	DBG_RES("%s() size: %zu pages_needed %d\n",
 			__func__, size, pages_needed);
 
 	/*
@@ -435,7 +435,7 @@ ccio_free_range(struct ioc *ioc, dma_addr_t iova, unsigned long pages_mapped)
 	BUG_ON((pages_mapped * IOVP_SIZE) > DMA_CHUNK_SIZE);
 	BUG_ON(pages_mapped > BITS_PER_LONG);
 
-	DBG_RES("%s():  res_idx: %d pages_mapped %d\n", 
+	DBG_RES("%s():  res_idx: %d pages_mapped %lu\n",
 		__func__, res_idx, pages_mapped);
 
 #ifdef CCIO_COLLECT_STATS
@@ -551,7 +551,7 @@ static u32 hint_lookup[] = {
  * index are bits 12:19 of the value returned by LCI.
  */ 
 static void
-ccio_io_pdir_entry(u64 *pdir_ptr, space_t sid, unsigned long vba,
+ccio_io_pdir_entry(__le64 *pdir_ptr, space_t sid, unsigned long vba,
 		   unsigned long hints)
 {
 	register unsigned long pa;
@@ -727,7 +727,7 @@ ccio_map_single(struct device *dev, void *addr, size_t size,
 	unsigned long flags;
 	dma_addr_t iovp;
 	dma_addr_t offset;
-	u64 *pdir_start;
+	__le64 *pdir_start;
 	unsigned long hint = hint_lookup[(int)direction];
 
 	BUG_ON(!dev);
@@ -754,8 +754,8 @@ ccio_map_single(struct device *dev, void *addr, size_t size,
 
 	pdir_start = &(ioc->pdir_base[idx]);
 
-	DBG_RUN("%s() 0x%p -> 0x%lx size: %0x%x\n",
-		__func__, addr, (long)iovp | offset, size);
+	DBG_RUN("%s() %px -> %#lx size: %zu\n",
+		__func__, addr, (long)(iovp | offset), size);
 
 	/* If not cacheline aligned, force SAFE_DMA on the whole mess */
 	if((size % L1_CACHE_BYTES) || ((unsigned long)addr % L1_CACHE_BYTES))
@@ -813,7 +813,7 @@ ccio_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
 		return;
 	}
 
-	DBG_RUN("%s() iovp 0x%lx/%x\n",
+	DBG_RUN("%s() iovp %#lx/%zx\n",
 		__func__, (long)iova, size);
 
 	iova ^= offset;        /* clear offset bits */
@@ -1291,7 +1291,7 @@ ccio_ioc_init(struct ioc *ioc)
 			iova_space_size>>20,
 			iov_order + PAGE_SHIFT);
 
-	ioc->pdir_base = (u64 *)__get_free_pages(GFP_KERNEL, 
+	ioc->pdir_base = (__le64 *)__get_free_pages(GFP_KERNEL,
 						 get_order(ioc->pdir_size));
 	if(NULL == ioc->pdir_base) {
 		panic("%s() could not allocate I/O Page Table\n", __func__);
diff --git a/drivers/parisc/iommu-helpers.h b/drivers/parisc/iommu-helpers.h
index a00c38b6224ab..c43f1a212a5c8 100644
--- a/drivers/parisc/iommu-helpers.h
+++ b/drivers/parisc/iommu-helpers.h
@@ -31,8 +31,8 @@ iommu_fill_pdir(struct ioc *ioc, struct scatterlist *startsg, int nents,
 		unsigned long vaddr;
 		long size;
 
-		DBG_RUN_SG(" %d : %08lx/%05x %p/%05x\n", nents,
-			   (unsigned long)sg_dma_address(startsg), cnt,
+		DBG_RUN_SG(" %d : %08lx %p/%05x\n", nents,
+			   (unsigned long)sg_dma_address(startsg),
 			   sg_virt(startsg), startsg->length
 		);
 
-- 
2.40.1

