Return-Path: <linux-kernel+bounces-136558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5C389D584
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED991F239B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9278564D;
	Tue,  9 Apr 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/9py+Ni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60285631
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654728; cv=none; b=BayefOcjsfV0ReEiOkpWDri5W7pTaZzeqQNb39KrD5qqvrIJJry485BeqlFx/CSmG4CGUdTpFytuyj4FQbY3R7lnLXHE+3KJwOotTWMbb0GrNB8MM//NJO3+/UuvdrSDXXfXaWZS30LJZiYCTq5+3mK4tycaoOA7cuVg7XqGSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654728; c=relaxed/simple;
	bh=ZY9sin7F1FOM2/QeBR1n457pb/jjou4lTyaBx1XPflg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENcq8ktPpX1nQkRKLZvnkYSNwTARv/S9b6bL1T6CoI0crubdPUKc79M7TWsoCz8nGkxLnq4mKD33q6498Sz0AGobbvHfXmFoAXB2verFpiEtjpaiI+52FbpsLZDyGuSFzC7sWg4XswnX/I4kl1YlzKnAPCGppTBXpxbGvQ4tV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/9py+Ni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7A1C433B1;
	Tue,  9 Apr 2024 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654727;
	bh=ZY9sin7F1FOM2/QeBR1n457pb/jjou4lTyaBx1XPflg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/9py+NidPXCVPUMGd0kufG/y63MT2AfemIKhalAx4FloWPEwHbZK2/NodbgYlfam
	 zo+IBb/3dmx60VAHPosB7YEpJzjE4f6byWsF3cqBNDQTCYzHNlz1HVqKnDT2HCh1lK
	 cUy1Qp/Nk+bw0qgcno/YuSUreXEUWW5SOgssY+aVr+ovZlF1o6DrO62VsIqPaDSqIL
	 ttYkVNFKBA5orHBOuPQ5xlqvdb3bamLKbDz+es7APokW2gfKAb7pAAom0ncqZU5hyo
	 ppGJR9OmDqADNk7NeIrzMkHFXmhTBU3CmUQdRp16HYybhutxFGJOQXHy2+KNamaACi
	 QX7pHZuJY4FPg==
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
Subject: [PATCH v4 5/9] mm/ksm: use folio in stable_node_dup
Date: Tue,  9 Apr 2024 17:28:20 +0800
Message-ID: <20240409092826.1733637-6-alexs@kernel.org>
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

Use ksm_get_folio() and save 2 compound_head calls.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
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


