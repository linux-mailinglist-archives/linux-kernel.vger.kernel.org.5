Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1801E7E8800
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjKKBuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjKKBuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:50:01 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0607744B6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:49:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da07b5e6f75so3004813276.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699667396; x=1700272196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5zYvNy11wPFSXtbOCMF1jmCxoULUPk8AuRfEcB+0ec=;
        b=ai2g+uoYus0H1rcrIVWAChCtNoh+LJ09G+R3nXuo0yvoYXgfA3IGd4fMlAGL+6U2VW
         dMI1Z1j7c8LcSqsXVH1e+4byaRtLV+YGqbUfnFe3h62TeKz3m298KX/HaLKN2I9TWKOy
         PBOPerUR+YY8SBFQJLVE5XkMIDrsZ7YIQGf9Lp6VSM+dVQhR+3QHJ984xWRUsVOMafmm
         0uoXr2Ri5GKBWZnq6vw6cf3z2/PYHLI9QSU3fRKtRtDIKJMhOYDZbjfPAMKu/kzYsw5+
         9II5mc+La7Ysr93/7Ad5HoZW9/q0jtYfoaLf4mRYTTWGn5XhLaFGki7sZzPI6MFPW4oo
         dFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699667396; x=1700272196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5zYvNy11wPFSXtbOCMF1jmCxoULUPk8AuRfEcB+0ec=;
        b=g9kdqtBIMvhjUYRV4zWcUMNbsfAIxBynecc7RnQEfjX7DXI7uZVW1DTVMSPskt3h1x
         3v4tx6nOSE12lTHYPu66fTevt5XO2BBAtwMUsJXDgjh5NXmuFFjO/E+1XJO5PHW3wwvO
         s56scdnvU3yHPsZpSkynQVClYpo8w35QlZY8AX0B3UbPr44WPHpWpcPyagb9EUUTgNnF
         pzfcIpojXHab4CzcVc1xHrUTNQ+9SzOMT8I17JTvmpzNrA922ijPNsoh84IDb0o5ys6P
         MBdnZ6umPfHWa3vrHLB3hlSObew53YMqzQTOWw3y6GttpCFf6BGA0JK5lz0Dm2jrbmWB
         RZJg==
X-Gm-Message-State: AOJu0Yy4CiJcFHZaYQGs+4rjJssovsdFLb8EpzpJHahs68jLCMlWH5Df
        EzMXjX/+vQ9mv8jzQnoog/7MKdZD/lif
X-Google-Smtp-Source: AGHT+IGlkaHWtGqV0UkJu0rvtA1k9ZZ57Gs66Jwq7SIIgYI9wrEfdfCXzyPpZ9/K7DvXZAhRDM+MJo8CPWkW
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:77fa:5ee:8100:77])
 (user=davidai job=sendgmr) by 2002:a25:9e88:0:b0:d9c:f811:eb9e with SMTP id
 p8-20020a259e88000000b00d9cf811eb9emr27355ybq.4.1699667396287; Fri, 10 Nov
 2023 17:49:56 -0800 (PST)
Date:   Fri, 10 Nov 2023 17:49:30 -0800
In-Reply-To: <20231111014933.1934562-1-davidai@google.com>
Mime-Version: 1.0
References: <20231111014933.1934562-1-davidai@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231111014933.1934562-3-davidai@google.com>
Subject: [PATCH v4 2/2] cpufreq: add virtual-cpufreq driver
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
 drivers/cpufreq/Kconfig           |  15 +++
 drivers/cpufreq/Makefile          |   1 +
 drivers/cpufreq/virtual-cpufreq.c | 201 ++++++++++++++++++++++++++++++
 include/linux/arch_topology.h     |   1 +
 4 files changed, 218 insertions(+)
 create mode 100644 drivers/cpufreq/virtual-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 35efb53d5492..f2d37075aa10 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -217,6 +217,21 @@ config CPUFREQ_DT
 
 	  If in doubt, say N.
 
+config CPUFREQ_VIRT
+	tristate "Virtual cpufreq driver"
+	depends on OF
+	select PM_OPP
+	help
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
index 8d141c71b016..eb72ecdc24db 100644
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
index 000000000000..f828d3345a68
--- /dev/null
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -0,0 +1,201 @@
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
+#define REG_CUR_FREQ_KHZ_OFFSET 0x0
+#define REG_SET_FREQ_KHZ_OFFSET 0x4
+#define PER_CPU_OFFSET 0x8
+
+static void __iomem *base;
+
+static void virt_scale_freq_tick(void)
+{
+	int cpu = smp_processor_id();
+	u32 max_freq = (u32)cpufreq_get_hw_max_freq(cpu);
+	u64 cur_freq;
+	unsigned long scale;
+
+	cur_freq = (u64)readl_relaxed(base + cpu * PER_CPU_OFFSET
+			+ REG_CUR_FREQ_KHZ_OFFSET);
+
+	cur_freq <<= SCHED_CAPACITY_SHIFT;
+	scale = (unsigned long)div_u64(cur_freq, max_freq);
+	scale = min(scale, SCHED_CAPACITY_SCALE);
+
+	this_cpu_write(arch_freq_scale, scale);
+}
+
+static struct scale_freq_data virt_sfd = {
+	.source = SCALE_FREQ_SOURCE_VIRT,
+	.set_freq_scale = virt_scale_freq_tick,
+};
+
+static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy)
+{
+	writel_relaxed(policy->cached_target_freq,
+		       base + policy->cpu * PER_CPU_OFFSET + REG_SET_FREQ_KHZ_OFFSET);
+	return 0;
+}
+
+static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	virt_cpufreq_set_perf(policy);
+	return target_freq;
+}
+
+static int virt_cpufreq_target_index(struct cpufreq_policy *policy,
+				     unsigned int index)
+{
+	return virt_cpufreq_set_perf(policy);
+}
+
+static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
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
+
+	/*
+	 * To simplify and improve latency of handling frequency requests on
+	 * the host side, this ensures that the vCPU thread triggering the MMIO
+	 * abort is the same thread whose performance constraints (Ex. uclamp
+	 * settings) need to be updated. This simplifies the VMM (Virtual
+	 * Machine Manager) having to find the correct vCPU thread and/or
+	 * facing permission issues when configuring other threads.
+	 */
+	policy->dvfs_possible_from_any_cpu = false;
+	policy->fast_switch_possible = true;
+
+	/*
+	 * Using the default SCALE_FREQ_SOURCE_CPUFREQ is insufficient since
+	 * the actual physical CPU frequency may not match requested frequency
+	 * from the vCPU thread due to frequency update latencies or other
+	 * inputs to the physical CPU frequency selection. This additional FIE
+	 * source allows for more accurate freq_scale updates and only takes
+	 * effect if another FIE source such as AMUs have not been registered.
+	 */
+	topology_set_scale_freq_source(&virt_sfd, policy->cpus);
+
+	return 0;
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
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
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
+	{ .compatible = "qemu,virtual-cpufreq", .data = NULL},
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
2.42.0.869.gea05f2083d-goog

