Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262477F5ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbjKWMO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345222AbjKWMOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:14:54 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6C8B2;
        Thu, 23 Nov 2023 04:14:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpiUTnt3SQqQyoKiseAwm+rzJy0K4usUDLljw1jt9W+Sww9Nc0yom132lWNTgjySysFVKTrAnpgsRPn22swkpv0x51zwuGPMfK8U0hf7AAYOLQNlUbUaIBtvt6RAHhIZ47GPiFRCTZf8mpW/s5In2u8qoh7JHJqA+uEFcLeMixJ/gXv6mqFdV9QAztDqLu9qS9TCQM52ILMd+F9BG6NxtnPbizH1w66a7gNJcZKPwBkh+/SFjddzeJRPaRSie2F4Y52HqXh6GxSYBlXUaVWGvuOk5XHfdOaMLjL4o2xUP3DVx0J4qZspjrzhOZfBGGpig/mf6oDd6XSXtYStF9gS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+Bjx/GznAj44/mYZXQdXN0P5krgPusnwR776WlxgEA=;
 b=nTgWgm8CURoebpsGop43Gv81sIHz5n8bb4dKL99jPF3oHTXBmrl6lIWYP9Z0KV60BsR0Ykv/FxJMS/fM4i6ROsDUn+FJ2EDfw09BKMFX9U/n8exfIwzajJrDP21I8DcoYlWJgaV4t4huSjfBzPziq1NOrXc+lo+YIog/2Y3qevEPCS3eFpmRgZ4k0TLKEuOv5DNFLS3h4c0vSL+N1f5yR9MOscffWkD6p7FDXpRXndSBUXQRHIgzR4aBHHGFX0KPx/XAGOiUiplGgmvFw801BSKb1s8v3W0cZa5bZtSZg6ZhVgVypVqLFSoKtWzqF4XWBgDxSsIBwvgjtps8tBeGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+Bjx/GznAj44/mYZXQdXN0P5krgPusnwR776WlxgEA=;
 b=lfijEx4vwLo5vxsRmMhwBh9VKUbp7FsHpazOzGamnS80xBIbZcCi6/tdD/c3s/0MxeMFgOnk41MRBCR1WVcHKXgTVGQj5RK3y5doUN0hGZ47XLBJuDVeWFQZD+FwvpIYI7XFCXR6OwgQ5OaMCQuEZqcwZYlurHUMRl1xH34105alxuJfKoIf6PZd23BCSgTih6xcgl7gYZuNuJ3Ze8WA0rOIdwo7OBaUc/0+6iZUvF+PF/N7b9P7lnLFzYOGoy3ceo0lxyHsrqKUx/IMcrdS+mvsvUwl+FIkfibsKlOMm6FiKWwisq+mipLtrkysqW2KCvo1AZaT7vVPDkfmjKSBqQ==
Received: from CH0PR03CA0410.namprd03.prod.outlook.com (2603:10b6:610:11b::22)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 12:14:57 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::59) by CH0PR03CA0410.outlook.office365.com
 (2603:10b6:610:11b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Thu, 23 Nov 2023 12:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 12:14:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Nov
 2023 04:14:40 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Nov
 2023 04:14:40 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 23 Nov 2023 04:14:35 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <lpieralisi@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v7] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
Date:   Thu, 23 Nov 2023 17:44:33 +0530
Message-ID: <20231123121433.12089-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ba36ff-e825-4a8a-84bc-08dbec1dce8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOk3A/ewSPbCFi5pFUAowz211dZn1bvyewgnKfE15vmtjpLqlcvmSh0+nLgjz2cNNPj4ilgCh/WrKG9tTwI+4eGh2y5zEy19avIiZyBST07nV/B8NYBO0HrfjaMfDsCn3sStffekW9fuNcQYgu0USb5tmblRPKZvPDtNUQWe6B79NvaSEGOzmSC6v4k50LAIg0wzkwqVnhnAU3jlaOB6A/kT2zoQutXiufdrJMp81NvgKdFR5E/60S2G47jOqLb6H2SLlnp1KBdyeIBFQtRAmdMrffVU7tYMMlGfLHKiLXaBInrMqreAHBFa5eCcR2gmu8IFddaxmXyEILPUN9+Ff6HjLBpVS1LdMEieF+8R/kVb4fWu7BJQbFQM7Zx385YYiorKPKajeUwomHTj/hMNWxwNCsuyZDdtSC6VvetbezZI1rpbOYMcl1WPVV2X6FLzhgHlX1rmWnRYMSxIa3NcO6MehGf4DHMZe3rw0Arhe5AokpGATO3aNraQXOs6t2OuJ1T0JEJojhV82AaWF5a0wJApkSH60FLiw4yY8mosFK8Wnwm83n05hRCPLhm50LONgNkpbyrKaQ4xctuzvkqqoU5VidTlcrhOjDB7I0N2TB8jrjxE/HxTGiyTHW3NHOaw7ygZ/psmqZT4PkCZdvW0B/wyXY2vDYMBBdIBG4ISrdfaWSykWROc5IGLrT75SDSdXDJegQraj6OCBFMfzdNvggYgUmcxSaBSOVZhGIVlUXJ0uM4aQa2Trfziqdg+ZQfROjMexf6BTSVVYYf2ZahhZFtlp4ooA2EFxsCFre3AMYcvv2khoJIXQrNn75TQgt0MUrHTUIZ8Quw/E3FLYIhZUw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(110136005)(316002)(54906003)(70206006)(70586007)(7696005)(36756003)(336012)(426003)(26005)(1076003)(2616005)(107886003)(478600001)(921008)(7636003)(82740400003)(356005)(36860700001)(83380400001)(86362001)(47076005)(966005)(2906002)(7416002)(5660300002)(40480700001)(8676002)(8936002)(41300700001)(4326008)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 12:14:56.4704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ba36ff-e825-4a8a-84bc-08dbec1dce8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Sending this patch separately as the other patch in the series is
applied by Rafael in v6[1]. Revision history before this version is
in the cover letter of v6[1].

Please review and provide ACK if looks fine.

v6[6] -> 7:
- Patch 2: remove CONFIG_HAVE_ARM_SMCCC_DISCOVERY ifdef check [Sudeep].
         : replace SMCC macro with CONFIG_ARM64 in internal.h [Sudeep].

[1] https://lore.kernel.org/lkml/20231109183322.28039-1-sumitg@nvidia.com/

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
index 8cd2d15dec11..bcef1ce1aed9 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -90,6 +90,15 @@ int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp);
 int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp);
 int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 
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
2.17.1

