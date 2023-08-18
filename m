Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230FC780765
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358723AbjHRIoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358743AbjHRInv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:43:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A713A94
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:43:48 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RRwNb25k4z1GF5y;
        Fri, 18 Aug 2023 16:42:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 16:43:45 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <anshuman.khandual@arm.com>, <james.clark@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH V3] coresight: trbe: Fix TRBE potential sleep in atomic context
Date:   Fri, 18 Aug 2023 16:40:52 +0800
Message-ID: <20230818084052.10116-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_call_function_single() will allocate an IPI interrupt vector to
the target processor and send a function call request to the interrupt
vector. After the target processor receives the IPI interrupt, it will
execute arm_trbe_remove_coresight_cpu() call request in the interrupt
handler.

According to the device_unregister() stack information, if other process
is useing the device, the down_write() may sleep, and trigger deadlocks
or unexpected errors.

  arm_trbe_remove_coresight_cpu
    coresight_unregister
      device_unregister
        device_del
          kobject_del
            __kobject_del
              sysfs_remove_dir
                kernfs_remove
                  down_write ---------> it may sleep

Add a helper arm_trbe_disable_cpu() to disable TRBE precpu irq and reset
per TRBE.
Simply call arm_trbe_remove_coresight_cpu() directly without useing the
smp_call_function_single(), which is the same as registering the TRBE
coresight device.

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Link: https://lore.kernel.org/r/20230814093813.19152-2-hejunhao3@huawei.com
[ Remove duplicate cpumask checks during removal ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[ v3 - Remove the operation of assigning NULL to cpudata->drvdata ]
---
 drivers/hwtracing/coresight/coresight-trbe.c | 32 +++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 8e4eb37e66e8..e20c1c6acc73 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1225,6 +1225,16 @@ static void arm_trbe_enable_cpu(void *info)
 	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
 }
 
+static void arm_trbe_disable_cpu(void *info)
+{
+	struct trbe_drvdata *drvdata = info;
+	struct trbe_cpudata *cpudata = this_cpu_ptr(drvdata->cpudata);
+
+	disable_percpu_irq(drvdata->irq);
+	trbe_reset_local(cpudata);
+}
+
+
 static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cpu)
 {
 	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
@@ -1329,18 +1339,12 @@ static void arm_trbe_probe_cpu(void *info)
 	cpumask_clear_cpu(cpu, &drvdata->supported_cpus);
 }
 
-static void arm_trbe_remove_coresight_cpu(void *info)
+static void arm_trbe_remove_coresight_cpu(struct trbe_drvdata *drvdata, int cpu)
 {
-	int cpu = smp_processor_id();
-	struct trbe_drvdata *drvdata = info;
-	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
 	struct coresight_device *trbe_csdev = coresight_get_percpu_sink(cpu);
 
-	disable_percpu_irq(drvdata->irq);
-	trbe_reset_local(cpudata);
 	if (trbe_csdev) {
 		coresight_unregister(trbe_csdev);
-		cpudata->drvdata = NULL;
 		coresight_set_percpu_sink(cpu, NULL);
 	}
 }
@@ -1369,8 +1373,10 @@ static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
 {
 	int cpu;
 
-	for_each_cpu(cpu, &drvdata->supported_cpus)
-		smp_call_function_single(cpu, arm_trbe_remove_coresight_cpu, drvdata, 1);
+	for_each_cpu(cpu, &drvdata->supported_cpus) {
+		smp_call_function_single(cpu, arm_trbe_disable_cpu, drvdata, 1);
+		arm_trbe_remove_coresight_cpu(drvdata, cpu);
+	}
 	free_percpu(drvdata->cpudata);
 	return 0;
 }
@@ -1409,12 +1415,8 @@ static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 {
 	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
 
-	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
-		struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
-
-		disable_percpu_irq(drvdata->irq);
-		trbe_reset_local(cpudata);
-	}
+	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
+		arm_trbe_disable_cpu(drvdata);
 	return 0;
 }
 
-- 
2.33.0

