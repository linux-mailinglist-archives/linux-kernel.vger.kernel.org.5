Return-Path: <linux-kernel+bounces-74403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4B85D38A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891DCB24801
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569863F8CC;
	Wed, 21 Feb 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h1985OuN"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87E3DB89
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507695; cv=none; b=eWwNFPPWijaZ/GG8XZsw/FRJ34UGS7cAvIljB4XP6ZOUwI0wBRJyJSm84rLpPVsPnGgqWbNFDujtkdgkZB841vqTIhLOm++qAJ7JQiaiPGHdNnd2pnLT0o4DytrrueuVc7n36sukmzgRbfqWQ+LReFcPS3PE1jd9gsnNaO+NLW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507695; c=relaxed/simple;
	bh=3uKwHohhB3aic92O+ME8L8BAtG4fdHDuAqPlhAFi+CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+1tuzxVCWjOavqWkRmibeOzd2ubAMGn1Ot68mU7ACvbgLY2gqGXt9H9V6F3GVY/dAmg70VGcW/gGn8Qa+PGnoUFdkcNyQAEqLd5kYHN4eT5ksJhIZx0GMfsdvs+7OrXwHVnPfVgXtm9PDEd0AsnY5XY5vbM0G+9CeTTzwvJoUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h1985OuN; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708507685; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dbpOfTRpA7RL14rl+8ySQliZQuoH0mAg7qi1p2q34yY=;
	b=h1985OuNmMzPVT2MEjzNvkwjO8iGeZGj5HIyJ840Ku6pHvlVK89oIPp2MBbUJXnbvOiXozhRYD2uEk1PeZ4lZzagswPlsD8T4V9zS2yTS+RtyoBZ8ijq+C46pbk4hgD3IFkj6GkA3qU91OTwHXh8s1tqSVQWZyPOVbwvIWk/Zb0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W0zPloF_1708507683;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0zPloF_1708507683)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:28:04 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	linmiaohe@huawei.com,
	naoya.horiguchi@nec.com,
	mhocko@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] mm: record the migration reason for struct migration_target_control
Date: Wed, 21 Feb 2024 17:27:53 +0800
Message-Id: <04e445d16ab9f8d5a4cd4082c0c9b5f5e0bbf54c.1708507022.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
References: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support different hugetlb allocation strategies during hugetlb migration
based on various migration reasons, recording the migration reason for the
migration_target_control structure as a preparation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/gup.c            | 1 +
 mm/internal.h       | 1 +
 mm/memory-failure.c | 1 +
 mm/memory_hotplug.c | 1 +
 mm/mempolicy.c      | 1 +
 mm/migrate.c        | 1 +
 mm/page_alloc.c     | 1 +
 mm/vmscan.c         | 3 ++-
 8 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index df83182ec72d..959a1a05b059 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2132,6 +2132,7 @@ static int migrate_longterm_unpinnable_pages(
 		struct migration_target_control mtc = {
 			.nid = NUMA_NO_NODE,
 			.gfp_mask = GFP_USER | __GFP_NOWARN,
+			.reason = MR_LONGTERM_PIN,
 		};
 
 		if (migrate_pages(movable_page_list, alloc_migration_target,
diff --git a/mm/internal.h b/mm/internal.h
index 93e229112045..7677ee4d8e12 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -958,6 +958,7 @@ struct migration_target_control {
 	int nid;		/* preferred node id */
 	nodemask_t *nmask;
 	gfp_t gfp_mask;
+	enum migrate_reason reason;
 };
 
 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9349948f1abf..780bb2aee0af 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2666,6 +2666,7 @@ static int soft_offline_in_use_page(struct page *page)
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+		.reason = MR_MEMORY_FAILURE,
 	};
 
 	if (!huge && folio_test_large(folio)) {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a444e2d7dd2b..b79ba36e09e0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1841,6 +1841,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		struct migration_target_control mtc = {
 			.nmask = &nmask,
 			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+			.reason = MR_MEMORY_HOTPLUG,
 		};
 		int ret;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f60b4c99f130..98ceb12e0e17 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1070,6 +1070,7 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
 	struct migration_target_control mtc = {
 		.nid = dest,
 		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
+		.reason = MR_SYSCALL,
 	};
 
 	nodes_clear(nmask);
diff --git a/mm/migrate.c b/mm/migrate.c
index 73a052a382f1..bde63010a3cf 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2060,6 +2060,7 @@ static int do_move_pages_to_node(struct list_head *pagelist, int node)
 	struct migration_target_control mtc = {
 		.nid = node,
 		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
+		.reason = MR_SYSCALL,
 	};
 
 	err = migrate_pages(pagelist, alloc_migration_target, NULL,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b0b92ce997dc..81ba73d77921 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6264,6 +6264,7 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
 	struct migration_target_control mtc = {
 		.nid = zone_to_nid(cc->zone),
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+		.reason = MR_CONTIG_RANGE,
 	};
 
 	lru_cache_disable();
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 87df3a48bdd7..d111c8e3b40e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -978,7 +978,8 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
 			__GFP_NOMEMALLOC | GFP_NOWAIT,
 		.nid = target_nid,
-		.nmask = &allowed_mask
+		.nmask = &allowed_mask,
+		.reason = MR_DEMOTION,
 	};
 
 	if (list_empty(demote_folios))
-- 
2.39.3


