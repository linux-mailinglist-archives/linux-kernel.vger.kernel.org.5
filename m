Return-Path: <linux-kernel+bounces-86329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A56886C3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6CF282068
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B235524D0;
	Thu, 29 Feb 2024 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMF3HkMv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844EC50275
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196212; cv=none; b=Wv+mzj6/kIuovm3yApG1wqZV/iIovmrR14TuDSptClZOg8eLMOyFxmaYrwqsKQs9Qt7RACccIlbqQK33bUZRmPvjF4fVEQT1YsxGrtwEU8qP1BgFQxDRQ2fwKoqPm1qTRNKLsgpww5Gyg3nppJEW8dHPYJEGcSDGbhFx9f8K3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196212; c=relaxed/simple;
	bh=D3gosUAbJ411jF5gJMOHU52/qPrsWux46CaF4VHvHXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3yENasO0UUPfpdANUmPNvrDMKTt/2M7fkbheeJ7NtLEeI8LZxSCdCGQRrrPbykrk+b1gIctGe56NE+IOwMaKCemUaWZv5sgi7G3I5XgBJIeSqAzn7KrV/8yjg9SLvEOOpa0ap8ydruC4dR2OkN2JGrkQ5M0CUqV/9cKwLUC6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMF3HkMv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709196209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEIsgpr2yLoy4elJT8aXcINQKUFxaL7Rf0iNOo8Hn4s=;
	b=FMF3HkMv4tmab7s0fPbIp+yoZkg45MOf1NVZjK4nFBn4WqsEPAzObIHcIGaUWgDzKgl0/E
	QOpOLQXdWAv/cTvMk8xvYVDghQS6SoXA7v4m4B7a0U08rYfxdx4JUTCE2p6aKDvx3/gzSR
	l+WKGY3DHNVgLAaY0C3IZfbocvYFkc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-ZGrhDu18OWup79m2yW0rKA-1; Thu, 29 Feb 2024 03:43:22 -0500
X-MC-Unique: ZGrhDu18OWup79m2yW0rKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DEB184AC60;
	Thu, 29 Feb 2024 08:43:22 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 436911807;
	Thu, 29 Feb 2024 08:43:14 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>,
	peterx@redhat.com,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/7] mm/ppc: Replace pXd_is_leaf() with pXd_leaf()
Date: Thu, 29 Feb 2024 16:42:53 +0800
Message-ID: <20240229084258.599774-3-peterx@redhat.com>
In-Reply-To: <20240229084258.599774-1-peterx@redhat.com>
References: <20240229084258.599774-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

From: Peter Xu <peterx@redhat.com>

They're the same macros underneath.  Drop pXd_is_leaf(), instead always use
pXd_leaf().

At the meantime, instead of renames, drop the pXd_is_leaf() fallback
definitions directly in arch/powerpc/include/asm/pgtable.h. because similar
fallback macros for pXd_leaf() are already defined in
include/linux/pgtable.h.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 ++++----
 arch/powerpc/include/asm/pgtable.h           | 24 --------------------
 arch/powerpc/kvm/book3s_64_mmu_radix.c       | 12 +++++-----
 arch/powerpc/mm/book3s64/radix_pgtable.c     | 14 ++++++------
 arch/powerpc/mm/pgtable.c                    |  6 ++---
 arch/powerpc/mm/pgtable_64.c                 |  6 ++---
 arch/powerpc/xmon/xmon.c                     |  6 ++---
 7 files changed, 26 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d1318e8582ac..3e99e409774a 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1439,18 +1439,16 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
 /*
  * Like pmd_huge() and pmd_large(), but works regardless of config options
  */
-#define pmd_is_leaf pmd_is_leaf
-#define pmd_leaf pmd_is_leaf
+#define pmd_leaf pmd_leaf
 #define pmd_large pmd_leaf
-static inline bool pmd_is_leaf(pmd_t pmd)
+static inline bool pmd_leaf(pmd_t pmd)
 {
 	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
 }
 
-#define pud_is_leaf pud_is_leaf
-#define pud_leaf pud_is_leaf
+#define pud_leaf pud_leaf
 #define pud_large pud_leaf
-static inline bool pud_is_leaf(pud_t pud)
+static inline bool pud_leaf(pud_t pud)
 {
 	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
 }
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 5928b3c1458d..e6edf1cdbc5b 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -182,30 +182,6 @@ static inline void pte_frag_set(mm_context_t *ctx, void *p)
 }
 #endif
 
-#ifndef pmd_is_leaf
-#define pmd_is_leaf pmd_is_leaf
-static inline bool pmd_is_leaf(pmd_t pmd)
-{
-	return false;
-}
-#endif
-
-#ifndef pud_is_leaf
-#define pud_is_leaf pud_is_leaf
-static inline bool pud_is_leaf(pud_t pud)
-{
-	return false;
-}
-#endif
-
-#ifndef p4d_is_leaf
-#define p4d_is_leaf p4d_is_leaf
-static inline bool p4d_is_leaf(p4d_t p4d)
-{
-	return false;
-}
-#endif
-
 #define pmd_pgtable pmd_pgtable
 static inline pgtable_t pmd_pgtable(pmd_t pmd)
 {
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 4a1abb9f7c05..408d98f8a514 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -503,7 +503,7 @@ static void kvmppc_unmap_free_pmd(struct kvm *kvm, pmd_t *pmd, bool full,
 	for (im = 0; im < PTRS_PER_PMD; ++im, ++p) {
 		if (!pmd_present(*p))
 			continue;
-		if (pmd_is_leaf(*p)) {
+		if (pmd_leaf(*p)) {
 			if (full) {
 				pmd_clear(p);
 			} else {
@@ -532,7 +532,7 @@ static void kvmppc_unmap_free_pud(struct kvm *kvm, pud_t *pud,
 	for (iu = 0; iu < PTRS_PER_PUD; ++iu, ++p) {
 		if (!pud_present(*p))
 			continue;
-		if (pud_is_leaf(*p)) {
+		if (pud_leaf(*p)) {
 			pud_clear(p);
 		} else {
 			pmd_t *pmd;
@@ -635,12 +635,12 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 		new_pud = pud_alloc_one(kvm->mm, gpa);
 
 	pmd = NULL;
-	if (pud && pud_present(*pud) && !pud_is_leaf(*pud))
+	if (pud && pud_present(*pud) && !pud_leaf(*pud))
 		pmd = pmd_offset(pud, gpa);
 	else if (level <= 1)
 		new_pmd = kvmppc_pmd_alloc();
 
-	if (level == 0 && !(pmd && pmd_present(*pmd) && !pmd_is_leaf(*pmd)))
+	if (level == 0 && !(pmd && pmd_present(*pmd) && !pmd_leaf(*pmd)))
 		new_ptep = kvmppc_pte_alloc();
 
 	/* Check if we might have been invalidated; let the guest retry if so */
@@ -658,7 +658,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 		new_pud = NULL;
 	}
 	pud = pud_offset(p4d, gpa);
-	if (pud_is_leaf(*pud)) {
+	if (pud_leaf(*pud)) {
 		unsigned long hgpa = gpa & PUD_MASK;
 
 		/* Check if we raced and someone else has set the same thing */
@@ -709,7 +709,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 		new_pmd = NULL;
 	}
 	pmd = pmd_offset(pud, gpa);
-	if (pmd_is_leaf(*pmd)) {
+	if (pmd_leaf(*pmd)) {
 		unsigned long lgpa = gpa & PMD_MASK;
 
 		/* Check if we raced and someone else has set the same thing */
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index c6a4ac766b2b..1f8db10693e3 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -204,14 +204,14 @@ static void radix__change_memory_range(unsigned long start, unsigned long end,
 		pudp = pud_alloc(&init_mm, p4dp, idx);
 		if (!pudp)
 			continue;
-		if (pud_is_leaf(*pudp)) {
+		if (pud_leaf(*pudp)) {
 			ptep = (pte_t *)pudp;
 			goto update_the_pte;
 		}
 		pmdp = pmd_alloc(&init_mm, pudp, idx);
 		if (!pmdp)
 			continue;
-		if (pmd_is_leaf(*pmdp)) {
+		if (pmd_leaf(*pmdp)) {
 			ptep = pmdp_ptep(pmdp);
 			goto update_the_pte;
 		}
@@ -767,7 +767,7 @@ static void __meminit remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 		if (!pmd_present(*pmd))
 			continue;
 
-		if (pmd_is_leaf(*pmd)) {
+		if (pmd_leaf(*pmd)) {
 			if (IS_ALIGNED(addr, PMD_SIZE) &&
 			    IS_ALIGNED(next, PMD_SIZE)) {
 				if (!direct)
@@ -807,7 +807,7 @@ static void __meminit remove_pud_table(pud_t *pud_start, unsigned long addr,
 		if (!pud_present(*pud))
 			continue;
 
-		if (pud_is_leaf(*pud)) {
+		if (pud_leaf(*pud)) {
 			if (!IS_ALIGNED(addr, PUD_SIZE) ||
 			    !IS_ALIGNED(next, PUD_SIZE)) {
 				WARN_ONCE(1, "%s: unaligned range\n", __func__);
@@ -845,7 +845,7 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct,
 		if (!p4d_present(*p4d))
 			continue;
 
-		if (p4d_is_leaf(*p4d)) {
+		if (p4d_leaf(*p4d)) {
 			if (!IS_ALIGNED(addr, P4D_SIZE) ||
 			    !IS_ALIGNED(next, P4D_SIZE)) {
 				WARN_ONCE(1, "%s: unaligned range\n", __func__);
@@ -1554,7 +1554,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 
 int pud_clear_huge(pud_t *pud)
 {
-	if (pud_is_leaf(*pud)) {
+	if (pud_leaf(*pud)) {
 		pud_clear(pud);
 		return 1;
 	}
@@ -1601,7 +1601,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 
 int pmd_clear_huge(pmd_t *pmd)
 {
-	if (pmd_is_leaf(*pmd)) {
+	if (pmd_leaf(*pmd)) {
 		pmd_clear(pmd);
 		return 1;
 	}
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 549a440ed7f6..9e7ba9c3851f 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -410,7 +410,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	if (p4d_none(p4d))
 		return NULL;
 
-	if (p4d_is_leaf(p4d)) {
+	if (p4d_leaf(p4d)) {
 		ret_pte = (pte_t *)p4dp;
 		goto out;
 	}
@@ -432,7 +432,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	if (pud_none(pud))
 		return NULL;
 
-	if (pud_is_leaf(pud)) {
+	if (pud_leaf(pud)) {
 		ret_pte = (pte_t *)pudp;
 		goto out;
 	}
@@ -471,7 +471,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 		goto out;
 	}
 
-	if (pmd_is_leaf(pmd)) {
+	if (pmd_leaf(pmd)) {
 		ret_pte = (pte_t *)pmdp;
 		goto out;
 	}
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 1b366526f4f2..386c6b06eab7 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL(__pte_frag_size_shift);
 /* 4 level page table */
 struct page *p4d_page(p4d_t p4d)
 {
-	if (p4d_is_leaf(p4d)) {
+	if (p4d_leaf(p4d)) {
 		if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
 			VM_WARN_ON(!p4d_huge(p4d));
 		return pte_page(p4d_pte(p4d));
@@ -111,7 +111,7 @@ struct page *p4d_page(p4d_t p4d)
 
 struct page *pud_page(pud_t pud)
 {
-	if (pud_is_leaf(pud)) {
+	if (pud_leaf(pud)) {
 		if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
 			VM_WARN_ON(!pud_huge(pud));
 		return pte_page(pud_pte(pud));
@@ -125,7 +125,7 @@ struct page *pud_page(pud_t pud)
  */
 struct page *pmd_page(pmd_t pmd)
 {
-	if (pmd_is_leaf(pmd)) {
+	if (pmd_leaf(pmd)) {
 		/*
 		 * vmalloc_to_page may be called on any vmap address (not only
 		 * vmalloc), and it uses pmd_page() etc., when huge vmap is
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index b3b94cd37713..9669c9925225 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3342,7 +3342,7 @@ static void show_pte(unsigned long addr)
 		return;
 	}
 
-	if (p4d_is_leaf(*p4dp)) {
+	if (p4d_leaf(*p4dp)) {
 		format_pte(p4dp, p4d_val(*p4dp));
 		return;
 	}
@@ -3356,7 +3356,7 @@ static void show_pte(unsigned long addr)
 		return;
 	}
 
-	if (pud_is_leaf(*pudp)) {
+	if (pud_leaf(*pudp)) {
 		format_pte(pudp, pud_val(*pudp));
 		return;
 	}
@@ -3370,7 +3370,7 @@ static void show_pte(unsigned long addr)
 		return;
 	}
 
-	if (pmd_is_leaf(*pmdp)) {
+	if (pmd_leaf(*pmdp)) {
 		format_pte(pmdp, pmd_val(*pmdp));
 		return;
 	}
-- 
2.43.0


