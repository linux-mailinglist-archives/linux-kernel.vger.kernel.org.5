Return-Path: <linux-kernel+bounces-136560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFE489D587
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C29C1C22DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F6A7FBB8;
	Tue,  9 Apr 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXbjGhv4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6D7F495
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654733; cv=none; b=JCAXMESnMEraH4E+L0//rSdY0LqtNHIJrnTTxD531M55T5BsOpnB3uAByMbig4MWqtOcUWkQG1gnYiq5NzyZBlqTjb7Q0yxP8y7wuF57XPbPYQ0GWf/rV8S76R/3+mVGf0GBj6uMXPsVWCv85Os/1jMRattPzdiniSIP6QoFTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654733; c=relaxed/simple;
	bh=kQN6FVtHG3hCQ1muL4e6/z5sNInnsnuhNQpT8qXQDKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tqpv1NgfoTsF/82UrZAXOoTMYzbl/lvXpCidvfUZmaW14LGgyTKSzuI4gP56rDxR3ooacCQbYBcPYBzqq0p+VdTbeQjwNyimyuhC2+ks7DFFajAPO/L410J5jH7eGfgRNTX8xQXluMrmoHGjQqFFs/5EL/7rHx3cLOwl1BVzUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXbjGhv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4145FC433F1;
	Tue,  9 Apr 2024 09:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654733;
	bh=kQN6FVtHG3hCQ1muL4e6/z5sNInnsnuhNQpT8qXQDKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXbjGhv4j5QR/j+cdEHV+7W1koJXqWz0Rb1a9u1mejXGAL6dCIqJ9poZ+7mJMyPUQ
	 MehaKYskrhsNlDJYo7S+wZ7vfMjpdOoT6Pq4ShQfZjkvD0QIDex94hl7XsYYf2E9YJ
	 j57kxizvU1otNbZOiGJrxz3y4Q3QnaD794ZR/3Jn8aGO/lzghT3lAFBA1h8WHB26mj
	 VZFsfFvXHGVlVtDCsaupYUkBkOCzGZwUDifeCCNVvwdKV/sRVIA8vQZsnCorU89iyF
	 u9xuYV0nQrm7N4XH8chMU/kdGbvnuUZCWJxqY/AqNRoCE5Rn/gVb0ViQXJgFTgAhdF
	 6x1JKxmdZ52rA==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 7/9] mm/ksm: use folio in write_protect_page
Date: Tue,  9 Apr 2024 17:28:22 +0800
Message-ID: <20240409092826.1733637-8-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409092826.1733637-1-alexs@kernel.org>
References: <20240409092826.1733637-1-alexs@kernel.org>
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

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 95a487a21eed..776094fab34e 100644
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


