Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B27677CD31
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbjHONMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbjHONMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:12:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C610C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:12:30 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQBV41Wl6zrS48;
        Tue, 15 Aug 2023 21:11:08 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 21:12:27 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <jonathan.cameron@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH v2 RESEND] drivers/perf: hisi: Schedule perf session according to locality
Date:   Tue, 15 Aug 2023 21:10:10 +0800
Message-ID: <20230815131010.2147-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

The PCIe PMUs locate on different NUMA node but currently we don't
consider it and likely stack all the sessions on the same CPU:

[root@localhost tmp]# cat /sys/devices/hisi_pcie*/cpumask
0
0
0
0
0
0

This can be optimize a bit to use a local CPU for the PMU.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v2:
- Make interrupt affinity consistent with CPU in online handler
Link: https://lore.kernel.org/all/20230808125147.2080-1-yangyicong@huawei.com/

 drivers/perf/hisilicon/hisi_pcie_pmu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index e10fc7cb9493..5a00adb2de8c 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -665,8 +665,8 @@ static int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
 	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node, struct hisi_pcie_pmu, node);
 
 	if (pcie_pmu->on_cpu == -1) {
-		pcie_pmu->on_cpu = cpu;
-		WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)));
+		pcie_pmu->on_cpu = cpumask_local_spread(0, dev_to_node(&pcie_pmu->pdev->dev));
+		WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(pcie_pmu->on_cpu)));
 	}
 
 	return 0;
@@ -676,14 +676,23 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node, struct hisi_pcie_pmu, node);
 	unsigned int target;
+	cpumask_t mask;
+	int numa_node;
 
 	/* Nothing to do if this CPU doesn't own the PMU */
 	if (pcie_pmu->on_cpu != cpu)
 		return 0;
 
 	pcie_pmu->on_cpu = -1;
-	/* Choose a new CPU from all online cpus. */
-	target = cpumask_any_but(cpu_online_mask, cpu);
+
+	/* Choose a local CPU from all online cpus. */
+	numa_node = dev_to_node(&pcie_pmu->pdev->dev);
+	if (cpumask_and(&mask, cpumask_of_node(numa_node), cpu_online_mask) &&
+	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
+		target = cpumask_any(&mask);
+	else
+		target = cpumask_any_but(cpu_online_mask, cpu);
+
 	if (target >= nr_cpu_ids) {
 		pci_err(pcie_pmu->pdev, "There is no CPU to set\n");
 		return 0;
-- 
2.24.0

