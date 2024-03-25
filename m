Return-Path: <linux-kernel+bounces-117033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37B88A657
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9181F2FA67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14086CDBE;
	Mon, 25 Mar 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqD8rAwq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FE36CDA8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370748; cv=none; b=s2uSwTmD4eUYyQAIOrGlwTp0NSToQF7SN6v0N3gl3fVDCKEz24BmdfTkzFO49bxn4J9jccxclBovFMUBFgFl9mU5dMGA0ig6kac01xX/BQeQuKQHRIieUtRc90vrQt8MTZr47j+TfK5qOnNlgikVPs0fLTuTQ/+edQmAHGtU42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370748; c=relaxed/simple;
	bh=QDhgdKPLSZ+LCN9CDxfi2X7NfAWh6m7wtgm+INCh864=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFPWmwaK5ND9BYXzBF6ah0nNRUbskT5J9nhF5q7jTSdxuPLdbnUNCVf7kaivDXOzz296koOaRm2Qqpn4JbTYny1AOdaCaKbvYlbUyhsuTg1sM/cg+q8+b2Yw59Emf1Ug7Bhd/XQIjrVPOa25SxNV/DDDt4c0eSktmlexd7mBjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqD8rAwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4269BC43394;
	Mon, 25 Mar 2024 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370747;
	bh=QDhgdKPLSZ+LCN9CDxfi2X7NfAWh6m7wtgm+INCh864=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqD8rAwqqd1rZlggHYvDueBQdTe6WYxAdUuXriWjNgenrTHHVxgd7GnHtwUzXPlhH
	 Euyl3J3vJqwRgkj3fMPW6SSRO52ygC73Q37XEga85/ltaHFKcyi6/C2rE8khfLB5PY
	 bxE3SiDge/MfBeeZCQnSRaw+A7+4HaJJVcT/0uxumAh0+nAx5acDnUKKC4zVEo1HSD
	 9RBSBXjM3odN+trHUYLuYZ2raubRH4AfZKu7VHIhfapDctVyDJdBckiKsEpDWGh90q
	 aPKP7sDOtjUpNAHzVOTGKEQnQnT3FK+ONVRVirrIwynhumCYaAlKkfN748A6RM0AbW
	 pKbYUkce4rmmg==
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
Subject: [PATCH v3 01/14] mm/ksm: add ksm_get_folio
Date: Mon, 25 Mar 2024 20:48:48 +0800
Message-ID: <20240325124904.398913-2-alexs@kernel.org>
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

The ksm only contains single pages, so we could add a new func
ksm_get_folio for get_ksm_page to use folio instead of pages to save a
couple of compound_head calls.

After all caller replaced, get_ksm_page will be removed.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
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


