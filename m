Return-Path: <linux-kernel+bounces-127265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A40D8948ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EBF283DAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BF913AEE;
	Tue,  2 Apr 2024 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vqJv50+j"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4451F9EC;
	Tue,  2 Apr 2024 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022471; cv=none; b=n66R1FYMODO/JzitbVvo7oDh+CLzhE4T3FtdY38rNRFxsCPY6eWuy9ssb0/pUN/3PPtXDV44xRZWcOBqlHn5PBsylwtWFz8gV7Qa/Y8NydPC8Efqte7CZC2jjftRBwubWENoNXtT5pa08wQX0otdGo7595vX5d0Pi05BsrgMdqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022471; c=relaxed/simple;
	bh=k41Pvw0mfXzaqhx1OVEqvFMH75xZ+Wubo5cMCx7DvZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+4erVAWARux7zPfMREekMuHDdbbt245Eu2jXrvragwtxXcSyjTax58SfjfwloizJl6ofETeXthDuJOd+ksKcx8mIO1OzTzTaEY1NxjKtPdIuVAECr7Y6jslOqazs+t3CrTtzHVZG+VHXpyn8Z69yk0i48WIHs0o8SnsvypLUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vqJv50+j; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712022470; x=1743558470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nmUKUSi2MoSUY6V0czBUbSS/ooN8zBAEjuFUgPRajcw=;
  b=vqJv50+jcA2YB25b6Zr9xtHWa0RSQNjZa3zVgaPjOaOjeZyB4rsL/HC0
   Ve82KKfSGLUr3DFIMCDcxwRSVROR4fyjAp1mTAVcvGOGoqO5oWRjBRWK2
   rMnM/HOP+2SwZHvmYdd/G8tT+LJHLcn/no72rUnmvLoF9JVbbxBFhNMc/
   E=;
X-IronPort-AV: E=Sophos;i="6.07,173,1708387200"; 
   d="scan'208";a="408337927"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 01:47:49 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:1848]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.248:2525] with esmtp (Farcaster)
 id dbdfce37-3297-4f21-86c3-3f98adefad0d; Tue, 2 Apr 2024 01:47:48 +0000 (UTC)
X-Farcaster-Flow-ID: dbdfce37-3297-4f21-86c3-3f98adefad0d
Received: from EX19D001UWA003.ant.amazon.com (10.13.138.211) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 2 Apr 2024 01:47:48 +0000
Received: from u34cccd802f2d52.ant.amazon.com (10.252.141.8) by
 EX19D001UWA003.ant.amazon.com (10.13.138.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 2 Apr 2024 01:47:46 +0000
From: Haris Okanovic <harisokn@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-assembly@vger.kernel.org>
CC: <peterz@infradead.org>, Haris Okanovic <harisokn@amazon.com>, Ali Saidi
	<alisaidi@amazon.com>, Geoff Blake <blakgeof@amazon.com>, Brian Silver
	<silverbr@amazon.com>
Subject: [PATCH 3/3] arm64: cpuidle: Add arm_poll_idle
Date: Mon, 1 Apr 2024 20:47:06 -0500
Message-ID: <20240402014706.3969151-3-harisokn@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402014706.3969151-1-harisokn@amazon.com>
References: <20240402014706.3969151-1-harisokn@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D001UWA003.ant.amazon.com (10.13.138.211)

An arm64 cpuidle driver with two states: (1) First polls for new runable
tasks up to 100 us (by default) before (2) a wfi idle and awoken by
interrupt (the current arm64 behavior). It allows CPUs to return from
idle more quickly by avoiding the longer interrupt wakeup path, which
may require EL1/EL2 transition in certain VM scenarios.

Poll duration is optionally configured at load time via the poll_limit
module parameter.

The default 100 us duration was experimentally chosen, by measuring QPS
(queries per sec) of the MLPerf bert inference benchmark, which seems
particularly susceptible to this change; see procedure below. 100 us is
the inflection point where QPS stopped growing in a range of tested
values. All results are from AWS m7g.16xlarge instances (Graviton3 SoC)
with dedicated tenancy (dedicated hardware).

| before | 10us  | 25us | 50us | 100us | 125us | 150us | 200us | 300us |
| 5.87   | 5.91  | 5.96 | 6.01 | 6.06  | 6.07  | 6.06  | 6.06  | 6.06  |

Perf's scheduler benchmarks also improve with a range of poll_limit
values >= 10 us. Higher limits produce near identical results within a
3% noise margin. The following tables are `perf bench sched` results,
run times in seconds.

`perf bench sched messaging -l 80000`
| AWS instance  | SoC       | Before | After  | % Change |
| c6g.16xl (VM) | Graviton2 | 18.974 | 18.400 | none     |
| c7g.16xl (VM) | Graviton3 | 13.852 | 13.859 | none     |
| c6g.metal     | Graviton2 | 17.621 | 16.744 | none     |
| c7g.metal     | Graviton3 | 13.430 | 13.404 | none     |

`perf bench sched pipe -l 2500000`
| AWS instance  | SoC       | Before | After  | % Change |
| c6g.16xl (VM) | Graviton2 | 30.158 | 15.181 | -50%     |
| c7g.16xl (VM) | Graviton3 | 18.289 | 12.067 | -34%     |
| c6g.metal     | Graviton2 | 17.609 | 15.170 | -14%     |
| c7g.metal     | Graviton3 | 14.103 | 12.304 | -13%     |

`perf bench sched seccomp-notify -l 2500000`
| AWS instance  | SoC       | Before | After  | % Change |
| c6g.16xl (VM) | Graviton2 | 28.784 | 13.754 | -52%     |
| c7g.16xl (VM) | Graviton3 | 16.964 | 11.430 | -33%     |
| c6g.metal     | Graviton2 | 15.717 | 13.536 | -14%     |
| c7g.metal     | Graviton3 | 13.301 | 11.491 | -14%     |

Steps to run MLPerf bert inference on Ubuntu 22.04:
 sudo apt install build-essential python3 python3-pip
 pip install "pybind11[global]" tensorflow  transformers
 export TF_ENABLE_ONEDNN_OPTS=1
 export DNNL_DEFAULT_FPMATH_MODE=BF16
 git clone https://github.com/mlcommons/inference.git --recursive
 cd inference
 git checkout v2.0
 cd loadgen
 CFLAGS="-std=c++14" python3 setup.py bdist_wheel
 pip install dist/*.whl
 cd ../language/bert
 make setup
 python3 run.py --backend=tf --scenario=SingleStream

Suggested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Geoff Blake <blakgeof@amazon.com>
Cc: Brian Silver <silverbr@amazon.com>
Signed-off-by: Haris Okanovic <harisokn@amazon.com>
---
 drivers/cpuidle/Kconfig.arm           |  13 ++
 drivers/cpuidle/Makefile              |   1 +
 drivers/cpuidle/cpuidle-arm-polling.c | 171 ++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-arm-polling.c

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index a1ee475d180d..484666dda38d 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -14,6 +14,19 @@ config ARM_CPUIDLE
 	  initialized by calling the CPU operations init idle hook
 	  provided by architecture code.
 
+config ARM_POLL_CPUIDLE
+	bool "ARM64 CPU idle Driver with polling"
+	depends on ARM64
+	depends on ARM_ARCH_TIMER_EVTSTREAM
+	select CPU_IDLE_MULTIPLE_DRIVERS
+	help
+	  Select this to enable a polling cpuidle driver for ARM64:
+	  The first state polls TIF_NEED_RESCHED for best latency on short
+	  sleep intervals. The second state falls back to arch_cpu_idle() to
+	  wait for interrupt. This is can be helpful in workloads that
+	  frequently block/wake at short intervals or VMs where wakeup IPIs
+	  are more expensive.
+
 config ARM_PSCI_CPUIDLE
 	bool "PSCI CPU idle Driver"
 	depends on ARM_PSCI_FW
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index d103342b7cfc..23c21422792d 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
 obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
+obj-$(CONFIG_ARM_POLL_CPUIDLE)		+= cpuidle-arm-polling.o
 obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
 obj-$(CONFIG_ARM_PSCI_CPUIDLE_DOMAIN)	+= cpuidle-psci-domain.o
 obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
diff --git a/drivers/cpuidle/cpuidle-arm-polling.c b/drivers/cpuidle/cpuidle-arm-polling.c
new file mode 100644
index 000000000000..bca128568114
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-arm-polling.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM64 CPU idle driver using wfe polling
+ *
+ * Copyright 2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ *
+ * Authors:
+ *   Haris Okanovic <harisokn@amazon.com>
+ *   Brian Silver <silverbr@amazon.com>
+ *
+ * Based on cpuidle-arm.c
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpu_cooling.h>
+#include <linux/cpuidle.h>
+#include <linux/sched/clock.h>
+
+#include <asm/cpuidle.h>
+#include <asm/readex.h>
+
+#include "dt_idle_states.h"
+
+/* Max duration of the wfe() poll loop in us, before transitioning to
+ * arch_cpu_idle()/wfi() sleep.
+ */
+#define DEFAULT_POLL_LIMIT_US 100
+static unsigned int poll_limit __read_mostly = DEFAULT_POLL_LIMIT_US;
+
+/*
+ * arm_idle_wfe_poll - Polls state in wfe loop until reschedule is
+ * needed or timeout
+ */
+static int __cpuidle arm_idle_wfe_poll(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int idx)
+{
+	u64 time_start, time_limit;
+
+	time_start = local_clock();
+	dev->poll_time_limit = false;
+
+	local_irq_enable();
+
+	if (current_set_polling_and_test())
+		goto end;
+
+	time_limit = cpuidle_poll_time(drv, dev);
+
+	do {
+		// exclusive read arms the monitor for wfe
+		if (__READ_ONCE_EX(current_thread_info()->flags) & _TIF_NEED_RESCHED)
+			goto end;
+
+		// may exit prematurely, see ARM_ARCH_TIMER_EVTSTREAM
+		wfe();
+	} while (local_clock() - time_start < time_limit);
+
+	dev->poll_time_limit = true;
+
+end:
+	current_clr_polling();
+	return idx;
+}
+
+/*
+ * arm_idle_wfi - Places cpu in lower power state until interrupt,
+ * a fallback to polling
+ */
+static int __cpuidle arm_idle_wfi(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int idx)
+{
+	if (current_clr_polling_and_test()) {
+		local_irq_enable();
+		return idx;
+	}
+	arch_cpu_idle();
+	return idx;
+}
+
+static struct cpuidle_driver arm_poll_idle_driver __initdata = {
+	.name = "arm_poll_idle",
+	.owner = THIS_MODULE,
+	.states = {
+		{
+			.enter			= arm_idle_wfe_poll,
+			.exit_latency		= 0,
+			.target_residency	= 0,
+			.exit_latency_ns	= 0,
+			.power_usage		= UINT_MAX,
+			.flags			= CPUIDLE_FLAG_POLLING,
+			.name			= "WFE",
+			.desc			= "ARM WFE",
+		},
+		{
+			.enter			= arm_idle_wfi,
+			.exit_latency		= DEFAULT_POLL_LIMIT_US,
+			.target_residency	= DEFAULT_POLL_LIMIT_US,
+			.power_usage		= UINT_MAX,
+			.name			= "WFI",
+			.desc			= "ARM WFI",
+		},
+	},
+	.state_count = 2,
+};
+
+/*
+ * arm_poll_init_cpu - Initializes arm cpuidle polling driver for one cpu
+ */
+static int __init arm_poll_init_cpu(int cpu)
+{
+	int ret;
+	struct cpuidle_driver *drv;
+
+	drv = kmemdup(&arm_poll_idle_driver, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
+	drv->states[1].exit_latency = poll_limit;
+	drv->states[1].target_residency = poll_limit;
+
+	ret = cpuidle_register(drv, NULL);
+	if (ret) {
+		pr_err("failed to register driver: %d, cpu %d\n", ret, cpu);
+		goto out_kfree_drv;
+	}
+
+	pr_info("registered driver cpu %d\n", cpu);
+
+	cpuidle_cooling_register(drv);
+
+	return 0;
+
+out_kfree_drv:
+	kfree(drv);
+	return ret;
+}
+
+/*
+ * arm_poll_init - Initializes arm cpuidle polling driver
+ */
+static int __init arm_poll_init(void)
+{
+	int cpu, ret;
+	struct cpuidle_driver *drv;
+	struct cpuidle_device *dev;
+
+	for_each_possible_cpu(cpu) {
+		ret = arm_poll_init_cpu(cpu);
+		if (ret)
+			goto out_fail;
+	}
+
+	return 0;
+
+out_fail:
+	pr_info("de-register all");
+	while (--cpu >= 0) {
+		dev = per_cpu(cpuidle_devices, cpu);
+		drv = cpuidle_get_cpu_driver(dev);
+		cpuidle_unregister(drv);
+		kfree(drv);
+	}
+
+	return ret;
+}
+
+module_param(poll_limit, uint, 0444);
+device_initcall(arm_poll_init);
-- 
2.34.1


