Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1196A769FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGaRro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGaRri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:47:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30B199A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:47:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5847479b559so56169287b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690825653; x=1691430453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lyiOmduPphwKP1TYhs95hV8rTF98G0vjDVCfm7076M=;
        b=pTr9lBURB05TuAnN+Pw9E1YbBy/yfW3PathJCDcVGQvAe12cFXBjzHcoAJ1jF+H0ka
         g5aVX7t2Q2NRyLSN/RpBfhuubwOYSdPUYWm7A6FIuQYCSliu3OgKysdbw2cp7KBOQ0bd
         uS/RPNfQ3KxXU6VDg7JcgjWgSOWDMW90G3XoyZz+ey2gfHRsJRvXuh8t4wBT6v6GoW74
         K5Ek42aaAW1qoGjnu9fkWX1qy1lKV5kNwWkNFvhAFfANDEtIddZ5Gm++sc4Qcv99e7/0
         qbGWkqOz+Pqwmr7c8EjJNxsjVImBWEwW5tozbvdxJkExVos6bWyf4XU2Km6NOSAwIgm9
         YYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690825653; x=1691430453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lyiOmduPphwKP1TYhs95hV8rTF98G0vjDVCfm7076M=;
        b=XCek7VZ4L8nFpTVV+ucgiXyPO6qIcR1B0emcgsH6gdvvvKKzZD86PQesKp6gxrtVOc
         tNQnICkfJdj0v7PCcLLivvTT6saTNThbyexmRZjBs5UlPjpEBKdCQ7fNZctPuDSY76KJ
         LuMvXDK7IPS2cxiicVbBQuJDgtpku5KYUD4oAzDy7VnBrV5Yj1o2oTaGQIoqd9CC5h7x
         cODk9Ogif2+dp5mRx1a08y9iBvXajlHuguuQQTm5f7t+bH67xwfVO9eVtJrA5lnEPIOD
         YkTLx8JhASDtpfPLQ5B7Un0mYUm0gj8gnscKtYPs4kpzFe2xwGoibu7cct5CjDwrQPxl
         dpjg==
X-Gm-Message-State: ABy/qLY2UXVnpmGqeHqO8vk6J0I+X0w/9VYw7JUWw+y//BiMScSQ6U2C
        49rZByAq0QqCv0MfPnedB+NFGshxNkIV
X-Google-Smtp-Source: APBJJlH6u20HUC41hybaCjrbrEHeVrWm9JoKjj4vyjbCA6WK4IKFfiiKS0KQaSjHYajvH0Gv50+1PXqkRTf3
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:4949:e05:91e:bd74])
 (user=davidai job=sendgmr) by 2002:a81:b104:0:b0:583:9913:f293 with SMTP id
 p4-20020a81b104000000b005839913f293mr79039ywh.1.1690825653600; Mon, 31 Jul
 2023 10:47:33 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:46:09 -0700
In-Reply-To: <20230731174613.4133167-1-davidai@google.com>
Mime-Version: 1.0
References: <20230731174613.4133167-1-davidai@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731174613.4133167-3-davidai@google.com>
Subject: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
From:   David Dai <davidai@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        David Dai <davidai@google.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a virtualized cpufreq driver for guest kernels to improve
performance and power of workloads within VMs.

This driver does two main things:

1. Sends the frequency of vCPUs as a hint to the host. The host uses the
hint to schedule the vCPU threads and decide physical CPU frequency.

2. If a VM does not support a virtualized FIE(like AMUs), it queries the
host CPU frequency by reading a MMIO region of a virtual cpufreq device
to update the guest's frequency scaling factor periodically. This enables
accurate Per-Entity Load Tracking for tasks running in the guest.

Co-developed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: David Dai <davidai@google.com>
---
 drivers/cpufreq/Kconfig           |  15 ++
 drivers/cpufreq/Makefile          |   1 +
 drivers/cpufreq/virtual-cpufreq.c | 237 ++++++++++++++++++++++++++++++
 include/linux/arch_topology.h     |   1 +
 4 files changed, 254 insertions(+)
 create mode 100644 drivers/cpufreq/virtual-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index f429b9b37b76..3977ca796747 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -217,6 +217,21 @@ config CPUFREQ_DT
 
 	  If in doubt, say N.
 
+config CPUFREQ_VIRT
+        tristate "Virtual cpufreq driver"
+	depends on OF
+	select PM_OPP
+        help
+	  This adds a virtualized cpufreq driver for guest kernels that
+	  read/writes to a MMIO region for a virtualized cpufreq device to
+	  communicate with the host. It sends frequency updates to the host
+	  which gets used as a hint to schedule vCPU threads and select CPU
+	  frequency. If a VM does not support a virtualized FIE such as AMUs,
+	  it updates the frequency scaling factor by polling host CPU frequency
+	  to enable accurate Per-Entity Load Tracking for tasks running in the guest.
+
+	  If in doubt, say N.
+
 config CPUFREQ_DT_PLATDEV
 	tristate "Generic DT based cpufreq platdev driver"
 	depends on OF
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index ef8510774913..bbc9f9bdfa4b 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
+obj-$(CONFIG_CPUFREQ_VIRT)		+= virtual-cpufreq.o
 
 # Traces
 CFLAGS_amd-pstate-trace.o               := -I$(src)
diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
new file mode 100644
index 000000000000..66b0fd9b821c
--- /dev/null
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Google LLC
+ */
+
+#include <linux/arch_topology.h>
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#define REG_CUR_FREQ_OFFSET 0x0
+#define REG_SET_FREQ_OFFSET 0x4
+#define PER_CPU_OFFSET 0x8
+
+struct virt_cpufreq_ops {
+	void (*set_freq)(struct cpufreq_policy *policy, u32 freq);
+	u32 (*get_freq)(struct cpufreq_policy *policy);
+};
+
+struct virt_cpufreq_drv_data {
+	void __iomem *base;
+	const struct virt_cpufreq_ops *ops;
+};
+
+static void virt_cpufreq_set_freq(struct cpufreq_policy *policy, u32 freq)
+{
+	struct virt_cpufreq_drv_data *data = policy->driver_data;
+
+	writel_relaxed(freq, data->base + policy->cpu * PER_CPU_OFFSET
+			+ REG_SET_FREQ_OFFSET);
+}
+
+static u32 virt_cpufreq_get_freq(struct cpufreq_policy *policy)
+{
+	struct virt_cpufreq_drv_data *data = policy->driver_data;
+
+	return readl_relaxed(data->base + policy->cpu * PER_CPU_OFFSET
+			+ REG_CUR_FREQ_OFFSET);
+}
+
+static const struct virt_cpufreq_ops virt_freq_ops = {
+	.set_freq = virt_cpufreq_set_freq,
+	.get_freq = virt_cpufreq_get_freq,
+};
+
+static void virt_scale_freq_tick(void)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(smp_processor_id());
+	struct virt_cpufreq_drv_data *data = policy->driver_data;
+	u32 max_freq = (u32)policy->cpuinfo.max_freq;
+	u64 cur_freq;
+	u64 scale;
+
+	cpufreq_cpu_put(policy);
+
+	cur_freq = (u64)data->ops->get_freq(policy);
+	cur_freq <<= SCHED_CAPACITY_SHIFT;
+	scale = div_u64(cur_freq, max_freq);
+
+	this_cpu_write(arch_freq_scale, (unsigned long)scale);
+}
+
+static struct scale_freq_data virt_sfd = {
+	.source = SCALE_FREQ_SOURCE_VIRT,
+	.set_freq_scale = virt_scale_freq_tick,
+};
+
+static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy)
+{
+	struct virt_cpufreq_drv_data *data = policy->driver_data;
+	/*
+	 * Use cached frequency to avoid rounding to freq table entries
+	 * and undo 25% frequency boost applied by schedutil.
+	 */
+	u32 freq = mult_frac(policy->cached_target_freq, 80, 100);
+
+	data->ops->set_freq(policy, freq);
+	return 0;
+}
+
+static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy *policy,
+		unsigned int target_freq)
+{
+	virt_cpufreq_set_perf(policy);
+	return target_freq;
+}
+
+static int virt_cpufreq_target_index(struct cpufreq_policy *policy,
+		unsigned int index)
+{
+	return virt_cpufreq_set_perf(policy);
+}
+
+static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	struct virt_cpufreq_drv_data *drv_data = cpufreq_get_driver_data();
+	struct cpufreq_frequency_table *table;
+	struct device *cpu_dev;
+	int ret;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	ret = dev_pm_opp_of_add_table(cpu_dev);
+	if (ret)
+		return ret;
+
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		dev_err(cpu_dev, "OPP table can't be empty\n");
+		return -ENODEV;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &table);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		return ret;
+	}
+
+	policy->freq_table = table;
+	policy->dvfs_possible_from_any_cpu = false;
+	policy->fast_switch_possible = true;
+	policy->driver_data = drv_data;
+
+	/*
+	 * Only takes effect if another FIE source such as AMUs
+	 * have not been registered.
+	 */
+	topology_set_scale_freq_source(&virt_sfd, policy->cpus);
+
+	return 0;
+
+}
+
+static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->related_cpus);
+	kfree(policy->freq_table);
+	policy->freq_table = NULL;
+	return 0;
+}
+
+static int virt_cpufreq_online(struct cpufreq_policy *policy)
+{
+	/* Nothing to restore. */
+	return 0;
+}
+
+static int virt_cpufreq_offline(struct cpufreq_policy *policy)
+{
+	/* Dummy offline() to avoid exit() being called and freeing resources. */
+	return 0;
+}
+
+static struct cpufreq_driver cpufreq_virt_driver = {
+	.name		= "virt-cpufreq",
+	.init		= virt_cpufreq_cpu_init,
+	.exit		= virt_cpufreq_cpu_exit,
+	.online         = virt_cpufreq_online,
+	.offline        = virt_cpufreq_offline,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= virt_cpufreq_target_index,
+	.fast_switch	= virt_cpufreq_fast_switch,
+	.attr		= cpufreq_generic_attr,
+};
+
+static int virt_cpufreq_driver_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct virt_cpufreq_drv_data *drv_data;
+
+	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
+	if (!drv_data)
+		return -ENOMEM;
+
+	drv_data->ops = of_device_get_match_data(&pdev->dev);
+	if (!drv_data->ops)
+		return -EINVAL;
+
+	drv_data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(drv_data->base))
+		return PTR_ERR(drv_data->base);
+
+	cpufreq_virt_driver.driver_data = drv_data;
+
+	ret = cpufreq_register_driver(&cpufreq_virt_driver);
+	if (ret) {
+		dev_err(&pdev->dev, "Virtual CPUFreq driver failed to register: %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&pdev->dev, "Virtual CPUFreq driver initialized\n");
+	return 0;
+}
+
+static int virt_cpufreq_driver_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&cpufreq_virt_driver);
+	return 0;
+}
+
+static const struct of_device_id virt_cpufreq_match[] = {
+	{ .compatible = "virtual,cpufreq", .data = &virt_freq_ops},
+	{}
+};
+MODULE_DEVICE_TABLE(of, virt_cpufreq_match);
+
+static struct platform_driver virt_cpufreq_driver = {
+	.probe = virt_cpufreq_driver_probe,
+	.remove = virt_cpufreq_driver_remove,
+	.driver = {
+		.name = "virt-cpufreq",
+		.of_match_table = virt_cpufreq_match,
+	},
+};
+
+static int __init virt_cpufreq_init(void)
+{
+	return platform_driver_register(&virt_cpufreq_driver);
+}
+postcore_initcall(virt_cpufreq_init);
+
+static void __exit virt_cpufreq_exit(void)
+{
+	platform_driver_unregister(&virt_cpufreq_driver);
+}
+module_exit(virt_cpufreq_exit);
+
+MODULE_DESCRIPTION("Virtual cpufreq driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a07b510e7dc5..888282dce2ba 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -42,6 +42,7 @@ enum scale_freq_source {
 	SCALE_FREQ_SOURCE_CPUFREQ = 0,
 	SCALE_FREQ_SOURCE_ARCH,
 	SCALE_FREQ_SOURCE_CPPC,
+	SCALE_FREQ_SOURCE_VIRT,
 };
 
 struct scale_freq_data {
-- 
2.41.0.585.gd2178a4bd4-goog

