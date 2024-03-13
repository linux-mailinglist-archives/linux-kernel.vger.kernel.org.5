Return-Path: <linux-kernel+bounces-101809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606187ABCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32735286FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0E75C902;
	Wed, 13 Mar 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLlwADTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738B5BAC3;
	Wed, 13 Mar 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347839; cv=none; b=BFF+mavJrHchmi2w0pEsTds77GiL9mopOlnCsqDp8D55WDa+QJS9o0lTD0AAhI4PEbh6ukXSadtPZGWe8O5agJdU1HQQ9dZbv+kAQH2feiWohCxG4lyfbT2pyK7ND9JpZm2UhQAVRuA4Ce/gWzc6/LYB/jYl3TyD/HfcwW18duA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347839; c=relaxed/simple;
	bh=T6QsRNkgdzo6I3UWRsu4FApuPB6ewk3CFmecwbTtWM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMepFH+Bld2YHU8ZAR/IaKbCadobRfCEqEJZpFjErpjv2Ol8RiyUPscld+C5ce1purnBMKM/R0fHEvDlokatJ5LnAEr0N/7W7yhPEMAzoykAGVn6enJrAxmShXGYEqDYnq+TIKW00bNogoVFp8xW4ho20DX2ZclFDwQ8kzL/pX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLlwADTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EA7C43390;
	Wed, 13 Mar 2024 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347839;
	bh=T6QsRNkgdzo6I3UWRsu4FApuPB6ewk3CFmecwbTtWM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLlwADTqHQXnEfbk/mat25aKXSBWtYIJ7HlzwAQWal1YDgNfvDSZ3Ks1Ub8hqIIrU
	 AzHQg0kXe/x3KRq3Aw9hyEP52sS5tOdskzLJ4TBmLQpdTLyTbpPjrhRXcnl6aM0TWu
	 hBqiz4/ir6dzikI7nKr4EyzeujPziy9KuaxW4sJZcd0ZJVfsRIT5JxLECx3/jsdr2Q
	 fh8hiFtxbaCGZA6PVTr1ZhSWxVIz2ynfWQzuq4Kj6oXTKCoKQdPuzR0bQv15hpSZUx
	 Foutp96jZKJrEUxMdJEHvlkdDLJSwIN8IKmveieeuBI7D/Dt397Rn9yQy9C+4hyylN
	 olCn8TQLAlReA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 07/60] mm: migrate: convert numamigrate_isolate_page() to numamigrate_isolate_folio()
Date: Wed, 13 Mar 2024 12:36:14 -0400
Message-ID: <20240313163707.615000-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 2ac9e99f3b21b2864305fbfba4bae5913274c409 ]

Rename numamigrate_isolate_page() to numamigrate_isolate_folio(), then
make it takes a folio and use folio API to save compound_head() calls.

Link: https://lkml.kernel.org/r/20230913095131.2426871-4-wangkefeng.wang@huawei.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 2774f256e7c0 ("mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c9fabb960996f..e5f2f7243a659 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2501,10 +2501,9 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 	return __folio_alloc_node(gfp, order, nid);
 }
 
-static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
+static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
 {
-	int nr_pages = thp_nr_pages(page);
-	int order = compound_order(page);
+	int nr_pages = folio_nr_pages(folio);
 
 	/* Avoid migrating to a node that is nearly full */
 	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
@@ -2516,22 +2515,23 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 			if (managed_zone(pgdat->node_zones + z))
 				break;
 		}
-		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
+		wakeup_kswapd(pgdat->node_zones + z, 0,
+			      folio_order(folio), ZONE_MOVABLE);
 		return 0;
 	}
 
-	if (!isolate_lru_page(page))
+	if (!folio_isolate_lru(folio))
 		return 0;
 
-	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_is_file_lru(page),
+	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
 			    nr_pages);
 
 	/*
-	 * Isolating the page has taken another reference, so the
-	 * caller's reference can be safely dropped without the page
+	 * Isolating the folio has taken another reference, so the
+	 * caller's reference can be safely dropped without the folio
 	 * disappearing underneath us during migration.
 	 */
-	put_page(page);
+	folio_put(folio);
 	return 1;
 }
 
@@ -2565,7 +2565,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	if (page_is_file_lru(page) && PageDirty(page))
 		goto out;
 
-	isolated = numamigrate_isolate_page(pgdat, page);
+	isolated = numamigrate_isolate_folio(pgdat, page_folio(page));
 	if (!isolated)
 		goto out;
 
-- 
2.43.0


