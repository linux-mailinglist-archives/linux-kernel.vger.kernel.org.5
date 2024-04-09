Return-Path: <linux-kernel+bounces-136553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8A189D57C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5E6284CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DBE80020;
	Tue,  9 Apr 2024 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRFcqFN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C38003D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654717; cv=none; b=gEAOcUzwRfV2I2KguWOYWcPvhrj0LX8uJTV+8tL4wNvG2c/2UytVqQ5RNMCeVr35XHaM8JO3Vm7D2/hQZdeZJl3KZL0MIbuxB3rDjjFRojIGtgmNbfEt5Zfwn1CQcsz5BsHi95LZUpSIj4z5fTWL12/nKduJweZ2bwYZzq9gi7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654717; c=relaxed/simple;
	bh=jy6PhQURlzWnemsEhuISNb873RtM8zjTy52Z9fJnaQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ff9U9OawqoJNlrJ6MDdwF7kgeEG3n7qi2NpvoKmcN9EFcZqeKWTCXtzJfMneQIAZkp3k3Q/PKFM+SsgjvwrZl/B86RqgwHZ45sFAJM9GByganNFHRJsyK/Fzzs0Ayq15yRGnjLaqcXkj6DHXZEwTsUqyt38da8bsj6N/UF4c1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRFcqFN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EFEC43390;
	Tue,  9 Apr 2024 09:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654717;
	bh=jy6PhQURlzWnemsEhuISNb873RtM8zjTy52Z9fJnaQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRFcqFN9/XtdCn1Sbvo2Ddn+Ka5gBb/M2Y/Q0SD9k4n7tUVbGSJveLmsl9M8J9cDy
	 20+EmBJsTN2SUT/vt59KF9BxtksTeVWOSZs3E6BIXoMeScBM1ZfqUx8Fq783/yp8m2
	 u2oEPEGPPrgCI+XsJXITtUUH8VIM0MlCkXPcy/2EKPzxthn2kzLzMcE5U/a8+L1EYa
	 91TJ5ltdVOR3EDcHvQdeGI9BJJ5T96tgJZTnePSgKHwFYMpzrqD4vZmzICwhNWKQZk
	 liyNGwApsCciLgWPQ6zoLlKRFvNaQytldVXlzCIsJC8KqkYZJEqkChrbG38FjG9//8
	 /dOweJU2fevgQ==
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
Subject: [PATCH v4 1/9] mm/ksm: add ksm_get_folio
Date: Tue,  9 Apr 2024 17:28:16 +0800
Message-ID: <20240409092826.1733637-2-alexs@kernel.org>
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

The ksm only contains single pages, so we could add a new func
ksm_get_folio for get_ksm_page to use folio instead of pages to save a
couple of compound_head calls.

After all caller replaced, get_ksm_page will be removed.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8c001819cf10..ac080235b002 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
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


