Return-Path: <linux-kernel+bounces-25625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9549482D3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29ECD28171B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50FA79D9;
	Mon, 15 Jan 2024 04:53:12 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118663AC;
	Mon, 15 Jan 2024 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-74-65a4ba317e96
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
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [RFC PATCH 4/4] mm/damon: introduce DAMOS_PROMOTE action for promotion
Date: Mon, 15 Jan 2024 13:52:52 +0900
Message-ID: <20240115045253.1775-5-honggyu.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsXC9ZZnoa7hriWpBh8filrMWb+GzWLXjRCL
	/3uPMVo8+f+b1eLEzUY2i87vS1ksLu+aw2Zxb81/Vosj68+yWKy7BWRtPnuG2WLxcjWLfR0P
	mCwOf33DZDH50gI2ixdTzjBanJw1mcVi9tF77A5CHv8PTmL2WHr6DZvHhiYg0bLvFrvHgk2l
	Hi1H3rJ6LN7zkslj06pONo9Nnyaxe5yY8ZvFY+dDS48Xm2cyevQ2v2Pz+LxJLoAvissmJTUn
	syy1SN8ugStjyrsWpoI9kRVff19hbmD859HFyMkhIWAi0bhjDyuc/amdDcRmE1CTuPJyElMX
	IweHiICDxKqvCl2MXBzMAp+YJW4fnskMUiMs4C+x/OJ1dhCbRUBV4sua5Wwg9bwCZhI3HjFD
	jNSUeLz9J1gJp4C5xOv2N2BxIaCSxrXfwOK8AoISJ2c+YQGxmQXkJZq3zmYG2SUhsI9d4tW8
	NUwQgyQlDq64wTKBkX8Wkp5ZSHoWMDKtYhTKzCvLTczMMdHLqMzLrNBLzs/dxAiMtmW1f6J3
	MH66EHyIUYCDUYmH98ffxalCrIllxZW5hxglOJiVRHgPPl+QKsSbklhZlVqUH19UmpNafIhR
	moNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoGx16WGmUH5dkzwk+eNjTUlS+ultB09X6nL
	CW4t3PC2bmHZ8XPZ3z8tiF8x1dJn2vLYpiMTrJPWF9cYzn2quv62/exncpNzFq74F1awKnul
	V3Og1yuZ4uXGScfuJV/+8VB9ls/X94l35MsP628P77f9Vz7j49vfhp970ycWOzh26p883Fys
	vVZZiaU4I9FQi7moOBEAEJRAWbICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsXCNUNLT9dg15JUg02NthZz1q9hs9h1I8Ti
	/95jjBZP/v9mtThxs5HN4vOz18wWnU++M1ocnnuS1aLz+1IWi8u75rBZ3Fvzn9XiyPqzLBbr
	bgFZm8+eYbZYvFzNYl/HAyaLw1/fMFlMvrSAzeLFlDOMFidnTWaxmH30HruDqMf/g5OYPZae
	fsPmsaEJSLTsu8XusWBTqUfLkbesHov3vGTy2LSqk81j06dJ7B4nZvxm8dj50NLjxeaZjB69
	ze/YPL7d9vBY/OIDk8fnTXIBAlFcNimpOZllqUX6dglcGVPetTAV7Ims+Pr7CnMD4z+PLkZO
	DgkBE4nGT+1sIDabgJrElZeTmLoYOThEBBwkVn1V6GLk4mAW+MQscfvwTGaQGmEBf4nlF6+z
	g9gsAqoSX9YsZwOp5xUwk7jxiBlipKbE4+0/wUo4BcwlXre/AYsLAZU0rv0GFucVEJQ4OfMJ
	C4jNLCAv0bx1NvMERp5ZSFKzkKQWMDKtYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECIyrZbV/
	Ju5g/HLZ/RCjAAejEg/vj7+LU4VYE8uKK3MPMUpwMCuJ8B58viBViDclsbIqtSg/vqg0J7X4
	EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgbHB85rxSbF7IgVpn09/+lHssdLjbJjQ
	M/msy++3njB9Wjxp4ec9bh9mtk6NeLpotqLOxYyiPyxqFkl5i51mBn//v28Cx99gyWh+6X0n
	nH7vWL9gwiZ1B57wrcXVM80+868+NS886N+tmPj1G2tmf7ZQfit25RnjtoNGj+VDtLb8fPbl
	Sfz9GVoXlViKMxINtZiLihMB/3CNO6cCAAA=
X-CFilter-Loop: Reflected

From: Hyeongtak Ji <hyeongtak.ji@sk.com>

This patch introduces DAMOS_PROMOTE action for paddr mode.

It includes renaming alloc_demote_folio to alloc_migrate_folio to use it
for promotion as well.

The execution sequence of DAMOS_DEMOTE and DAMOS_PROMOTE look as
follows for comparison.

  DAMOS_DEMOTE action
    damo_pa_apply_scheme
    -> damon_pa_reclaim
    -> demote_pages
    -> do_demote_folio_list
    -> __demote_folio_list
    -> demote_folio_list

  DAMOS_PROMOTE action
    damo_pa_apply_scheme
    -> damon_pa_promote
    -> promote_pages
    -> do_promote_folio_list
    -> __promote_folio_list
    -> promote_folio_list

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 include/linux/damon.h          |   2 +
 include/linux/migrate_mode.h   |   1 +
 include/linux/vm_event_item.h  |   1 +
 include/trace/events/migrate.h |   3 +-
 mm/damon/paddr.c               |  29 ++++++++
 mm/damon/sysfs-schemes.c       |   1 +
 mm/internal.h                  |   1 +
 mm/vmscan.c                    | 129 ++++++++++++++++++++++++++++++++-
 mm/vmstat.c                    |   1 +
 9 files changed, 165 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4c0a0fef09c5..477060bb6718 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -107,6 +107,7 @@ struct damon_target {
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @DAMOS_DEMOTE:	Do demotion for the current region.
+ * @DAMOS_PROMOTE:	Do promotion if possible, otherwise do nothing.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  *
  * The support of each action is up to running &struct damon_operations.
@@ -125,6 +126,7 @@ enum damos_action {
 	DAMOS_LRU_DEPRIO,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	DAMOS_DEMOTE,
+	DAMOS_PROMOTE,
 	NR_DAMOS_ACTIONS,
 };
 
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
index d3e3f077cd00..360ce69d5898 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -257,6 +257,32 @@ static unsigned long damon_pa_reclaim(struct damon_region *r, struct damos *s, b
 	return applied * PAGE_SIZE;
 }
 
+static unsigned long damon_pa_promote(struct damon_region *r, struct damos *s)
+{
+	unsigned long addr, applied;
+	LIST_HEAD(folio_list);
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
+
+		if (!folio)
+			continue;
+
+		if (damos_pa_filter_out(s, folio))
+			goto put_folio;
+
+		if (!folio_isolate_lru(folio))
+			goto put_folio;
+
+		list_add(&folio->lru, &folio_list);
+put_folio:
+		folio_put(folio);
+	}
+	applied = promote_pages(&folio_list);
+	cond_resched();
+	return applied * PAGE_SIZE;
+}
+
 static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		struct damon_region *r, struct damos *s, bool mark_accessed)
 {
@@ -309,6 +335,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		break;
 	case DAMOS_DEMOTE:
 		return damon_pa_reclaim(r, scheme, true);
+	case DAMOS_PROMOTE:
+		return damon_pa_promote(r, scheme);
 	default:
 		/* DAMOS actions that not yet supported by 'paddr'. */
 		break;
@@ -326,6 +354,7 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 	case DAMOS_DEMOTE:
 		return damon_cold_score(context, r, scheme);
 	case DAMOS_LRU_PRIO:
+	case DAMOS_PROMOTE:
 		return damon_hot_score(context, r, scheme);
 	default:
 		break;
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index ac7cd3f17b12..1b84d0af7e1f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1188,6 +1188,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"lru_deprio",
 	"stat",
 	"demote",
+	"promote",
 };
 
 static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
diff --git a/mm/internal.h b/mm/internal.h
index 2380397ec2f3..f159455e63d4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -870,6 +870,7 @@ unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
 unsigned long demote_pages(struct list_head *folio_list);
+unsigned long promote_pages(struct list_head *folio_list);
 /* The ALLOC_WMARK bits are used as an index to zone->watermark */
 #define ALLOC_WMARK_MIN		WMARK_MIN
 #define ALLOC_WMARK_LOW		WMARK_LOW
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eaa3dd6b7562..f03be320f9ad 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -910,7 +910,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
-static struct folio *alloc_demote_folio(struct folio *src,
+static struct folio *alloc_migrate_folio(struct folio *src,
 		unsigned long private)
 {
 	struct folio *dst;
@@ -973,7 +973,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	node_get_allowed_targets(pgdat, &allowed_mask);
 
 	/* Demotion ignores all cpuset and mempolicy settings */
-	migrate_pages(demote_folios, alloc_demote_folio, NULL,
+	migrate_pages(demote_folios, alloc_migrate_folio, NULL,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
 
@@ -982,6 +982,48 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	return nr_succeeded;
 }
 
+/*
+ * Take folios on @promote_folios and attempt to promote them to another node.
+ * Folios which are not promoted are left on @promote_folios.
+ */
+static unsigned int promote_folio_list(struct list_head *promote_folios,
+				     struct pglist_data *pgdat)
+{
+	int target_nid = next_promotion_node(pgdat->node_id);
+	unsigned int nr_succeeded;
+	nodemask_t allowed_mask = NODE_MASK_NONE;
+
+	struct migration_target_control mtc = {
+		/*
+		 * Allocate from 'node', or fail quickly and quietly.
+		 * When this happens, 'page' will likely be stayed
+		 * instead of migrated.
+		 */
+		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
+			__GFP_NOMEMALLOC | GFP_NOWAIT,
+		.nid = target_nid,
+		.nmask = &allowed_mask
+	};
+
+	if (pgdat->node_id == target_nid)
+		return 0;
+
+	if (list_empty(promote_folios))
+		return 0;
+
+	if (target_nid == NUMA_NO_NODE)
+		return 0;
+
+	/* Promotion ignores all cpuset and mempolicy settings */
+	migrate_pages(promote_folios, alloc_migrate_folio, NULL,
+		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_PROMOTION,
+		      &nr_succeeded);
+
+	__count_vm_events(PGPROMOTE, nr_succeeded);
+
+	return nr_succeeded;
+}
+
 static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
 {
 	if (gfp_mask & __GFP_FS)
@@ -1058,6 +1100,65 @@ static unsigned int __demote_folio_list(struct list_head *folio_list,
 	return nr_demoted;
 }
 
+/*
+ * __promote_folio_list() returns the number of promoted pages
+ */
+static unsigned int __promote_folio_list(struct list_head *folio_list,
+		struct pglist_data *pgdat, struct scan_control *sc)
+{
+	LIST_HEAD(ret_folios);
+	LIST_HEAD(promote_folios);
+	unsigned int nr_promoted = 0;
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
+		if (references == FOLIOREF_KEEP ||
+		    references == FOLIOREF_RECLAIM ||
+		    references == FOLIOREF_RECLAIM_CLEAN)
+			goto keep_locked;
+
+		/* Relocate its contents to another node. */
+		list_add(&folio->lru, &promote_folios);
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
+	/* Migrate folios selected for promotion */
+	nr_promoted += promote_folio_list(&promote_folios, pgdat);
+	/* Folios that could not be promoted are still in @promote_folios */
+	if (!list_empty(&promote_folios)) {
+		/* Folios which weren't promoted go back on @folio_list */
+		list_splice_init(&promote_folios, folio_list);
+	}
+
+	try_to_unmap_flush();
+
+	list_splice(&ret_folios, folio_list);
+
+	return nr_promoted;
+}
+
 /*
  * shrink_folio_list() returns the number of reclaimed pages
  */
@@ -2186,6 +2287,25 @@ static unsigned int do_demote_folio_list(struct list_head *folio_list,
 	return nr_demoted;
 }
 
+static unsigned int do_promote_folio_list(struct list_head *folio_list,
+				      struct pglist_data *pgdat)
+{
+	unsigned int nr_promoted;
+	struct folio *folio;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+	};
+
+	nr_promoted = __promote_folio_list(folio_list, pgdat, &sc);
+	while (!list_empty(folio_list)) {
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+		folio_putback_lru(folio);
+	}
+
+	return nr_promoted;
+}
+
 static unsigned long reclaim_or_migrate_folios(struct list_head *folio_list,
 		unsigned int (*handler)(struct list_head *, struct pglist_data *))
 {
@@ -2230,6 +2350,11 @@ unsigned long demote_pages(struct list_head *folio_list)
 	return reclaim_or_migrate_folios(folio_list, do_demote_folio_list);
 }
 
+unsigned long promote_pages(struct list_head *folio_list)
+{
+	return reclaim_or_migrate_folios(folio_list, do_promote_folio_list);
+}
+
 static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
 				 struct lruvec *lruvec, struct scan_control *sc)
 {
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


