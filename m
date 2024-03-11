Return-Path: <linux-kernel+bounces-99192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145998784B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3787A1C208F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D647F7C;
	Mon, 11 Mar 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="lVxgJ9go"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542554AEC1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173546; cv=none; b=P+I3IjIPFhhr4GXnXg0XBZAicSEzkJKHJqlAnzZuGTgp3VzbJstiJuRAJlkPhotLM0qPEIF2x6HQMnyPNpshK7XAJXHa13nAxYKbI871916IWWbRah8G+PeM7gWYHwuz6Nu56B4fHdiDPJSux/NEBgY5y5DbDJC9kIZZxb3zsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173546; c=relaxed/simple;
	bh=R+SayAQZPNsrQCGIPKRPT8zODJZd7Em+eDjR+ljv420=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvlcIbVXht8/LPuaL3tcKOjnxcj5nApN44XXnPFlhS+Nzl6rLyOgvqiiEeF6CgQ5AQQFzFTBsqWp5pRmoFGc9aEhZRx2O5qQNGYg7oa6jvMfDOV+HGbMo1+PP4nVaWH84a2WzczwX2Ynp2Nw2KbAFCJXXJRG9ikExiMxgL0f2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=lVxgJ9go; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690c73735b5so16608736d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710173541; x=1710778341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rae8DczRYY1qVTc5krNA5vQiwAZfYKBrfNd8phx9FQ=;
        b=lVxgJ9gorX7fC9BqHjK5V0jvkX/cfIoh1FtZEhiSP9PM7Ha3fB7AY2rHCJ4JeEgS0Y
         f3dgJZHA6RKtIZpTH6Qnl8akSZwJNRAomO1bvw+UFNGaIcH72FO+qxCLvYc1Fe+fe+fJ
         rpPgrzx3unYXv5GHd43Q4LfpRWy/N0NuBe49LWn7VWYfz+YFfPe6Z8nVSeFJNs4XXg3X
         AdLnKQXkzOFMq55qHXrx1h8sAbQAGbUFvo3k4sKWjHAxRi57ttMQzvbhhlub7dm3YGOH
         eLbX2EELsQ28hykmZ+7byfknspS9gRjbCuH33E2BYX1zX5iuoBhh6cqRnIzyeDogvKDd
         YQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173541; x=1710778341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rae8DczRYY1qVTc5krNA5vQiwAZfYKBrfNd8phx9FQ=;
        b=HJhF065FeHp8BTBnohHS5tqtJrX2O9PpatNelaDCGHgorHHm4sHOc8gD0ENLiiy4lh
         eGTl4gDK5tfG4u/QHY1DnNaf7NeozBLrA46GBUHv2dJiexP9FpOJJVK/Jp6K4xnuvVd4
         Sim0Mg3Rf4aJqUhDOK9o8cvWPux5N1HfndVLxrSi98Pq+x+AFE0sx8tbpo0lC5rIn6WS
         5bIOKVC3b7E0sTCBtHv050v3TR0SdX6EFZjuFdkbFEib7CMANN0jP7aTezAQP93xcNg6
         VZroO+TsH8LJ4Qzc2csAJI0dG9orJNz4d7fHuWNI7nSl85fG10JDDZDoab2z2l40Qq1r
         sDvw==
X-Forwarded-Encrypted: i=1; AJvYcCXeXljwg1v+4+rseMwkM3kutlrZoj+GVpePGR+uCNH4w6iF+8WtoZ92znVRxqYQw91Mq9vx1lpuyMk5HpVqR9cAddb0Qx8Gf/OYpb5+
X-Gm-Message-State: AOJu0YweyYDgcA9KTkflIJLVQRVhzx9UWMZCkGrZ7AKriU1vzQ/RvDzD
	u7gdygid1jzbq1OClGVrRtjQY/0GQKosY7Ewg5DoaDqGrUj8Lh+5e+JtamHGdV8=
X-Google-Smtp-Source: AGHT+IF1lXMtfLql23ntUBZ5Bx3lRSL4pD/LtPVgSinUp2k9OQFjpcIS4RA39FA+WPNkw9m4xQHQ4Q==
X-Received: by 2002:a0c:fa82:0:b0:690:aed1:bd8f with SMTP id o2-20020a0cfa82000000b00690aed1bd8fmr7127592qvn.57.1710173540994;
        Mon, 11 Mar 2024 09:12:20 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id p6-20020a0cf546000000b00690d2ed0d74sm1115722qvm.115.2024.03.11.09.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:12:20 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: zswap: optimize zswap pool size tracking
Date: Mon, 11 Mar 2024 12:12:13 -0400
Message-ID: <20240311161214.1145168-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Profiling the munmap() of a zswapped memory region shows 50%(!) of the
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

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/proc/meminfo.c     |  3 +-
 include/linux/zswap.h |  2 +-
 mm/zswap.c            | 98 +++++++++++++++++++++----------------------
 3 files changed, 49 insertions(+), 54 deletions(-)

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
index 9a3237752082..7c39327a7cc2 100644
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
@@ -540,6 +499,28 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	return NULL;
 }
 
+static unsigned long zswap_max_pages(void)
+{
+	return totalram_pages() * zswap_max_pool_percent / 100;
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
@@ -912,7 +893,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	}
 	zswap_entry_cache_free(entry);
 	atomic_dec(&zswap_stored_pages);
-	zswap_update_total_size();
 }
 
 /*
@@ -1317,7 +1297,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
 #else
 	/* use pool stats instead of memcg stats */
-	nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
+	nr_backing = zswap_total_pages();
 	nr_stored = atomic_read(&zswap_nr_stored);
 #endif
 
@@ -1385,6 +1365,10 @@ static void shrink_worker(struct work_struct *w)
 {
 	struct mem_cgroup *memcg;
 	int ret, failures = 0;
+	unsigned long thr;
+
+	/* Reclaim down to the accept threshold */
+	thr = zswap_max_pages() * zswap_accept_thr_percent / 100;
 
 	/* global reclaim will select cgroup in a round-robin fashion. */
 	do {
@@ -1432,10 +1416,9 @@ static void shrink_worker(struct work_struct *w)
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
@@ -1476,6 +1459,7 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *dupentry;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
+	unsigned long max_pages, cur_pages;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1487,6 +1471,7 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_enabled)
 		goto check_old;
 
+	/* Check cgroup limits */
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
 		memcg = get_mem_cgroup_from_objcg(objcg);
@@ -1497,15 +1482,20 @@ bool zswap_store(struct folio *folio)
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
+		unsigned long thr = max_pages * zswap_accept_thr_percent / 100;
+
+		if (cur_pages > thr)
 			goto shrink;
 		else
 			zswap_pool_reached_full = false;
@@ -1581,7 +1571,6 @@ bool zswap_store(struct folio *folio)
 
 	/* update stats */
 	atomic_inc(&zswap_stored_pages);
-	zswap_update_total_size();
 	count_vm_event(ZSWPOUT);
 
 	return true;
@@ -1711,6 +1700,13 @@ void zswap_swapoff(int type)
 
 static struct dentry *zswap_debugfs_root;
 
+static int debugfs_get_total_size(void *data, u64 *val)
+{
+	*val = zswap_total_pages() * PAGE_SIZE;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, "%llu");
+
 static int zswap_debugfs_init(void)
 {
 	if (!debugfs_initialized())
@@ -1732,8 +1728,8 @@ static int zswap_debugfs_init(void)
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


