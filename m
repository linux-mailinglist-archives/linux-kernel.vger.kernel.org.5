Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4924F7B3643
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjI2PDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjI2PD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D19FCC7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 948B91007;
        Fri, 29 Sep 2023 08:04:02 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DA393F5A1;
        Fri, 29 Sep 2023 08:03:23 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:02:57 +0100
Subject: [PATCH v3 08/17] firmware: arm_ffa: Initial support for scheduler
 receiver interrupt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230929-ffa_v1-1_notif-v3-8-c8e4f15190c8@arm.com>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
In-Reply-To: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7567; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=cEqV4YVf1LWm1xYaB7cZIwUpKEDLEWd8Uc3+Kj3BYQI=;
 b=owEBbAKT/ZANAwAIAQBBurwxfuKYAcsmYgBlFucvCcxjPXx8TBj4nbCzrmy1KuOnDdP4lGixl
 6UZ6ZzDsruJAjIEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnLwAKCRAAQbq8MX7i
 mJWaD/ifHyJbruDUC9theNrtvo0jGb1ru5UA3xiOU0FdjmfkTlfhzrKsEIf3vD/VNiWrVIrLpeh
 iQD7oj49Afj2+HakhGwbMo1ML25XWx8ZA2TFScS1VISOorUwxXS0+s8Ve8krpWjQRaztztHRiQP
 JDjtuBIa5u9fw04zDIsPPyJE4WpAPaAv+8vjG5dzjO6caEmnJ+HJNsn2aKFeuJ4csOXa5yATwGk
 8gvOk7wbJ9/PIKlU1/+UcXPWpyA3ZpBpVbaMho7X7D/142ZKGvp2L8F3YWo2Z1okmafVUbrwyNq
 a6hgu8//Ux/MjxiQZVHww2tpc44zqr+TeWZwCa8NVGO7bA8U6XLx9eyaZ16PigxKMXnFnCeyBzc
 EK451CBMexA+OmxNNLSgDsHgSzxROs0SuSo75sPoEIjg2KZ1yS9eGNVOkLBbdGUhQQHvR8FeOhf
 sw6NaJdPLAPqjv6dcfuM/bm155YP9GbJsl97CkXjHZuHcVGTTCkTL2pYVMsxIimUd5gWKnXOEhe
 BP4gcnAlQSLEe6aKPsAGEtiphMBcfQo0EO8wquHZqE45eOF7QZjVYTsZmQp4XhSYsvYfQ2zwktP
 syZVXcfXmPIeVpY7tsvAj62CY+Nho0TP0PJCEK0S+atI+XGQWbUTBeoBJPFJxvAqTLNOACitipc
 DA8CCM3Y9PMV4
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Framework uses the schedule receiver interrupt to inform the
receiver’s scheduler that the receiver must be run to handle a pending
notification. A receiver’s scheduler can obtain the description of the
schedule receiver interrupt by invoking the FFA_FEATURES interface.

The delivery of the physical schedule receiver interrupt from the secure
state to the non-secure state depends upon the state of the interrupt
controller as configured by the hypervisor.

The schedule seceiver interrupt is assumed to be a SGI. The Arm GIC
specification defines 16 SGIs. It recommends that they are equally
divided between the non-secure and secure states. OS like Linux kernel
in the non-secure state typically do not have SGIs to spare. The usage
of SGIs in the secure state is however limited. It is more likely that
software in the Secure world does not use all the SGIs allocated to it.

It is recommended that the secure world software donates an unused SGI
to the normal world for use as the schedule receiver interrupt. This
implies that secure world software must configure the SGI in the GIC
as a non-secure interrupt before presenting it to the normal world.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 192 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index dfeeb751bebe..a0c80eff04c4 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -22,15 +22,20 @@
 #define DRIVER_NAME "ARM FF-A"
 #define pr_fmt(fmt) DRIVER_NAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/arm_ffa.h>
 #include <linux/bitfield.h>
+#include <linux/cpuhotplug.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/of_irq.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
 #include <linux/uuid.h>
 
 #include "common.h"
@@ -76,6 +81,10 @@ static inline int ffa_to_linux_errno(int errno)
 	return -EINVAL;
 }
 
+struct ffa_pcpu_irq {
+	struct ffa_drv_info *info;
+};
+
 struct ffa_drv_info {
 	u32 version;
 	u16 vm_id;
@@ -85,6 +94,12 @@ struct ffa_drv_info {
 	void *tx_buffer;
 	bool mem_ops_native;
 	bool bitmap_created;
+	unsigned int sched_recv_irq;
+	unsigned int cpuhp_state;
+	struct ffa_pcpu_irq __percpu *irq_pcpu;
+	struct workqueue_struct *notif_pcpu_wq;
+	struct work_struct irq_work;
+	bool info_get_64b;
 };
 
 static struct ffa_drv_info *drv_info;
@@ -922,9 +937,153 @@ static void ffa_setup_partitions(void)
 	kfree(pbuf);
 }
 
+/* FFA FEATURE IDs */
+#define FFA_FEAT_NOTIFICATION_PENDING_INT	(1)
+#define FFA_FEAT_SCHEDULE_RECEIVER_INT		(2)
+#define FFA_FEAT_MANAGED_EXIT_INT		(3)
+
+static irqreturn_t irq_handler(int irq, void *irq_data)
+{
+	struct ffa_pcpu_irq *pcpu = irq_data;
+	struct ffa_drv_info *info = pcpu->info;
+
+	queue_work(info->notif_pcpu_wq, &info->irq_work);
+
+	return IRQ_HANDLED;
+}
+
+static void ffa_sched_recv_irq_work_fn(struct work_struct *work)
+{
+	struct ffa_drv_info *info = container_of(work, struct ffa_drv_info,
+						 irq_work);
+
+	ffa_notification_info_get(info->info_get_64b);
+}
+
+static int ffa_sched_recv_irq_map(void)
+{
+	int ret, irq, sr_intid;
+
+	/* The returned sr_intid is assumed to be SGI donated to NS world */
+	ret = ffa_features(FFA_FEAT_SCHEDULE_RECEIVER_INT, 0, &sr_intid, NULL);
+	if (ret < 0) {
+		if (ret != -EOPNOTSUPP)
+			pr_err("Failed to retrieve scheduler Rx interrupt\n");
+		return ret;
+	}
+
+	if (acpi_disabled) {
+		struct of_phandle_args oirq = {};
+		struct device_node *gic;
+
+		/* Only GICv3 supported currently with the device tree */
+		gic = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
+		if (!gic)
+			return -ENXIO;
+
+		oirq.np = gic;
+		oirq.args_count = 1;
+		oirq.args[0] = sr_intid;
+		irq = irq_create_of_mapping(&oirq);
+		of_node_put(gic);
+#ifdef CONFIG_ACPI
+	} else {
+		irq = acpi_register_gsi(NULL, sr_intid, ACPI_EDGE_SENSITIVE,
+					ACPI_ACTIVE_HIGH);
+#endif
+	}
+
+	if (irq <= 0) {
+		pr_err("Failed to create IRQ mapping!\n");
+		return -ENODATA;
+	}
+
+	return irq;
+}
+
+static void ffa_sched_recv_irq_unmap(void)
+{
+	if (drv_info->sched_recv_irq)
+		irq_dispose_mapping(drv_info->sched_recv_irq);
+}
+
+static int ffa_cpuhp_pcpu_irq_enable(unsigned int cpu)
+{
+	enable_percpu_irq(drv_info->sched_recv_irq, IRQ_TYPE_NONE);
+	return 0;
+}
+
+static int ffa_cpuhp_pcpu_irq_disable(unsigned int cpu)
+{
+	disable_percpu_irq(drv_info->sched_recv_irq);
+	return 0;
+}
+
+static void ffa_uninit_pcpu_irq(void)
+{
+	if (drv_info->cpuhp_state)
+		cpuhp_remove_state(drv_info->cpuhp_state);
+
+	if (drv_info->notif_pcpu_wq)
+		destroy_workqueue(drv_info->notif_pcpu_wq);
+
+	if (drv_info->sched_recv_irq)
+		free_percpu_irq(drv_info->sched_recv_irq, drv_info->irq_pcpu);
+
+	if (drv_info->irq_pcpu)
+		free_percpu(drv_info->irq_pcpu);
+}
+
+static int ffa_init_pcpu_irq(unsigned int irq)
+{
+	struct ffa_pcpu_irq __percpu *irq_pcpu;
+	int ret, cpu;
+
+	irq_pcpu = alloc_percpu(struct ffa_pcpu_irq);
+	if (!irq_pcpu)
+		return -ENOMEM;
+
+	for_each_present_cpu(cpu)
+		per_cpu_ptr(irq_pcpu, cpu)->info = drv_info;
+
+	drv_info->irq_pcpu = irq_pcpu;
+
+	ret = request_percpu_irq(irq, irq_handler, "ARM-FFA", irq_pcpu);
+	if (ret) {
+		pr_err("Error registering notification IRQ %d: %d\n", irq, ret);
+		return ret;
+	}
+
+	INIT_WORK(&drv_info->irq_work, ffa_sched_recv_irq_work_fn);
+	drv_info->notif_pcpu_wq = create_workqueue("ffa_pcpu_irq_notification");
+	if (!drv_info->notif_pcpu_wq)
+		return -EINVAL;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "ffa/pcpu-irq:starting",
+				ffa_cpuhp_pcpu_irq_enable,
+				ffa_cpuhp_pcpu_irq_disable);
+
+	if (ret < 0)
+		return ret;
+
+	drv_info->cpuhp_state = ret;
+	return 0;
+}
+
+static void ffa_notifications_cleanup(void)
+{
+	ffa_uninit_pcpu_irq();
+	ffa_sched_recv_irq_unmap();
+
+	if (drv_info->bitmap_created) {
+		ffa_notification_bitmap_destroy();
+		drv_info->bitmap_created = false;
+	}
+}
+
 static int ffa_notifications_setup(void)
 {
-	int ret;
+	int ret, irq;
 
 	ret = ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NULL);
 	if (!ret) {
@@ -936,15 +1095,24 @@ static int ffa_notifications_setup(void)
 	}
 	drv_info->bitmap_created = true;
 
-	return 0;
-}
+	irq = ffa_sched_recv_irq_map();
+	if (irq <= 0)
+		goto cleanup;
 
-static void ffa_notifications_cleanup(void)
-{
-	if (drv_info->bitmap_created) {
-		ffa_notification_bitmap_destroy();
-		drv_info->bitmap_created = false;
-	}
+	if (FFA_FN_NATIVE(NOTIFICATION_INFO_GET) ==
+		FFA_FN64_NOTIFICATION_INFO_GET)
+		drv_info->info_get_64b = true;
+
+	drv_info->sched_recv_irq = irq;
+
+	ret = ffa_init_pcpu_irq(irq);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+cleanup:
+	ffa_notifications_cleanup();
+	return ret;
 }
 
 static int __init ffa_init(void)
@@ -1002,7 +1170,11 @@ static int __init ffa_init(void)
 
 	ffa_set_up_mem_ops_native_flag();
 
-	return ffa_notifications_setup();
+	ret = ffa_notifications_setup();
+	if (ret)
+		goto free_pages;
+
+	return 0;
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);

-- 
2.42.0

