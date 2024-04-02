Return-Path: <linux-kernel+bounces-127859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B2A8951C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD13283F92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EA769945;
	Tue,  2 Apr 2024 11:24:27 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 63FA664A98;
	Tue,  2 Apr 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057067; cv=none; b=VrV9IuzQYD5IaGjRTM2AICU57B+/ZezFCo4BpcPcIgc/3qGez/mY5OSgE6st/wYbKBhGE86GwPKa0BGcbAK37RV5n4+3lfRjLnV92O0Lqk9tpBcUqNhvNyy10HLxjcNXhy5xOgJe8SG5kLlesJa8p0rgyH9Z81wysCWXKgmQH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057067; c=relaxed/simple;
	bh=CaTYjj8zdYnlQyXbzA5vWY5G6Z6GdB28oa29n6j0Xqw=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AL7bnQchj8u0OStRtRDt0BQtflLopGQqeRcQAYfnNRwwSFDnp2kpwQLz9nq6Fv5dEVNQM276fTXcSX94k6/V/O5UZNGl1sMixOBXsosacEoiJjGtOFuSTgSoPbDtsaE+/TrjF9wtepR20cw5ctiTWCMo5IrOogrQbtsKLiL5dQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id E6CB118097DE79;
	Tue,  2 Apr 2024 19:24:21 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 19:24:21 +0800
Date: Tue, 2 Apr 2024 19:24:15 +0800
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
Subject: [PATCH 1/3] sched: make softirq cputime accounting separately in
 irqtime
Message-ID: <20240402112415.GA17946@didi-ThinkCentre-M930t-N000>
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
In-Reply-To: <20240402112112.GA17370@didi-ThinkCentre-M930t-N000>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

Currently we account irq{,soft} time in "irqtime.total",
when CONFIG_IRQ_TIME_ACCOUNTING=y. Since we account them in
the same path (irq{,soft}_enter{,exit}), we can separately count them
by filtering the offset.
In order to not break backward compatibility, we do not change the meaning
of "total", we only let softirq time to be accounted separately in
a new field "total_soft".
So interrupt time could also be calculated by "total" minus "total_soft".

This patch only let softirq cputime stats available in irqtime, do not
make it in real usage.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/sched/cputime.c | 18 ++++++++++++++----
 kernel/sched/sched.h   | 16 ++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..23e4bca1e3e8 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -35,13 +35,14 @@ void disable_sched_clock_irqtime(void)
 }
 
 static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
-				  enum cpu_usage_stat idx)
+				  u64 delta_soft, enum cpu_usage_stat idx)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
 
 	u64_stats_update_begin(&irqtime->sync);
 	cpustat[idx] += delta;
 	irqtime->total += delta;
+	irqtime->total_soft += delta_soft;
 	irqtime->tick_delta += delta;
 	u64_stats_update_end(&irqtime->sync);
 }
@@ -54,7 +55,7 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
 	unsigned int pc;
-	s64 delta;
+	s64 delta, delta_soft = 0;
 	int cpu;
 
 	if (!sched_clock_irqtime)
@@ -65,6 +66,15 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 	irqtime->irq_start_time += delta;
 	pc = irq_count() - offset;
 
+	/*
+	 * We only account softirq time when we are called by
+	 * account_softirq_enter{,exit}
+	 */
+	if ((offset & SOFTIRQ_OFFSET) || (pc & SOFTIRQ_OFFSET)) {
+		delta_soft = sched_clock_cpu(cpu) - irqtime->soft_start_time;
+		irqtime->soft_start_time += delta_soft;
+	}
+
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
 	 * We want to continue accounting softirq time to ksoftirqd thread
@@ -72,9 +82,9 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 	 * that do not consume any time, but still wants to run.
 	 */
 	if (pc & HARDIRQ_MASK)
-		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
+		irqtime_account_delta(irqtime, delta, delta_soft, CPUTIME_IRQ);
 	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
-		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
+		irqtime_account_delta(irqtime, delta, delta_soft, CPUTIME_SOFTIRQ);
 }
 
 static u64 irqtime_tick_accounted(u64 maxtime)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe047bd5d..f479c61b84b5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2931,8 +2931,10 @@ static inline void nohz_run_idle_balance(int cpu) { }
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 struct irqtime {
 	u64			total;
+	u64			total_soft;
 	u64			tick_delta;
 	u64			irq_start_time;
+	u64			soft_start_time;
 	struct u64_stats_sync	sync;
 };
 
@@ -2956,6 +2958,20 @@ static inline u64 irq_time_read(int cpu)
 
 	return total;
 }
+
+static inline u64 irq_time_read_soft(int cpu)
+{
+	struct irqtime *irqtime = &per_cpu(cpu_irqtime, cpu);
+	unsigned int seq;
+	u64 total_soft;
+
+	do {
+		seq = __u64_stats_fetch_begin(&irqtime->sync);
+		total_soft = irqtime->total_soft;
+	} while (__u64_stats_fetch_retry(&irqtime->sync, seq));
+
+	return total_soft;
+}
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.17.1


