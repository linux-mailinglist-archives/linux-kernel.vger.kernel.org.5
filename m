Return-Path: <linux-kernel+bounces-117040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A588A661
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED7B1F39E68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB615ECF0;
	Mon, 25 Mar 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5flbydc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D315ECDF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370765; cv=none; b=S2qpW5Iol2n1oXjw7HuetHkRcZCCtlHoHKyYKhijPUQRoSsCwbnxOXfoQNpFGOvdpIDItudJxZoC8H0Edq7R9BcTYgAVhX/KozZdgXhQ5GbA6cLjWGmsobjzcAvGoXypGUvG/mBjUxncFb02kC/xitfYQ94c5Ed7T9Mp484+ubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370765; c=relaxed/simple;
	bh=lWYPejGlgqLibFq5W+K6QUuTn2MtB1S2BqZV6I+i3CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzdxVnyn/Vgp4DepD3M2BvaJyul4FXp/iRUtGuv1nQQGZF3kAvvQPBZg052m3WTz2e++skiV9f1G2r9SJ8ks0icTcBagjx1qJf3+HDKBWGwsGt0+z9Rm6c9EkeYAR9Drqg5SWxChfScVtxU6qYadHFPgs/HYC0zo7+WYW1ePljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5flbydc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803FAC43390;
	Mon, 25 Mar 2024 12:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370764;
	bh=lWYPejGlgqLibFq5W+K6QUuTn2MtB1S2BqZV6I+i3CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5flbydcPOaY/CsPsj+d8KOVqtPlR7xNta+LNhWtad6FJFqA70qit66HqnLvBbz5W
	 PdFK1AZAtFcn36YWBVeGKp1BGYJqFQrd1S76oa3P3pen/6qEOHCUMZyvtVT0BMdG8D
	 w6CHnT3FBjQiWJgLtz+B/cuSw7+Su7GkwpVK3atIN530jw6OwqlIIPtj3GQviOugv1
	 XJuV5uGhtUYaSPGpRX8ZhcKDV7IQPfuLmkTsmrpbASbcL83UW9eck85Hv6WiRboR/g
	 IsYR4VfIJHEB7VqvFgPPzG3FKyXwQXR9nujPgfxR5nrtDhNtiW350jdjOHhAZXtbaH
	 PLku2UoUL3Gmw==
From: alexs@kernel.org
To: Matthew Wilcox <willy@infradead.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Izik Eidus <izik.eidus@ravellosystems.com>,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ryncsn@gmail.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH v3 07/14] mm/ksm: use folio in write_protect_page
Date: Mon, 25 Mar 2024 20:48:54 +0800
Message-ID: <20240325124904.398913-8-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325124904.398913-1-alexs@kernel.org>
References: <20240325124904.398913-1-alexs@kernel.org>
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
index 95a487a21eed..5d1f62e7462a 100644
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


