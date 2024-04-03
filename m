Return-Path: <linux-kernel+bounces-130034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50664897369
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB9A1F21B9F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041014A097;
	Wed,  3 Apr 2024 15:06:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6797B149DE3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156792; cv=none; b=Gq/cix349ETa+DDdUG96/VzGsU9+FWjCBpV2uMhKa5ezJvV8rqx2t0pd5NZxAfHFgchRUQc9B//A6vYm9ODCW5QLgz/g5v+7sbzRT6WDubV7Bh4Sk1CuOfv6I04APL6XTyPaorh95tmY3LfXTCZluUz9LwQfCed+a/i6Jc6LkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156792; c=relaxed/simple;
	bh=54N//QKAL73VOVwcfjNuqoX3Jag5no7obFOKhG6hRyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ol19/pK/hhYXctx/r1lfxPor/zpIJhOXWGqdc+MCUTFZbQRJmaW5pnaImHxSMkkQ4jE7hNJ8DeMANTVkmaawQ9SVuJzF2pCfuyIoQfrYEgz41t1xxsTED5qMRolNHYAieI8RbaGUIe+4HXhGFpzJ6r2p9ECeoPJT+1ohPwHn8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2D7E1684;
	Wed,  3 Apr 2024 08:07:01 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.74.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7F1D3F7B4;
	Wed,  3 Apr 2024 08:06:26 -0700 (PDT)
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
	Waiman Long <longman@redhat.com>
Subject: [PATCH 3/7] sched/isolation: Use HKR_TYPE_SCHED in find_new_ilb()
Date: Wed,  3 Apr 2024 17:05:35 +0200
Message-Id: <20240403150543.2793354-4-pierre.gondois@arm.com>
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

Replace the HK_TYPE_MISC isolation mask with HKR_TYPE_SCHED in
find_new_ilb(). This ultimately resolves [1], i.e. selecting
a CPU for the nohz idle balance which cannot pull tasks
through:
sched_balance_trigger()
\-nohz_balancer_kick()
  \-kick_ilb()
    \-find_new_ilb()
      \-smp_call_function_single_async()
        \-nohz_csd_cpu()
          \-raise_softirq_irqoff()
sched_balance_softirq()
\-_nohz_idle_balance()
  \-sched_balance_domains()

Indeed, a following patch will add/remove CPUs with a NULL sched
domain to the HKR_TYPE_SCHED cpumask.

[1] https://lore.kernel.org/all/20230804090858.7605-1-rui.zhang@intel.com/

Reported-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e3d707243ca7..0665f5eb4703 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11842,16 +11842,13 @@ static inline int on_null_domain(struct rq *rq)
  * - When one of the busy CPUs notices that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
- *
- * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is not set
- *   anywhere yet.
  */
 static inline int find_new_ilb(void)
 {
 	const struct cpumask *hk_mask;
 	int ilb_cpu;
 
-	hk_mask = housekeeping_cpumask(HK_TYPE_MISC);
+	hk_mask = housekeeping_runtime_cpumask(HKR_TYPE_SCHED);
 
 	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
 
-- 
2.25.1


