Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6F783ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjHVLbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjHVLbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:31:04 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ACACD2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692703859;
        bh=KkLV16+WkRX4ihKG1MjBEkAMOPnIqDOadaG9tU3jWvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ka3F30c7TJBavJcFaJoKngSLoAnnCWKn8YCFdzT1KAHqG2uk89jM3qgWiwmSg4bKF
         UOhgR97ItliDUlvw/PWPl9MFMLsFos9w2NskeetwbqE30+CV5xETG5u2RwJwhfRIwM
         TcIxfap1idsc4mf+iCezv2b6RUxPZpqVELWpZs86XBbBtqFsw20I+qiAVIFTqAbhLb
         63nS7lWKlcDXdgfxKbNhnqIxz0I7Y5HXXLtt5wzu6JaFHYjm+TUDTqr3BpN3ZpbD/f
         JDAPHX9l0HqcjWXCRWW1n2LPmfU78Hn7idzxBUETkZrOsp+bcJ8c/JGNXInoBhyXvJ
         qiTW1F0JMoZRA==
Received: from thinkos.home (unknown [142.120.205.109])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RVRxH3H5dz1M2L;
        Tue, 22 Aug 2023 07:30:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
Subject: [RFC PATCH v3 1/3] sched: Rename cpus_share_cache to cpus_share_llc
Date:   Tue, 22 Aug 2023 07:31:31 -0400
Message-Id: <20230822113133.643238-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for introducing cpus_share_l2c, rename cpus_share_cache
to cpus_share_llc, to make it clear that it specifically groups CPUs by
LLC.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: x86@kernel.org
---
 block/blk-mq.c                 | 2 +-
 include/linux/sched/topology.h | 4 ++--
 kernel/sched/core.c            | 4 ++--
 kernel/sched/fair.c            | 8 ++++----
 kernel/sched/topology.c        | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b9f454613989..ed1457ca2c6d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1136,7 +1136,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	/* same CPU or cache domain?  Complete locally */
 	if (cpu == rq->mq_ctx->cpu ||
 	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
-	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
+	     cpus_share_llc(cpu, rq->mq_ctx->cpu)))
 		return false;
 
 	/* don't try to IPI to an offline CPU */
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6cc444e..7f9331f71260 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -178,7 +178,7 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
-bool cpus_share_cache(int this_cpu, int that_cpu);
+bool cpus_share_llc(int this_cpu, int that_cpu);
 
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef int (*sched_domain_flags_f)(void);
@@ -227,7 +227,7 @@ partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 }
 
-static inline bool cpus_share_cache(int this_cpu, int that_cpu)
+static inline bool cpus_share_llc(int this_cpu, int that_cpu)
 {
 	return true;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..d096ce815099 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3904,7 +3904,7 @@ void wake_up_if_idle(int cpu)
 	rcu_read_unlock();
 }
 
-bool cpus_share_cache(int this_cpu, int that_cpu)
+bool cpus_share_llc(int this_cpu, int that_cpu)
 {
 	if (this_cpu == that_cpu)
 		return true;
@@ -3929,7 +3929,7 @@ static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 	 * If the CPU does not share cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
 	 */
-	if (!cpus_share_cache(smp_processor_id(), cpu))
+	if (!cpus_share_llc(smp_processor_id(), cpu))
 		return true;
 
 	if (cpu == smp_processor_id())
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4da5f3541762..680bbe0c7d7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6626,7 +6626,7 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	 * a cpufreq perspective, it's better to have higher utilisation
 	 * on one CPU.
 	 */
-	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
+	if (available_idle_cpu(this_cpu) && cpus_share_llc(this_cpu, prev_cpu))
 		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
@@ -7146,7 +7146,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (prev != target && cpus_share_llc(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev))
 		return prev;
@@ -7172,7 +7172,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
+	    cpus_share_llc(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
@@ -7206,7 +7206,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (sched_smt_active()) {
 		has_idle_core = test_idle_cores(target);
 
-		if (!has_idle_core && cpus_share_cache(prev, target)) {
+		if (!has_idle_core && cpus_share_llc(prev, target)) {
 			i = select_idle_smt(p, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6682535e37c8..1ae2a0a1115a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -661,7 +661,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
  *
  * Also keep a unique ID per domain (we use the first CPU number in
  * the cpumask of the domain), this allows us to quickly tell if
- * two CPUs are in the same cache domain, see cpus_share_cache().
+ * two CPUs are in the same cache domain, see cpus_share_llc().
  */
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
-- 
2.39.2

