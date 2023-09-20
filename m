Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847337A8C36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjITTDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjITTDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:03:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83CBCA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690d2e13074so115082b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695236584; x=1695841384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ouvC9AOz3I+aujxy3BgYZwvGJPKjc3/8uuxzUuwqOFg=;
        b=nkUotcJqL+cOwV30t5+g9WT4P9W2YD2QxJHzy3MjAVmT+18LzIFonEicCtjzGrLui9
         DSQK5WGoX8/znIgiZB/gPpyYZdTD+H1wyygdL+NMK/3fmnUTgrmlvk/eT0ovj5HY7BFN
         984M0q7Sh20JVhI6Quj+LqO/CWBmmP2H9Nt8JkuoXlWteb9+hYKcE+1p35GRUNjL4G5m
         BV0s2p6g9nlLAiFPJUrvEaARJsrjgPq0Kn5MgLZrbhsRd4393EHECT7aRSwknrFxFmMF
         FE6STDXzPo7IiyynXg6c6WIWplQKyOwS07DeSN574Yhz8Q2dKu4MWextM/scz2Z187f7
         05LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695236584; x=1695841384;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouvC9AOz3I+aujxy3BgYZwvGJPKjc3/8uuxzUuwqOFg=;
        b=XQSn0ug4avlutT036Sm1DNIxiHPuK+qVPfA7Q7MatXW1xAjIOsLCPoqLI+nEJfDvgw
         I4Ik+O9GJjpuaRefRmCOpUcpYz77TBdbEDPJzw48VMScHqbIS7Nat4A97TE2kFEZo8oO
         LYAmG71IWriUUP/EM0FhuGV/G25ClEF+q92rwls3oZnNCHhpEGo/MZEboNki33eR5ofO
         qe596a5e2bB4VtBBOaet3QxAPU4VVbx5tBD4BQZAeJVQ2ajYoI7R3zRnTGpaighvhlqJ
         16KYGn9HDvXVCvc0LMqqB+lrnboFjPa7JPjr7ILcg8bie1n/ctYcUIBMX1E7+mboZDol
         f4bg==
X-Gm-Message-State: AOJu0Yy28iC7tX9Nd7J2PDhzB9MvWj9hAgRQZetGbmr4UotWHOSDimCC
        A9YgBYiHbA6fzOa+De9AjCw=
X-Google-Smtp-Source: AGHT+IHpkXwDW7wLHkw9/gwS4e48YtJ5+qZf0n+vVOPD7mH5dU+NucT1NkWU/2VMS3T4gOkfxVuwEg==
X-Received: by 2002:a05:6a20:8402:b0:153:78c1:c40f with SMTP id c2-20020a056a20840200b0015378c1c40fmr4054957pzd.15.1695236583894;
        Wed, 20 Sep 2023 12:03:03 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([124.127.145.18])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006871fdde2c7sm423935pfa.110.2023.09.20.12.03.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Sep 2023 12:03:03 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Yuanchu Xie <yuanchu@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH v3 1/6] workingset: simplify and use a more intuitive model
Date:   Thu, 21 Sep 2023 03:02:39 +0800
Message-ID: <20230920190244.16839-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920190244.16839-1-ryncsn@gmail.com>
References: <20230920190244.16839-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

This basically removed workingset_activation and reduced calls to
workingset_age_nonresident.

The idea behind this change is a new way to calculate the refault
distance and prepare for adapting refault distance based re-activation
for multi-gen LRU.

Currently, refault distance re-activation is based on two assumptions:
1. Activation of an inactive page will left-shift LRU pages (considering
   LRU starts from right).
2. Eviction of an inactive page will left-shift LRU pages.

Assumption 2 is correct, but assumption 1 is not always true, an activated
page could be anywhere in the LRU list (through mark_page_accessed), it
only left-shift the pages on its right.

And besides, one page can get activate/deactivated for multiple times.

And multi-gen LRU doesn't fit with this model well, pages are getting
aged and activated constantly as the generation sliding window slides.

So instead we introduce a simpler idea here: Just presume the evicted
pages are still in memory, each has an eviction sequence like before.
Let the `nonresistence_age` still be NA and get increased for each
eviction, so we get a "Shadow LRU" here of one evicted page:

  Let SP = ((NA's reading @ current) - (NA's reading @ eviction))

                           +-memory available to cache-+
                           |                           |
 +-------------------------+===============+===========+
 | *   shadows  O O  O     |   INACTIVE    |   ACTIVE  |
 +-+-----------------------+===============+===========+
   |                       |
   +-----------------------+
   |         SP
 fault page          O -> Hole left by previously faulted in pages
                     * -> The page corresponding to SP

It can be easily seen that SP stands for how far the current workflow
could push a page out of available memory. Since all evicted page was
once head of INACTIVE list, the page could have such an access distance:

  SP + NR_INACTIVE

It *may* get re-activated before getting evicted again if:

  SP + NR_INACTIVE < NR_INACTIVE + NR_ACTIVE

Which can be simplified to:

  SP < NR_ACTIVE

Then the page is worth getting re-activated to start from ACTIVE part,
since the access distance is shorter than the total memory to make it
stay.

And since this is only an estimation, based on several hypotheses, and
it could break the ability of LRU to distinguish a workingset out of
caches, so throttle this by two factors:

1. Notice previously re-faulted in pages may leave "holes" on the shadow
   part of LRU, that part is left unhandled on purpose to decrease
   re-activate rate for pages that have a large SP value (the larger
   SP value a page has, the more likely it will be affected by such
   holes).
2. When the ACTIVE part of LRU is long enough, chanllaging ACTIVE pages
   by re-activating a one-time faulted previously INACTIVE page may not
   be a good idea, so throttle the re-activation when ACTIVE > INACTIVE
   by comparing with INACTIVE instead.

Another effect of the refault activation worth noticing is that, by
throttling reactivation when ACTIVE part is high, this refault distance
based re-activation can help hold a portion of the caches in memory
instead of letting cached get evicted permutably when the cache size is
larger than total memory, and hotness is similar among all cache pages.
That's because the established workingset (ACTIVE part) will tend to stay
since we throttled reactivation, until the workingset itself start to stall.

This is actually similar with the algoritm before, which introduce such
effect by increasing nonresistence_age in many call paths, trottled
the reactivation when activition/reactivation is massively happenning.

Combined all above, we have:
Upon refault, if any of following conditions is met, mark page as active:

- If ACTIVE LRU is low (NR_ACTIVE < NR_INACTIVE), check if:
  SP < NR_ACTIVE

- If ACTIVE LRU is high (NR_ACTIVE >= NR_INACTIVE), check if:
  SP < NR_INACTIVE

Code-wise, this is simpler than before since no longer need to do lruvec
statistic update when activating a page, and so far, a few benchmarks shows
a similar or better result. And when combined with multi-gen LRU (in
later commits) it shows a measurable performance gain for some workloads.

Using memtier and fio test from commit ac35a4902374 but scaled down
to fit in my test environment, and some other test results:

  memtier test (with 16G ramdisk as swap and 4G memcg limit on an i7-9700):
  memcached -u nobody -m 16384 -s /tmp/memcached.socket \
    -a 0766 -t 12 -B binary &
  memtier_benchmark -S /tmp/memcached.socket -P memcache_binary -n allkeys\
    --key-minimum=1 --key-maximum=32000000 --key-pattern=P:P -c 1 \
    -t 12 --ratio 1:0 --pipeline 8 -d 2000 -x 6

  fio test 1 (with 16G ramdisk on 28G VM on an i7-9700):
  fio -name=refault --numjobs=12 --directory=/mnt --size=1024m \
    --buffered=1 --ioengine=io_uring --iodepth=128 \
    --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
    --rw=randread --random_distribution=random --norandommap \
    --time_based --ramp_time=5m --runtime=5m --group_reporting

  fio test 2 (with 16G ramdisk on 28G VM on an i7-9700):
  fio -name=mglru --numjobs=10 --directory=/mnt --size=1536m \
    --buffered=1 --ioengine=io_uring --iodepth=128 \
    --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
    --rw=randread --random_distribution=zipf:1.2 --norandommap \
    --time_based --ramp_time=10m --runtime=5m --group_reporting

  mysql (using oltp_read_only from sysbench, with 12G of buffer pool
  in a 10G memcg):
  sysbench /usr/share/sysbench/oltp_read_only.lua <auth and db params> \
    --tables=36 --table-size=2000000 --threads=12 --time=1800

  kernel build test done with 3G memcg limit on an i7-9700.

Before (Average of 6 test run):
fio: IOPS=5125.5k
fio2: IOPS=7291.16k
memcached: 57600.926 ops/s
mysql: 6491.5 tps
kernel-build: 1817.13499 seconds

After (Average of 6 test run):
fio: IOPS=5137.5k
fio2: IOPS=7300.67k
memcached: 57878.422 ops/s
mysql: 6491.1 tps
kernel-build: 1813.66231 seconds

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   2 -
 mm/swap.c            |   1 -
 mm/vmscan.c          |   2 -
 mm/workingset.c      | 155 ++++++++++++++++++-------------------------
 4 files changed, 64 insertions(+), 96 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 493487ed7c38..ca51d79842b7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -344,10 +344,8 @@ static inline swp_entry_t page_swap_entry(struct page *page)
 
 /* linux/mm/workingset.c */
 bool workingset_test_recent(void *shadow, bool file, bool *workingset);
-void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
 void workingset_refault(struct folio *folio, void *shadow);
-void workingset_activation(struct folio *folio);
 
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..685b446fd4f9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -482,7 +482,6 @@ void folio_mark_accessed(struct folio *folio)
 		else
 			__lru_cache_activate_folio(folio);
 		folio_clear_referenced(folio);
-		workingset_activation(folio);
 	}
 	if (folio_test_idle(folio))
 		folio_clear_idle(folio);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..3f4de75e5186 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2539,8 +2539,6 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 		lruvec_add_folio(lruvec, folio);
 		nr_pages = folio_nr_pages(folio);
 		nr_moved += nr_pages;
-		if (folio_test_active(folio))
-			workingset_age_nonresident(lruvec, nr_pages);
 	}
 
 	/*
diff --git a/mm/workingset.c b/mm/workingset.c
index da58a26d0d4d..8613945fc66e 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -64,74 +64,64 @@
  * thrashing on the inactive list, after which refaulting pages can be
  * activated optimistically to compete with the existing active pages.
  *
- * Approximating inactive page access frequency - Observations:
+ * For such approximation, we introduce a counter `nonresistence_age` (NA)
+ * here. This counter increases each time a page is evicted, and each evicted
+ * page will have a shadow that stores the counter reading at the eviction
+ * time as a timestamp. So when an evicted page was faulted again, we have:
  *
- * 1. When a page is accessed for the first time, it is added to the
- *    head of the inactive list, slides every existing inactive page
- *    towards the tail by one slot, and pushes the current tail page
- *    out of memory.
+ *   Let SP = ((NA's reading @ current) - (NA's reading @ eviction))
  *
- * 2. When a page is accessed for the second time, it is promoted to
- *    the active list, shrinking the inactive list by one slot.  This
- *    also slides all inactive pages that were faulted into the cache
- *    more recently than the activated page towards the tail of the
- *    inactive list.
+ *                            +-memory available to cache-+
+ *                            |                           |
+ *  +-------------------------+===============+===========+
+ *  | *   shadows  O O  O     |   INACTIVE    |   ACTIVE  |
+ *  +-+-----------------------+===============+===========+
+ *    |                       |
+ *    +-----------------------+
+ *    |         SP
+ *  fault page          O -> Hole left by previously faulted in pages
+ *                      * -> The page corresponding to SP
  *
- * Thus:
+ * Here SP can stands for how far the current workflow could push a page
+ * out of available memory. Since all evicted page was once head of
+ * INACTIVE list, the page could have such an access distance of:
  *
- * 1. The sum of evictions and activations between any two points in
- *    time indicate the minimum number of inactive pages accessed in
- *    between.
+ *   SP + NR_INACTIVE
  *
- * 2. Moving one inactive page N page slots towards the tail of the
- *    list requires at least N inactive page accesses.
+ * So if:
  *
- * Combining these:
+ *   SP + NR_INACTIVE < NR_INACTIVE + NR_ACTIVE
  *
- * 1. When a page is finally evicted from memory, the number of
- *    inactive pages accessed while the page was in cache is at least
- *    the number of page slots on the inactive list.
+ * Which can be simplified to:
  *
- * 2. In addition, measuring the sum of evictions and activations (E)
- *    at the time of a page's eviction, and comparing it to another
- *    reading (R) at the time the page faults back into memory tells
- *    the minimum number of accesses while the page was not cached.
- *    This is called the refault distance.
+ *   SP < NR_ACTIVE
  *
- * Because the first access of the page was the fault and the second
- * access the refault, we combine the in-cache distance with the
- * out-of-cache distance to get the complete minimum access distance
- * of this page:
+ * Then the page is worth getting re-activated to start from ACTIVE part,
+ * since the access distance is shorter than total memory to make it stay.
  *
- *      NR_inactive + (R - E)
+ * And since this is only an estimation, based on several hypotheses, and
+ * it could break the ability of LRU to distinguish a workingset out of
+ * caches, so throttle this by two factors:
  *
- * And knowing the minimum access distance of a page, we can easily
- * tell if the page would be able to stay in cache assuming all page
- * slots in the cache were available:
+ * 1. Notice that re-faulted in pages may leave "holes" on the shadow
+ *    part of LRU, that part is left unhandled on purpose to decrease
+ *    re-activate rate for pages that have a large SP value (the larger
+ *    SP value a page have, the more likely it will be affected by such
+ *    holes).
+ * 2. When the ACTIVE part of LRU is long enough, challenging ACTIVE pages
+ *    by re-activating a one-time faulted previously INACTIVE page may not
+ *    be a good idea, so throttle the re-activation when ACTIVE > INACTIVE
+ *    by comparing with INACTIVE instead.
  *
- *   NR_inactive + (R - E) <= NR_inactive + NR_active
+ * Combined all above, we have:
+ * Upon refault, if any of the following conditions is met, mark the page
+ * as active:
  *
- * If we have swap we should consider about NR_inactive_anon and
- * NR_active_anon, so for page cache and anonymous respectively:
- *
- *   NR_inactive_file + (R - E) <= NR_inactive_file + NR_active_file
- *   + NR_inactive_anon + NR_active_anon
- *
- *   NR_inactive_anon + (R - E) <= NR_inactive_anon + NR_active_anon
- *   + NR_inactive_file + NR_active_file
- *
- * Which can be further simplified to:
- *
- *   (R - E) <= NR_active_file + NR_inactive_anon + NR_active_anon
- *
- *   (R - E) <= NR_active_anon + NR_inactive_file + NR_active_file
- *
- * Put into words, the refault distance (out-of-cache) can be seen as
- * a deficit in inactive list space (in-cache).  If the inactive list
- * had (R - E) more page slots, the page would not have been evicted
- * in between accesses, but activated instead.  And on a full system,
- * the only thing eating into inactive list space is active pages.
+ * - If ACTIVE LRU is low (NR_ACTIVE < NR_INACTIVE), check if:
+ *   SP < NR_ACTIVE
  *
+ * - If ACTIVE LRU is high (NR_ACTIVE >= NR_INACTIVE), check if:
+ *   SP < NR_INACTIVE
  *
  *		Refaulting inactive pages
  *
@@ -419,8 +409,10 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	struct mem_cgroup *eviction_memcg;
 	struct lruvec *eviction_lruvec;
 	unsigned long refault_distance;
-	unsigned long workingset_size;
+	unsigned long inactive_file;
+	unsigned long inactive_anon;
 	unsigned long refault;
+	unsigned long active;
 	int memcgid;
 	struct pglist_data *pgdat;
 	unsigned long eviction;
@@ -479,21 +471,27 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	 * workingset competition needs to consider anon or not depends
 	 * on having free swap space.
 	 */
-	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
-	if (!file) {
-		workingset_size += lruvec_page_state(eviction_lruvec,
-						     NR_INACTIVE_FILE);
-	}
+	active = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
+	inactive_file = lruvec_page_state(eviction_lruvec, NR_INACTIVE_FILE);
+
 	if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
-		workingset_size += lruvec_page_state(eviction_lruvec,
+		active += lruvec_page_state(eviction_lruvec,
 						     NR_ACTIVE_ANON);
-		if (file) {
-			workingset_size += lruvec_page_state(eviction_lruvec,
-						     NR_INACTIVE_ANON);
-		}
+		inactive_anon = lruvec_page_state(eviction_lruvec,
+						  NR_INACTIVE_ANON);
+	} else {
+		inactive_anon = 0;
 	}
 
-	return refault_distance <= workingset_size;
+	/*
+	 * When there are already enough active pages, be less aggressive
+	 * on reactivating pages, challenge an large set of established
+	 * active pages with one time refaulted page may not be a good idea.
+	 */
+	if (active >= inactive_anon + inactive_file)
+		return refault_distance < inactive_anon + inactive_file;
+	else
+		return refault_distance < active + (file ? inactive_anon : inactive_file);
 }
 
 /**
@@ -543,7 +541,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 		goto out;
 
 	folio_set_active(folio);
-	workingset_age_nonresident(lruvec, nr);
 	mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + file, nr);
 
 	/* Folio was active prior to eviction */
@@ -560,30 +557,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 	rcu_read_unlock();
 }
 
-/**
- * workingset_activation - note a page activation
- * @folio: Folio that is being activated.
- */
-void workingset_activation(struct folio *folio)
-{
-	struct mem_cgroup *memcg;
-
-	rcu_read_lock();
-	/*
-	 * Filter non-memcg pages here, e.g. unmap can call
-	 * mark_page_accessed() on VDSO pages.
-	 *
-	 * XXX: See workingset_refault() - this should return
-	 * root_mem_cgroup even for !CONFIG_MEMCG.
-	 */
-	memcg = folio_memcg_rcu(folio);
-	if (!mem_cgroup_disabled() && !memcg)
-		goto out;
-	workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(folio));
-out:
-	rcu_read_unlock();
-}
-
 /*
  * Shadow entries reflect the share of the working set that does not
  * fit into memory, so their number depends on the access pattern of
-- 
2.41.0

