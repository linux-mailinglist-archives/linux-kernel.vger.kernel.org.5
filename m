Return-Path: <linux-kernel+bounces-81583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4E8677D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C993287BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE712CD89;
	Mon, 26 Feb 2024 14:06:24 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA7E12C525;
	Mon, 26 Feb 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956383; cv=none; b=QPmRRahs7k8CN6PM67SwTS40uPjWAA1QtDr1W+OKSS6BeFxSLd1K815tzY1UW+aphLrkxiT8QmPCHSl4f74aBxCP9dFK6hefwCYuCF8wo/JHJiIii26KZSubMjlFtH3IfXSx5Rol2CgS4amQlK2jqQsNIU2sBG+MrQJzF3QMKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956383; c=relaxed/simple;
	bh=k6DbcpBVXMmCiXmnmNrP0yZrXB+ni5erIDbzS0ImpJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpbDZHOdOWdoPIHUFOcQ4gEM9FNtn0Xsq+a9+sjqxMrwGPbjPi7EHtR0mQpMJzQYNFw/GyGYkVdERy10nLtDkQbziq933p4O1C7AC8igLVOjR8N8lMoyR5WlFL4j1naCA68aPKUkXxm9WkmH2fitrmyGSAQFnpe12Rq9hZb4vss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-6b-65dc9ad87a7f
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
Subject: [PATCH v2 3/7] mm/damon: introduce DAMOS_DEMOTE action for demotion
Date: Mon, 26 Feb 2024 23:05:49 +0900
Message-ID: <20240226140555.1615-4-honggyu.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsXC9ZZnoe6NWXdSDebt0LaY2GNgMWf9GjaL
	XTdCLP7vPcZo8eT/b1aLEzcb2Sw6vy9lsbi8aw6bxb01/1ktjqw/y2Kx7haQtfnsGWaLxcvV
	LPZ1PGCyOPz1DZPF5EsL2CxeTDnDaHFy1mQWi9lH77E7CHv8PziJ2WPp6TdsHhuagMTOWXfZ
	PVr23WL3WLCp1KPlyFtWj8V7XjJ5bFrVyeax6dMkdo8TM36zeOx8aOnxYvNMRo/e5ndsHp83
	yQXwR3HZpKTmZJalFunbJXBlvDqzlrlgtU/FtxdbmBsYb9l2MXJySAiYSDy53M4IY8+dcZYN
	xGYTUJO48nISUxcjB4eIgIPEqq8KXYxcHMwCDSwSPz5fYgGpERbwkeiceYYJxGYRUJW4N/sX
	M4jNK2Am8afrFjPETE2Jx9t/soPYnALmEv8Pt7OBzBQCqjl6G6pcUOLkzCdgI5kF5CWat85m
	BtklIXCKXeL/hLOsEHMkJQ6uuMEygZF/FpKeWUh6FjAyrWIUyswry03MzDHRy6jMy6zQS87P
	3cQIjL9ltX+idzB+uhB8iFGAg1GJh9eh9k6qEGtiWXFl7iFGCQ5mJRHecJmbqUK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYF79myP4s1c6u8d//s72H
	10GOnSfll05a0zc/NefqohmNm5yW8SvZx17mdy5d4DTzk9Mm1nf+tR3xBXFvqrOi3OYKmW9s
	DQ7f3iNuFle+aPHT9N9+XY8vW2WaL/0S91pgxwcGa/m47XcLrm1R5ew6+rVnd9v/oN37gnb7
	mb53yFpdrqO0fw67EktxRqKhFnNRcSIAYaWl7rsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXCNUNLT/fGrDupBj2n5C0m9hhYzFm/hs1i
	140Qi/97jzFaPPn/m9XixM1GNovPz14zW3Q++c5ocXjuSVaLzu9LWSwu75rDZnFvzX9WiyPr
	z7JYrLsFZG0+e4bZYvFyNYtD156zWuzreMBkcfjrGyaLyZcWsFm8mHKG0eLkrMksFrOP3mN3
	EPf4f3ASs8fS02/YPDY0AYmds+6ye7Tsu8XusWBTqUfLkbesHov3vGTy2LSqk81j06dJ7B4n
	Zvxm8dj50NLjxeaZjB69ze/YPL7d9vBY/OIDU4BgFJdNSmpOZllqkb5dAlfGqzNrmQtW+1R8
	e7GFuYHxlm0XIyeHhICJxNwZZ9lAbDYBNYkrLycxdTFycIgIOEis+qrQxcjFwSzQwCLx4/Ml
	FpAaYQEfic6ZZ5hAbBYBVYl7s38xg9i8AmYSf7puMUPM1JR4vP0nO4jNKWAu8f9wOxvITCGg
	mqO3ocoFJU7OfAI2kllAXqJ562zmCYw8s5CkZiFJLWBkWsUokplXlpuYmWOqV5ydUZmXWaGX
	nJ+7iREYa8tq/0zcwfjlsvshRgEORiUeXofaO6lCrIllxZW5hxglOJiVRHjDZW6mCvGmJFZW
	pRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTAaWRvZp3m2y1/ukm7Z
	eDFZ4tL0k58LjnHqsq/6ptO9xqZoWWKmmoSg0L7/OU7f7XUmMPPblv9dYWXUdH7eV6WXC9zO
	qX+98VfRv0tGwWyLcf3TTyeexJ1nvOPaMjtHOX++sH1woepsPbWN15uPvCx83vNHwCe6/t1K
	o9VOvCYWMoqJ2u6fVymxFGckGmoxFxUnAgBVpl34sQIAAA==
X-CFilter-Loop: Reflected

This patch introduces DAMOS_DEMOTE action, which is similar to
DAMOS_PAGEOUT, but demote folios instead of swapping them out.

Since there are some common routines with pageout, many functions have
similar logics between pageout and demote.

damon_pa_migrate_folio_list() is a minimized version of
shrink_folio_list(), but it's minified only for demotion.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 include/linux/damon.h    |   2 +
 mm/damon/paddr.c         | 222 ++++++++++++++++++++++++++++++++++++++-
 mm/damon/sysfs-schemes.c |   1 +
 3 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e00ddf1ed39c..86e66772766b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -105,6 +105,7 @@ struct damon_target {
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
+ * @DAMOS_DEMOTE:       Do demotion for the given region.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  *
@@ -122,6 +123,7 @@ enum damos_action {
 	DAMOS_NOHUGEPAGE,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
+	DAMOS_DEMOTE,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
 };
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 277a1c4d833c..23e37ce57202 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -12,6 +12,9 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
+#include <linux/memory-tiers.h>
+#include <linux/migrate.h>
+#include <linux/mm_inline.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -226,8 +229,214 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 
 enum migration_mode {
 	MIG_PAGEOUT,
+	MIG_DEMOTE,
 };
 
+/*
+ * XXX: This is copied from demote_folio_list as renamed as migrate_folio_list.
+ * Take folios on @migrate_folios and attempt to migrate them to another node.
+ * Folios which are not migrated are left on @migrate_folios.
+ */
+static unsigned int migrate_folio_list(struct list_head *migrate_folios,
+				       struct pglist_data *pgdat,
+				       enum migration_mode mm)
+{
+	int target_nid = next_demotion_node(pgdat->node_id);
+	unsigned int nr_succeeded;
+	nodemask_t allowed_mask;
+
+	struct migration_target_control mtc = {
+		/*
+		 * Allocate from 'node', or fail quickly and quietly.
+		 * When this happens, 'page' will likely just be discarded
+		 * instead of migrated.
+		 */
+		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
+			__GFP_NOMEMALLOC | GFP_NOWAIT,
+		.nid = target_nid,
+		.nmask = &allowed_mask
+	};
+
+	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
+		return 0;
+
+	if (list_empty(migrate_folios))
+		return 0;
+
+	node_get_allowed_targets(pgdat, &allowed_mask);
+
+	/* Migration ignores all cpuset and mempolicy settings */
+	migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
+		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
+		      &nr_succeeded);
+
+	__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
+
+	return nr_succeeded;
+}
+
+enum folio_references {
+	FOLIOREF_RECLAIM,
+	FOLIOREF_KEEP,
+	FOLIOREF_ACTIVATE,
+};
+
+/*
+ * XXX: This is just copied and simplified from folio_check_references at
+ *      mm/vmscan.c but without having scan_control.
+ */
+static enum folio_references folio_check_references(struct folio *folio)
+{
+	int referenced_ptes, referenced_folio;
+	unsigned long vm_flags;
+
+	referenced_ptes = folio_referenced(folio, 1, NULL, &vm_flags);
+	referenced_folio = folio_test_clear_referenced(folio);
+
+	/* rmap lock contention: rotate */
+	if (referenced_ptes == -1)
+		return FOLIOREF_KEEP;
+
+	if (referenced_ptes) {
+		/*
+		 * All mapped folios start out with page table
+		 * references from the instantiating fault, so we need
+		 * to look twice if a mapped file/anon folio is used more
+		 * than once.
+		 *
+		 * Mark it and spare it for another trip around the
+		 * inactive list.  Another page table reference will
+		 * lead to its activation.
+		 *
+		 * Note: the mark is set for activated folios as well
+		 * so that recently deactivated but used folios are
+		 * quickly recovered.
+		 */
+		folio_set_referenced(folio);
+
+		if (referenced_folio || referenced_ptes > 1)
+			return FOLIOREF_ACTIVATE;
+
+		/*
+		 * Activate file-backed executable folios after first usage.
+		 */
+		if ((vm_flags & VM_EXEC) && folio_is_file_lru(folio))
+			return FOLIOREF_ACTIVATE;
+
+		return FOLIOREF_KEEP;
+	}
+
+	return FOLIOREF_RECLAIM;
+}
+
+/*
+ * XXX: This is minimized implmentation based on shrink_folio_list only for
+ *      the demotion calling demote_folio_list.
+ */
+static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
+						struct pglist_data *pgdat,
+						enum migration_mode mm)
+{
+	unsigned int nr_migrated = 0;
+	struct folio *folio;
+	LIST_HEAD(ret_folios);
+	LIST_HEAD(migrate_folios);
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
+		references = folio_check_references(folio);
+		if (references == FOLIOREF_KEEP)
+			goto keep_locked;
+
+		/* Relocate its contents to another node. */
+		list_add(&folio->lru, &migrate_folios);
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
+	/* Migrate folios selected for migration */
+	nr_migrated += migrate_folio_list(&migrate_folios, pgdat, mm);
+	/* Folios that could not be migrated are still in @migrate_folios */
+	if (!list_empty(&migrate_folios)) {
+		/* Folios which weren't migrated go back on @folio_list */
+		list_splice_init(&migrate_folios, folio_list);
+	}
+
+	try_to_unmap_flush();
+
+	list_splice(&ret_folios, folio_list);
+
+	while (!list_empty(folio_list)) {
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+		folio_putback_lru(folio);
+	}
+
+	return nr_migrated;
+}
+
+/*
+ * XXX: This is almost identical to reclaim_pages() in mm/vmscan.c, but it
+ *      internally calls damon_pa_migrate_folio_list() instead of
+ *      reclaim_folio_list().  We might be better to think if we can have a
+ *      common function for both cases.
+ */
+static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
+					    enum migration_mode mm)
+{
+	int nid;
+	unsigned int nr_migrated = 0;
+	LIST_HEAD(node_folio_list);
+	unsigned int noreclaim_flag;
+
+	if (list_empty(folio_list))
+		return nr_migrated;
+
+	noreclaim_flag = memalloc_noreclaim_save();
+
+	nid = folio_nid(lru_to_folio(folio_list));
+	do {
+		struct folio *folio = lru_to_folio(folio_list);
+
+		if (nid == folio_nid(folio)) {
+			folio_clear_active(folio);
+			list_move(&folio->lru, &node_folio_list);
+			continue;
+		}
+
+		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
+							   NODE_DATA(nid), mm);
+		nid = folio_nid(lru_to_folio(folio_list));
+	} while (!list_empty(folio_list));
+
+	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
+						   NODE_DATA(nid), mm);
+
+	memalloc_noreclaim_restore(noreclaim_flag);
+
+	return nr_migrated;
+}
+
 static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 				      enum migration_mode mm)
 {
@@ -247,7 +456,11 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		folio_test_clear_young(folio);
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
-		if (folio_test_unevictable(folio))
+		/*
+		 * Since unevictable folios can be demoted or promoted,
+		 * unevictable test is needed only for pageout.
+		 */
+		if (mm == MIG_PAGEOUT && folio_test_unevictable(folio))
 			folio_putback_lru(folio);
 		else
 			list_add(&folio->lru, &folio_list);
@@ -258,6 +471,9 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	case MIG_PAGEOUT:
 		applied = reclaim_pages(&folio_list);
 		break;
+	case MIG_DEMOTE:
+		applied = damon_pa_migrate_pages(&folio_list, mm);
+		break;
 	default:
 		/* Unexpected migration mode. */
 		return 0;
@@ -314,6 +530,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r, scheme);
+	case DAMOS_DEMOTE:
+		return damon_pa_migrate(r, scheme, MIG_DEMOTE);
 	case DAMOS_STAT:
 		break;
 	default:
@@ -334,6 +552,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 		return damon_hot_score(context, r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_cold_score(context, r, scheme);
+	case DAMOS_DEMOTE:
+		return damon_cold_score(context, r, scheme);
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index fe0fe2562000..53e47fad5021 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1186,6 +1186,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"nohugepage",
 	"lru_prio",
 	"lru_deprio",
+	"demote",
 	"stat",
 };
 
-- 
2.34.1


