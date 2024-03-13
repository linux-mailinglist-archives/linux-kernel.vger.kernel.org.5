Return-Path: <linux-kernel+bounces-102565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E4687B3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEEBE284EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED6160253;
	Wed, 13 Mar 2024 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2VNe5EI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626065B696
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366466; cv=none; b=dAB5KdMX0rH9CYigSLexAJdUk+ZplNbPN+9LtXA/CqNUCrCykdcgd2Bs8q+SiozXlptjx6DyF4IO7XcTetdFOZ0sqeWeK0KxkJQ9hP4q7gjadE4CugR8QAnG36GmmbLBW+bqWPlf9Qg1QJNRUZKe2GzsIqQ3sVfVeHeuAbo1MU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366466; c=relaxed/simple;
	bh=re8gayKJqX7wtB2aUip/dTMGnIaKcXRJtJft1bXrpLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZSAYu3kkta0bAH9sKVGQVntZJohlwLcyCr5vcE11YKabDGlOcN0CdvX9u31nzgWawEg8C+v3VyPD7KC5bDEOIC05vLaKM6EqgP3QbUIT13fREkGGgtCnQflHRzgJZFwhxjCJhEaRefbw9np7ZsOChZAmmg4CXqViC5z6mMJylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2VNe5EI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5IYGWVxUA2LCxblG8GUdWUManYweqkS1nMwnfIC++w=;
	b=H2VNe5EIuFiP3yY4ymiDZ96SXUzISF09YCgfe5lGPz2S3YfvIaV9Qf22lo7cYhBLFX3NeS
	NsUAYYKI4chTd8Alt2p3HbhiFQCt+rzRzvOwwb7u+0Ff3WGNAagnQyYDLukqnYJyy7pWye
	CnwxEEALwWNaeFTkJXAp4VO5+PbZCZI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-UOjKkYpgPUSif_SpQ7oGeg-1; Wed, 13 Mar 2024 17:47:38 -0400
X-MC-Unique: UOjKkYpgPUSif_SpQ7oGeg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-690ab2b0de1so1163156d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366458; x=1710971258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5IYGWVxUA2LCxblG8GUdWUManYweqkS1nMwnfIC++w=;
        b=SWUWxIVcrErXeZST167+40Hi6GekICQehIm1HgxysyAFCC2WJz5GI6z7HHlL/6cpYX
         T7UNyPtRBfCPKrzZN7v9AwPYUYG2vXTCuCUh5yY8jRT+N+PkpqjAu4PIihu1zjNqpwQA
         PWIyPLK9kOVcnkcix8lG2pG6Kt7dcpOKIMMTeRuljvRQSHNyNBY6ZZiUx7vX6VNWdI0Y
         o4MpAEzZnjh5Ji3QGf8SXD08seBQtepa0QnzsKYScCKGOC2GdH3nklkj2qj+IaxeR/UL
         iWdIa7Io2JfIk9hJ7NX/QGy1KpRUxTTy7sSv60w9SOTU6wgpJ5eWPXqBa8a5OnTHYL6C
         SyxA==
X-Gm-Message-State: AOJu0YyjWhlJ++mdub8vQl4y6L5+IXqcpCzRnHh5k3WmXBCmBIqyWuTK
	0KVUreHIlAxv7362z3i1YM/km2mlOu9YAbXdtEjLxQmxhcWi5KhKnIot7701dzvXwKtloO0GoP9
	3m/S1fOgUoU7qTKw12a3nyCddtZG2x47atm6yBua+iFcaRqYCUGAi/e6jk2oIbFr73xUaJ0P4ou
	4c797f3PQsZpaP3X0u9UZQx6daj+4EWAXzIS0fF6dyj4A=
X-Received: by 2002:ad4:44af:0:b0:690:cdd5:ea47 with SMTP id n15-20020ad444af000000b00690cdd5ea47mr5817879qvt.4.1710366457923;
        Wed, 13 Mar 2024 14:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpS4qzMtDq6dHWn+zDTnC7YerPZmR6KmCZydssp8t/OhY0dbMM5c9rhqAeusvBg5vL+ogyTw==
X-Received: by 2002:ad4:44af:0:b0:690:cdd5:ea47 with SMTP id n15-20020ad444af000000b00690cdd5ea47mr5817849qvt.4.1710366457259;
        Wed, 13 Mar 2024 14:47:37 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:36 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	peterx@redhat.com,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 11/13] mm/treewide: Replace pXd_huge() with pXd_leaf()
Date: Wed, 13 Mar 2024 17:47:17 -0400
Message-ID: <20240313214719.253873-12-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313214719.253873-1-peterx@redhat.com>
References: <20240313214719.253873-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Now after we're sure all pXd_huge() definitions are the same as pXd_leaf(),
reuse it.  Luckily, pXd_huge() isn't widely used.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/include/asm/pgtable-3level.h | 2 +-
 arch/arm64/include/asm/pgtable.h      | 2 +-
 arch/arm64/mm/hugetlbpage.c           | 4 ++--
 arch/loongarch/mm/hugetlbpage.c       | 2 +-
 arch/mips/mm/tlb-r4k.c                | 2 +-
 arch/powerpc/mm/pgtable_64.c          | 6 +++---
 arch/x86/mm/pgtable.c                 | 4 ++--
 mm/gup.c                              | 4 ++--
 mm/hmm.c                              | 2 +-
 mm/memory.c                           | 2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index e7aecbef75c9..9e3c44f0aea2 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -190,7 +190,7 @@ static inline pte_t pte_mkspecial(pte_t pte)
 #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
 
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
-#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
+#define pmd_thp_or_huge(pmd)	(pmd_leaf(pmd) || pmd_trans_huge(pmd))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !pmd_table(pmd))
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 14d24c357c7a..c4efa47fed5f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -512,7 +512,7 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 	return pmd;
 }
 
-#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
+#define pmd_thp_or_huge(pmd)	(pmd_leaf(pmd) || pmd_trans_huge(pmd))
 
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 1234bbaef5bf..f494fc31201f 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -321,7 +321,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	if (sz != PUD_SIZE && pud_none(pud))
 		return NULL;
 	/* hugepage or swap? */
-	if (pud_huge(pud) || !pud_present(pud))
+	if (pud_leaf(pud) || !pud_present(pud))
 		return (pte_t *)pudp;
 	/* table; check the next level */
 
@@ -333,7 +333,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	if (!(sz == PMD_SIZE || sz == CONT_PMD_SIZE) &&
 	    pmd_none(pmd))
 		return NULL;
-	if (pmd_huge(pmd) || !pmd_present(pmd))
+	if (pmd_leaf(pmd) || !pmd_present(pmd))
 		return (pte_t *)pmdp;
 
 	if (sz == CONT_PTE_SIZE)
diff --git a/arch/loongarch/mm/hugetlbpage.c b/arch/loongarch/mm/hugetlbpage.c
index 1e76fcb83093..a4e78e74aa21 100644
--- a/arch/loongarch/mm/hugetlbpage.c
+++ b/arch/loongarch/mm/hugetlbpage.c
@@ -64,7 +64,7 @@ uint64_t pmd_to_entrylo(unsigned long pmd_val)
 {
 	uint64_t val;
 	/* PMD as PTE. Must be huge page */
-	if (!pmd_huge(__pmd(pmd_val)))
+	if (!pmd_leaf(__pmd(pmd_val)))
 		panic("%s", __func__);
 
 	val = pmd_val ^ _PAGE_HUGE;
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 4106084e57d7..76f3b9c0a9f0 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -326,7 +326,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	idx = read_c0_index();
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	/* this could be a huge page  */
-	if (pmd_huge(*pmdp)) {
+	if (pmd_leaf(*pmdp)) {
 		unsigned long lo;
 		write_c0_pagemask(PM_HUGE_MASK);
 		ptep = (pte_t *)pmdp;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 9b99113cb51a..6621cfc3baf8 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -102,7 +102,7 @@ struct page *p4d_page(p4d_t p4d)
 {
 	if (p4d_leaf(p4d)) {
 		if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
-			VM_WARN_ON(!p4d_huge(p4d));
+			VM_WARN_ON(!p4d_leaf(p4d));
 		return pte_page(p4d_pte(p4d));
 	}
 	return virt_to_page(p4d_pgtable(p4d));
@@ -113,7 +113,7 @@ struct page *pud_page(pud_t pud)
 {
 	if (pud_leaf(pud)) {
 		if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
-			VM_WARN_ON(!pud_huge(pud));
+			VM_WARN_ON(!pud_leaf(pud));
 		return pte_page(pud_pte(pud));
 	}
 	return virt_to_page(pud_pgtable(pud));
@@ -132,7 +132,7 @@ struct page *pmd_page(pmd_t pmd)
 		 * enabled so these checks can't be used.
 		 */
 		if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
-			VM_WARN_ON(!(pmd_leaf(pmd) || pmd_huge(pmd)));
+			VM_WARN_ON(!pmd_leaf(pmd));
 		return pte_page(pmd_pte(pmd));
 	}
 	return virt_to_page(pmd_page_vaddr(pmd));
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ff690ddc2334..d74f0814e086 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -731,7 +731,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 		return 0;
 
 	/* Bail out if we are we on a populated non-leaf entry: */
-	if (pud_present(*pud) && !pud_huge(*pud))
+	if (pud_present(*pud) && !pud_leaf(*pud))
 		return 0;
 
 	set_pte((pte_t *)pud, pfn_pte(
@@ -760,7 +760,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 	}
 
 	/* Bail out if we are we on a populated non-leaf entry: */
-	if (pmd_present(*pmd) && !pmd_huge(*pmd))
+	if (pmd_present(*pmd) && !pmd_leaf(*pmd))
 		return 0;
 
 	set_pte((pte_t *)pmd, pfn_pte(
diff --git a/mm/gup.c b/mm/gup.c
index e2415e9789bc..8e04a04ef138 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -778,7 +778,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	p4d = READ_ONCE(*p4dp);
 	if (!p4d_present(p4d))
 		return no_page_table(vma, flags);
-	BUILD_BUG_ON(p4d_huge(p4d));
+	BUILD_BUG_ON(p4d_leaf(p4d));
 	if (unlikely(p4d_bad(p4d)))
 		return no_page_table(vma, flags);
 
@@ -3070,7 +3070,7 @@ static int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr, unsigned lo
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(p4d))
 			return 0;
-		BUILD_BUG_ON(p4d_huge(p4d));
+		BUILD_BUG_ON(p4d_leaf(p4d));
 		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
 			if (!gup_huge_pd(__hugepd(p4d_val(p4d)), addr,
 					 P4D_SHIFT, next, flags, pages, nr))
diff --git a/mm/hmm.c b/mm/hmm.c
index c95b9ec5d95f..93aebd9cc130 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -429,7 +429,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
 
-	if (pud_huge(pud) && pud_devmap(pud)) {
+	if (pud_leaf(pud) && pud_devmap(pud)) {
 		unsigned long i, npages, pfn;
 		unsigned int required_fault;
 		unsigned long *hmm_pfns;
diff --git a/mm/memory.c b/mm/memory.c
index 904f70b99498..baee777dcd2d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2765,7 +2765,7 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 	unsigned long next;
 	int err = 0;
 
-	BUG_ON(pud_huge(*pud));
+	BUG_ON(pud_leaf(*pud));
 
 	if (create) {
 		pmd = pmd_alloc_track(mm, pud, addr, mask);
-- 
2.44.0


