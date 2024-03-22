Return-Path: <linux-kernel+bounces-111136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE24886849
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69491F225E1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0D518629;
	Fri, 22 Mar 2024 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPndUjay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D9A168A8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096491; cv=none; b=thB+W3dP1JV1ETyM0tdJpAC4L7leHEJ+TW7EHyKckIYb0RLLawjIZ9+V5WMW2WHU8fEpNu/trPjKjKz/Iqc9jEdYJLWGLvPQZrm0Ya1CgBnUK5Em1ZQlYzBGAtml/Fm881X5SYtZlmHOfv/vMPKuPJkVIpJzmOss5pzEXJeLqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096491; c=relaxed/simple;
	bh=CRD+qsq6X8eUY6+mfkkDNsd4MjPhDaxu0Mmm/KE7kcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZBlhBS0uj6alESBnWiFBCOWARiwke1q3FhPKlnt9eD3sV9I6SQcA1+gUiEJHnqeH5xcFPMbL/yKlGLkANTCbbICC4asrVGZxFH9fO5VugC9RhpZXj4KUjudm/lpEdje5AaEphzeRFEw90yDU6Qs+bddXCQVF8ZSKSUIKplLFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPndUjay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C56C433F1;
	Fri, 22 Mar 2024 08:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096491;
	bh=CRD+qsq6X8eUY6+mfkkDNsd4MjPhDaxu0Mmm/KE7kcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPndUjayFYuvxAfrdHVpgbn3recU3ex9yh6yyygkZajGGC43bK7JvpNx2k8KyYj2J
	 SJ3AcquFw5gxtAwAzsgJcAX10ry74rQoDSQg6coQUWfwSoNnkQ4hPcT6KoDm4Qj8/U
	 6y5ZJFVIIb9ByKLPS6cnCjQgKXY/+0LepUrK+9bYUtm0y6hw/KBKkQM+3wp0RX2pLG
	 neO9o9EmWT94cbmzT1QVbawxNScHRds6LaBQoT+obrK3rMc57EGxTIrZysRoIg/vO1
	 UJJsrjQG4U4+0lxFljPG9881vtHf5Bm7IZpbJ8h5yXFaMcVQg9g2Fa4AhjlRGpICqL
	 z8SLLhp6LhmDw==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH v2 07/14] mm/ksm: use folio in write_protect_page
Date: Fri, 22 Mar 2024 16:36:54 +0800
Message-ID: <20240322083703.232364-8-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322083703.232364-1-alexs@kernel.org>
References: <20240322083703.232364-1-alexs@kernel.org>
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
---
 mm/ksm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index cd607b942c26..f41491cf13c6 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1289,22 +1289,22 @@ static u32 calc_checksum(struct page *page)
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
+	pvmw.address = page_address_in_vma(&folio->page, vma);
 	if (pvmw.address == -EFAULT)
 		goto out;
 
-	BUG_ON(PageTransCompound(page));
+	VM_BUG_ON(folio_test_large(folio));
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, pvmw.address,
 				pvmw.address + PAGE_SIZE);
@@ -1315,12 +1315,12 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
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
@@ -1340,20 +1340,20 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
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
@@ -1519,7 +1519,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
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


