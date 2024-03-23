Return-Path: <linux-kernel+bounces-112206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C8D8876E9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E0FB2269D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E278F55;
	Sat, 23 Mar 2024 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQWGmLsy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C03FC7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711164801; cv=none; b=SkNfku1evGHuaXergY1VCQGqvJLg3n5Qs7eNwDsIHuAHqz4kv3ogH4qYkHQf4vuHVFtRenRVirasQldrGB17UCDiaq/R9V1pbeKywv8DzlgneRgNtKcEKr/VM6BzqTlwPAU06rpul9PabKEIhtsjtwj3BBDlJbRcedJFpcsyhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711164801; c=relaxed/simple;
	bh=gSP6ypGcGVyUPXg12ljPEJ5zv4OPCaxX0EaLkDEbiwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBhAJU5kmMWvnASok9fs2IFSeZm1hTijV/toYIoqTh9AoExbUuts+DV1RnLrD84OfloeBDnHh14+rs+rjTrQNoAof73btw5Nww3DfvUQ9meXDomQ2Hq9N1GIeu8h6irkNZFFlt14tbdfmsJcMdssqumtjtJJK+KnfqHX+Tgf45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQWGmLsy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711164798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RT3JU78BLCUvx59f8uOYoEo4UVIewlw6hqvfhC3pJ8=;
	b=hQWGmLsyRxilIJvy3COfNT41VTHpO3hQ+8vq4WgN6e+CagP9zZ7EWDwGKLzKEF6LiqvdO5
	PQvAM55WetkDWNI9BWfE9FuqmBvGo/4doNblS+YAJDoS6os78ozQ8kTkj/U+gj4t/US7OH
	fyncB18O7wvY+afKoCN4TNynLjvRF94=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-XBcmXtX3PNCmOqcZaVr_Sw-1; Fri, 22 Mar 2024 23:33:16 -0400
X-MC-Unique: XBcmXtX3PNCmOqcZaVr_Sw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69651ab4c4fso7332526d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 20:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711164795; x=1711769595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RT3JU78BLCUvx59f8uOYoEo4UVIewlw6hqvfhC3pJ8=;
        b=IBPYFPL/25z8QhQ75T5Prp3wRoo4USy9mctWUQWKZquxYyUoic3zxX5HceZ9jmgmvR
         uji/wYpjpKxPTu0xNOACm4RhlB5nFf8WSZEgab2UGrg7gaxCmWSw6L+95zuKuAVWz4BK
         gE9fPe/zWIGHkOmMLZ0ApEqaLl46/bG/O0UjwP0MCcr7D5Zd8H8+DW3y5AzYLGl1iUci
         O9qgTqOy5Ev1j8asYHuAwA04J1Rcy92g2u7KF2SHwRC5pBD7jOaEw589RL3UA6arXFx9
         TJbn8V3EuZFZrlaMkh5G4ZMxBypVIyY0qHh1n/OBlS3FdyVypDAcu9rgTNIQwDUf6rJi
         vD0Q==
X-Gm-Message-State: AOJu0YxsgSp0SIxSSdJvECbHHpzrnpyolrxvp/ClUCedZQIIkJKnc5Z2
	MhmXpjqM75pBIanjSQ2xyETRbjC9F52mTxckEQ00Rizvaa/3o2uYCHAPfQ+iW+eI6541OUIjfeI
	/1Gzt/g7vCZAr0yPASoU0IpFYQKGfDVDFhsD5qq/G7VJxarA2IUnqHkMyNzc2W+QlA0cLkGzgQX
	Bb2OkwYloAdFAaCb4HtY/BME4RXs34dd0QsZi55fJn1uo=
X-Received: by 2002:a05:6214:4598:b0:696:7b32:cceb with SMTP id op24-20020a056214459800b006967b32ccebmr496279qvb.6.1711164795356;
        Fri, 22 Mar 2024 20:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKF8jhZbJHSvX24ZFr9evzOa/c38cWLTQmFytc3WEfQcqwh3k7QGxTFmu0XJXF0XffA+dzpA==
X-Received: by 2002:a05:6214:4598:b0:696:7b32:cceb with SMTP id op24-20020a056214459800b006967b32ccebmr496264qvb.6.1711164794792;
        Fri, 22 Mar 2024 20:33:14 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id j12-20020a05621419cc00b006910e7edfedsm1698198qvc.62.2024.03.22.20.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 20:33:14 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	peterx@redhat.com
Subject: [PATCH 2/2] fixup! mm/gup: handle hugepd for follow_page()
Date: Fri, 22 Mar 2024 23:33:10 -0400
Message-ID: <20240323033310.971447-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240323033310.971447-1-peterx@redhat.com>
References: <20240323033310.971447-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

The major issue is that now slow gup will reuse some fast gup functions to
parse hugepd entries.  So we need to move hugepd and relevant functions out
of HAVE_FAST_GUP, but also under CONFIG_MMU.

Meanwhile, the helper record_subpages() can be used by either hugepd or
fast-gup section.  To avoid "unused function" warnings we must provide a
macro to it, unfortunately.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 287 +++++++++++++++++++++++++++----------------------------
 1 file changed, 143 insertions(+), 144 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 4cd349390477..fe9df268bef2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -30,11 +30,6 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
-static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
-				  unsigned long addr, unsigned int pdshift,
-				  unsigned int flags,
-				  struct follow_page_context *ctx);
-
 static inline void sanity_check_pinned_pages(struct page **pages,
 					     unsigned long npages)
 {
@@ -505,6 +500,149 @@ static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
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
@@ -2962,145 +3100,6 @@ static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
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
-
-static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
-				  unsigned long addr, unsigned int pdshift,
-				  unsigned int flags,
-				  struct follow_page_context *ctx)
-{
-	struct page *page;
-	struct hstate *h;
-	spinlock_t *ptl;
-	int nr = 0, ret;
-	pte_t *ptep;
-
-	/* Only hugetlb supports hugepd */
-	if (WARN_ON_ONCE(!is_vm_hugetlb_page(vma)))
-		return ERR_PTR(-EFAULT);
-
-	h = hstate_vma(vma);
-	ptep = hugepte_offset(hugepd, addr, pdshift);
-	ptl = huge_pte_lock(h, vma->vm_mm, ptep);
-	ret = gup_huge_pd(hugepd, addr, pdshift, addr + PAGE_SIZE,
-			  flags, &page, &nr);
-	spin_unlock(ptl);
-
-	if (ret) {
-		WARN_ON_ONCE(nr != 1);
-		ctx->page_mask = (1U << huge_page_order(h)) - 1;
-		return page;
-	}
-
-	return NULL;
-}
-#else
-static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
-		unsigned int pdshift, unsigned long end, unsigned int flags,
-		struct page **pages, int *nr)
-{
-	return 0;
-}
-
-static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
-				  unsigned long addr, unsigned int pdshift,
-				  unsigned int flags,
-				  struct follow_page_context *ctx)
-{
-	return NULL;
-}
-#endif /* CONFIG_ARCH_HAS_HUGEPD */
-
 static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 			unsigned long end, unsigned int flags,
 			struct page **pages, int *nr)
-- 
2.44.0


