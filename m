Return-Path: <linux-kernel+bounces-26638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF3882E468
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D222838CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C2111A0;
	Tue, 16 Jan 2024 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqvej9ew"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC41119E;
	Tue, 16 Jan 2024 00:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0345CC433F1;
	Tue, 16 Jan 2024 00:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705363998;
	bh=B/pzjSFZjA/xOdsawpBkIOGtEnV9muLApf9oW5IKgnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqvej9ew9k3qg6okLpc7f+p7HQ1X3plmYhI4wJ0w6aAvNDYGxdTJutMJm3PbrQEmV
	 f2RHJYrMxgbRJPkjrfBvmPakaWcQmjWM0H3hN2IiJrhzpYAvY9jD/qgWHaa6bFg24O
	 BTuGQCdp6faLfzfs5DBb4BhLIJk2OCXa0T3JRDYZ4bt//5E/anNnjOWrVXo6kLdwnt
	 6mBysTwnKaMa7JvdbGsBVD2aTjxJxmeGfd6WhMTugsdGM9LznXK7wBWJqP2XIRq9Bh
	 RF5j8wJnXqyO5ZfgJsKrolPyQ/wtY56rbrHWnwZnPoKe2lGBnCwlnRYQPUADTWzgnQ
	 SQ1YWGQAyL+vQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srikar Srimath Tirumala <srikars@nvidia.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lpieralisi@kernel.org,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 05/18] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
Date: Mon, 15 Jan 2024 19:12:47 -0500
Message-ID: <20240116001308.212917-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001308.212917-1-sashal@kernel.org>
References: <20240116001308.212917-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Srikar Srimath Tirumala <srikars@nvidia.com>

[ Upstream commit 310293a2b94197f3d75e65ab22672287a7938a00 ]

Current implementation of processor_thermal performs software throttling
in fixed steps of "20%" which can be too coarse for some platforms.
We observed some performance gain after reducing the throttle percentage.
Change the CPUFREQ thermal reduction percentage and maximum thermal steps
to be configurable. Also, update the default values of both for Nvidia
Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "5%"
and accordingly the maximum number of thermal steps are increased as they
are derived from the reduction percentage.

Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/arm64/Makefile          |  1 +
 drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++
 drivers/acpi/internal.h              |  9 +++++
 drivers/acpi/processor_thermal.c     | 49 +++++++++++++++++++++++-----
 4 files changed, 70 insertions(+), 9 deletions(-)
 create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c

diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 143debc1ba4a..726944648c9b 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
 obj-y				+= dma.o init.o
+obj-y				+= thermal_cpufreq.o
diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
new file mode 100644
index 000000000000..d524f2cd6044
--- /dev/null
+++ b/drivers/acpi/arm64/thermal_cpufreq.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/acpi.h>
+
+#include "../internal.h"
+
+#define SMCCC_SOC_ID_T241      0x036b0241
+
+int acpi_arch_thermal_cpufreq_pctg(void)
+{
+	s32 soc_id = arm_smccc_get_soc_id_version();
+
+	/*
+	 * Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) and
+	 * reduce the CPUFREQ Thermal reduction percentage to 5%.
+	 */
+	if (soc_id == SMCCC_SOC_ID_T241)
+		return 5;
+
+	return 0;
+}
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 866c7c4ed233..af1198e2b526 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -85,6 +85,15 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
 void acpi_scan_table_notify(void);
 
+#ifdef CONFIG_ARM64
+int acpi_arch_thermal_cpufreq_pctg(void);
+#else
+static inline int acpi_arch_thermal_cpufreq_pctg(void)
+{
+	return 0;
+}
+#endif
+
 /* --------------------------------------------------------------------------
                      Device Node Initialization / Removal
    -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index b7c6287eccca..1219adb11ab9 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -17,6 +17,8 @@
 #include <acpi/processor.h>
 #include <linux/uaccess.h>
 
+#include "internal.h"
+
 #ifdef CONFIG_CPU_FREQ
 
 /* If a passive cooling situation is detected, primarily CPUfreq is used, as it
@@ -26,12 +28,21 @@
  */
 
 #define CPUFREQ_THERMAL_MIN_STEP 0
-#define CPUFREQ_THERMAL_MAX_STEP 3
 
-static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
+static int cpufreq_thermal_max_step __read_mostly = 3;
+
+/*
+ * Minimum throttle percentage for processor_thermal cooling device.
+ * The processor_thermal driver uses it to calculate the percentage amount by
+ * which cpu frequency must be reduced for each cooling state. This is also used
+ * to calculate the maximum number of throttling steps or cooling states.
+ */
+static int cpufreq_thermal_reduction_pctg __read_mostly = 20;
 
-#define reduction_pctg(cpu) \
-	per_cpu(cpufreq_thermal_reduction_pctg, phys_package_first_cpu(cpu))
+static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_step);
+
+#define reduction_step(cpu) \
+	per_cpu(cpufreq_thermal_reduction_step, phys_package_first_cpu(cpu))
 
 /*
  * Emulate "per package data" using per cpu data (which should really be
@@ -71,7 +82,7 @@ static int cpufreq_get_max_state(unsigned int cpu)
 	if (!cpu_has_cpufreq(cpu))
 		return 0;
 
-	return CPUFREQ_THERMAL_MAX_STEP;
+	return cpufreq_thermal_max_step;
 }
 
 static int cpufreq_get_cur_state(unsigned int cpu)
@@ -79,7 +90,7 @@ static int cpufreq_get_cur_state(unsigned int cpu)
 	if (!cpu_has_cpufreq(cpu))
 		return 0;
 
-	return reduction_pctg(cpu);
+	return reduction_step(cpu);
 }
 
 static int cpufreq_set_cur_state(unsigned int cpu, int state)
@@ -92,7 +103,7 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 	if (!cpu_has_cpufreq(cpu))
 		return 0;
 
-	reduction_pctg(cpu) = state;
+	reduction_step(cpu) = state;
 
 	/*
 	 * Update all the CPUs in the same package because they all
@@ -113,7 +124,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 		if (!policy)
 			return -EINVAL;
 
-		max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
+		max_freq = (policy->cpuinfo.max_freq *
+			    (100 - reduction_step(i) * cpufreq_thermal_reduction_pctg)) / 100;
 
 		cpufreq_cpu_put(policy);
 
@@ -126,10 +138,29 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 	return 0;
 }
 
+static void acpi_thermal_cpufreq_config(void)
+{
+	int cpufreq_pctg = acpi_arch_thermal_cpufreq_pctg();
+
+	if (!cpufreq_pctg)
+		return;
+
+	cpufreq_thermal_reduction_pctg = cpufreq_pctg;
+
+	/*
+	 * Derive the MAX_STEP from minimum throttle percentage so that the reduction
+	 * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
+	 * the CPU performance doesn't become 0.
+	 */
+	cpufreq_thermal_max_step = (100 / cpufreq_pctg) - 2;
+}
+
 void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu;
 
+	acpi_thermal_cpufreq_config();
+
 	for_each_cpu(cpu, policy->related_cpus) {
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 		int ret;
@@ -190,7 +221,7 @@ static int acpi_processor_max_state(struct acpi_processor *pr)
 
 	/*
 	 * There exists four states according to
-	 * cpufreq_thermal_reduction_pctg. 0, 1, 2, 3
+	 * cpufreq_thermal_reduction_step. 0, 1, 2, 3
 	 */
 	max_state += cpufreq_get_max_state(pr->id);
 	if (pr->flags.throttling)
-- 
2.43.0


