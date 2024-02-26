Return-Path: <linux-kernel+bounces-80451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F4B866883
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B9A1C215AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D71C2AF;
	Mon, 26 Feb 2024 03:06:42 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4C1BC57
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916801; cv=none; b=BrLNnA79YufVV73TqBcznKhUkZIeceAEoGFCTakT1BWHBdl1L/S/ubbwmn+C2x2HC+JSGdANl+oYz0ZtkjIf1UxwwsaPcYVUOGROR/kZhCN8cmGOpDamUfqcLb8Y4M2IBG4c0usEBAnmfoxisnw1CbbucQ54K7Kvs3+qjJh4UyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916801; c=relaxed/simple;
	bh=+1VdXIPG+erpF/AVFX/h+PqqlvJOGm1O0Tz9NB8RbNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fPJrtcfwGBTVorHRT7AkAMktxUdaD6Wqmmi2Pg97bDUaZcTM9he6QVHSWkHuwf+92MUkDtK7tKthAYarjzIHSO++wrLcxu9FXbBL9CogghnlKsJfgvAD+r50ZmVd6m6ZKajbTKZWRz4TSNA5KLbGXn5rX5zTZzCMPI1m0oKlEbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-4b-65dc00305618
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
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
Subject: [RESEND PATCH v8 8/8] mm: Pause migrc mechanism at high memory pressure
Date: Mon, 26 Feb 2024 12:06:13 +0900
Message-Id: <20240226030613.22366-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240226030613.22366-1-byungchul@sk.com>
References: <20240226030613.22366-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoa4Bw51Ug5PTRS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAldG
	V9t/toKpKhW/N1k1MO6X7WLk5JAQMJH42X+DEcZu+neHCcRmE1CXuHHjJzOILSJgJnGw9Q87
	iM0scJdJ4kA/G4gtLBAgsbDzMiuIzSKgKnFmzjUwm1fAVOLOjgvsEDPlJVZvOAA0h4ODE2jO
	+/+GIGEhoJK/vVeB1nIBlXxmkzjyfB0LRL2kxMEVN1gmMPIuYGRYxSiUmVeWm5iZY6KXUZmX
	WaGXnJ+7iREY9stq/0TvYPx0IfgQowAHoxIP74IPt1OFWBPLiitzDzFKcDArifCGy9xMFeJN
	SaysSi3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cCokaC2g9Mq8Ixo
	ypMFAUuX3Dtj+C6pXKu1uPzwVqaOQ5+uGCTEH5Xt5FaX/M1ZUG8b1f9egfPBX3ahxQ21f3kv
	31ro4dambOOnIjA7eVX+30BW+ZfbQi+ErRCwWd73wEfz0OqEsOe/3M+oXOdf9W6txuklXGms
	/Z41U7YauOWI9KisY5nPcl+JpTgj0VCLuag4EQCWNApudwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrGvAcCfVYMJNdos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZXS1/WcrmKpS8XuTVQPjftkuRk4OCQETiaZ/d5hAbDYBdYkbN34yg9giAmYS
	B1v/sIPYzAJ3mSQO9LOB2MICARILOy+zgtgsAqoSZ+ZcA7N5BUwl7uy4wA4xU15i9YYDQHM4
	ODiB5rz/bwgSFgIq+dt7lXECI9cCRoZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgUG8rPbP
	xB2MXy67H2IU4GBU4uFd8OF2qhBrYllxZe4hRgkOZiUR3nCZm6lCvCmJlVWpRfnxRaU5qcWH
	GKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjOZfFouliRezzvW/IjXh9MJlbuUnPmo1
	9K0T/nN3ysVdU24d335DOrfyjYaUyipdoWO8lzOEqvZ0LuR0XbJrWuzpeYELJKVm61zXW8Um
	sz14af3MZ/bTebLOu/78Eb/f3/q+2RZTqfrutEnOeu8Cb5yrFtlh0HHpa5gYQ4Dhkuw4g6bv
	Suf+ciuxFGckGmoxFxUnAgAB/uHHXgIAAA==
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


