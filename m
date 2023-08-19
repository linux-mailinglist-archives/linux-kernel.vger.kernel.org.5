Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E149C781985
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjHSMdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjHSMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:33:01 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88EA449D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692448262;
        bh=jGTs53tSaFLu88+rEt/xwV87jmo91ronilXRFWcRyOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gy/BjmGVnlF4lrhIGPEaoXWPrPCPx2nGbSasn0VcpnPAUY1ajAqe17zEofZ2PXFIT
         d7fZefa95pI9GlrvjM4vlgumRvTfLr9lhbxudR81oKHQbmDm7yOC+LfRnMRxipDhPu
         Z6z1oqYEHNZv1em0+kAQjeFPBiYJvfqmzMd6f6rEdpa2wYwQ4HCygGIFqmTenSt53Q
         LDQ9OjIKjRZr9wjRd9z3RYDc/8J1jooAxoWhhdewgyPGMkvwqskVP/GwshLTmT9gWp
         Rdg/T5b2TK8NEcsnByo8XhrKRxc4tfz9F7WzsU98OUYJ7FZW0oywuQF3XqcdWPNSGN
         iAyCcMCWOz5fw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RSdPx3Wmqz1LwP;
        Sat, 19 Aug 2023 08:31:01 -0400 (EDT)
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
Subject: [RFC PATCH v2 2/3] sched: Introduce cpus_share_l2c
Date:   Sat, 19 Aug 2023 08:31:55 -0400
Message-Id: <20230819123155.275094-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818153027.202017-2-mathieu.desnoyers@efficios.com>
References: <20230818153027.202017-2-mathieu.desnoyers@efficios.com>
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

Introduce cpus_share_l2c to allow querying whether two logical CPUs
share a common L2 cache.

Considering a system like the AMD EPYC 9654 96-Core Processor, the L1
cache has a latency of 4-5 cycles, the L2 cache has a latency of at
least 14ns, whereas the L3 cache has a latency of 50ns [1]. Compared to
this, I measured the RAM accesses to a latency around 120ns on my
system [2]. So L3 really is only 2.4x faster than RAM accesses.
Therefore, with this relatively slow access speed compared to L2, the
scheduler will benefit from only considering CPUs sharing an L2 cache
for the purpose of using remote runqueue locking rather than queued
wakeups.

Link: https://en.wikichip.org/wiki/amd/microarchitectures/zen_4 [1]
Link: https://github.com/ChipsandCheese/MemoryLatencyTest [2]
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
Changes since v1:
- Fix l2c id for configurations where L2 have a single logical CPU:
  use TOPOLOGY_CLUSTER_SYSFS to find out whether topology cluster is
  implemented or if LLC should be used as fallback.
---
 include/linux/sched/topology.h |  6 ++++++
 kernel/sched/core.c            |  8 ++++++++
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        | 32 +++++++++++++++++++++++++++++---
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7f9331f71260..c5fdee188bea 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -178,6 +178,7 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
+bool cpus_share_l2c(int this_cpu, int that_cpu);
 bool cpus_share_llc(int this_cpu, int that_cpu);
 
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
@@ -227,6 +228,11 @@ partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 }
 
+static inline bool cpus_share_l2c(int this_cpu, int that_cpu)
+{
+	return true;
+}
+
 static inline bool cpus_share_llc(int this_cpu, int that_cpu)
 {
 	return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d096ce815099..11e60a69ae31 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3904,6 +3904,14 @@ void wake_up_if_idle(int cpu)
 	rcu_read_unlock();
 }
 
+bool cpus_share_l2c(int this_cpu, int that_cpu)
+{
+	if (this_cpu == that_cpu)
+		return true;
+
+	return per_cpu(sd_l2c_id, this_cpu) == per_cpu(sd_l2c_id, that_cpu);
+}
+
 bool cpus_share_llc(int this_cpu, int that_cpu)
 {
 	if (this_cpu == that_cpu)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 81ac605b9cd5..d93543db214c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1828,6 +1828,8 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 	return sd;
 }
 
+DECLARE_PER_CPU(int, sd_l2c_size);
+DECLARE_PER_CPU(int, sd_l2c_id);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 1ae2a0a1115a..2a672cbcd67e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -661,8 +661,11 @@ static void destroy_sched_domains(struct sched_domain *sd)
  *
  * Also keep a unique ID per domain (we use the first CPU number in
  * the cpumask of the domain), this allows us to quickly tell if
- * two CPUs are in the same cache domain, see cpus_share_llc().
+ * two CPUs are in the same cache domain, see cpus_share_l2c() and
+ * cpus_share_llc().
  */
+DEFINE_PER_CPU(int, sd_l2c_size);
+DEFINE_PER_CPU(int, sd_l2c_id);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
@@ -672,12 +675,27 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
+#ifdef TOPOLOGY_CLUSTER_SYSFS
+static int cpu_get_l2c_info(int cpu, int *l2c_size, int *l2c_id)
+{
+	const struct cpumask *cluster_mask = topology_cluster_cpumask(cpu);
+
+	*l2c_size = cpumask_weight(cluster_mask);
+	*l2c_id = cpumask_first(cluster_mask);
+	return 0;
+}
+#else
+static int cpu_get_l2c_info(int cpu, int *l2c_size, int *l2c_id)
+{
+	return -1;
+}
+#endif
+
 static void update_top_cache_domain(int cpu)
 {
 	struct sched_domain_shared *sds = NULL;
 	struct sched_domain *sd;
-	int id = cpu;
-	int size = 1;
+	int id = cpu, size = 1, l2c_id, l2c_size;
 
 	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
 	if (sd) {
@@ -686,6 +704,14 @@ static void update_top_cache_domain(int cpu)
 		sds = sd->shared;
 	}
 
+	if (cpu_get_l2c_info(cpu, &l2c_id, &l2c_size)) {
+		/* Fallback on using LLC. */
+		l2c_size = size;
+		l2c_id = id;
+	}
+	per_cpu(sd_l2c_size, cpu) = l2c_size;
+	per_cpu(sd_l2c_id, cpu) = l2c_id;
+
 	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
 	per_cpu(sd_llc_size, cpu) = size;
 	per_cpu(sd_llc_id, cpu) = id;
-- 
2.39.2

