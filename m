Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF07E7194
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345027AbjKISeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345024AbjKISeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:34:16 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40423C0E;
        Thu,  9 Nov 2023 10:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+65YvdJLD3qUQHZytCZJm2rB7bEmUz1ie37xy1LZYbaTvtV+hykfOQ7dHlhB53HX9lP/ryJnGDvoylHSikxrgQ34MBZ45ENTKKTSg0hyxHgNQaXuDGb9hhtYzfavZfw3dO8Nn5UWJgPd5VtkQKGH6nqltqy9gE0ffCG0CtkW7NgWFqzzKb2/SYQzX2JPIIkukPxkSwSDI8ZOFFYiRS0ujsivW2E3hikcux/WtGs6xlhki39Zb70mGtdShmefy0sd7ZZ5oNIfGqGDw1VHJoexY5muesEVWQtFzRIZRmcu9VpzcOLJqG/1cEkYKaALnXSn5jrv9cdfcxQ7THz7IQowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etdtFIyOVk+QHMyELQC4r6hMLBXvOLwaMROE9c6y4b0=;
 b=Qw3IDh2ioZ/fkdOOXaFSdb0AdYlSrDWZ/dcvfCqabECnEsaONH5pcoMOcJ3XacOmlSiqWLWWMGKkU8uVV6EsVmrmlnmZjvkrQbTddjCsHDGvtWGVxL9ElLAauU8RsDkG4+LOEGvVxWRzrPMtC68z0Vf21vWB0ySR04NwPPANx5CUG57sRmIzJ4HNYr/nQ2i99iVXzM6zbY2jS0+1gyASjsr9fJfl9KZn5+NtdKGF5MGKupcdp/YY++usDefCPTEMO08dhXWefrbBkSViqyCQ1tyMBQtJNcLGnF+Ws/Gvnszs2Ir0bczQvDzBQ8F1KoVzorZBW5kuPJZA0yoDl3yCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etdtFIyOVk+QHMyELQC4r6hMLBXvOLwaMROE9c6y4b0=;
 b=aUIw9kGgggIO3AebQVqQnimVq5xcioktROPa+7AozbsyHDRPSiVR3X2XfrFgViJZZpvz9vO3Zg7OwGH8oU1xrrGjX1JKQfhvOvFPNIXm0Yyq2QYdA7LptUbFnJBwVSIZ7eeGVljX95tU02i85KB0HNgVpml6pP8DivkyKQNZnyoAnEKDHtJeVIZwGjIPI1huiJyTFA5qrMx4uFm6Q+fipg+vvgyPyrPSMoUzrIMB949h6Z32gOdhjKGd+DpCcO9tT7VK9PjENRO/TE/4SpJh4MjO7JoAz7Ti4Ax2/KCrYkkro53OElDHAn8fRqcLtxCAGPwUYTwh4NCi0VGi3yaU6w==
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Thu, 9 Nov
 2023 18:34:10 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::7e) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 18:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 18:34:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Nov 2023
 10:33:53 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Nov 2023
 10:33:53 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 9 Nov 2023 10:33:48 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <lpieralisi@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v6 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
Date:   Fri, 10 Nov 2023 00:03:22 +0530
Message-ID: <20231109183322.28039-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109183322.28039-1-sumitg@nvidia.com>
References: <20231109183322.28039-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: f39ea2ad-bfe0-42fd-777c-08dbe1527728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9P570LFQBf3PeDIKGJpl+vPJ8LhpTEvbgZtlEVjU7r50bq2PNwGC2Kw4YPgX9Gu1BpvP5/eZK9sE1evdRprQy1uFOMtbtztI5xOq8CxIPFVuMs2tSoLzlSn71sOXtU3mULN+qRGfv8jSxZVYaI75Wt4C2xoN/pwXWkCUMBAyDfe/bs/V+1bsMCzeObwYnNm+URiofC/ozdVIBGbS42UIqjoOOiHnuPDGJKgXQ2aWdm+TLE316fz49z1rd8ay369kD2fcm3qHAlOHlNuxaZI/Wnst9vFzLTyxhE5NGinSDHHKibI7RB+l/y31ODNBpno+/gX/RbLpNxLXhKMXq5XKo5HOlrocESHImtP5SD8GkqmBvsIBUbbjfmdsRdOsjnt4bvWObSux7Mxcw+j5cgbykIk62GAaegfSiCxKHrxqReT0FtuQYHOdt2sy2UzDk6EnVUxspaB0o17m7bdg8N6zo6VnL6UFgTKASPzd29TP0OPPYJ1hiRtQt8QtUZN7k+ATS0C3DsuBMusW6CClM1EHZetE7IfWCnRTaeFJAIYYdDS+pDRIC6zdMOJLCgScBfz1KfQzOKJOKRdCnC4uE5r5jv/0SwGOI3Ujr0zPYZHnuySasLDadnHtIBanKYivPhzvqefvVu8MJBQCgUrlIXMivxrBQd2N0v9UHMvabxSbbURk7v/HfR5QKv9HCUfMRE9tSetYPOQMmtIj6xWyq6p5aLM6jbF5DDdF8ExBCcpaJsJc8MuDe/xRAK11AnCYUVAj/b3rgHxqFXLc/X3fH8XYsdfWcFytGwqpflnSHLDYcLBf+ktvvQZS1XWxEFrum80
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(478600001)(41300700001)(47076005)(7696005)(7416002)(6666004)(5660300002)(8676002)(426003)(336012)(4326008)(8936002)(83380400001)(36860700001)(2906002)(26005)(2616005)(316002)(1076003)(70206006)(70586007)(54906003)(110136005)(86362001)(107886003)(7636003)(82740400003)(356005)(36756003)(921008)(40480700001)(40460700003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 18:34:10.4203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f39ea2ad-bfe0-42fd-777c-08dbe1527728
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikar Srimath Tirumala <srikars@nvidia.com>

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
---
 drivers/acpi/arm64/Makefile          |  1 +
 drivers/acpi/arm64/thermal_cpufreq.c | 22 +++++++++++++
 drivers/acpi/internal.h              |  9 +++++
 drivers/acpi/processor_thermal.c     | 49 +++++++++++++++++++++++-----
 4 files changed, 72 insertions(+), 9 deletions(-)
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
index 000000000000..40d5806ed528
--- /dev/null
+++ b/drivers/acpi/arm64/thermal_cpufreq.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/acpi.h>
+
+#include "../internal.h"
+
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
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
+#endif
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 866c7c4ed233..ee213a8cddc5 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -85,6 +85,15 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
 void acpi_scan_table_notify(void);
 
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
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
2.17.1

