Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1467D4AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjJXIwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjJXIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:52:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA929111;
        Tue, 24 Oct 2023 01:52:28 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:52:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698137547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lX5T14Mf8vnUqBaB2zBFckLBaXLCozl47d44enrzcSo=;
        b=keb+WRb1PDGJgsRPbh1JPWpKUPNwaN7ZNInT9ogPKOzr8hzA1UpVk7nXKsQEwwholM2oGe
        c7ykzkYUCMvc+5Ug6B84A3sqewL3k9bSgv7+MpvrK4oM/gRKiCsSWKyzr3JP9dt2+2lR3X
        gmaSa0cpb/UWGjZluR+TDmETKPUlrrFbx0etTcFvucMJX0X4OagQBeU7JgaxEC83x7vdiI
        x1LNRTzdUPv8v294VIFKECl5qULN5uV3+FDUSdMA8RDHxtjwe0a28icASd5110f18mjWdc
        piM/21KQeOAFxZJh0bWEyLuiGdqPDXaB53jwuXnMCtNCC3emdz9bP71UWBzyWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698137547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lX5T14Mf8vnUqBaB2zBFckLBaXLCozl47d44enrzcSo=;
        b=3REin60+gGFENL31JJkSGtsrCdD8mHcmQ1V60IldstpgjS3V60O2kizUsCMkbC1vMZ0l7r
        o8DAto6VvrY0PLAQ==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add cpus_share_resources API
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231019033323.54147-2-yangyicong@huawei.com>
References: <20231019033323.54147-2-yangyicong@huawei.com>
MIME-Version: 1.0
Message-ID: <169813754637.3135.6468203039885741701.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b95303e0aeaf446b65169dd4142cacdaeb7d4c8b
Gitweb:        https://git.kernel.org/tip/b95303e0aeaf446b65169dd4142cacdaeb7d4c8b
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Thu, 19 Oct 2023 11:33:21 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Oct 2023 10:38:42 +02:00

sched: Add cpus_share_resources API

Add cpus_share_resources() API. This is the preparation for the
optimization of select_idle_cpu() on platforms with cluster scheduler
level.

On a machine with clusters cpus_share_resources() will test whether
two cpus are within the same cluster. On a non-cluster machine it
will behaves the same as cpus_share_cache(). So we use "resources"
here for cache resources.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-and-reviewed-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20231019033323.54147-2-yangyicong@huawei.com
---
 include/linux/sched/sd_flags.h |  7 +++++++
 include/linux/sched/topology.h |  8 +++++++-
 kernel/sched/core.c            | 12 ++++++++++++
 kernel/sched/sched.h           |  1 +
 kernel/sched/topology.c        | 13 +++++++++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index fad77b5..a8b2864 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -110,6 +110,13 @@ SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
+ * Domain members share CPU cluster (LLC tags or L2 cache)
+ *
+ * NEEDS_GROUPS: Clusters are shared between groups.
+ */
+SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
+
+/*
  * Domain members share CPU package resources (i.e. caches)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 67b573d..4c14fe1 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -45,7 +45,7 @@ static inline int cpu_smt_flags(void)
 #ifdef CONFIG_SCHED_CLUSTER
 static inline int cpu_cluster_flags(void)
 {
-	return SD_SHARE_PKG_RESOURCES;
+	return SD_CLUSTER | SD_SHARE_PKG_RESOURCES;
 }
 #endif
 
@@ -179,6 +179,7 @@ cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
 bool cpus_share_cache(int this_cpu, int that_cpu);
+bool cpus_share_resources(int this_cpu, int that_cpu);
 
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef int (*sched_domain_flags_f)(void);
@@ -232,6 +233,11 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
+static inline bool cpus_share_resources(int this_cpu, int that_cpu)
+{
+	return true;
+}
+
 #endif	/* !CONFIG_SMP */
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dc724f5..5e1fb8a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3939,6 +3939,18 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
+/*
+ * Whether CPUs are share cache resources, which means LLC on non-cluster
+ * machines and LLC tag or L2 on machines with clusters.
+ */
+bool cpus_share_resources(int this_cpu, int that_cpu)
+{
+	if (this_cpu == that_cpu)
+		return true;
+
+	return per_cpu(sd_share_id, this_cpu) == per_cpu(sd_share_id, that_cpu);
+}
+
 static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 {
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 65cad0e..998f03d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1853,6 +1853,7 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
+DECLARE_PER_CPU(int, sd_share_id);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a63729f..dbb8c32 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -668,6 +668,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
+DEFINE_PER_CPU(int, sd_share_id);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
@@ -693,6 +694,17 @@ static void update_top_cache_domain(int cpu)
 	per_cpu(sd_llc_id, cpu) = id;
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
 
+	sd = lowest_flag_domain(cpu, SD_CLUSTER);
+	if (sd)
+		id = cpumask_first(sched_domain_span(sd));
+
+	/*
+	 * This assignment should be placed after the sd_llc_id as
+	 * we want this id equals to cluster id on cluster machines
+	 * but equals to LLC id on non-Cluster machines.
+	 */
+	per_cpu(sd_share_id, cpu) = id;
+
 	sd = lowest_flag_domain(cpu, SD_NUMA);
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
@@ -1550,6 +1562,7 @@ static struct cpumask		***sched_domains_numa_masks;
  */
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
+	 SD_CLUSTER		|	\
 	 SD_SHARE_PKG_RESOURCES |	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
