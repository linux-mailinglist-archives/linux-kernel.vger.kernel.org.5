Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD8809C42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573228AbjLHGOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjLHGOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:14:12 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44541720
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:14:18 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ddd64f83a4so16397587b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702016058; x=1702620858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVLrJAGnIVd+3pf7kb6jXJD9XT/HKbFyDQ4DzyYCxV8=;
        b=DYMfm5eproKgtvufpK7UWF4bD5BIst+8BSRd4OIrXlzLFrW+BE4SangKzXmimaiMvU
         mhPWsiJi2CNur9lIL21AjXP+8mMRZ3olgR/DGFDMfasTqoaCil282hBIMrIrocOLfNfd
         Td9/+FHAKknL9PzG53MJ6nZUjz5sqVh0ZqL+KhHjMSFjLiJkbsk+Gr1mRhvjViEumZL6
         nCzeIf2h+08CS6q6STOPN1nPJojI4r+BtIohMd+qYEohNrtwgzRZBOExsjrbNwj06qj0
         w2jhn3Jquo0nNYJbHGVH3o8q+5rce0RHycxEsfggL3Qa1/pGdi4GO0chXzOVPjRToGnd
         RDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702016058; x=1702620858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVLrJAGnIVd+3pf7kb6jXJD9XT/HKbFyDQ4DzyYCxV8=;
        b=EC4rvbxu3jvXSWZ4i6t2H2DrkRzuOmzndyPwhsH+qYY4DhxTXG/dGeAkTYbgRqRtP9
         Q2jKy3cqYNjrKmwJQrfXk7pEfoOS6nMY4qeXfh137bXT6AQ93/Jzby3bUrZyoXbje8oQ
         G/q9lQA42ShVJaUqXQwsLHhLh3Yqiw6NVtvmc3Idb4veE8XiQCaIwH6TAWqAa8jBgw+l
         HRAfYLGFsvjDpxWIvEQv9E6m4S853prkMq1gitGx9oQ8krOqlFm+gimzcx6LVu6FDBCM
         MZ8PTZWuBdexCrfyoR8gldYHsqAjGbQK8DegPj9FG2kYwJPxQQY6h+aTuMVPcnUwNJJL
         lC5Q==
X-Gm-Message-State: AOJu0YzbgqPX1oUOez7culpXpraCi9ZCiG+ZNbIm7epWin1KQz0EQ8Zm
        /kMCqvS4lgP8d1s0H6b3x4AJP4AwBgg=
X-Google-Smtp-Source: AGHT+IEZAEdkcU44UW2VfipVvWCCbfA4P11A2km0xUAWfMA+F2bO2hVaznBKtFn6SfuvrT80lhXwHcrPs/o=
X-Received: from yuzhao2.bld.corp.google.com ([100.64.188.49]) (user=yuzhao
 job=sendgmr) by 2002:a81:af51:0:b0:5d7:1941:61d3 with SMTP id
 x17-20020a81af51000000b005d7194161d3mr44861ywj.9.1702016057776; Thu, 07 Dec
 2023 22:14:17 -0800 (PST)
Date:   Thu,  7 Dec 2023 23:14:06 -0700
In-Reply-To: <20231208061407.2125867-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208061407.2125867-3-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 3/4] mm/mglru: respect min_ttl_ms with memcgs
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>,
        "T . J . Mercier" <tjmercier@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While investigating kswapd "consuming 100% CPU" [1] (also see
"mm/mglru: try to stop at high watermarks"), it was discovered that
the memcg LRU can breach the thrashing protection imposed by
min_ttl_ms.

Before the memcg LRU:
  kswapd()
    shrink_node_memcgs()
      mem_cgroup_iter()
        inc_max_seq()  // always hit a different memcg
    lru_gen_age_node()
      mem_cgroup_iter()
        check the timestamp of the oldest generation

After the memcg LRU:
  kswapd()
    shrink_many()
      restart:
        iterate the memcg LRU:
          inc_max_seq()  // occasionally hit the same memcg
          if raced with lru_gen_rotate_memcg():
            goto restart
    lru_gen_age_node()
      mem_cgroup_iter()
        check the timestamp of the oldest generation

Specifically, when the restart happens in shrink_many(), it needs to
stick with the (memcg LRU) generation it began with. In other words,
it should neither re-read memcg_lru->seq nor age an lruvec of a
different generation. Otherwise it can hit the same memcg multiple
times without giving lru_gen_age_node() a chance to check the
timestamp of that memcg's oldest generation (against min_ttl_ms).

[1] https://lore.kernel.org/CAK8fFZ4DY+GtBA40Pm7Nn5xCHy+51w3sfxPqkqpqakSXYyX+Wg@mail.gmail.com/

Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: T.J. Mercier <tjmercier@google.com>
Cc: stable@vger.kernel.org
---
 include/linux/mmzone.h | 30 +++++++++++++++++-------------
 mm/vmscan.c            | 30 ++++++++++++++++--------------
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b23bc5390240..e3093ef9530f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -510,33 +510,37 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
  * the old generation, is incremented when all its bins become empty.
  *
  * There are four operations:
- * 1. MEMCG_LRU_HEAD, which moves an memcg to the head of a random bin in its
+ * 1. MEMCG_LRU_HEAD, which moves a memcg to the head of a random bin in its
  *    current generation (old or young) and updates its "seg" to "head";
- * 2. MEMCG_LRU_TAIL, which moves an memcg to the tail of a random bin in its
+ * 2. MEMCG_LRU_TAIL, which moves a memcg to the tail of a random bin in its
  *    current generation (old or young) and updates its "seg" to "tail";
- * 3. MEMCG_LRU_OLD, which moves an memcg to the head of a random bin in the old
+ * 3. MEMCG_LRU_OLD, which moves a memcg to the head of a random bin in the old
  *    generation, updates its "gen" to "old" and resets its "seg" to "default";
- * 4. MEMCG_LRU_YOUNG, which moves an memcg to the tail of a random bin in the
+ * 4. MEMCG_LRU_YOUNG, which moves a memcg to the tail of a random bin in the
  *    young generation, updates its "gen" to "young" and resets its "seg" to
  *    "default".
  *
  * The events that trigger the above operations are:
  * 1. Exceeding the soft limit, which triggers MEMCG_LRU_HEAD;
- * 2. The first attempt to reclaim an memcg below low, which triggers
+ * 2. The first attempt to reclaim a memcg below low, which triggers
  *    MEMCG_LRU_TAIL;
- * 3. The first attempt to reclaim an memcg below reclaimable size threshold,
+ * 3. The first attempt to reclaim a memcg below reclaimable size threshold,
  *    which triggers MEMCG_LRU_TAIL;
- * 4. The second attempt to reclaim an memcg below reclaimable size threshold,
+ * 4. The second attempt to reclaim a memcg below reclaimable size threshold,
  *    which triggers MEMCG_LRU_YOUNG;
- * 5. Attempting to reclaim an memcg below min, which triggers MEMCG_LRU_YOUNG;
+ * 5. Attempting to reclaim a memcg below min, which triggers MEMCG_LRU_YOUNG;
  * 6. Finishing the aging on the eviction path, which triggers MEMCG_LRU_YOUNG;
- * 7. Offlining an memcg, which triggers MEMCG_LRU_OLD.
+ * 7. Offlining a memcg, which triggers MEMCG_LRU_OLD.
  *
- * Note that memcg LRU only applies to global reclaim, and the round-robin
- * incrementing of their max_seq counters ensures the eventual fairness to all
- * eligible memcgs. For memcg reclaim, it still relies on mem_cgroup_iter().
+ * Notes:
+ * 1. Memcg LRU only applies to global reclaim, and the round-robin incrementing
+ *    of their max_seq counters ensures the eventual fairness to all eligible
+ *    memcgs. For memcg reclaim, it still relies on mem_cgroup_iter().
+ * 2. There are only two valid generations: old (seq) and young (seq+1).
+ *    MEMCG_NR_GENS is set to three so that when reading the generation counter
+ *    locklessly, a stale value (seq-1) does not wraparound to young.
  */
-#define MEMCG_NR_GENS	2
+#define MEMCG_NR_GENS	3
 #define MEMCG_NR_BINS	8
 
 struct lru_gen_memcg {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 10e964cd0efe..cac38e9cac86 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4117,6 +4117,9 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	else
 		VM_WARN_ON_ONCE(true);
 
+	WRITE_ONCE(lruvec->lrugen.seg, seg);
+	WRITE_ONCE(lruvec->lrugen.gen, new);
+
 	hlist_nulls_del_rcu(&lruvec->lrugen.list);
 
 	if (op == MEMCG_LRU_HEAD || op == MEMCG_LRU_OLD)
@@ -4127,9 +4130,6 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	pgdat->memcg_lru.nr_memcgs[old]--;
 	pgdat->memcg_lru.nr_memcgs[new]++;
 
-	lruvec->lrugen.gen = new;
-	WRITE_ONCE(lruvec->lrugen.seg, seg);
-
 	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
 		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
@@ -4152,11 +4152,11 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg)
 
 		gen = get_memcg_gen(pgdat->memcg_lru.seq);
 
+		lruvec->lrugen.gen = gen;
+
 		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[gen][bin]);
 		pgdat->memcg_lru.nr_memcgs[gen]++;
 
-		lruvec->lrugen.gen = gen;
-
 		spin_unlock_irq(&pgdat->memcg_lru.lock);
 	}
 }
@@ -4663,7 +4663,7 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool
 	DEFINE_MAX_SEQ(lruvec);
 
 	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg))
-		return 0;
+		return -1;
 
 	if (!should_run_aging(lruvec, max_seq, sc, can_swap, &nr_to_scan))
 		return nr_to_scan;
@@ -4738,7 +4738,7 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		cond_resched();
 	}
 
-	/* whether try_to_inc_max_seq() was successful */
+	/* whether this lruvec should be rotated */
 	return nr_to_scan < 0;
 }
 
@@ -4792,13 +4792,13 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 	struct lruvec *lruvec;
 	struct lru_gen_folio *lrugen;
 	struct mem_cgroup *memcg;
-	const struct hlist_nulls_node *pos;
+	struct hlist_nulls_node *pos;
 
+	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
 	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
 restart:
 	op = 0;
 	memcg = NULL;
-	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
 
 	rcu_read_lock();
 
@@ -4809,6 +4809,10 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 		}
 
 		mem_cgroup_put(memcg);
+		memcg = NULL;
+
+		if (gen != READ_ONCE(lrugen->gen))
+			continue;
 
 		lruvec = container_of(lrugen, struct lruvec, lrugen);
 		memcg = lruvec_memcg(lruvec);
@@ -4893,16 +4897,14 @@ static void set_initial_priority(struct pglist_data *pgdat, struct scan_control
 	if (sc->priority != DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU_BATCH)
 		return;
 	/*
-	 * Determine the initial priority based on ((total / MEMCG_NR_GENS) >>
-	 * priority) * reclaimed_to_scanned_ratio = nr_to_reclaim, where the
-	 * estimated reclaimed_to_scanned_ratio = inactive / total.
+	 * Determine the initial priority based on
+	 * (total >> priority) * reclaimed_to_scanned_ratio = nr_to_reclaim,
+	 * where reclaimed_to_scanned_ratio = inactive / total.
 	 */
 	reclaimable = node_page_state(pgdat, NR_INACTIVE_FILE);
 	if (get_swappiness(lruvec, sc))
 		reclaimable += node_page_state(pgdat, NR_INACTIVE_ANON);
 
-	reclaimable /= MEMCG_NR_GENS;
-
 	/* round down reclaimable and round up sc->nr_to_reclaim */
 	priority = fls_long(reclaimable) - 1 - fls_long(sc->nr_to_reclaim - 1);
 
-- 
2.43.0.472.g3155946c3a-goog

