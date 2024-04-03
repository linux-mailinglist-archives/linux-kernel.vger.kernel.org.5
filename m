Return-Path: <linux-kernel+bounces-130035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D0897374
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2BEB22097
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F3314A093;
	Wed,  3 Apr 2024 15:06:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D64A14A0A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156803; cv=none; b=Y0js+CFdbQzhJQbEMaBEGxO3DiTWUSDQ5xtTdMGNS0gPz14M6dPRiEGrwTkrWVWkVpqBOyKgNb7AG7Sez1FEjuDkKQW/KGMH7zYPDqLslgZ66A3OPrCn+CV6muOJyl50+/WXz6pM0aZNFgE17RDz+JBCv/hrCg/B8pLbl5KLKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156803; c=relaxed/simple;
	bh=pimyCXvc7YX8asor/As9BfBUS8PADGX9CEj0YFa8W2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RvDbhsV1C/cdlKIxWB4Gm/bKwdNFIUn0oNNbYd1LefIjgv6SUjp5DJcCtX5vV7Jq+Ug1E24Z5GXDMLkRTsnQOlgj6uAJPRo0OhK08L/+HOD1QWbcCN4Fj9bCTSaKHTcnQsZKrGZSdbzbJexqswLeTqdp7a5JklXxqlFexMYfyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDA771688;
	Wed,  3 Apr 2024 08:07:11 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.74.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 338893F7B4;
	Wed,  3 Apr 2024 08:06:36 -0700 (PDT)
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
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 4/7] sched/fair: Move/add on_null_domain()/housekeeping_cpu() checks
Date: Wed,  3 Apr 2024 17:05:36 +0200
Message-Id: <20240403150543.2793354-5-pierre.gondois@arm.com>
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

Prepare a following patch by moving/adding on_null_domain()
and housekeeping_runtime_cpu() checks.

In nohz_balance_enter_idle():
-
The housekeeping_runtime_cpu(cpu, HKR_TYPE_SCHED) call is currently
a no-op as HKR_TYPE_SCHED is never configured. The call can thus
be moved down.
-
In the current code, an isolated CPU sets nohz.has_blocked,
but isn't set in nohz.idle_cpus_mask.
However, _nohz_idle_balance::for_each_cpu_wrap() iterates
over nohz.idle_cpus_mask cpus.
Move the check up to avoid this.

In nohz_balance_exit_idle():
-
The check against a NULL sd in:
  nohz_balance_enter_idle()
  \-if (on_null_domain())
    \-[returning here]
  \-rq->nohz_tick_stopped = 1
prevents from setting the rq's nohz_tick_stopped, and
  sched_balance_trigger()
  \-if (on_null_domain())
    \-[returning here]
  \-nohz_balancer_kick()
    \-nohz_balance_exit_idle()
prevents from resetting the nohz.[nr_cpus|idle_cpus_mask] variables.
So the newly added on_null_domain() check doesn't change current
behaviour.
It however prepares:
- the use of the HKR_TYPE_SCHED isolation mask
- the removal of on_null_domain()
in a later patch.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0665f5eb4703..3e0f2a0f153f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12039,6 +12039,10 @@ void nohz_balance_exit_idle(struct rq *rq)
 {
 	SCHED_WARN_ON(rq != this_rq());
 
+	/* If we're a completely isolated CPU, we don't play: */
+	if (on_null_domain(rq))
+		return;
+
 	if (likely(!rq->nohz_tick_stopped))
 		return;
 
@@ -12079,10 +12083,6 @@ void nohz_balance_enter_idle(int cpu)
 	if (!cpu_active(cpu))
 		return;
 
-	/* Spare idle load balancing on CPUs that don't want to be disturbed: */
-	if (!housekeeping_runtime_test_cpu(cpu, HKR_TYPE_SCHED))
-		return;
-
 	/*
 	 * Can be set safely without rq->lock held
 	 * If a clear happens, it will have evaluated last additions because
@@ -12090,6 +12090,14 @@ void nohz_balance_enter_idle(int cpu)
 	 */
 	rq->has_blocked_load = 1;
 
+	/* Spare idle load balancing on CPUs that don't want to be disturbed: */
+	if (!housekeeping_runtime_test_cpu(cpu, HKR_TYPE_SCHED))
+		return;
+
+	/* If we're a completely isolated CPU, we don't play: */
+	if (on_null_domain(rq))
+		return;
+
 	/*
 	 * The tick is still stopped but load could have been added in the
 	 * meantime. We set the nohz.has_blocked flag to trig a check of the
@@ -12099,10 +12107,6 @@ void nohz_balance_enter_idle(int cpu)
 	if (rq->nohz_tick_stopped)
 		goto out;
 
-	/* If we're a completely isolated CPU, we don't play: */
-	if (on_null_domain(rq))
-		return;
-
 	rq->nohz_tick_stopped = 1;
 
 	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
-- 
2.25.1


