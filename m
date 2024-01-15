Return-Path: <linux-kernel+bounces-25719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5070982D4F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B461F218FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB0EE55E;
	Mon, 15 Jan 2024 08:20:17 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BF9C132
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-95-65a4eab45f59
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
Subject: [PATCH v6 7/7] mm: Pause migrc mechanism at high memory pressure
Date: Mon, 15 Jan 2024 17:19:53 +0900
Message-Id: <20240115081953.2521-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240115081953.2521-1-byungchul@sk.com>
References: <20240115081953.2521-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsXC9ZZnoe6WV0tSDV5cVbeYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovrux4yWhzvPcBk
	Mf/eZzaLzZumMlscnzKV0eL3D6COk7MmszgIenxv7WPx2DnrLrvHgk2lHptXaHks3vOSyWPT
	qk42j02fJrF7vDt3jt3jxIzfLB7zTgZ6vN93lc1j6y87j8ap19g8Pm+S83g3/y1bAH8Ul01K
	ak5mWWqRvl0CV8b5NZOZC24oVzxu3cjawNgh28XIySEhYCIxrWkJK4zd0HKLGcRmE1CXuHHj
	J5gtImAmcbD1D3sXIxcHs8BHJonV3ztYQBLCAp4SPQu3MoLYLAKqEhPetIHFeYEGzfzyngli
	qLzE6g0HwAZxCphKvPt4nB3EFgKqabm7jhVkqIRAM7vE0vP9bBANkhIHV9xgmcDIu4CRYRWj
	UGZeWW5iZo6JXkZlXmaFXnJ+7iZGYEQsq/0TvYPx04XgQ4wCHIxKPLw//i5OFWJNLCuuzD3E
	KMHBrCTCW31nSaoQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYO
	TqkGRs+pWc4KGU5aTx5lljxscJr4MEDDk9V/VXL8lfwTG5doHPjBdmv3Ydu5DFc5mlWORsfz
	PZv1OpO1QnHh19VXXTtm+6RH3N7rcOKCU5qP3mu30y9XWW47fKjctHNdquGKbeLdWy6+bd/Q
	9dlnxtW7qx7q9ezsnVYwI7LA3PCJltDDrlWJD1yUHiuxFGckGmoxFxUnAgAEz+8chAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXC5WfdrLvl1ZJUg+5NUhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgyzq+ZzFxwQ7nicetG1gbGDtkuRk4OCQETiYaWW8wgNpuA
	usSNGz/BbBEBM4mDrX/Yuxi5OJgFPjJJrP7ewQKSEBbwlOhZuJURxGYRUJWY8KYNLM4LNGjm
	l/dMEEPlJVZvOAA2iFPAVOLdx+PsILYQUE3L3XWsExi5FjAyrGIUycwry03MzDHVK87OqMzL
	rNBLzs/dxAgM72W1fybuYPxy2f0QowAHoxIP74+/i1OFWBPLiitzDzFKcDArifBW31mSKsSb
	klhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cC47ufENp675cE3
	ReXfOTiEHTobu9Z2q05YxfvIsGfMtadztlRtuL9Kyv3IjYRiec5fnpJ/1tee75gS/efcq0lB
	cWomzS6HnwfwVwn7NqT4Tg5ZVfhycap6vpr7DNWtnheLf4Ztf768Yu/DgMVvBCZN5X2ozy5S
	+Cpe2+V2a9El873Sl/2PTexUYinOSDTUYi4qTgQA60wLeWsCAAA=
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
index 5b93e5abf953..7643ccb7c156 100644
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
@@ -1330,6 +1347,9 @@ bool migrc_flush_free_folios(void);
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
index da4d43ac2622..b838f279f050 100644
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


