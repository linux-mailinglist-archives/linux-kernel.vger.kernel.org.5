Return-Path: <linux-kernel+bounces-3374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AFD816B99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790F028403A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5451BDC3;
	Mon, 18 Dec 2023 10:51:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DFB1BDC2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13D8C2F4;
	Mon, 18 Dec 2023 02:52:21 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 346023F738;
	Mon, 18 Dec 2023 02:51:33 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Yu Zhao <yuzhao@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/16] arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
Date: Mon, 18 Dec 2023 10:50:49 +0000
Message-Id: <20231218105100.172635-6-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218105100.172635-1-ryan.roberts@arm.com>
References: <20231218105100.172635-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new layer for the in-table PTE manipulation APIs. For now, The
existing API is prefixed with double underscore to become the
arch-private API and the public API is just a simple wrapper that calls
the private API.

The public API implementation will subsequently be used to transparently
manipulate the contiguous bit where appropriate. But since there are
already some contig-aware users (e.g. hugetlb, kernel mapper), we must
first ensure those users use the private API directly so that the future
contig-bit manipulations in the public API do not interfere with those
existing uses.

set_pte_at() is a core macro that forwards to set_ptes() (with nr=1).
Instead of creating a __set_pte_at() internal macro, convert all arch
users to use set_ptes()/__set_ptes() directly, as appropriate. Callers
in hugetlb may benefit from calling __set_ptes() once for their whole
range rather than managing their own loop. This is left for future
improvement.

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 10 +++++-----
 arch/arm64/kernel/mte.c          |  2 +-
 arch/arm64/kvm/guest.c           |  2 +-
 arch/arm64/mm/fault.c            |  2 +-
 arch/arm64/mm/hugetlbpage.c      | 10 +++++-----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 650d4f4bb6dc..323ec91add60 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -342,9 +342,9 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
 		mte_sync_tags(pte, nr_pages);
 }
 
-static inline void set_ptes(struct mm_struct *mm,
-			    unsigned long __always_unused addr,
-			    pte_t *ptep, pte_t pte, unsigned int nr)
+static inline void __set_ptes(struct mm_struct *mm,
+			      unsigned long __always_unused addr,
+			      pte_t *ptep, pte_t pte, unsigned int nr)
 {
 	page_table_check_ptes_set(mm, ptep, pte, nr);
 	__sync_cache_and_tags(pte, nr);
@@ -358,7 +358,6 @@ static inline void set_ptes(struct mm_struct *mm,
 		pte_val(pte) += PAGE_SIZE;
 	}
 }
-#define set_ptes set_ptes
 
 /*
  * Huge pte definitions.
@@ -1067,7 +1066,7 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 #endif /* CONFIG_ARM64_MTE */
 
 /*
- * On AArch64, the cache coherency is handled via the set_pte_at() function.
+ * On AArch64, the cache coherency is handled via the __set_ptes() function.
  */
 static inline void update_mmu_cache_range(struct vm_fault *vmf,
 		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
@@ -1121,6 +1120,7 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 				    pte_t old_pte, pte_t new_pte);
 
 #define set_pte					__set_pte
+#define set_ptes				__set_ptes
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index a41ef3213e1e..dcdcccd40891 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -67,7 +67,7 @@ int memcmp_pages(struct page *page1, struct page *page2)
 	/*
 	 * If the page content is identical but at least one of the pages is
 	 * tagged, return non-zero to avoid KSM merging. If only one of the
-	 * pages is tagged, set_pte_at() may zero or change the tags of the
+	 * pages is tagged, __set_ptes() may zero or change the tags of the
 	 * other page via mte_sync_tags().
 	 */
 	if (page_mte_tagged(page1) || page_mte_tagged(page2))
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index aaf1d4939739..629145fd3161 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -1072,7 +1072,7 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 		} else {
 			/*
 			 * Only locking to serialise with a concurrent
-			 * set_pte_at() in the VMM but still overriding the
+			 * __set_ptes() in the VMM but still overriding the
 			 * tags, hence ignoring the return value.
 			 */
 			try_page_mte_tagging(page);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 460d799e1296..a287c1dea871 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -205,7 +205,7 @@ static void show_pte(unsigned long addr)
  *
  * It needs to cope with hardware update of the accessed/dirty state by other
  * agents in the system and can safely skip the __sync_icache_dcache() call as,
- * like set_pte_at(), the PTE is never changed from no-exec to exec here.
+ * like __set_ptes(), the PTE is never changed from no-exec to exec here.
  *
  * Returns whether or not the PTE actually changed.
  */
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index f5aae342632c..741cb53672fd 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -254,12 +254,12 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
-			set_pte_at(mm, addr, ptep, pte);
+			__set_ptes(mm, addr, ptep, pte, 1);
 		return;
 	}
 
 	if (!pte_cont(pte)) {
-		set_pte_at(mm, addr, ptep, pte);
+		__set_ptes(mm, addr, ptep, pte, 1);
 		return;
 	}
 
@@ -270,7 +270,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	clear_flush(mm, addr, ptep, pgsize, ncontig);
 
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
+		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
 }
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -478,7 +478,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 	hugeprot = pte_pgprot(pte);
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
+		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
 
 	return 1;
 }
@@ -507,7 +507,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pfn = pte_pfn(pte);
 
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
+		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
 }
 
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-- 
2.25.1


