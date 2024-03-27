Return-Path: <linux-kernel+bounces-121507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE46988EABB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2BDB3A542
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA399137779;
	Wed, 27 Mar 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aR0s4wNn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83413E6CA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553046; cv=none; b=N7LOTZk3LAdgYbzUcjewEvQgr6E4iW8rMvSw2YqH5JesPuHOkeySVpL1jhcKi4sJz+DYIxJl+Rqn39lHI0Hn8IK6JT4UGt+ffnwy6Xvmz7T9d/SPwIDCCNZWMiV/pgjabExsQeI4x0EXtK9AJByW/9xqbRn+hltwa/VQVFN+mPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553046; c=relaxed/simple;
	bh=wHolJt++Lm8o7MeXb+Mlp23nTs4ZFP6jgKqABTJPx3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNFXJAcVYUMJrjBLTVe5oS/60eDalWg+WxKfzTMB26ivgHYhgqhrUXQOa9tOMcliYjGWFpgWcoP9ItEtKchx29hN2uCdez6Dja7wz2KuQaWh/tZbZ8fWfkvOYO9/J+5fmq0tK4TDM7vMiYHnY/WuINZYOnRr8Wjsu1WUL467t5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aR0s4wNn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjVJdBQT9/0ffkgcc4+ae3LmOxlOj4cpHe90WMWbkEY=;
	b=aR0s4wNnA0XeWbAfp6Mo61Jj0O0xFSIn2xCiG88UXBDnjyHW2t4sNSB4BBCp4458H5+AEc
	M+LeDhIcqHEoeMbUZ4VfUmI8wPNw9q7N9gU7GBtSkJFtKdyv0mY/N+zvX1mQKksy75L00B
	etwdCFLxEwMf0+qMQ+60Dt4HYB7/ckw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-aM7uMknSMGuaJ6Qv5wZD_Q-1; Wed, 27 Mar 2024 11:24:02 -0400
X-MC-Unique: aM7uMknSMGuaJ6Qv5wZD_Q-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c3c43470d7so1243366b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553041; x=1712157841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjVJdBQT9/0ffkgcc4+ae3LmOxlOj4cpHe90WMWbkEY=;
        b=Z5NphEyyJEeoruOuPz801BVy8XuW5a/ZK4bAkPOc7e+RcpoVatZuzg5buY75ggX9CG
         IvYHJk9/vzKtMky+C8Nr44G5axeLqh3jeCiQXPL1CowZQG9O5CsTRO+4z7tsVTk36gtV
         5gyCzYEnuSvSZ/FG9smzcZ78vPrM1u2WhHmBi3oKmjp9bAh5pBcV60p51RIZDdZYQ2/9
         yi0F76WbcXLh/UNETyJyg6ZwbeQG/TRa5ZMAu1U25yIaymqBWv3oGI1OVmPP7M7KruGP
         qSThP5SbeOfwdwg8t6zFUu398R5DL7JhC/i4QsF89D5ECAbzVrR0VO03zshTMHSwpvoj
         um2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpZeVi7/jLe2UGLJ74BvdLB/Pw/wv8rvIZR0ymQ014TUO3l7OEHVpXs6NNAweAR3MPkSppjvSwIXXyDcC0xBGOWQQT4Mu3djZYJ/oA
X-Gm-Message-State: AOJu0YzT/ZAj83VTj5wLtv5sFYEg99AOlx+bO8ldpVrkP0+eeg1+Fq+Q
	ZZq0AymXc6WWSDZxK3svsKStijarZGhkYHfiz2Uijm/z3qpYjHB3tj0GUjc6V0bujQxiu7hP2C+
	wbfrYoyKwOfqGegXYRlU5A3Pyb3VOTryQRWUUmuYwVQid5JVH9PNd8UkBjHWuwA==
X-Received: by 2002:a05:6808:1829:b0:3c3:c913:2709 with SMTP id bh41-20020a056808182900b003c3c9132709mr293803oib.2.1711553041248;
        Wed, 27 Mar 2024 08:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAanQflKq3pmTo1+xDGdmPcZlLuONtp7wiA2xhvVSTNiy0v1ZL/DhUjtngy2OWwjyBQX1+lw==
X-Received: by 2002:a05:6808:1829:b0:3c3:c913:2709 with SMTP id bh41-20020a056808182900b003c3c9132709mr293761oib.2.1711553040651;
        Wed, 27 Mar 2024 08:24:00 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:24:00 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	peterx@redhat.com,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v4 12/13] mm/gup: Handle hugepd for follow_page()
Date: Wed, 27 Mar 2024 11:23:31 -0400
Message-ID: <20240327152332.950956-13-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152332.950956-1-peterx@redhat.com>
References: <20240327152332.950956-1-peterx@redhat.com>
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
leveraged.  There's something not needed for follow page, for example,
gup_hugepte() tries to detect pgtable entry change which will never happen
with slow gup (which has the pgtable lock held), but that's not a problem
to check.

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

To allow slow gup like follow_*_page() to access hugepd helpers, hugepd
codes are moved to the top.  Besides that, the helper record_subpages()
will be used by either hugepd or fast-gup now. To avoid "unused function"
warnings we must provide a "#ifdef" for it, unfortunately.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 269 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 163 insertions(+), 106 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a81184b01276..a02463c9420e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -500,6 +500,149 @@ static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
 }
 
 #ifdef CONFIG_MMU
+
+#if defined(CONFIG_ARCH_HAS_HUGEPD) || defined(CONFIG_HAVE_FAST_GUP)
+static int record_subpages(struct page *page, unsigned long sz,
+			   unsigned long addr, unsigned long end,
+			   struct page **pages)
+{
+	struct page *start_page;
+	int nr;
+
+	start_page = nth_page(page, (addr & (sz - 1)) >> PAGE_SHIFT);
+	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
+		pages[nr] = nth_page(start_page, nr);
+
+	return nr;
+}
+#endif	/* CONFIG_ARCH_HAS_HUGEPD || CONFIG_HAVE_FAST_GUP */
+
+#ifdef CONFIG_ARCH_HAS_HUGEPD
+static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
+				      unsigned long sz)
+{
+	unsigned long __boundary = (addr + sz) & ~(sz-1);
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
+
+static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
+		       unsigned long end, unsigned int flags,
+		       struct page **pages, int *nr)
+{
+	unsigned long pte_end;
+	struct page *page;
+	struct folio *folio;
+	pte_t pte;
+	int refs;
+
+	pte_end = (addr + sz) & ~(sz-1);
+	if (pte_end < end)
+		end = pte_end;
+
+	pte = huge_ptep_get(ptep);
+
+	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
+		return 0;
+
+	/* hugepages are never "special" */
+	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+
+	page = pte_page(pte);
+	refs = record_subpages(page, sz, addr, end, pages + *nr);
+
+	folio = try_grab_folio(page, refs, flags);
+	if (!folio)
+		return 0;
+
+	if (unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
+		gup_put_folio(folio, refs, flags);
+		return 0;
+	}
+
+	if (!pte_write(pte) && gup_must_unshare(NULL, flags, &folio->page)) {
+		gup_put_folio(folio, refs, flags);
+		return 0;
+	}
+
+	*nr += refs;
+	folio_set_referenced(folio);
+	return 1;
+}
+
+/*
+ * NOTE: currently GUP for a hugepd is only possible on hugetlbfs file
+ * systems on Power, which does not have issue with folio writeback against
+ * GUP updates.  When hugepd will be extended to support non-hugetlbfs or
+ * even anonymous memory, we need to do extra check as what we do with most
+ * of the other folios. See writable_file_mapping_allowed() and
+ * folio_fast_pin_allowed() for more information.
+ */
+static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
+		unsigned int pdshift, unsigned long end, unsigned int flags,
+		struct page **pages, int *nr)
+{
+	pte_t *ptep;
+	unsigned long sz = 1UL << hugepd_shift(hugepd);
+	unsigned long next;
+
+	ptep = hugepte_offset(hugepd, addr, pdshift);
+	do {
+		next = hugepte_addr_end(addr, end, sz);
+		if (!gup_hugepte(ptep, sz, addr, end, flags, pages, nr))
+			return 0;
+	} while (ptep++, addr = next, addr != end);
+
+	return 1;
+}
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
+#else /* CONFIG_ARCH_HAS_HUGEPD */
+static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
+		unsigned int pdshift, unsigned long end, unsigned int flags,
+		struct page **pages, int *nr)
+{
+	return 0;
+}
+
+static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
+				  unsigned long addr, unsigned int pdshift,
+				  unsigned int flags,
+				  struct follow_page_context *ctx)
+{
+	return NULL;
+}
+#endif /* CONFIG_ARCH_HAS_HUGEPD */
+
+
 static struct page *no_page_table(struct vm_area_struct *vma,
 				  unsigned int flags, unsigned long address)
 {
@@ -871,6 +1014,9 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags, address);
+	if (unlikely(is_hugepd(__hugepd(pmd_val(pmdval)))))
+		return follow_hugepd(vma, __hugepd(pmd_val(pmdval)),
+				     address, PMD_SHIFT, flags, ctx);
 	if (pmd_devmap(pmdval)) {
 		ptl = pmd_lock(mm, pmd);
 		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
@@ -921,6 +1067,9 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	pud = READ_ONCE(*pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
+	if (unlikely(is_hugepd(__hugepd(pud_val(pud)))))
+		return follow_hugepd(vma, __hugepd(pud_val(pud)),
+				     address, PUD_SHIFT, flags, ctx);
 	if (pud_leaf(pud)) {
 		ptl = pud_lock(mm, pudp);
 		page = follow_huge_pud(vma, address, pudp, flags, ctx);
@@ -944,10 +1093,13 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 
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
@@ -997,10 +1149,15 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 
 	pgd = pgd_offset(mm, address);
 
-	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		return no_page_table(vma, flags, address);
+	if (unlikely(is_hugepd(__hugepd(pgd_val(*pgd)))))
+		page = follow_hugepd(vma, __hugepd(pgd_val(*pgd)),
+				     address, PGDIR_SHIFT, flags, ctx);
+	else if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+		page = no_page_table(vma, flags, address);
+	else
+		page = follow_p4d_mask(vma, address, pgd, flags, ctx);
 
-	return follow_p4d_mask(vma, address, pgd, flags, ctx);
+	return page;
 }
 
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
@@ -2947,106 +3104,6 @@ static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
 }
 #endif
 
-static int record_subpages(struct page *page, unsigned long sz,
-			   unsigned long addr, unsigned long end,
-			   struct page **pages)
-{
-	struct page *start_page;
-	int nr;
-
-	start_page = nth_page(page, (addr & (sz - 1)) >> PAGE_SHIFT);
-	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
-		pages[nr] = nth_page(start_page, nr);
-
-	return nr;
-}
-
-#ifdef CONFIG_ARCH_HAS_HUGEPD
-static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
-				      unsigned long sz)
-{
-	unsigned long __boundary = (addr + sz) & ~(sz-1);
-	return (__boundary - 1 < end - 1) ? __boundary : end;
-}
-
-static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
-		       unsigned long end, unsigned int flags,
-		       struct page **pages, int *nr)
-{
-	unsigned long pte_end;
-	struct page *page;
-	struct folio *folio;
-	pte_t pte;
-	int refs;
-
-	pte_end = (addr + sz) & ~(sz-1);
-	if (pte_end < end)
-		end = pte_end;
-
-	pte = huge_ptep_get(ptep);
-
-	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
-		return 0;
-
-	/* hugepages are never "special" */
-	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
-
-	page = pte_page(pte);
-	refs = record_subpages(page, sz, addr, end, pages + *nr);
-
-	folio = try_grab_folio(page, refs, flags);
-	if (!folio)
-		return 0;
-
-	if (unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
-		gup_put_folio(folio, refs, flags);
-		return 0;
-	}
-
-	if (!pte_write(pte) && gup_must_unshare(NULL, flags, &folio->page)) {
-		gup_put_folio(folio, refs, flags);
-		return 0;
-	}
-
-	*nr += refs;
-	folio_set_referenced(folio);
-	return 1;
-}
-
-/*
- * NOTE: currently GUP for a hugepd is only possible on hugetlbfs file
- * systems on Power, which does not have issue with folio writeback against
- * GUP updates.  When hugepd will be extended to support non-hugetlbfs or
- * even anonymous memory, we need to do extra check as what we do with most
- * of the other folios. See writable_file_mapping_allowed() and
- * folio_fast_pin_allowed() for more information.
- */
-static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
-		unsigned int pdshift, unsigned long end, unsigned int flags,
-		struct page **pages, int *nr)
-{
-	pte_t *ptep;
-	unsigned long sz = 1UL << hugepd_shift(hugepd);
-	unsigned long next;
-
-	ptep = hugepte_offset(hugepd, addr, pdshift);
-	do {
-		next = hugepte_addr_end(addr, end, sz);
-		if (!gup_hugepte(ptep, sz, addr, end, flags, pages, nr))
-			return 0;
-	} while (ptep++, addr = next, addr != end);
-
-	return 1;
-}
-#else
-static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
-		unsigned int pdshift, unsigned long end, unsigned int flags,
-		struct page **pages, int *nr)
-{
-	return 0;
-}
-#endif /* CONFIG_ARCH_HAS_HUGEPD */
-
 static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 			unsigned long end, unsigned int flags,
 			struct page **pages, int *nr)
-- 
2.44.0


