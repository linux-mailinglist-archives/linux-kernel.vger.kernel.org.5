Return-Path: <linux-kernel+bounces-117038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B388A65E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656661F2EE7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C4515E7E8;
	Mon, 25 Mar 2024 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRtPf4r8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20015E5BC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370759; cv=none; b=BOt3BA06w5wqOFxJSR5J1Z19YgN3EajP67mHKMvfR7rcfZxviv+WdjBohtpsVhgPDV6GMooRNGJ+k0u+JAb9gDSVP7YuLzh1p//EKJZxUD5lJzGMwzknxdJ6ja5a6Y3iLXmE+y0Uy9YZKwXyOrwzG5f5YtkzUgneCrwFp5StVUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370759; c=relaxed/simple;
	bh=use98PRBO/PGh8RpGpv26dYXjrLSdpRJYI2DZcqj2jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8Fp7JtUUTfH7xB6/yuqP2KT8sX5qXcBt7STCO3qpVRc2OxDQWl/68HlNxIoRwoSWRAm4GkVviTxdsg9W8xqr7A4Gg2Q5OjHNMh8lBfcwlv7UnK0TkjvtAh3d6i7/UQdV4dqyZF5VUHeQmzQB/I+er04ShtUCYv/bW3K4ovPTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRtPf4r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB56AC433F1;
	Mon, 25 Mar 2024 12:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370759;
	bh=use98PRBO/PGh8RpGpv26dYXjrLSdpRJYI2DZcqj2jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRtPf4r8PWZiL5CnScSGqihoUvl5yGGa4RN9z0L/EYdAJg3+6MqePjyIvUpkMx1rw
	 3Fsdp9liTUlZSC+8d9zCkq4Ngw7NrIclL994hgNJbmp/L+puZisbyUSfZXfOtw+KIR
	 gQFjeo1NO9/gGmslX7z9ky+Yd9OjWbR9pLsVS2suqmxtBS2Kd4tFIgl52/eU999qlH
	 9MKIs+9iKWxWm2B22UK37n5x5CT9GlBfIPmlycWt+5Lg0h/GXkA33I0DE3DZPOu1+j
	 SXAcDHdBp3ph/rHE5tK/WavJAR82+8zTaPgB+Rr6yrDkvWUuv20zQVqKkuL81nrhpH
	 0zWOkcXhZePAw==
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
Subject: [PATCH v3 05/14] mm/ksm: use folio in stable_node_dup
Date: Mon, 25 Mar 2024 20:48:52 +0800
Message-ID: <20240325124904.398913-6-alexs@kernel.org>
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

Use ksm_get_folio() and save 2 compound_head calls.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 mm/ksm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index b6ee2bc7646f..aa80fbf3a8e0 100644
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
+	return &tree_folio->page;
 }
 
 static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stable_node,
-- 
2.43.0


