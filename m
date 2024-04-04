Return-Path: <linux-kernel+bounces-131625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC01898A31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C7282AF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38719129E9F;
	Thu,  4 Apr 2024 14:33:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15751B964
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241207; cv=none; b=gTZ7g+0tzYqKI+lftC/iFrwAztsegjzW20PGXQS5jk0OAYPoxsHwzXM8+ojmIRs3zV3E4PCi8UttMZcwj8yc8T3HhU/NKKKoIRNyXB2Q7dTvJxiyev4Hgu+bsn1DKanyMxgtBBu10q77Ng8dOABiHM67Rw6OzjZ8xmPcJC7Orug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241207; c=relaxed/simple;
	bh=MBFCEoIMizXjea6QRBCNY0kwTxTJRZKU3qWYUNv/d+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q68njDYitw8npjsX3ros0RBvQBQ8LtXGXysJ4bCrTj8wU4HTIX8P5yaRZifbrrqYVEeZQQxws2zj9v+6jAZ8D690kzmMT5z/xsB3ssDkr4iFnNnhd9PjX9Js2iGwAFko4lqPcDrsk+gAZk17fUjRar0zVJiKrbeEj8ypMia1mH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4A11007;
	Thu,  4 Apr 2024 07:33:56 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 086CD3F64C;
	Thu,  4 Apr 2024 07:33:23 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>
Subject: [PATCH v2 4/4] arm64: mm: Lazily clear pte table mappings from fixmap
Date: Thu,  4 Apr 2024 15:33:08 +0100
Message-Id: <20240404143308.2224141-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404143308.2224141-1-ryan.roberts@arm.com>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the pgtable operations abstracted into `struct pgtable_ops`, the
early pgtable alloc, map and unmap operations are nicely centralized. So
let's enhance the implementation to speed up the clearing of pte table
mappings in the fixmap.

Extend FIX_MAP so that we now have 16 slots in the fixmap dedicated for
pte tables. At alloc/map time, we select the next slot in the series and
map it. Or if we are at the end and no more slots are available, clear
down all of the slots and start at the beginning again. Batching the
clear like this means we can issue tlbis more efficiently.

Due to the batching, there may still be some slots mapped at the end, so
address this by adding an optional cleanup() function to `struct
pgtable_ops` to handle this for us.

Execution time of map_mem(), which creates the kernel linear map page
tables, was measured on different machines with different RAM configs:

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
before         |   11   (0%) |  109   (0%) |  449   (0%) |  1257   (0%)
after          |    6 (-46%) |   61 (-44%) |  257 (-43%) |   838 (-33%)

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Tested-by: Eric Chanudet <echanude@redhat.com>
---
 arch/arm64/include/asm/fixmap.h  |  5 +++-
 arch/arm64/include/asm/pgtable.h |  4 ---
 arch/arm64/mm/fixmap.c           | 11 ++++++++
 arch/arm64/mm/mmu.c              | 44 +++++++++++++++++++++++++++++---
 4 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 87e307804b99..91fcd7c5c513 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -84,7 +84,9 @@ enum fixed_addresses {
 	 * Used for kernel page table creation, so unmapped memory may be used
 	 * for tables.
 	 */
-	FIX_PTE,
+#define NR_PTE_SLOTS		16
+	FIX_PTE_END,
+	FIX_PTE_BEGIN = FIX_PTE_END + NR_PTE_SLOTS - 1,
 	FIX_PMD,
 	FIX_PUD,
 	FIX_P4D,
@@ -108,6 +110,7 @@ void __init early_fixmap_init(void);
 #define __late_clear_fixmap(idx) __set_fixmap((idx), 0, FIXMAP_PAGE_CLEAR)
 
 extern void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
+void __init clear_fixmap_nosync(enum fixed_addresses idx);
 
 #include <asm-generic/fixmap.h>
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 92c9aed5e7af..4c7114d49697 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -691,10 +691,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 /* Find an entry in the third-level page table. */
 #define pte_offset_phys(dir,addr)	(pmd_page_paddr(READ_ONCE(*(dir))) + pte_index(addr) * sizeof(pte_t))
 
-#define pte_set_fixmap(addr)		((pte_t *)set_fixmap_offset(FIX_PTE, addr))
-#define pte_set_fixmap_offset(pmd, addr)	pte_set_fixmap(pte_offset_phys(pmd, addr))
-#define pte_clear_fixmap()		clear_fixmap(FIX_PTE)
-
 #define pmd_page(pmd)			phys_to_page(__pmd_to_phys(pmd))
 
 /* use ONLY for statically allocated translation tables */
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index de1e09d986ad..0cb09bedeeec 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -131,6 +131,17 @@ void __set_fixmap(enum fixed_addresses idx,
 	}
 }
 
+void __init clear_fixmap_nosync(enum fixed_addresses idx)
+{
+	unsigned long addr = __fix_to_virt(idx);
+	pte_t *ptep;
+
+	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
+
+	ptep = fixmap_pte(addr);
+	__pte_clear(&init_mm, addr, ptep);
+}
+
 void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 {
 	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 90bf822859b8..2e3b594aa23c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -66,11 +66,14 @@ enum pgtable_type {
  *              mapped either as a result of a previous call to alloc() or
  *              map(). The page's virtual address must be considered invalid
  *              after this call returns.
+ * @cleanup:    (Optional) Called at the end of a set of operations to cleanup
+ *              any lazy state.
  */
 struct pgtable_ops {
 	void *(*alloc)(int type, phys_addr_t *pa);
 	void *(*map)(int type, void *parent, unsigned long addr);
 	void (*unmap)(int type);
+	void (*cleanup)(void);
 };
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
@@ -139,9 +142,33 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
+static int pte_slot_next __initdata = FIX_PTE_BEGIN;
+
+static void __init clear_pte_fixmap_slots(void)
+{
+	unsigned long start = __fix_to_virt(FIX_PTE_BEGIN);
+	unsigned long end = __fix_to_virt(pte_slot_next);
+	int i;
+
+	for (i = FIX_PTE_BEGIN; i > pte_slot_next; i--)
+		clear_fixmap_nosync(i);
+
+	flush_tlb_kernel_range(start, end);
+	pte_slot_next = FIX_PTE_BEGIN;
+}
+
+static int __init pte_fixmap_slot(void)
+{
+	if (pte_slot_next < FIX_PTE_END)
+		clear_pte_fixmap_slots();
+
+	return pte_slot_next--;
+}
+
 static void *__init early_pgtable_alloc(int type, phys_addr_t *pa)
 {
 	void *va;
+	int slot;
 
 	*pa = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
 					MEMBLOCK_ALLOC_NOLEAKTRACE);
@@ -159,7 +186,9 @@ static void *__init early_pgtable_alloc(int type, phys_addr_t *pa)
 		va = pmd_set_fixmap(*pa);
 		break;
 	case TYPE_PTE:
-		va = pte_set_fixmap(*pa);
+		slot = pte_fixmap_slot();
+		set_fixmap(slot, *pa);
+		va = (pte_t *)__fix_to_virt(slot);
 		break;
 	default:
 		BUG();
@@ -174,7 +203,9 @@ static void *__init early_pgtable_alloc(int type, phys_addr_t *pa)
 
 static void *__init early_pgtable_map(int type, void *parent, unsigned long addr)
 {
+	phys_addr_t pa;
 	void *entry;
+	int slot;
 
 	switch (type) {
 	case TYPE_P4D:
@@ -187,7 +218,10 @@ static void *__init early_pgtable_map(int type, void *parent, unsigned long addr
 		entry = pmd_set_fixmap_offset((pud_t *)parent, addr);
 		break;
 	case TYPE_PTE:
-		entry = pte_set_fixmap_offset((pmd_t *)parent, addr);
+		slot = pte_fixmap_slot();
+		pa = pte_offset_phys((pmd_t *)parent, addr);
+		set_fixmap(slot, pa);
+		entry = (pte_t *)(__fix_to_virt(slot) + (pa & (PAGE_SIZE - 1)));
 		break;
 	default:
 		BUG();
@@ -209,7 +243,7 @@ static void __init early_pgtable_unmap(int type)
 		pmd_clear_fixmap();
 		break;
 	case TYPE_PTE:
-		pte_clear_fixmap();
+		// Unmap lazily: see clear_pte_fixmap_slots().
 		break;
 	default:
 		BUG();
@@ -220,6 +254,7 @@ static struct pgtable_ops early_pgtable_ops __initdata = {
 	.alloc = early_pgtable_alloc,
 	.map = early_pgtable_map,
 	.unmap = early_pgtable_unmap,
+	.cleanup = clear_pte_fixmap_slots,
 };
 
 bool pgattr_change_is_safe(u64 old, u64 new)
@@ -538,6 +573,9 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 		alloc_init_p4d(pgdp, addr, next, phys, prot, ops, flags);
 		phys += next - addr;
 	} while (pgdp++, addr = next, addr != end);
+
+	if (ops->cleanup)
+		ops->cleanup();
 }
 
 static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
-- 
2.25.1


