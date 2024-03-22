Return-Path: <linux-kernel+bounces-111134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B50886846
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCCA1F22C95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F3938DE4;
	Fri, 22 Mar 2024 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGS9D7Rv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42624383AD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096486; cv=none; b=Gj8aAINrXWg6GGuULApgePjuJEox+QIN4y/v3arKnYyYE9KaM6kAu8VRzpFQviorZBJxcyFye8JzOPqIKeuiUM2YcvQdvOghmtfUuWW0ovr97fLlkJ3KFrfJF2owesgsROnKFNgHdx4ui4i+0QG3zNKjKUa7sQK53vKIaSYyhRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096486; c=relaxed/simple;
	bh=swBWDDTfKPZfIshmO9+8+Tzqpp1exgNxKwXg3dE2124=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvDVumDV/iFnyRHvA2LYAwgEoj+q/5/obVi5PFGVOp84QxPNNeN71dYEHBXNTboudC/5P8mCCg9aNTAzp2S0cKbLAENXdb/jq7lzWJcOEqsoRx769vPzzLnWPCvN4oWa4wpb01v9ihXT2mhVocRRqwcMpSEXtWeD4hai/DbOz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGS9D7Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C74C433C7;
	Fri, 22 Mar 2024 08:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711096485;
	bh=swBWDDTfKPZfIshmO9+8+Tzqpp1exgNxKwXg3dE2124=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGS9D7RvKPTXxnlUVQ0m7lLcLgSe2JsQ/C16nFNsWIGdx4hoVu89jKYQPZ4pVIQkm
	 LUZdfrNIl0j5qWWmh4/GQMYf3eOKTE6mHp5fIGtBMuuvvVAP+R5SFBNQbMPnw36m3V
	 Rf2vKsB8o3WwISyorzm7bMYUo9LsItXJR25HAL8vwOxVRpln+3DCSY0tLqkFXpRFcx
	 xS1EuUj37mxQQVQ1p71HaIYocf9QpwNj0O7EzfE4w/5f+JtGoz5o3C1LZy8CGETqLl
	 Bm7PkXRuP6Zq38bMbL9QYNQNM6p9vGLqBrL3lahxrNBsWhLEtglFCySXScJBlQ1LDs
	 bCd5xTUf+YRVA==
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
Subject: [PATCH v2 05/14] mm/ksm: use folio in stable_node_dup
Date: Fri, 22 Mar 2024 16:36:52 +0800
Message-ID: <20240322083703.232364-6-alexs@kernel.org>
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

Use ksm_get_folio() and save 2 compound_head calls.

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
index b6ee2bc7646f..a1e382ecd501 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1631,14 +1631,14 @@ bool is_page_sharing_candidate(struct ksm_stable_node *stable_node)
 	return __is_page_sharing_candidate(stable_node, 0);
 }
 
-static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
-				    struct ksm_stable_node **_stable_node,
-				    struct rb_root *root,
-				    bool prune_stale_stable_nodes)
+static void *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
+			     struct ksm_stable_node **_stable_node,
+			     struct rb_root *root,
+			     bool prune_stale_stable_nodes)
 {
 	struct ksm_stable_node *dup, *found = NULL, *stable_node = *_stable_node;
 	struct hlist_node *hlist_safe;
-	struct page *_tree_page, *tree_page = NULL;
+	struct folio *folio, *tree_folio = NULL;
 	int nr = 0;
 	int found_rmap_hlist_len;
 
@@ -1663,18 +1663,18 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
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
+	return tree_folio;
 }
 
 static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stable_node,
-- 
2.43.0


