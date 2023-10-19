Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C8B7CEE75
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjJSDgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjJSDg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:36:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C24B124
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:36:24 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9tYK3ZkfzvPsk;
        Thu, 19 Oct 2023 11:31:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 11:36:18 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <tim.c.chen@linux.intel.com>,
        <yu.c.chen@intel.com>, <gautham.shenoy@amd.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <kprateek.nayak@amd.com>,
        <wuyun.abel@bytedance.com>
Subject: [PATCH v11 1/3] sched: Add cpus_share_resources API
Date:   Thu, 19 Oct 2023 11:33:21 +0800
Message-ID: <20231019033323.54147-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231019033323.54147-1-yangyicong@huawei.com>
References: <20231019033323.54147-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

Add cpus_share_resources() API. This is the preparation for the
optimization of select_idle_cpu() on platforms with cluster scheduler
level.

On a machine with clusters cpus_share_resources() will test whether
two cpus are within the same cluster. On a non-cluster machine it
will behaves the same as cpus_share_cache(). So we use "resources"
here for cache resources.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched/sd_flags.h |  7 +++++++
 include/linux/sched/topology.h |  8 +++++++-
 kernel/sched/core.c            | 12 ++++++++++++
 kernel/sched/sched.h           |  1 +
 kernel/sched/topology.c        | 13 +++++++++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index fad77b5172e2..a8b28647aafc 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -109,6 +109,13 @@ SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
  */
 SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
+/*
+ * Domain members share CPU cluster (LLC tags or L2 cache)
+ *
+ * NEEDS_GROUPS: Clusters are shared between groups.
+ */
+SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
+
 /*
  * Domain members share CPU package resources (i.e. caches)
  *
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 67b573d5bf28..4c14fe127223 100644
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
index 264c2eb380d7..562b27ced328 100644
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
index 65cad0e5729e..998f03d02de0 100644
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
index a63729f87c21..dbb8c328e8ad 100644
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
-- 
2.24.0

