Return-Path: <linux-kernel+bounces-150291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9A48A9CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04BDB277A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9316C861;
	Thu, 18 Apr 2024 14:20:27 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257916C852
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450027; cv=none; b=kuNVnUpZhV2XTynYgcY8CqZxn8sQsnFz/IJcF2WQ4JAQpWBekBDxU2/kQ5f0tJpaVb3ChHVQhBgWORA7zO5Eby1PYfwUIytMiR7CduJf8ZruBKIDyjF/0VjqSV3ZjWO2G9rcJZqzNZJ+NXM6/ESnkZ2fQUNKDwmiSziVOPJyH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450027; c=relaxed/simple;
	bh=yN02vDdA73XbkzuEVpO9Jpre9qVR28t2iJxR7y3j8a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiRxZ9ixsUg0JI/9hHCAmo1M+rHqSjiq0NSIM+xBLR22880hCAMouZDafDItX4Pzugm03dWdYCJ8xV0TnU20WCyE4acP3VB/rjKB9P+KnqsmH/7P9Lprha/uZ+pn3U3qLpcGUgr6ekVBKId4UiGwmqC9aitjgcOYUNPnX3CBLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VL0G20QnKzXlRQ;
	Thu, 18 Apr 2024 22:16:58 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 98AD218006B;
	Thu, 18 Apr 2024 22:20:18 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 22:20:17 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <dennisszhou@gmail.com>,
	<shakeelb@google.com>, <jack@suse.cz>, <surenb@google.com>,
	<kent.overstreet@linux.dev>, <mhocko@suse.cz>, <vbabka@suse.cz>,
	<yuzhao@google.com>, <yu.ma@intel.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <zhangpeng362@huawei.com>
Subject: [RFC PATCH v2 1/2] percpu_counter: introduce atomic mode for percpu_counter
Date: Thu, 18 Apr 2024 22:20:07 +0800
Message-ID: <20240418142008.2775308-2-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418142008.2775308-1-zhangpeng362@huawei.com>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)

From: ZhangPeng <zhangpeng362@huawei.com>

Depending on whether counters is NULL, we can support two modes:
atomic mode and perpcu mode. We implement both modes by grouping
the s64 count and atomic64_t count_atomic in a union. At the same time,
we create the interface for adding and reading in atomic mode and for
switching atomic mode to percpu mode.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/percpu_counter.h | 43 +++++++++++++++++++++++++++++++---
 lib/percpu_counter.c           | 31 ++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 3a44dd1e33d2..160f9734c0bb 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -21,7 +21,13 @@
 
 struct percpu_counter {
 	raw_spinlock_t lock;
-	s64 count;
+	/* Depending on whether counters is NULL, we can support two modes,
+	 * atomic mode using count_atomic and perpcu mode using count.
+	 */
+	union {
+		s64 count;
+		atomic64_t count_atomic;
+	};
 #ifdef CONFIG_HOTPLUG_CPU
 	struct list_head list;	/* All percpu_counters are on a list */
 #endif
@@ -32,14 +38,14 @@ extern int percpu_counter_batch;
 
 int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
 			       gfp_t gfp, u32 nr_counters,
-			       struct lock_class_key *key);
+			       struct lock_class_key *key, bool switch_mode);
 
 #define percpu_counter_init_many(fbc, value, gfp, nr_counters)		\
 	({								\
 		static struct lock_class_key __key;			\
 									\
 		__percpu_counter_init_many(fbc, value, gfp, nr_counters,\
-					   &__key);			\
+					   &__key, false);		\
 	})
 
 
@@ -130,6 +136,20 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
 	return (fbc->counters != NULL);
 }
 
+static inline s64 percpu_counter_atomic_read(struct percpu_counter *fbc)
+{
+	return atomic64_read(&fbc->count_atomic);
+}
+
+static inline void percpu_counter_atomic_add(struct percpu_counter *fbc,
+					     s64 amount)
+{
+	atomic64_add(amount, &fbc->count_atomic);
+}
+
+int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
+				       u32 nr_counters);
+
 #else /* !CONFIG_SMP */
 
 struct percpu_counter {
@@ -260,6 +280,23 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
 static inline void percpu_counter_sync(struct percpu_counter *fbc)
 {
 }
+
+static inline s64 percpu_counter_atomic_read(struct percpu_counter *fbc)
+{
+	return fbc->count;
+}
+
+static inline void percpu_counter_atomic_add(struct percpu_counter *fbc,
+					     s64 amount)
+{
+	percpu_counter_add(fbc, amount);
+}
+
+static inline int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
+						     u32 nr_counters)
+{
+	return 0;
+}
 #endif	/* CONFIG_SMP */
 
 static inline void percpu_counter_inc(struct percpu_counter *fbc)
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 44dd133594d4..95c4e038051a 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -153,7 +153,7 @@ EXPORT_SYMBOL(__percpu_counter_sum);
 
 int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
 			       gfp_t gfp, u32 nr_counters,
-			       struct lock_class_key *key)
+			       struct lock_class_key *key, bool switch_mode)
 {
 	unsigned long flags __maybe_unused;
 	size_t counter_size;
@@ -174,7 +174,8 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
 #ifdef CONFIG_HOTPLUG_CPU
 		INIT_LIST_HEAD(&fbc[i].list);
 #endif
-		fbc[i].count = amount;
+		if (likely(!switch_mode))
+			fbc[i].count = amount;
 		fbc[i].counters = (void *)counters + (i * counter_size);
 
 		debug_percpu_counter_activate(&fbc[i]);
@@ -357,6 +358,32 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 	return good;
 }
 
+/*
+ * percpu_counter_switch_to_pcpu_many: Converts struct percpu_counters from
+ * atomic mode to percpu mode.
+ */
+int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
+				       u32 nr_counters)
+{
+	static struct lock_class_key __key;
+	unsigned long flags;
+	bool ret = 0;
+
+	if (percpu_counter_initialized(fbc))
+		return 0;
+
+	preempt_disable();
+	local_irq_save(flags);
+	if (likely(!percpu_counter_initialized(fbc)))
+		ret = __percpu_counter_init_many(fbc, 0,
+					GFP_ATOMIC|__GFP_NOWARN|__GFP_ZERO,
+					nr_counters, &__key, true);
+	local_irq_restore(flags);
+	preempt_enable();
+
+	return ret;
+}
+
 static int __init percpu_counter_startup(void)
 {
 	int ret;
-- 
2.25.1


