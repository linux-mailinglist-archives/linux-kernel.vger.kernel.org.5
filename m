Return-Path: <linux-kernel+bounces-142401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DA68A2B21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E371C22840
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926D1524A6;
	Fri, 12 Apr 2024 09:24:57 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A950A87
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913897; cv=none; b=cxSh3y66KzppnHjEStLNHcq005P2VibpgieFwOG2NlXT+nJp3wZ/MlhZ0SLy/cXJkGH9Fz+8TQWTX+BU2F/K8usiAemAVeXEZ4TXamLvnSP8Af2oLxB068FFTIJ76jsGsfA9rIHpY7PWatUrvt4hNvy1R1PoOEvKswpVB4prDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913897; c=relaxed/simple;
	bh=JeRFl6IV6v5i010O95XTQGaSHiDkUq3NQHN6d2k86g8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ai+KgtxO4Q7KsQccrwsv7kXsRkSTnGUMhDc1bT72TMf3LHgL9xNvd2/KSkqISyu206D4qvqJJOO1Kk5pQs3/mZme6uD8BQWI3egBpf8HCKJ3wJWM/7sTrkAgvcBZT8OeoLnIQ0fpm9+HfTwa+f2GeXRcrxNwh/h7mK1I2ZGs5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VGB0R3lh1z2NW5X;
	Fri, 12 Apr 2024 17:21:59 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id E766118001A;
	Fri, 12 Apr 2024 17:24:52 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:24:51 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <dennisszhou@gmail.com>,
	<shakeelb@google.com>, <jack@suse.cz>, <surenb@google.com>,
	<kent.overstreet@linux.dev>, <mhocko@suse.cz>, <vbabka@suse.cz>,
	<yuzhao@google.com>, <yu.ma@intel.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <zhangpeng362@huawei.com>
Subject: [RFC PATCH 3/3] mm: convert mm's rss stats into lazy_percpu_counter
Date: Fri, 12 Apr 2024 17:24:41 +0800
Message-ID: <20240412092441.3112481-4-zhangpeng362@huawei.com>
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

Since commit f1a7941243c1 ("mm: convert mm's rss stats into
percpu_counter"), the rss_stats have converted into percpu_counter,
which convert the error margin from (nr_threads * 64) to approximately
(nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
performance regression on fork/exec/shell. Even after commit 14ef95be6f55
("kernel/fork: group allocation/free of per-cpu counters for mm struct"),
the performance of fork/exec/shell is still poor compared to
previous kernel versions.

To mitigate performance regression, we use lazy_percpu_counter to delay
the allocation of percpu memory for rss_stats. After lmbench test, we
will get 3% ~ 6% performance improvement for lmbench fork_proc/exec_proc/
shell_proc after conversion. The test results are as follows:

             base           base+revert        base+lazy_percpu_counter

fork_proc    427.4ms        394.1ms  (7.8%)    413.9ms  (3.2%)
exec_proc    2205.1ms       2042.2ms (7.4%)    2072.0ms (6.0%)
shell_proc   3180.9ms       2963.7ms (6.8%)    3010.7ms (5.4%)

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h          |  8 ++++----
 include/linux/mm_types.h    |  4 ++--
 include/trace/events/kmem.h |  4 ++--
 kernel/fork.c               | 12 ++++--------
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 07c73451d42f..d1ea246b99c3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2631,28 +2631,28 @@ static inline bool get_user_page_fast_only(unsigned long addr,
  */
 static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 {
-	return percpu_counter_read_positive(&mm->rss_stat[member]);
+	return lazy_percpu_counter_read_positive(&mm->rss_stat[member]);
 }
 
 void mm_trace_rss_stat(struct mm_struct *mm, int member);
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
 {
-	percpu_counter_add(&mm->rss_stat[member], value);
+	lazy_percpu_counter_add(&mm->rss_stat[member], value);
 
 	mm_trace_rss_stat(mm, member);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member)
 {
-	percpu_counter_inc(&mm->rss_stat[member]);
+	lazy_percpu_counter_add(&mm->rss_stat[member], 1);
 
 	mm_trace_rss_stat(mm, member);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member)
 {
-	percpu_counter_dec(&mm->rss_stat[member]);
+	lazy_percpu_counter_sub(&mm->rss_stat[member], 1);
 
 	mm_trace_rss_stat(mm, member);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c432add95913..bf44c3a6fc99 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -18,7 +18,7 @@
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
-#include <linux/percpu_counter.h>
+#include <linux/lazy-percpu-counter.h>
 
 #include <asm/mmu.h>
 
@@ -898,7 +898,7 @@ struct mm_struct {
 
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
-		struct percpu_counter rss_stat[NR_MM_COUNTERS];
+		struct lazy_percpu_counter rss_stat[NR_MM_COUNTERS];
 
 		struct linux_binfmt *binfmt;
 
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 6e62cc64cd92..3a35d9a665b7 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -399,8 +399,8 @@ TRACE_EVENT(rss_stat,
 		__entry->mm_id = mm_ptr_to_hash(mm);
 		__entry->curr = !!(current->mm == mm);
 		__entry->member = member;
-		__entry->size = (percpu_counter_sum_positive(&mm->rss_stat[member])
-							    << PAGE_SHIFT);
+		__entry->size = (lazy_percpu_counter_sum_positive(&mm->rss_stat[member])
+							  << PAGE_SHIFT);
 	),
 
 	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..0a4efb436030 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -823,7 +823,7 @@ static void check_mm(struct mm_struct *mm)
 			 "Please make sure 'struct resident_page_types[]' is updated as well");
 
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		long x = percpu_counter_sum(&mm->rss_stat[i]);
+		long x = lazy_percpu_counter_sum(&mm->rss_stat[i]);
 
 		if (unlikely(x))
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
@@ -910,6 +910,8 @@ static void cleanup_lazy_tlbs(struct mm_struct *mm)
  */
 void __mmdrop(struct mm_struct *mm)
 {
+	int i;
+
 	BUG_ON(mm == &init_mm);
 	WARN_ON_ONCE(mm == current->mm);
 
@@ -924,7 +926,7 @@ void __mmdrop(struct mm_struct *mm)
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
-	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
+	lazy_percpu_counter_destroy_many(&mm->rss_stat[i], NR_MM_COUNTERS);
 
 	free_mm(mm);
 }
@@ -1301,16 +1303,10 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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
-- 
2.25.1


