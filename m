Return-Path: <linux-kernel+bounces-127860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DEE8951CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503C0282354
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D9264A98;
	Tue,  2 Apr 2024 11:27:13 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A04694CB4A;
	Tue,  2 Apr 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057232; cv=none; b=pPmllmuMTbwl9s5JoPEuYJY7Y/CE3stDBApKiQaweBc8Li8KSxNGxgC8UIkeyb58ZaE1GIhoEoryJEkAKPdwmitR3bwYurgbtmxh7N/61b8o1ARNuQ+xWIh7Uju2HBbP5XKUz7usWdM5eK1+FY8/p3cfZ5m5uAenNthjpdS5UWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057232; c=relaxed/simple;
	bh=Z50/tzj5KXaW5FqNbjgiT/MlV+E4o0YKBuzY4ut0BbI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UOR27Gw+UERjiauZkugthMXrRRiv7jbbf3lkrcRaRdyRpMuLpQirxtovrMlxlyED3/jtToclNOuCf8BRd8yRyxm4933bxkwU6MVRUxi8/8I/QzW6g8NloIZTUKk+GKhcevYUKUTnUhjgSgGubqrbuUw2WO3B8W3C1P9B8XDX9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id B30B718097DE83;
	Tue,  2 Apr 2024 19:27:06 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 19:27:06 +0800
Date: Tue, 2 Apr 2024 19:27:00 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: Tio Zhang <tiozhang@didiglobal.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <rostedt@goodmis.org>, <bsingharora@gmail.com>,
	<corbet@lwn.net>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <tiozhang@didiglobal.com>,
	<zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>, <fuyuanli@didiglobal.com>
Subject: [PATCH 2/3] delayacct: get delay of SOFTIRQ
Message-ID: <20240402112700.GA18519@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsingharora@gmail.com, corbet@lwn.net,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net,
	fuyuanli@didiglobal.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402112415.GA17946@didi-ThinkCentre-M930t-N000>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

This patch makes SOFTIRQ time accounted by "irqtime.total_soft" in use
by adding soft_delay accounts for Delay accounting.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 include/linux/delayacct.h | 11 +++++++----
 kernel/delayacct.c        |  5 +++--
 kernel/sched/core.c       |  6 ++++--
 kernel/sched/sched.h      |  1 +
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 6639f48dac36..bf1d45fcb505 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -49,12 +49,14 @@ struct task_delay_info {
 	u64 wpcopy_delay;	/* wait for write-protect copy */
 
 	u64 irq_delay;	/* wait for IRQ/SOFTIRQ */
+	u64 soft_delay;	/* wait for SOFTIRQ */
 
 	u32 freepages_count;	/* total count of memory reclaim */
 	u32 thrashing_count;	/* total count of thrash waits */
 	u32 compact_count;	/* total count of memory compact */
 	u32 wpcopy_count;	/* total count of write-protect copy */
 	u32 irq_count;	/* total count of IRQ/SOFTIRQ */
+	u32 soft_count;	/* total count of SOFTIRQ */
 };
 #endif
 
@@ -84,7 +86,7 @@ extern void __delayacct_compact_start(void);
 extern void __delayacct_compact_end(void);
 extern void __delayacct_wpcopy_start(void);
 extern void __delayacct_wpcopy_end(void);
-extern void __delayacct_irq(struct task_struct *task, u32 delta);
+extern void __delayacct_irq(struct task_struct *task, u32 delta, u32 delta_soft);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -219,13 +221,14 @@ static inline void delayacct_wpcopy_end(void)
 		__delayacct_wpcopy_end();
 }
 
-static inline void delayacct_irq(struct task_struct *task, u32 delta)
+static inline void delayacct_irq(struct task_struct *task, u32 delta,
+					u32 delta_soft)
 {
 	if (!static_branch_unlikely(&delayacct_key))
 		return;
 
 	if (task->delays)
-		__delayacct_irq(task, delta);
+		__delayacct_irq(task, delta, delta_soft);
 }
 
 #else
@@ -266,7 +269,7 @@ static inline void delayacct_wpcopy_start(void)
 {}
 static inline void delayacct_wpcopy_end(void)
 {}
-static inline void delayacct_irq(struct task_struct *task, u32 delta)
+static inline void delayacct_irq(struct task_struct *task, u32 delta, u32 delta_soft)
 {}
 
 #endif /* CONFIG_TASK_DELAY_ACCT */
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 6f0c358e73d8..8517f1c1df88 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -278,13 +278,14 @@ void __delayacct_wpcopy_end(void)
 		      &current->delays->wpcopy_count);
 }
 
-void __delayacct_irq(struct task_struct *task, u32 delta)
+void __delayacct_irq(struct task_struct *task, u32 delta, u32 delta_soft)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&task->delays->lock, flags);
 	task->delays->irq_delay += delta;
 	task->delays->irq_count++;
+	task->delays->soft_delay += delta_soft;
+	task->delays->soft_count++;
 	raw_spin_unlock_irqrestore(&task->delays->lock, flags);
 }
-
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..2f5fd775b47b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -698,10 +698,11 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
  * In theory, the compile should just see 0 here, and optimize out the call
  * to sched_rt_avg_update. But I don't trust it...
  */
-	s64 __maybe_unused steal = 0, irq_delta = 0;
+	s64 __maybe_unused steal = 0, irq_delta = 0, soft_delta = 0;
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
+	soft_delta = irq_time_read_soft(cpu_of(rq)) - rq->prev_soft_time;
 
 	/*
 	 * Since irq_time is only updated on {soft,}irq_exit, we might run into
@@ -722,9 +723,10 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 		irq_delta = delta;
 
 	rq->prev_irq_time += irq_delta;
+	rq->prev_soft_time += soft_delta;
 	delta -= irq_delta;
 	psi_account_irqtime(rq->curr, irq_delta);
-	delayacct_irq(rq->curr, irq_delta);
+	delayacct_irq(rq->curr, irq_delta, soft_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f479c61b84b5..abf96ad9c301 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1105,6 +1105,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
+	u64			prev_soft_time;
 #endif
 #ifdef CONFIG_PARAVIRT
 	u64			prev_steal_time;
-- 
2.17.1


