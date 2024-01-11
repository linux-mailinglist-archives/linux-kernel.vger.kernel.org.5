Return-Path: <linux-kernel+bounces-23092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E761682A788
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA53B22B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6EF4F2;
	Thu, 11 Jan 2024 06:23:37 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31293DDB6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-fc-659f85c84c60
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	xhao@linux.alibaba.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: [v5 7/7] mm: Pause migrc mechanism at high memory pressure
Date: Thu, 11 Jan 2024 15:07:57 +0900
Message-Id: <20240111060757.13563-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240111060757.13563-1-byungchul@sk.com>
References: <20240111060757.13563-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXC9ZZnke6J1vmpBt+OS1rMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	2LxpKrPF7x9AdXOmWFmcnDWZxUHA43trH4vHgk2lHptXaHks3vOSyWPTqk42j02fJrF7vDt3
	jt3jxIzfLB47H1p6zDsZ6PF+31U2j62/7Dw+b5LzeDf/LVsAXxSXTUpqTmZZapG+XQJXRuvT
	24wF15Qq7p/7wt7AOEGmi5GTQ0LAROLXs9WMXYwcYPbXpUogYTYBdYkbN34yg9giAmYSB1v/
	sHcxcnEwCzxgkpj7dgUjSEJYwFniypE37CA2i4CqROeWKWANvAKmEvv6/7NAzJeXWL3hAFic
	E2jQhcOzwHYJAdU8aqsDmSkh8J1N4tSzHmaIekmJgytusExg5F3AyLCKUSgzryw3MTPHRC+j
	Mi+zQi85P3cTIzDol9X+id7B+OlC8CFGAQ5GJR7eB4vmpQqxJpYVV+YeYpTgYFYS4VX4PCdV
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA2NK4BODuvaY
	85cFJTwi2gO2xOTpXdLxvB3rWPEvRO3BVrPfk2a/mLP0+O0inqUT706TTah6NNH0uJH4iclr
	Pt/dVa+umMV6Z9WRz9p28tvio3J3Gu/8fDNWbOU7j4txHAvdkpoumdT7HLhWKNuyKt/lit/x
	yiS/n25KJz/XTOMoPKi/aJ3Yu0glluKMREMt5qLiRAA8WMaJdgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsXC5WfdrHuidX6qwatdfBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGSxedNUZovfP4Dq5kyxsjg5azKLg6DH99Y+Fo8Fm0o9Nq/Q8li85yWTx6ZVnWwemz5N
	Yvd4d+4cu8eJGb9ZPHY+tPSYdzLQ4/2+q2wei198YPLY+svO4/MmOY9389+yBfBHcdmkpOZk
	lqUW6dslcGW0Pr3NWHBNqeL+uS/sDYwTZLoYOTgkBEwkvi5V6mLk5GATUJe4ceMnM4gtImAm
	cbD1D3sXIxcHs8ADJom5b1cwgiSEBZwlrhx5ww5iswioSnRumQLWwCtgKrGv/z8LiC0hIC+x
	esMBsDgn0KALh2cxguwSAqp51FY3gZFrASPDKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMAQ
	Xlb7Z+IOxi+X3Q8xCnAwKvHwGryclyrEmlhWXJl7iFGCg1lJhFfh85xUId6UxMqq1KL8+KLS
	nNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsYWjaCUo+t/GWzL++0tv2VW7tMf
	f5/V301+XBobrB6ynffi8vTP7d/z9nGtcdu9oVps9zaOiwtn+6oa7T+kw7hwkYHh6nQHY0HB
	m7xr52xLmj7vQtXT0wc2yarpOrhskFvDf2NXl4iBQWjBnS+Nxit2f65gPy+tfdJzQvmzsNOT
	/p/33HyE/9I+JZbijERDLeai4kQAdp/uwF0CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Regression was observed when the system is in high memory pressure with
swap on, where migrc might keep a number of folios in its pending queue,
which possibly makes it worse. So temporarily prevented migrc from
working on that condition.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/internal.h   | 20 ++++++++++++++++++++
 mm/migrate.c    | 16 ++++++++++++++++
 mm/page_alloc.c | 13 +++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index dc72a04d33a8..cade8219b417 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1295,6 +1295,8 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 #endif /* CONFIG_SHRINKER_DEBUG */
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+extern atomic_t migrc_pause_cnt;
+
 /*
  * Reset the indicator indicating there are no writable mappings at the
  * beginning of every rmap traverse for unmap. Migrc can work only when
@@ -1323,6 +1325,21 @@ static inline bool can_migrc_test(void)
 	return current->can_migrc && current->tlb_ubc_ro.flush_required;
 }
 
+static inline void migrc_pause(void)
+{
+	atomic_inc(&migrc_pause_cnt);
+}
+
+static inline void migrc_resume(void)
+{
+	atomic_dec(&migrc_pause_cnt);
+}
+
+static inline bool migrc_paused(void)
+{
+	return !!atomic_read(&migrc_pause_cnt);
+}
+
 /*
  * Return the number of folios pending TLB flush that have yet to get
  * freed in the zone.
@@ -1340,6 +1357,9 @@ bool migrc_flush_free_folios(void);
 static inline void can_migrc_init(void) {}
 static inline void can_migrc_fail(void) {}
 static inline bool can_migrc_test(void) { return false; }
+static inline void migrc_pause(void) {}
+static inline void migrc_resume(void) {}
+static inline bool migrc_paused(void) { return false; }
 static inline int migrc_pending_nr_in_zone(struct zone *z) { return 0; }
 static inline bool migrc_flush_free_folios(void) { return false; }
 #endif
diff --git a/mm/migrate.c b/mm/migrate.c
index 181bfe260442..d072591c6ce6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -62,6 +62,12 @@ static struct tlbflush_unmap_batch migrc_ubc;
 static LIST_HEAD(migrc_folios);
 static DEFINE_SPINLOCK(migrc_lock);
 
+/*
+ * Increase on entry of handling high memory pressure e.g. direct
+ * reclaim, decrease on the exit. See __alloc_pages_slowpath().
+ */
+atomic_t migrc_pause_cnt = ATOMIC_INIT(0);
+
 /*
  * Need to synchronize between TLB flush and managing pending CPUs in
  * migrc_ubc. Take a look at the following scenario:
@@ -1892,6 +1898,7 @@ static int migrate_pages_batch(struct list_head *from,
 	 */
 	init_tlb_ubc(&pending_ubc);
 	do_migrc = (reason == MR_DEMOTION || reason == MR_NUMA_MISPLACED);
+	do_migrc = do_migrc && !migrc_paused();
 
 	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
@@ -1930,6 +1937,15 @@ static int migrate_pages_batch(struct list_head *from,
 				continue;
 			}
 
+			/*
+			 * In case that the system is in high memory
+			 * pressure, give up migrc mechanism this turn.
+			 */
+			if (unlikely(do_migrc && migrc_paused())) {
+				fold_ubc(tlb_ubc, &pending_ubc);
+				do_migrc = false;
+			}
+
 			can_migrc_init();
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
 					private, folio, &dst, mode, reason,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6ef0c22b1109..366777afce7f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4072,6 +4072,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	unsigned int cpuset_mems_cookie;
 	unsigned int zonelist_iter_cookie;
 	int reserve_flags;
+	bool migrc_paused = false;
 
 restart:
 	compaction_retries = 0;
@@ -4203,6 +4204,16 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (page)
 		goto got_pg;
 
+	/*
+	 * The system is in very high memory pressure. Pause migrc from
+	 * expanding its pending queue temporarily.
+	 */
+	if (!migrc_paused) {
+		migrc_pause();
+		migrc_paused = true;
+		migrc_flush_free_folios();
+	}
+
 	/* Caller is not willing to reclaim, we can't balance anything */
 	if (!can_direct_reclaim)
 		goto nopage;
@@ -4330,6 +4341,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
+	if (migrc_paused)
+		migrc_resume();
 	return page;
 }
 
-- 
2.17.1


