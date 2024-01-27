Return-Path: <linux-kernel+bounces-40947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CA083E8A9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C871C22321
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FA8F49;
	Sat, 27 Jan 2024 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjuKReo6"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816CC8F40
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316220; cv=none; b=WYVgqwKurMyTbrPyKBNE+eVpVwqlSPCyo0xmW++sdU0G2Rtgxfvw582zEeMV/g7m4Irw68qdaBqkRBGgDu/Ihuqf5FHoxUGRO0+MoooF/QdXoCD5LO1tUELn4yN89TqdsXgmf1W2cVOAAJa7zz6hZlmxgM5Yzqykn/XbWqJuFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316220; c=relaxed/simple;
	bh=NcvEgjiiC9dhO/10JdNmADGge4yx5Q6VfAy8AVjWODA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d36kIHNT5UiXl6tuf/5quYhW72wAERISRVHj9lOzUWky+8YgDcuafMsFOgJisnP6uVoxoaobqYwOWSVQWb5Zu+WrOZcCASxCwYYx7g+knC8fvMm3kQNs1sKKgB4MOI0yg2c1on3SpCGXv58+vnLj0d15E+GA+Sy3D9VKAgXk4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjuKReo6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-602d563287cso11247687b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706316217; x=1706921017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVpEyU1ZEIUtuB66OZBKS+wM/IebWFfxC7N5VZ5jlTQ=;
        b=PjuKReo6Mawf1qc0aM1uvio3gZiQfmDjAB+Tssw+7JMVIGcT7vsPpgTMhZ099OztPc
         4Lh1c02x5/wl51OPIIqHJW2h+gSd8B/szL62KbF3uQAbZ9KazSJPuDQNSTrPvBIzJ6tQ
         5MLxbZSvjl+wVQ3pdasNENnqe/78Shek7ugwfazLdQQb00/whRl42a8kqrr1u76ErByE
         Oayt+Tgfm8MskNlD2SBihoI/EpAIvwX6x2xFlhYdwdBhbD/SRuRTJBeJzlR/0akgx6QD
         H16BzR4kZnD68h586tMOozCLIUy1YLoSWmRphuCCb/nUVT+rWIn/AU4Xp2gbKdVNQsLH
         9Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706316217; x=1706921017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVpEyU1ZEIUtuB66OZBKS+wM/IebWFfxC7N5VZ5jlTQ=;
        b=Xzvxw4kzLVPicttlUKhXGW5OmAjYCHoLTYlSZQGrhC2vX7z1d4TxFgIiaAgkHraDuZ
         OEep18y2+jy94sl4CsfJuebT3R38eH8IrbOkIBMyxhTjUs3lsT5rybJ1zFUxK0b7gvsO
         NOYDX1qdZztigCtFjZCQ6t/hyj/uBP6gz/1GZ1gHUBbsJ7y53wSF7JXsBX1Qwci1+Nfm
         ZNwGzh2b37z8VQVc4icuyE813k8bIsP9RDtVlcCt10386Jl6/uwF55CYmrGMZ9VEY/AF
         yHtbCZQoWrakiz4Gm9NRpce2IOKpu1VKb7daehoftJnPS7UgWweLUG/GDuwyg7dWgopy
         6+Yw==
X-Gm-Message-State: AOJu0YwoepWaKtLiWHIeYgtQ6/M3iPna3dVQLN6AxKFQU3dYYAxn0NcN
	DVTktQgYewSxE+D/pluzutM6QLlWHJCoNHsi3KxJyqkZ10AwmOTcWJNV+kfQF0jQoPXLoI9TJZx
	XSmGOuA==
X-Google-Smtp-Source: AGHT+IE/szBT3vMFudSKm/AaI5aALFjntml/r3QIAjBs49SCBNQLy3ZZ3SM/FAzldN3YhxhaxDGm+OxIWSk5
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:d621:88fa:6f6:1b46])
 (user=davidai job=sendgmr) by 2002:a05:6902:2102:b0:dc2:54a9:cbf7 with SMTP
 id dk2-20020a056902210200b00dc254a9cbf7mr340146ybb.13.1706316217535; Fri, 26
 Jan 2024 16:43:37 -0800 (PST)
Date: Fri, 26 Jan 2024 16:43:16 -0800
In-Reply-To: <20240127004321.1902477-1-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240127004321.1902477-1-davidai@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240127004321.1902477-3-davidai@google.com>
Subject: [PATCH v5 2/2] cpufreq: add virtual-cpufreq driver
From: David Dai <davidai@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, David Dai <davidai@google.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pavan Kondeti <quic_pkondeti@quicinc.com>, Gupta Pankaj <pankaj.gupta@amd.com>, 
	Mel Gorman <mgorman@suse.de>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
 drivers/cpufreq/virtual-cpufreq.c | 209 ++++++++++++++++++++++++++++++
 include/linux/arch_topology.h     |   1 +
 4 files changed, 226 insertions(+)
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
index 000000000000..0132f430a13e
--- /dev/null
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -0,0 +1,209 @@
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
+#include <linux/platform_device.h>
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
+static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy,
+					  unsigned int target_freq)
+{
+	writel_relaxed(target_freq,
+		       base + policy->cpu * PER_CPU_OFFSET + REG_SET_FREQ_KHZ_OFFSET);
+	return 0;
+}
+
+static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	virt_cpufreq_set_perf(policy, target_freq);
+	return target_freq;
+}
+
+static int virt_cpufreq_target_index(struct cpufreq_policy *policy,
+				     unsigned int index)
+{
+	return virt_cpufreq_set_perf(policy,
+				     policy->freq_table[index].frequency);
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
+	struct device *cpu_dev;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->related_cpus);
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &policy->freq_table);
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
index a63d61ca55af..fb272b4bf7b1 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -49,6 +49,7 @@ enum scale_freq_source {
 	SCALE_FREQ_SOURCE_CPUFREQ = 0,
 	SCALE_FREQ_SOURCE_ARCH,
 	SCALE_FREQ_SOURCE_CPPC,
+	SCALE_FREQ_SOURCE_VIRT,
 };
 
 struct scale_freq_data {
-- 
2.43.0.429.g432eaa2c6b-goog


