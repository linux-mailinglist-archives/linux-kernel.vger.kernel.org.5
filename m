Return-Path: <linux-kernel+bounces-118766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9B488BF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43941F638BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4B76BFA3;
	Tue, 26 Mar 2024 10:15:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6105C904
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448103; cv=none; b=B7gKLAjN5Mn7hk7pSZJ2R/jVol1sAEiwOP4G1FPXE76YvqZzHbm033aJWf1A3MrAg141InR6vwqTmKBtRXRJhY1v46d74RZTPafhfN5egSI+UqFSlWt76LVcZBcRCwE+G7L0qh/gBUfMUmSL2q7Uf3ck0hdElFQRVkQ6ZqfTdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448103; c=relaxed/simple;
	bh=N1xkCE3sQMpXnANNge/c5FP6TEfXrEfnEn4nfLeC1Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cwdu4fb8JCcZCui2ghOCnKOFxqvExUCmxkYt69WE9BluFKazFYcOc77J7tuyUy+1qBTpq433l4+I7NlGQI/Nsd/9Smmqt1IwfS3/EY/0kVuMTW7lEXtaW+cCR6X6GG+D2MvaCgZOXs17CXmpl9AEKWfl6SgdSO9lEXBFhBnMeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAC12339;
	Tue, 26 Mar 2024 03:15:34 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13F053F64C;
	Tue, 26 Mar 2024 03:14:59 -0700 (PDT)
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
Subject: [PATCH v1 1/3] arm64: mm: Don't remap pgtables per- cont(pte|pmd) block
Date: Tue, 26 Mar 2024 10:14:46 +0000
Message-Id: <20240326101448.3453626-2-ryan.roberts@arm.com>
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

A large part of the kernel boot time is creating the kernel linear map
page tables. When rodata=full, all memory is mapped by pte. And when
there is lots of physical ram, there are lots of pte tables to populate.
The primary cost associated with this is mapping and unmapping the pte
table memory in the fixmap; at unmap time, the TLB entry must be
invalidated and this is expensive.

Previously, each pmd and pte table was fixmapped/fixunmapped for each
cont(pte|pmd) block of mappings (16 entries with 4K granule). This means
we ended up issuing 32 TLBIs per (pmd|pte) table during the population
phase.

Let's fix that, and fixmap/fixunmap each page once per population, for a
saving of 31 TLBIs per (pmd|pte) table. This gives a significant boot
speedup.

Execution time of map_mem(), which creates the kernel linear map page
tables, was measured on different machines with different RAM configs:

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
before         |  151   (0%) | 2191   (0%) | 8990   (0%) | 17443   (0%)
after          |   77 (-49%) |  429 (-80%) | 1753 (-80%) |  3796 (-78%)

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/mmu.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 495b732d5af3..fd91b5bdb514 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -172,12 +172,9 @@ bool pgattr_change_is_safe(u64 old, u64 new)
 	return ((old ^ new) & ~mask) == 0;
 }
 
-static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
-		     phys_addr_t phys, pgprot_t prot)
+static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
+		       phys_addr_t phys, pgprot_t prot)
 {
-	pte_t *ptep;
-
-	ptep = pte_set_fixmap_offset(pmdp, addr);
 	do {
 		pte_t old_pte = __ptep_get(ptep);
 
@@ -193,7 +190,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		phys += PAGE_SIZE;
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
 
-	pte_clear_fixmap();
+	return ptep;
 }
 
 static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
@@ -204,6 +201,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 {
 	unsigned long next;
 	pmd_t pmd = READ_ONCE(*pmdp);
+	pte_t *ptep;
 
 	BUG_ON(pmd_sect(pmd));
 	if (pmd_none(pmd)) {
@@ -219,6 +217,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	}
 	BUG_ON(pmd_bad(pmd));
 
+	ptep = pte_set_fixmap_offset(pmdp, addr);
 	do {
 		pgprot_t __prot = prot;
 
@@ -229,20 +228,20 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 		    (flags & NO_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
-		init_pte(pmdp, addr, next, phys, __prot);
+		ptep = init_pte(ptep, addr, next, phys, __prot);
 
 		phys += next - addr;
 	} while (addr = next, addr != end);
+
+	pte_clear_fixmap();
 }
 
-static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
-		     phys_addr_t phys, pgprot_t prot,
-		     phys_addr_t (*pgtable_alloc)(int), int flags)
+static pmd_t *init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
+		       phys_addr_t phys, pgprot_t prot,
+		       phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
-	pmd_t *pmdp;
 
-	pmdp = pmd_set_fixmap_offset(pudp, addr);
 	do {
 		pmd_t old_pmd = READ_ONCE(*pmdp);
 
@@ -269,7 +268,7 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 		phys += next - addr;
 	} while (pmdp++, addr = next, addr != end);
 
-	pmd_clear_fixmap();
+	return pmdp;
 }
 
 static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
@@ -279,6 +278,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 {
 	unsigned long next;
 	pud_t pud = READ_ONCE(*pudp);
+	pmd_t *pmdp;
 
 	/*
 	 * Check for initial section mappings in the pgd/pud.
@@ -297,6 +297,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 	}
 	BUG_ON(pud_bad(pud));
 
+	pmdp = pmd_set_fixmap_offset(pudp, addr);
 	do {
 		pgprot_t __prot = prot;
 
@@ -307,10 +308,13 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 		    (flags & NO_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
-		init_pmd(pudp, addr, next, phys, __prot, pgtable_alloc, flags);
+		pmdp = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc,
+				flags);
 
 		phys += next - addr;
 	} while (addr = next, addr != end);
+
+	pmd_clear_fixmap();
 }
 
 static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
-- 
2.25.1


