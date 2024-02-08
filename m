Return-Path: <linux-kernel+bounces-57519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED6984DA13
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8382C1C22348
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52C16A03B;
	Thu,  8 Feb 2024 06:26:32 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78256997B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373592; cv=none; b=iRhzwrgEaGSms+hcuZ2/EMOLtYg1vNxmajVrMYZvPsY+VwwOUI9nB78z9G+rIlZ1xWbncDcLrka/AVaWTMfEze5Qvd7MP7orTsV0Be/srZJIar3S7ObjZL7yvviatPrTLIYYL6YpZ5tT69R6FBl8a9ce6VQl9ynZk4FBXKo4CbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373592; c=relaxed/simple;
	bh=+1VdXIPG+erpF/AVFX/h+PqqlvJOGm1O0Tz9NB8RbNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Fo0nQo/kNKH/8X7etmn0cCzPNzhTpRahqwZpngxCpatMqK5OaPF0zdO0NLhxrgCivYk6PtPSqCuaK4JdHhXFz9bttvcV7am9YkSApbRYdkk28Wpr3PsqxwjNHLZLT3iDJgOohxH74f4o+uPzxYDq3jJmZNyV6TTA3EddSsqPyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-92-65c4740b9853
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
Subject: [RESEND PATCH v7 8/8] mm: Pause migrc mechanism at high memory pressure
Date: Thu,  8 Feb 2024 15:26:08 +0900
Message-Id: <20240208062608.44351-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208062608.44351-1-byungchul@sk.com>
References: <20240208062608.44351-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXC9ZZnkS53yZFUg2OLFS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeL6roeMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6jj5KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkPN7Nf8sWwB/FZZOS
	mpNZllqkb5fAldHV9p+tYKpKxe9NVg2M+2W7GDk5JARMJD72/2eFsS/3bmUEsdkE1CVu3PjJ
	DGKLCJhJHGz9w97FyMXBLPCRSWL19w4WkISwQIDEkdZmsGYWAVWJ241nwJp5BUwlJp6eyQIx
	VF5i9YYDYIM4gQbt3HYKrF4IqObF7MlsIEMlBJrZJd5f3s0M0SApcXDFDZYJjLwLGBlWMQpl
	5pXlJmbmmOhlVOZlVugl5+duYgTGw7LaP9E7GD9dCD7EKMDBqMTDe6L8cKoQa2JZcWXuIUYJ
	DmYlEV6zHQdShXhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBK
	NTCKF61wktiiEf395IUrt657vQ5Oe3t1QRl3RVXvm5LSHWXhd7d4bpskdTtn4Q/3Oxx2H9IK
	1ugW3w85vO+9y2JN+WpuhgUX0xdfqCnesCMyIdth6xYOO4drF+5vF/y5+8DpzeGOs3pUTy5b
	USd2YuWx+6w2JeqVrr/Fdurrvj//+NvJDVFRa/WtlViKMxINtZiLihMBNpCA8oMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrMtdciTV4PUrMYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8Sc7j
	3fy3bAECUVw2Kak5mWWpRfp2CVwZXW3/2QqmqlT83mTVwLhftouRk0NCwETicu9WRhCbTUBd
	4saNn8wgtoiAmcTB1j/sXYxcHMwCH5kkVn/vYAFJCAsESBxpbWYFsVkEVCVuN54Ba+YVMJWY
	eHomC8RQeYnVGw6ADeIEGrRz2ymweiGgmhezJ7NNYORawMiwilEkM68sNzEzx1SvODujMi+z
	Qi85P3cTIzC4l9X+mbiD8ctl90OMAhyMSjy8J8oPpwqxJpYVV+YeYpTgYFYS4TXbcSBViDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgbFAmtFb6Hr81b3/
	kk53HOzf6fH6/K6CgIjdHJf5br+stGBccGvCGnHFB4HnT2p/3bvLg+ugQP7kCa+vnWA4szjB
	ZU5w6qyXe3dxHNpzd0/B780s1TKnV3Tymu15N/nYvfWzjFtrtz8r3PRXuPtTVVFn2aN7krL2
	X1UY1Uumqu8vP6Uhcy15x7SPSizFGYmGWsxFxYkAeC9GyWoCAAA=
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


