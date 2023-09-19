Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5139F7A6318
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjISMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjISMgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:36:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB07FB8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:36:12 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rqgz34dJWzJsYW;
        Tue, 19 Sep 2023 20:32:15 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 20:36:01 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arch_topology: Support SMT control on arm64
Date:   Tue, 19 Sep 2023 20:33:19 +0800
Message-ID: <20230919123319.23785-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Tests has been done on our ACPI based arm64 server and on
ACPI/OF based QEMU VMs.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/Kconfig            |  1 +
 drivers/base/arch_topology.c  | 63 +++++++++++++++++++++++++++++++++++
 include/linux/arch_topology.h | 11 ++++++
 3 files changed, 75 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b10515c0200b..531a71c7f499 100644
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
index b741b5ba82bd..75a693834fff 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -729,6 +729,63 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
 	return &cpu_topology[cpu].cluster_sibling;
 }
 
+#ifdef CONFIG_HOTPLUG_SMT
+static int topology_smt_num_threads = 1;
+
+void __init topology_smt_set_num_threads(void)
+{
+	int cpu, sibling, threads;
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
+	for_each_possible_cpu(cpu) {
+		threads = 1;
+
+		/* Invalid thread id, this CPU is not in a SMT core */
+		if (cpu_topology[cpu].thread_id == -1)
+			continue;
+
+		for_each_possible_cpu(sibling) {
+			if (sibling == cpu || cpu_topology[sibling].thread_id == -1)
+				continue;
+
+			if (cpu_topology[cpu].core_id == cpu_topology[sibling].core_id)
+				threads++;
+		}
+
+		if (threads > topology_smt_num_threads)
+			topology_smt_num_threads = threads;
+	}
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
@@ -841,6 +898,12 @@ void __init init_cpu_topology(void)
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

