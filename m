Return-Path: <linux-kernel+bounces-132458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28831899516
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482301C20E03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC865BAD;
	Fri,  5 Apr 2024 06:09:19 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF274CB4B;
	Fri,  5 Apr 2024 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297358; cv=none; b=KBDty4oBptMCwUHoBjLemKcdjlspz9Gttu62EkUfsFkrIJBRfRY4+82leFk7wz3uF2ndtziz6vnlVp1KvHtw90evTiDbd937z6EceIS7ZTBdf+J4ygbBq6lTUGWXswj/YRM0QG3zHsiZuj5gAu0yuvLIhQZwvWN91BwCvkI6/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297358; c=relaxed/simple;
	bh=gsAAZc9cuhVh+ZidXiXs6Qt6krpw6tKnwYRowtFGyuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkZWvFNKg96f18ToQiX4t0DQQFkCsYxO2xymMcb2DKjUH2640awMQ5UvzNlhX6915q9VKAsbXElDFvDN0B67zY6/0yVob1fIsRlbME3ZaVjBFBQnj2YQjG/6bzpQIhb8+IRdnsolHAsJyeSLL83mUvKWjWqyvpbgHEZOOIUgktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-bf-660f9584a273
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
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: [RFC PATCH v3 5/7] mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
Date: Fri,  5 Apr 2024 15:08:54 +0900
Message-ID: <20240405060858.2818-6-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240405060858.2818-1-honggyu.kim@sk.com>
References: <20240405060858.2818-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsXC9ZZnkW7rVP40g/cv2S0m9hhYzFm/hs1i
	140Qi/sPXrNb/N97jNHiyf/frBYnbjayWXR+X8picXnXHDaLe2v+s1ocWX+WxWLz2TPMFouX
	q1ns63jAZHH46xsmi8mXFrBZvJhyhtHi5KzJLBazj95jdxD2WHr6DZvHhiYgsXPWXXaPln23
	2D0WbCr1aDnyltVj8Z6XTB6bVnWyeWz6NInd48SM3yweOx9aerzYPJPRo7f5HZvH501yAXxR
	XDYpqTmZZalF+nYJXBlzt39lKXjmWHFx+wPWBsafJl2MnBwSAiYS1yY8ZIWxv8xYwQRiswmo
	SVx5OQnI5uAQEXCQWPVVoYuRi4NZ4D+zxOXeX2D1wgIxEltu9bGA2CwCqhLv23+xg9i8AmYS
	6w5MYYSYqSnxePtPsDingLnEvMcbwGwhoJpPB49B1QtKnJz5BGwOs4C8RPPW2cwgyyQEjrFL
	dPcuZ4EYJClxcMUNlgmM/LOQ9MxC0rOAkWkVo1BmXlluYmaOiV5GZV5mhV5yfu4mRmDcLav9
	E72D8dOF4EOMAhyMSjy8HnP50oRYE8uKK3MPMUpwMCuJ8HY78KYJ8aYkVlalFuXHF5XmpBYf
	YpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYGTO1Z7VPcNyR8qcL2IbfwY1nGD8ukzz
	+eKnGe9WXD7HyMGgt2rulqqdLZvMHSYqXVwqe+C3yd11/tf+fNp1klX585qpDUsnG79RadJT
	fXK06keZ/Zeea8XyZxRCi++/PGd4V3NX6LmrjzSqmBgmH+lY+Vb+b2CvjcWd/XNPMzpsqb9j
	Pvuk/9oCJZbijERDLeai4kQAHlV+d7cCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXCNUNLT7dlKn+awYajxhYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLD4/e81s0fnkO6PF4bknWS06vy9lsbi8aw6bxb01
	/1ktjqw/y2Kx+ewZZovFy9UsDl17zmqxr+MBk8Xhr2+YLCZfWsBm8WLKGUaLk7Mms1jMPnqP
	3UHcY+npN2weG5qAxM5Zd9k9WvbdYvdYsKnUo+XIW1aPxXteMnlsWtXJ5rHp0yR2jxMzfrN4
	7Hxo6fFi80xGj97md2we3257eCx+8YHJ4/MmuQCBKC6blNSczLLUIn27BK6Mudu/shQ8c6y4
	uP0BawPjT5MuRk4OCQETiS8zVjCB2GwCahJXXk4Csjk4RAQcJFZ9Vehi5OJgFvjPLHG59xcr
	SI2wQIzEllt9LCA2i4CqxPv2X+wgNq+AmcS6A1MYIWZqSjze/hMszilgLjHv8QYwWwio5tPB
	Y1D1ghInZz4Bm8MsIC/RvHU28wRGnllIUrOQpBYwMq1iFMnMK8tNzMwx1SvOzqjMy6zQS87P
	3cQIjLVltX8m7mD8ctn9EKMAB6MSD6/HXL40IdbEsuLK3EOMEhzMSiK83Q68aUK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MrXcDg/iWGvI5yvDcEPSw
	P7yqU3jJ5C2Pvy4L8fm1582vb8cbBHa9dWFsOCph3xcfE7ij53oE2/o5kXf2dcY+e1Nr+oMr
	4Hrr5n1XHJdsEYkI9Jt05UHSp92tM6sTGmznMuj59LzSXeVnl+zzf8/UavV1Jhr7TaNcmH7q
	CmYbMthL8AfIuscosRRnJBpqMRcVJwIAr8ixFrECAAA=
X-CFilter-Loop: Reflected

This patch introduces DAMOS_MIGRATE_COLD action, which is similar to
DAMOS_PAGEOUT, but migrate folios to the given 'target_nid' in the sysfs
instead of swapping them out.

The 'target_nid' sysfs knob is created by this patch to inform the
migration target node ID.

Here is one of the example usage of this 'migrate_cold' action.

  $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
  $ cat contexts/<N>/schemes/<N>/action
  migrate_cold
  $ echo 2 > contexts/<N>/schemes/<N>/target_nid
  $ echo commit > state
  $ numactl -p 0 ./hot_cold 500M 600M &
  $ numastat -c -p hot_cold

  Per-node process memory usage (in MBs)
  PID             Node 0 Node 1 Node 2 Total
  --------------  ------ ------ ------ -----
  701 (hot_cold)     501      0    601  1101

Since there are some common routines with pageout, many functions have
similar logics between pageout and migrate cold.

damon_pa_migrate_folio_list() is a minimized version of
shrink_folio_list(), but it's minified only for demotion.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 include/linux/damon.h    |   2 +
 mm/damon/paddr.c         | 146 ++++++++++++++++++++++++++++++++++++++-
 mm/damon/sysfs-schemes.c |   4 ++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 24ea33a03d5d..df8671e69a70 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -105,6 +105,7 @@ struct damon_target {
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
+ * @DAMOS_MIGRATE_COLD: Migrate for the given cold region.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
  *
@@ -122,6 +123,7 @@ enum damos_action {
 	DAMOS_NOHUGEPAGE,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
+	DAMOS_MIGRATE_COLD,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
 };
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 277a1c4d833c..fe217a26f788 100644
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
@@ -226,8 +229,137 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 
 enum migration_mode {
 	MIG_PAGEOUT,
+	MIG_MIGRATE_COLD,
 };
 
+static unsigned int migrate_folio_list(struct list_head *migrate_folios,
+				       struct pglist_data *pgdat,
+				       int target_nid)
+{
+	unsigned int nr_succeeded;
+	nodemask_t allowed_mask = NODE_MASK_NONE;
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
+	/* Migration ignores all cpuset and mempolicy settings */
+	migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
+		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
+		      &nr_succeeded);
+
+	return nr_succeeded;
+}
+
+static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
+						struct pglist_data *pgdat,
+						enum migration_mode mm,
+						int target_nid)
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
+		/* Relocate its contents to another node. */
+		list_add(&folio->lru, &migrate_folios);
+		folio_unlock(folio);
+		continue;
+keep:
+		list_add(&folio->lru, &ret_folios);
+		VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
+	}
+	/* 'folio_list' is always empty here */
+
+	/* Migrate folios selected for migration */
+	nr_migrated += migrate_folio_list(&migrate_folios, pgdat, target_nid);
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
+static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
+					    enum migration_mode mm,
+					    int target_nid)
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
+							   NODE_DATA(nid), mm,
+							   target_nid);
+		nid = folio_nid(lru_to_folio(folio_list));
+	} while (!list_empty(folio_list));
+
+	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
+						   NODE_DATA(nid), mm,
+						   target_nid);
+
+	memalloc_noreclaim_restore(noreclaim_flag);
+
+	return nr_migrated;
+}
+
 static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 				      enum migration_mode mm)
 {
@@ -247,7 +379,11 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
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
@@ -258,6 +394,10 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	case MIG_PAGEOUT:
 		applied = reclaim_pages(&folio_list);
 		break;
+	case MIG_MIGRATE_COLD:
+		applied = damon_pa_migrate_pages(&folio_list, mm,
+						 s->target_nid);
+		break;
 	default:
 		/* Unexpected migration mode. */
 		return 0;
@@ -314,6 +454,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r, scheme);
+	case DAMOS_MIGRATE_COLD:
+		return damon_pa_migrate(r, scheme, MIG_MIGRATE_COLD);
 	case DAMOS_STAT:
 		break;
 	default:
@@ -334,6 +476,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 		return damon_hot_score(context, r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_cold_score(context, r, scheme);
+	case DAMOS_MIGRATE_COLD:
+		return damon_cold_score(context, r, scheme);
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 1a30ea82c890..18b7d054c748 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1406,6 +1406,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"nohugepage",
 	"lru_prio",
 	"lru_deprio",
+	"migrate_cold",
 	"stat",
 };
 
@@ -1659,6 +1660,9 @@ static ssize_t target_nid_store(struct kobject *kobj,
 			struct damon_sysfs_scheme, kobj);
 	int err = 0;
 
+        if (scheme->action != DAMOS_MIGRATE_COLD)
+                return -EINVAL;
+
 	/* TODO: error handling for target_nid range. */
 	err = kstrtoint(buf, 0, &scheme->target_nid);
 
-- 
2.34.1


