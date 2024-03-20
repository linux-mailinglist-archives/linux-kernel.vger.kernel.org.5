Return-Path: <linux-kernel+bounces-108553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A03D880C25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9C41F23700
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D7B383A5;
	Wed, 20 Mar 2024 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YI8Hv6Xm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79D381BB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920270; cv=none; b=eal3VOeypM6LpbZAD3R1NR9YPmMt5gkP8AchD6oo2aEvlEEYW+Lj+2JjcWOJ1jkykCp3hs55r8HRCVV5vg+oqEwWcUW0XFyIl3Kky0KjNQnAq6LUyhYyhEnjEd5MzSJjbeGFUvBzUvpMSNnpVVaX8XD9EaL4bDxbxAhlCmDqrpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920270; c=relaxed/simple;
	bh=o9GRn+UUdxaobJAptmjj5VgVz5sUBp61iu84lZ36vgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOfAAm0y7Wfj3yp4qbvKMvIFNghtgmXmSTYuFeu+BcFxd3aN7eEE2wFvKsGKkxAE/+ibcMe9e+T6ZFbSd0/teTrKb7dgAKDeHt04eBxSyfqelosrPqJFvarjGSZInDFwEdo7WMNGhFAxUa6EQuK7zJWEm/elJzAsryadaorMlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YI8Hv6Xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5001CC43394;
	Wed, 20 Mar 2024 07:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710920269;
	bh=o9GRn+UUdxaobJAptmjj5VgVz5sUBp61iu84lZ36vgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YI8Hv6Xm0jtVWQtKp1cEyat0wmWHkY/j8Kn9DULx7rBhfbctCAntP1sNzBbd/Bgxf
	 GKK43+qd3J6n4vPv1LSUBWx7F0jGccn4GAjoLM7vsPEws0j8wqHcpLDkSqObqPUuVx
	 S00afiEWDkzZAspltpRvm6n9CzWLkZZD+sF6Yv437TNRj14g+lzb+lT9VmbZKVVdi0
	 S0FJt5H5PXEH4w1WFjdRasWZANKxZgTMKd0TGJwcL18EO4qG0Z+afEB0r2hCI/K5mL
	 QKchWwWwSDnOFXDVHupER88Io9H7AnuzjlMcmemfsbxURM5CC2DJV+0FmKEL2WDgAX
	 1i5wfHTNMdfWA==
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
Subject: [PATCH 04/11] mm/ksm: use folio in stable_node_dup
Date: Wed, 20 Mar 2024 15:40:40 +0800
Message-ID: <20240320074049.4130552-5-alexs@kernel.org>
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

Save 2 compound_head calls.

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
index 9ea9b5ac44b4..f57817ef75bf 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1617,14 +1617,14 @@ bool is_page_sharing_candidate(struct ksm_stable_node *stable_node)
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
 
@@ -1649,18 +1649,18 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 		 * stable_node parameter itself will be freed from
 		 * under us if it returns NULL.
 		 */
-		_tree_page = get_ksm_page(dup, GET_KSM_PAGE_NOLOCK);
-		if (!_tree_page)
+		folio = get_ksm_page(dup, GET_KSM_PAGE_NOLOCK);
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
@@ -1668,7 +1668,7 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 				continue;
 			}
 		}
-		put_page(_tree_page);
+		folio_put(folio);
 	}
 
 	if (found) {
@@ -1733,7 +1733,7 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 	}
 
 	*_stable_node_dup = found;
-	return tree_page;
+	return tree_folio;
 }
 
 static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stable_node,
-- 
2.43.0


