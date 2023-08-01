Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD98D76A8FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjHAG0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjHAG0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:26:41 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F431BF5;
        Mon, 31 Jul 2023 23:26:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFPwR437Bz9xHvs;
        Tue,  1 Aug 2023 14:15:03 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.220.249])
        by APP1 (Coremail) with SMTP id LxC2BwCHOroapchkgAwYAA--.27948S5;
        Tue, 01 Aug 2023 07:25:39 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR ARM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        iommu@lists.linux.dev (open list:XEN SWIOTLB SUBSYSTEM),
        linux-mm@kvack.org (open list:SLAB ALLOCATOR)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v7 3/9] swiotlb: add documentation and rename swiotlb_do_find_slots()
Date:   Tue,  1 Aug 2023 08:23:58 +0200
Message-Id: <7a92817b18ce0e1bd38967784f53bf76a43cb886.1690871004.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
References: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHOroapchkgAwYAA--.27948S5
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWfGF4UuFy8tF1xZF1kKrg_yoW7ur4rpF
        4rt3Z8tFs8Jr1xC39Fkw48uF1S9w4kK347uFWavryF9rnrJr9agFyktrW5XFyrJFW8uF4U
        Ja4a9r48Gr13Xr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkF7I0En4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8Z2-UUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

Add some kernel-doc comments and move the existing documentation of struct
io_tlb_slot to its correct location. The latter was forgotten in commit
942a8186eb445 ("swiotlb: move struct io_tlb_slot to swiotlb.c").

Use the opportunity to give swiotlb_do_find_slots() a more descriptive name
and make it clear how it differs from swiotlb_find_slots().

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/swiotlb.h | 15 +++++++---
 kernel/dma/swiotlb.c    | 61 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 2d453b3e7771..31625ae507ea 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -76,10 +76,6 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
  *		@end. For default swiotlb, this is command line adjustable via
  *		setup_io_tlb_npages.
- * @list:	The free list describing the number of free entries available
- *		from each index.
- * @orig_addr:	The original address corresponding to a mapped entry.
- * @alloc_size:	Size of the allocated buffer.
  * @debugfs:	The dentry to debugfs.
  * @late_alloc:	%true if allocated using the page allocator
  * @force_bounce: %true if swiotlb bouncing is forced
@@ -111,6 +107,17 @@ struct io_tlb_mem {
 #endif
 };
 
+/**
+ * is_swiotlb_buffer() - check if a physical address belongs to a swiotlb
+ * @dev:        Device which has mapped the buffer.
+ * @paddr:      Physical address within the DMA buffer.
+ *
+ * Check if @paddr points into a bounce buffer.
+ *
+ * Return:
+ * * %true if @paddr points into a bounce buffer
+ * * %false otherwise
+ */
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0840bc15fb53..66793b59c290 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -62,6 +62,13 @@
 
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 
+/**
+ * struct io_tlb_slot - IO TLB slot descriptor
+ * @orig_addr:	The original address corresponding to a mapped entry.
+ * @alloc_size:	Size of the allocated buffer.
+ * @list:	The free list describing the number of free entries available
+ *		from each index.
+ */
 struct io_tlb_slot {
 	phys_addr_t orig_addr;
 	size_t alloc_size;
@@ -635,11 +642,22 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
 }
 #endif /* CONFIG_DEBUG_FS */
 
-/*
- * Find a suitable number of IO TLB entries size that will fit this request and
- * allocate a buffer from that IO TLB pool.
+/**
+ * swiotlb_area_find_slots() - search for slots in one IO TLB memory area
+ * @dev:	Device which maps the buffer.
+ * @area_index:	Index of the IO TLB memory area to be searched.
+ * @orig_addr:	Original (non-bounced) IO buffer address.
+ * @alloc_size: Total requested size of the bounce buffer,
+ *		including initial alignment padding.
+ * @alloc_align_mask:	Required alignment of the allocated buffer.
+ *
+ * Find a suitable sequence of IO TLB entries for the request and allocate
+ * a buffer from the given IO TLB memory area.
+ * This function takes care of locking.
+ *
+ * Return: Index of the first allocated slot, or -1 on error.
  */
-static int swiotlb_do_find_slots(struct device *dev, int area_index,
+static int swiotlb_area_find_slots(struct device *dev, int area_index,
 		phys_addr_t orig_addr, size_t alloc_size,
 		unsigned int alloc_align_mask)
 {
@@ -734,6 +752,19 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
 	return slot_index;
 }
 
+/**
+ * swiotlb_find_slots() - search for slots in the whole swiotlb
+ * @dev:	Device which maps the buffer.
+ * @orig_addr:	Original (non-bounced) IO buffer address.
+ * @alloc_size: Total requested size of the bounce buffer,
+ *		including initial alignment padding.
+ * @alloc_align_mask:	Required alignment of the allocated buffer.
+ *
+ * Search through the whole software IO TLB to find a sequence of slots that
+ * match the allocation constraints.
+ *
+ * Return: Index of the first allocated slot, or -1 on error.
+ */
 static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		size_t alloc_size, unsigned int alloc_align_mask)
 {
@@ -742,8 +773,8 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	int i = start, index;
 
 	do {
-		index = swiotlb_do_find_slots(dev, i, orig_addr, alloc_size,
-					      alloc_align_mask);
+		index = swiotlb_area_find_slots(dev, i, orig_addr, alloc_size,
+						alloc_align_mask);
 		if (index >= 0)
 			return index;
 		if (++i >= mem->nareas)
@@ -755,6 +786,15 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 
 #ifdef CONFIG_DEBUG_FS
 
+/**
+ * mem_used() - get number of used slots in an allocator
+ * @mem:	Software IO TLB allocator.
+ *
+ * The result is accurate in this version of the function, because an atomic
+ * counter is available if CONFIG_DEBUG_FS is set.
+ *
+ * Return: Number of used slots.
+ */
 static unsigned long mem_used(struct io_tlb_mem *mem)
 {
 	return atomic_long_read(&mem->total_used);
@@ -762,6 +802,15 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
 
 #else /* !CONFIG_DEBUG_FS */
 
+/**
+ * mem_used() - get number of used slots in an allocator
+ * @mem:	Software IO TLB allocator.
+ *
+ * The result is not accurate, because there is no locking of individual
+ * areas.
+ *
+ * Return: Approximate number of used slots.
+ */
 static unsigned long mem_used(struct io_tlb_mem *mem)
 {
 	int i;
-- 
2.25.1

