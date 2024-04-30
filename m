Return-Path: <linux-kernel+bounces-163968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FDB8B76AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964951C2237B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02061171E5D;
	Tue, 30 Apr 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hH9HhO9N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E217164B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482792; cv=none; b=n8oQbGKYL+xhHPkRZkAYqhsKGVkjB47wifqqsPn0DJPE/RkXSVQQ633eV9kyH0a+C4mC7sRjIzUldZ076cm3e9vP+gPd8wHKBTfUAyCTIzscuDDTtqaZiHC5ZIItnLLVOGn2/O3SXsagk/a9tbTw/q7b+lm7cSJ2n0AEo0b5UY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482792; c=relaxed/simple;
	bh=Fg4lBOg1skWsglB5fUJ1GeEpxVLwdD3TzvV4Oy9QFtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYT5eZM0bxLMK1VdLt6dIm1Lgpo9ZDV8SPAYq2NA7M00TuESEaoo4JeCAvWd/WoIEpiXx1q9zfieOqDMvsddENatGqbTkPnSDKAvwOm1A6W8wIf8/Ch7yCvvv1przsPa8063nYSvOi+tic6HvacNPpAi2innm8rna5qdqmjLLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hH9HhO9N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714482789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oWuqOsXifT7Zmvx2sEqXndtkJ5mO0uhVIU3UoDEgjcQ=;
	b=hH9HhO9NN4I0bcKVuLIZo/TmjrAkmfUqLuiiEs4Gx3A5AAXCD5smdH4UPJF6GLP9O4mXyn
	PwytoU8hBP3BZ97XUWCrhiknm/h0WQevL/aDAosvo5dFY3a+3aagHWZT0oTq308i0q0uBo
	1t6EtARFB8bBXHpl9DFqicnzzB/TmyM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-cjKQ2djqP-izduWJUNXzdA-1; Tue, 30 Apr 2024 09:13:07 -0400
X-MC-Unique: cjKQ2djqP-izduWJUNXzdA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ee46069390so280875a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714482786; x=1715087586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWuqOsXifT7Zmvx2sEqXndtkJ5mO0uhVIU3UoDEgjcQ=;
        b=W5/k5dPDzVifG+6Bb+peyH3vB/4KpRG27p4mCfxiJakotRGp7q4NfSmkbQHcR9X2gX
         LFBUw8N1NB/zOBktq5aNd5aPVBa/KYkGh3cblEmgA1M9bbLFSn+HpyvciLjfsfhtEL3M
         XPa7u3vXvD0GD9pbCbJXGuSTzeG2Alk0zNqFwIIB++e1fc9f9RUD/G+wplG3rydj1Vob
         3Emku4JGNb+dxzpoV2+2bc6Rio+v2uPxLwX5l1gOVoPwJNpx9fBxHenN5rYwEawTYinb
         7ASe1wiz6wiwSaBhRBo/Fp+DNPWWX7sejN3UScLA2yEkrdEhyZbLTYHRyA8X6SWkzS0e
         Lq0w==
X-Gm-Message-State: AOJu0Yy7yHCVZCFXuDjV5DhypSH5+GDA00xB2mIWBQKTqquurXPUEyjW
	zsD7hrLZUdtQwjINHXKqqzgRQU37j0sLx3lRGTAInTdC+pUMw/ANu7u3suXg+rAwzplTbUfudI1
	vg8sBMJgjBcVtgWksBlKsHV4AZIY8z56dWIl+mRGH2SU1gVvRZuw62SAtwvvkaqNifxEnutKktN
	LXXS6bNtvHPK6t9rVDIH/egl8nQLO3XyBU+xJlAxdYhMs=
X-Received: by 2002:a05:6830:100f:b0:6ee:29b2:c2c5 with SMTP id a15-20020a056830100f00b006ee29b2c2c5mr6823551otp.1.1714482786069;
        Tue, 30 Apr 2024 06:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6fWhVkCw/NAkBxI5mhCww2FCWhCtQ7223L4ixmBRvipLfoa6GDPyCxArc1sm1kF/OD00lJQ==
X-Received: by 2002:a05:6830:100f:b0:6ee:29b2:c2c5 with SMTP id a15-20020a056830100f00b006ee29b2c2c5mr6823485otp.1.1714482785270;
        Tue, 30 Apr 2024 06:13:05 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id mk11-20020a056214580b00b006a0cd28f98dsm2008123qvb.25.2024.04.30.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 06:13:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>,
	John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2] mm/gup: Fix hugepd handling in hugetlb rework
Date: Tue, 30 Apr 2024 09:13:03 -0400
Message-ID: <20240430131303.264331-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

v1: https://lore.kernel.org/r/20240428190151.201002-1-peterx@redhat.com

This is v2 and dropped the 2nd test patch as a better one can come later,
this patch alone is kept untouched, added David's R-b.  Should apply to
both mm-stable and mm-unstable.  The target commit to be fixed should just
been moved into mm-stable, so no need to cc stable.
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


