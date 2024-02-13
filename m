Return-Path: <linux-kernel+bounces-64532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F852853FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E401F26524
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C46633E0;
	Tue, 13 Feb 2024 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p110QIDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A663123
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866463; cv=none; b=E9nD/2Sr82A9v3y4qX4KtWwJFcEwzvpSC+Eq3eaDvCEo4JdDTMLoeTr3HNrr1td80gnEoJU/DLenw6u9ke4dTrlizu7iTXoLnxS1LTpWq0PBKF4FmTU8RQr7u4xY3l1SmQD+VHGPrIBGUeWvpYi9Ir7v0P8ckLpA0Z4sNP1p9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866463; c=relaxed/simple;
	bh=EOUbn3otcSd8X/NKXin2lmernP0Kdf4cu7phiv4gtOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MhWpHwLhBuonj5V0WJDAT8HgXFcQ0oZuUDI7SYsCzOFevlVlee37r0vNq5Kr4TBoAVZXurUAUvfMXXKKm8GUCbtWRzSmPuY5i2DT+DpTZM5gEYjzioP5ybTTegKVW0iBwHTsbuZwTYujDqCmLaaECNu42LDlC+F8rkAcuhkaXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p110QIDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED851C43390;
	Tue, 13 Feb 2024 23:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707866462;
	bh=EOUbn3otcSd8X/NKXin2lmernP0Kdf4cu7phiv4gtOY=;
	h=From:Date:Subject:To:Cc:From;
	b=p110QIDsEhAKXdFBNDgjhpA2hMfBUIWDUKoFMH39dK9vOpc0UzUWDJ0TWcS6EWVld
	 jGIi9TyjG2nt/FRsiUQnTuDjwR4k8cRYPnW/ZaqRs9/Fjhcq53J0HYqCprKjnopJEX
	 VGfh7TUITjtD9x+9V3ySwFxJCXWcPiGFW8wWwmwlMXX0o6B2KaQO3Cj67v4pFYkE81
	 PZXZksUz3vH5czIWT+pHZV8nYiESkQVCVjb5mJ8GnIwf5jc+cNqFzpnIE6UGNmmJnf
	 6Eb6NFs9yPAOvZkYx6Fj/MryOzoNPmXWgQSRSpvTQ7nlm8BfrWw+9+FhKF+f83GxhA
	 SgQdAyWZd/EPQ==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 13 Feb 2024 15:20:49 -0800
Subject: [PATCH v3] mm: swap: async free swap slot cache entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-async-free-v3-1-b89c3cc48384@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFD5y2UC/1XMQQrCMBCF4auUWRvJTFJrXHkPcdHWSRuUVBIJl
 tK7mxYFu3wP/m+CyMFxhFMxQeDkoht8HmpXQNvXvmPhbnkDSVJIeBB1HH0rbGAWDVtlSGKpFUE
 OnoGte6/Y5Zp37+JrCONqJ1zeL0P4zyQUKIxuqKqMobaR5zsHz4/9EDpYnES/VktU25ZyW1Jpp
 WJZ4VFv2nmeP3hFtdXhAAAA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
 Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
 Yosry Ahmed <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
 Nhat Pham <nphamcs@gmail.com>, Kairui Song <kasong@tencent.com>, 
 Barry Song <v-songbaohua@oppo.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
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

Add /sys/kernel/mm/swap/swap_slot_async_free to control the
async free behavior. When enabled, using work queue to async
free the swap slot when the swap slot cache is full.

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
Changes in v3:
- Address feedback from Tim Chen, direct free path will free all swap slots.
- Add /sys/kernel/mm/swap/swap_slot_async_fee to enable async free. Default is off.
- Link to v2: https://lore.kernel.org/r/20240131-async-free-v2-1-525f03e07184@kernel.org

Changes in v2:
- Add description of the impact of time changing suggest by Ying.
- Remove create_workqueue() and use schedule_work()
- Link to v1: https://lore.kernel.org/r/20231221-async-free-v1-1-94b277992cb0@kernel.org
---
 include/linux/swap_slots.h |  2 ++
 mm/swap_slots.c            | 20 ++++++++++++++++++++
 mm/swap_state.c            | 23 +++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
index 15adfb8c813a..bb9a401d7cae 100644
--- a/include/linux/swap_slots.h
+++ b/include/linux/swap_slots.h
@@ -19,6 +19,7 @@ struct swap_slots_cache {
 	spinlock_t	free_lock;  /* protects slots_ret, n_ret */
 	swp_entry_t	*slots_ret;
 	int		n_ret;
+	struct work_struct async_free;
 };
 
 void disable_swap_slots_cache_lock(void);
@@ -27,5 +28,6 @@ void enable_swap_slots_cache(void);
 void free_swap_slot(swp_entry_t entry);
 
 extern bool swap_slot_cache_enabled;
+extern uint8_t slot_cache_async_free __read_mostly;
 
 #endif /* _LINUX_SWAP_SLOTS_H */
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0bec1f705f8e..9e9bc0ffb215 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -38,12 +38,15 @@
 static DEFINE_PER_CPU(struct swap_slots_cache, swp_slots);
 static bool	swap_slot_cache_active;
 bool	swap_slot_cache_enabled;
+uint8_t	slot_cache_async_free;
+
 static bool	swap_slot_cache_initialized;
 static DEFINE_MUTEX(swap_slots_cache_mutex);
 /* Serialize swap slots cache enable/disable operations */
 static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
 
 static void __drain_swap_slots_cache(unsigned int type);
+static void swapcache_async_free_entries(struct work_struct *data);
 
 #define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache_enabled)
 #define SLOTS_CACHE 0x1
@@ -149,6 +152,7 @@ static int alloc_swap_slot_cache(unsigned int cpu)
 		spin_lock_init(&cache->free_lock);
 		cache->lock_initialized = true;
 	}
+	INIT_WORK(&cache->async_free, swapcache_async_free_entries);
 	cache->nr = 0;
 	cache->cur = 0;
 	cache->n_ret = 0;
@@ -269,6 +273,20 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
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
@@ -293,6 +311,8 @@ void free_swap_slot(swp_entry_t entry)
 		}
 		cache->slots_ret[cache->n_ret++] = entry;
 		spin_unlock_irq(&cache->free_lock);
+		if (slot_cache_async_free && cache->n_ret >= SWAP_SLOTS_CACHE_SIZE)
+			schedule_work(&cache->async_free);
 	} else {
 direct_free:
 		swapcache_free_entries(&entry, 1);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e671266ad772..e4549f33556b 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -912,8 +912,31 @@ static ssize_t vma_ra_enabled_store(struct kobject *kobj,
 }
 static struct kobj_attribute vma_ra_enabled_attr = __ATTR_RW(vma_ra_enabled);
 
+static ssize_t swap_slot_async_free_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", READ_ONCE(slot_cache_async_free));
+}
+static ssize_t swap_slot_async_free_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	ssize_t ret;
+	int val;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+	WRITE_ONCE(slot_cache_async_free, !!val);
+	return count;
+}
+static struct kobj_attribute swap_slot_async_free_attr =
+	__ATTR(swap_slot_async_free, 0644, swap_slot_async_free_show,
+	       swap_slot_async_free_store);
+
 static struct attribute *swap_attrs[] = {
 	&vma_ra_enabled_attr.attr,
+	&swap_slot_async_free_attr.attr,
 	NULL,
 };
 

---
base-commit: eacce8189e28717da6f44ee492b7404c636ae0de
change-id: 20231216-async-free-bef392015432

Best regards,
-- 
Chris Li <chrisl@kernel.org>


