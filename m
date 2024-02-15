Return-Path: <linux-kernel+bounces-66643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 285CE8560EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A19B3240C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C3127B6D;
	Thu, 15 Feb 2024 10:32:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97312D76B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993166; cv=none; b=pQmcD8WL4/o7NgC9XonQByaYisgSmsSDQRge4kGsMDq9t/qfvhEbJHBXR4FGcacpN0QZniMtrKYn+tfQ/QF422NsqTLy7g823FxLwYVOdK8WF3TaW4C+A1uLSLeiwwb7E2EPcPKpYUK5aw5vIW8UxPADxKp4iePJT79avjgOqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993166; c=relaxed/simple;
	bh=+OkHaAXcApv5i6T7H/FIyOrqmVoEbs4XCu7oHPJUMwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqKcAPRl2a3EnWrjMRE2XHVX2G+KtMYAG4lyXT6acZmU4vyf/AZQqiY/xwH4kFf8YBwBBDfwbeqc9e4pGJ1uC8FzhIzN4/1sRw7eVjjM2fUCGpFbJHuYGliSWrHUVVNHzf9LWA0Rp6kFX/506kMPVHBEFlTD2/riG8M2On+saY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2453152B;
	Thu, 15 Feb 2024 02:33:24 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A90E53F7B4;
	Thu, 15 Feb 2024 02:32:40 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/18] arm64/mm: Convert READ_ONCE(*ptep) to ptep_get(ptep)
Date: Thu, 15 Feb 2024 10:31:54 +0000
Message-Id: <20240215103205.2607016-8-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215103205.2607016-1-ryan.roberts@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a number of places in the arch code that read a pte by using
the READ_ONCE() macro. Refactor these call sites to instead use the
ptep_get() helper, which itself is a READ_ONCE(). Generated code should
be the same.

This will benefit us when we shortly introduce the transparent contpte
support. In this case, ptep_get() will become more complex so we now
have all the code abstracted through it.

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 12 +++++++++---
 arch/arm64/kernel/efi.c          |  2 +-
 arch/arm64/mm/fault.c            |  4 ++--
 arch/arm64/mm/hugetlbpage.c      |  6 +++---
 arch/arm64/mm/kasan_init.c       |  2 +-
 arch/arm64/mm/mmu.c              | 12 ++++++------
 arch/arm64/mm/pageattr.c         |  4 ++--
 arch/arm64/mm/trans_pgd.c        |  2 +-
 8 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b6d3e9e0a946..de034ca40bad 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -275,6 +275,12 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	}
 }
 
+#define ptep_get ptep_get
+static inline pte_t ptep_get(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+
 extern void __sync_icache_dcache(pte_t pteval);
 bool pgattr_change_is_safe(u64 old, u64 new);
 
@@ -302,7 +308,7 @@ static inline void __check_safe_pte_update(struct mm_struct *mm, pte_t *ptep,
 	if (!IS_ENABLED(CONFIG_DEBUG_VM))
 		return;
 
-	old_pte = READ_ONCE(*ptep);
+	old_pte = ptep_get(ptep);
 
 	if (!pte_valid(old_pte) || !pte_valid(pte))
 		return;
@@ -904,7 +910,7 @@ static inline int __ptep_test_and_clear_young(pte_t *ptep)
 {
 	pte_t old_pte, pte;
 
-	pte = READ_ONCE(*ptep);
+	pte = ptep_get(ptep);
 	do {
 		old_pte = pte;
 		pte = pte_mkold(pte);
@@ -986,7 +992,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 {
 	pte_t old_pte, pte;
 
-	pte = READ_ONCE(*ptep);
+	pte = ptep_get(ptep);
 	do {
 		old_pte = pte;
 		pte = pte_wrprotect(pte);
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 0228001347be..d0e08e93b246 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -103,7 +103,7 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct set_perm_data *spd = data;
 	const efi_memory_desc_t *md = spd->md;
-	pte_t pte = READ_ONCE(*ptep);
+	pte_t pte = ptep_get(ptep);
 
 	if (md->attribute & EFI_MEMORY_RO)
 		pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 55f6455a8284..a254761fa1bd 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -191,7 +191,7 @@ static void show_pte(unsigned long addr)
 		if (!ptep)
 			break;
 
-		pte = READ_ONCE(*ptep);
+		pte = ptep_get(ptep);
 		pr_cont(", pte=%016llx", pte_val(pte));
 		pte_unmap(ptep);
 	} while(0);
@@ -214,7 +214,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 			  pte_t entry, int dirty)
 {
 	pteval_t old_pteval, pteval;
-	pte_t pte = READ_ONCE(*ptep);
+	pte_t pte = ptep_get(ptep);
 
 	if (pte_same(pte, entry))
 		return 0;
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 6720ec8d50e7..2892f925ed66 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -485,7 +485,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	size_t pgsize;
 	pte_t pte;
 
-	if (!pte_cont(READ_ONCE(*ptep))) {
+	if (!pte_cont(ptep_get(ptep))) {
 		ptep_set_wrprotect(mm, addr, ptep);
 		return;
 	}
@@ -510,7 +510,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	size_t pgsize;
 	int ncontig;
 
-	if (!pte_cont(READ_ONCE(*ptep)))
+	if (!pte_cont(ptep_get(ptep)))
 		return ptep_clear_flush(vma, addr, ptep);
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
@@ -543,7 +543,7 @@ pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr
 		 * when the permission changes from executable to non-executable
 		 * in cases where cpu is affected with errata #2645198.
 		 */
-		if (pte_user_exec(READ_ONCE(*ptep)))
+		if (pte_user_exec(ptep_get(ptep)))
 			return huge_ptep_clear_flush(vma, addr, ptep);
 	}
 	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 4c7ad574b946..c2a9f4f6c7dd 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -113,7 +113,7 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 			memset(__va(page_phys), KASAN_SHADOW_INIT, PAGE_SIZE);
 		next = addr + PAGE_SIZE;
 		set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
-	} while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)));
+	} while (ptep++, addr = next, addr != end && pte_none(ptep_get(ptep)));
 }
 
 static void __init kasan_pmd_populate(pud_t *pudp, unsigned long addr,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3a27d887f7dd..343629a17042 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -173,7 +173,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 	ptep = pte_set_fixmap_offset(pmdp, addr);
 	do {
-		pte_t old_pte = READ_ONCE(*ptep);
+		pte_t old_pte = ptep_get(ptep);
 
 		set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
 
@@ -182,7 +182,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		 * only allow updates to the permission attributes.
 		 */
 		BUG_ON(!pgattr_change_is_safe(pte_val(old_pte),
-					      READ_ONCE(pte_val(*ptep))));
+					      pte_val(ptep_get(ptep))));
 
 		phys += PAGE_SIZE;
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
@@ -852,7 +852,7 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 
 	do {
 		ptep = pte_offset_kernel(pmdp, addr);
-		pte = READ_ONCE(*ptep);
+		pte = ptep_get(ptep);
 		if (pte_none(pte))
 			continue;
 
@@ -985,7 +985,7 @@ static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
 
 	do {
 		ptep = pte_offset_kernel(pmdp, addr);
-		pte = READ_ONCE(*ptep);
+		pte = ptep_get(ptep);
 
 		/*
 		 * This is just a sanity check here which verifies that
@@ -1004,7 +1004,7 @@ static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
 	 */
 	ptep = pte_offset_kernel(pmdp, 0UL);
 	for (i = 0; i < PTRS_PER_PTE; i++) {
-		if (!pte_none(READ_ONCE(ptep[i])))
+		if (!pte_none(ptep_get(&ptep[i])))
 			return;
 	}
 
@@ -1473,7 +1473,7 @@ pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte
 		 * when the permission changes from executable to non-executable
 		 * in cases where cpu is affected with errata #2645198.
 		 */
-		if (pte_user_exec(READ_ONCE(*ptep)))
+		if (pte_user_exec(ptep_get(ptep)))
 			return ptep_clear_flush(vma, addr, ptep);
 	}
 	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 924843f1f661..73a5e8f82586 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -36,7 +36,7 @@ bool can_set_direct_map(void)
 static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct page_change_data *cdata = data;
-	pte_t pte = READ_ONCE(*ptep);
+	pte_t pte = ptep_get(ptep);
 
 	pte = clear_pte_bit(pte, cdata->clear_mask);
 	pte = set_pte_bit(pte, cdata->set_mask);
@@ -245,5 +245,5 @@ bool kernel_page_present(struct page *page)
 		return true;
 
 	ptep = pte_offset_kernel(pmdp, addr);
-	return pte_valid(READ_ONCE(*ptep));
+	return pte_valid(ptep_get(ptep));
 }
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 7b14df3c6477..f71ab4704cce 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -33,7 +33,7 @@ static void *trans_alloc(struct trans_pgd_info *info)
 
 static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 {
-	pte_t pte = READ_ONCE(*src_ptep);
+	pte_t pte = ptep_get(src_ptep);
 
 	if (pte_valid(pte)) {
 		/*
-- 
2.25.1


