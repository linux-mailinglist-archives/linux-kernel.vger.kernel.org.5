Return-Path: <linux-kernel+bounces-35886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC583982A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8822813F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D2385C4B;
	Tue, 23 Jan 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PejjRt7u"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21C823CE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035570; cv=none; b=O70HO99Hp17cpHUG7JrMioMPlTFizu7Tgj0I8/lGkkB0MGGIzc3DZGy1NOcsrRLoLB7jViL3ymr0SUHq4w46kftJljUGiJpuH1I2xprSOxgn4wa7KY0iWaw6qXiM6lNPg5KVW0CaQbs07uZ5J2sLV5OLZvCtCTyj0un1R3kn728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035570; c=relaxed/simple;
	bh=IL7NUK6FxDSA1jjR35p4up3wfl6Mv6w9KsukibKyqQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csrG0jD511P2EnE13653qIuYxLa7l1jR+GqIvKswb4amhWvhZXEZWX+BgpL9tkf6UQOrx4DfHfZ4Elx17wuUSSSScORm/FYReuLJmFSfc9icdeasOy6f7L3h4o+FbgwOtqdP58WJaQqd2mqrm4IrLHOjZAj/ThM+cnhwsiTdUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PejjRt7u; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d71cb97937so27820095ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706035568; x=1706640368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IuyIoFCfZ7YdkhEdaTKUsA0jfoduX/Ed91Z/Iy4HbTw=;
        b=PejjRt7uLwqKq1+RCdilOmOSZXx1Nedcu9l8fLIBzzPY65mPMBgbBTSY+pvnBIOFg7
         wU3sIXUtDHjnpPpETXQd5A6JxtR10IVacsQvV8ODvMGMTkPPAxoR/3QogKcrBHEstBbm
         JYoRzfvJv39e99D9xPI70uB2G5zLgNPiSpMF4anD7xvvXzWeE8eq7igNcjvJU1rY4FlW
         cLvXfSCIBa1Ag4OZeG/eejAXehYJHLhYfsLDE4LRJEh4PjjnefNWcgMqt44T5aU4VVUg
         VRTbJD+6zI000jXuEZSaUn1qMIFAhm4wPEUd3iGn7PE0GuzalzpNtjRdbkXm8/z9vWqJ
         2kYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035568; x=1706640368;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IuyIoFCfZ7YdkhEdaTKUsA0jfoduX/Ed91Z/Iy4HbTw=;
        b=K/tnIK8GxKmsHA8yJLufIqCffklht6RqB1XHaCieE3Tq4FYhqGpMUtGZsGdfV35Prj
         HX29trMhi+vTGmbUE7fbx3+GhhhxE1TkGIsu6ptfPqKmVmEmXzHjSl0VH0L1YF5Uv2Ow
         cWQjBa8TUgzWVjflirnO9XXP1lZaRMlaHJbVRocVo1nGc2TszNtC6QkE4zN3n43UUTq9
         x3yj3eoJBsK/ycTvr4UeiY6uUqTtkKBkWLVuQBfHJS0bJcFpbzDODY1KurD5b07ZOyoy
         To8S58pLX+g8WTNVwDOyg+BoRLWQvkzE9MUEwI5LbqQu/r9Rb5LSzJZB+LipVCDKrdwi
         XXPw==
X-Gm-Message-State: AOJu0Yw4P/VuYxQ7eXIBC0V1onvodFA+SV0iLPDJlW2mYHyd4CH9tg1k
	K0YHR1P2XHRn1iob+Na4gB2FUdvZMDXv/U6BJlGOkdsbs+dhlYcS
X-Google-Smtp-Source: AGHT+IEICLiW4CBTB3qCkG5rC/3WLM2CjLX2MTEiymk06M7wUen2STMsCnbNu4Cim58h7VWkWAoNUA==
X-Received: by 2002:a17:902:eacb:b0:1d7:2500:69d5 with SMTP id p11-20020a170902eacb00b001d7250069d5mr3578430pld.17.1706035567964;
        Tue, 23 Jan 2024 10:46:07 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902b70500b001d74c285b55sm4035196pls.67.2024.01.23.10.46.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jan 2024 10:46:07 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 3/3] mm, lru_gen: move pages in bulk when aging
Date: Wed, 24 Jan 2024 02:45:52 +0800
Message-ID: <20240123184552.59758-4-ryncsn@gmail.com>
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

Another overhead of aging is page moving. Actually, in most cases,
pages are being moved to the same gen after folio_inc_gen is called,
especially the protected pages.  So it's better to move them in bulk.

This also has a good effect on LRU order. Currently when MGLRU
ages, it walks the LRU backwards, and the protected pages are moved to
the tail of newer gen one by one, which actually reverses the order of
pages in LRU. Moving them in batches can help keep their order, only
in a small scope though, due to the scan limit of MAX_LRU_BATCH pages.

After this commit, we can see a slight performance gain (with
CONFIG_DEBUG_LIST=n):

Test 1: Ramdisk fio test in a 4G memcg on a EPYC 7K62:
  fio -name=mglru --numjobs=16 --directory=/mnt --size=960m \
    --buffered=1 --ioengine=io_uring --iodepth=128 \
    --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
    --rw=randread --random_distribution=zipf:0.5 --norandommap \
    --time_based --ramp_time=1m --runtime=6m --group_reporting

Before:
bw (  MiB/s): min= 8299, max= 9847, per=100.00%, avg=9388.23, stdev=16.25, samples=11488
iops        : min=2124544, max=2521056, avg=2403385.82, stdev=4159.07, samples=11488

After (-0.2%):
bw (  MiB/s): min= 8359, max= 9796, per=100.00%, avg=9367.29, stdev=15.75, samples=11488
iops        : min=2140113, max=2507928, avg=2398024.65, stdev=4033.07, samples=11488

Test 2: Ramdisk fio hybrid test for 30m in a 4G memcg on a EPYC 7K62 (3 times):
  fio --buffered=1 --numjobs=8 --size=960m --directory=/mnt \
    --time_based --ramp_time=1m --runtime=30m \
    --ioengine=io_uring --iodepth=128 --iodepth_batch_submit=32 \
    --iodepth_batch_complete=32 --norandommap \
    --name=mglru-ro --rw=randread --random_distribution=zipf:0.7 \
    --name=mglru-rw --rw=randrw --random_distribution=zipf:0.7

Before this patch:
 READ: 6973.3 MiB/s, Stdev: 19.601587
WRITE: 1302.3 MiB/s, Stdev: 4.988877

After this patch (+0.1%, +0.3%):
 READ: 6981.0 MiB/s, Stdev: 15.556349
WRITE: 1305.7 MiB/s, Stdev: 2.357023

Test 3: 30m of MySQL test in 6G memcg for 12 times:
  echo 'set GLOBAL innodb_buffer_pool_size=16106127360;' | \
    mysql -u USER -h localhost --password=PASS

  sysbench /usr/share/sysbench/oltp_read_only.lua \
    --mysql-user=USER --mysql-password=PASS --mysql-db=DB \
    --tables=48 --table-size=2000000 --threads=16 --time=1800 run

Before this patch
Avg: 135310.868182 qps. Stdev: 379.200942

After this patch (-0.3%):
Avg: 135099.210000 qps. Stdev: 351.488863

Test 4: Build linux kernel in 2G memcg with make -j48 with SSD swap
        (for memory stress, 18 times):

Before this patch:
Average: 1467.813023. Stdev: 24.232886

After this patch (+0.0%):
Average: 1464.178154. Stdev: 17.992974

Test 5: Memtier test in a 4G cgroup using brd as swap (20 times):
  memcached -u nobody -m 16384 -s /tmp/memcached.socket \
    -a 0766 -t 16 -B binary &
  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys \
    --key-minimum=1 --key-maximum=16000000 -d 1024 \
    --ratio=1:0 --key-pattern=P:P -c 1 -t 16 --pipeline 8 -x 3

Before this patch:
Avg: 48389.282500 Ops/sec. Stdev: 3534.470933

After this patch (+1.2%):
Avg: 48959.374118 Ops/sec. Stdev: 3488.559744

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/vmscan.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8c701b34d757..373a70801db9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3122,8 +3122,45 @@ static int folio_update_gen(struct folio *folio, int gen)
  */
 struct lru_gen_inc_batch {
 	int delta;
+	struct folio *head, *tail;
 };
 
+static inline void lru_gen_inc_bulk_done(struct lru_gen_folio *lrugen,
+					 int bulk_gen, bool type, int zone,
+					 struct lru_gen_inc_batch *batch)
+{
+	if (!batch->head)
+		return;
+
+	list_bulk_move_tail(&lrugen->folios[bulk_gen][type][zone],
+			    &batch->head->lru,
+			    &batch->tail->lru);
+
+	batch->head = NULL;
+}
+
+/*
+ * When aging, protected pages will go to the tail of the same higher
+ * gen, so the can be moved in batches. Besides reduced overhead, this
+ * also avoids changing their LRU order in a small scope.
+ */
+static inline void lru_gen_try_bulk_move(struct lru_gen_folio *lrugen, struct folio *folio,
+					 int bulk_gen, int new_gen, bool type, int zone,
+					 struct lru_gen_inc_batch *batch)
+{
+	/*
+	 * If folio not moving to the bulk_gen, it's raced with promotion
+	 * so it need to go to the head of another LRU.
+	 */
+	if (bulk_gen != new_gen)
+		list_move(&folio->lru, &lrugen->folios[new_gen][type][zone]);
+
+	if (!batch->head)
+		batch->tail = folio;
+
+	batch->head = folio;
+}
+
 static void lru_gen_inc_batch_done(struct lruvec *lruvec, int gen, int type, int zone,
 				   struct lru_gen_inc_batch *batch)
 {
@@ -3132,6 +3169,8 @@ static void lru_gen_inc_batch_done(struct lruvec *lruvec, int gen, int type, int
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	enum lru_list lru = type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
 
+	lru_gen_inc_bulk_done(lrugen, new_gen, type, zone, batch);
+
 	if (!delta)
 		return;
 
@@ -3709,6 +3748,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 	struct lru_gen_inc_batch batch = { };
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
+	int bulk_gen = (old_gen + 1) % MAX_NR_GENS;
 
 	if (type == LRU_GEN_ANON && !can_swap)
 		goto done;
@@ -3737,7 +3777,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 			}
 
 			new_gen = folio_inc_gen(folio, old_gen, false, &batch);
-			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
+			lru_gen_try_bulk_move(lrugen, folio, bulk_gen, new_gen, type, zone, &batch);
 
 			if (!--remaining) {
 				lru_gen_inc_batch_done(lruvec, old_gen, type, zone, &batch);
@@ -4275,6 +4315,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	int tier = lru_tier_from_refs(refs);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
+	int bulk_gen = (old_gen + 1) % MAX_NR_GENS;
 
 	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
 
@@ -4308,7 +4349,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 		gen = folio_inc_gen(folio, old_gen, false, batch);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		lru_gen_try_bulk_move(lrugen, folio, bulk_gen, gen, type, zone, batch);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
 			   lrugen->protected[hist][type][tier - 1] + delta);
@@ -4318,7 +4359,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	/* ineligible */
 	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
 		gen = folio_inc_gen(folio, old_gen, false, batch);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		lru_gen_try_bulk_move(lrugen, folio, bulk_gen, gen, type, zone, batch);
 		return true;
 	}
 
-- 
2.43.0


