Return-Path: <linux-kernel+bounces-139824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45E48A0831
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64681C223A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FBC13CAAE;
	Thu, 11 Apr 2024 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgJlk6qU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6C13CF99
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816057; cv=none; b=pY435sh77TRFClt79uXxCqOfcGyKhKOWV+el6Abqsoq0YjPi+oTZ0i2Riw+GiutdEIdvmnPAUTxm81ylb9f0tR3tmToYVXAryL0d6SBEAGD1JwWiItyx7YMXvl4Bfj5SCI/vxgV2O1Nv8ODHyUzYdl3W0uPkiBfLokuUrAJC2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816057; c=relaxed/simple;
	bh=oezv8n190iRAYJbqG1rSb+HEO3aakytr9BMxPO0jqOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqcIQOh3jkSfZVcMoarOHGd2m0Kh9omTasuFQQH9bsIREBAotaiSh7HEfYSr02e+Cp2s8/q6G5V5tDAV5k3xQZk66ANQ/rdX2ZZgyGL8WXqHB2lLDd3EevfTnTHOAS7N75YgPBcK7c7L+P6ePSKe23kNcW5zvlfHQ9bz66KqE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgJlk6qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A9EC433C7;
	Thu, 11 Apr 2024 06:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816057;
	bh=oezv8n190iRAYJbqG1rSb+HEO3aakytr9BMxPO0jqOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgJlk6qUo71If1Hxiz9eQsY0pFcpm4jNK7/rtAzAt/q4vCYQU03Bl1aZ5ZiY8T50U
	 3SNtQ75PjlVB+Y0VNKaGnr0UqLF1Phb9fwrNgXo18gnLvsJT7FChrz2OuTpUa9k6+A
	 7CLGzC5F3kZwMwngHWwW42Ddk91bRjqfI4zoGb//eWcMRxIqkPPFrsOWo8vv28pzB9
	 k5BOFJGgkRmvIxtiA3fPAT1wRfDn8OJXuOrXGutaJNGVLD6BdVs4HxQmCaTC15xVPX
	 PyauH5xarZ2NzpCIuJlDGmEQXiWk3VzrrCtxAlc/AQ7XFAIZNY/yS3T5v/PSPTCZOl
	 Ld+oDpm/7WNhg==
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
Subject: [PATCH v5 01/10] mm/ksm: add ksm_get_folio
Date: Thu, 11 Apr 2024 14:17:02 +0800
Message-ID: <20240411061713.1847574-2-alexs@kernel.org>
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

The ksm only contains single pages, so we could add a new func
ksm_get_folio for get_ksm_page to use folio instead of pages to save a
couple of compound_head calls.

After all caller replaced, get_ksm_page will be removed.

Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8c001819cf10..ac126a4c245c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -897,7 +897,7 @@ enum get_ksm_page_flags {
 };
 
 /*
- * get_ksm_page: checks if the page indicated by the stable node
+ * ksm_get_folio: checks if the page indicated by the stable node
  * is still its ksm page, despite having held no reference to it.
  * In which case we can trust the content of the page, and it
  * returns the gotten page; but if the page has now been zapped,
@@ -915,10 +915,10 @@ enum get_ksm_page_flags {
  * a page to put something that might look like our key in page->mapping.
  * is on its way to being freed; but it is an anomaly to bear in mind.
  */
-static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
+static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
 				 enum get_ksm_page_flags flags)
 {
-	struct page *page;
+	struct folio *folio;
 	void *expected_mapping;
 	unsigned long kpfn;
 
@@ -926,8 +926,8 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
 					PAGE_MAPPING_KSM);
 again:
 	kpfn = READ_ONCE(stable_node->kpfn); /* Address dependency. */
-	page = pfn_to_page(kpfn);
-	if (READ_ONCE(page->mapping) != expected_mapping)
+	folio = pfn_folio(kpfn);
+	if (READ_ONCE(folio->mapping) != expected_mapping)
 		goto stale;
 
 	/*
@@ -940,41 +940,41 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
 	 * in folio_migrate_mapping(), it might still be our page,
 	 * in which case it's essential to keep the node.
 	 */
-	while (!get_page_unless_zero(page)) {
+	while (!folio_try_get(folio)) {
 		/*
 		 * Another check for page->mapping != expected_mapping would
 		 * work here too.  We have chosen the !PageSwapCache test to
 		 * optimize the common case, when the page is or is about to
 		 * be freed: PageSwapCache is cleared (under spin_lock_irq)
 		 * in the ref_freeze section of __remove_mapping(); but Anon
-		 * page->mapping reset to NULL later, in free_pages_prepare().
+		 * folio->mapping reset to NULL later, in free_pages_prepare().
 		 */
-		if (!PageSwapCache(page))
+		if (!folio_test_swapcache(folio))
 			goto stale;
 		cpu_relax();
 	}
 
-	if (READ_ONCE(page->mapping) != expected_mapping) {
-		put_page(page);
+	if (READ_ONCE(folio->mapping) != expected_mapping) {
+		folio_put(folio);
 		goto stale;
 	}
 
 	if (flags == GET_KSM_PAGE_TRYLOCK) {
-		if (!trylock_page(page)) {
-			put_page(page);
+		if (!folio_trylock(folio)) {
+			folio_put(folio);
 			return ERR_PTR(-EBUSY);
 		}
 	} else if (flags == GET_KSM_PAGE_LOCK)
-		lock_page(page);
+		folio_lock(folio);
 
 	if (flags != GET_KSM_PAGE_NOLOCK) {
-		if (READ_ONCE(page->mapping) != expected_mapping) {
-			unlock_page(page);
-			put_page(page);
+		if (READ_ONCE(folio->mapping) != expected_mapping) {
+			folio_unlock(folio);
+			folio_put(folio);
 			goto stale;
 		}
 	}
-	return page;
+	return folio;
 
 stale:
 	/*
@@ -990,6 +990,14 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
 	return NULL;
 }
 
+static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
+				 enum get_ksm_page_flags flags)
+{
+	struct folio *folio = ksm_get_folio(stable_node, flags);
+
+	return &folio->page;
+}
+
 /*
  * Removing rmap_item from stable or unstable tree.
  * This function will clean the information from the stable/unstable tree.
-- 
2.43.0


