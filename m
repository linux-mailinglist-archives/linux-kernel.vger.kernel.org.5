Return-Path: <linux-kernel+bounces-136562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FAB89D589
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850EC284CB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1904D86269;
	Tue,  9 Apr 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WssjhCxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C085631
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654739; cv=none; b=M5gdWb25NR3BoFyn3OpD+gLYxaal3amaT6SdFKQDZoq5SzYGb5H9oBzNDNISqt6NfdwUywFIdDrQ6M8sp1uV8O+VOo0JgzDQA2K0/0X6qk8HCtfV17GkDZSHPDjRBhx7XALroBpd3rqEyBKnBGd1wA6VHCD3ebszeBJOhObNp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654739; c=relaxed/simple;
	bh=MGM8cnYOc2xUfzqiaHDKMMd1O2BaUHSekMXG68vTT9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSaajEa6hajevLHAjOtlhvzMjB6hexh5VQmA1mJSCJh2WxCWZfgB4BBnzehPFzYJUGZUFFPtwjNBNURmoQ1GfJBSW37n7ULjZ1G/nmoM+cE485l7vBFq1sAFd3MhAKdlHbB9wLwl94cZIzYs04QgQb4O8nZhS0m1+K02aJvwDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WssjhCxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AEBC43390;
	Tue,  9 Apr 2024 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654739;
	bh=MGM8cnYOc2xUfzqiaHDKMMd1O2BaUHSekMXG68vTT9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WssjhCxIFV/yIm+DWR08ghSxRH0lwhxnaD1vS2T9rvquOXkj3qGcbCZmtRVCMugbx
	 IpWPk8pGp412gnIoQ31Hh+Nj/nr0kRrJQXzBuprxRcKWtx46uGS3zwlAVGzzAnLZOa
	 52pTuciC59Q7qvfrK/iyC4ieJiOEUd4NAdFCWYHbq3mk8cYivLFFarlmlmJQ3ANn4L
	 vJKWBxpUoAfA+1TuCAgUsamwLOWgCzpz3n7rfQU0g534XfH/f/OuaqzHk9rvsWc4Go
	 6wBLSxMwmhQEKLpYL8rYKa8MXVHlvfAV/2jf/n0c8537CHdVO8iTIdYeth+9BA3DNQ
	 yLoovR8/YKs9Q==
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
Subject: [PATCH v4 9/9] mm/ksm: replace set_page_stable_node by folio_set_stable_node
Date: Tue,  9 Apr 2024 17:28:24 +0800
Message-ID: <20240409092826.1733637-10-alexs@kernel.org>
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

Only single page could be reached where we set stable node after write
protect, so use folio converted func to replace page's. And remove the
unused func set_page_stable_node().

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index a705ed16aa1b..0d703c3da9d8 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1094,17 +1094,11 @@ static inline struct ksm_stable_node *page_stable_node(struct page *page)
 	return folio_stable_node(page_folio(page));
 }
 
-static inline void set_page_stable_node(struct page *page,
-					struct ksm_stable_node *stable_node)
-{
-	VM_BUG_ON_PAGE(PageAnon(page) && PageAnonExclusive(page), page);
-	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
-}
-
 static inline void folio_set_stable_node(struct folio *folio,
 					 struct ksm_stable_node *stable_node)
 {
-	set_page_stable_node(&folio->page, stable_node);
+	VM_WARN_ON_FOLIO(folio_test_anon(folio) && PageAnonExclusive(&folio->page), folio);
+	folio->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
 }
 
 #ifdef CONFIG_SYSFS
@@ -1519,7 +1513,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 			 * PageAnon+anon_vma to PageKsm+NULL stable_node:
 			 * stable_tree_insert() will update stable_node.
 			 */
-			set_page_stable_node(page, NULL);
+			folio_set_stable_node(page_folio(page), NULL);
 			mark_page_accessed(page);
 			/*
 			 * Page reclaim just frees a clean page with no dirty
-- 
2.43.0


