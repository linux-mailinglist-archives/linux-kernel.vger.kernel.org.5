Return-Path: <linux-kernel+bounces-121506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D726D88EB64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97EEBB3A426
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F3913E6C0;
	Wed, 27 Mar 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyWyLPwq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF713775A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553042; cv=none; b=PEMgY8PqmQ6N2ZU+l2431HTzeaWV+UlU1EvuXl4vV7dK3vzSswO43FkUYZS8GGGBSbwE4sjwQwUMOWItShI9VaTk/v+vczZRJkXSILCsVGTKoyGnr6IuiCwNUqvNmJilrSPpiqgGcB+BK8lcpgGNzFu2fg3blsyOsYkhuJ9yqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553042; c=relaxed/simple;
	bh=v3UeZk66u3jF3iEaoA46IxrGTPgh6SWO72DoCKY7fnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gre4umBqApp9N3StwwQLttfq2ooH7/95xKN6PpZVZkqry/r06N7EVjpP07KlIuKU6Efkn9kXRccBZpRFcVg+MrxgHYd6JB3ayL6F+9m5vFqbvooY8Y8Gztmk5ogC+FB39s3x9g3yY5p2GULo6mMBk0W9YhWckKjnhHEbT6c64ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyWyLPwq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldvmB2LhfsIRddCCGOUltuspZLyBYJ6Ab85tSc3WzTs=;
	b=YyWyLPwqCWeKt+MQ5fSRqtOAAu+Hz+J827SBKE4XLkhzZVZ9aA2q3CUdzx1Jpl65jn5Ksf
	IHEBwUqsnVB98lIfCXEBw+tFmwDIVuV986oZn5boGM0XjIIBsAjpVR9mqOZLyIN+ZIaMOH
	YxkX0xG3DJbWHFM2rFmwlh/5/zbkkaU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-sEgUmLPlM8mjf4sdwGXV2A-1; Wed, 27 Mar 2024 11:23:58 -0400
X-MC-Unique: sEgUmLPlM8mjf4sdwGXV2A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7830635331bso149217285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553037; x=1712157837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldvmB2LhfsIRddCCGOUltuspZLyBYJ6Ab85tSc3WzTs=;
        b=M9crnE/5bxzGIGiu4jY9w0n/3IFbkJGdfhmNqn5n/+jKcmg5f02KOULSXhHSNeNbqW
         W/ZiiL2ujIkOR78U22CEOdn1Cmm+hxD1om/lWJ0bYrkjYgNuDYiv0Bf8BfwnGOkP5kZX
         NUWU0zFYFSVvG6McrVORXx4AMdNCdVoaiwRx4BHORZ8qgQeREv5z6KIxuDnLeN2bFSNq
         qTou1lICwQwvMGKQcwhe8NkW9YvECIMzW3Xw8EPwI3cFT+AI00X68Hy9XmTqjwseBD8n
         kTKS4OhAcTmsHx9PqggNuZf/NTsMmmyoOB3h2GktROrRIJTl4k+P33bBXXwtcSWPP5nS
         qfpA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ekrckxmUPRYgXdPv1Mv+oae9BscqlvGk2iCoRNcsgGFWjrSpYooJ+Kk79Jxn0POci0RsDTv8weueNOwEEI50vU5LU5tcR7W+IGP2
X-Gm-Message-State: AOJu0Yyu7k9JKzmLsY7gNKpkZ4K0um65YfUZLUGoLDpVeJ6xA0ElLLOQ
	LCJxZnhvSx2BuZ52F09F9iqHnq4ZV5WWXpGc6gpongSnmSDSkkQ8VloXYhEXtswErKRJrMG+SL3
	ufC2hhVuC3zQ+GMT4XUkLoptXfnTZdNc9yGpkQUw2wDuyIe4Y7Ui1Al0663rCSQ==
X-Received: by 2002:a05:6214:3d8c:b0:696:6f95:4421 with SMTP id om12-20020a0562143d8c00b006966f954421mr14386003qvb.1.1711553037003;
        Wed, 27 Mar 2024 08:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnSeTu/B6EMntVMOCEyhcTmSAZJByvhuxAj5BPZo0z5woD7z6vaVN6Kd8/ZBw0a5bsOP9d6g==
X-Received: by 2002:a05:6214:3d8c:b0:696:6f95:4421 with SMTP id om12-20020a0562143d8c00b006966f954421mr14385952qvb.1.1711553036462;
        Wed, 27 Mar 2024 08:23:56 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:56 -0700 (PDT)
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
Subject: [PATCH v4 10/13] mm/gup: Handle huge pud for follow_pud_mask()
Date: Wed, 27 Mar 2024 11:23:29 -0400
Message-ID: <20240327152332.950956-11-peterx@redhat.com>
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
index d3bb25c39482..3f36511bdc02 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -351,8 +351,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
-struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags, struct dev_pagemap **pgmap);
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
@@ -507,12 +505,6 @@ static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
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
index 26b8cca24077..1e5d42211bb4 100644
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
index bc6fa82d9815..2979198d7b71 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1377,8 +1377,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
-		      pud_t *pud, bool write)
+void touch_pud(struct vm_area_struct *vma, unsigned long addr,
+	       pud_t *pud, bool write)
 {
 	pud_t _pud;
 
@@ -1390,49 +1390,6 @@ static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
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
index 6c8d3844b6a3..eee8c82740b5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1111,6 +1111,8 @@ int __must_check try_grab_page(struct page *page, unsigned int flags);
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


