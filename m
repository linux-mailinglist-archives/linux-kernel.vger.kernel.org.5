Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B401F7A9787
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjIURZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjIURYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:24:42 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBE337BFD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:13:26 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6c0cb43abc4so1433522a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695316403; x=1695921203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3167ObCwuPGy0ykS2mGpCnZZz/lnDX5wo2e/FWfZcMc=;
        b=3bJacgBp4Te45COTN/63YnwW2ThWDUiUSqS68AkJMwx0SnL4g9teCVUUJfOACEIzLJ
         UgtbNCB8IBx/KoOCG4gwe0E//Mdtg/1RpE8Xp3wZBNBimpJNkxqV3jO7FjJtsjHDrZXs
         83LY8klGUy3u0UPAxhQqPC+PO/P+Q1TZpZtFeDHhN5WZRUt1gtWYIqB6P3Zh8JE96pI0
         8VJ8RA7JXB0NjTqcdfKrdYvZZB/JdcxtNi7U3J6bQGB1MHEHEY7q0qcNEH1pPvVIyxNC
         VRFjI+xsM/uodmpl7kGuf18z+yq9kODcV91SJKP+TC8F0jNSC1by+liMjbCBU+BXS6OM
         P83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316403; x=1695921203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3167ObCwuPGy0ykS2mGpCnZZz/lnDX5wo2e/FWfZcMc=;
        b=XM0ZT8E/jvG9moIJXk4g7HQabLwCfd3kgSBJkwTHnHyPJ+6DQZ4cPWfODGtgWLajW+
         4nuJSdBZZmrCwMNy2pnL0INNmgjcH8blq0W3HQQ3qFvkxZ8ocnmFz8kV5OlgP0Xjt8/c
         CcYc8S4+SxB4vrpbk7FM7lWAzycEQEZ+9sf0yl6YBrQVdj1d6JIrc6FgnX0rpQjkeoJS
         Tce8TkCUmXsV/1zr+XVDmqNqNH0tWkDaBRyYDSqboIR4aAMBZkj+KJYuqvbBba6tjkic
         /aLGgl8BI2Pn6N5hzEtSFkJ8S0RG2nY3rx7Refb+eNca72hZQPLAswel/ZBweUwjEfLs
         w30w==
X-Gm-Message-State: AOJu0YwBOL/FOReaw5bp98Fe/SF68j2JT9aPSOnEzRHDUE1yKsWeYJU6
        e/5n305zq9rgA8AWcRz0BpBSGHZOmTeuRMuF
X-Google-Smtp-Source: AGHT+IEJ4fcoyEGYjUXnEO4k8S62qHUkVPnBwaKgs95Sypxteexrw0RSMgrAyDrgXkVHLcy4yrd/Nrxvhz1akcJT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:e0c5:0:b0:d78:28d0:15bc with SMTP
 id x188-20020a25e0c5000000b00d7828d015bcmr99461ybg.4.1695283870798; Thu, 21
 Sep 2023 01:11:10 -0700 (PDT)
Date:   Thu, 21 Sep 2023 08:10:57 +0000
In-Reply-To: <20230921081057.3440885-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230921081057.3440885-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921081057.3440885-6-yosryahmed@google.com>
Subject: [PATCH 5/5] mm: memcg: restore subtree stats flushing
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stats flushing for memcg currently follows the following rules:
- Always flush the entire memcg hierarchy (i.e. flush the root).
- Only one flusher is allowed at a time. If someone else tries to flush
  concurrently, they skip and return immediately.
- A periodic flusher flushes all the stats every 2 seconds.

The reason this approach is followed is because all flushes are
serialized by a global rstat spinlock. On the memcg side, flushing is
invoked from userspace reads as well as in-kernel flushers (e.g.
reclaim, refault, etc). This approach aims to avoid serializing all
flushers on the global lock, which can cause a significant performance
hit under high concurrency.

This approach has the following problems:
- Occasionally a userspace read of the stats of a non-root cgroup will
  be too expensive as it has to flush the entire hierarchy [1].
- Sometimes the stats accuracy are compromised if there is an ongoing
  flush, and we skip and return before the subtree of interest is
  actually flushed, yielding stale stats (by up to 2s due to periodic
  flushing). This is more visible when reading stats from userspace,
  but can also affect in-kernel flushers.

The latter problem is particulary a concern when userspace reads stats
after an event occurs, but gets stats from before the event. Examples:
- When memory usage / pressure spikes, a userspace OOM handler may look
  at the stats of different memcgs to select a victim based on various
  heuristics (e.g. how much private memory will be freed by killing
  this). Reading stale stats from before the usage spike in this case
  may cause a wrongful OOM kill.
- A proactive reclaimer may read the stats after writing to
  memory.reclaim to measure the success of the reclaim operation. Stale
  stats from before reclaim may give a false negative.
- Reading the stats of a parent and a child memcg may be inconsistent
  (child larger than parent), if the flush doesn't happen when the
  parent is read, but happens when the child is read.

As for in-kernel flushers, they will occasionally get stale stats. No
regressions are currently known from this, but if there are regressions,
they would be very difficult to debug and link to the source of the
problem.

This patch aims to fix these problems by restoring subtree flushing,
and removing the unified/coalesced flushing logic that skips flushing if
there is an ongoing flush. This change would introduce a significant
regression with global stats flushing thresholds. With per-memcg stats
flushing thresholds, this seems to perform really well. The thresholds
protect the underlying lock from unnecessary contention.

Add a mutex to protect the underlying rstat lock from excessive memcg
flushing. The thresholds are re-checked after the mutex is grabbed to
make sure that a concurrent flush did not already get the subtree we are
trying to flush. A call to cgroup_rstat_flush() is not cheap, even if
there are no pending updates.

This patch was tested in two ways to ensure the latency of flushing is
up to bar, on a machine with 384 cpus:
- A synthetic test with 5000 concurrent workers in 500 cgroups doing
  allocations and reclaim, as well as 1000 readers for memory.stat
  (variation of [2]). No regressions were noticed in the total runtime.
  Note that significant regressions in this test are observed with
  global stats thresholds, but not with per-memcg thresholds.

- A synthetic stress test for concurrently reading memcg stats while
  memory allocation/freeing workers are running in the background,
  provided by Wei Xu [3]. With 250k threads reading the stats every
  100ms in 50k cgroups, 99.9% of reads take <= 50us. Less than 0.01%
  of reads take more than 1ms, and no reads take more than 100ms.

[1] https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |  8 ++---
 mm/memcontrol.c            | 73 +++++++++++++++++++++++---------------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            | 10 ++++--
 4 files changed, 56 insertions(+), 37 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 45d0c10e86cc..1b61a2707307 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1030,8 +1030,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
-void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_ratelimited(void);
+void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
+void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
@@ -1520,11 +1520,11 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
-static inline void mem_cgroup_flush_stats(void)
+static inline void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
 }
 
-static inline void mem_cgroup_flush_stats_ratelimited(void)
+static inline void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c273c65bb642..99cfba81684f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -666,7 +666,6 @@ struct memcg_vmstats {
  */
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
-static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
 static u64 flush_last_time;
 
 #define FLUSH_TIME (2UL*HZ)
@@ -727,35 +726,45 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(void)
+static void do_flush_stats(struct mem_cgroup *memcg)
 {
-	/*
-	 * We always flush the entire tree, so concurrent flushers can just
-	 * skip. This avoids a thundering herd problem on the rstat global lock
-	 * from memcg flushers (e.g. reclaim, refault, etc).
-	 */
-	if (atomic_read(&stats_flush_ongoing) ||
-	    atomic_xchg(&stats_flush_ongoing, 1))
-		return;
-
-	WRITE_ONCE(flush_last_time, jiffies_64);
-
-	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+	if (mem_cgroup_is_root(memcg))
+		WRITE_ONCE(flush_last_time, jiffies_64);
 
-	atomic_set(&stats_flush_ongoing, 0);
+	cgroup_rstat_flush(memcg->css.cgroup);
 }
 
-void mem_cgroup_flush_stats(void)
+/*
+ * mem_cgroup_flush_stats - flush the stats of a memory cgroup subtree
+ * @memcg: root of the subtree to flush
+ *
+ * Flushing is serialized by the underlying global rstat lock. There is also a
+ * minimum amount of work to be done even if there are no stat updates to flush.
+ * Hence, we only flush the stats if the updates delta exceeds a threshold. This
+ * avoids unnecessary work and contention on the underlying lock.
+ */
+void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
-	if (memcg_should_flush_stats(root_mem_cgroup))
-		do_flush_stats();
+	static DEFINE_MUTEX(memcg_stats_flush_mutex);
+
+	if (!memcg)
+		memcg = root_mem_cgroup;
+
+	if (!memcg_should_flush_stats(memcg))
+		return;
+
+	mutex_lock(&memcg_stats_flush_mutex);
+	/* An overlapping flush may have occurred, check again after locking */
+	if (memcg_should_flush_stats(memcg))
+		do_flush_stats(memcg);
+	mutex_unlock(&memcg_stats_flush_mutex);
 }
 
-void mem_cgroup_flush_stats_ratelimited(void)
+void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 {
 	/* Only flush if the periodic flusher is one full cycle late */
 	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
-		mem_cgroup_flush_stats();
+		mem_cgroup_flush_stats(memcg);
 }
 
 static void flush_memcg_stats_dwork(struct work_struct *w)
@@ -764,7 +773,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Deliberately ignore memcg_should_flush_stats() here so that flushing
 	 * in latency-sensitive paths is as cheap as possible.
 	 */
-	do_flush_stats();
+	do_flush_stats(root_mem_cgroup);
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
@@ -1593,7 +1602,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	 *
 	 * Current memory state:
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -4035,7 +4044,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -4116,7 +4125,7 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4613,7 +4622,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
@@ -6640,7 +6649,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
@@ -7806,7 +7815,11 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 			break;
 		}
 
-		cgroup_rstat_flush(memcg->css.cgroup);
+		/*
+		 * mem_cgroup_flush_stats() ignores small changes. Use
+		 * do_flush_stats() directly to get accurate stats for charging.
+		 */
+		do_flush_stats(memcg);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
@@ -7871,8 +7884,10 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
-	cgroup_rstat_flush(css->cgroup);
-	return memcg_page_state(mem_cgroup_from_css(css), MEMCG_ZSWAP_B);
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	mem_cgroup_flush_stats(memcg);
+	return memcg_page_state(memcg, MEMCG_ZSWAP_B);
 }
 
 static int zswap_max_show(struct seq_file *m, void *v)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a4e44f1c97c1..60bead17b1f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2246,7 +2246,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(sc->target_mem_cgroup);
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
diff --git a/mm/workingset.c b/mm/workingset.c
index 79b338996088..141defbe3da2 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -461,8 +461,12 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	css_get(&eviction_memcg->css);
 	rcu_read_unlock();
 
-	/* Flush stats (and potentially sleep) outside the RCU read section */
-	mem_cgroup_flush_stats_ratelimited();
+	/*
+	 * Flush stats (and potentially sleep) outside the RCU read section.
+	 * XXX: With per-memcg flushing and thresholding, is ratelimiting
+	 * still needed here?
+	 */
+	mem_cgroup_flush_stats_ratelimited(eviction_memcg);
 
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
@@ -673,7 +677,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		struct lruvec *lruvec;
 		int i;
 
-		mem_cgroup_flush_stats();
+		mem_cgroup_flush_stats(sc->memcg);
 		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
 			pages += lruvec_page_state_local(lruvec,
-- 
2.42.0.459.ge4e396fd5e-goog

