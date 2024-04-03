Return-Path: <linux-kernel+bounces-130033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0B897368
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A545C1F244CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204AF14A082;
	Wed,  3 Apr 2024 15:06:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8213A272
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156784; cv=none; b=I9+xA6PyAqY5lXHlP2B66DaNX7435p9h+Z9d43VixDrYgBOAooggrReShZJHvEMO63PivRL03FTJv57MaE8D2p+dQm4zkt8EOFB8ugdH8xO8dEVhzI5UyM93NN/Q1S57zrurm2mgXsC25DAG47j0wVyyrpdF5CehOHDIN/Zhy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156784; c=relaxed/simple;
	bh=YrK76JRYQ9vB2jJg41sUj5FbQqSSvT+rqTxOnYT1bKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmTcSe3kj+nvCPETPlLkj2TN9j0nKAGGGLtoLcypLZXPZnbPAQfn8i+pV63MYo2Ar65UEr7iYhwG5Tq+kACSBK9Z04VCbm0mHP0+pL0PB+yqhAPLZ8xfgHoQEJgmN882YS2zFBlKxuSMbYMtfMUNcymguUY1F5BYepuLjDdLFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE0B91655;
	Wed,  3 Apr 2024 08:06:52 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.74.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 486973F7B4;
	Wed,  3 Apr 2024 08:06:17 -0700 (PDT)
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
	Michal Hocko <mhocko@suse.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/7] sched/isolation: Move HK_TYPE_SCHED to housekeeping runtime
Date: Wed,  3 Apr 2024 17:05:34 +0200
Message-Id: <20240403150543.2793354-3-pierre.gondois@arm.com>
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

The HK_TYPE_SCHED isolation mask is never modified. It is however
referenced in the scheduler code to ignore CPUs not taking part in
load balancing for instance.

Move the HK_TYPE_SCHED to the newly created housekeeping runtime
type. Places where HK_TYPE_SCHED is used are not impacted as:
- the HKR_FLAG_SCHED flag isn't used by the isolcpus/nohz_full
  kernel parameters
- masks not set though kernel parameters default to the
  cpu_online_mask

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/linux/sched/isolation.h | 2 +-
 kernel/sched/fair.c             | 4 ++--
 kernel/sched/isolation.c        | 5 ++++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 5d2f40c6f04c..80b4e26a1b73 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -7,6 +7,7 @@
 #include <linux/tick.h>
 
 enum hkr_type {
+	HKR_TYPE_SCHED,
 	HKR_TYPE_MAX
 };
 
@@ -14,7 +15,6 @@ enum hk_type {
 	HK_TYPE_TIMER,
 	HK_TYPE_RCU,
 	HK_TYPE_MISC,
-	HK_TYPE_SCHED,
 	HK_TYPE_TICK,
 	HK_TYPE_DOMAIN,
 	HK_TYPE_WQ,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1dd37168da50..e3d707243ca7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12083,7 +12083,7 @@ void nohz_balance_enter_idle(int cpu)
 		return;
 
 	/* Spare idle load balancing on CPUs that don't want to be disturbed: */
-	if (!housekeeping_cpu(cpu, HK_TYPE_SCHED))
+	if (!housekeeping_runtime_test_cpu(cpu, HKR_TYPE_SCHED))
 		return;
 
 	/*
@@ -12309,7 +12309,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	 * This CPU doesn't want to be disturbed by scheduler
 	 * housekeeping
 	 */
-	if (!housekeeping_cpu(this_cpu, HK_TYPE_SCHED))
+	if (!housekeeping_runtime_test_cpu(this_cpu, HKR_TYPE_SCHED))
 		return;
 
 	/* Will wake up very soon. No time for doing anything else*/
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5acbed870c28..735925578815 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -8,11 +8,14 @@
  *
  */
 
+enum hk_runtime_flags {
+	HKR_FLAG_SCHED		= BIT(HKR_TYPE_SCHED),
+};
+
 enum hk_flags {
 	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
 	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
 	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
-	HK_FLAG_SCHED		= BIT(HK_TYPE_SCHED),
 	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
-- 
2.25.1


