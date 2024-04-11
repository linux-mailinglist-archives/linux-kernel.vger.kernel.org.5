Return-Path: <linux-kernel+bounces-139832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF348A0839
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3BE1C222BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3442913DDBD;
	Thu, 11 Apr 2024 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDQK7Bqf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718BBE57F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816079; cv=none; b=WkxG7wSiXaOaDEaLvYaqm6XpoRt9IPwiaNV1C0ms3bnGyPz/k18Rysq/6UKj1pTXjKP5KNjf+t+BooBpEAqo0qmqZ1KHqwGHwS4PG0NIVJC8tgwkLo1W0QnMFrl5i0Wfr/gvYx0W9cudYWDBpXNcJowL0sBY4LXvTvM/nnKnJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816079; c=relaxed/simple;
	bh=wwxxrSyMrjaoURhO6OXX+a2E0cDwbJxoGFhUDcJuPic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7Hvl2bmWCc+4CwJHViVCsMShJ2xvWmu6901HUlDhbWC3rTiqkAiIn4DYD4258QqTph1J7P86p2iT26jBRQCtQ1F4Zx7WMJdJsstRhZSIdyJrGjT7j98kIwKP/eav03l4Kj3e2mK7ELDs52FYh8jijOUzc9vfpKylcdTD3+2onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDQK7Bqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CA9C43142;
	Thu, 11 Apr 2024 06:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816079;
	bh=wwxxrSyMrjaoURhO6OXX+a2E0cDwbJxoGFhUDcJuPic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDQK7BqfFTyKR3n/R+YvyO4I55kJp28xKTt8gOMJzVuB5hAcmSDUzIwLWBVsgvyfX
	 Z6RjymuU0IhJe/n62nYuMNFQ5PMVSYhI5XxpLhIThOrYM4D92pBZP3z58FxKyiU3Qq
	 1kVWLlrq++6LvXjzYqEIHQEA9vJYF8cfrr5QHj1c1Eiu03aUiYbNOUdA4VGxgbLgXE
	 /TPzMg7BdEdke3czh9Uxlrs/bG+nCAlWaMRO436c7KOe8uKYBOEGgAJECYwXFIdbxH
	 i5gYTYmC76/TLxM5nbCeHVcTdn6lIK53zFtmshPmYl6SjDCvWHl/Ox68b39PndsJyM
	 NAhveKN2mU7yw==
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
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH v5 09/10] mm/ksm: rename get_ksm_page_flags() to ksm_get_folio_flags
Date: Thu, 11 Apr 2024 14:17:10 +0800
Message-ID: <20240411061713.1847574-10-alexs@kernel.org>
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

From: David Hildenbrand <david@redhat.com>

As we are removing get_ksm_page_flags(), make the flags match the new
function name.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Shi <alexs@kernel.org>
---
 mm/ksm.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 61a7b5b037a6..662fdaaf3ea3 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -890,10 +890,10 @@ static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
 	free_stable_node(stable_node);
 }
 
-enum get_ksm_page_flags {
-	GET_KSM_PAGE_NOLOCK,
-	GET_KSM_PAGE_LOCK,
-	GET_KSM_PAGE_TRYLOCK
+enum ksm_get_folio_flags {
+	KSM_GET_FOLIO_NOLOCK,
+	KSM_GET_FOLIO_LOCK,
+	KSM_GET_FOLIO_TRYLOCK
 };
 
 /*
@@ -916,7 +916,7 @@ enum get_ksm_page_flags {
  * is on its way to being freed; but it is an anomaly to bear in mind.
  */
 static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
-				 enum get_ksm_page_flags flags)
+				 enum ksm_get_folio_flags flags)
 {
 	struct folio *folio;
 	void *expected_mapping;
@@ -959,15 +959,15 @@ static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
 		goto stale;
 	}
 
-	if (flags == GET_KSM_PAGE_TRYLOCK) {
+	if (flags == KSM_GET_FOLIO_TRYLOCK) {
 		if (!folio_trylock(folio)) {
 			folio_put(folio);
 			return ERR_PTR(-EBUSY);
 		}
-	} else if (flags == GET_KSM_PAGE_LOCK)
+	} else if (flags == KSM_GET_FOLIO_LOCK)
 		folio_lock(folio);
 
-	if (flags != GET_KSM_PAGE_NOLOCK) {
+	if (flags != KSM_GET_FOLIO_NOLOCK) {
 		if (READ_ONCE(folio->mapping) != expected_mapping) {
 			folio_unlock(folio);
 			folio_put(folio);
@@ -1001,7 +1001,7 @@ static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
 		struct folio *folio;
 
 		stable_node = rmap_item->head;
-		folio = ksm_get_folio(stable_node, GET_KSM_PAGE_LOCK);
+		folio = ksm_get_folio(stable_node, KSM_GET_FOLIO_LOCK);
 		if (!folio)
 			goto out;
 
@@ -1116,7 +1116,7 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
 	struct folio *folio;
 	int err;
 
-	folio = ksm_get_folio(stable_node, GET_KSM_PAGE_LOCK);
+	folio = ksm_get_folio(stable_node, KSM_GET_FOLIO_LOCK);
 	if (!folio) {
 		/*
 		 * ksm_get_folio did remove_node_from_stable_tree itself.
@@ -1656,7 +1656,7 @@ static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 		 * stable_node parameter itself will be freed from
 		 * under us if it returns NULL.
 		 */
-		folio = ksm_get_folio(dup, GET_KSM_PAGE_NOLOCK);
+		folio = ksm_get_folio(dup, KSM_GET_FOLIO_NOLOCK);
 		if (!folio)
 			continue;
 		nr += 1;
@@ -1779,7 +1779,7 @@ static struct folio *__stable_node_chain(struct ksm_stable_node **_stable_node_d
 	if (!is_stable_node_chain(stable_node)) {
 		if (is_page_sharing_candidate(stable_node)) {
 			*_stable_node_dup = stable_node;
-			return ksm_get_folio(stable_node, GET_KSM_PAGE_NOLOCK);
+			return ksm_get_folio(stable_node, KSM_GET_FOLIO_NOLOCK);
 		}
 		/*
 		 * _stable_node_dup set to NULL means the stable_node
@@ -1887,7 +1887,7 @@ static struct page *stable_tree_search(struct page *page)
 			 * fine to continue the walk.
 			 */
 			tree_folio = ksm_get_folio(stable_node_any,
-						   GET_KSM_PAGE_NOLOCK);
+						   KSM_GET_FOLIO_NOLOCK);
 		}
 		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
 		if (!tree_folio) {
@@ -1948,7 +1948,7 @@ static struct page *stable_tree_search(struct page *page)
 			 * than kpage, but that involves more changes.
 			 */
 			tree_folio = ksm_get_folio(stable_node_dup,
-						   GET_KSM_PAGE_TRYLOCK);
+						   KSM_GET_FOLIO_TRYLOCK);
 
 			if (PTR_ERR(tree_folio) == -EBUSY)
 				return ERR_PTR(-EBUSY);
@@ -2120,7 +2120,7 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 			 * fine to continue the walk.
 			 */
 			tree_folio = ksm_get_folio(stable_node_any,
-						   GET_KSM_PAGE_NOLOCK);
+						   KSM_GET_FOLIO_NOLOCK);
 		}
 		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
 		if (!tree_folio) {
@@ -2611,7 +2611,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			list_for_each_entry_safe(stable_node, next,
 						 &migrate_nodes, list) {
 				folio = ksm_get_folio(stable_node,
-						      GET_KSM_PAGE_NOLOCK);
+						      KSM_GET_FOLIO_NOLOCK);
 				if (folio)
 					folio_put(folio);
 				cond_resched();
-- 
2.43.0


