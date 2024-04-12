Return-Path: <linux-kernel+bounces-142402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854AB8A2B22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99CCB276AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646F535DC;
	Fri, 12 Apr 2024 09:24:59 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383CC51C50
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913899; cv=none; b=EqDVBQ2gxB0Ys1QFLMY4YdK1PFs5gpZ8yKzxb8avBlVMKxgnUxcasuv/uy9Da50LiW4WbWw1NOCAUfRVKDSdlyhk0xBA0zlMP8ZZ9KtM/C1Uk0H1TXyda5leS2H0RmEEwsen7n7NJB0QHAI6urbrUZDdU0ECvN/fmBfZx5IKN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913899; c=relaxed/simple;
	bh=8lnR8zRqLwOO46roCZhHT5is87jP2DPUwMS/Zy2/3kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDEReul9u6h/hVFiwIjdndeaF51PhHAd9lgweVsSO7+VU6IOh90Q3DlvGvGsf4a4mcswuDRUIa753A11Q+/h1JUKwFFPQy/XPw6LzDCEJ5bqa5kvhBr9qghxO3alPDxaFkBKoZom33PjYbCwX+BH5EpiyKb4Kdy6tbu3togGj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VGB0L1sf0zwS0n;
	Fri, 12 Apr 2024 17:21:54 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id CF99218007B;
	Fri, 12 Apr 2024 17:24:51 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:24:50 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <dennisszhou@gmail.com>,
	<shakeelb@google.com>, <jack@suse.cz>, <surenb@google.com>,
	<kent.overstreet@linux.dev>, <mhocko@suse.cz>, <vbabka@suse.cz>,
	<yuzhao@google.com>, <yu.ma@intel.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <zhangpeng362@huawei.com>
Subject: [RFC PATCH 2/3] lazy_percpu_counter: include struct percpu_counter in struct lazy_percpu_counter
Date: Fri, 12 Apr 2024 17:24:40 +0800
Message-ID: <20240412092441.3112481-3-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412092441.3112481-1-zhangpeng362@huawei.com>
References: <20240412092441.3112481-1-zhangpeng362@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)

From: ZhangPeng <zhangpeng362@huawei.com>

Add the struct percpu_counter fbc to struct lazy_percpu_counter.
Convert the u64 __percpu parameter of the lazy percpu counter function
to the struct percpu_counter parameter to prepare for converting
mm's rss stats into lazy_percpu_counter.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/lazy-percpu-counter.h | 16 ++++--
 lib/lazy-percpu-counter.c           | 83 +++++++++++++++++++++++------
 2 files changed, 77 insertions(+), 22 deletions(-)

diff --git a/include/linux/lazy-percpu-counter.h b/include/linux/lazy-percpu-counter.h
index 281b8dd88cb2..03ff24f0128d 100644
--- a/include/linux/lazy-percpu-counter.h
+++ b/include/linux/lazy-percpu-counter.h
@@ -20,15 +20,21 @@
 #define _LINUX_LAZY_PERCPU_COUNTER_H
 
 #include <linux/atomic.h>
+#include <linux/percpu_counter.h>
 #include <asm/percpu.h>
 
 struct lazy_percpu_counter {
 	atomic64_t			v;
 	unsigned long			last_wrap;
+	struct percpu_counter		fbc;
 };
 
-void lazy_percpu_counter_exit(struct lazy_percpu_counter *c);
+void lazy_percpu_counter_destroy_many(struct lazy_percpu_counter *c,
+				      u32 nr_counters);
 void lazy_percpu_counter_add_slowpath(struct lazy_percpu_counter *c, s64 i);
+s64 lazy_percpu_counter_read_positive(struct lazy_percpu_counter *c);
+s64 lazy_percpu_counter_sum(struct lazy_percpu_counter *c);
+s64 lazy_percpu_counter_sum_positive(struct lazy_percpu_counter *c);
 
 /*
  * We use the high bits of the atomic counter for a secondary counter, which is
@@ -48,13 +54,13 @@ void lazy_percpu_counter_add_slowpath(struct lazy_percpu_counter *c, s64 i);
  */
 #define COUNTER_IS_PCPU_BIT		1
 
-static inline u64 __percpu *lazy_percpu_counter_is_pcpu(u64 v)
+static inline struct percpu_counter *lazy_percpu_counter_is_pcpu(u64 v)
 {
 	if (!(v & COUNTER_IS_PCPU_BIT))
 		return NULL;
 
 	v ^= COUNTER_IS_PCPU_BIT;
-	return (u64 __percpu *)(unsigned long)v;
+	return (struct percpu_counter *)(unsigned long)v;
 }
 
 /**
@@ -66,10 +72,10 @@ static inline u64 __percpu *lazy_percpu_counter_is_pcpu(u64 v)
 static inline void lazy_percpu_counter_add(struct lazy_percpu_counter *c, s64 i)
 {
 	u64 v = atomic64_read(&c->v);
-	u64 __percpu *pcpu_v = lazy_percpu_counter_is_pcpu(v);
+	struct percpu_counter *pcpu_v = lazy_percpu_counter_is_pcpu(v);
 
 	if (likely(pcpu_v))
-		this_cpu_add(*pcpu_v, i);
+		percpu_counter_add(pcpu_v, i);
 	else
 		lazy_percpu_counter_add_slowpath(c, i);
 }
diff --git a/lib/lazy-percpu-counter.c b/lib/lazy-percpu-counter.c
index e1914207214d..c360903cc02a 100644
--- a/lib/lazy-percpu-counter.c
+++ b/lib/lazy-percpu-counter.c
@@ -15,45 +15,94 @@ static inline s64 lazy_percpu_counter_atomic_val(s64 v)
 
 static void lazy_percpu_counter_switch_to_pcpu(struct lazy_percpu_counter *c)
 {
-	u64 __percpu *pcpu_v = alloc_percpu_gfp(u64, GFP_ATOMIC|__GFP_NOWARN);
 	u64 old, new, v;
+	unsigned long flags;
+	bool allocated = false;
 
-	if (!pcpu_v)
-		return;
-
+	local_irq_save(flags);
 	preempt_disable();
 	v = atomic64_read(&c->v);
 	do {
-		if (lazy_percpu_counter_is_pcpu(v)) {
-			free_percpu(pcpu_v);
-			return;
+		if (lazy_percpu_counter_is_pcpu(v))
+			break;
+
+		if (!allocated) {
+			if (percpu_counter_init(&c->fbc, 0, GFP_ATOMIC|__GFP_NOWARN))
+				break;
+			allocated = true;
 		}
 
 		old = v;
-		new = (unsigned long)pcpu_v | 1;
+		new = (unsigned long)&c->fbc | 1;
 
-		*this_cpu_ptr(pcpu_v) = lazy_percpu_counter_atomic_val(v);
+		percpu_counter_set(&c->fbc, lazy_percpu_counter_atomic_val(v));
 	} while ((v = atomic64_cmpxchg(&c->v, old, new)) != old);
 	preempt_enable();
+	local_irq_restore(flags);
 }
 
 /**
- * lazy_percpu_counter_exit: Free resources associated with a
- * lazy_percpu_counter
+ * lazy_percpu_counter_destroy_many: Free resources associated with
+ * lazy_percpu_counters
  *
- * @c: counter to exit
+ * @c: counters to exit
+ * @nr_counters: number of counters
  */
-void lazy_percpu_counter_exit(struct lazy_percpu_counter *c)
+void lazy_percpu_counter_destroy_many(struct lazy_percpu_counter *c,
+				      u32 nr_counters)
+{
+	struct percpu_counter *pcpu_v;
+	u32 i;
+
+	for (i = 0; i < nr_counters; i++) {
+		pcpu_v = lazy_percpu_counter_is_pcpu(atomic64_read(&c[i].v));
+		if (pcpu_v)
+			percpu_counter_destroy(pcpu_v);
+	}
+}
+EXPORT_SYMBOL_GPL(lazy_percpu_counter_destroy_many);
+
+s64 lazy_percpu_counter_read_positive(struct lazy_percpu_counter *c)
+{
+	s64 v = atomic64_read(&c->v);
+	struct percpu_counter *pcpu_v = lazy_percpu_counter_is_pcpu(v);
+
+	if (pcpu_v)
+		return percpu_counter_read_positive(pcpu_v);
+
+	return lazy_percpu_counter_atomic_val(v);
+}
+EXPORT_SYMBOL_GPL(lazy_percpu_counter_read_positive);
+
+s64 lazy_percpu_counter_sum(struct lazy_percpu_counter *c)
+{
+	s64 v = atomic64_read(&c->v);
+	struct percpu_counter *pcpu_v = lazy_percpu_counter_is_pcpu(v);
+
+	if (pcpu_v)
+		return percpu_counter_sum(pcpu_v);
+
+	return lazy_percpu_counter_atomic_val(v);
+}
+EXPORT_SYMBOL_GPL(lazy_percpu_counter_sum);
+
+s64 lazy_percpu_counter_sum_positive(struct lazy_percpu_counter *c)
 {
-	free_percpu(lazy_percpu_counter_is_pcpu(atomic64_read(&c->v)));
+	s64 v = atomic64_read(&c->v);
+	struct percpu_counter *pcpu_v = lazy_percpu_counter_is_pcpu(v);
+
+	if (pcpu_v)
+		return percpu_counter_sum_positive(pcpu_v);
+
+	return lazy_percpu_counter_atomic_val(v);
 }
-EXPORT_SYMBOL_GPL(lazy_percpu_counter_exit);
+EXPORT_SYMBOL_GPL(lazy_percpu_counter_sum_positive);
 
 void lazy_percpu_counter_add_slowpath(struct lazy_percpu_counter *c, s64 i)
 {
 	u64 atomic_i;
 	u64 old, v = atomic64_read(&c->v);
-	u64 __percpu *pcpu_v;
+	struct percpu_counter *pcpu_v;
 
 	atomic_i  = i << COUNTER_IS_PCPU_BIT;
 	atomic_i &= ~COUNTER_MOD_MASK;
@@ -62,7 +111,7 @@ void lazy_percpu_counter_add_slowpath(struct lazy_percpu_counter *c, s64 i)
 	do {
 		pcpu_v = lazy_percpu_counter_is_pcpu(v);
 		if (pcpu_v) {
-			this_cpu_add(*pcpu_v, i);
+			percpu_counter_add(pcpu_v, i);
 			return;
 		}
 
-- 
2.25.1


