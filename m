Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B997BE7A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377847AbjJIRTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377880AbjJIRTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:19:23 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D23E9;
        Mon,  9 Oct 2023 10:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieZkMki8SS5AJZcLrTGZWJ8176efaL84WeYxSVl9tWtxdlsJybzeKrbU+4QaLyy+3DYzLrmjP4M2TsirKjlsqG34ZIRm0zDNXIFF+tG26MMsxbXVN8YhTb6QG+3V+evMDnVa2F1gtNk9ckSL2LCz988EOniJqjDVEB8/HABJfht8UTTFwXeqoz0jYC48pL2zXWEqBRBjIe21Cfo6xliYaWA/fyULrs0tgunIX0vpT6rtOUUReRn4FiCOGM+P6JtKisupir4H+oOikQkmwfLb9+HJZiMohsm61c5kDAfCpC/Co+Ni3ptJMxmW+12Q8052i7eYTefo3FrHSGTkMiu0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+IxZ3/+FdjyFPqEqyBy04dvpDEj10CZthXgLZspFDE=;
 b=cr8vjRQBUXuq7i6ZVNXJhF9JLKrSEYJ0WVqyuyNBOz0Wvux8hcVu/7xB+QbYvNykzZNi67ypiPNeqZ9kpVK2OjU1EpMnnQrL8UGVka5zit5iJiBU4M7Bai19ZwDxYbBi1XkhWpRlp9dPeVR8hx6cC9diKwew5AwnL6HQUUF4k4a2GIsrFndaAA02kVD8s0H2CEsBoHj1T7KPczn9NijJDlDgd/+jTzAZzV8wF8ZURMaFVLwF7FLTFb2hit/HYBkhhtcAUjvgtk+rVIrko+yenznN/Gi5mIqNPkH3AOmYX9yZ+bQkEYPkKqkJgVSupAb+4z+l2gCvOEqGMIG5xO+5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+IxZ3/+FdjyFPqEqyBy04dvpDEj10CZthXgLZspFDE=;
 b=sb3yes+VqvzCNFaz27fj+OHNDmQx5dKz/en6MK0ymmvodNyKpOYSidgmTPSIB5WK67vjfCvSiSvWinvmEnM9BJFJKHPp1FHWTk5IcIoDEy5DGaB8yElC7qDRpdpi6uS7OVoY3Lrv+7NaZSTDe30mWgPU9kmWVcTH0qF01onYBx9VwZ1HWc3rcKUNO0hpJNDxbC8XzH61CGSr/IIEK+w8b4LGi/YKBXwwUkLiIoJ5IXYbbGHUyLcPXqz/UMaiaITffprsgrEmZwhhkLaRSBlAUqJAfpy+BdFUyXcPvn0CImbutqbISbbV4YTOM65nHzq1yRrnRGTYj8r0QXovq2INcw==
Received: from CY5PR15CA0234.namprd15.prod.outlook.com (2603:10b6:930:88::24)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 17:19:15 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::e0) by CY5PR15CA0234.outlook.office365.com
 (2603:10b6:930:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 17:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 17:19:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 10:19:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 10:19:03 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 9 Oct 2023 10:18:59 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v4 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
Date:   Mon, 9 Oct 2023 22:48:39 +0530
Message-ID: <20231009171839.12267-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231009171839.12267-1-sumitg@nvidia.com>
References: <20231009171839.12267-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd70e1a-133d-4b1d-974f-08dbc8ebdd21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1J+rwqavycv4SV8YzzfNIhbMcsjA+b42QvsQmtu2PpPJgUDNTTUJBjYd4JyN01exZJnI2oyZTi/QDAZdcmd3pcy5BTZH5kSeevbBxMDZ2pYeL4c/PYFRVJc/wOepYfOrDJlUACNwcYYSIDJYKWCem2ziY2/R1jhesMepofF/997KCJmdNMrjFxMLXoBxtsW1YVa4OKFRHOxBq+7HD/HXfivkL6oQx1j2k/bbIXMTnB7OL5sgbszTB+Wqj2d8AeHtHmdtYL9o7xZ3VAqX2gELrbA+YqQly5gBEHH0OGTY9TS+CqjQd41c693CcfKy3Q7NH4zIBn35RzQCn9czWPWYTKAQsJ7usMAelx0YmMAn9rjGzkw3nehkV9bHT7DXNVJt27tZtN+Y85SvYi8tCMjutItRFydKDcPjHt40svz8SOSGbJEfUFmIFp3u6TKUzxy3sTBRz8AEBUf0/fPC70L0pvbotRmXHDtdkUVFwgvZDRhov04CvQy4K/k4m0oyepdovv0zrkbT11iGRsXEDSK+51JIJG65y0BTO9sajcGBMw9D5y20M/nTEKl+LGkIGhYoa+MoTFIyrc/DP5gv6edIc4N/2W7FlU7SEOgOIEjlabWJeA7b5X6+3Yjie9QqKHWcLhVsiHYUVXyt1iWfGhO67rCH2NyFUkEhGYCx1MQ6qtwL9mJFE9SGp8MpbX2yswz+IKW77olGRPx5CzmiuIs402gZYbcLsgD4q6jjxKoyBcMIw4OqCKJm5C1mUjpva7DN34PJsesMqKLtCus8oCnUdg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(26005)(426003)(1076003)(336012)(2616005)(36860700001)(478600001)(7696005)(6666004)(47076005)(8676002)(107886003)(83380400001)(4326008)(2906002)(8936002)(5660300002)(54906003)(110136005)(70206006)(70586007)(41300700001)(316002)(40460700003)(7636003)(356005)(40480700001)(82740400003)(36756003)(86362001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 17:19:15.4486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd70e1a-133d-4b1d-974f-08dbc8ebdd21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/acpi/arm64/Makefile          |  1 +
 drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++++++
 drivers/acpi/processor_thermal.c     | 35 +++++++++++++++++++++++++---
 include/linux/acpi.h                 |  9 +++++++
 4 files changed, 62 insertions(+), 3 deletions(-)
 create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c

diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 143debc1ba4a..3f181d8156cc 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
 obj-y				+= dma.o init.o
+obj-$(CONFIG_ACPI)		+= thermal_cpufreq.o
diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
new file mode 100644
index 000000000000..de834fb013e7
--- /dev/null
+++ b/drivers/acpi/arm64/thermal_cpufreq.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/acpi.h>
+
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
+#define SMCCC_SOC_ID_T241      0x036b0241
+
+int acpi_thermal_cpufreq_pctg(void)
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
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index b7c6287eccca..52f316e4e260 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -26,7 +26,16 @@
  */
 
 #define CPUFREQ_THERMAL_MIN_STEP 0
-#define CPUFREQ_THERMAL_MAX_STEP 3
+
+static int cpufreq_thermal_max_step __read_mostly = 3;
+
+/*
+ * Minimum throttle percentage for processor_thermal cooling device.
+ * The processor_thermal driver uses it to calculate the percentage amount by
+ * which cpu frequency must be reduced for each cooling state. This is also used
+ * to calculate the maximum number of throttling steps or cooling states.
+ */
+static int cpufreq_thermal_pctg __read_mostly = 20;
 
 static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
 
@@ -71,7 +80,7 @@ static int cpufreq_get_max_state(unsigned int cpu)
 	if (!cpu_has_cpufreq(cpu))
 		return 0;
 
-	return CPUFREQ_THERMAL_MAX_STEP;
+	return cpufreq_thermal_max_step;
 }
 
 static int cpufreq_get_cur_state(unsigned int cpu)
@@ -113,7 +122,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 		if (!policy)
 			return -EINVAL;
 
-		max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
+		max_freq = (policy->cpuinfo.max_freq *
+			    (100 - reduction_pctg(i) * cpufreq_thermal_pctg)) / 100;
 
 		cpufreq_cpu_put(policy);
 
@@ -126,10 +136,29 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 	return 0;
 }
 
+static void acpi_thermal_cpufreq_config(void)
+{
+	int cpufreq_pctg = acpi_thermal_cpufreq_pctg();
+
+	if (!cpufreq_pctg)
+		return;
+
+	cpufreq_thermal_pctg = cpufreq_pctg;
+
+	/*
+	 * Derive the MAX_STEP from minimum throttle percentage so that the reduction
+	 * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
+	 * the CPU performance doesn't become 0.
+	 */
+	cpufreq_thermal_max_step = (100 / cpufreq_thermal_pctg) - 1;
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
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ba3f601b6e3d..052c90d7479a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1541,4 +1541,13 @@ static inline void acpi_device_notify(struct device *dev) { }
 static inline void acpi_device_notify_remove(struct device *dev) { }
 #endif
 
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
+int acpi_thermal_cpufreq_pctg(void);
+#else
+inline int acpi_thermal_cpufreq_pctg(void)
+{
+	return 0;
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.17.1

