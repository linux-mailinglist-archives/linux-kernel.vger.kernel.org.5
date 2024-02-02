Return-Path: <linux-kernel+bounces-49424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B8846A3E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1D028DC7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953543FE44;
	Fri,  2 Feb 2024 08:09:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7404208DD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861341; cv=none; b=uLP1/TacggqompYgj4B3Un4rLSEiVF+BDrz6h84EZKdASI3ZzEVSgROMULRe7Fj+blaQ5vmkHv8FscGt7vFrdmnCIOmBZ8YnQBiz4AC4YefMSz+DMrc0HJQeckZid5r17Pr0JpycsRpz6xVTwp+BMVpiItN864FTBw0Jp+1YwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861341; c=relaxed/simple;
	bh=La/t/g/3XWeRFMx+KrtVfTx+R1Lu4QQlWhl2tkyKzbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CpXMGww3Wdt1oH1NcMLJ4TLe5D18lcOTS3RsBKs35IV6TZdYgysUmXL1XHrJeMJz41Wbhn+Vbf4pQqz8RSi+2HOFq5V2oXN61JD1kY2YpmapDFAUJOialyrq74+pPH+rwBjVxLXyHQ2jkaN49vQj04LmGDnr0xyJF8nEftB5ZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ED401A2D;
	Fri,  2 Feb 2024 00:09:40 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2CAC3F5A1;
	Fri,  2 Feb 2024 00:08:54 -0800 (PST)
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
Subject: [PATCH v5 11/25] arm64/mm: pte_clear(): New layer to manage contig bit
Date: Fri,  2 Feb 2024 08:07:42 +0000
Message-Id: <20240202080756.1453939-12-ryan.roberts@arm.com>
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

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 3 ++-
 arch/arm64/mm/fixmap.c           | 2 +-
 arch/arm64/mm/hugetlbpage.c      | 2 +-
 arch/arm64/mm/mmu.c              | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f1fd6c5e3eca..3b0ff58109c5 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -93,7 +93,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 	__pte(__phys_to_pte_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
 #define pte_none(pte)		(!pte_val(pte))
-#define pte_clear(mm, addr, ptep) \
+#define __pte_clear(mm, addr, ptep) \
 				__set_pte(ptep, __pte(0))
 #define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
 
@@ -1140,6 +1140,7 @@ void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte);
 
 #define set_pte					__set_pte
 #define set_ptes				__set_ptes
+#define pte_clear				__pte_clear
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index 51cd4501816d..bfc02568805a 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -123,7 +123,7 @@ void __set_fixmap(enum fixed_addresses idx,
 	if (pgprot_val(flags)) {
 		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
 	} else {
-		pte_clear(&init_mm, addr, ptep);
+		__pte_clear(&init_mm, addr, ptep);
 		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
 	}
 }
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 9d7e7315eaa3..3d73b83cf97f 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -400,7 +400,7 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 	ncontig = num_contig_ptes(sz, &pgsize);
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		pte_clear(mm, addr, ptep);
+		__pte_clear(mm, addr, ptep);
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7cc1930f0e10..bcaa5a5d86f8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -859,7 +859,7 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 			continue;
 
 		WARN_ON(!pte_present(pte));
-		pte_clear(&init_mm, addr, ptep);
+		__pte_clear(&init_mm, addr, ptep);
 		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 		if (free_mapped)
 			free_hotplug_page_range(pte_page(pte),
-- 
2.25.1


