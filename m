Return-Path: <linux-kernel+bounces-161546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8908B4D8F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307501C20A2B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C755074BE5;
	Sun, 28 Apr 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvXucAWf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DAEEC6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714330920; cv=none; b=UhT/65ONXVzwZlvk+RpTnP0Qh3PvB3nTqhKcYCDZwYTrGhgNNYw4wxf5qxYc7qB6KQYcohBUb6jy3vGVOXNbQs2zQufuc8y/iGN8ebuOkBJ9RAPwSed7SQgozwuLkwC2n2y77GMTlvNTVxelFZ2MWMXHl8LM/3N7eM0CCwzoNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714330920; c=relaxed/simple;
	bh=Lg5fQVF0mglFNHDdxhhQVAJMKZD6+4vCdL9v2vUiliQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iprru9mOf/ptZUbM6NGgiO/ylXHjK0LEXXNRgyNSamvCYkKuUzWhdfOhMm5Ich0XwnXLi33dWgPM8Vb5lhp4roUbzzwzfeAe9sduIDOGqQq0/4Y0+hrMcJtPZzu8Q1WjZTe0g+FvbGxl42GLTiMXePj2GWjr+opCWxW5jIAgxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvXucAWf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714330917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1t4UcvVVCt+Lz5av6btBnWLmCHNkWkDBAkPZW0Lpq7g=;
	b=GvXucAWfhevlb7zMEKWUQnMJj1gffcpGnVLV3F2wyUyrDHAt9wZ3zVDOn/4Vo94PCjjGQf
	y1bWBmo9ICgvOHZ0QL6FgCH40GmNie3FpBT6zLPfz8xVm8fe1aFeGSynQewZNe/j1RypKQ
	nWohF+5QYHcBkoJOD6xIa7MFHVVr3AE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-FbcYGLo0PTOzx0tu0YFozw-1; Sun, 28 Apr 2024 15:01:56 -0400
X-MC-Unique: FbcYGLo0PTOzx0tu0YFozw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-434ed2e412fso12001231cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714330916; x=1714935716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1t4UcvVVCt+Lz5av6btBnWLmCHNkWkDBAkPZW0Lpq7g=;
        b=mhQgOHUELCP02ppgMzzLmAobgl1YcU+cpBvfBRy7WjRQTXYn3qqTnXhqTuiYIzseOU
         VQ0Cn5DdJYopRY5gTGODykZ2MQsHf26/y3vCDkcS7WA9a4WTy9uZ8NPXsPJ2I0NFep5U
         QmglhYPtifCcEOkLerxkqEHKbNpQ/Tgwj9VS06Y6rsdkCQxMs9nIN67ejUwnc7s1ENVP
         gJciEGbN+ZbxgNgFbaFK5bEDpx5BHbAnVGA+P4Ogs94zsh+LnS+FXfaDsWwDySXQ4Q/Q
         c/HvnY51SzDAY33RqrZsY2zhM4BRYUtBwJhaC6kbiEIEHNV9f7KCZiQORWlTehJOL5c4
         6zSw==
X-Gm-Message-State: AOJu0Yw+WLLNsnKZ/pxrouEbMW0/W0W72N5E+GrUAU8OjhBiMNe2g3Oy
	6BBj3/uzYJnilWuwu8kOqJWCREXRj/CE6pX6Qf3Zrn76bRQgSSvaOt87lMFaXt70ZXLcscWQ50o
	VSSvR9z3lIWHISnkG8gusjZ+lsXxGNbVrFK3n3syGrq7HcxpRMIvgY6F0m5hrNp3AEW+MAZKrrs
	tBSGBv/kw0i7U4Xe70XW8iCML1EpcpU55/vNglxxb78Co=
X-Received: by 2002:a05:620a:17a0:b0:790:e83a:e6eb with SMTP id ay32-20020a05620a17a000b00790e83ae6ebmr4022700qkb.5.1714330915224;
        Sun, 28 Apr 2024 12:01:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq4u33yQLthyJZ4VKOCA3UIJSHLI7n1RNa/Jea7Dll1CjPi5vBpPXi0aewsChF2WFetPSb5Q==
X-Received: by 2002:a05:620a:17a0:b0:790:e83a:e6eb with SMTP id ay32-20020a05620a17a000b00790e83ae6ebmr4022657qkb.5.1714330914396;
        Sun, 28 Apr 2024 12:01:54 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id oo8-20020a05620a530800b0078d693c0b4bsm9818152qkn.135.2024.04.28.12.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 12:01:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/2] mm/gup: Fix hugepd handling in hugetlb rework
Date: Sun, 28 Apr 2024 15:01:50 -0400
Message-ID: <20240428190151.201002-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240428190151.201002-1-peterx@redhat.com>
References: <20240428190151.201002-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a12083d721d7 added hugepd handling for gup-slow, reusing gup-fast
functions.  follow_hugepd() correctly took the vma pointer in, however
didn't pass it over into the lower functions, which was overlooked.

The issue is gup_fast_hugepte() uses the vma pointer to make the correct
decision on whether an unshare is needed for a FOLL_PIN|FOLL_LONGTERM.  Now
without vma ponter it will constantly return "true" (needs an unshare) for
a page cache, even though in the SHARED case it will be wrong to unshare.

The other problem is, even if an unshare is needed, it now returns 0 rather
than -EMLINK, which will not trigger a follow up FAULT_FLAG_UNSHARE fault.
That will need to be fixed too when the unshare is wanted.

gup_longterm test didn't expose this issue in the past because it didn't
yet test R/O unshare in this case, another separate patch will enable that
in future tests.

Fix it by passing vma correctly to the bottom, rename gup_fast_hugepte()
back to gup_hugepte() as it is shared between the fast/slow paths, and also
allow -EMLINK to be returned properly by gup_hugepte() even though gup-fast
will take it the same as zero.

Reported-by: David Hildenbrand <david@redhat.com>
Fixes: a12083d721d7 ("mm/gup: handle hugepd for follow_page()")
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Note: The target commit to be fixed should just been moved into mm-stable,
so no need to cc stable.
---
 mm/gup.c | 64 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2f7baf96f655..ca0f5cedce9b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -525,9 +525,17 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 	return (__boundary - 1 < end - 1) ? __boundary : end;
 }
 
-static int gup_fast_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
+/*
+ * Returns 1 if succeeded, 0 if failed, -EMLINK if unshare needed.
+ *
+ * NOTE: for the same entry, gup-fast and gup-slow can return different
+ * results (0 v.s. -EMLINK) depending on whether vma is available.  This is
+ * the expected behavior, where we simply want gup-fast to fallback to
+ * gup-slow to take the vma reference first.
+ */
+static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz,
+		       unsigned long addr, unsigned long end, unsigned int flags,
+		       struct page **pages, int *nr)
 {
 	unsigned long pte_end;
 	struct page *page;
@@ -559,9 +567,9 @@ static int gup_fast_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		return 0;
 	}
 
-	if (!pte_write(pte) && gup_must_unshare(NULL, flags, &folio->page)) {
+	if (!pte_write(pte) && gup_must_unshare(vma, flags, &folio->page)) {
 		gup_put_folio(folio, refs, flags);
-		return 0;
+		return -EMLINK;
 	}
 
 	*nr += refs;
@@ -577,19 +585,22 @@ static int gup_fast_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
  * of the other folios. See writable_file_mapping_allowed() and
  * gup_fast_folio_allowed() for more information.
  */
-static int gup_fast_hugepd(hugepd_t hugepd, unsigned long addr,
-		unsigned int pdshift, unsigned long end, unsigned int flags,
-		struct page **pages, int *nr)
+static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
+		      unsigned long addr, unsigned int pdshift,
+		      unsigned long end, unsigned int flags,
+		      struct page **pages, int *nr)
 {
 	pte_t *ptep;
 	unsigned long sz = 1UL << hugepd_shift(hugepd);
 	unsigned long next;
+	int ret;
 
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	do {
 		next = hugepte_addr_end(addr, end, sz);
-		if (!gup_fast_hugepte(ptep, sz, addr, end, flags, pages, nr))
-			return 0;
+		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr);
+		if (ret != 1)
+			return ret;
 	} while (ptep++, addr = next, addr != end);
 
 	return 1;
@@ -613,22 +624,25 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 	h = hstate_vma(vma);
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	ptl = huge_pte_lock(h, vma->vm_mm, ptep);
-	ret = gup_fast_hugepd(hugepd, addr, pdshift, addr + PAGE_SIZE,
-			      flags, &page, &nr);
+	ret = gup_hugepd(vma, hugepd, addr, pdshift, addr + PAGE_SIZE,
+			 flags, &page, &nr);
 	spin_unlock(ptl);
 
-	if (ret) {
+	if (ret == 1) {
+		/* GUP succeeded */
 		WARN_ON_ONCE(nr != 1);
 		ctx->page_mask = (1U << huge_page_order(h)) - 1;
 		return page;
 	}
 
-	return NULL;
+	/* ret can be either 0 (translates to NULL) or negative */
+	return ERR_PTR(ret);
 }
 #else /* CONFIG_ARCH_HAS_HUGEPD */
-static inline int gup_fast_hugepd(hugepd_t hugepd, unsigned long addr,
-		unsigned int pdshift, unsigned long end, unsigned int flags,
-		struct page **pages, int *nr)
+static inline int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
+			     unsigned long addr, unsigned int pdshift,
+			     unsigned long end, unsigned int flags,
+			     struct page **pages, int *nr)
 {
 	return 0;
 }
@@ -3261,8 +3275,8 @@ static int gup_fast_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr,
 			 * architecture have different format for hugetlbfs
 			 * pmd format and THP pmd format
 			 */
-			if (!gup_fast_hugepd(__hugepd(pmd_val(pmd)), addr,
-					     PMD_SHIFT, next, flags, pages, nr))
+			if (gup_hugepd(NULL, __hugepd(pmd_val(pmd)), addr,
+				       PMD_SHIFT, next, flags, pages, nr) != 1)
 				return 0;
 		} else if (!gup_fast_pte_range(pmd, pmdp, addr, next, flags,
 					       pages, nr))
@@ -3291,8 +3305,8 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
 					       pages, nr))
 				return 0;
 		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
-			if (!gup_fast_hugepd(__hugepd(pud_val(pud)), addr,
-					     PUD_SHIFT, next, flags, pages, nr))
+			if (gup_hugepd(NULL, __hugepd(pud_val(pud)), addr,
+				       PUD_SHIFT, next, flags, pages, nr) != 1)
 				return 0;
 		} else if (!gup_fast_pmd_range(pudp, pud, addr, next, flags,
 					       pages, nr))
@@ -3318,8 +3332,8 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 			return 0;
 		BUILD_BUG_ON(p4d_leaf(p4d));
 		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
-			if (!gup_fast_hugepd(__hugepd(p4d_val(p4d)), addr,
-					     P4D_SHIFT, next, flags, pages, nr))
+			if (gup_hugepd(NULL, __hugepd(p4d_val(p4d)), addr,
+				       P4D_SHIFT, next, flags, pages, nr) != 1)
 				return 0;
 		} else if (!gup_fast_pud_range(p4dp, p4d, addr, next, flags,
 					       pages, nr))
@@ -3347,8 +3361,8 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 					       pages, nr))
 				return;
 		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
-			if (!gup_fast_hugepd(__hugepd(pgd_val(pgd)), addr,
-					      PGDIR_SHIFT, next, flags, pages, nr))
+			if (gup_hugepd(NULL, __hugepd(pgd_val(pgd)), addr,
+				       PGDIR_SHIFT, next, flags, pages, nr) != 1)
 				return;
 		} else if (!gup_fast_p4d_range(pgdp, pgd, addr, next, flags,
 					       pages, nr))
-- 
2.44.0


