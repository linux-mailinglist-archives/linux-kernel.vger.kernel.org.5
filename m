Return-Path: <linux-kernel+bounces-108555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 974D8880C27
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532912844A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1033B3AC01;
	Wed, 20 Mar 2024 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDzTtQlW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E0F3A1DC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920276; cv=none; b=O/hRgST52B/0OoWd5uFVoXYrVDI3KJxVEwURBiRYG/ioxc+lcoyffi4I4c5j2MfEH8auQ1HMlifVktSXxRbp0376MnPYP37+g3HQnxAfjvYxCivzC8jt/bfy0K06qebtndMCp1tfPx3hyj6ts0aH979YEr5VeXQvFPBy9Q3xXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920276; c=relaxed/simple;
	bh=19yPEARCpp8Ts03v7RxMxCBtzle77h5p1XW4PvUaw5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OACJU04CAjFVsO7yIXmstS5oFX9wjeKPaop5ITfdGGWnk3DVMCVIcbtgZ8TqTwfWDozTE15/wIGD/v6qMQQJsJb/5VCCh7L9fzjm5IgM3wQNArC9VYtOffRz/TIRTbdKjwrF+beWa1Jx5BHA08XJHgYJIniZo51I8OW7Yfy1kDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDzTtQlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778E8C433F1;
	Wed, 20 Mar 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920276;
	bh=19yPEARCpp8Ts03v7RxMxCBtzle77h5p1XW4PvUaw5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDzTtQlW47rs4jpnYM++UgOMgMjc6JVlGxhM/IaBtklgkLeG6r4Tnxl1Xk+XlC8O/
	 KQHON/2ylQa9Yuyx0B8AKyEW5/TRrTxN4xBejiHEVqucOuTU7IwSba7JJ+kXWreOOF
	 R4+4Zyn9/Nev/5bFVVQ4UkccMEbHgMbDM6uTF739A2wUe83+/7uDOexjTk7NkSdnO7
	 dcnb3ZAD1eZm7Vkx6yt8emCSnB7fcs+Nq9lIWGKaeEwRTnfw1B+r3bex6R9HSkNFbI
	 s/2hdV/dzXTTLvLx7rtB70nOF7m9hfqY35R7h5eY35GCu8RyZf6Qj9ygfbX6Qednoz
	 MHs21FcRRCPOQ==
From: alexs@kernel.org
To: Izik Eidus <izik.eidus@ravellosystems.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>,
	kasong@tencent.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-kernel@vger.kernel.org,
	"Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 06/11] mm/ksm: use folio in write_protect_page
Date: Wed, 20 Mar 2024 15:40:42 +0800
Message-ID: <20240320074049.4130552-7-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320074049.4130552-1-alexs@kernel.org>
References: <20240320074049.4130552-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Compound page is checked and skipped before write_protect_page() called,
use folio to save few compound_head checking and also remove duplicated
compound checking again in the func.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 165a3e4162bf..ad3a0294a2ec 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1275,23 +1275,21 @@ static u32 calc_checksum(struct page *page)
 	return checksum;
 }
 
-static int write_protect_page(struct vm_area_struct *vma, struct page *page,
+static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
 			      pte_t *orig_pte)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, 0);
+	DEFINE_PAGE_VMA_WALK(pvmw, &folio->page, vma, 0, 0);
 	int swapped;
 	int err = -EFAULT;
 	struct mmu_notifier_range range;
 	bool anon_exclusive;
 	pte_t entry;
 
-	pvmw.address = page_address_in_vma(page, vma);
+	pvmw.address = page_address_in_vma(&folio->page, vma);
 	if (pvmw.address == -EFAULT)
 		goto out;
 
-	BUG_ON(PageTransCompound(page));
-
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, pvmw.address,
 				pvmw.address + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
@@ -1301,12 +1299,12 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
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
@@ -1326,20 +1324,20 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
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
@@ -1505,7 +1503,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 	 * ptes are necessarily already write-protected.  But in either
 	 * case, we need to lock and check page_count is not raised.
 	 */
-	if (write_protect_page(vma, page, &orig_pte) == 0) {
+	if (write_protect_page(vma, (struct folio *)page, &orig_pte) == 0) {
 		if (!kpage) {
 			/*
 			 * While we hold page lock, upgrade page from
-- 
2.43.0


