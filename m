Return-Path: <linux-kernel+bounces-49423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5C846A3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C5F1F2B42B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD61018E2F;
	Fri,  2 Feb 2024 08:08:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E3118037
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861337; cv=none; b=akYNyyF3115RSHEp1IyL0dNK27oTi4YCaHZnwBghhW9cjHqWv8HIoCXY8wUR0L8+dgT8J4DQxFVKgGNEKk4GjjLyzcOnbSbhHmZTpD1C8T62ODUk7Qs62w74V2XykYUZiaxIOCq26ux5OQYzlai5JQqm06oYG8szRnsNK5HGI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861337; c=relaxed/simple;
	bh=h8hseitjVbcStovkWTDmGF7pyhm8fsork5JtvDIQOvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XVmDNhJpt+liKv/nOACeFa+akFyvlbLJBcY3QQlafGngRmycICbJWkUcZaDIgYJoivL811dOrwu8AkUaSgnw7YYS/F4AB80FPPga+P6zd38aL/CmR2a/wB3HcZkH/paDQGfi4jWS8L7zUliIrS+K7AoHycgSlxWdLHNJ2RlGuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCB8F1A25;
	Fri,  2 Feb 2024 00:09:36 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0BD93F5A1;
	Fri,  2 Feb 2024 00:08:50 -0800 (PST)
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
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
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
Subject: [PATCH v5 10/25] arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
Date: Fri,  2 Feb 2024 08:07:41 +0000
Message-Id: <20240202080756.1453939-11-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202080756.1453939-1-ryan.roberts@arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
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
index 3cb45e8dbb52..f1fd6c5e3eca 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -358,9 +358,9 @@ static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
 	return pfn_pte(pte_pfn(pte) + nr, pte_pgprot(pte));
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
@@ -374,7 +374,6 @@ static inline void set_ptes(struct mm_struct *mm,
 		pte = pte_advance_pfn(pte, 1);
 	}
 }
-#define set_ptes set_ptes
 
 /*
  * Huge pte definitions.
@@ -1079,7 +1078,7 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 #endif /* CONFIG_ARM64_MTE */
 
 /*
- * On AArch64, the cache coherency is handled via the set_pte_at() function.
+ * On AArch64, the cache coherency is handled via the __set_ptes() function.
  */
 static inline void update_mmu_cache_range(struct vm_fault *vmf,
 		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
@@ -1140,6 +1139,7 @@ void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte);
 #endif
 
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
index 13189322a38f..23d0dfc16686 100644
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
index 8116ac599f80..9d7e7315eaa3 100644
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


