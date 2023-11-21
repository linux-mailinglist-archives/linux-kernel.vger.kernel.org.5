Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3A47F28F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjKUJ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjKUJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:29:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A197C121
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:29:24 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SZJrw0K7BzsRPH;
        Tue, 21 Nov 2023 17:25:52 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 17:29:19 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <dietmar.eggemann@arm.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <jonathan.cameron@huawei.com>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/4] arch_topology: Support basic SMT control for the driver
Date:   Tue, 21 Nov 2023 17:25:59 +0800
Message-ID: <20231121092602.47792-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231121092602.47792-1-yangyicong@huawei.com>
References: <20231121092602.47792-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

The core CPU control framework supports runtime SMT control which
is not yet supported by arch_topology driver and thus arch_topology
based architectures. This patch implements it in the following aspects:

- implement topology_is_primary_thread() to indicate the primary thread,
  required by the framework
- architecture code can get/set the SMT thread number by
  topology_smt_{get, set}_num_threads()
- update the SMT thread number for the framework after the topology
  enumerated on arm64, which is also required by the framework

For disabling SMT we'll offline all the secondary threads and
only leave the primary thread. Since we don't have restriction
for primary thread selection, the first thread is chosen as the
primary thread in this implementation.

This patch only implements the basic support for SMT control, which
needs to collabrate with ACPI/OF based topology building to fully
enable the feature. The SMT control will be enabled unless the
correct SMT thread number is set and HOTPLUG_SMT kconfig is selected.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/base/arch_topology.c  | 38 +++++++++++++++++++++++++++++++++++
 include/linux/arch_topology.h | 14 +++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b741b5ba82bd..3ed6bdf9460e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -729,6 +729,36 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
 	return &cpu_topology[cpu].cluster_sibling;
 }
 
+#ifdef CONFIG_HOTPLUG_SMT
+
+/* Maximum threads number per-Core */
+static unsigned int topology_smt_num_threads = 1;
+
+void __init topology_smt_set_num_threads(unsigned int num_threads)
+{
+	topology_smt_num_threads = num_threads;
+}
+
+unsigned int __init topology_smt_get_num_threads(void)
+{
+	return topology_smt_num_threads;
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
@@ -841,6 +871,14 @@ void __init init_cpu_topology(void)
 		reset_cpu_topology();
 	}
 
+	/*
+	 * By this stage we get to know whether we support SMT or not, update
+	 * the information for the core. We don't support
+	 * CONFIG_SMT_NUM_THREADS_DYNAMIC so make the max_threads == num_threads.
+	 */
+	cpu_smt_set_num_threads(topology_smt_get_num_threads(),
+				topology_smt_get_num_threads());
+
 	for_each_possible_cpu(cpu) {
 		ret = fetch_cache_info(cpu);
 		if (!ret)
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a07b510e7dc5..0367f3a61838 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -92,6 +92,20 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+
+#ifdef CONFIG_HOTPLUG_SMT
+bool topology_is_primary_thread(unsigned int cpu);
+void topology_smt_set_num_threads(unsigned int num_threads);
+unsigned int topology_smt_get_num_threads(void);
+#else
+static inline bool topology_is_primary_thread(unsigned int cpu) { return false; }
+static inline void topology_smt_set_num_threads(unsigned int num_threads) { }
+static inline unsigned int topology_smt_get_num_threads(void)
+{
+	return 1;
+}
+#endif
+
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.24.0

