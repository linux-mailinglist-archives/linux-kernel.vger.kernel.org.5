Return-Path: <linux-kernel+bounces-118768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEBB88BF0C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42300305F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7806F529;
	Tue, 26 Mar 2024 10:15:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84876E614
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448106; cv=none; b=RrBeWwczo1puiz8/FPkKDw7uNqmRKZFbeSvTyImhwn95P+uaBPGIOPB7oGMIw//L/NTQ4CK8EjPx8mNtz3cp3Iz+2vgZbtROq62AnY3Yh9d5I7Mtq8+AdPLII/EKVvbguKKE3nRr/mQdHWizWijBVmmHUKujlmWmNumNIcUtcwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448106; c=relaxed/simple;
	bh=2kh5z4ZYeYSHWKUnfblNZOib032yZlzjmwa5hLyMKR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5ZDcs36V5RZeFNTS7jSqgsjmmrTT+A1+Y3BsXFI7v6My9OGkWP7ApBkcTw9HNRQBx2Ol8pA7YoBYThykqEJ4SnnTzbzY/SHPfQFJOubbdGdbc2FXbB3KOwyUW5fCPnM2/LQ0f0HG+JXj7hsjfH4RGFWW2ilGzasyz3/s9wX+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FA8F1474;
	Tue, 26 Mar 2024 03:15:38 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D2A03F64C;
	Tue, 26 Mar 2024 03:15:03 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] arm64: mm: Lazily clear pte table mappings from fixmap
Date: Tue, 26 Mar 2024 10:14:48 +0000
Message-Id: <20240326101448.3453626-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326101448.3453626-1-ryan.roberts@arm.com>
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the pgtable operations nicely abstracted into `struct pgtable_ops`,
the early pgtable alloc, map and unmap operations are nicely
centralized. So let's enhance the implementation to speed up the
clearing of pte table mappings in the fixmap.

Extend FIX_MAP so that we now have 16 slots in the fixmap dedicated for
pte tables. At alloc/map time, we select the next slot in the series and
map it. Or if we are at the end and no more slots are available, clear
down all of the slots and start at the beginning again. Batching the
clear like this means we can issue tlbis more efficiently.

Due to the batching, there may still be some slots mapped at the end, so
address this by adding an optional cleanup() function to `struct
pgtable_ops`. to handle this for us.

Execution time of map_mem(), which creates the kernel linear map page
tables, was measured on different machines with different RAM configs:

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
before         |   77   (0%) |  375   (0%) | 1532   (0%) |  3366   (0%)
after          |   63 (-18%) |  330 (-12%) | 1312 (-14%) |  2929 (-13%)

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
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
index afdd56d26ad7..bd5d02f3f0a3 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -686,10 +686,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 /* Find an entry in the third-level page table. */
 #define pte_offset_phys(dir,addr)	(pmd_page_paddr(READ_ONCE(*(dir))) + pte_index(addr) * sizeof(pte_t))
 
-#define pte_set_fixmap(addr)		((pte_t *)set_fixmap_offset(FIX_PTE, addr))
-#define pte_set_fixmap_offset(pmd, addr)	pte_set_fixmap(pte_offset_phys(pmd, addr))
-#define pte_clear_fixmap()		clear_fixmap(FIX_PTE)
-
 #define pmd_page(pmd)			phys_to_page(__pmd_to_phys(pmd))
 
 /* use ONLY for statically allocated translation tables */
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index de1e09d986ad..f83385f6ab86 100644
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
+	pte_clear(&init_mm, addr, ptep);
+}
+
 void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 {
 	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 81702b91b107..1b2a2a2d09b7 100644
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
@@ -139,6 +142,29 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
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
 static void __init early_pgtable_unmap(int type)
 {
 	switch (type) {
@@ -152,7 +178,7 @@ static void __init early_pgtable_unmap(int type)
 		pmd_clear_fixmap();
 		break;
 	case TYPE_PTE:
-		pte_clear_fixmap();
+		// Unmap lazily: see clear_pte_fixmap_slots().
 		break;
 	default:
 		BUG();
@@ -161,7 +187,9 @@ static void __init early_pgtable_unmap(int type)
 
 static void *__init early_pgtable_map(int type, void *parent, unsigned long addr)
 {
+	phys_addr_t pa;
 	void *entry;
+	int slot;
 
 	switch (type) {
 	case TYPE_P4D:
@@ -174,7 +202,10 @@ static void *__init early_pgtable_map(int type, void *parent, unsigned long addr
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
@@ -186,6 +217,7 @@ static void *__init early_pgtable_map(int type, void *parent, unsigned long addr
 static void *__init early_pgtable_alloc(int type, phys_addr_t *pa)
 {
 	void *va;
+	int slot;
 
 	*pa = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
 					MEMBLOCK_ALLOC_NOLEAKTRACE);
@@ -203,7 +235,9 @@ static void *__init early_pgtable_alloc(int type, phys_addr_t *pa)
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
@@ -220,6 +254,7 @@ static struct pgtable_ops early_pgtable_ops = {
 	.alloc = early_pgtable_alloc,
 	.map = early_pgtable_map,
 	.unmap = early_pgtable_unmap,
+	.cleanup = clear_pte_fixmap_slots,
 };
 
 bool pgattr_change_is_safe(u64 old, u64 new)
@@ -527,6 +562,9 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
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


