Return-Path: <linux-kernel+bounces-48237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB58458ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36951C21F71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457053391;
	Thu,  1 Feb 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f2iaxKHw"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F1D53369
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794293; cv=none; b=JQvFSgLKpTJjcqCJru3T9SOUBP+Si5isW7DyWxhKTKU9I5JDOB0Y+R1n+OuynzW7qUKUcMjT/Jq1agCe5K0GGxZYOscBHyatGacKEQaE1KRCf3lfodVTlCFUvht/ZPqrrjwVUd3ZJHCX3pJ8q0BmSOn8Oeu61mTnNJ/adK/eV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794293; c=relaxed/simple;
	bh=T6/oMqfm0cTUFZu7aG4cysOe/uV1jAyX0rldyapQGag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p/JOYhiYGrZYvZou20wIJAP/KzzqmUOK6l73sUF8G3e20YogeDhkVAKbSIZ3zstGpi4op34oT2arprOEWUjnjC9kDTRiNP0+gJolmg1ETgslXjEQxDfiKxGqOhnuSRy/U6B+KWLWwXTmgb1hpkgGyN5JvO1sVv0dnl/NCueX7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f2iaxKHw; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706794282; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YTeBhqdSU74IlpwBPcbqYdhQu9vEwdBX/KgZ9rQ8d00=;
	b=f2iaxKHwRYfdAnZsvsKvJF84+YvPrP0z41Chw6K2IlkPvjTa1JgXVk90orxqOZbWD3bLUDazHvrpUFatRJ5iCjwcphwIznGP+He9MaaZEsk7kNgSfO632hLR9WSMsT6Eqw/qa8dkVp82cC1OXrl8JgUyMbTERCb6Wpm5x5TkNqA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.tpA.q_1706794281;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W.tpA.q_1706794281)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 21:31:22 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: osalvador@suse.de,
	david@redhat.com,
	mhocko@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when dissolving the old hugetlb
Date: Thu,  1 Feb 2024 21:31:13 +0800
Message-Id: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 369fa227c219 ("mm: make alloc_contig_range handle free
hugetlb pages"), the alloc_contig_range() can handle free hugetlb pages
by allocating a new fresh hugepage, and replacing the old one in the
free hugepage pool.

However, our customers can still see the failure of alloc_contig_range()
when seeing a free hugetlb page. The reason is that, there are few memory
on the old hugetlb page's node, and it can not allocate a fresh hugetlb
page on the old hugetlb page's node in isolate_or_dissolve_huge_page() with
setting __GFP_THISNODE flag. This makes sense to some degree.

Later, the commit ae37c7ff79f1 (" mm: make alloc_contig_range handle
in-use hugetlb pages") handles the in-use hugetlb pages by isolating it
and doing migration in __alloc_contig_migrate_range(), but it can allow
fallbacking to other numa node when allocating a new hugetlb in
alloc_migration_target().

This introduces inconsistency to handling free and in-use hugetlb.
Considering the CMA allocation and memory hotplug relying on the
alloc_contig_range() are important in some scenarios, as well as keeping
the consistent hugetlb handling, we should remove the __GFP_THISNODE flag
in isolate_or_dissolve_huge_page() to allow fallbacking to other numa node,
which can solve the failure of alloc_contig_range() in our case.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9d996fe4ecd9..9c832709728e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3029,7 +3029,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 			struct folio *old_folio, struct list_head *list)
 {
-	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	gfp_t gfp_mask = htlb_alloc_mask(h);
 	int nid = folio_nid(old_folio);
 	struct folio *new_folio;
 	int ret = 0;
@@ -3088,7 +3088,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		 * Ref count on new_folio is already zero as it was dropped
 		 * earlier.  It can be directly added to the pool free list.
 		 */
-		__prep_account_new_huge_page(h, nid);
+		__prep_account_new_huge_page(h, folio_nid(new_folio));
 		enqueue_hugetlb_folio(h, new_folio);
 
 		/*
-- 
2.39.3


