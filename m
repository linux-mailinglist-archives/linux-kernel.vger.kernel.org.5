Return-Path: <linux-kernel+bounces-9401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2DD81C506
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D48C1F25558
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B379D4;
	Fri, 22 Dec 2023 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ4L/qUY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4E6FBC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F22C433C8;
	Fri, 22 Dec 2023 06:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703226349;
	bh=Jx2LL9VBtn7EevKYNjfg9tbjditIKurBb4A4cGkVspA=;
	h=From:Date:Subject:To:Cc:From;
	b=EZ4L/qUYdprfHbJoQZRCR24HRA73UxZyM04nbiV0MwPPACXOlRk+noH0bnkYTGFEu
	 aJjKpjm7vAsibAks0LYcZAKROonVVgLcfGqJk/BgMT0P3tu/mKjz5dZDMSA9i+1HIv
	 IivYWjzxgQdeXK/USykiZeGbm/4dK3CV4iEp4zWEZa3jdvniszsVEQZB9rxSa8vW0F
	 lMDgm/0uRF36MWMZWoxwj9xC9TZ8+jnwRT+zRzKGTqgixXtEkwFdVeucx4+cUKIeWU
	 ygQVGyy2RSrSvtADiI5dCYEx7KVEfboVTVd6Q7v9skpAec3ltil0W0GqUzT9eb8b+c
	 ufTIrxVr+pE6w==
From: Chris Li <chrisl@kernel.org>
Date: Thu, 21 Dec 2023 22:25:39 -0800
Subject: [PATCH] mm: swap: async free swap slot cache entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOIrhWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0Mz3cTiyrxk3bSi1FTdpNQ0Y0sjA0NTE2MjJaCGgqLUtMwKsGHRsbW
 1AKOxhW1cAAAA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 =?utf-8?q?Wei_Xu=EF=BF=BC?= <weixugc@google.com>, 
 =?utf-8?q?Yu_Zhao=EF=BF=BC?= <yuzhao@google.com>, 
 Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
 =?utf-8?q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
 =?utf-8?q?Yosry_Ahmed=EF=BF=BC?= <yosryahmed@google.com>, 
 Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, 
 Huang Ying <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
 Zhongkun He <hezhongkun.hzk@bytedance.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Barry Song <v-songbaohua@oppo.com>, 
 Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.12.3

We discovered that 1% swap page fault is 100us+ while 50% of
the swap fault is under 20us.

Further investigation show that a large portion of the time
spent in the free_swap_slots() function for the long tail case.

The percpu cache of swap slots is freed in a batch of 64 entries
inside free_swap_slots(). These cache entries are accumulated
from previous page faults, which may not be related to the current
process.

Doing the batch free in the page fault handler causes longer
tail latencies and penalizes the current process.

Move free_swap_slots() outside of the swapin page fault handler into an
async work queue to avoid such long tail latencies.

Testing:

Chun-Tse did some benchmark in chromebook, showing that
zram_wait_metrics improve about 15% with 80% and 95% confidence.

I recently ran some experiments on about 1000 Google production
machines. It shows swapin latency drops in the long tail
100us - 500us bucket dramatically.

platform	(100-500us)	 	(0-100us)
A		1.12% -> 0.36%		98.47% -> 99.22%
B		0.65% -> 0.15%		98.96% -> 99.46%
C		0.61% -> 0.23%		98.96% -> 99.38%

Signed-off-by: Chris Li <chrisl@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Wei Xu￼ <weixugc@google.com>
Cc: Yu Zhao￼ <yuzhao@google.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Chun-Tse Shao <ctshao@google.com>
Cc: Suren Baghdasaryan￼ <surenb@google.com>
Cc: Yosry Ahmed￼ <yosryahmed@google.com>
Cc: Brain Geffon <bgeffon@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/swap_slots.h |  1 +
 mm/swap_slots.c            | 37 +++++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
index 15adfb8c813a..67bc8fa30d63 100644
--- a/include/linux/swap_slots.h
+++ b/include/linux/swap_slots.h
@@ -19,6 +19,7 @@ struct swap_slots_cache {
 	spinlock_t	free_lock;  /* protects slots_ret, n_ret */
 	swp_entry_t	*slots_ret;
 	int		n_ret;
+	struct work_struct async_free;
 };
 
 void disable_swap_slots_cache_lock(void);
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0bec1f705f8e..a3b306550732 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -42,8 +42,10 @@ static bool	swap_slot_cache_initialized;
 static DEFINE_MUTEX(swap_slots_cache_mutex);
 /* Serialize swap slots cache enable/disable operations */
 static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
+static struct workqueue_struct *swap_free_queue;
 
 static void __drain_swap_slots_cache(unsigned int type);
+static void swapcache_async_free_entries(struct work_struct *data);
 
 #define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache_enabled)
 #define SLOTS_CACHE 0x1
@@ -149,6 +151,7 @@ static int alloc_swap_slot_cache(unsigned int cpu)
 		spin_lock_init(&cache->free_lock);
 		cache->lock_initialized = true;
 	}
+	INIT_WORK(&cache->async_free, swapcache_async_free_entries);
 	cache->nr = 0;
 	cache->cur = 0;
 	cache->n_ret = 0;
@@ -269,6 +272,20 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 	return cache->nr;
 }
 
+static void swapcache_async_free_entries(struct work_struct *data)
+{
+	struct swap_slots_cache *cache;
+
+	cache = container_of(data, struct swap_slots_cache, async_free);
+	spin_lock_irq(&cache->free_lock);
+	/* Swap slots cache may be deactivated before acquiring lock */
+	if (cache->slots_ret) {
+		swapcache_free_entries(cache->slots_ret, cache->n_ret);
+		cache->n_ret = 0;
+	}
+	spin_unlock_irq(&cache->free_lock);
+}
+
 void free_swap_slot(swp_entry_t entry)
 {
 	struct swap_slots_cache *cache;
@@ -282,17 +299,14 @@ void free_swap_slot(swp_entry_t entry)
 			goto direct_free;
 		}
 		if (cache->n_ret >= SWAP_SLOTS_CACHE_SIZE) {
-			/*
-			 * Return slots to global pool.
-			 * The current swap_map value is SWAP_HAS_CACHE.
-			 * Set it to 0 to indicate it is available for
-			 * allocation in global pool
-			 */
-			swapcache_free_entries(cache->slots_ret, cache->n_ret);
-			cache->n_ret = 0;
+			spin_unlock_irq(&cache->free_lock);
+			queue_work(swap_free_queue, &cache->async_free);
+			goto direct_free;
 		}
 		cache->slots_ret[cache->n_ret++] = entry;
 		spin_unlock_irq(&cache->free_lock);
+		if (cache->n_ret >= SWAP_SLOTS_CACHE_SIZE)
+			queue_work(swap_free_queue, &cache->async_free);
 	} else {
 direct_free:
 		swapcache_free_entries(&entry, 1);
@@ -348,3 +362,10 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 	}
 	return entry;
 }
+
+static int __init async_queue_init(void)
+{
+	swap_free_queue = create_workqueue("async swap cache");
+	return 0;
+}
+subsys_initcall(async_queue_init);

---
base-commit: eacce8189e28717da6f44ee492b7404c636ae0de
change-id: 20231216-async-free-bef392015432

Best regards,
-- 
Chris Li <chrisl@kernel.org>


