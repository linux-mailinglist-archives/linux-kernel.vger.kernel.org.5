Return-Path: <linux-kernel+bounces-49420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAAE846A35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E6A1C2A670
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1842AB7;
	Fri,  2 Feb 2024 08:08:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B99842076
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861329; cv=none; b=k5BOLssjAnXy4Po5Z0vnr/DLm0qQMNc+siXEIKxZdGIQ/KkGtiOx6YvxGh6db83uDmQQ9NfR++xWGFeaJqKjjcMPIeAQfG55DvCr9OiL8ym1EUy6XNIhulStX1C24d6bmFxdxXsMm+Q3ssTyBOmiFDJNwV7DTSVHvI8Y30D4vO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861329; c=relaxed/simple;
	bh=0dZnm+y0Nq9XiO0L7V9+trEQJFUMFZWy0iSlr4woyIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjVWvRlWZ/SbyHDSIJVdCqh57AifcFBdwxcro740hF12f/AuLIyInb1Gny1qKsA+/CGxYjCL0xLComnaunuPd/FXNJsqAoUrouiMGgGATk849T7LdOfLhF+cDGVNoFSrj3N9cpIeIQ19fx3M/w8A/5VReUKSZxMDmqcbny8xJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34710176C;
	Fri,  2 Feb 2024 00:09:29 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 489F23F5A1;
	Fri,  2 Feb 2024 00:08:43 -0800 (PST)
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
Subject: [PATCH v5 08/25] mm: Remove pte_next_pfn() and replace with pte_advance_pfn()
Date: Fri,  2 Feb 2024 08:07:39 +0000
Message-Id: <20240202080756.1453939-9-ryan.roberts@arm.com>
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

Now that the architectures are converted over to pte_advance_pfn(), we
can remove the pte_next_pfn() wrapper and convert the callers to call
pte_advance_pfn().

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 9 +--------
 mm/memory.c             | 4 ++--
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 815d92dcb96b..50f32cccbd92 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -212,19 +212,12 @@ static inline int pmd_dirty(pmd_t pmd)
 #define arch_flush_lazy_mmu_mode()	do {} while (0)
 #endif
 
-
-#ifndef pte_next_pfn
 #ifndef pte_advance_pfn
 static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
 {
 	return __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
 }
 #endif
-static inline pte_t pte_next_pfn(pte_t pte)
-{
-	return pte_advance_pfn(pte, 1);
-}
-#endif
 
 #ifndef set_ptes
 /**
@@ -256,7 +249,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		if (--nr == 0)
 			break;
 		ptep++;
-		pte = pte_next_pfn(pte);
+		pte = pte_advance_pfn(pte, 1);
 	}
 	arch_leave_lazy_mmu_mode();
 }
diff --git a/mm/memory.c b/mm/memory.c
index 38a010c4d04d..65fbe4f886c1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -988,7 +988,7 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 {
 	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
 	const pte_t *end_ptep = start_ptep + max_nr;
-	pte_t expected_pte = __pte_batch_clear_ignored(pte_next_pfn(pte), flags);
+	pte_t expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, 1), flags);
 	pte_t *ptep = start_ptep + 1;
 	bool writable;
 
@@ -1017,7 +1017,7 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		if (any_writable)
 			*any_writable |= writable;
 
-		expected_pte = pte_next_pfn(expected_pte);
+		expected_pte = pte_advance_pfn(expected_pte, 1);
 		ptep++;
 	}
 
-- 
2.25.1


