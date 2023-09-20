Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0627A8C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjITTDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjITTDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:03:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BAC133
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fcb4dc8a9so107793b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695236604; x=1695841404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kjgv+mFujyzVEIugXeNIQdL6q9WaOAgedP9iUwn1GA0=;
        b=fZxJ1+O/3Y5snEztA2gP6ey5/kGtbUM6AY4ui9G+AJjWtV1gtE34AQiTeOXuxUxYyr
         LDsRfPuVVtoT74byQ8BZ1qOHHIpngbqqWrImNw+zJeV56I4CGbxG33K6o7UnFNvJ/8ep
         YYMeRpJurfjS1I0/glar3bYmgpYLQXyCBwdysUdrI4bZXrX6dOAuNIGPVOhcRDGqoKqY
         +ChomoEYdo3iXg0/6llijAzBoP65yNTT819LI+7yHROEA92X6SB3/75QUZEK1KcoSDAU
         hifQaX9zsV2tCOt00kDSI7r9njNzuDWKXGz9NrhoapfYuLiLiqYRsbKPI6PM9xQceZFp
         pYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695236604; x=1695841404;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kjgv+mFujyzVEIugXeNIQdL6q9WaOAgedP9iUwn1GA0=;
        b=YzJ+D4F2p6l5SmuijMER9mVo/l0bAvLAEKyOUFaimunI2q9j4pH8h8Iv2ePAMhswKW
         JPfiSWxK7yIVnbTYYzgFrAZ8nZ4LyJpU/PPASTdWjF1Cwzo+GsH8I8jmJW8f5raZIYAF
         GcEj4aHaukIxvs2gjXkmKwTGj6y+U3JrgtAo+zwYLHw3AbjTtc/bIrPQq8Xrxjx6nMr+
         ZziEKQxHkZcyNmahXhE3eyIE1qfPYMOl+UxCdz71IQWAaDqNRh5kFfGS3x2+dDrRcuzP
         XHLDfkeOO4HW77Q2QII2tOts2akIpWSDvtjkUB0AzI6s+V6EpN2Rv0EWP49HvNMiALaW
         qP0A==
X-Gm-Message-State: AOJu0YzD7OCMODAtRGWcbJ20ZzVOdl0+6ZXKpQeVaCPGEpGQjfxhxZeh
        VSsIgMD26VYeSshNx7rFGVc=
X-Google-Smtp-Source: AGHT+IHW6mCVr1H1UgvYhLR1rDIAuYEv8miI6LBr4eJOdwLqHAyFRjLtC/x1CL1mtMoA2avNPaZcvQ==
X-Received: by 2002:a05:6a21:99a2:b0:15d:ee3:a1e3 with SMTP id ve34-20020a056a2199a200b0015d0ee3a1e3mr1350694pzb.16.1695236603799;
        Wed, 20 Sep 2023 12:03:23 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([124.127.145.18])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006871fdde2c7sm423935pfa.110.2023.09.20.12.03.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Sep 2023 12:03:23 -0700 (PDT)
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
Subject: [RFC PATCH v3 6/6] workingset, lru_gen: apply refault-distance based re-activation
Date:   Thu, 21 Sep 2023 03:02:44 +0800
Message-ID: <20230920190244.16839-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920190244.16839-1-ryncsn@gmail.com>
References: <20230920190244.16839-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I noticed MGLRU not working very well on certain workflows, which is
observed on some heavily stressed databases. That is when the file
page workingset size exceeds total memory, and the access distance
(the left-shift time of a page before it gets activated, considering
LRU starts from right) of file pages also larger than total memory.
All file pages are stuck on the oldest generation and getting
read-in then evicted permutably. Despite anon pages being idle,
they never get aged. PID controller didn't kickin until there are some
minor access pattern changes. And file pages are not promoted
or reused.

Even though the memory can't cover the whole workingset, the
refault-distance based re-activation can help hold part of the
workingset in-memory to help reduce the IO workload significantly.

So apply it for MGLRU as well. The updated refault-distance model
fits well for MGLRU in most cases, if we just consider the last two
generation as the inactive LRU and the first two generations as
active LRU.

Some adjustment is done to fit the logic better, also make the
refault-distance contributed to page tiering and PID refault detection
of MGLRU:

- If a tier-0 page have a qualified refault-distance, just promote
  it to higher tier, send it to second oldest gen.
- If a tier >= 1 page have a qualified refault-distance, mark it as
  active and send it to youngest gen.
- Increase the reference of every page that have a qualified
  refault-distance and increase the PID countroled refault rate
  of the updated tier, in hope similar paged will be protected
  next time upon eviction.

NOTE: This also changed the meaning of workingset_* fields in
/proc/vmstat, workingset_activate_* now stands for the pages
reactivated or promoted by refault distance checking,
workingset_restore_* now stands for all pages promoted by
any reason.

Following benchmark showed 5x improvement. To simulate the optimized
workflow, I setup a 3-replicated mongodb cluster, each in a different
cgroup, using 5 gb of wiretiger cache and 10g of oplog, on a 32G VM with
no limit set. The benchmark is done using
https://github.com/apavlo/py-tpcc.git, modified to run STOCK_LEVEL
query only, for simulating slow query and get a stable result.

Test is done on an EPYC 7K62 with 32G RAM with SATA SSD:

- Before (with ZRAM enabled, the result won't change whether
any kind of swap is on or not):
$ tpcc.py --config=mongodb.config mongodb --duration=900 --warehouses=500 --clients=30
==================================================================
Execution Results after 919 seconds
------------------------------------------------------------------
                  Executed        Time (µs)       Rate
  STOCK_LEVEL     577             27584645283.7   0.02 txn/s
------------------------------------------------------------------
  TOTAL           577             27584645283.7   0.02 txn/s

$ cat /proc/vmstat | grep workingset
workingset_nodes 47860
workingset_refault_anon 0
workingset_refault_file 23498953
workingset_activate_anon 0
workingset_activate_file 23487840
workingset_restore_anon 0
workingset_restore_file 18553646
workingset_nodereclaim 768

$ free -m
              total        used        free      shared  buff/cache   available
Mem:          31849        6829         790          23       24229       24542
Swap:         31848           0       31848

- Patched: (with ZRAM enabled):
$ tpcc.py --config=mongodb.config mongodb --duration=900 --warehouses=500 --clients=30
==================================================================
Execution Results after 905 seconds
------------------------------------------------------------------
                  Executed        Time (µs)       Rate
  STOCK_LEVEL     2542            27121571486.2   0.09 txn/s
------------------------------------------------------------------
  TOTAL           2542            27121571486.2   0.09 txn/s

$ cat /proc/vmstat | grep working
workingset_nodes 70358
workingset_refault_anon 16853
workingset_refault_file 22693601
workingset_activate_anon 10099
workingset_activate_file 8565519
workingset_restore_anon 10127
workingset_restore_file 8566053
workingset_nodereclaim 9801

$ free -m
              total        used        free      shared  buff/cache   available
Mem:          31849        7093         283           4       24472       24289
Swap:         31848        1652       30196

The performance is 5x times better than before, and the idle anon pages
now can get swapped out as expected. The result is also better with
lower test stress, testing with lower stress also shows a improvement.

I also checked the benchmark with memtier/memcached and fio,
using similar setup as in commit ac35a4902374 but scaled down to fit in
my test environment:

  memtier test (16G ramdisk as swap, 4G memcg limit, VM on a EPYC 7K62):
  memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 \
    -t 16 -B binary &
  memtier_benchmark -S /tmp/memcached.socket -P memcache_binary -n allkeys\
    --key-minimum=1 --key-maximum=36000000 --key-pattern=P:P -c 1 \
    -t 16 --ratio 1:0 --pipeline 8 -d 600 -x 6

  fio test 1 (16G ramdisk, 4G memcg limit, VM on a EPYC 7K62):
  fio -name=mglru --numjobs=16 --directory=/mnt --size=1000m \
    --buffered=1 --ioengine=io_uring --iodepth=128 \
    --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
    --rw=randread --random_distribution=zipf:1.2 --norandommap \
    --time_based --ramp_time=10m --runtime=5m --group_reporting

  fio test 2 (16G ramdisk, 2G memcg limit, VM on a EPYC 7K62):
  fio -name=mglru --numjobs=16 --directory=/mnt --size=1000m \
    --buffered=1 --ioengine=io_uring --iodepth=128 \
    --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
    --rw=randread --random_distribution=zipf:1.2 --norandommap \
    --time_based --ramp_time=10m --runtime=5m --group_reporting

  mysql test (15G buffer pool with 16G memcg limit, VM on a EPYC 7K62):
    sysbench /usr/share/sysbench/oltp_read_only.lua <auth and db params> \
      --tables=48 --table-size=2000000 --threads=16 --time=1800 run

Before this patch:
memtier: 37794.71 op/s
fio 1: 6327.3k iops
fio 2: 5697.6k iops
mysql: 146104.98 qps

After this patch:
memtier: 37792.61 op/s
fio 1: 6583.3k iops
fio 2: 5929.2k iops
mysql: 146055.88 qps

There is no regression on other tests so far, and a performance gain
is observed on file page heavy tasks.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/vmscan.c     |  20 +++++---
 mm/workingset.c | 130 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 95 insertions(+), 55 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 82acc1934c86..c7745b22cc0b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3730,17 +3730,21 @@ static void reset_ctrl_pos(struct lruvec *lruvec, int type, bool carryover)
 
 	for (tier = 0; tier < MAX_NR_TIERS; tier++) {
 		if (carryover) {
-			unsigned long sum;
+			unsigned long refaulted, total;
 
-			sum = atomic_long_read(&lrugen->avg_refaulted[type][tier]) +
-			      atomic_long_read(&lrugen->refaulted[hist][type][tier]);
-			atomic_long_set(&lrugen->avg_refaulted[type][tier], sum / 2);
+			refaulted = atomic_long_read(&lrugen->avg_refaulted[type][tier]) +
+				atomic_long_read(&lrugen->refaulted[hist][type][tier]);
 
-			sum = atomic_long_read(&lrugen->avg_total[type][tier]) +
-			      atomic_long_read(&lrugen->evicted[hist][type][tier]);
+			total = atomic_long_read(&lrugen->avg_total[type][tier]) +
+				atomic_long_read(&lrugen->evicted[hist][type][tier]);
 			if (tier)
-				sum += lrugen->protected[hist][type][tier - 1];
-			atomic_long_set(&lrugen->avg_total[type][tier], sum / 2);
+				total += lrugen->protected[hist][type][tier - 1];
+
+			/* total could be less than refaulted, see lru_gen_refault */
+			total = max(total, refaulted);
+
+			atomic_long_set(&lrugen->avg_refaulted[type][tier], refaulted / 2);
+			atomic_long_set(&lrugen->avg_total[type][tier], total / 2);
 		}
 
 		if (clear) {
diff --git a/mm/workingset.c b/mm/workingset.c
index 87a16b6158e5..e548c8cee9ad 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -175,6 +175,7 @@
 			 MEM_CGROUP_ID_SHIFT)
 #define EVICTION_BITS	(BITS_PER_LONG - (EVICTION_SHIFT))
 #define EVICTION_MASK	(~0UL >> EVICTION_SHIFT)
+#define LRU_GEN_EVICTION_BITS	(EVICTION_BITS - LRU_REFS_WIDTH - LRU_GEN_WIDTH)
 
 /*
  * Eviction timestamps need to be able to cover the full range of
@@ -185,6 +186,7 @@
  * evictions into coarser buckets by shaving off lower timestamp bits.
  */
 static unsigned int bucket_order __read_mostly;
+static unsigned int lru_gen_bucket_order __read_mostly;
 
 static void *pack_shadow(int memcgid, pg_data_t *pgdat, unsigned long eviction,
 			 bool workingset)
@@ -290,6 +292,34 @@ static inline bool lru_test_refault(struct mem_cgroup *memcg,
 			(file ? inactive_anon : inactive_file);
 }
 
+/**
+ * workingset_age_nonresident - age non-resident entries as LRU ages
+ * @lruvec: the lruvec that was aged
+ * @nr_pages: the number of pages to count
+ *
+ * As in-memory pages are aged, non-resident pages need to be aged as
+ * well, in order for the refault distances later on to be comparable
+ * to the in-memory dimensions. This function allows reclaim and LRU
+ * operations to drive the non-resident aging along in parallel.
+ */
+void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages)
+{
+	/*
+	 * Reclaiming a cgroup means reclaiming all its children in a
+	 * round-robin fashion. That means that each cgroup has an LRU
+	 * order that is composed of the LRU orders of its child
+	 * cgroups; and every page has an LRU position not just in the
+	 * cgroup that owns it, but in all of that group's ancestors.
+	 *
+	 * So when the physical inactive list of a leaf cgroup ages,
+	 * the virtual inactive lists of all its parents, including
+	 * the root cgroup's, age as well.
+	 */
+	do {
+		atomic_long_add(nr_pages, &lruvec->nonresident_age);
+	} while ((lruvec = parent_lruvec(lruvec)));
+}
+
 #ifdef CONFIG_LRU_GEN
 
 static void *lru_gen_eviction(struct folio *folio)
@@ -311,10 +341,14 @@ static void *lru_gen_eviction(struct folio *folio)
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	lrugen = &lruvec->lrugen;
 	min_seq = READ_ONCE(lrugen->min_seq[type]);
+
 	token = (min_seq << LRU_REFS_WIDTH) | max(refs - 1, 0);
+	token <<= LRU_GEN_EVICTION_BITS;
+	token |= lru_eviction(lruvec, LRU_GEN_EVICTION_BITS, lru_gen_bucket_order);
 
 	hist = lru_hist_from_seq(min_seq);
 	atomic_long_add(delta, &lrugen->evicted[hist][type][tier]);
+	workingset_age_nonresident(lruvec, folio_nr_pages(folio));
 
 	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
 }
@@ -329,15 +363,17 @@ static bool lru_gen_test_recent(struct lruvec *lruvec, bool file,
 	unsigned long min_seq;
 
 	min_seq = READ_ONCE(lruvec->lrugen.min_seq[file]);
+	token >>= LRU_GEN_EVICTION_BITS;
 	return (token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
 }
 
 static void lru_gen_refault(struct folio *folio, void *shadow)
 {
 	int memcgid;
-	bool recent;
+	bool refault;
 	bool workingset;
 	unsigned long token;
+	bool recent = false;
 	int hist, tier, refs;
 	struct lruvec *lruvec;
 	struct pglist_data *pgdat;
@@ -345,28 +381,36 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 	int type = folio_is_file_lru(folio);
 	int delta = folio_nr_pages(folio);
 
-	rcu_read_lock();
-
 	unpack_shadow(shadow, &memcgid, &pgdat, &token, &workingset);
 	lruvec = mem_cgroup_lruvec(mem_cgroup_from_id(memcgid), pgdat);
 	if (lruvec != folio_lruvec(folio))
-		goto unlock;
+		return;
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + type, delta);
-
+	refault = lru_test_refault(lruvec_memcg(lruvec), lruvec, token, type,
+				   LRU_GEN_EVICTION_BITS, lru_gen_bucket_order);
 	recent = lru_gen_test_recent(lruvec, type, token);
-	if (!recent)
-		goto unlock;
+	if (!recent && !refault)
+		return;
 
 	lrugen = &lruvec->lrugen;
-
 	hist = lru_hist_from_seq(READ_ONCE(lrugen->min_seq[type]));
 	/* see the comment in folio_lru_refs() */
+	token >>= LRU_GEN_EVICTION_BITS;
 	refs = (token & (BIT(LRU_REFS_WIDTH) - 1)) + workingset;
 	tier = lru_tier_from_refs(refs);
 
-	atomic_long_add(delta, &lrugen->refaulted[hist][type][tier]);
-	mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
+	if (refault) {
+		if (refs)
+			folio_set_active(folio);
+		/*
+		 * Protect higher tier to make it easier
+		 * to stay in a stable workingset and prevent refault.
+		 */
+		if (refs != BIT(LRU_REFS_WIDTH))
+			tier = lru_tier_from_refs(refs + 1);
+		mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
+	}
 
 	/*
 	 * Count the following two cases as stalls:
@@ -375,12 +419,25 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 	 * 2. For pages accessed multiple times through file descriptors,
 	 *    numbers of accesses might have been out of the range.
 	 */
-	if (lru_gen_in_fault() || refs == BIT(LRU_REFS_WIDTH)) {
-		folio_set_workingset(folio);
+	if (refault || lru_gen_in_fault() || refs == BIT(LRU_REFS_WIDTH)) {
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + type, delta);
+		folio_set_workingset(folio);
+	}
+
+	/*
+	 * If recent is false, add to global PID counters since the gen which
+	 * the page evicted is gone already.
+	 */
+	if (recent) {
+		/*
+		 * tier may get increased upon refault, which makes refaulted larger
+		 * than evicted, this will be reset and accounted by reset_ctrl_pos
+		 */
+		atomic_long_add(delta, &lrugen->refaulted[hist][type][tier]);
+	} else {
+		atomic_long_add(delta, &lrugen->avg_total[type][tier]);
+		atomic_long_add(delta, &lrugen->avg_refaulted[type][tier]);
 	}
-unlock:
-	rcu_read_unlock();
 }
 
 #else /* !CONFIG_LRU_GEN */
@@ -402,34 +459,6 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 
 #endif /* CONFIG_LRU_GEN */
 
-/**
- * workingset_age_nonresident - age non-resident entries as LRU ages
- * @lruvec: the lruvec that was aged
- * @nr_pages: the number of pages to count
- *
- * As in-memory pages are aged, non-resident pages need to be aged as
- * well, in order for the refault distances later on to be comparable
- * to the in-memory dimensions. This function allows reclaim and LRU
- * operations to drive the non-resident aging along in parallel.
- */
-void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages)
-{
-	/*
-	 * Reclaiming a cgroup means reclaiming all its children in a
-	 * round-robin fashion. That means that each cgroup has an LRU
-	 * order that is composed of the LRU orders of its child
-	 * cgroups; and every page has an LRU position not just in the
-	 * cgroup that owns it, but in all of that group's ancestors.
-	 *
-	 * So when the physical inactive list of a leaf cgroup ages,
-	 * the virtual inactive lists of all its parents, including
-	 * the root cgroup's, age as well.
-	 */
-	do {
-		atomic_long_add(nr_pages, &lruvec->nonresident_age);
-	} while ((lruvec = parent_lruvec(lruvec)));
-}
-
 /**
  * workingset_eviction - note the eviction of a folio from memory
  * @target_memcg: the cgroup that is causing the reclaim
@@ -529,16 +558,16 @@ void workingset_refault(struct folio *folio, void *shadow)
 	bool workingset;
 	long nr;
 
-	if (lru_gen_enabled()) {
-		lru_gen_refault(folio, shadow);
-		return;
-	}
-
 	/* Flush stats (and potentially sleep) before holding RCU read lock */
 	mem_cgroup_flush_stats_ratelimited();
 
 	rcu_read_lock();
 
+	if (lru_gen_enabled()) {
+		lru_gen_refault(folio, shadow);
+		goto out;
+	}
+
 	/*
 	 * The activation decision for this folio is made at the level
 	 * where the eviction occurred, as that is where the LRU order
@@ -785,6 +814,13 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 		EVICTION_BITS, max_order, bucket_order);
 
+#ifdef CONFIG_LRU_GEN
+	if (max_order > LRU_GEN_EVICTION_BITS)
+		lru_gen_bucket_order = max_order - LRU_GEN_EVICTION_BITS;
+	pr_info("workingset: lru_gen_timestamp_bits=%d lru_gen_bucket_order=%u\n",
+		LRU_GEN_EVICTION_BITS, lru_gen_bucket_order);
+#endif
+
 	ret = prealloc_shrinker(&workingset_shadow_shrinker, "mm-shadow");
 	if (ret)
 		goto err;
-- 
2.41.0

