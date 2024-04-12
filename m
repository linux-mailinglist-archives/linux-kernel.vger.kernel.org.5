Return-Path: <linux-kernel+bounces-142403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05498A2B23
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8605928CA4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59153E25;
	Fri, 12 Apr 2024 09:25:02 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5553399
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913901; cv=none; b=olahEVjBzE+4A6a0w+IF+W0XrFgjD/86yFOKylWbQBkB+Zoz/Q+ei1Ck3kEmfqb7qIQsjtZQ6Rpa6kdfT2ygfQ3pfIK2Gd3TfoKP5gKjvHXdWdr2nhA8Y+4pSbohuu0W73akS4agLTpr2HgB7gKP21rgzwluP7s5CW5+jOZWeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913901; c=relaxed/simple;
	bh=ClX5buHHt66svkg2lkRGeq7M9bw/T0fgF2y2uq7KpDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6YVnzwZ+5TqE8YHHFD2Z7uB3OVOwK+BCI5J7G/qa4+ttKvL0Hi/9J1v1wjZoJ/dU6qJ7/umBsgpAZhIZbDjmi/EwTrC19xwB5MmcQcm3osOHSvgSKZXFnQTMzjCnLejuuWcNABWmHCdTDka9EDEdGlU2s09j7zI3nKfKDfmT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VGB1445JlzNnch;
	Fri, 12 Apr 2024 17:22:32 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id C18CC180073;
	Fri, 12 Apr 2024 17:24:50 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:24:49 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <dennisszhou@gmail.com>,
	<shakeelb@google.com>, <jack@suse.cz>, <surenb@google.com>,
	<kent.overstreet@linux.dev>, <mhocko@suse.cz>, <vbabka@suse.cz>,
	<yuzhao@google.com>, <yu.ma@intel.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <zhangpeng362@huawei.com>
Subject: [RFC PATCH 1/3] Lazy percpu counters
Date: Fri, 12 Apr 2024 17:24:39 +0800
Message-ID: <20240412092441.3112481-2-zhangpeng362@huawei.com>
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

From: Kent Overstreet <kent.overstreet@linux.dev>

This patch adds lib/lazy-percpu-counter.c, which implements counters
that start out as atomics, but lazily switch to percpu mode if the
update rate crosses some threshold (arbitrarily set at 256 per second).

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/lazy-percpu-counter.h | 82 +++++++++++++++++++++++++++++
 lib/Makefile                        |  2 +-
 lib/lazy-percpu-counter.c           | 82 +++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/lazy-percpu-counter.h
 create mode 100644 lib/lazy-percpu-counter.c

diff --git a/include/linux/lazy-percpu-counter.h b/include/linux/lazy-percpu-counter.h
new file mode 100644
index 000000000000..281b8dd88cb2
--- /dev/null
+++ b/include/linux/lazy-percpu-counter.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lazy percpu counters:
+ * (C) 2022 Kent Overstreet
+ *
+ * Lazy percpu counters start out in atomic mode, then switch to percpu mode if
+ * the update rate crosses some threshold.
+ *
+ * This means we don't have to decide between low memory overhead atomic
+ * counters and higher performance percpu counters - we can have our cake and
+ * eat it, too!
+ *
+ * Internally we use an atomic64_t, where the low bit indicates whether we're in
+ * percpu mode, and the high 8 bits are a secondary counter that's incremented
+ * when the counter is modified - meaning 55 bits of precision are available for
+ * the counter itself.
+ */
+
+#ifndef _LINUX_LAZY_PERCPU_COUNTER_H
+#define _LINUX_LAZY_PERCPU_COUNTER_H
+
+#include <linux/atomic.h>
+#include <asm/percpu.h>
+
+struct lazy_percpu_counter {
+	atomic64_t			v;
+	unsigned long			last_wrap;
+};
+
+void lazy_percpu_counter_exit(struct lazy_percpu_counter *c);
+void lazy_percpu_counter_add_slowpath(struct lazy_percpu_counter *c, s64 i);
+
+/*
+ * We use the high bits of the atomic counter for a secondary counter, which is
+ * incremented every time the counter is touched. When the secondary counter
+ * wraps, we check the time the counter last wrapped, and if it was recent
+ * enough that means the update frequency has crossed our threshold and we
+ * switch to percpu mode:
+ */
+#define COUNTER_MOD_BITS		8
+#define COUNTER_MOD_MASK		~(~0ULL >> COUNTER_MOD_BITS)
+#define COUNTER_MOD_BITS_START		(64 - COUNTER_MOD_BITS)
+
+/*
+ * We use the low bit of the counter to indicate whether we're in atomic mode
+ * (low bit clear), or percpu mode (low bit set, counter is a pointer to actual
+ * percpu counters:
+ */
+#define COUNTER_IS_PCPU_BIT		1
+
+static inline u64 __percpu *lazy_percpu_counter_is_pcpu(u64 v)
+{
+	if (!(v & COUNTER_IS_PCPU_BIT))
+		return NULL;
+
+	v ^= COUNTER_IS_PCPU_BIT;
+	return (u64 __percpu *)(unsigned long)v;
+}
+
+/**
+ * lazy_percpu_counter_add: Add a value to a lazy_percpu_counter
+ *
+ * @c: counter to modify
+ * @i: value to add
+ */
+static inline void lazy_percpu_counter_add(struct lazy_percpu_counter *c, s64 i)
+{
+	u64 v = atomic64_read(&c->v);
+	u64 __percpu *pcpu_v = lazy_percpu_counter_is_pcpu(v);
+
+	if (likely(pcpu_v))
+		this_cpu_add(*pcpu_v, i);
+	else
+		lazy_percpu_counter_add_slowpath(c, i);
+}
+
+static inline void lazy_percpu_counter_sub(struct lazy_percpu_counter *c, s64 i)
+{
+	lazy_percpu_counter_add(c, -i);
+}
+
+#endif /* _LINUX_LAZY_PERCPU_COUNTER_H */
diff --git a/lib/Makefile b/lib/Makefile
index 2f4e17bfb299..7afa0c3e7cc7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -46,7 +46,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
 	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
-	 percpu-refcount.o rhashtable.o base64.o \
+	 percpu-refcount.o lazy-percpu-counter.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o bitmap-str.o
 obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
diff --git a/lib/lazy-percpu-counter.c b/lib/lazy-percpu-counter.c
new file mode 100644
index 000000000000..e1914207214d
--- /dev/null
+++ b/lib/lazy-percpu-counter.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/atomic.h>
+#include <linux/gfp.h>
+#include <linux/jiffies.h>
+#include <linux/lazy-percpu-counter.h>
+#include <linux/percpu.h>
+
+static inline s64 lazy_percpu_counter_atomic_val(s64 v)
+{
+	/* Ensure output is sign extended properly: */
+	return (v << COUNTER_MOD_BITS) >>
+		(COUNTER_MOD_BITS + COUNTER_IS_PCPU_BIT);
+}
+
+static void lazy_percpu_counter_switch_to_pcpu(struct lazy_percpu_counter *c)
+{
+	u64 __percpu *pcpu_v = alloc_percpu_gfp(u64, GFP_ATOMIC|__GFP_NOWARN);
+	u64 old, new, v;
+
+	if (!pcpu_v)
+		return;
+
+	preempt_disable();
+	v = atomic64_read(&c->v);
+	do {
+		if (lazy_percpu_counter_is_pcpu(v)) {
+			free_percpu(pcpu_v);
+			return;
+		}
+
+		old = v;
+		new = (unsigned long)pcpu_v | 1;
+
+		*this_cpu_ptr(pcpu_v) = lazy_percpu_counter_atomic_val(v);
+	} while ((v = atomic64_cmpxchg(&c->v, old, new)) != old);
+	preempt_enable();
+}
+
+/**
+ * lazy_percpu_counter_exit: Free resources associated with a
+ * lazy_percpu_counter
+ *
+ * @c: counter to exit
+ */
+void lazy_percpu_counter_exit(struct lazy_percpu_counter *c)
+{
+	free_percpu(lazy_percpu_counter_is_pcpu(atomic64_read(&c->v)));
+}
+EXPORT_SYMBOL_GPL(lazy_percpu_counter_exit);
+
+void lazy_percpu_counter_add_slowpath(struct lazy_percpu_counter *c, s64 i)
+{
+	u64 atomic_i;
+	u64 old, v = atomic64_read(&c->v);
+	u64 __percpu *pcpu_v;
+
+	atomic_i  = i << COUNTER_IS_PCPU_BIT;
+	atomic_i &= ~COUNTER_MOD_MASK;
+	atomic_i |= 1ULL << COUNTER_MOD_BITS_START;
+
+	do {
+		pcpu_v = lazy_percpu_counter_is_pcpu(v);
+		if (pcpu_v) {
+			this_cpu_add(*pcpu_v, i);
+			return;
+		}
+
+		old = v;
+	} while ((v = atomic64_cmpxchg(&c->v, old, old + atomic_i)) != old);
+
+	if (unlikely(!(v & COUNTER_MOD_MASK))) {
+		unsigned long now = jiffies;
+
+		if (c->last_wrap &&
+		    unlikely(time_after(c->last_wrap + HZ, now)))
+			lazy_percpu_counter_switch_to_pcpu(c);
+		else
+			c->last_wrap = now;
+	}
+}
+EXPORT_SYMBOL(lazy_percpu_counter_add_slowpath);
-- 
2.25.1


