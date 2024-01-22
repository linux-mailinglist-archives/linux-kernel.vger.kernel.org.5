Return-Path: <linux-kernel+bounces-32251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B89835912
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD251C217B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C7DF61;
	Mon, 22 Jan 2024 01:01:10 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719395673
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705885269; cv=none; b=ea0vjkC2Fk+6uLd8wTzrA9m+1mp+UHE7qw6CuTmRcyMkKN2ALCM97EPCraI1HRcW8qDUcNm+SxSYHVodefLCGGAc4VKHjxtmUYhNdIIl6Z6vc7drl1HxfEzSs8fwCI4LIv8bYpbsYt3A7WATTOpCrvzlOEXhwOxi9FrLMzt9F/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705885269; c=relaxed/simple;
	bh=+1VdXIPG+erpF/AVFX/h+PqqlvJOGm1O0Tz9NB8RbNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XiARvw5DHz4R7y/rcvBgQWuRq+IajwYO3DK6JlseqYmE4rrOd5F/wsP7F33n6Wu6OK325HAhyf5DOw/vA+3L3h4F+9/0vwjrqWKJDQ5wqh6s86lSuxZIt1FLbcH5gaoPcn8n+b0TuZGO+bDzVxy01YH/fS5ZeD06ZM9ZJGQE2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-95-65adbe43199d
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
Subject: [PATCH v7 8/8] mm: Pause migrc mechanism at high memory pressure
Date: Mon, 22 Jan 2024 10:00:40 +0900
Message-Id: <20240122010040.74346-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122010040.74346-1-byungchul@sk.com>
References: <20240122010040.74346-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXC9ZZnoa7zvrWpBv0tlhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AdRxctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnls/WXn0Tj1GpvH501yHu/mv2UL4I/isklJ
	zcksSy3St0vgyuhq+89WMFWl4vcmqwbG/bJdjJwcEgImEn+XPWSEsc9O38wGYrMJqEvcuPGT
	GcQWETCTONj6h72LkYuDWeAjk8Tq7x0sIAlhAU+J+4tngzWwCKhKzN23CyzOK2Aq8XjGAyaI
	ofISqzccABvECTRoyq8usLgQUM3cDzsZQYZKCPxnk7g++wgrRIOkxMEVN1gmMPIuYGRYxSiU
	mVeWm5iZY6KXUZmXWaGXnJ+7iREYD8tq/0TvYPx0IfgQowAHoxIPrwP72lQh1sSy4srcQ4wS
	HMxKIrz8qqtShXhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBK
	NTAmNca9qon/vGAqq/PkesONL//mz38uozZjjZLeqskW3PLXMzsO3Fpy7ETnkjjlN4xZKUoX
	u3ks+FuYwhOzzWoXpUwL32z+43D1pyg9jUl+CVbtFc5V/u77FOqLMk+vss5f17LVTTj29uWX
	/vP/fUvn6ViXHlI8O7f9jdeJ1LeyIXZeoTIXriixFGckGmoxFxUnAgAdfhCsgwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrOu8b22qwfs2XYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8Sc7j
	3fy3bAECUVw2Kak5mWWpRfp2CVwZXW3/2QqmqlT83mTVwLhftouRk0NCwETi7PTNbCA2m4C6
	xI0bP5lBbBEBM4mDrX/Yuxi5OJgFPjJJrP7ewQKSEBbwlLi/eDZYA4uAqsTcfbvA4rwCphKP
	ZzxgghgqL7F6wwGwQZxAg6b86gKLCwHVzP2wk3ECI9cCRoZVjCKZeWW5iZk5pnrF2RmVeZkV
	esn5uZsYgcG9rPbPxB2MXy67H2IU4GBU4uF1YF+bKsSaWFZcmXuIUYKDWUmEl191VaoQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDo93xug+yIhccdm+b
	cqr6p337zc+uiesLuSd1Xdi6fhVfdI/iFIFzXTtuLj7U25n/5MI3r0j5DbZFDpxLZb/fuq7Q
	3sdXMjlrx9JVX1MPK+5qv+6nGPlb9d3eyc660Q+0CszSQh3tj7vyv3SSP/dyW0Wi13sxt7YN
	vzzFfbI/9F/YwJlg28joocRSnJFoqMVcVJwIAOxAnm9qAgAA
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


