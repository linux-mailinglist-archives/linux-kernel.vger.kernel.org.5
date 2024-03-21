Return-Path: <linux-kernel+bounces-110737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4CF886300
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812FA1C21F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D1136986;
	Thu, 21 Mar 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIiA8dA1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080413792C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058911; cv=none; b=F9hSEZjJNrQnROKAC1nCqfaW7dv+oJOtSTXrAdTs8WGQKo64gbXLKhoSg3KKcDRt4Mj8nl8mfV/FGZn6ea3lb5Qi+XPVjcPAdW3CBuHxvYhZ9WlUlltYaYDsYSmb64+wfFWOW0dVGLC3Q9FjEd+D8DmAxbGjG82NB26gXnPc+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058911; c=relaxed/simple;
	bh=vIJxD1xmNJcziuLdkeQlq8aVMJXM76SBgb0FOm9yvPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjiNhPmeXj5c3pIkt2XPO62pAp4dl8bZdjtbt1/l5i9sGZJMvjOr6ZKGrzDwu2V+6YjGDyBrEEFUwI5nOezvRfhVrttpgF+3FRRCJfbge80NrNIxrvfowhqdwjv6wX4aS16nN/iE5XANy7cktUMWFyqzvXoFeCyP7xUY3gUsznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIiA8dA1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0KbP6b9RlV02LlNjzHhHyMPZ1vhd/KMB6w1UdD4tH4=;
	b=dIiA8dA1EoTmPTTsoe2Log5FBWyUKBYLvL87GFBN9x5jG/K2G3vHoYtA0qYNKd9BZl90Bg
	msbFEhE8JwxYwXDIr0XESd9gyTgvvehJfyz2L+9+twEU2d9aK0yt5p1QqarGsJDH17s1pf
	1DqzY+Kis0sUCINqiksQt1xN6a6aznc=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-reuvHv2pP4Khd5wKcVdyLg-1; Thu, 21 Mar 2024 18:08:27 -0400
X-MC-Unique: reuvHv2pP4Khd5wKcVdyLg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-222b55202f4so525966fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058907; x=1711663707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0KbP6b9RlV02LlNjzHhHyMPZ1vhd/KMB6w1UdD4tH4=;
        b=jC14gpS/CgPQNb5ChCgoU5iRpIVKetlfH/YJSN1XJ5JTkCHFR5BaGtgNyTRerqcp9H
         KafjlT2OknbA/cnorb7Y4pi8X1VP93f39adOqTRz5heP54l3TLJZlEBjsR+OOelLilna
         2QvEIjZXmEfd9Zox1CGq0/h0+2yYhmF0LPL6u8F/khHDuVmTyERzoHpj9yRCCZDqnSaH
         VoWMLRUixOmgxRX78Tllbq+26JjAFckXtNxGqVqoTFa8sjUniFFf9pTs0lWqNRqyUANn
         fLXb/bUJbZVk1Yw6o4z0R8UCa+4/lh7u6N1fwadKTehivWNG0AdUuGOQOEwkXl7VlwQq
         6X+w==
X-Forwarded-Encrypted: i=1; AJvYcCX3Mv4nZaEhEml5vmXpRjaeqd4yqqjA7stnzckyi5RSSHEj9X+mPT1jN45Ts9/8aAQxy9yDOKweGSa4UT4/vWht6m0D1AOh9bVNTEb0
X-Gm-Message-State: AOJu0YzytB/rmE3EGBAsQi11Lv+X+4dD0yz75ssvAISB+RFbt5FXEwSZ
	0Cf6CE+pCwPdex64sfCIeUbCgEAfkMk9fYaZnO+14PVWgHelnvdhZikBDFIMb1ZdgBoG5V/V3Xg
	zi/Mvvd+ii0eA07FsXX3Sv4VWcdgpckMjaXcUm4rJ2gY0MXSKW11+ltc6b33fNw==
X-Received: by 2002:a05:6870:4189:b0:229:8575:875b with SMTP id y9-20020a056870418900b002298575875bmr520309oac.5.1711058906669;
        Thu, 21 Mar 2024 15:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyRVGIH/+XEvquuQvEBSJicroe5v4UAFWGp7nk+sM4AQMJKL66g328LmVlireG12paxfzEyQ==
X-Received: by 2002:a05:6870:4189:b0:229:8575:875b with SMTP id y9-20020a056870418900b002298575875bmr520279oac.5.1711058906111;
        Thu, 21 Mar 2024 15:08:26 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:25 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	peterx@redhat.com,
	Yang Shi <shy828301@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 11/12] mm/gup: Handle hugepd for follow_page()
Date: Thu, 21 Mar 2024 18:08:01 -0400
Message-ID: <20240321220802.679544-12-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321220802.679544-1-peterx@redhat.com>
References: <20240321220802.679544-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Hugepd is only used in PowerPC so far on 4K page size kernels where hash
mmu is used.  follow_page_mask() used to leverage hugetlb APIs to access
hugepd entries.  Teach follow_page_mask() itself on hugepd.

With previous refactors on fast-gup gup_huge_pd(), most of the code can be
easily leveraged.  There's something not needed for follow page, for
example, gup_hugepte() tries to detect pgtable entry change which will
never happen with slow gup (which has the pgtable lock held), but that's
not a problem to check.

Since follow_page() always only fetch one page, set the end to "address +
PAGE_SIZE" should suffice.  We will still do the pgtable walk once for each
hugetlb page by setting ctx->page_mask properly.

One thing worth mentioning is that some level of pgtable's _bad() helper
will report is_hugepd() entries as TRUE on Power8 hash MMUs.  I think it at
least applies to PUD on Power8 with 4K pgsize.  It means feeding a hugepd
entry to pud_bad() will report a false positive. Let's leave that for now
because it can be arch-specific where I am a bit declined to touch.  In
this patch it's not a problem as long as hugepd is detected before any bad
pgtable entries.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 00cdf4cb0cd4..43a2e0a203cd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -30,6 +30,11 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
+static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
+				  unsigned long addr, unsigned int pdshift,
+				  unsigned int flags,
+				  struct follow_page_context *ctx);
+
 static inline void sanity_check_pinned_pages(struct page **pages,
 					     unsigned long npages)
 {
@@ -871,6 +876,9 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags, address);
+	if (unlikely(is_hugepd(__hugepd(pmd_val(pmdval)))))
+		return follow_hugepd(vma, __hugepd(pmd_val(pmdval)),
+				     address, PMD_SHIFT, flags, ctx);
 	if (pmd_devmap(pmdval)) {
 		ptl = pmd_lock(mm, pmd);
 		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
@@ -921,6 +929,9 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	pud = READ_ONCE(*pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
+	if (unlikely(is_hugepd(__hugepd(pud_val(pud)))))
+		return follow_hugepd(vma, __hugepd(pud_val(pud)),
+				     address, PUD_SHIFT, flags, ctx);
 	if (pud_leaf(pud)) {
 		ptl = pud_lock(mm, pudp);
 		page = follow_huge_pud(vma, address, pudp, flags, ctx);
@@ -944,10 +955,13 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 
 	p4dp = p4d_offset(pgdp, address);
 	p4d = READ_ONCE(*p4dp);
-	if (!p4d_present(p4d))
-		return no_page_table(vma, flags, address);
 	BUILD_BUG_ON(p4d_leaf(p4d));
-	if (unlikely(p4d_bad(p4d)))
+
+	if (unlikely(is_hugepd(__hugepd(p4d_val(p4d)))))
+		return follow_hugepd(vma, __hugepd(p4d_val(p4d)),
+				     address, P4D_SHIFT, flags, ctx);
+
+	if (!p4d_present(p4d) || p4d_bad(p4d))
 		return no_page_table(vma, flags, address);
 
 	return follow_pud_mask(vma, address, p4dp, flags, ctx);
@@ -981,7 +995,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 			      unsigned long address, unsigned int flags,
 			      struct follow_page_context *ctx)
 {
-	pgd_t *pgd;
+	pgd_t *pgd, pgdval;
 	struct mm_struct *mm = vma->vm_mm;
 
 	ctx->page_mask = 0;
@@ -996,11 +1010,17 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 						&ctx->page_mask);
 
 	pgd = pgd_offset(mm, address);
+	pgdval = *pgd;
 
-	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		return no_page_table(vma, flags, address);
+	if (unlikely(is_hugepd(__hugepd(pgd_val(pgdval)))))
+		page = follow_hugepd(vma, __hugepd(pgd_val(pgdval)),
+				     address, PGDIR_SHIFT, flags, ctx);
+	else if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+		page = no_page_table(vma, flags, address);
+	else
+		page = follow_p4d_mask(vma, address, pgd, flags, ctx);
 
-	return follow_p4d_mask(vma, address, pgd, flags, ctx);
+	return page;
 }
 
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
@@ -3037,6 +3057,37 @@ static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
 
 	return 1;
 }
+
+static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
+				  unsigned long addr, unsigned int pdshift,
+				  unsigned int flags,
+				  struct follow_page_context *ctx)
+{
+	struct page *page;
+	struct hstate *h;
+	spinlock_t *ptl;
+	int nr = 0, ret;
+	pte_t *ptep;
+
+	/* Only hugetlb supports hugepd */
+	if (WARN_ON_ONCE(!is_vm_hugetlb_page(vma)))
+		return ERR_PTR(-EFAULT);
+
+	h = hstate_vma(vma);
+	ptep = hugepte_offset(hugepd, addr, pdshift);
+	ptl = huge_pte_lock(h, vma->vm_mm, ptep);
+	ret = gup_huge_pd(hugepd, addr, pdshift, addr + PAGE_SIZE,
+			  flags, &page, &nr);
+	spin_unlock(ptl);
+
+	if (ret) {
+		WARN_ON_ONCE(nr != 1);
+		ctx->page_mask = (1U << huge_page_order(h)) - 1;
+		return page;
+	}
+
+	return NULL;
+}
 #else
 static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
 		unsigned int pdshift, unsigned long end, unsigned int flags,
@@ -3044,6 +3095,14 @@ static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
 {
 	return 0;
 }
+
+static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
+				  unsigned long addr, unsigned int pdshift,
+				  unsigned int flags,
+				  struct follow_page_context *ctx)
+{
+	return NULL;
+}
 #endif /* CONFIG_ARCH_HAS_HUGEPD */
 
 static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-- 
2.44.0


