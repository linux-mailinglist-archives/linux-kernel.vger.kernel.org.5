Return-Path: <linux-kernel+bounces-70755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54233859BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35D3B20EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25D219FC;
	Mon, 19 Feb 2024 06:04:39 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D30210F2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322678; cv=none; b=Jb8G15nPydZbpH8J63CfQiuH1c5+7J3TwWj5LT4KoWd+Uyg549/QeTCoSnHVUf+Wxtnj0uRUE8o+LkHz4fk4IN8mwdFADbXAhzUFh+z23xb4LEkcXZ6+oHipTjc3sIBEOlPo7JMd7iAcxRIdid7R7508ObFIQvjxDqI2fyilW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322678; c=relaxed/simple;
	bh=+1VdXIPG+erpF/AVFX/h+PqqlvJOGm1O0Tz9NB8RbNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=M3sA4fEySQeeifuRdjwL+VzFgtY3GEjHXhf6tpNFbTPObYZwrq9Lo5xJYUqJUq4j2YC0Fx+9xvKFDtHu7UGiOb+b9/FHyeTN2xXaoNO4zgEJ1vZrfCs/dWS2KczzqYN57OrEcwLAH41pdAh7sxzNn1bw65YAQl0hs/se7m+KZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-e1-65d2ef629e08
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v8 8/8] mm: Pause migrc mechanism at high memory pressure
Date: Mon, 19 Feb 2024 15:04:07 +0900
Message-Id: <20240219060407.25254-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240219060407.25254-1-byungchul@sk.com>
References: <20240219060407.25254-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsXC9ZZnkW7S+0upBlOOc1rMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK6Or7T9bwVSVit+brBoY98t2MXJySAiYSLx6e5Adxn45exeYzSagLnHjxk9m
	EFtEwEziYOsfoDgXB7PARyaJ1d87WEASwgKeEnNn3wBKcHCwCKhKtPRbgIR5BUwlOjZfZ4KY
	KS+xesMBZpASTqA5uw8KgYSFgEpOXJ3MBDJSQuA/m8ShN7uYIeolJQ6uuMEygZF3ASPDKkah
	zLyy3MTMHBO9jMq8zAq95PzcTYzAWFhW+yd6B+OnC8GHGAU4GJV4eDNELqUKsSaWFVfmHmKU
	4GBWEuF1b7qQKsSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNT
	qoFx4R97/cSKU/zXXhgsmuN7Xom/Jcj/xTMZlzLvnVYuR8rE9T88kfVIS1HIuxrjH/z6AK9X
	s7DOphfLU70CGTXPaU4+WeeeFzX7++1ZLge4Ll6NNDm9xPAQt75V+zk+N+E6jWPHBJsqWH9Z
	SU7VvOigPPnnrf2RlZ9V3q2Z2HZZhOvW0xp3RXElluKMREMt5qLiRACIIbCQgQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC5WfdrJv4/lKqwcVmU4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8Sc7j
	3fy3bAECUVw2Kak5mWWpRfp2CVwZXW3/2QqmqlT83mTVwLhftouRk0NCwETi5exd7CA2m4C6
	xI0bP5lBbBEBM4mDrX+A4lwczAIfmSRWf+9gAUkIC3hKzJ19AyjBwcEioCrR0m8BEuYVMJXo
	2HydCWKmvMTqDQeYQUo4gebsPigEEhYCKjlxdTLTBEauBYwMqxhFMvPKchMzc0z1irMzKvMy
	K/SS83M3MQIDe1ntn4k7GL9cdj/EKMDBqMTDmyFyKVWINbGsuDL3EKMEB7OSCK9704VUId6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsa+qN/cuR+ZJxic
	q9auf2XEox5edC9pU3qJ7r87F+Lf/zBlkdu5rNZgSn74i1tHZ6ekWUv4Cd+zOuTPNvGstnnv
	ZnNGq5yIbCONxTrJLKW9SVtqfAN2rAted3qPQ0GKXU0Be7GD92GJfLPzt105PjzdrfWaXe1L
	QdvCPX9TVBYLHv+ntOKlthJLcUaioRZzUXEiALbAftxoAgAA
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
 mm/migrate.c    | 18 +++++++++++++++++-
 mm/page_alloc.c | 13 +++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index ab02cb8306e2..55781f879fb2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1285,6 +1285,8 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 #endif /* CONFIG_SHRINKER_DEBUG */
 
 #if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+extern atomic_t migrc_pause_cnt;
+
 /*
  * Reset the indicator indicating there are no writable mappings at the
  * beginning of every rmap traverse for unmap. Migrc can work only when
@@ -1313,6 +1315,21 @@ static inline bool can_migrc_test(void)
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
@@ -1332,6 +1349,9 @@ void migrc_flush_end(struct tlbflush_unmap_batch *batch);
 static inline void can_migrc_init(void) {}
 static inline void can_migrc_fail(void) {}
 static inline bool can_migrc_test(void) { return false; }
+static inline void migrc_pause(void) {}
+static inline void migrc_resume(void) {}
+static inline bool migrc_paused(void) { return false; }
 static inline int migrc_pending_nr_in_zone(struct zone *z) { return 0; }
 static inline bool migrc_flush_free_folios(void) { return false; }
 static inline void migrc_flush_start(void) {}
diff --git a/mm/migrate.c b/mm/migrate.c
index cbe5372f159e..fbc8586ed735 100644
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
 static void init_tlb_ubc(struct tlbflush_unmap_batch *ubc)
 {
 	arch_tlbbatch_clear(&ubc->arch);
@@ -1922,7 +1928,8 @@ static int migrate_pages_batch(struct list_head *from,
 	 */
 	init_tlb_ubc(&pending_ubc);
 	do_migrc = IS_ENABLED(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH) &&
-		   (reason == MR_DEMOTION || reason == MR_NUMA_MISPLACED);
+		   (reason == MR_DEMOTION || reason == MR_NUMA_MISPLACED) &&
+		   !migrc_paused();
 
 	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
@@ -1961,6 +1968,15 @@ static int migrate_pages_batch(struct list_head *from,
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


