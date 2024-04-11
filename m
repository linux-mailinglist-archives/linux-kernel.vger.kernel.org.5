Return-Path: <linux-kernel+bounces-139830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A133E8A0837
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C927281418
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054F513DBAC;
	Thu, 11 Apr 2024 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC283FNT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58413DB8A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816074; cv=none; b=ny4lmipqq2S8ENxlKQoFvVMkZx6Msdp4BqFyBHN+l1/0fksVw/+sYkN86xaM25NR6bi4L7bZeAiVdKK/XrXEEZWneWFTRqf2NDRrE4QOBSqEmgC7y0Yt8JEM1gz5+NlnW38tzkCDnp1+TM5kKYeBb3xei8DMJqGQH/i1OKsmozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816074; c=relaxed/simple;
	bh=sFkZO7Zaxh50oOXAu6R13zvDS+luqAu687nTeql3yIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWhae2+9F5GQEmH1DAdz9WoxBMU0FsKRc7uYeqKSYZ/ICWgxk3/afn6Ygl3eihZIKCK+YWJgNyqPeJ1EJOb+B6DZKe2TTMT2HKznZEI++KXqdLW8+2WN7121Zo/zEjyQmjIAmgiZf58lKUT6q+uAejln3D1eNEzHKa4mibE6ATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC283FNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B169CC43390;
	Thu, 11 Apr 2024 06:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816073;
	bh=sFkZO7Zaxh50oOXAu6R13zvDS+luqAu687nTeql3yIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KC283FNT4ao2MpxFeaTvbWB0emRIG60QNJYtYHqPfmeIsjOwDnje007my1mGCHbr7
	 nfRzlHgiEt+8nqSnI2Rzz9caW/QhUDbKMurWAV3KSZVTF7Bu0a7LfeQ+o50k7IS9Tu
	 G5siZcOLRKQm0js4dUzp+np8Rd7N+17FhMh/N+FoMO2LSUZn2uFA0Lqweak+78LTb3
	 NZjPajid42oiT2MINzFrl9LaG0exQ4Ynawq4rEopwlt/4GHR3kwEg6kImr4HFqwzMm
	 Gq3jQqw9sQkIsGqZmUvKCqzJRkfX+JmRuRT797is7pY5H46bZ+ES7NHm55oNuHWOfq
	 JzVnxlijt2ekw==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	hughd@google.com,
	chrisw@sous-sol.org,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Izik Eidus <izik.eidus@ravellosystems.com>
Subject: [PATCH v5 07/10] mm/ksm: use folio in write_protect_page
Date: Thu, 11 Apr 2024 14:17:08 +0800
Message-ID: <20240411061713.1847574-8-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411061713.1847574-1-alexs@kernel.org>
References: <20240411061713.1847574-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Compound page is checked and skipped before write_protect_page() called,
use folio to save a few compound_head checking.

Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index b127d39c9af0..2fdd6586a3a7 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1289,23 +1289,24 @@ static u32 calc_checksum(struct page *page)
 	return checksum;
 }
 
-static int write_protect_page(struct vm_area_struct *vma, struct page *page,
+static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
 			      pte_t *orig_pte)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, 0, 0);
 	int swapped;
 	int err = -EFAULT;
 	struct mmu_notifier_range range;
 	bool anon_exclusive;
 	pte_t entry;
 
-	pvmw.address = page_address_in_vma(page, vma);
+	if (WARN_ON_ONCE(folio_test_large(folio)))
+		return err;
+
+	pvmw.address = page_address_in_vma(&folio->page, vma);
 	if (pvmw.address == -EFAULT)
 		goto out;
 
-	BUG_ON(PageTransCompound(page));
-
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, pvmw.address,
 				pvmw.address + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
@@ -1315,12 +1316,12 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 	if (WARN_ONCE(!pvmw.pte, "Unexpected PMD mapping?"))
 		goto out_unlock;
 
-	anon_exclusive = PageAnonExclusive(page);
+	anon_exclusive = PageAnonExclusive(&folio->page);
 	entry = ptep_get(pvmw.pte);
 	if (pte_write(entry) || pte_dirty(entry) ||
 	    anon_exclusive || mm_tlb_flush_pending(mm)) {
-		swapped = PageSwapCache(page);
-		flush_cache_page(vma, pvmw.address, page_to_pfn(page));
+		swapped = folio_test_swapcache(folio);
+		flush_cache_page(vma, pvmw.address, folio_pfn(folio));
 		/*
 		 * Ok this is tricky, when get_user_pages_fast() run it doesn't
 		 * take any lock, therefore the check that we are going to make
@@ -1340,20 +1341,20 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 		 * Check that no O_DIRECT or similar I/O is in progress on the
 		 * page
 		 */
-		if (page_mapcount(page) + 1 + swapped != page_count(page)) {
+		if (folio_mapcount(folio) + 1 + swapped != folio_ref_count(folio)) {
 			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
 			goto out_unlock;
 		}
 
 		/* See folio_try_share_anon_rmap_pte(): clear PTE first. */
 		if (anon_exclusive &&
-		    folio_try_share_anon_rmap_pte(page_folio(page), page)) {
+		    folio_try_share_anon_rmap_pte(folio, &folio->page)) {
 			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
 			goto out_unlock;
 		}
 
 		if (pte_dirty(entry))
-			set_page_dirty(page);
+			folio_mark_dirty(folio);
 		entry = pte_mkclean(entry);
 
 		if (pte_write(entry))
@@ -1519,7 +1520,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 	 * ptes are necessarily already write-protected.  But in either
 	 * case, we need to lock and check page_count is not raised.
 	 */
-	if (write_protect_page(vma, page, &orig_pte) == 0) {
+	if (write_protect_page(vma, page_folio(page), &orig_pte) == 0) {
 		if (!kpage) {
 			/*
 			 * While we hold page lock, upgrade page from
-- 
2.43.0


