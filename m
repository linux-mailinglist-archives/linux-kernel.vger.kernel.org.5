Return-Path: <linux-kernel+bounces-130039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB1897370
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A991C27350
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDDC14A4CE;
	Wed,  3 Apr 2024 15:07:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED7F149E0A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156821; cv=none; b=jN71auGUHpWPpZdJu3OaIA8E2ePdHwKwRJsC3iVwhwOOhF13xTtTaCqB/sdUxwX/rqBXLlztZKfy3Cc3oQskzk+pYyj0n+d1JstNF0bn4ctwLJR5rS2qpgL5eGmhxscIudh+rXG+VLdPSmc2rcALvGsbHwvj2NqUgmADOcDhqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156821; c=relaxed/simple;
	bh=7a1odYqmKjFL1UduF7vAKTCHsTnZIxWKisHGINaxoB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ra6n+9pqIaoyihtvoaUK1rjc071SMsLv7k0MUe987BEX8hlqY7JWfQNkTNTLdJTPnL3T5GmDnRRu+8TLYgR03MnUCBdlIUXwWjxtjREbeUVaLaUnFCPrC0gGmzLSKHnHHQAchVeopeF20RTvy1S3JCgwJaknHV6GPoe+Llh/bWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC1231691;
	Wed,  3 Apr 2024 08:07:30 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.74.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71E283F7B4;
	Wed,  3 Apr 2024 08:06:55 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Aaron Lu <aaron.lu@intel.com>,
	Rui Zhang <rui.zhang@intel.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 6/7] sched/fair: Remove on_null_domain() and redundant checks
Date: Wed,  3 Apr 2024 17:05:38 +0200
Message-Id: <20240403150543.2793354-7-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403150543.2793354-1-pierre.gondois@arm.com>
References: <20240403150543.2793354-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPUs with a NULL sched domain are removed from the HKR_TYPE_SCHED
isolation mask. The two following checks are equialent:
- !housekeeping_runtime_test_cpu(cpu, HKR_TYPE_SCHED)
- on_null_domain(rq)

Remove on_null_domain() and the redundant checks.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e0f2a0f153f..9657c8f2176b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11830,11 +11830,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 
 }
 
-static inline int on_null_domain(struct rq *rq)
-{
-	return unlikely(!rcu_dereference_sched(rq->sd));
-}
-
 #ifdef CONFIG_NO_HZ_COMMON
 /*
  * NOHZ idle load balancing (ILB) details:
@@ -12040,7 +12035,7 @@ void nohz_balance_exit_idle(struct rq *rq)
 	SCHED_WARN_ON(rq != this_rq());
 
 	/* If we're a completely isolated CPU, we don't play: */
-	if (on_null_domain(rq))
+	if (!housekeeping_runtime_test_cpu(cpu_of(rq), HKR_TYPE_SCHED))
 		return;
 
 	if (likely(!rq->nohz_tick_stopped))
@@ -12090,12 +12085,8 @@ void nohz_balance_enter_idle(int cpu)
 	 */
 	rq->has_blocked_load = 1;
 
-	/* Spare idle load balancing on CPUs that don't want to be disturbed: */
-	if (!housekeeping_runtime_test_cpu(cpu, HKR_TYPE_SCHED))
-		return;
-
 	/* If we're a completely isolated CPU, we don't play: */
-	if (on_null_domain(rq))
+	if (!housekeeping_runtime_test_cpu(cpu, HKR_TYPE_SCHED))
 		return;
 
 	/*
@@ -12504,11 +12495,14 @@ static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
  */
 void sched_balance_trigger(struct rq *rq)
 {
+	int cpu = cpu_of(rq);
+
 	/*
 	 * Don't need to rebalance while attached to NULL domain or
 	 * runqueue CPU is not active
 	 */
-	if (unlikely(on_null_domain(rq) || !cpu_active(cpu_of(rq))))
+	if (unlikely(!housekeeping_runtime_test_cpu(cpu, HKR_TYPE_SCHED)) ||
+	    !cpu_active(cpu))
 		return;
 
 	if (time_after_eq(jiffies, rq->next_balance))
-- 
2.25.1


