Return-Path: <linux-kernel+bounces-100460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051768797CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8F228A455
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D77D3EC;
	Tue, 12 Mar 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zBc4fSb0"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AD7D092
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257951; cv=none; b=sQX2wM3xD4xxb4U/OokpizgUMlfc0rD/O7anrTIjy8EhQ0O3XIBUWPS3NqIGQtJxr55HJkA3qmK2ooVkToyQtOir9kqH3+0q8+XE3cmcVNruKXzGOkxHqgN6kIwfEfJLpAnvlN5JTGVQ9hJGyB6Qs+wGTVfQEsC1QwVIGQYkjgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257951; c=relaxed/simple;
	bh=BjC71ox0EzPHqRA3Y0dPcF9yEQsm5iTnk/hEwgu30Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urRvSPnO/WsiWdlIoSS9UDYCGOUpcNOwtNqn89igv85ZHvf4Gvcs4y/T/kzCdS2VVINQumMDfNPJy393dWQPbPJ5zmLwJLdyTYTSwJicZWY5+tbxd/n645fWTdvV66l/R3i8NERiHfqecFBWq0wrdoQ0AwVDMRhKEMHMr9Ut7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zBc4fSb0; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60a3c48e70fso23462127b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710257947; x=1710862747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWZy9viPn3xVfMwSo1fLlHap3PyL9EaP0f09VNsk6Bo=;
        b=zBc4fSb0DGMiKxVi0pi9dbDLBPjBl2+1J+WpIhpFtkiaUKdxrd3LzDiDHsnN7UoUoV
         RHZRfaJd84TFrz6Sv86msSMYYkItB3/JIul+GjN7zSdR93RpDWGDp8Uhle21wXVZGzs9
         KWD108GxPl23MkmQD7Rd8GrIKSn9dtirk0ieignLAZc3opzBzl6zWaPeWdMqQ/Z1Iuh8
         YoCBdLfa25BBN1kN6RiVQAqVPQzjOOzbwf+emsvPn9ZVDtcq6Puv9XpNKt7vqbUI1Rui
         cIBIMOKhcz3bgv8lnvX3Rev/ODBT0k823VlJ3YUrzqii+fgE9boAh4BxTnJBNyPVP872
         rK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257947; x=1710862747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWZy9viPn3xVfMwSo1fLlHap3PyL9EaP0f09VNsk6Bo=;
        b=QsFZn+MrhGeykUMb6k6qk3QDXNh+Gs/ubBYbysi7PsO+EHzTkSBuvWc3RfdB8vRYir
         DCm/V8LV673RuKuVZpzvLcD4upCf/rUqVM3/fA9l1Vgxg2Kb4WPwYyLoFH3VQ36ni/Wh
         GpgYzntDj9x7MhoioDQVqaIHdjl1aHS3XD+WCBKPmSD+I3CGgZM/jSoml5zrFC1kGVrV
         xBpcy90vE1ZPAuqu/3v3eNgop0FVm7TWX4Jw2nW7DnWT7BpRjnX+BudSReg7ZtjW86Zt
         uuM4U94p1nZttSUd4+9b+0gkEHLGi+wVSjdaytDArwJwgzH1Rsuanwqi7VS7QvMB8YDm
         jKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcNexKE06f0kn7hKnqqVVqrQC/WfLd72lYpGi4SvZV6C6vWr3zwNduQcMmoqZuiIUloQ5FqpasAObW47LgBTzyk5hsd3phiHEIi1V/
X-Gm-Message-State: AOJu0YywhjdftFjt8tZurK8PAjt3iDjjny0Gq++MJs3RMiYl5yrW062q
	PALv/Kf1wL+rG8u1fYGoTLnl3WFIkYwUq/pmpsm54DrfScb2uasohnD5zW0i214=
X-Google-Smtp-Source: AGHT+IHDHnX9SmKbMH9otvB7qodDk5ietPk+zbRHlckOs6d8X6iQGzYMyKQrhCJWwH2JcNl/HDRb4A==
X-Received: by 2002:a25:db86:0:b0:dc6:ddfc:1736 with SMTP id g128-20020a25db86000000b00dc6ddfc1736mr8146867ybf.17.1710257947206;
        Tue, 12 Mar 2024 08:39:07 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id k16-20020a0cfa50000000b00691012c2042sm256432qvo.127.2024.03.12.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:39:06 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH V2 1/2] mm: zswap: optimize zswap pool size tracking
Date: Tue, 12 Mar 2024 11:34:11 -0400
Message-ID: <20240312153901.3441-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Profiling the munmap() of a zswapped memory region shows 60% of the
total cycles currently going into updating the zswap_pool_total_size.

There are three consumers of this counter:
- store, to enforce the globally configured pool limit
- meminfo & debugfs, to report the size to the user
- shrink, to determine the batch size for each cycle

Instead of aggregating everytime an entry enters or exits the zswap
pool, aggregate the value from the zpools on-demand:

- Stores aggregate the counter anyway upon success. Aggregating to
  check the limit instead is the same amount of work.

- Meminfo & debugfs might benefit somewhat from a pre-aggregated
  counter, but aren't exactly hotpaths.

- Shrinking can aggregate once for every cycle instead of doing it for
  every freed entry. As the shrinker might work on tens or hundreds of
  objects per scan cycle, this is a large reduction in aggregations.

The paths that benefit dramatically are swapin, swapoff, and
unmaps. There could be millions of pages being processed until
somebody asks for the pool size again. This eliminates the pool size
updates from those paths entirely.

Top profile entries for a 24G range munmap(), before:

    38.54%  zswap-unmap  [kernel.kallsyms]  [k] zs_zpool_total_size
    12.51%  zswap-unmap  [kernel.kallsyms]  [k] zpool_get_total_size
     9.10%  zswap-unmap  [kernel.kallsyms]  [k] zswap_update_total_size
     2.95%  zswap-unmap  [kernel.kallsyms]  [k] obj_cgroup_uncharge_zswap
     2.88%  zswap-unmap  [kernel.kallsyms]  [k] __slab_free
     2.86%  zswap-unmap  [kernel.kallsyms]  [k] xas_store

and after:

     7.70%  zswap-unmap  [kernel.kallsyms]  [k] __slab_free
     7.16%  zswap-unmap  [kernel.kallsyms]  [k] obj_cgroup_uncharge_zswap
     6.74%  zswap-unmap  [kernel.kallsyms]  [k] xas_store

It was also briefly considered to move to a single atomic in zswap
that is updated by the backends, since zswap only cares about the sum
of all pools anyway. However, zram directly needs per-pool information
out of zsmalloc. To keep the backend from having to update two atomics
every time, I opted for the lazy aggregation instead for now.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
---
 fs/proc/meminfo.c     |   3 +-
 include/linux/zswap.h |   2 +-
 mm/zswap.c            | 101 +++++++++++++++++++++---------------------
 3 files changed, 52 insertions(+), 54 deletions(-)

v2:
- added profile info (Yosry). Counter footprint is actually 60%, I had
  missed the third line in perf's graphed output previously.
- zswap_accept_thr_pages() helper (Yosry)
- fixed debugfs file missing newline (Yosry)
- added changelog note on a single zswap atomic for the backend size (Yosry)
- collected acks and reviews

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 45af9a989d40..245171d9164b 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -89,8 +89,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "SwapTotal:      ", i.totalswap);
 	show_val_kb(m, "SwapFree:       ", i.freeswap);
 #ifdef CONFIG_ZSWAP
-	seq_printf(m,  "Zswap:          %8lu kB\n",
-		   (unsigned long)(zswap_pool_total_size >> 10));
+	show_val_kb(m, "Zswap:          ", zswap_total_pages());
 	seq_printf(m,  "Zswapped:       %8lu kB\n",
 		   (unsigned long)atomic_read(&zswap_stored_pages) <<
 		   (PAGE_SHIFT - 10));
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 341aea490070..2a85b941db97 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -7,7 +7,6 @@
 
 struct lruvec;
 
-extern u64 zswap_pool_total_size;
 extern atomic_t zswap_stored_pages;
 
 #ifdef CONFIG_ZSWAP
@@ -27,6 +26,7 @@ struct zswap_lruvec_state {
 	atomic_long_t nr_zswap_protected;
 };
 
+unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 bool zswap_load(struct folio *folio);
 void zswap_invalidate(swp_entry_t swp);
diff --git a/mm/zswap.c b/mm/zswap.c
index 9a3237752082..1a5cc7298306 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -43,8 +43,6 @@
 /*********************************
 * statistics
 **********************************/
-/* Total bytes used by the compressed storage */
-u64 zswap_pool_total_size;
 /* The number of compressed pages currently stored in zswap */
 atomic_t zswap_stored_pages = ATOMIC_INIT(0);
 /* The number of same-value filled pages currently stored in zswap */
@@ -264,45 +262,6 @@ static inline struct zswap_tree *swap_zswap_tree(swp_entry_t swp)
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpools[0]))
 
-static bool zswap_is_full(void)
-{
-	return totalram_pages() * zswap_max_pool_percent / 100 <
-			DIV_ROUND_UP(zswap_pool_total_size, PAGE_SIZE);
-}
-
-static bool zswap_can_accept(void)
-{
-	return totalram_pages() * zswap_accept_thr_percent / 100 *
-				zswap_max_pool_percent / 100 >
-			DIV_ROUND_UP(zswap_pool_total_size, PAGE_SIZE);
-}
-
-static u64 get_zswap_pool_size(struct zswap_pool *pool)
-{
-	u64 pool_size = 0;
-	int i;
-
-	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
-		pool_size += zpool_get_total_size(pool->zpools[i]);
-
-	return pool_size;
-}
-
-static void zswap_update_total_size(void)
-{
-	struct zswap_pool *pool;
-	u64 total = 0;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(pool, &zswap_pools, list)
-		total += get_zswap_pool_size(pool);
-
-	rcu_read_unlock();
-
-	zswap_pool_total_size = total;
-}
-
 /*********************************
 * pool functions
 **********************************/
@@ -540,6 +499,33 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	return NULL;
 }
 
+static unsigned long zswap_max_pages(void)
+{
+	return totalram_pages() * zswap_max_pool_percent / 100;
+}
+
+static unsigned long zswap_accept_thr_pages(void)
+{
+	return zswap_max_pages() * zswap_accept_thr_percent / 100;
+}
+
+unsigned long zswap_total_pages(void)
+{
+	struct zswap_pool *pool;
+	u64 total = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &zswap_pools, list) {
+		int i;
+
+		for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
+			total += zpool_get_total_size(pool->zpools[i]);
+	}
+	rcu_read_unlock();
+
+	return total >> PAGE_SHIFT;
+}
+
 /*********************************
 * param callbacks
 **********************************/
@@ -912,7 +898,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	}
 	zswap_entry_cache_free(entry);
 	atomic_dec(&zswap_stored_pages);
-	zswap_update_total_size();
 }
 
 /*
@@ -1317,7 +1302,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
 #else
 	/* use pool stats instead of memcg stats */
-	nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
+	nr_backing = zswap_total_pages();
 	nr_stored = atomic_read(&zswap_nr_stored);
 #endif
 
@@ -1385,6 +1370,10 @@ static void shrink_worker(struct work_struct *w)
 {
 	struct mem_cgroup *memcg;
 	int ret, failures = 0;
+	unsigned long thr;
+
+	/* Reclaim down to the accept threshold */
+	thr = zswap_accept_thr_pages();
 
 	/* global reclaim will select cgroup in a round-robin fashion. */
 	do {
@@ -1432,10 +1421,9 @@ static void shrink_worker(struct work_struct *w)
 			break;
 		if (ret && ++failures == MAX_RECLAIM_RETRIES)
 			break;
-
 resched:
 		cond_resched();
-	} while (!zswap_can_accept());
+	} while (zswap_total_pages() > thr);
 }
 
 static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
@@ -1476,6 +1464,7 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *dupentry;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
+	unsigned long max_pages, cur_pages;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1487,6 +1476,7 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_enabled)
 		goto check_old;
 
+	/* Check cgroup limits */
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
 		memcg = get_mem_cgroup_from_objcg(objcg);
@@ -1497,15 +1487,18 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	/* reclaim space if needed */
-	if (zswap_is_full()) {
+	/* Check global limits */
+	cur_pages = zswap_total_pages();
+	max_pages = zswap_max_pages();
+
+	if (cur_pages >= max_pages) {
 		zswap_pool_limit_hit++;
 		zswap_pool_reached_full = true;
 		goto shrink;
 	}
 
 	if (zswap_pool_reached_full) {
-	       if (!zswap_can_accept())
+		if (cur_pages > zswap_accept_thr_pages())
 			goto shrink;
 		else
 			zswap_pool_reached_full = false;
@@ -1581,7 +1574,6 @@ bool zswap_store(struct folio *folio)
 
 	/* update stats */
 	atomic_inc(&zswap_stored_pages);
-	zswap_update_total_size();
 	count_vm_event(ZSWPOUT);
 
 	return true;
@@ -1711,6 +1703,13 @@ void zswap_swapoff(int type)
 
 static struct dentry *zswap_debugfs_root;
 
+static int debugfs_get_total_size(void *data, u64 *val)
+{
+	*val = zswap_total_pages() * PAGE_SIZE;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, "%llu\n");
+
 static int zswap_debugfs_init(void)
 {
 	if (!debugfs_initialized())
@@ -1732,8 +1731,8 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
 	debugfs_create_u64("written_back_pages", 0444,
 			   zswap_debugfs_root, &zswap_written_back_pages);
-	debugfs_create_u64("pool_total_size", 0444,
-			   zswap_debugfs_root, &zswap_pool_total_size);
+	debugfs_create_file("pool_total_size", 0444,
+			    zswap_debugfs_root, NULL, &total_size_fops);
 	debugfs_create_atomic_t("stored_pages", 0444,
 				zswap_debugfs_root, &zswap_stored_pages);
 	debugfs_create_atomic_t("same_filled_pages", 0444,
-- 
2.44.0


