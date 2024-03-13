Return-Path: <linux-kernel+bounces-101807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA4387ABC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7223028684E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEA35A784;
	Wed, 13 Mar 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su6ItRDQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8D5A10F;
	Wed, 13 Mar 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347836; cv=none; b=YJtJiWEFuhDD2Ej+ICjFbFLdI/OPCzy+JALN5nIFVKk1LjEl2wUKZIyaMscsLOx+piSDcRA1cunsPwfMLM5DF+L4pdtM0nEdSqeF3aHXFuo4uizr+NfBtJW5ONqzJr4Ps0KEz/tmQEZepBdVORbbrUnJSxQJmJ4uKFKkezHwigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347836; c=relaxed/simple;
	bh=tbqqHx9mHufdhmm/r3A2G4daIIglJuRWcySHPED7Rx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2Ad34fzJTktDtzDdcmXldWIYOZILXDPZyWo/xbNBD9n9mYlPJ0MsKNl27JMgjRKYXyuN82D+lXzmnoRPyP1xTVlAp1+fAaJ6ZbViQ52FKYiNa8TBblBFjjORcCJ/WzFGWW3uaN5fV6YDMQ/RBmYb0moPq+462Qk3DMRfcJrj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su6ItRDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC20EC4AF6D;
	Wed, 13 Mar 2024 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347836;
	bh=tbqqHx9mHufdhmm/r3A2G4daIIglJuRWcySHPED7Rx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=su6ItRDQc5ueb3TVn9q4WWpInKPeVMnbHMTd+6xxtfH+RkO2XtJ0GyLn8KKHrnlBs
	 DMZF/O3pJSA0c0qrsQE9kcfZ/2vn2FBqeRRtUoFV1t+BA6EVuJYDx0vM6lmdKHV3qZ
	 DGCB5K6gkZ4UhQr5Jgxjn+aF1nM7gK8YYSNlOGekEhp96mbhspLDBY2S06QiMRb5bu
	 2WOL4QjcLtPgg/wacbIaT++r3cfcbdqknfftttn8AGnJq4GTyu9U7yEUjYGalQjy84
	 o8eK2lLocHrRrKfWJPF3ZwCeRiaCdXogEcQd1H7NZh0X6NRGsvvDy/nARMxmf7sMSv
	 491+Zg2Ezi3Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Huang Ying <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 05/60] mm: migrate: remove PageTransHuge check in numamigrate_isolate_page()
Date: Wed, 13 Mar 2024 12:36:12 -0400
Message-ID: <20240313163707.615000-6-sashal@kernel.org>
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

[ Upstream commit a8ac4a767dcd9d87d8229045904d9fe15ea5e0e8 ]

Patch series "mm: migrate: more folio conversion and unification", v3.

Convert more migrate functions to use a folio, it is also a preparation
for large folio migration support when balancing numa.

This patch (of 8):

The assert VM_BUG_ON_PAGE(order && !PageTransHuge(page), page) is not very
useful,

   1) for a tail/base page, order = 0, for a head page, the order > 0 &&
      PageTransHuge() is true
   2) there is a PageCompound() check and only base page is handled in
      do_numa_page(), and do_huge_pmd_numa_page() only handle PMD-mapped
      THP
   3) even though the page is a tail page, isolate_lru_page() will post
      a warning, and fail to isolate the page
   4) if large folio/pte-mapped THP migration supported in the future,
      we could migrate the entire folio if numa fault on a tail page

so just remove the check.

Link: https://lkml.kernel.org/r/20230913095131.2426871-1-wangkefeng.wang@huawei.com
Link: https://lkml.kernel.org/r/20230913095131.2426871-2-wangkefeng.wang@huawei.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 2774f256e7c0 ("mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b4d972d80b10c..6f8ad6b64c9bc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2506,8 +2506,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	int nr_pages = thp_nr_pages(page);
 	int order = compound_order(page);
 
-	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
-
 	/* Do not migrate THP mapped by multiple processes */
 	if (PageTransHuge(page) && total_mapcount(page) > 1)
 		return 0;
-- 
2.43.0


