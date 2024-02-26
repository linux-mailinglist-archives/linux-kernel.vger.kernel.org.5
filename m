Return-Path: <linux-kernel+bounces-81585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE15E8677D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D61A1F2BEA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02A312E1CC;
	Mon, 26 Feb 2024 14:06:26 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F18212C803;
	Mon, 26 Feb 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956386; cv=none; b=PGtoDyje7bJxWlnmQlrXyoFpHeXvxkn5fHe6ciVt31p/Q68KwGPG98JLCThsB92aL/7m7d+1ncacK69ym/QNE2ti0UTKkLsF/pzvMH+cBKJ9Gn5cuNZHA4VriqobW53xCv6oI3cEckfhmfxRu9qvrLUd0it1c/K2v2oSO8U/mm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956386; c=relaxed/simple;
	bh=DNlk804N1hnzt8DH0e5+lqyDTtt76Du4GvfOQwH+aBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiIeriUb9c2bUKBx73yqSetns4Ej8/clr264cqKaWhxsnfXdBBzpScHNOnhrCxJMbBJgc3jr3v7ysOq0Gki1Lh3BLLrr5AJ38ccjxRfgyYEF3i6gFn8MWRRIxIrZHrAYsrdyikuao+/SX+IcUa0jr8VS9IpwOPIzfzIZarWs/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-83-65dc9adb88dd
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com
Subject: [PATCH v2 5/7] mm/damon: introduce DAMOS_PROMOTE action for promotion
Date: Mon, 26 Feb 2024 23:05:51 +0900
Message-ID: <20240226140555.1615-6-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240226140555.1615-1-honggyu.kim@sk.com>
References: <20240226140555.1615-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsXC9ZZnoe7tWXdSDbYckLeY2GNgMWf9GjaL
	XTdCLP7vPcZo8eT/b1aLEzcb2Sw6vy9lsbi8aw6bxb01/1ktjqw/y2Kx7haQtfnsGWaLxcvV
	LPZ1PGCyOPz1DZPF5EsL2CxeTDnDaHFy1mQWi9lH77E7CHv8PziJ2WPp6TdsHhuagMTOWXfZ
	PVr23WL3WLCp1KPlyFtWj8V7XjJ5bFrVyeax6dMkdo8TM36zeOx8aOnxYvNMRo/e5ndsHp83
	yQXwR3HZpKTmZJalFunbJXBlTDz7hq1goUXFnL5tjA2Mv3S7GDk4JARMJL4uK+5i5AQzp545
	yQxiswmoSVx5OYkJpEREwEFi1VeFLkYuDmaBBhaJH58vsYDEhQX8JDa/LAMxWQRUJW4tEQDp
	5BUwk3h5aR4rxERNicfbf7KD2JwC5hL/D7ezgZQLAdUcvc0MUS4ocXLmExYQm1lAXqJ562xm
	kE0SAqfYJXYu2skEMUdS4uCKGywTGPlnIemZhaRnASPTKkahzLyy3MTMHBO9jMq8zAq95Pzc
	TYzAyFtW+yd6B+OnC8GHGAU4GJV4eB1q76QKsSaWFVfmHmKU4GBWEuENl7mZKsSbklhZlVqU
	H19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoExc5uYpGYdU+jLbvYbJc+c
	C/IN5vrMsZj+vszyRE2yOqvE4RuVi+afWLlBj+PY/aMJf68HfEtMi2UrnTJXfb9HyYybhU27
	7QU1a/49rzsus76lnKnRUOTc1QvPN8yKdFG/qOXZelPnfnVxsv7t9TvvPMuTPH1iy2Mu/2vX
	lxxvjHe9cuvBhjc2SizFGYmGWsxFxYkA+pGG7LgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsXCNUNLT/f2rDupBu9n8FlM7DGwmLN+DZvF
	rhshFv/3HmO0ePL/N6vFiZuNbBafn71mtuh88p3R4vDck6wWnd+Xslhc3jWHzeLemv+sFkfW
	n2WxWHcLyNp89gyzxeLlahaHrj1ntdjX8YDJ4vDXN0wWky8tYLN4MeUMo8XJWZNZLGYfvcfu
	IO7x/+AkZo+lp9+weWxoAhI7Z91l92jZd4vdY8GmUo+WI29ZPRbvecnksWlVJ5vHpk+T2D1O
	zPjN4rHzoaXHi80zGT16m9+xeXy77eGx+MUHpgDBKC6blNSczLLUIn27BK6MiWffsBUstKiY
	07eNsYHxl24XIyeHhICJxNQzJ5lBbDYBNYkrLycxdTFycIgIOEis+qrQxcjFwSzQwCLx4/Ml
	FpC4sICfxOaXZSAmi4CqxK0lAiCdvAJmEi8vzWOFmKgp8Xj7T3YQm1PAXOL/4XY2kHIhoJqj
	t5khygUlTs58wgJiMwvISzRvnc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS
	83M3MQLjbFntn4k7GL9cdj/EKMDBqMTD61B7J1WINbGsuDL3EKMEB7OSCG+4zM1UId6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsaZS5iZNt2Tdbt0unvm
	iovFUdcX3Wq791p78tTIUrU5c/hXW3OkcVzoSwmaaeu8+/eSDEVN0VZDyT3cux47NJxh37gi
	KrjL31clSkhh00MFPZb1r0QDVCdOMU741V437+TRA0+1+982M1+fkPPlt3nRZPu23BldO/rM
	ntjqx0yaLdCxjD/R9ZESS3FGoqEWc1FxIgBxEqWRrwIAAA==
X-CFilter-Loop: Reflected

From: Hyeongtak Ji <hyeongtak.ji@sk.com>

This patch introduces DAMOS_PROMOTE action for paddr mode.

It includes renaming alloc_demote_folio to alloc_migrate_folio to use it
for promotion as well.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 include/linux/damon.h          |  2 ++
 include/linux/migrate_mode.h   |  1 +
 include/linux/vm_event_item.h  |  1 +
 include/trace/events/migrate.h |  3 ++-
 mm/damon/paddr.c               | 45 ++++++++++++++++++++++++++++------
 mm/damon/sysfs-schemes.c       |  1 +
 mm/vmstat.c                    |  1 +
 7 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 86e66772766b..d7e52d0228b4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -105,6 +105,7 @@ struct damon_target {
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
+ * @DAMOS_PROMOTE:      Do promotion for the given region.
  * @DAMOS_DEMOTE:       Do demotion for the given region.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
@@ -123,6 +124,7 @@ enum damos_action {
 	DAMOS_NOHUGEPAGE,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
+	DAMOS_PROMOTE,
 	DAMOS_DEMOTE,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index f37cc03f9369..63f75eb9abf3 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -29,6 +29,7 @@ enum migrate_reason {
 	MR_CONTIG_RANGE,
 	MR_LONGTERM_PIN,
 	MR_DEMOTION,
+	MR_PROMOTION,
 	MR_TYPES
 };
 
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 8abfa1240040..63cf920afeaa 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -44,6 +44,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGDEMOTE_KSWAPD,
 		PGDEMOTE_DIRECT,
 		PGDEMOTE_KHUGEPAGED,
+		PGPROMOTE,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
 		PGSCAN_KHUGEPAGED,
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 0190ef725b43..f0dd569c1e62 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -22,7 +22,8 @@
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
 	EM( MR_CONTIG_RANGE,	"contig_range")			\
 	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
-	EMe(MR_DEMOTION,	"demotion")
+	EM( MR_DEMOTION,	"demotion")			\
+	EMe(MR_PROMOTION,	"promotion")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 23e37ce57202..37a7b34a36dd 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -229,6 +229,7 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 
 enum migration_mode {
 	MIG_PAGEOUT,
+	MIG_PROMOTE,
 	MIG_DEMOTE,
 };
 
@@ -241,9 +242,26 @@ static unsigned int migrate_folio_list(struct list_head *migrate_folios,
 				       struct pglist_data *pgdat,
 				       enum migration_mode mm)
 {
-	int target_nid = next_demotion_node(pgdat->node_id);
+	int target_nid;
 	unsigned int nr_succeeded;
 	nodemask_t allowed_mask;
+	int reason;
+	enum vm_event_item vm_event;
+
+	switch (mm) {
+	case MIG_PROMOTE:
+		target_nid = next_promotion_node(pgdat->node_id);
+		reason = MR_PROMOTION;
+		vm_event = PGPROMOTE;
+		break;
+	case MIG_DEMOTE:
+		target_nid = next_demotion_node(pgdat->node_id);
+		reason = MR_DEMOTION;
+		vm_event = PGDEMOTE_DIRECT;
+		break;
+	default:
+		return 0;
+	}
 
 	struct migration_target_control mtc = {
 		/*
@@ -263,14 +281,19 @@ static unsigned int migrate_folio_list(struct list_head *migrate_folios,
 	if (list_empty(migrate_folios))
 		return 0;
 
-	node_get_allowed_targets(pgdat, &allowed_mask);
+	if (mm == MIG_DEMOTE) {
+		node_get_allowed_targets(pgdat, &allowed_mask);
+	} else if (mm == MIG_PROMOTE) {
+		/* TODO: Need to add upper_tier_mask at struct memory_tier. */
+		allowed_mask = NODE_MASK_NONE;
+	}
 
 	/* Migration ignores all cpuset and mempolicy settings */
 	migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
-		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
+		      (unsigned long)&mtc, MIGRATE_ASYNC, reason,
 		      &nr_succeeded);
 
-	__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
+	__count_vm_events(vm_event, nr_succeeded);
 
 	return nr_succeeded;
 }
@@ -359,7 +382,8 @@ static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
 		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
 
 		references = folio_check_references(folio);
-		if (references == FOLIOREF_KEEP)
+		if (references == FOLIOREF_KEEP ||
+		    (references == FOLIOREF_RECLAIM && mm == MIG_PROMOTE))
 			goto keep_locked;
 
 		/* Relocate its contents to another node. */
@@ -452,8 +476,10 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
 
-		folio_clear_referenced(folio);
-		folio_test_clear_young(folio);
+		if (mm != MIG_PROMOTE) {
+			folio_clear_referenced(folio);
+			folio_test_clear_young(folio);
+		}
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
 		/*
@@ -471,6 +497,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	case MIG_PAGEOUT:
 		applied = reclaim_pages(&folio_list);
 		break;
+	case MIG_PROMOTE:
 	case MIG_DEMOTE:
 		applied = damon_pa_migrate_pages(&folio_list, mm);
 		break;
@@ -530,6 +557,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r, scheme);
+	case DAMOS_PROMOTE:
+		return damon_pa_migrate(r, scheme, MIG_PROMOTE);
 	case DAMOS_DEMOTE:
 		return damon_pa_migrate(r, scheme, MIG_DEMOTE);
 	case DAMOS_STAT:
@@ -552,6 +581,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 		return damon_hot_score(context, r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_cold_score(context, r, scheme);
+	case DAMOS_PROMOTE:
+		return damon_hot_score(context, r, scheme);
 	case DAMOS_DEMOTE:
 		return damon_cold_score(context, r, scheme);
 	default:
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 53e47fad5021..9bc48932eb6c 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1186,6 +1186,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"nohugepage",
 	"lru_prio",
 	"lru_deprio",
+	"promote",
 	"demote",
 	"stat",
 };
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 359460deb377..c703abdb8137 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1282,6 +1282,7 @@ const char * const vmstat_text[] = {
 	"pgdemote_kswapd",
 	"pgdemote_direct",
 	"pgdemote_khugepaged",
+	"pgpromote",
 	"pgscan_kswapd",
 	"pgscan_direct",
 	"pgscan_khugepaged",
-- 
2.34.1


