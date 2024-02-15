Return-Path: <linux-kernel+bounces-66211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED0A85588C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007F11F21936
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE5710F4;
	Thu, 15 Feb 2024 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvFyLvve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E42EC7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958951; cv=none; b=OWll6qycrFFxlYL8Rl0GRHXt7PBAl8jusllgMVm19r+HmqBdGBzYOqpWlnhXpgtkOxcGP73y1kyZhbSvQg6VA1OBNCDnvlOZvx4bl+m9qgvb1sLEjzZEyMGyQJ+zvAUgSXbaK+RhQSckRpsHDE8s6eonZoJfT0xHyDCtU5PcmZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958951; c=relaxed/simple;
	bh=vxbCUjb2siC8gO3MI0ihjF8F/AbZiW4QI18D4VWKOfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OU277aut4VOCRfEuBetxzjN8D9GcCUQ28Bb9tV5v37YW8TbMug0YKCT5kOqraLUl65VotR3ODFUrxfPD7tR7KOMtQunh0vAFkwBMvZHFURjfpI3Il7zi4fRJLuxzLLZm9ILm8wTQo8kUqd+vl2biJJKINySaVg10pnOVuUqKcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvFyLvve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE9C433F1;
	Thu, 15 Feb 2024 01:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958951;
	bh=vxbCUjb2siC8gO3MI0ihjF8F/AbZiW4QI18D4VWKOfo=;
	h=From:Date:Subject:To:Cc:From;
	b=nvFyLvvevhmQzN4QxWdsxAjdizMx+oVdrGsS/A9guWvjpVMnqREOFbwOE3P8WtkEg
	 Yh16v9GXp3NTxlSMoF/ySq2gb1rVwMP/xK5yh2YrrpzwWC6UuLn3P7pU15R9T4NHvw
	 31SZfo+8PjxkIxECKkm1mQk6r9B9nVdZPjFgT+IBorNt4ZYVsyVyDsOCURczdQu2wT
	 LdV2Iznax/rBkL923BLAjfFjVUmPrUa75rPrTgWz3wsmwXblIMloy2e3r8WvYjb638
	 Q8nwUtq5bvoBkh/1mEPWAn+B50lwC9vI/OJOWY+0eOnfl3FuMb56/w1gNuywC7blMq
	 tlZI5sOVchDHA==
From: Chris Li <chrisl@kernel.org>
Date: Wed, 14 Feb 2024 17:02:13 -0800
Subject: [PATCH v4] mm: swap: async free swap slot cache entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-async-free-v4-1-6abe0d59f85f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJRizWUC/2XMQQ6CMBCF4auQrq3pzBShrryHcQF1gEYDpjVEQ
 ri7hWgUXb6XfP8oAnvHQeyTUXjuXXBdG4feJMI2RVuzdOe4BSokQNjJIgytlZVnliVXZFBBqgl
 FBDfPlXssseMp7saFe+eHpd3D/L4yCN+ZHiRIo0vMMmPQlupwYd/yddv5WsydHt9WK6C1xWhTT
 CtFrDLI9Z+lj0WglaVoy9xYslbn9GOnaXoCqHIsMh0BAAA=
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
 Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
 Yosry Ahmed <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
 Nhat Pham <nphamcs@gmail.com>, Kairui Song <kasong@tencent.com>, 
 Barry Song <v-songbaohua@oppo.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
 Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.12.4

We discovered that 1% swap page fault is 100us+ while 50% of
the swap fault is under 20us.

Further investigation shows that a large portion of the time
spent in the free_swap_slots() function for the long tail case.

The percpu cache of swap slots is freed in a batch of 64 entries
inside free_swap_slots(). These cache entries are accumulated
from previous page faults, which may not be related to the current
process.

Doing the batch free in the page fault handler causes longer
tail latencies and penalizes the current process.

When the swap cache slot is full, schedule async free cached
swap slots in a work queue, before the next swap fault comes in.
If the next swap fault comes in very fast, before the async
free gets a chance to run. It will directly free all the swap
cache in the swap fault the same way as previously.

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
---
Changes in v4:
- Remove the sysfs interface file, according the feedback.
- Move the full condition test inside the spinlock.
- Link to v3: https://lore.kernel.org/r/20240213-async-free-v3-1-b89c3cc48384@kernel.org

Changes in v3:
- Address feedback from Tim Chen, direct free path will free all swap slots.
- Add /sys/kernel/mm/swap/swap_slot_async_fee to enable async free. Default is off.
- Link to v2: https://lore.kernel.org/r/20240131-async-free-v2-1-525f03e07184@kernel.org

Changes in v2:
- Add description of the impact of time changing suggest by Ying.
- Remove create_workqueue() and use schedule_work()
- Link to v1: https://lore.kernel.org/r/20231221-async-free-v1-1-94b277992cb0@kernel.org
---
 include/linux/swap_slots.h |  1 +
 mm/swap_slots.c            | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index 0bec1f705f8e..23dc04bce9ca 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -44,6 +44,7 @@ static DEFINE_MUTEX(swap_slots_cache_mutex);
 static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
 
 static void __drain_swap_slots_cache(unsigned int type);
+static void swapcache_async_free_entries(struct work_struct *data);
 
 #define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache_enabled)
 #define SLOTS_CACHE 0x1
@@ -149,6 +150,7 @@ static int alloc_swap_slot_cache(unsigned int cpu)
 		spin_lock_init(&cache->free_lock);
 		cache->lock_initialized = true;
 	}
+	INIT_WORK(&cache->async_free, swapcache_async_free_entries);
 	cache->nr = 0;
 	cache->cur = 0;
 	cache->n_ret = 0;
@@ -269,12 +271,27 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 	return cache->nr;
 }
 
+static void swapcache_async_free_entries(struct work_struct *data)
+{
+	struct swap_slots_cache *cache;
+
+	cache = container_of(data, struct swap_slots_cache, async_free);
+	spin_lock_irq(&cache->free_lock);
+	/* Swap slots cache may be deactivated before acquiring lock */
+	if (cache->slots_ret && cache->n_ret) {
+		swapcache_free_entries(cache->slots_ret, cache->n_ret);
+		cache->n_ret = 0;
+	}
+	spin_unlock_irq(&cache->free_lock);
+}
+
 void free_swap_slot(swp_entry_t entry)
 {
 	struct swap_slots_cache *cache;
 
 	cache = raw_cpu_ptr(&swp_slots);
 	if (likely(use_swap_slot_cache && cache->slots_ret)) {
+		bool full;
 		spin_lock_irq(&cache->free_lock);
 		/* Swap slots cache may be deactivated before acquiring lock */
 		if (!use_swap_slot_cache || !cache->slots_ret) {
@@ -292,7 +309,10 @@ void free_swap_slot(swp_entry_t entry)
 			cache->n_ret = 0;
 		}
 		cache->slots_ret[cache->n_ret++] = entry;
+		full = cache->n_ret >= SWAP_SLOTS_CACHE_SIZE;
 		spin_unlock_irq(&cache->free_lock);
+		if (full)
+			schedule_work(&cache->async_free);
 	} else {
 direct_free:
 		swapcache_free_entries(&entry, 1);

---
base-commit: eacce8189e28717da6f44ee492b7404c636ae0de
change-id: 20231216-async-free-bef392015432

Best regards,
-- 
Chris Li <chrisl@kernel.org>


