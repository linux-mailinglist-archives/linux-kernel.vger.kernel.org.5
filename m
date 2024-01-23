Return-Path: <linux-kernel+bounces-35885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6E839828
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA0A1C273CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828E282D9A;
	Tue, 23 Jan 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyo3F43T"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378B82D81
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035567; cv=none; b=FtIC7irj4bGfeI4eyYgu88dH2UjyIRs0JZp6ymmqRXSENONT/NEJ4Vf0PJXn+A8dG1xQqNmQDvCuUqySF3K4ZsaVzoLFBahHBdBp/ymg14M89yb1u+RqttJWF3YqNMRITNKIpwCD1Pp2NlI+EHll+AAECiPYEZylai1oTv1uJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035567; c=relaxed/simple;
	bh=b9uFtsBfQcjlq+mfT5fdYSSaIH6BNVdPfDY5iwgFdWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G89Ge49CfYIhDRX/aGjBlemxd//NsI5dboIWhtKEjK0sWS1i4UsaVsAHwzNxMkEd2eRJQRCiZO0vLyNEyU3JRTuQcR0QpMgR8uoDRd8EBj5krBwTBjPPFkwCxOPVJNnU358/FAaWftc8LSMfFNMbOsrX6teZqhpEoBMmlbwi+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyo3F43T; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d75ea3a9b6so18104925ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706035565; x=1706640365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rc80RJovXRONel2vPZqiqNiPzdLsOGe//Ia7888m/xQ=;
        b=iyo3F43TH0i1dLIiA+qgX/G+TbdwslMXaMDZ2FW4Kjy3eBfoCrw+QCz7bR3Rt8eGKx
         eVaV4XzbiSZYv/mdrJTNIASHMwOEJnqT0S7K2vgW4JI/cURxv43By6dxZtGXerQgGS5m
         MS1GtWhvWvlD8z2Et+xd6ZNaV9lAWYNIcmyJa0GT4Ga6+4UqcBxyouV/pOS2je0OhVOu
         p6B13KlvmO9PW0MrsNBIFGHR0zPiwh8DyuwS4F87oCfeO4suZwR/z4o3/ziSWyZU99q+
         tzc9gS3Dk0xHNKd0rAhqoq2ehCgCYpuwQ4Vpng1ziSOVsGqJgiQ3OswJlL7jyEeZ9HWG
         2u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035565; x=1706640365;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rc80RJovXRONel2vPZqiqNiPzdLsOGe//Ia7888m/xQ=;
        b=dxuufIKgRjeb9wx/cA8nNt/NRSBbfNtiKV/2rER2nkfrGkqdDuYQT7udUu9Cc9rsON
         bcYmzUBe1KoUz56usdySF7H879ZTz4ZdEskb3x2eyKzm2HbZQ5ceNQXDvuLC1V5ZJo1z
         UsTchdj+J8vAT9N5I3+oZYGP18DXtMYatermlMm4Ose2F07uD1YmCh0TAdZt2aaQRcNA
         kNYWitJYTcgW/wwpBcGZJzIoVYJJ63tSpbKEZxs6hGefQn4iwPZ9gsucTZpUh1ptasuA
         JsOl9bGBMkkjmGaxvrglojDxMba9iPt+1K9qUKyTxhUTouM9hRh/tC0u6Ytczk/9jC7i
         i9dw==
X-Gm-Message-State: AOJu0YzXJJRQ7BvNNLWY4O1btEBnIE74FaM2FPLCIN4ujOveqf0kKJQp
	mcYHB7oUf3jZBVdZZ6s7tRX0RHo3D7vfFZO7qXAiMLBPojVMQF2u
X-Google-Smtp-Source: AGHT+IF64IW2XJLq7K2HXZYsFhS1Lcix1YogNkO/ahBEKQxX6SOEvgC3c8bnVYZKaRE3MHMEchv0JA==
X-Received: by 2002:a17:902:d48b:b0:1d7:37cf:6c71 with SMTP id c11-20020a170902d48b00b001d737cf6c71mr7152816plg.38.1706035565062;
        Tue, 23 Jan 2024 10:46:05 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902b70500b001d74c285b55sm4035196pls.67.2024.01.23.10.46.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jan 2024 10:46:04 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 2/3] mm, lru_gen: batch update counters on aging
Date: Wed, 24 Jan 2024 02:45:51 +0800
Message-ID: <20240123184552.59758-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123184552.59758-1-ryncsn@gmail.com>
References: <20240123184552.59758-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

When lru_gen is aging, it will update mm counters page by page,
which causes a higher overhead if age happens frequently or there
are a lot of pages in one generation getting moved.
Optimize this by doing the counter update in batch.

Although most __mod_*_state has its own caches the overhead
is still observable.

Test 1: Ramdisk fio test in a 4G memcg on a EPYC 7K62 with:
  fio -name=mglru --numjobs=16 --directory=/mnt --size=960m \
    --buffered=1 --ioengine=io_uring --iodepth=128 \
    --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
    --rw=randread --random_distribution=zipf:0.5 --norandommap \
    --time_based --ramp_time=1m --runtime=6m --group_reporting

Before this patch:
bw (  MiB/s): min= 8360, max= 9771, per=100.00%, avg=9381.31, stdev=15.67, samples=11488
iops        : min=2140296, max=2501385, avg=2401613.91, stdev=4010.41, samples=11488

After this patch (+0.0%):
bw (  MiB/s): min= 8299, max= 9847, per=100.00%, avg=9388.23, stdev=16.25, samples=11488
iops        : min=2124544, max=2521056, avg=2403385.82, stdev=4159.07, samples=11488

Test 2: Ramdisk fio hybrid test for 30m in a 4G memcg on a EPYC 7K62 (3 times):
  fio --buffered=1 --numjobs=8 --size=960m --directory=/mnt \
    --time_based --ramp_time=1m --runtime=30m \
    --ioengine=io_uring --iodepth=128 --iodepth_batch_submit=32 \
    --iodepth_batch_complete=32 --norandommap \
    --name=mglru-ro --rw=randread --random_distribution=zipf:0.7 \
    --name=mglru-rw --rw=randrw --random_distribution=zipf:0.7

Before this patch:
 READ: 6926.6 MiB/s, Stdev: 37.950260
WRITE: 1297.3 MiB/s, Stdev: 7.408704

After this patch (+0.7%, +0.4%):
 READ: 6973.3 MiB/s, Stdev: 19.601587
WRITE: 1302.3 MiB/s, Stdev: 4.988877

Test 3: 30m of MySQL test in 6G memcg (12 times):
  echo 'set GLOBAL innodb_buffer_pool_size=16106127360;' | \
    mysql -u USER -h localhost --password=PASS

  sysbench /usr/share/sysbench/oltp_read_only.lua \
    --mysql-user=USER --mysql-password=PASS --mysql-db=DB \
    --tables=48 --table-size=2000000 --threads=16 --time=1800 run

Before this patch
Avg: 135005.779091 qps. Stdev: 295.299027

After this patch (+0.2%):
Avg: 135310.868182 qps. Stdev: 379.200942

Test 4: Build linux kernel in 2G memcg with make -j48 with SSD swap
        (for memory stress, 18 times):

Before this patch:
Average: 1455.659254 s. Stdev: 15.274481

After this patch (-0.8%):
Average: 1467.813023 s. Stdev: 24.232886

Test 5: Memtier test in a 4G cgroup using brd as swap (20 times):
  memcached -u nobody -m 16384 -s /tmp/memcached.socket \
    -a 0766 -t 16 -B binary &
  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys \
    --key-minimum=1 --key-maximum=16000000 -d 1024 \
    --ratio=1:0 --key-pattern=P:P -c 1 -t 16 --pipeline 8 -x 3

Before this patch:
Avg: 47691.343500 Ops/sec. Stdev: 3925.772473

After this patch (+1.7%):
Avg: 48389.282500 Ops/sec. Stdev: 3534.470933

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/vmscan.c | 68 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03631cedb3ab..8c701b34d757 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3113,12 +3113,45 @@ static int folio_update_gen(struct folio *folio, int gen)
 	return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
 }
 
-/* protect pages accessed multiple times through file descriptors */
-static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
+/*
+ * When oldest gen ie being reclaimed, protected/unreclaimable pages can be
+ * moved in batch. They usually all land on same gen (old_gen + 1) by
+ * folio_inc_gen so the batch struct is limited to one / type / zone
+ * level LRU.
+ * Batch is applied after finished or aborted scanning one LRU list.
+ */
+struct lru_gen_inc_batch {
+	int delta;
+};
+
+static void lru_gen_inc_batch_done(struct lruvec *lruvec, int gen, int type, int zone,
+				   struct lru_gen_inc_batch *batch)
 {
-	int type = folio_is_file_lru(folio);
+	int delta = batch->delta;
+	int new_gen = (gen + 1) % MAX_NR_GENS;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
-	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
+	enum lru_list lru = type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
+
+	if (!delta)
+		return;
+
+	WRITE_ONCE(lrugen->nr_pages[gen][type][zone],
+		   lrugen->nr_pages[gen][type][zone] - delta);
+	WRITE_ONCE(lrugen->nr_pages[new_gen][type][zone],
+		   lrugen->nr_pages[new_gen][type][zone] + delta);
+
+	if (!lru_gen_is_active(lruvec, gen) && lru_gen_is_active(lruvec, new_gen)) {
+		__update_lru_size(lruvec, lru, zone, -delta);
+		__update_lru_size(lruvec, lru + LRU_ACTIVE, zone, delta);
+	}
+}
+
+/* protect pages accessed multiple times through file descriptors */
+static int folio_inc_gen(struct folio *folio, int old_gen, bool reclaiming,
+			 struct lru_gen_inc_batch *batch)
+{
+	int new_gen;
+	int delta = folio_nr_pages(folio);
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
 
 	VM_WARN_ON_ONCE_FOLIO(!(old_flags & LRU_GEN_MASK), folio);
@@ -3138,7 +3171,8 @@ static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclai
 			new_flags |= BIT(PG_reclaim);
 	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
 
-	lru_gen_update_size(lruvec, folio, old_gen, new_gen);
+	/* new_gen is ensured to be old_gen + 1 here, do a batch update */
+	batch->delta += delta;
 
 	return new_gen;
 }
@@ -3672,6 +3706,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 {
 	int zone;
 	int remaining = MAX_LRU_BATCH;
+	struct lru_gen_inc_batch batch = { };
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
@@ -3701,12 +3736,15 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 				prefetchw(&prev->flags);
 			}
 
-			new_gen = folio_inc_gen(lruvec, folio, false);
+			new_gen = folio_inc_gen(folio, old_gen, false, &batch);
 			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
 
-			if (!--remaining)
+			if (!--remaining) {
+				lru_gen_inc_batch_done(lruvec, old_gen, type, zone, &batch);
 				return false;
+			}
 		}
+		lru_gen_inc_batch_done(lruvec, old_gen, type, zone, &batch);
 	}
 done:
 	reset_ctrl_pos(lruvec, type, true);
@@ -4226,7 +4264,7 @@ void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
  ******************************************************************************/
 
 static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_control *sc,
-		       int tier_idx)
+		       int tier_idx, struct lru_gen_inc_batch *batch)
 {
 	bool success;
 	int gen = folio_lru_gen(folio);
@@ -4236,6 +4274,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	int refs = folio_lru_refs(folio);
 	int tier = lru_tier_from_refs(refs);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	int old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
 	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
 
@@ -4259,7 +4298,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* promoted */
-	if (gen != lru_gen_from_seq(lrugen->min_seq[type])) {
+	if (gen != old_gen) {
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
@@ -4268,7 +4307,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	if (tier > tier_idx || refs == BIT(LRU_REFS_WIDTH)) {
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
-		gen = folio_inc_gen(lruvec, folio, false);
+		gen = folio_inc_gen(folio, old_gen, false, batch);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
@@ -4278,7 +4317,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 
 	/* ineligible */
 	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
-		gen = folio_inc_gen(lruvec, folio, false);
+		gen = folio_inc_gen(folio, old_gen, false, batch);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
@@ -4286,7 +4325,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	/* waiting for writeback */
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
-		gen = folio_inc_gen(lruvec, folio, true);
+		gen = folio_inc_gen(folio, old_gen, true, batch);
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
@@ -4353,6 +4392,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 		LIST_HEAD(moved);
 		int skipped_zone = 0;
 		struct folio *prev = NULL;
+		struct lru_gen_inc_batch batch = { };
 		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
 		struct list_head *head = &lrugen->folios[gen][type][zone];
 
@@ -4377,7 +4417,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 				prefetchw(&prev->flags);
 			}
 
-			if (sort_folio(lruvec, folio, sc, tier))
+			if (sort_folio(lruvec, folio, sc, tier, &batch))
 				sorted += delta;
 			else if (isolate_folio(lruvec, folio, sc)) {
 				list_add(&folio->lru, list);
@@ -4391,6 +4431,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 				break;
 		}
 
+		lru_gen_inc_batch_done(lruvec, gen, type, zone, &batch);
+
 		if (skipped_zone) {
 			list_splice(&moved, head);
 			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
-- 
2.43.0


