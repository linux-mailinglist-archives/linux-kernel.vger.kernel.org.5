Return-Path: <linux-kernel+bounces-26093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9982DB5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F92A1C21B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4833D179AA;
	Mon, 15 Jan 2024 14:34:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6421798E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02C4A1515;
	Mon, 15 Jan 2024 06:35:32 -0800 (PST)
Received: from e126645.arm.com (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7ECDB3F6C4;
	Mon, 15 Jan 2024 06:34:43 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH v2 3/3] sched/fair: Use rq in update_blocked_averages()
Date: Mon, 15 Jan 2024 15:34:26 +0100
Message-Id: <20240115143427.1820628-4-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115143427.1820628-1-pierre.gondois@arm.com>
References: <20240115143427.1820628-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_blocked_averages() could receive a 'struct rq' instead of a
CPU number to avoid converting the CPU number to a 'struct rq'
multiple times.

Suggested-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 97d9e0d32337..c70bb993f473 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9349,10 +9349,9 @@ static unsigned long task_h_load(struct task_struct *p)
 }
 #endif
 
-static void update_blocked_averages(int cpu)
+static void update_blocked_averages(struct rq *rq)
 {
 	bool decayed = false, done = true;
-	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
@@ -12026,7 +12025,7 @@ static bool update_nohz_stats(struct rq *rq)
 	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
 		return true;
 
-	update_blocked_averages(cpu);
+	update_blocked_averages(rq);
 
 	return rq->has_blocked_load;
 }
@@ -12286,7 +12285,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	raw_spin_rq_unlock(this_rq);
 
 	t0 = sched_clock_cpu(this_cpu);
-	update_blocked_averages(this_cpu);
+	update_blocked_averages(this_rq);
 
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
@@ -12376,7 +12375,7 @@ static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 		return;
 
 	/* normal load balance */
-	update_blocked_averages(this_rq->cpu);
+	update_blocked_averages(this_rq);
 	rebalance_domains(this_rq, idle);
 }
 
-- 
2.25.1


