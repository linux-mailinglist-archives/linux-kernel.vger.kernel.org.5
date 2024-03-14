Return-Path: <linux-kernel+bounces-103555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E39B87C10A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95358B2247C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66CC7441E;
	Thu, 14 Mar 2024 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSNE6heu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B773535
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432794; cv=none; b=PYa8tO8e7pmEqEagoFgvovTBZlFJK+/J7t+3H2NETOzKARDhWqdVMgb7D7aSpSEMonRZTV5PRrINWlGRZycLm3yeG0vwu2XP/9kyxJvGKNzSvqBEFI687Eg9QBtW1Rw34EGm1EG4aPsEU7dvOwWHr+kVP37cqAseCLph5SPErBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432794; c=relaxed/simple;
	bh=VomcpaOlPzMQxs2yu0M7gH6x1DZOfskay+Zu1+shBO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIcxm8eoD0MdXCzQXhm4MR4xTQizoPT3vVtfiHY70HNbo1HnFhtv/Y6Tlzs9UvtbhwEvV21yztSE417EoUFDFA/Of6XOW1AokDIfTHDemWYe2MrPl3K4plilj1WKuBbk+/IZqzuRtES6rvYSPe5cLu7JWinCuMBIaNTv2LT1a+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSNE6heu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710432790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3u70TmCODVTszy6/DbBhWFHEWUxfQhlZeNtqCG8er74=;
	b=WSNE6heujXzuT311SytVgUGll6SR+yBHd6rXiU/oo/yJEApxyZGRaX71oWkj4Ln4MkDRbI
	v+aIXfwsTzksK2lb5y2jteOcnbM6RnxK1/7p2FMfjx96TuJ+Mu6UhySJpZWBxPzQcvSGV/
	WmVksMRtVu65M4tg6XFaA6kXNmhcp5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-uEIAQqoHMdOxBr0EYk-BMQ-1; Thu, 14 Mar 2024 12:13:06 -0400
X-MC-Unique: uEIAQqoHMdOxBr0EYk-BMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07C84803F6F;
	Thu, 14 Mar 2024 16:13:06 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E64240C6CB7;
	Thu, 14 Mar 2024 16:13:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH v1 1/2] mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly
Date: Thu, 14 Mar 2024 17:12:59 +0100
Message-ID: <20240314161300.382526-2-david@redhat.com>
In-Reply-To: <20240314161300.382526-1-david@redhat.com>
References: <20240314161300.382526-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Darrick reports that in some cases where pread() would fail with -EIO and
mmap()+access would generate a SIGBUS signal, MADV_POPULATE_READ /
MADV_POPULATE_WRITE will keep retrying forever and not fail with -EFAULT.

While the madvise() call can be interrupted by a signal, this is not
the desired behavior. MADV_POPULATE_READ / MADV_POPULATE_WRITE should
behave like page faults in that case: fail and not retry forever.

A reproducer can be found at [1].

The reason is that __get_user_pages(), as called by
faultin_vma_page_range(), will not handle VM_FAULT_RETRY in a proper
way: it will simply return 0 when VM_FAULT_RETRY happened, making
madvise_populate()->faultin_vma_page_range() retry again and again,
never setting FOLL_TRIED->FAULT_FLAG_TRIED for __get_user_pages().

__get_user_pages_locked() does what we want, but duplicating that logic
in faultin_vma_page_range() feels wrong.

So let's use __get_user_pages_locked() instead, that will detect
VM_FAULT_RETRY and set FOLL_TRIED when retrying, making the fault
handler return VM_FAULT_SIGBUS (VM_FAULT_ERROR) at some point,
propagating -EFAULT from faultin_page() to __get_user_pages(), all the way
to madvise_populate().

But, there is an issue: __get_user_pages_locked() will end up re-taking the
MM lock and then __get_user_pages() will do another VMA lookup. In the
meantime, the VMA layout could have changed and we'd fail with different
error codes than we'd want to.

As __get_user_pages() will currently do a new VMA lookup either way,
let it do the VMA handling in a different way, controlled by a new
FOLL_MADV_POPULATE flag, effectively moving these checks from
madvise_populate() + faultin_page_range() in there.

With this change, Darricks reproducer properly fails with -EFAULT, as
documented for MADV_POPULATE_READ / MADV_POPULATE_WRITE.

[1] https://lore.kernel.org/all/20240313171936.GN1927156@frogsfrogsfrogs/

Reported-by: Darrick J. Wong <djwong@kernel.org>
Closes: https://lore.kernel.org/all/20240311223815.GW1927156@frogsfrogsfrogs/
Fixes: 4ca9b3859dac ("mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page tables")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c      | 54 ++++++++++++++++++++++++++++++---------------------
 mm/internal.h | 10 ++++++----
 mm/madvise.c  | 17 ++--------------
 3 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index df83182ec72d5..f6d55635742f5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1206,6 +1206,22 @@ static long __get_user_pages(struct mm_struct *mm,
 
 		/* first iteration or cross vma bound */
 		if (!vma || start >= vma->vm_end) {
+			/*
+			 * MADV_POPULATE_(READ|WRITE) wants to handle VMA
+			 * lookups+error reporting differently.
+			 */
+			if (gup_flags & FOLL_MADV_POPULATE) {
+				vma = vma_lookup(mm, start);
+				if (!vma) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				if (check_vma_flags(vma, gup_flags)) {
+					ret = -EINVAL;
+					goto out;
+				}
+				goto retry;
+			}
 			vma = gup_vma_lookup(mm, start);
 			if (!vma && in_gate_area(mm, start)) {
 				ret = get_gate_page(mm, start & PAGE_MASK,
@@ -1683,35 +1699,35 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 }
 
 /*
- * faultin_vma_page_range() - populate (prefault) page tables inside the
- *			      given VMA range readable/writable
+ * faultin_page_range() - populate (prefault) page tables inside the
+ *			  given range readable/writable
  *
  * This takes care of mlocking the pages, too, if VM_LOCKED is set.
  *
- * @vma: target vma
+ * @mm: the mm to populate page tables in
  * @start: start address
  * @end: end address
  * @write: whether to prefault readable or writable
  * @locked: whether the mmap_lock is still held
  *
- * Returns either number of processed pages in the vma, or a negative error
- * code on error (see __get_user_pages()).
+ * Returns either number of processed pages in the MM, or a negative error
+ * code on error (see __get_user_pages()). Note that this function reports
+ * errors related to VMAs, such as incompatible mappings, as expected by
+ * MADV_POPULATE_(READ|WRITE).
  *
- * vma->vm_mm->mmap_lock must be held. The range must be page-aligned and
- * covered by the VMA. If it's released, *@locked will be set to 0.
+ * The range must be page-aligned.
+ *
+ * mm->mmap_lock must be held. If it's released, *@locked will be set to 0.
  */
-long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end, bool write, int *locked)
+long faultin_page_range(struct mm_struct *mm, unsigned long start,
+			unsigned long end, bool write, int *locked)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	unsigned long nr_pages = (end - start) / PAGE_SIZE;
 	int gup_flags;
 	long ret;
 
 	VM_BUG_ON(!PAGE_ALIGNED(start));
 	VM_BUG_ON(!PAGE_ALIGNED(end));
-	VM_BUG_ON_VMA(start < vma->vm_start, vma);
-	VM_BUG_ON_VMA(end > vma->vm_end, vma);
 	mmap_assert_locked(mm);
 
 	/*
@@ -1723,19 +1739,13 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 	 *		  a poisoned page.
 	 * !FOLL_FORCE: Require proper access permissions.
 	 */
-	gup_flags = FOLL_TOUCH | FOLL_HWPOISON | FOLL_UNLOCKABLE;
+	gup_flags = FOLL_TOUCH | FOLL_HWPOISON | FOLL_UNLOCKABLE |
+		    FOLL_MADV_POPULATE;
 	if (write)
 		gup_flags |= FOLL_WRITE;
 
-	/*
-	 * We want to report -EINVAL instead of -EFAULT for any permission
-	 * problems or incompatible mappings.
-	 */
-	if (check_vma_flags(vma, gup_flags))
-		return -EINVAL;
-
-	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
-			       NULL, locked);
+	ret = __get_user_pages_locked(mm, start, nr_pages, NULL, locked,
+				      gup_flags);
 	lru_add_drain();
 	return ret;
 }
diff --git a/mm/internal.h b/mm/internal.h
index d1c69119b24fb..a57dd5156cf84 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -686,9 +686,8 @@ struct anon_vma *folio_anon_vma(struct folio *folio);
 void unmap_mapping_folio(struct folio *folio);
 extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
-extern long faultin_vma_page_range(struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end,
-				   bool write, int *locked);
+extern long faultin_page_range(struct mm_struct *mm, unsigned long start,
+		unsigned long end, bool write, int *locked);
 extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
 			       unsigned long bytes);
 
@@ -1127,10 +1126,13 @@ enum {
 	FOLL_FAST_ONLY = 1 << 20,
 	/* allow unlocking the mmap lock */
 	FOLL_UNLOCKABLE = 1 << 21,
+	/* VMA lookup+checks compatible with MADV_POPULATE_(READ|WRITE) */
+	FOLL_MADV_POPULATE = 1 << 22,
 };
 
 #define INTERNAL_GUP_FLAGS (FOLL_TOUCH | FOLL_TRIED | FOLL_REMOTE | FOLL_PIN | \
-			    FOLL_FAST_ONLY | FOLL_UNLOCKABLE)
+			    FOLL_FAST_ONLY | FOLL_UNLOCKABLE | \
+			    FOLL_MADV_POPULATE)
 
 /*
  * Indicates for which pages that are write-protected in the page table,
diff --git a/mm/madvise.c b/mm/madvise.c
index 44a498c94158c..1a073fcc4c0c0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -908,27 +908,14 @@ static long madvise_populate(struct vm_area_struct *vma,
 {
 	const bool write = behavior == MADV_POPULATE_WRITE;
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long tmp_end;
 	int locked = 1;
 	long pages;
 
 	*prev = vma;
 
 	while (start < end) {
-		/*
-		 * We might have temporarily dropped the lock. For example,
-		 * our VMA might have been split.
-		 */
-		if (!vma || start >= vma->vm_end) {
-			vma = vma_lookup(mm, start);
-			if (!vma)
-				return -ENOMEM;
-		}
-
-		tmp_end = min_t(unsigned long, end, vma->vm_end);
 		/* Populate (prefault) page tables readable/writable. */
-		pages = faultin_vma_page_range(vma, start, tmp_end, write,
-					       &locked);
+		pages = faultin_page_range(mm, start, end, write, &locked);
 		if (!locked) {
 			mmap_read_lock(mm);
 			locked = 1;
@@ -949,7 +936,7 @@ static long madvise_populate(struct vm_area_struct *vma,
 				pr_warn_once("%s: unhandled return value: %ld\n",
 					     __func__, pages);
 				fallthrough;
-			case -ENOMEM:
+			case -ENOMEM: /* No VMA or out of memory. */
 				return -ENOMEM;
 			}
 		}
-- 
2.43.2


