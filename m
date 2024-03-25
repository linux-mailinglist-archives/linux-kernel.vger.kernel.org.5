Return-Path: <linux-kernel+bounces-117303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F7288A9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD0D3046A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AE616FF48;
	Mon, 25 Mar 2024 14:56:42 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD716F91E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378601; cv=none; b=rlPK8xx44tbpTVHsu8y5m1HHKWymfG9CylfToIR+tZYGzsddfXaWUf1pQyftpoxt0ZgAqZ+b28DonEc4Rsll6MkW0eFHYN012wtLkvu5TUGz0xgNRYfWgqXYDxZ68oA2hE0Qj/h0MrR0MfTvWcVdggQphrjd254nGy4jkBOHHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378601; c=relaxed/simple;
	bh=Jznk0U1nUM93F+OjDNFTDQGGpO/+NygdkRGhqiyMtIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKMsswnxv5yaHPcchvoE0FjejH68v6NuRhd5tFVx9fTjG5z0k//jbYJ978dA7dbqlGlJdzJ/gZ0E9EuYpN+d8QGJmbXJhGA73EvhXEOMG4FqkWzLUjHU/zw3oK/wb+u2X5Sxn7s2v+WRFAdUKKKoLfb5ZAbLO5zce5XYP03XqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4V3GGS2kLVz9sjs;
	Mon, 25 Mar 2024 15:56:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JVR3mRugAZfo; Mon, 25 Mar 2024 15:56:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4V3GGK5kxZz9snj;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BC19F8B76C;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id jllWntrCz3wc; Mon, 25 Mar 2024 15:56:09 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A95A8B765;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 5/8] powerpc/mm: Allow hugepages without hugepd
Date: Mon, 25 Mar 2024 15:55:58 +0100
Message-ID: <69591a2e4fd72c1dd09eb8e0b2e7f1256fd32304.1711377230.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711377230.git.christophe.leroy@csgroup.eu>
References: <cover.1711377230.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711378567; l=4076; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Jznk0U1nUM93F+OjDNFTDQGGpO/+NygdkRGhqiyMtIg=; b=NRVJXrlJlcUaGzfQGV1gXGWLIRU/BzjMzXwi1e9lA4gXddnJMpRRfFmCSybSn6ZqcShsYRtTG eE1Wia4TerHBN/z+blYQ+hywkW7qiSZ3w7OWik7L539Ar+p3FBIVxKC
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In preparation of implementing huge pages on powerpc 8xx
without hugepd, enclose hugepd related code inside an
ifdef CONFIG_ARCH_HAS_HUGEPD

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/hugetlb.h        |  2 ++
 arch/powerpc/include/asm/nohash/pgtable.h |  8 +++++---
 arch/powerpc/mm/hugetlbpage.c             | 10 ++++++++++
 arch/powerpc/mm/pgtable.c                 |  2 ++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index ea71f7245a63..a05657e5701b 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -30,10 +30,12 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 }
 #define is_hugepage_only_range is_hugepage_only_range
 
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 #define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
 			    unsigned long ceiling);
+#endif
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 427db14292c9..ac3353f7f2ac 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -340,7 +340,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #define pgprot_writecombine pgprot_noncached_wc
 
-#ifdef CONFIG_HUGETLB_PAGE
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 static inline int hugepd_ok(hugepd_t hpd)
 {
 #ifdef CONFIG_PPC_8xx
@@ -351,6 +351,10 @@ static inline int hugepd_ok(hugepd_t hpd)
 #endif
 }
 
+#define is_hugepd(hpd)		(hugepd_ok(hpd))
+#endif
+
+#ifdef CONFIG_HUGETLB_PAGE
 static inline int pmd_huge(pmd_t pmd)
 {
 	return 0;
@@ -360,8 +364,6 @@ static inline int pud_huge(pud_t pud)
 {
 	return 0;
 }
-
-#define is_hugepd(hpd)		(hugepd_ok(hpd))
 #endif
 
 int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 66ac56b26007..db73ad845a2a 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -42,6 +42,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr, unsigned long s
 	return __find_linux_pte(mm->pgd, addr, NULL, NULL);
 }
 
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			   unsigned long address, unsigned int pdshift,
 			   unsigned int pshift, spinlock_t *ptl)
@@ -193,6 +194,13 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	return hugepte_offset(*hpdp, addr, pdshift);
 }
+#else
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, unsigned long sz)
+{
+	return pte_alloc_huge(mm, pmd_off(mm, addr), addr, sz);
+}
+#endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
 /*
@@ -248,6 +256,7 @@ int __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 	return __alloc_bootmem_huge_page(h, nid);
 }
 
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 #ifndef CONFIG_PPC_BOOK3S_64
 #define HUGEPD_FREELIST_SIZE \
 	((PAGE_SIZE - sizeof(struct hugepd_freelist)) / sizeof(pte_t))
@@ -505,6 +514,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 		}
 	} while (addr = next, addr != end);
 }
+#endif
 
 bool __init arch_hugetlb_valid_size(unsigned long size)
 {
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9e7ba9c3851f..acdf64c9b93e 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -487,8 +487,10 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	if (!hpdp)
 		return NULL;
 
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 	ret_pte = hugepte_offset(*hpdp, ea, pdshift);
 	pdshift = hugepd_shift(*hpdp);
+#endif
 out:
 	if (hpage_shift)
 		*hpage_shift = pdshift;
-- 
2.43.0


