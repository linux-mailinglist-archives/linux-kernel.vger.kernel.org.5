Return-Path: <linux-kernel+bounces-118767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE188BF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A75D1C3073C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3566BFBC;
	Tue, 26 Mar 2024 10:15:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B7C6BB54
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448105; cv=none; b=LVuP1+9NNcovIvB6MwDe8CJxeNycQXN0kojqzuokh5P9iaMmpyUXrhnBZxJ89cRUdZBUSXRTSgiTpJ4JsDfRlAd215R137SSrdQNjWPbDB5HZzOxbPPff4nVg7p7WrMpEu+vz4QiM5djl7GQlSPNeQsBwJTuVwwoIMHp8kkbHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448105; c=relaxed/simple;
	bh=tUlILiUPC4r3MTYK2Xz87PGbGKDtio5NMBlwO9wN7SU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEvHsh+ZLiu4rslrCzxTGF7SbS8W1m21SRTDflw5zIkPoUzWaraznCBmGeEKqjz8kwUcbinJAQ4lNmiU5iFjjTCTccplZ6WNxlqWQyPWGeGdT0O/BpwfEqQGvsBjVxyCI+w6vb+S9blrLKk+EZJaaxgJDp9l0tDZLQUdv9gDMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82DED13D5;
	Tue, 26 Mar 2024 03:15:36 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95F803F844;
	Tue, 26 Mar 2024 03:15:01 -0700 (PDT)
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
Subject: [PATCH v1 2/3] arm64: mm: Don't remap pgtables for allocate vs populate
Date: Tue, 26 Mar 2024 10:14:47 +0000
Message-Id: <20240326101448.3453626-3-ryan.roberts@arm.com>
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

The previous change reduced remapping in the fixmap during the
population stage, but the code was still separately
fixmapping/fixunmapping each table during allocation in order to clear
the contents to zero. Which means each table still has 2 TLB
invalidations issued against it. Let's fix this so that each table is
only mapped/unmapped once, halving the number of TLBIs.

Achieve this by abstracting pgtable allocate, map and unmap operations
out of the main pgtable population loop code and into a `struct
pgtable_ops` function pointer structure. This allows us to formalize the
semantics of "alloc" to mean "alloc and map", requiring an "unmap" when
finished. So "map" is only performed (and also matched by "unmap") if
the pgtable is already been allocated.

As a side effect of this refactoring, we no longer need to use the
fixmap at all once pages have been mapped in the linear map because
their "map" operation can simply do a __va() translation. So with this
change, we are down to 1 TLBI per table when doing early pgtable
manipulations, and 0 TLBIs when doing late pgtable manipulations.

Execution time of map_mem(), which creates the kernel linear map page
tables, was measured on different machines with different RAM configs:

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
before         |   77   (0%) |  429   (0%) | 1753   (0%) |  3796   (0%)
after          |   77   (0%) |  375 (-13%) | 1532 (-13%) |  3366 (-11%)

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/mmu.h   |   8 +
 arch/arm64/kernel/cpufeature.c |  10 +-
 arch/arm64/mm/mmu.c            | 308 ++++++++++++++++++++++++---------
 include/linux/pgtable.h        |   8 +
 4 files changed, 243 insertions(+), 91 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 65977c7783c5..ae44353010e8 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -109,6 +109,14 @@ static inline bool kaslr_requires_kpti(void)
 	return true;
 }
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+extern
+void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
+			     phys_addr_t size, pgprot_t prot,
+			     void *(*pgtable_alloc)(int, phys_addr_t *),
+			     int flags);
+#endif
+
 #define INIT_MM_CONTEXT(name)	\
 	.pgd = swapper_pg_dir,
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 56583677c1f2..9a70b1954706 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1866,17 +1866,13 @@ static bool has_lpa2(const struct arm64_cpu_capabilities *entry, int scope)
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define KPTI_NG_TEMP_VA		(-(1UL << PMD_SHIFT))
 
-extern
-void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
-			     phys_addr_t size, pgprot_t prot,
-			     phys_addr_t (*pgtable_alloc)(int), int flags);
-
 static phys_addr_t __initdata kpti_ng_temp_alloc;
 
-static phys_addr_t __init kpti_ng_pgd_alloc(int shift)
+static void *__init kpti_ng_pgd_alloc(int type, phys_addr_t *pa)
 {
 	kpti_ng_temp_alloc -= PAGE_SIZE;
-	return kpti_ng_temp_alloc;
+	*pa = kpti_ng_temp_alloc;
+	return __va(kpti_ng_temp_alloc);
 }
 
 static int __init __kpti_install_ng_mappings(void *__unused)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fd91b5bdb514..81702b91b107 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -41,9 +41,42 @@
 #include <asm/pgalloc.h>
 #include <asm/kfence.h>
 
+enum pgtable_type {
+	TYPE_P4D = 0,
+	TYPE_PUD = 1,
+	TYPE_PMD = 2,
+	TYPE_PTE = 3,
+};
+
+/**
+ * struct pgtable_ops - Ops to allocate and access pgtable memory. Calls must be
+ * serialized by the caller.
+ * @alloc:      Allocates 1 page of memory for use as pgtable `type` and maps it
+ *              into va space. Returned memory is zeroed. Puts physical address
+ *              of page in *pa, and returns virtual address of the mapping. User
+ *              must explicitly unmap() before doing another alloc() or map() of
+ *              the same `type`.
+ * @map:        Determines the physical address of the pgtable of `type` by
+ *              interpretting `parent` as the pgtable entry for the next level
+ *              up. Maps the page and returns virtual address of the pgtable
+ *              entry within the table that corresponds to `addr`. User must
+ *              explicitly unmap() before doing another alloc() or map() of the
+ *              same `type`.
+ * @unmap:      Unmap the currently mapped page of `type`, which will have been
+ *              mapped either as a result of a previous call to alloc() or
+ *              map(). The page's virtual address must be considered invalid
+ *              after this call returns.
+ */
+struct pgtable_ops {
+	void *(*alloc)(int type, phys_addr_t *pa);
+	void *(*map)(int type, void *parent, unsigned long addr);
+	void (*unmap)(int type);
+};
+
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
+#define NO_ALLOC		BIT(3)
 
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
@@ -106,34 +139,89 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
-static phys_addr_t __init early_pgtable_alloc(int shift)
+static void __init early_pgtable_unmap(int type)
+{
+	switch (type) {
+	case TYPE_P4D:
+		p4d_clear_fixmap();
+		break;
+	case TYPE_PUD:
+		pud_clear_fixmap();
+		break;
+	case TYPE_PMD:
+		pmd_clear_fixmap();
+		break;
+	case TYPE_PTE:
+		pte_clear_fixmap();
+		break;
+	default:
+		BUG();
+	}
+}
+
+static void *__init early_pgtable_map(int type, void *parent, unsigned long addr)
+{
+	void *entry;
+
+	switch (type) {
+	case TYPE_P4D:
+		entry = p4d_set_fixmap_offset((pgd_t *)parent, addr);
+		break;
+	case TYPE_PUD:
+		entry = pud_set_fixmap_offset((p4d_t *)parent, addr);
+		break;
+	case TYPE_PMD:
+		entry = pmd_set_fixmap_offset((pud_t *)parent, addr);
+		break;
+	case TYPE_PTE:
+		entry = pte_set_fixmap_offset((pmd_t *)parent, addr);
+		break;
+	default:
+		BUG();
+	}
+
+	return entry;
+}
+
+static void *__init early_pgtable_alloc(int type, phys_addr_t *pa)
 {
-	phys_addr_t phys;
-	void *ptr;
+	void *va;
 
-	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
-					 MEMBLOCK_ALLOC_NOLEAKTRACE);
-	if (!phys)
+	*pa = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
+					MEMBLOCK_ALLOC_NOLEAKTRACE);
+	if (!*pa)
 		panic("Failed to allocate page table page\n");
 
-	/*
-	 * The FIX_{PGD,PUD,PMD} slots may be in active use, but the FIX_PTE
-	 * slot will be free, so we can (ab)use the FIX_PTE slot to initialise
-	 * any level of table.
-	 */
-	ptr = pte_set_fixmap(phys);
-
-	memset(ptr, 0, PAGE_SIZE);
+	switch (type) {
+	case TYPE_P4D:
+		va = p4d_set_fixmap(*pa);
+		break;
+	case TYPE_PUD:
+		va = pud_set_fixmap(*pa);
+		break;
+	case TYPE_PMD:
+		va = pmd_set_fixmap(*pa);
+		break;
+	case TYPE_PTE:
+		va = pte_set_fixmap(*pa);
+		break;
+	default:
+		BUG();
+	}
+	memset(va, 0, PAGE_SIZE);
 
-	/*
-	 * Implicit barriers also ensure the zeroed page is visible to the page
-	 * table walker
-	 */
-	pte_clear_fixmap();
+	/* Ensure the zeroed page is visible to the page table walker */
+	dsb(ishst);
 
-	return phys;
+	return va;
 }
 
+static struct pgtable_ops early_pgtable_ops = {
+	.alloc = early_pgtable_alloc,
+	.map = early_pgtable_map,
+	.unmap = early_pgtable_unmap,
+};
+
 bool pgattr_change_is_safe(u64 old, u64 new)
 {
 	/*
@@ -196,7 +284,7 @@ static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(int),
+				struct pgtable_ops *ops,
 				int flags)
 {
 	unsigned long next;
@@ -210,14 +298,15 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 		if (flags & NO_EXEC_MAPPINGS)
 			pmdval |= PMD_TABLE_PXN;
-		BUG_ON(!pgtable_alloc);
-		pte_phys = pgtable_alloc(PAGE_SHIFT);
+		BUG_ON(flags & NO_ALLOC);
+		ptep = ops->alloc(TYPE_PTE, &pte_phys);
+		ptep += pte_index(addr);
 		__pmd_populate(pmdp, pte_phys, pmdval);
-		pmd = READ_ONCE(*pmdp);
+	} else {
+		BUG_ON(pmd_bad(pmd));
+		ptep = ops->map(TYPE_PTE, pmdp, addr);
 	}
-	BUG_ON(pmd_bad(pmd));
 
-	ptep = pte_set_fixmap_offset(pmdp, addr);
 	do {
 		pgprot_t __prot = prot;
 
@@ -233,12 +322,12 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 		phys += next - addr;
 	} while (addr = next, addr != end);
 
-	pte_clear_fixmap();
+	ops->unmap(TYPE_PTE);
 }
 
 static pmd_t *init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		       phys_addr_t phys, pgprot_t prot,
-		       phys_addr_t (*pgtable_alloc)(int), int flags)
+		       struct pgtable_ops *ops, int flags)
 {
 	unsigned long next;
 
@@ -260,7 +349,7 @@ static pmd_t *init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 						      READ_ONCE(pmd_val(*pmdp))));
 		} else {
 			alloc_init_cont_pte(pmdp, addr, next, phys, prot,
-					    pgtable_alloc, flags);
+					    ops, flags);
 
 			BUG_ON(pmd_val(old_pmd) != 0 &&
 			       pmd_val(old_pmd) != READ_ONCE(pmd_val(*pmdp)));
@@ -274,7 +363,7 @@ static pmd_t *init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(int), int flags)
+				struct pgtable_ops *ops, int flags)
 {
 	unsigned long next;
 	pud_t pud = READ_ONCE(*pudp);
@@ -290,14 +379,15 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 		if (flags & NO_EXEC_MAPPINGS)
 			pudval |= PUD_TABLE_PXN;
-		BUG_ON(!pgtable_alloc);
-		pmd_phys = pgtable_alloc(PMD_SHIFT);
+		BUG_ON(flags & NO_ALLOC);
+		pmdp = ops->alloc(TYPE_PMD, &pmd_phys);
+		pmdp += pmd_index(addr);
 		__pud_populate(pudp, pmd_phys, pudval);
-		pud = READ_ONCE(*pudp);
+	} else {
+		BUG_ON(pud_bad(pud));
+		pmdp = ops->map(TYPE_PMD, pudp, addr);
 	}
-	BUG_ON(pud_bad(pud));
 
-	pmdp = pmd_set_fixmap_offset(pudp, addr);
 	do {
 		pgprot_t __prot = prot;
 
@@ -308,18 +398,17 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 		    (flags & NO_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
-		pmdp = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc,
-				flags);
+		pmdp = init_pmd(pmdp, addr, next, phys, __prot, ops, flags);
 
 		phys += next - addr;
 	} while (addr = next, addr != end);
 
-	pmd_clear_fixmap();
+	ops->unmap(TYPE_PMD);
 }
 
 static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 			   phys_addr_t phys, pgprot_t prot,
-			   phys_addr_t (*pgtable_alloc)(int),
+			   struct pgtable_ops *ops,
 			   int flags)
 {
 	unsigned long next;
@@ -332,14 +421,15 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 
 		if (flags & NO_EXEC_MAPPINGS)
 			p4dval |= P4D_TABLE_PXN;
-		BUG_ON(!pgtable_alloc);
-		pud_phys = pgtable_alloc(PUD_SHIFT);
+		BUG_ON(flags & NO_ALLOC);
+		pudp = ops->alloc(TYPE_PUD, &pud_phys);
+		pudp += pud_index(addr);
 		__p4d_populate(p4dp, pud_phys, p4dval);
-		p4d = READ_ONCE(*p4dp);
+	} else {
+		BUG_ON(p4d_bad(p4d));
+		pudp = ops->map(TYPE_PUD, p4dp, addr);
 	}
-	BUG_ON(p4d_bad(p4d));
 
-	pudp = pud_set_fixmap_offset(p4dp, addr);
 	do {
 		pud_t old_pud = READ_ONCE(*pudp);
 
@@ -361,7 +451,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 						      READ_ONCE(pud_val(*pudp))));
 		} else {
 			alloc_init_cont_pmd(pudp, addr, next, phys, prot,
-					    pgtable_alloc, flags);
+					    ops, flags);
 
 			BUG_ON(pud_val(old_pud) != 0 &&
 			       pud_val(old_pud) != READ_ONCE(pud_val(*pudp)));
@@ -369,12 +459,12 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		phys += next - addr;
 	} while (pudp++, addr = next, addr != end);
 
-	pud_clear_fixmap();
+	ops->unmap(TYPE_PUD);
 }
 
 static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 			   phys_addr_t phys, pgprot_t prot,
-			   phys_addr_t (*pgtable_alloc)(int),
+			   struct pgtable_ops *ops,
 			   int flags)
 {
 	unsigned long next;
@@ -387,21 +477,21 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 
 		if (flags & NO_EXEC_MAPPINGS)
 			pgdval |= PGD_TABLE_PXN;
-		BUG_ON(!pgtable_alloc);
-		p4d_phys = pgtable_alloc(P4D_SHIFT);
+		BUG_ON(flags & NO_ALLOC);
+		p4dp = ops->alloc(TYPE_P4D, &p4d_phys);
+		p4dp += p4d_index(addr);
 		__pgd_populate(pgdp, p4d_phys, pgdval);
-		pgd = READ_ONCE(*pgdp);
+	} else {
+		BUG_ON(pgd_bad(pgd));
+		p4dp = ops->map(TYPE_P4D, pgdp, addr);
 	}
-	BUG_ON(pgd_bad(pgd));
 
-	p4dp = p4d_set_fixmap_offset(pgdp, addr);
 	do {
 		p4d_t old_p4d = READ_ONCE(*p4dp);
 
 		next = p4d_addr_end(addr, end);
 
-		alloc_init_pud(p4dp, addr, next, phys, prot,
-			       pgtable_alloc, flags);
+		alloc_init_pud(p4dp, addr, next, phys, prot, ops, flags);
 
 		BUG_ON(p4d_val(old_p4d) != 0 &&
 		       p4d_val(old_p4d) != READ_ONCE(p4d_val(*p4dp)));
@@ -409,13 +499,13 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 		phys += next - addr;
 	} while (p4dp++, addr = next, addr != end);
 
-	p4d_clear_fixmap();
+	ops->unmap(TYPE_P4D);
 }
 
 static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 					unsigned long virt, phys_addr_t size,
 					pgprot_t prot,
-					phys_addr_t (*pgtable_alloc)(int),
+					struct pgtable_ops *ops,
 					int flags)
 {
 	unsigned long addr, end, next;
@@ -434,8 +524,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 
 	do {
 		next = pgd_addr_end(addr, end);
-		alloc_init_p4d(pgdp, addr, next, phys, prot, pgtable_alloc,
-			       flags);
+		alloc_init_p4d(pgdp, addr, next, phys, prot, ops, flags);
 		phys += next - addr;
 	} while (pgdp++, addr = next, addr != end);
 }
@@ -443,36 +532,59 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				 unsigned long virt, phys_addr_t size,
 				 pgprot_t prot,
-				 phys_addr_t (*pgtable_alloc)(int),
+				 struct pgtable_ops *ops,
 				 int flags)
 {
 	mutex_lock(&fixmap_lock);
 	__create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
-				    pgtable_alloc, flags);
+				    ops, flags);
 	mutex_unlock(&fixmap_lock);
 }
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-extern __alias(__create_pgd_mapping_locked)
-void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
-			     phys_addr_t size, pgprot_t prot,
-			     phys_addr_t (*pgtable_alloc)(int), int flags);
-#endif
+static void pgd_pgtable_unmap(int type)
+{
+}
+
+static void *pgd_pgtable_map(int type, void *parent, unsigned long addr)
+{
+	void *entry;
+
+	switch (type) {
+	case TYPE_P4D:
+		entry = p4d_offset((pgd_t *)parent, addr);
+		break;
+	case TYPE_PUD:
+		entry = pud_offset((p4d_t *)parent, addr);
+		break;
+	case TYPE_PMD:
+		entry = pmd_offset((pud_t *)parent, addr);
+		break;
+	case TYPE_PTE:
+		entry = pte_offset_kernel((pmd_t *)parent, addr);
+		break;
+	default:
+		BUG();
+	}
+
+	return entry;
+}
 
-static phys_addr_t __pgd_pgtable_alloc(int shift)
+static void *__pgd_pgtable_alloc(int type, phys_addr_t *pa)
 {
-	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
-	BUG_ON(!ptr);
+	void *va = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
+
+	BUG_ON(!va);
 
 	/* Ensure the zeroed page is visible to the page table walker */
 	dsb(ishst);
-	return __pa(ptr);
+	*pa = __pa(va);
+	return va;
 }
 
-static phys_addr_t pgd_pgtable_alloc(int shift)
+static void *pgd_pgtable_alloc(int type, phys_addr_t *pa)
 {
-	phys_addr_t pa = __pgd_pgtable_alloc(shift);
-	struct ptdesc *ptdesc = page_ptdesc(phys_to_page(pa));
+	void *va = __pgd_pgtable_alloc(type, pa);
+	struct ptdesc *ptdesc = page_ptdesc(phys_to_page(*pa));
 
 	/*
 	 * Call proper page table ctor in case later we need to
@@ -482,13 +594,41 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
 	 * We don't select ARCH_ENABLE_SPLIT_PMD_PTLOCK if pmd is
 	 * folded, and if so pagetable_pte_ctor() becomes nop.
 	 */
-	if (shift == PAGE_SHIFT)
+	if (type == TYPE_PTE)
 		BUG_ON(!pagetable_pte_ctor(ptdesc));
-	else if (shift == PMD_SHIFT)
+	else if (type == TYPE_PMD)
 		BUG_ON(!pagetable_pmd_ctor(ptdesc));
 
-	return pa;
+	return va;
+}
+
+static struct pgtable_ops pgd_pgtable_ops = {
+	.alloc = pgd_pgtable_alloc,
+	.map = pgd_pgtable_map,
+	.unmap = pgd_pgtable_unmap,
+};
+
+static struct pgtable_ops __pgd_pgtable_ops = {
+	.alloc = __pgd_pgtable_alloc,
+	.map = pgd_pgtable_map,
+	.unmap = pgd_pgtable_unmap,
+};
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
+			     phys_addr_t size, pgprot_t prot,
+			     void *(*pgtable_alloc)(int, phys_addr_t *),
+			     int flags)
+{
+	struct pgtable_ops ops = {
+		.alloc = pgtable_alloc,
+		.map = pgd_pgtable_map,
+		.unmap = pgd_pgtable_unmap,
+	};
+
+	__create_pgd_mapping_locked(pgdir, phys, virt, size, prot, &ops, flags);
 }
+#endif
 
 /*
  * This function can only be used to modify existing table entries,
@@ -503,8 +643,8 @@ void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 			&phys, virt);
 		return;
 	}
-	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-			     NO_CONT_MAPPINGS);
+	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
+			     &early_pgtable_ops, NO_CONT_MAPPINGS | NO_ALLOC);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
@@ -519,7 +659,7 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
-			     pgd_pgtable_alloc, flags);
+			     &pgd_pgtable_ops, flags);
 }
 
 static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
@@ -531,8 +671,8 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 
-	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-			     NO_CONT_MAPPINGS);
+	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
+			     &pgd_pgtable_ops, NO_CONT_MAPPINGS | NO_ALLOC);
 
 	/* flush the TLBs after updating live kernel mappings */
 	flush_tlb_kernel_range(virt, virt + size);
@@ -542,7 +682,7 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
 				  phys_addr_t end, pgprot_t prot, int flags)
 {
 	__create_pgd_mapping(pgdp, start, __phys_to_virt(start), end - start,
-			     prot, early_pgtable_alloc, flags);
+			     prot, &early_pgtable_ops, flags);
 }
 
 void __init mark_linear_text_alias_ro(void)
@@ -733,7 +873,7 @@ static int __init map_entry_trampoline(void)
 	memset(tramp_pg_dir, 0, PGD_SIZE);
 	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS,
 			     entry_tramp_text_size(), prot,
-			     __pgd_pgtable_alloc, NO_BLOCK_MAPPINGS);
+			     &__pgd_pgtable_ops, NO_BLOCK_MAPPINGS);
 
 	/* Map both the text and data into the kernel page table */
 	for (i = 0; i < DIV_ROUND_UP(entry_tramp_text_size(), PAGE_SIZE); i++)
@@ -1335,7 +1475,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
-			     size, params->pgprot, __pgd_pgtable_alloc,
+			     size, params->pgprot, &__pgd_pgtable_ops,
 			     flags);
 
 	memblock_clear_nomap(start, size);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 85fc7554cd52..1d9e91847cd8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -83,6 +83,14 @@ static inline unsigned long pud_index(unsigned long address)
 #define pud_index pud_index
 #endif
 
+#ifndef p4d_index
+static inline unsigned long p4d_index(unsigned long address)
+{
+	return (address >> P4D_SHIFT) & (PTRS_PER_P4D - 1);
+}
+#define p4d_index p4d_index
+#endif
+
 #ifndef pgd_index
 /* Must be a compile-time constant, so implement it as a macro */
 #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
-- 
2.25.1


