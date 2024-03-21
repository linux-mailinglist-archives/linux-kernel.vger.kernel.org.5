Return-Path: <linux-kernel+bounces-110735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0E8862FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CAE1C22179
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81528138485;
	Thu, 21 Mar 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFWIp+k/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE0E137C49
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058909; cv=none; b=BSScEXfvZk/0kC0OUUCbyhcDfSZIFOt4pvdFPfhTHw1d1q79WKG7z9gRC/xyVbL37rlQplAUNukPjbG/EbkBttMtlVe2RgPZJzjn2NzQKQTAOhllTb8e92jP9qdkSJi6S9+6TS+Q9bLd/0LB7qN2ScgGBthh4+xbStXehFJm/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058909; c=relaxed/simple;
	bh=Mue/44vgd6mPZ43QWexdWgiIluvbkdZ2Z9p4n62rqTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IehHuO5YcC7YNfC7uFvIeukkaHOmnyk+IbwZXA1Nm0oN80ke3uZWAYzMBm2EVWoLsPlqIAxw9K7tuUIzzb07UO2LgM56yRD2Q4yii900/m78fb08auogxTKSar/FaKJsnSZbZna0N67/ccBPJvrGa6r3B4mJVweC0n6E+Yoe8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFWIp+k/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwtVKmcef1NV2SEc6Dd7pe+XzH6c3RDiTdVw8lXpTc0=;
	b=MFWIp+k/IAAt7Y90E1wjo3LRNAbL5qW/yvGErPf8WG/+5u+R6GkTFK7ufUfnnlDVj8VoCU
	9HF2L4R8eKotgNg3ockuq9f6tMjUpiLunhgzea7jpkNKw0QZe5NNj4UY4vsnD1+E8Vmo2x
	KRBXqXe14SAZ+yOmffou/yRXVhMjUC0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-4LlkOeFmNcmEre-3f6_BVA-1; Thu, 21 Mar 2024 18:08:23 -0400
X-MC-Unique: 4LlkOeFmNcmEre-3f6_BVA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-690d3f5af86so3057226d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058903; x=1711663703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwtVKmcef1NV2SEc6Dd7pe+XzH6c3RDiTdVw8lXpTc0=;
        b=WVeU6+PiSnr2YyMsmTM2oBOw+Jg9PtCTIwGjzJCGoVrt/CrcMQuVwJjkIIqt/hp/qT
         FCQhJOLXea6VW52ztocm6KBtLc0lXW2Wz+X/w4ezODUBDBXABxipMl/DNWPH8ICPRxpP
         S8UihSKwa6dwBrTUxsU+3nng5PegHFzn253010pv03FpCZ72F9C8PuUFS5au7XRa02nI
         IISZnmphVSXpkl7IRB7Sit3Chwlx3p2gjkbzRU6THuSyQLk5ThMwHjnO4bBO30u8PqlU
         6tUk1sud9e/3ctwYYntxNcjlSOrrVSXxFinQJ6X5Qd6Xgaq0zuIiY2GrWqBu1ZskNcxe
         52ng==
X-Forwarded-Encrypted: i=1; AJvYcCWW/LqFFtRcYNRW8uhgqh0QDO152aKWJZB2dElJckRLZ1qEw6EaEi8y/1vYhJTtLy4n8sibcShgGO2yQL8BCF1s0NnuF4wsrT/7Y1ve
X-Gm-Message-State: AOJu0Ywz835msWszwHapHx62n8z7RBhuJ3nxUBKM7i+7u4ov9dfTsGl1
	ivLwRNwfW71Ic3mgRvF+zUzgxAEu4kvyYHrRcQo5DrvWrVYM0I/BQMbCF0pAbtj5jCbe2yn5m0J
	aj3h81GNzB0AfNiTasX8QvGeJNYkExtzkUnH/PfEDgI61NlDFZjhRNojWzmrQJg==
X-Received: by 2002:a05:6214:4403:b0:690:b47e:60e3 with SMTP id oj3-20020a056214440300b00690b47e60e3mr171644qvb.5.1711058902742;
        Thu, 21 Mar 2024 15:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFefVkn71VpIW4uNQ3LlUv67q0iftDvBfI3myHkSibZanv1/17GTXunJ1XxyTP0oQ7cl/tpbA==
X-Received: by 2002:a05:6214:4403:b0:690:b47e:60e3 with SMTP id oj3-20020a056214440300b00690b47e60e3mr171615qvb.5.1711058902326;
        Thu, 21 Mar 2024 15:08:22 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:21 -0700 (PDT)
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
Subject: [PATCH v3 09/12] mm/gup: Handle huge pud for follow_pud_mask()
Date: Thu, 21 Mar 2024 18:07:59 -0400
Message-ID: <20240321220802.679544-10-peterx@redhat.com>
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

Teach follow_pud_mask() to be able to handle normal PUD pages like hugetlb.

Rename follow_devmap_pud() to follow_huge_pud() so that it can process
either huge devmap or hugetlb. Move it out of TRANSPARENT_HUGEPAGE_PUD and
and huge_memory.c (which relies on CONFIG_THP).  Switch to pud_leaf() to
detect both cases in the slow gup.

In the new follow_huge_pud(), taking care of possible CoR for hugetlb if
necessary.  touch_pud() needs to be moved out of huge_memory.c to be
accessable from gup.c even if !THP.

Since at it, optimize the non-present check by adding a pud_present() early
check before taking the pgtable lock, failing the follow_page() early if
PUD is not present: that is required by both devmap or hugetlb.  Use
pud_huge() to also cover the pud_devmap() case.

One more trivial thing to mention is, introduce "pud_t pud" in the code
paths along the way, so the code doesn't dereference *pudp multiple time.
Not only because that looks less straightforward, but also because if the
dereference really happened, it's not clear whether there can be race to
see different *pudp values when it's being modified at the same time.

Setting ctx->page_mask properly for a PUD entry.  As a side effect, this
patch should also be able to optimize devmap GUP on PUD to be able to jump
over the whole PUD range, but not yet verified.  Hugetlb already can do so
prior to this patch.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h |  8 -----
 mm/gup.c                | 70 +++++++++++++++++++++++++++++++++++++++--
 mm/huge_memory.c        | 47 ++-------------------------
 mm/internal.h           |  2 ++
 4 files changed, 71 insertions(+), 56 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 3bcdfc7e5d57..39195f7c5269 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -346,8 +346,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
-struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags, struct dev_pagemap **pgmap);
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
@@ -504,12 +502,6 @@ static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *follow_devmap_pud(struct vm_area_struct *vma,
-	unsigned long addr, pud_t *pud, int flags, struct dev_pagemap **pgmap)
-{
-	return NULL;
-}
-
 static inline bool thp_migration_supported(void)
 {
 	return false;
diff --git a/mm/gup.c b/mm/gup.c
index a338944e4425..ae21afb9434e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -525,6 +525,70 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 	return NULL;
 }
 
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+static struct page *follow_huge_pud(struct vm_area_struct *vma,
+				    unsigned long addr, pud_t *pudp,
+				    int flags, struct follow_page_context *ctx)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct page *page;
+	pud_t pud = *pudp;
+	unsigned long pfn = pud_pfn(pud);
+	int ret;
+
+	assert_spin_locked(pud_lockptr(mm, pudp));
+
+	if ((flags & FOLL_WRITE) && !pud_write(pud))
+		return NULL;
+
+	if (!pud_present(pud))
+		return NULL;
+
+	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
+
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
+	    pud_devmap(pud)) {
+		/*
+		 * device mapped pages can only be returned if the caller
+		 * will manage the page reference count.
+		 *
+		 * At least one of FOLL_GET | FOLL_PIN must be set, so
+		 * assert that here:
+		 */
+		if (!(flags & (FOLL_GET | FOLL_PIN)))
+			return ERR_PTR(-EEXIST);
+
+		if (flags & FOLL_TOUCH)
+			touch_pud(vma, addr, pudp, flags & FOLL_WRITE);
+
+		ctx->pgmap = get_dev_pagemap(pfn, ctx->pgmap);
+		if (!ctx->pgmap)
+			return ERR_PTR(-EFAULT);
+	}
+
+	page = pfn_to_page(pfn);
+
+	if (!pud_devmap(pud) && !pud_write(pud) &&
+	    gup_must_unshare(vma, flags, page))
+		return ERR_PTR(-EMLINK);
+
+	ret = try_grab_page(page, flags);
+	if (ret)
+		page = ERR_PTR(ret);
+	else
+		ctx->page_mask = HPAGE_PUD_NR - 1;
+
+	return page;
+}
+#else  /* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
+static struct page *follow_huge_pud(struct vm_area_struct *vma,
+				    unsigned long addr, pud_t *pudp,
+				    int flags, struct follow_page_context *ctx)
+{
+	return NULL;
+}
+#endif	/* CONFIG_PGTABLE_HAS_HUGE_LEAVES */
+
 static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 		pte_t *pte, unsigned int flags)
 {
@@ -760,11 +824,11 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 
 	pudp = pud_offset(p4dp, address);
 	pud = READ_ONCE(*pudp);
-	if (pud_none(pud))
+	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
-	if (pud_devmap(pud)) {
+	if (pud_leaf(pud)) {
 		ptl = pud_lock(mm, pudp);
-		page = follow_devmap_pud(vma, address, pudp, flags, &ctx->pgmap);
+		page = follow_huge_pud(vma, address, pudp, flags, ctx);
 		spin_unlock(ptl);
 		if (page)
 			return page;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c77cedf45f3a..f8bd2012bc27 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1363,8 +1363,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
-		      pud_t *pud, bool write)
+void touch_pud(struct vm_area_struct *vma, unsigned long addr,
+	       pud_t *pud, bool write)
 {
 	pud_t _pud;
 
@@ -1376,49 +1376,6 @@ static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pud(vma, addr, pud);
 }
 
-struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags, struct dev_pagemap **pgmap)
-{
-	unsigned long pfn = pud_pfn(*pud);
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int ret;
-
-	assert_spin_locked(pud_lockptr(mm, pud));
-
-	if (flags & FOLL_WRITE && !pud_write(*pud))
-		return NULL;
-
-	if (pud_present(*pud) && pud_devmap(*pud))
-		/* pass */;
-	else
-		return NULL;
-
-	if (flags & FOLL_TOUCH)
-		touch_pud(vma, addr, pud, flags & FOLL_WRITE);
-
-	/*
-	 * device mapped pages can only be returned if the
-	 * caller will manage the page reference count.
-	 *
-	 * At least one of FOLL_GET | FOLL_PIN must be set, so assert that here:
-	 */
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return ERR_PTR(-EEXIST);
-
-	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
-	page = pfn_to_page(pfn);
-
-	ret = try_grab_page(page, flags);
-	if (ret)
-		page = ERR_PTR(ret);
-
-	return page;
-}
-
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
 		  struct vm_area_struct *vma)
diff --git a/mm/internal.h b/mm/internal.h
index f8b31234c130..63e4f6e001be 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1102,6 +1102,8 @@ int __must_check try_grab_page(struct page *page, unsigned int flags);
 /*
  * mm/huge_memory.c
  */
+void touch_pud(struct vm_area_struct *vma, unsigned long addr,
+	       pud_t *pud, bool write);
 struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmd,
 				   unsigned int flags);
-- 
2.44.0


