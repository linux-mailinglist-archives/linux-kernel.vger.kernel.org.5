Return-Path: <linux-kernel+bounces-150293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF68A9CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4503B27844
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD616D4C1;
	Thu, 18 Apr 2024 14:20:30 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27616C868
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450030; cv=none; b=KBlVG4JOA72OsuamPDzP0Hv6x6j7uiOFOaE7rIuDgfwylWTIh98QOxdMcyC60jKTNFklqCxDZ76cqcjXzSIFbxQIDTLhpx8y1ozluOdVXUVfPzqoVt88KW3QDzA0y32Et4jfXVUgfqvRskPLk3vnB/3pgVIv/L6Objb/gHeGETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450030; c=relaxed/simple;
	bh=VToe+G5gCpIh0JC/YRdvGcXhSR6YzrScmagb3i00W1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkE5nZJhYJt32SjiZBdao8qncTQ8UiCnaeukk+jNREjC9WI6oNO0P5IHgUL74rEWIqiIuXf4T7n+oCMAYvCDUO+pJylDvT8oTQzMFfxpIAEB+ynkA6II4nB5IGn3T8twfo4PruhXiS4JLQ3oexbPgMuNColZNhQdzKtcWclwwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VL0GY5dl6z1R5WL;
	Thu, 18 Apr 2024 22:17:25 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id A4877140382;
	Thu, 18 Apr 2024 22:20:19 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 22:20:18 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <dennisszhou@gmail.com>,
	<shakeelb@google.com>, <jack@suse.cz>, <surenb@google.com>,
	<kent.overstreet@linux.dev>, <mhocko@suse.cz>, <vbabka@suse.cz>,
	<yuzhao@google.com>, <yu.ma@intel.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <zhangpeng362@huawei.com>
Subject: [RFC PATCH v2 2/2] mm: convert mm's rss stats to use atomic mode
Date: Thu, 18 Apr 2024 22:20:08 +0800
Message-ID: <20240418142008.2775308-3-zhangpeng362@huawei.com>
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

Since commit f1a7941243c1 ("mm: convert mm's rss stats into
percpu_counter"), the rss_stats have converted into percpu_counter,
which convert the error margin from (nr_threads * 64) to approximately
(nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
performance regression on fork/exec/shell. Even after commit 14ef95be6f55
("kernel/fork: group allocation/free of per-cpu counters for mm struct"),
the performance of fork/exec/shell is still poor compared to previous
kernel versions.

To mitigate performance regression, we delay the allocation of percpu
memory for rss_stats. Therefore, we convert mm's rss stats to use
percpu_counter atomic mode. For single-thread processes, rss_stat is in
atomic mode, which reduces the memory consumption and performance
regression caused by using percpu. For multiple-thread processes,
rss_stat is switched to the percpu mode to reduce the error margin.
We convert rss_stats from atomic mode to percpu mode only when the
second thread is created.

After lmbench test, we can get 2% ~ 4% performance improvement
for lmbench fork_proc/exec_proc/shell_proc and 6.7% performance
improvement for lmbench page_fault (before batch mode[1]).

The test results are as follows:

             base           base+revert        base+this patch

fork_proc    416.3ms        400.0ms  (3.9%)    398.6ms  (4.2%)
exec_proc    2095.9ms       2061.1ms (1.7%)    2047.7ms (2.3%)
shell_proc   3028.2ms       2954.7ms (2.4%)    2961.2ms (2.2%)
page_fault   0.3603ms       0.3358ms (6.8%)    0.3361ms (6.7%)

[1] https://lore.kernel.org/all/20240412064751.119015-1-wangkefeng.wang@huawei.com/

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h          | 50 +++++++++++++++++++++++++++++++------
 include/trace/events/kmem.h |  4 +--
 kernel/fork.c               | 18 +++++++------
 3 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d261e45bb29b..8f1bfbd54697 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2631,30 +2631,66 @@ static inline bool get_user_page_fast_only(unsigned long addr,
  */
 static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 {
-	return percpu_counter_read_positive(&mm->rss_stat[member]);
+	struct percpu_counter *fbc = &mm->rss_stat[member];
+
+	if (percpu_counter_initialized(fbc))
+		return percpu_counter_read_positive(fbc);
+
+	return percpu_counter_atomic_read(fbc);
 }
 
 void mm_trace_rss_stat(struct mm_struct *mm, int member);
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
 {
-	percpu_counter_add(&mm->rss_stat[member], value);
+	struct percpu_counter *fbc = &mm->rss_stat[member];
+
+	if (percpu_counter_initialized(fbc))
+		percpu_counter_add(fbc, value);
+	else
+		percpu_counter_atomic_add(fbc, value);
 
 	mm_trace_rss_stat(mm, member);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member)
 {
-	percpu_counter_inc(&mm->rss_stat[member]);
-
-	mm_trace_rss_stat(mm, member);
+	add_mm_counter(mm, member, 1);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member)
 {
-	percpu_counter_dec(&mm->rss_stat[member]);
+	add_mm_counter(mm, member, -1);
+}
 
-	mm_trace_rss_stat(mm, member);
+static inline s64 mm_counter_sum(struct mm_struct *mm, int member)
+{
+	struct percpu_counter *fbc = &mm->rss_stat[member];
+
+	if (percpu_counter_initialized(fbc))
+		return percpu_counter_sum(fbc);
+
+	return percpu_counter_atomic_read(fbc);
+}
+
+static inline s64 mm_counter_sum_positive(struct mm_struct *mm, int member)
+{
+	struct percpu_counter *fbc = &mm->rss_stat[member];
+
+	if (percpu_counter_initialized(fbc))
+		return percpu_counter_sum_positive(fbc);
+
+	return percpu_counter_atomic_read(fbc);
+}
+
+static inline int mm_counter_switch_to_pcpu_many(struct mm_struct *mm)
+{
+	return percpu_counter_switch_to_pcpu_many(mm->rss_stat, NR_MM_COUNTERS);
+}
+
+static inline void mm_counter_destroy_many(struct mm_struct *mm)
+{
+	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
 }
 
 /* Optimized variant when folio is already known not to be anon */
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 6e62cc64cd92..a4e40ae6a8c8 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -399,8 +399,8 @@ TRACE_EVENT(rss_stat,
 		__entry->mm_id = mm_ptr_to_hash(mm);
 		__entry->curr = !!(current->mm == mm);
 		__entry->member = member;
-		__entry->size = (percpu_counter_sum_positive(&mm->rss_stat[member])
-							    << PAGE_SHIFT);
+		__entry->size = (mm_counter_sum_positive(mm, member)
+							<< PAGE_SHIFT);
 	),
 
 	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..0214273798c5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -823,7 +823,7 @@ static void check_mm(struct mm_struct *mm)
 			 "Please make sure 'struct resident_page_types[]' is updated as well");
 
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		long x = percpu_counter_sum(&mm->rss_stat[i]);
+		long x = mm_counter_sum(mm, i);
 
 		if (unlikely(x))
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
@@ -1301,16 +1301,10 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_cid(mm))
 		goto fail_cid;
 
-	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
-				     NR_MM_COUNTERS))
-		goto fail_pcpu;
-
 	mm->user_ns = get_user_ns(user_ns);
 	lru_gen_init_mm(mm);
 	return mm;
 
-fail_pcpu:
-	mm_destroy_cid(mm);
 fail_cid:
 	destroy_context(mm);
 fail_nocontext:
@@ -1730,6 +1724,16 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldmm)
 		return 0;
 
+	/*
+	 * For single-thread processes, rss_stat is in atomic mode, which
+	 * reduces the memory consumption and performance regression caused by
+	 * using percpu. For multiple-thread processes, rss_stat is switched to
+	 * the percpu mode to reduce the error margin.
+	 */
+	if (clone_flags & CLONE_THREAD)
+		if (mm_counter_switch_to_pcpu_many(oldmm))
+			return -ENOMEM;
+
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm = oldmm;
-- 
2.25.1


