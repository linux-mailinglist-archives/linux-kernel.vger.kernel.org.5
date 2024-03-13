Return-Path: <linux-kernel+bounces-101808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281B687ABC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D760F286BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D225B5D9;
	Wed, 13 Mar 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZem/hgZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247114D583;
	Wed, 13 Mar 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347838; cv=none; b=CZp/omjfBjy+/8Ybs4aLzYMlSHd2Cuxg+2/sZ9KEodGzsHFWWhzKOyJrgoSoRC3YO0qhftmMT2rJ4ITFDCl8cRIT1AoWUgAbljTQQmOI2sYCNm6hhNI0eNOHD2xyUk9vpYjBw+IEqUICP7SFeOROcIaOt/CC7dvWYtxy6PGm6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347838; c=relaxed/simple;
	bh=i6QID6+SkDYvTWTlSTyWSw1sfimeDrT5dJe8XN/TIQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B84gpg5WTIDMshasRXXwTCLjEgzCUjCSobxFv04IopVbCZnctvk+4cOGrwPVqSePvG4XLpWuwfajJxLsn+ah3eOai/mkurZSyf1/c6/t5jLqCbAfm2xCQ1WxaQxkg+BJAFSqWdtQY8rPSObADdHSvovK1BiKQqIqOA75AsrtL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZem/hgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EA2C433C7;
	Wed, 13 Mar 2024 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347837;
	bh=i6QID6+SkDYvTWTlSTyWSw1sfimeDrT5dJe8XN/TIQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZem/hgZJ2E+vi/ahi/+kaNaZ8FdwbGvVYA1OSRAniw1mH9FUldUMAyk76wTgb5f9
	 3oXL6bOQDpNeTYmA7KEygJdxI+LDjDwP+LSiXuIQploavq6AH0XHgcSOGEB+elSdko
	 X8cZUdBLaU+cLTbphUPEMGotAeOPQrKMqOuHiqaRJU61gZO8eAjL2JSnvxosYq1ZMJ
	 n1u3Gdob9avuAFUqRzPEac0xOVzGL88CeBX2UYgVEiA+e/7NwEp5NDMnt9VtU1sXsl
	 dgeoW7A3jxouKAaxk6acLVJpB06yODPC+d7xNuJhs4mkGCmhg8uVCPUh9nFuVZzNaG
	 hXB4CrkHpc3hQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 06/60] mm: migrate: remove THP mapcount check in numamigrate_isolate_page()
Date: Wed, 13 Mar 2024 12:36:13 -0400
Message-ID: <20240313163707.615000-7-sashal@kernel.org>
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

[ Upstream commit 728be28fae8c838d52c91dce4867133798146357 ]

The check of THP mapped by multiple processes was introduced by commit
04fa5d6a6547 ("mm: migrate: check page_count of THP before migrating") and
refactor by commit 340ef3902cf2 ("mm: numa: cleanup flow of transhuge page
migration"), which is out of date, since migrate_misplaced_page() is now
using the standard migrate_pages() for small pages and THPs, the reference
count checking is in folio_migrate_mapping(), so let's remove the special
check for THP.

Link: https://lkml.kernel.org/r/20230913095131.2426871-3-wangkefeng.wang@huawei.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 2774f256e7c0 ("mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6f8ad6b64c9bc..c9fabb960996f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2506,10 +2506,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	int nr_pages = thp_nr_pages(page);
 	int order = compound_order(page);
 
-	/* Do not migrate THP mapped by multiple processes */
-	if (PageTransHuge(page) && total_mapcount(page) > 1)
-		return 0;
-
 	/* Avoid migrating to a node that is nearly full */
 	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
 		int z;
-- 
2.43.0


