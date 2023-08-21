Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7477783461
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjHUUzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjHUUzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:55:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C77A1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:55:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cf4cb742715so4778697276.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692651318; x=1693256118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvdq61L+aFGdt8QKKpNnJHBdE39S0UeYM1yvvHjD3xQ=;
        b=gDjS77jh86r8ZKs1/zKg7Cco96sopZmFLEz/zj9xB/n1q5vx7rO/YHELKGS+X9Ug4U
         YpGS8y0oXx1+lQOuCRWO4hJaQzYd+MTroVbrUvtNf91m8TASXjyJIAiKKFjFs2SvbEMF
         ETcYXj5DRyAg6uMI1Tg+PNCmWCLVT4wh3IA7ElB0FC39nvwl0DxqHUQMVF3L6VZeLxWD
         Igvb6FKlgK7kbWdQtRC2tXSUf35syDuAtXUdPI50X7vL1Y+pprzowUj3JjDeaCVIeOGE
         KhQl4U7drhKa+h5IQMVK0nmZmAfMy/Kou0T2fowQemhM6iwR2fCYPTNirZnXMfkhAzuf
         7vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692651318; x=1693256118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvdq61L+aFGdt8QKKpNnJHBdE39S0UeYM1yvvHjD3xQ=;
        b=I68YXwhp15eApD443+o2kWvgb1ZMm6wh5GLyMqqE1TB/hoz+T/HTC10fLiQ0hktUpQ
         m8gy784RXLl0B4rsOt8PXbrPSPh6m6aWwGK+CKqK8cE8Y2T11uMso6lQMmdS1rgadopk
         pgpiRcNhVYuskZB0rD+3Z3TiJ1SsutS9OeCdL7ho0ZKR7RO5IUSskMzYAVEFdEO0CQCI
         g5rIQgh8/kVE6mMozByXiTaW9Fw7SMIJLdq3V2AzYAEQabrvYkDP24TepTncbnPc56uw
         zV+y4ZnMXz97mZxe1meY6MD2/4XgbpMVGN7vdojCR8W3r8z+ZOVXaybORIeVQJxW5ek/
         lCLA==
X-Gm-Message-State: AOJu0YwR3/EQSxYjDo7t7hrhIioy7Dms3+9v7ppuCCNts42lXEoOBxj1
        blgvhFfxfmgpMP+B/xZOU69WyWG9rAL2+Fnf
X-Google-Smtp-Source: AGHT+IHI17WgDLA9h5213qI/4QCn9pZF+BZYijIyegDPoTXjNDSTPJibwpZtlmJmIAbTjzp62J1FhYw7o02Y6LmV
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:d604:0:b0:cf9:3564:33cc with SMTP
 id n4-20020a25d604000000b00cf9356433ccmr61637ybg.13.1692651318564; Mon, 21
 Aug 2023 13:55:18 -0700 (PDT)
Date:   Mon, 21 Aug 2023 20:54:56 +0000
In-Reply-To: <20230821205458.1764662-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821205458.1764662-2-yosryahmed@google.com>
Subject: [PATCH 1/3] mm: memcg: properly name and document unified stats flushing
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most contexts that flush memcg stats use "unified" flushing, where
basically all flushers attempt to flush the entire hierarchy, but only
one flusher is allowed at a time, others skip flushing.

This is needed because we need to flush the stats from paths such as
reclaim or refaults, which may have high concurrency, especially on
large systems. Serializing such performance-sensitive paths can
introduce regressions, hence, unified flushing offers a tradeoff between
stats staleness and the performance impact of flushing stats.

Document this properly and explicitly by renaming the common flushing
helper from do_flush_stats() to do_unified_stats_flush(), and adding
documentation to describe unified flushing. Additionally, rename
flushing APIs to add "try" in the name, which implies that flushing will
not always happen. Also add proper documentation.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |  8 +++---
 mm/memcontrol.c            | 53 ++++++++++++++++++++++++++------------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            |  4 +--
 4 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 11810a2cfd2d..d517b0cc5221 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1034,8 +1034,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
-void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_ratelimited(void);
+void mem_cgroup_try_flush_stats(void);
+void mem_cgroup_try_flush_stats_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
@@ -1519,11 +1519,11 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
-static inline void mem_cgroup_flush_stats(void)
+static inline void mem_cgroup_try_flush_stats(void)
 {
 }
 
-static inline void mem_cgroup_flush_stats_ratelimited(void)
+static inline void mem_cgroup_try_flush_stats_ratelimited(void)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cf57fe9318d5..c6150ea54d48 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -630,7 +630,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 		/*
 		 * If stats_flush_threshold exceeds the threshold
 		 * (>num_online_cpus()), cgroup stats update will be triggered
-		 * in __mem_cgroup_flush_stats(). Increasing this var further
+		 * in mem_cgroup_try_flush_stats(). Increasing this var further
 		 * is redundant and simply adds overhead in atomic update.
 		 */
 		if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
@@ -639,13 +639,17 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(void)
+/*
+ * do_unified_stats_flush - do a unified flush of memory cgroup statistics
+ *
+ * A unified flush tries to flush the entire hierarchy, but skips if there is
+ * another ongoing flush. This is meant for flushers that may have a lot of
+ * concurrency (e.g. reclaim, refault, etc), and should not be serialized to
+ * avoid slowing down performance-sensitive paths. A unified flush may skip, and
+ * hence may yield stale stats.
+ */
+static void do_unified_stats_flush(void)
 {
-	/*
-	 * We always flush the entire tree, so concurrent flushers can just
-	 * skip. This avoids a thundering herd problem on the rstat global lock
-	 * from memcg flushers (e.g. reclaim, refault, etc).
-	 */
 	if (atomic_read(&stats_flush_ongoing) ||
 	    atomic_xchg(&stats_flush_ongoing, 1))
 		return;
@@ -658,16 +662,31 @@ static void do_flush_stats(void)
 	atomic_set(&stats_flush_ongoing, 0);
 }
 
-void mem_cgroup_flush_stats(void)
+/*
+ * mem_cgroup_try_flush_stats - try to flush memory cgroup statistics
+ *
+ * Try to flush the stats of all memcgs that have stat updates since the last
+ * flush. We do not flush the stats if:
+ * - The magnitude of the pending updates is below a certain threshold.
+ * - There is another ongoing unified flush (see do_unified_stats_flush()).
+ *
+ * Hence, the stats may be stale, but ideally by less than FLUSH_TIME due to
+ * periodic flushing.
+ */
+void mem_cgroup_try_flush_stats(void)
 {
 	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
-		do_flush_stats();
+		do_unified_stats_flush();
 }
 
-void mem_cgroup_flush_stats_ratelimited(void)
+/*
+ * Like mem_cgroup_try_flush_stats(), but only flushes if the periodic flusher
+ * is late.
+ */
+void mem_cgroup_try_flush_stats_ratelimited(void)
 {
 	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
-		mem_cgroup_flush_stats();
+		mem_cgroup_try_flush_stats();
 }
 
 static void flush_memcg_stats_dwork(struct work_struct *w)
@@ -676,7 +695,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Always flush here so that flushing in latency-sensitive paths is
 	 * as cheap as possible.
 	 */
-	do_flush_stats();
+	do_unified_stats_flush();
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
@@ -1576,7 +1595,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	 *
 	 * Current memory state:
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -4018,7 +4037,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -4093,7 +4112,7 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4595,7 +4614,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
@@ -6610,7 +6629,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c7c149cb8d66..457a18921fda 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2923,7 +2923,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
diff --git a/mm/workingset.c b/mm/workingset.c
index da58a26d0d4d..affb8699e58d 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -520,7 +520,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	}
 
 	/* Flush stats (and potentially sleep) before holding RCU read lock */
-	mem_cgroup_flush_stats_ratelimited();
+	mem_cgroup_try_flush_stats_ratelimited();
 
 	rcu_read_lock();
 
@@ -664,7 +664,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		struct lruvec *lruvec;
 		int i;
 
-		mem_cgroup_flush_stats();
+		mem_cgroup_try_flush_stats();
 		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
 			pages += lruvec_page_state_local(lruvec,
-- 
2.42.0.rc1.204.g551eb34607-goog

