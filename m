Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B886380B10B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574945AbjLIAdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574901AbjLIAdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:33:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89572171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:33:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA5C433D9;
        Sat,  9 Dec 2023 00:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702081994;
        bh=ZYf+SCCklojL+rFQDuhNnAEcg+CE/5aqIBLmY3otw/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E/vlLFAN63TLonVDuzgDM/iQrbez8wI6/Zy/OM28cmmkKLejjX3Hgub1eIodNE8Nt
         VUoKweM7KEzMjq07ZPZUVTyx+pZbYmuIki/5nD/X8wCm/u1SQGe8fzgHb3xeGQ8lwd
         b9gtujc7R3OcqqJc8d1Zua2EE33qqKUmbbHx80d465DurOFC5RnosZNQ0I91EzM8uZ
         1jZ0OyEtlf1cSQV5YT7o8v/6X+WyuAD0K1JRDd75zV796MNYET5lLD7fik9qZCVATU
         tbw8VKMeHCPECDlxWzOtSQXIhimcWZ/M7lnXTSjZ9pA59ZXmle+FHvFjjAqfJIbsit
         q8f4D9GUFlSbQ==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Pavel.Kozlov@synopsys.com,
        Vineet Gupta <vgupta@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/5] ARC: mm: retire support for aliasing VIPT D$
Date:   Fri,  8 Dec 2023 16:33:05 -0800
Message-Id: <20231209003307.480051-4-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209003307.480051-1-vgupta@kernel.org>
References: <20231209003307.480051-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy ARC700 processors (first generation of MMU enabled ARC cores) had
VIPT cached which could be configured such that they could alias.
Corresponding support in kernel (with all the obnoxious cache flush overhead)
was added in ARC port 10 years ago to support 1 silicon. That is long bygone
and we can let it RIP.

Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig                  |   5 --
 arch/arc/include/asm/cacheflush.h |  43 ----------
 arch/arc/mm/cache.c               | 136 ++----------------------------
 arch/arc/mm/mmap.c                |  21 +----
 arch/arc/mm/tlb.c                 |  16 ++--
 5 files changed, 14 insertions(+), 207 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 3162db540ee9..1b0483c51cc1 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -49,7 +49,6 @@ config ARC
 	select OF
 	select OF_EARLY_FLATTREE
 	select PCI_SYSCALL if PCI
-	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
 	select HAVE_ARCH_JUMP_LABEL if ISA_ARCV2 && !CPU_ENDIAN_BE32
 	select TRACE_IRQFLAGS_SUPPORT
 
@@ -232,10 +231,6 @@ config ARC_CACHE_PAGES
 	  Note that Global I/D ENABLE + Per Page DISABLE works but corollary
 	  Global DISABLE + Per Page ENABLE won't work
 
-config ARC_CACHE_VIPT_ALIASING
-	bool "Support VIPT Aliasing D$"
-	depends on ARC_HAS_DCACHE && ISA_ARCOMPACT
-
 endif #ARC_CACHE
 
 config ARC_HAS_ICCM
diff --git a/arch/arc/include/asm/cacheflush.h b/arch/arc/include/asm/cacheflush.h
index bd5b1a9a0544..563af3e75f01 100644
--- a/arch/arc/include/asm/cacheflush.h
+++ b/arch/arc/include/asm/cacheflush.h
@@ -44,31 +44,10 @@ void dma_cache_wback(phys_addr_t start, unsigned long sz);
 
 #define flush_cache_dup_mm(mm)			/* called on fork (VIVT only) */
 
-#ifndef CONFIG_ARC_CACHE_VIPT_ALIASING
-
 #define flush_cache_mm(mm)			/* called on munmap/exit */
 #define flush_cache_range(mm, u_vstart, u_vend)
 #define flush_cache_page(vma, u_vaddr, pfn)	/* PF handling/COW-break */
 
-#else	/* VIPT aliasing dcache */
-
-/* To clear out stale userspace mappings */
-void flush_cache_mm(struct mm_struct *mm);
-void flush_cache_range(struct vm_area_struct *vma,
-	unsigned long start,unsigned long end);
-void flush_cache_page(struct vm_area_struct *vma,
-	unsigned long user_addr, unsigned long page);
-
-/*
- * To make sure that userspace mapping is flushed to memory before
- * get_user_pages() uses a kernel mapping to access the page
- */
-#define ARCH_HAS_FLUSH_ANON_PAGE
-void flush_anon_page(struct vm_area_struct *vma,
-	struct page *page, unsigned long u_vaddr);
-
-#endif	/* CONFIG_ARC_CACHE_VIPT_ALIASING */
-
 /*
  * A new pagecache page has PG_arch_1 clear - thus dcache dirty by default
  * This works around some PIO based drivers which don't call flush_dcache_page
@@ -76,28 +55,6 @@ void flush_anon_page(struct vm_area_struct *vma,
  */
 #define PG_dc_clean	PG_arch_1
 
-#define CACHE_COLORS_NUM	4
-#define CACHE_COLORS_MSK	(CACHE_COLORS_NUM - 1)
-#define CACHE_COLOR(addr)	(((unsigned long)(addr) >> (PAGE_SHIFT)) & CACHE_COLORS_MSK)
-
-/*
- * Simple wrapper over config option
- * Bootup code ensures that hardware matches kernel configuration
- */
-static inline int cache_is_vipt_aliasing(void)
-{
-	return IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);
-}
-
-/*
- * checks if two addresses (after page aligning) index into same cache set
- */
-#define addr_not_cache_congruent(addr1, addr2)				\
-({									\
-	cache_is_vipt_aliasing() ? 					\
-		(CACHE_COLOR(addr1) != CACHE_COLOR(addr2)) : 0;		\
-})
-
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)		\
 do {									\
 	memcpy(dst, src, len);						\
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index f7e05c146637..9106ceac323c 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -145,10 +145,9 @@ int arc_cache_mumbojumbo(int c, char *buf, int len)
 	p_dc->sz_k = 1 << (dbcr.sz - 1);
 
 	n += scnprintf(buf + n, len - n,
-			"D-Cache\t\t: %uK, %dway/set, %uB Line, %s%s%s\n",
+			"D-Cache\t\t: %uK, %dway/set, %uB Line, %s%s\n",
 			p_dc->sz_k, assoc, p_dc->line_len,
 			vipt ? "VIPT" : "PIPT",
-			p_dc->colors > 1 ? " aliasing" : "",
 			IS_USED_CFG(CONFIG_ARC_HAS_DCACHE));
 
 slc_chk:
@@ -703,51 +702,10 @@ static inline void arc_slc_enable(void)
  * Exported APIs
  */
 
-/*
- * Handle cache congruency of kernel and userspace mappings of page when kernel
- * writes-to/reads-from
- *
- * The idea is to defer flushing of kernel mapping after a WRITE, possible if:
- *  -dcache is NOT aliasing, hence any U/K-mappings of page are congruent
- *  -U-mapping doesn't exist yet for page (finalised in update_mmu_cache)
- *  -In SMP, if hardware caches are coherent
- *
- * There's a corollary case, where kernel READs from a userspace mapped page.
- * If the U-mapping is not congruent to K-mapping, former needs flushing.
- */
 void flush_dcache_folio(struct folio *folio)
 {
-	struct address_space *mapping;
-
-	if (!cache_is_vipt_aliasing()) {
-		clear_bit(PG_dc_clean, &folio->flags);
-		return;
-	}
-
-	/* don't handle anon pages here */
-	mapping = folio_flush_mapping(folio);
-	if (!mapping)
-		return;
-
-	/*
-	 * pagecache page, file not yet mapped to userspace
-	 * Make a note that K-mapping is dirty
-	 */
-	if (!mapping_mapped(mapping)) {
-		clear_bit(PG_dc_clean, &folio->flags);
-	} else if (folio_mapped(folio)) {
-		/* kernel reading from page with U-mapping */
-		phys_addr_t paddr = (unsigned long)folio_address(folio);
-		unsigned long vaddr = folio_pos(folio);
-
-		/*
-		 * vaddr is not actually the virtual address, but is
-		 * congruent to every user mapping.
-		 */
-		if (addr_not_cache_congruent(paddr, vaddr))
-			__flush_dcache_pages(paddr, vaddr,
-						folio_nr_pages(folio));
-	}
+	clear_bit(PG_dc_clean, &folio->flags);
+	return;
 }
 EXPORT_SYMBOL(flush_dcache_folio);
 
@@ -921,44 +879,6 @@ noinline void flush_cache_all(void)
 
 }
 
-#ifdef CONFIG_ARC_CACHE_VIPT_ALIASING
-
-void flush_cache_mm(struct mm_struct *mm)
-{
-	flush_cache_all();
-}
-
-void flush_cache_page(struct vm_area_struct *vma, unsigned long u_vaddr,
-		      unsigned long pfn)
-{
-	phys_addr_t paddr = pfn << PAGE_SHIFT;
-
-	u_vaddr &= PAGE_MASK;
-
-	__flush_dcache_pages(paddr, u_vaddr, 1);
-
-	if (vma->vm_flags & VM_EXEC)
-		__inv_icache_pages(paddr, u_vaddr, 1);
-}
-
-void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
-		       unsigned long end)
-{
-	flush_cache_all();
-}
-
-void flush_anon_page(struct vm_area_struct *vma, struct page *page,
-		     unsigned long u_vaddr)
-{
-	/* TBD: do we really need to clear the kernel mapping */
-	__flush_dcache_pages((phys_addr_t)page_address(page), u_vaddr, 1);
-	__flush_dcache_pages((phys_addr_t)page_address(page),
-			    (phys_addr_t)page_address(page), 1);
-
-}
-
-#endif
-
 void copy_user_highpage(struct page *to, struct page *from,
 	unsigned long u_vaddr, struct vm_area_struct *vma)
 {
@@ -966,46 +886,11 @@ void copy_user_highpage(struct page *to, struct page *from,
 	struct folio *dst = page_folio(to);
 	void *kfrom = kmap_atomic(from);
 	void *kto = kmap_atomic(to);
-	int clean_src_k_mappings = 0;
-
-	/*
-	 * If SRC page was already mapped in userspace AND it's U-mapping is
-	 * not congruent with K-mapping, sync former to physical page so that
-	 * K-mapping in memcpy below, sees the right data
-	 *
-	 * Note that while @u_vaddr refers to DST page's userspace vaddr, it is
-	 * equally valid for SRC page as well
-	 *
-	 * For !VIPT cache, all of this gets compiled out as
-	 * addr_not_cache_congruent() is 0
-	 */
-	if (page_mapcount(from) && addr_not_cache_congruent(kfrom, u_vaddr)) {
-		__flush_dcache_pages((unsigned long)kfrom, u_vaddr, 1);
-		clean_src_k_mappings = 1;
-	}
 
 	copy_page(kto, kfrom);
 
-	/*
-	 * Mark DST page K-mapping as dirty for a later finalization by
-	 * update_mmu_cache(). Although the finalization could have been done
-	 * here as well (given that both vaddr/paddr are available).
-	 * But update_mmu_cache() already has code to do that for other
-	 * non copied user pages (e.g. read faults which wire in pagecache page
-	 * directly).
-	 */
 	clear_bit(PG_dc_clean, &dst->flags);
-
-	/*
-	 * if SRC was already usermapped and non-congruent to kernel mapping
-	 * sync the kernel mapping back to physical page
-	 */
-	if (clean_src_k_mappings) {
-		__flush_dcache_pages((unsigned long)kfrom,
-					(unsigned long)kfrom, 1);
-	} else {
-		clear_bit(PG_dc_clean, &src->flags);
-	}
+	clear_bit(PG_dc_clean, &src->flags);
 
 	kunmap_atomic(kto);
 	kunmap_atomic(kfrom);
@@ -1140,17 +1025,8 @@ static noinline void __init arc_cache_init_master(void)
 			      dc->line_len, L1_CACHE_BYTES);
 
 		/* check for D-Cache aliasing on ARCompact: ARCv2 has PIPT */
-		if (is_isa_arcompact()) {
-			int handled = IS_ENABLED(CONFIG_ARC_CACHE_VIPT_ALIASING);
-
-			if (dc->colors > 1) {
-				if (!handled)
-					panic("Enable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
-				if (CACHE_COLORS_NUM != dc->colors)
-					panic("CACHE_COLORS_NUM not optimized for config\n");
-			} else if (handled && dc->colors == 1) {
-				panic("Disable CONFIG_ARC_CACHE_VIPT_ALIASING\n");
-			}
+		if (is_isa_arcompact() && dc->colors > 1) {
+			panic("Aliasing VIPT cache not supported\n");
 		}
 	}
 
diff --git a/arch/arc/mm/mmap.c b/arch/arc/mm/mmap.c
index fce5fa2b4f52..3c1c7ae73292 100644
--- a/arch/arc/mm/mmap.c
+++ b/arch/arc/mm/mmap.c
@@ -14,10 +14,6 @@
 
 #include <asm/cacheflush.h>
 
-#define COLOUR_ALIGN(addr, pgoff)			\
-	((((addr) + SHMLBA - 1) & ~(SHMLBA - 1)) +	\
-	 (((pgoff) << PAGE_SHIFT) & (SHMLBA - 1)))
-
 /*
  * Ensure that shared mappings are correctly aligned to
  * avoid aliasing issues with VIPT caches.
@@ -31,21 +27,13 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	int do_align = 0;
-	int aliasing = cache_is_vipt_aliasing();
 	struct vm_unmapped_area_info info;
 
-	/*
-	 * We only need to do colour alignment if D cache aliases.
-	 */
-	if (aliasing)
-		do_align = filp || (flags & MAP_SHARED);
-
 	/*
 	 * We enforce the MAP_FIXED case.
 	 */
 	if (flags & MAP_FIXED) {
-		if (aliasing && flags & MAP_SHARED &&
+		if (flags & MAP_SHARED &&
 		    (addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1))
 			return -EINVAL;
 		return addr;
@@ -55,10 +43,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		return -ENOMEM;
 
 	if (addr) {
-		if (do_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
+		addr = PAGE_ALIGN(addr);
 
 		vma = find_vma(mm, addr);
 		if (TASK_SIZE - len >= addr &&
@@ -70,7 +55,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
-	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
+	info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index e536b2dcd4b0..ad702b49aeb3 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -478,21 +478,15 @@ void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
 
 	create_tlb(vma, vaddr, ptep);
 
-	if (page == ZERO_PAGE(0)) {
+	if (page == ZERO_PAGE(0))
 		return;
-	}
 
 	/*
-	 * Exec page : Independent of aliasing/page-color considerations,
-	 *	       since icache doesn't snoop dcache on ARC, any dirty
-	 *	       K-mapping of a code page needs to be wback+inv so that
-	 *	       icache fetch by userspace sees code correctly.
-	 * !EXEC page: If K-mapping is NOT congruent to U-mapping, flush it
-	 *	       so userspace sees the right data.
-	 *  (Avoids the flush for Non-exec + congruent mapping case)
+	 * For executable pages, since icache doesn't snoop dcache, any
+	 * dirty K-mapping of a code page needs to be wback+inv so that
+	 * icache fetch by userspace sees code correctly.
 	 */
-	if ((vma->vm_flags & VM_EXEC) ||
-	     addr_not_cache_congruent(paddr, vaddr)) {
+	if (vma->vm_flags & VM_EXEC) {
 		struct folio *folio = page_folio(page);
 		int dirty = !test_and_set_bit(PG_dc_clean, &folio->flags);
 		if (dirty) {
-- 
2.34.1

