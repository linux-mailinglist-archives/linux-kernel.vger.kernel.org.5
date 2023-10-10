Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D449B7BFA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjJJL4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjJJL42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:56:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912399
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:56:26 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4Z4g6RdJztTMx;
        Tue, 10 Oct 2023 19:51:47 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 19:56:23 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <dietmar.eggemann@arm.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <jonathan.cameron@huawei.com>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arch_topology: Support SMT control on arm64
Date:   Tue, 10 Oct 2023 19:53:35 +0800
Message-ID: <20231010115335.13862-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

The core CPU control framework supports runtime SMT control which
is not yet supported on arm64. Besides the general vulnerabilities
concerns we want this runtime control on our arm64 server for:

- better single CPU performance in some cases
- saving overall power consumption

This patch implements it in the following aspects:

- implement the callbacks of the core
- update the SMT status after the topology enumerated on arm64
- select HOTPLUG_SMT for arm64

For disabling SMT we'll offline all the secondary threads and
only leave the primary thread. Since we don't have restriction
for primary thread selection, the first thread is chosen as the
primary thread in this implementation.

Tests has been done on our real ACPI based arm64 server and on
ACPI/OF based QEMU VMs.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- Avoid the complexity on SMT detecting by visiting each CPU once, concerned by Sudeep
Link: https://lore.kernel.org/all/20230919123319.23785-1-yangyicong@huawei.com/

 arch/arm64/Kconfig            |  1 +
 drivers/base/arch_topology.c  | 75 +++++++++++++++++++++++++++++++++++
 include/linux/arch_topology.h | 11 +++++
 3 files changed, 87 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 78f20e632712..339661ceabc8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -233,6 +233,7 @@ config ARM64
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
+	select HOTPLUG_SMT if SMP
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b741b5ba82bd..c5b453c2cd61 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -729,6 +729,75 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
 	return &cpu_topology[cpu].cluster_sibling;
 }
 
+#ifdef CONFIG_HOTPLUG_SMT
+static int topology_smt_num_threads = 1;
+
+void __init topology_smt_set_num_threads(void)
+{
+	int cpu, sibling, threads;
+	cpumask_var_t to_visit;
+
+	if (!alloc_cpumask_var(&to_visit, GFP_KERNEL)) {
+		pr_err("Failed to update the SMT info\n");
+		return;
+	}
+
+	cpumask_or(to_visit, to_visit, cpu_possible_mask);
+
+	/*
+	 * Walk all the CPUs to find the largest thread number, in case we're
+	 * on a heterogeneous platform with only part of the CPU cores support
+	 * SMT.
+	 *
+	 * Get the thread number by checking the CPUs with same core id
+	 * rather than checking the topology_sibling_cpumask(), since the
+	 * sibling mask will not cover all the CPUs if there's CPU offline.
+	 */
+	for_each_cpu(cpu, to_visit) {
+		threads = 1;
+
+		cpumask_clear_cpu(cpu, to_visit);
+
+		/* Invalid thread id, this CPU is not in a SMT core */
+		if (cpu_topology[cpu].thread_id == -1)
+			continue;
+
+		for_each_cpu(sibling, to_visit) {
+			if (cpu_topology[sibling].thread_id != -1 &&
+			    cpu_topology[cpu].core_id == cpu_topology[sibling].core_id)
+				threads++;
+
+			cpumask_clear_cpu(sibling, to_visit);
+		}
+
+		if (threads > topology_smt_num_threads)
+			topology_smt_num_threads = threads;
+	}
+
+	free_cpumask_var(to_visit);
+
+	/*
+	 * We don't support CONFIG_SMT_NUM_THREADS_DYNAMIC so make the
+	 * max_threads == num_threads.
+	 */
+	cpu_smt_set_num_threads(topology_smt_num_threads, topology_smt_num_threads);
+}
+
+/*
+ * On SMT Hotplug the primary thread of the SMT won't be disabled. For x86 they
+ * seem to have a primary thread for special purpose. For other arthitectures
+ * like arm64 there's no such restriction for a primary thread, so make the
+ * first thread in the SMT as the primary thread.
+ */
+bool topology_is_primary_thread(unsigned int cpu)
+{
+	if (cpu == cpumask_first(topology_sibling_cpumask(cpu)))
+		return true;
+
+	return false;
+}
+#endif
+
 void update_siblings_masks(unsigned int cpuid)
 {
 	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
@@ -841,6 +910,12 @@ void __init init_cpu_topology(void)
 		reset_cpu_topology();
 	}
 
+	/*
+	 * By this stage we get to know whether we support SMT or not, update
+	 * the information for the core.
+	 */
+	topology_smt_set_num_threads();
+
 	for_each_possible_cpu(cpu) {
 		ret = fetch_cache_info(cpu);
 		if (!ret)
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a07b510e7dc5..cf605a576e7b 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -92,6 +92,17 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+
+#ifdef CONFIG_HOTPLUG_SMT
+bool topology_smt_supported(void);
+bool topology_is_primary_thread(unsigned int cpu);
+void topology_smt_set_num_threads(void);
+#else
+static inline bool topology_smt_supported(void) { return false; }
+static inline bool topology_is_primary_thread(unsigned int cpu) { return false; }
+static inline void topology_smt_set_num_threads(void) { }
+#endif
+
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.24.0

