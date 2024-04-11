Return-Path: <linux-kernel+bounces-139828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5BD8A0835
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D48C1F24CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1613D528;
	Thu, 11 Apr 2024 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohkAORx1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB013CAA0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816068; cv=none; b=ocHqgeDeQJ9cymuDRgx+wbvyApcsRWZaBW5ngOc8rMcvFR3C22wZhhTii/2CrVMaOWtn5HBYV15M1ab813eUIlgX81zX/nuGoaBD7qY7kPXfZUK/gpCw8CiM0aBM0Sd3IJvdfuMbu26IlvOG2UvAa/6QQx2ano2ut+TL7bp+jZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816068; c=relaxed/simple;
	bh=6Rigut9B0xei0o3RlU/2pvsNtNjz8VS58APxTOkaTzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/BRm5P/+RiH0zOJdf4rAsnOuucPUC3ViSkupaWNL1NovQpe5OsPv3fLFVP8uxojXFTQ8Ug9FV3aAuyfYxgkmyKgBZ6iQqEdFol8KNnjlApubA7b+zKOTFzSJsWc6RwQge3UhpQaSTFMFnq+P2R6gwCaJavbJaaGP2xU2eGiFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohkAORx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F82C433B2;
	Thu, 11 Apr 2024 06:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712816068;
	bh=6Rigut9B0xei0o3RlU/2pvsNtNjz8VS58APxTOkaTzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohkAORx1XDD/r3zGvplob2RLchLHYpJtenMlCbrLa21NNHXYHsSFleenl2QJvPwDO
	 BmJobQMM8/tiaJ2dc6Xqc1+pTXwNBj4/zO06Eeu4LRUemG65+A9n/DP1SoCXG6914z
	 vmmFfjvM6AxZfKRbJh6c/IeVBz7S8/GXndViQaqA1DdKxNizoD+AfChC+db9N5Bnp9
	 7vRT2PZBknD6b550bTqQ9oSG/8iTN94euob/LzgnwW4VPDEHbwNrSjRjnWDXIqu14t
	 sx0a9yK+5/uUZG1uXV0Si3q76gnQPcXFHtNdkX+DnqoIGAZzLazQIpwpJpOYxe4ryU
	 EYYNzK4nJSBNA==
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
Subject: [PATCH v5 05/10] mm/ksm: use folio in stable_node_dup
Date: Thu, 11 Apr 2024 14:17:06 +0800
Message-ID: <20240411061713.1847574-6-alexs@kernel.org>
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

Use ksm_get_folio() and save 2 compound_head calls.

Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 1a7b13004589..654400f993fc 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1638,7 +1638,7 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 {
 	struct ksm_stable_node *dup, *found = NULL, *stable_node = *_stable_node;
 	struct hlist_node *hlist_safe;
-	struct page *_tree_page, *tree_page = NULL;
+	struct folio *folio, *tree_folio = NULL;
 	int nr = 0;
 	int found_rmap_hlist_len;
 
@@ -1657,24 +1657,24 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 		 * We must walk all stable_node_dup to prune the stale
 		 * stable nodes during lookup.
 		 *
-		 * get_ksm_page can drop the nodes from the
+		 * ksm_get_folio can drop the nodes from the
 		 * stable_node->hlist if they point to freed pages
 		 * (that's why we do a _safe walk). The "dup"
 		 * stable_node parameter itself will be freed from
 		 * under us if it returns NULL.
 		 */
-		_tree_page = get_ksm_page(dup, GET_KSM_PAGE_NOLOCK);
-		if (!_tree_page)
+		folio = ksm_get_folio(dup, GET_KSM_PAGE_NOLOCK);
+		if (!folio)
 			continue;
 		nr += 1;
 		if (is_page_sharing_candidate(dup)) {
 			if (!found ||
 			    dup->rmap_hlist_len > found_rmap_hlist_len) {
 				if (found)
-					put_page(tree_page);
+					folio_put(tree_folio);
 				found = dup;
 				found_rmap_hlist_len = found->rmap_hlist_len;
-				tree_page = _tree_page;
+				tree_folio = folio;
 
 				/* skip put_page for found dup */
 				if (!prune_stale_stable_nodes)
@@ -1682,7 +1682,7 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 				continue;
 			}
 		}
-		put_page(_tree_page);
+		folio_put(folio);
 	}
 
 	if (found) {
@@ -1747,7 +1747,7 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 	}
 
 	*_stable_node_dup = found;
-	return tree_page;
+	return &tree_folio->page;
 }
 
 static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stable_node,
-- 
2.43.0


