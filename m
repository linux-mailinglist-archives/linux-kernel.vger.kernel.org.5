Return-Path: <linux-kernel+bounces-25624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3316482D3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA361F214F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F24B6FA4;
	Mon, 15 Jan 2024 04:53:10 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B3323CC;
	Mon, 15 Jan 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-5f-65a4ba2e01d2
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	linmiaohe@huawei.com,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [RFC PATCH 2/4] mm/damon: introduce DAMOS_DEMOTE action for demotion
Date: Mon, 15 Jan 2024 13:52:50 +0900
Message-ID: <20240115045253.1775-3-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240115045253.1775-1-honggyu.kim@sk.com>
References: <20240115045253.1775-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsXC9ZZnoa7eriWpBu3/TC3mrF/DZrHrRojF
	/73HGC2e/P/NanHiZiObRef3pSwWl3fNYbO4t+Y/q8WR9WdZLNbdArI2nz3DbLF4uZrFvo4H
	TBaHv75hsph8aQGbxYspZxgtTs6azGIx++g9dgchj/8HJzF7LD39hs1jQxOQaNl3i91jwaZS
	j5Yjb1k9Fu95yeSxaVUnm8emT5PYPU7M+M3isfOhpceLzTMZPXqb37F5fN4kF8AXxWWTkpqT
	WZZapG+XwJXxZ9lB5oIFdhVbVr9hamBsMO5i5OSQEDCR6Py4iK2LkQPMbp6RChJmE1CTuPJy
	EhNIWETAQWLVV4UuRi4OZoEzzBLNvZdZQGqEBXwlJm1ZAWazCKhKnD7wmR3E5hUwk1jYco0N
	YrymxOPtP8HinALmEq/b3zCD2EJANY1rv0HVC0qcnPkEbA6zgLxE89bZzCDLJAQ2sUu0f//B
	DDFIUuLgihssExj5ZyHpmYWkZwEj0ypGocy8stzEzBwTvYzKvMwKveT83E2MwGhbVvsnegfj
	pwvBhxgFOBiVeHh//F2cKsSaWFZcmXuIUYKDWUmE9+DzBalCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGAPNeW/+9StzX5VhuWrp8zO7+HanabQkBfoe
	+7nEoF1qxi7lP55Vh8TWcsWG9QrGqyXaRl/k29IY2Vy9JSprRQJbk/LTTUIWFtnMO50/xyv/
	T84zO1Fu4fO66jm3nxbPCfvTl5ZvuM/1JyBlv8ikZ97v/a8beH5f07bvbtvFym3JvflHDt3W
	U2Ipzkg01GIuKk4EAG2hjDqyAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LhmqGlp6u3a0mqwed76hZz1q9hs9h1I8Ti
	/95jjBZP/v9mtThxs5HN4vOz18wWh+eeZLXo/L6UxeLyrjlsFvfW/Ge1OLL+LIvFultA1uaz
	Z5gtFi9Xs9jX8YDJ4vDXN0wWky8tYLN4MeUMo8XJWZNZLGYfvcfuIOLx/+AkZo+lp9+weWxo
	AhIt+26xeyzYVOrRcuQtq8fiPS+ZPDat6mTz2PRpErvHiRm/WTx2PrT0eLF5JqNHb/M7No9v
	tz08Fr/4wOTxeZNcgEAUl01Kak5mWWqRvl0CV8afZQeZCxbYVWxZ/YapgbHBuIuRg0NCwESi
	eUZqFyMnB5uAmsSVl5OYQMIiAg4Sq74qdDFycTALnGGWaO69zAJSIyzgKzFpywowm0VAVeL0
	gc/sIDavgJnEwpZrbCC2hICmxOPtP8HinALmEq/b3zCD2EJANY1rv0HVC0qcnPkEbA6zgLxE
	89bZzBMYeWYhSc1CklrAyLSKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMJqW1f6ZuIPxy2X3
	Q4wCHIxKPLw//i5OFWJNLCuuzD3EKMHBrCTCe/D5glQh3pTEyqrUovz4otKc1OJDjNIcLEri
	vF7hqQlCAumJJanZqakFqUUwWSYOTqkGRqbaO1OuvHgSdnYul/4aucDwdGFt23Ov6vpzOu9F
	Bu+7kptwcMqpokCmw9/3LGPdt8xE5rD3pukGvtKG7drnbss2T/jQqPU/7lZPr+MOP9kjYbbO
	xw8yf9QoeNCb+GXTlrTrIgEB1aq7DxlkmEQn+J/7n6aaqHQ0sr7rw6VpH6vN50+7xm60Roml
	OCPRUIu5qDgRAHgQXk+iAgAA
X-CFilter-Loop: Reflected

This patch introduces DAMOS_DEMOTE action, which is similar to
DAMOS_PAGEOUT, but demote folios instead of swapping them out.

Since there are some common routines with pageout, many functions have
similar logics between pageout and demote.

The execution sequence of DAMOS_PAGEOUT and DAMOS_DEMOTE look as follows.

  DAMOS_PAGEOUT action
    damo_pa_apply_scheme
    -> damon_pa_reclaim
    -> reclaim_pages
    -> reclaim_folio_list
    -> shrink_folio_list

  DAMOS_DEMOTE action
    damo_pa_apply_scheme
    -> damon_pa_reclaim
    -> demote_pages
    -> do_demote_folio_list
    -> __demote_folio_list
    -> demote_folio_list

__demote_folio_list() is a minimized version of shrink_folio_list(), but
it's minified only for demotion.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 include/linux/damon.h    |  2 +
 mm/damon/paddr.c         | 17 +++++---
 mm/damon/sysfs-schemes.c |  1 +
 mm/internal.h            |  1 +
 mm/vmscan.c              | 84 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e00ddf1ed39c..4c0a0fef09c5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -106,6 +106,7 @@ struct damon_target {
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
  * @DAMOS_STAT:		Do nothing but count the stat.
+ * @DAMOS_DEMOTE:	Do demotion for the current region.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  *
  * The support of each action is up to running &struct damon_operations.
@@ -123,6 +124,7 @@ enum damos_action {
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
+	DAMOS_DEMOTE,
 	NR_DAMOS_ACTIONS,
 };
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 081e2a325778..d3e3f077cd00 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -224,7 +224,7 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	return false;
 }
 
-static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
+static unsigned long damon_pa_reclaim(struct damon_region *r, struct damos *s, bool is_demote)
 {
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
@@ -242,14 +242,17 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 		folio_test_clear_young(folio);
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
-		if (folio_test_unevictable(folio))
+		if (folio_test_unevictable(folio) && !is_demote)
 			folio_putback_lru(folio);
 		else
 			list_add(&folio->lru, &folio_list);
 put_folio:
 		folio_put(folio);
 	}
-	applied = reclaim_pages(&folio_list);
+	if (is_demote)
+		applied = demote_pages(&folio_list);
+	else
+		applied = reclaim_pages(&folio_list);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
@@ -297,13 +300,15 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pa_pageout(r, scheme);
+		return damon_pa_reclaim(r, scheme, false);
 	case DAMOS_LRU_PRIO:
 		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r, scheme);
 	case DAMOS_STAT:
 		break;
+	case DAMOS_DEMOTE:
+		return damon_pa_reclaim(r, scheme, true);
 	default:
 		/* DAMOS actions that not yet supported by 'paddr'. */
 		break;
@@ -317,11 +322,11 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
+	case DAMOS_LRU_DEPRIO:
+	case DAMOS_DEMOTE:
 		return damon_cold_score(context, r, scheme);
 	case DAMOS_LRU_PRIO:
 		return damon_hot_score(context, r, scheme);
-	case DAMOS_LRU_DEPRIO:
-		return damon_cold_score(context, r, scheme);
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index fe0fe2562000..ac7cd3f17b12 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1187,6 +1187,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"lru_prio",
 	"lru_deprio",
 	"stat",
+	"demote",
 };
 
 static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..2380397ec2f3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -869,6 +869,7 @@ extern void set_pageblock_order(void);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
+unsigned long demote_pages(struct list_head *folio_list);
 /* The ALLOC_WMARK bits are used as an index to zone->watermark */
 #define ALLOC_WMARK_MIN		WMARK_MIN
 #define ALLOC_WMARK_LOW		WMARK_LOW
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7ca2396ccc3b..eaa3dd6b7562 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -998,6 +998,66 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
 	return !data_race(folio_swap_flags(folio) & SWP_FS_OPS);
 }
 
+/*
+ * __demote_folio_list() returns the number of demoted pages
+ */
+static unsigned int __demote_folio_list(struct list_head *folio_list,
+		struct pglist_data *pgdat, struct scan_control *sc)
+{
+	LIST_HEAD(ret_folios);
+	LIST_HEAD(demote_folios);
+	unsigned int nr_demoted = 0;
+
+	if (next_demotion_node(pgdat->node_id) == NUMA_NO_NODE)
+		return 0;
+
+	cond_resched();
+
+	while (!list_empty(folio_list)) {
+		struct folio *folio;
+		enum folio_references references;
+
+		cond_resched();
+
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+
+		if (!folio_trylock(folio))
+			goto keep;
+
+		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
+
+		references = folio_check_references(folio, sc);
+		if (references == FOLIOREF_KEEP)
+			goto keep_locked;
+
+		/* Relocate its contents to another node. */
+		list_add(&folio->lru, &demote_folios);
+		folio_unlock(folio);
+		continue;
+keep_locked:
+		folio_unlock(folio);
+keep:
+		list_add(&folio->lru, &ret_folios);
+		VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
+	}
+	/* 'folio_list' is always empty here */
+
+	/* Migrate folios selected for demotion */
+	nr_demoted += demote_folio_list(&demote_folios, pgdat);
+	/* Folios that could not be demoted are still in @demote_folios */
+	if (!list_empty(&demote_folios)) {
+		/* Folios which weren't demoted go back on @folio_list */
+		list_splice_init(&demote_folios, folio_list);
+	}
+
+	try_to_unmap_flush();
+
+	list_splice(&ret_folios, folio_list);
+
+	return nr_demoted;
+}
+
 /*
  * shrink_folio_list() returns the number of reclaimed pages
  */
@@ -2107,6 +2167,25 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	return nr_reclaimed;
 }
 
+static unsigned int do_demote_folio_list(struct list_head *folio_list,
+				      struct pglist_data *pgdat)
+{
+	unsigned int nr_demoted;
+	struct folio *folio;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+	};
+
+	nr_demoted = __demote_folio_list(folio_list, pgdat, &sc);
+	while (!list_empty(folio_list)) {
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+		folio_putback_lru(folio);
+	}
+
+	return nr_demoted;
+}
+
 static unsigned long reclaim_or_migrate_folios(struct list_head *folio_list,
 		unsigned int (*handler)(struct list_head *, struct pglist_data *))
 {
@@ -2146,6 +2225,11 @@ unsigned long reclaim_pages(struct list_head *folio_list)
 	return reclaim_or_migrate_folios(folio_list, reclaim_folio_list);
 }
 
+unsigned long demote_pages(struct list_head *folio_list)
+{
+	return reclaim_or_migrate_folios(folio_list, do_demote_folio_list);
+}
+
 static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
 				 struct lruvec *lruvec, struct scan_control *sc)
 {
-- 
2.34.1


