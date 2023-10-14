Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C87C9445
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjJNKzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjJNKzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:55:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659D3CA;
        Sat, 14 Oct 2023 03:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePMhBNfWemaaFR3Ks9gsV8IXe+TSM2m8GcUtRNBjL1X50TbKjnr1CW7GBkEGk4YEnM9BWyGavG8fI2tf17JipJfUJthZNDhXJtHhr77TT/XFZBZfAaNumxISMhyUb8SCNzYPcXFTfgH6RFGikHMt+CMOqh2/r5DsswENRbkPKjpCdERdVUQgMAhsoAGeSM6X/7ClI2GNnMKDl1kQATBxkuBI5LA8MfoM2xq/jMJySgr7pCX7I/gchId5IqTy3tTIl0eV4yVlHXkaAwB+86ZdgVS5JpGSrQ+dr6nU2PqgkI2c6xKsqeh13MHwFmioJxDA8Eepg9iVmQQlipE2jfgWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSIW8U2al/DShLxcue0Fncesdmp6BLtlbjkQDzSfGLo=;
 b=aVxxIRAOPOdgQlRpYdtfW6MKRPQIkWQN4RU5Bru7bsvoxw53XsT6lnrzcCLGG2jXMjD8IsTBdOOKutQ+nTFtOxVn76OZjVDdZARjlGBm9xQ9DaRSo5FxdPR67/GKZQhRAUgyDrc5holYIWeljx5Vwhp89zOw3HB90lh9LmuY4uwaDzkUUhVTraoSfrL3/ZoRIzSJoPJp7j2o/984JbyOAuQGuCkn9KRpFMp3W7GrT/pOK6NGZjXXJL6UEL2vt+PNFOKdP2jqxn4L7lzGlLky8WW+NjDSrVBggymwfxlfDOF431teZDbTN2Cs0Lge4dx2rlSZX87JSPZHMuPteC8+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSIW8U2al/DShLxcue0Fncesdmp6BLtlbjkQDzSfGLo=;
 b=ixd1NHvWPQizdVISXA/rQ6Q/2Cyhe0AkDgbViQCJoU7V/gW53lM23A61rqCPFK//ueSILhhOHo0T4CmOK3qn8WA3ysIaUBnETRBHMWEPPukX17PnZwklsZqf43UjU6guJWy8fHjhX9fhPKxUd4zIQNPQXyVN3ev43m+ABpAEZmcTXU0Fvjt9sQEXX94Ifm341YWw5ZaBpGDSE9XXQNgUcWvZLhzktP1Qoz0grbA3jmPKcZ/vxHeeaoRfkJeefSQ9NYj5+c3KioPfMIxDGPUf553n5BeCwhKHFMUe7IDus23HovLcyuHxCJyaRkEC6r/L5FjuhewtTnIviND+fK2Tyg==
Received: from SA0PR11CA0091.namprd11.prod.outlook.com (2603:10b6:806:d1::6)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Sat, 14 Oct
 2023 10:54:57 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::73) by SA0PR11CA0091.outlook.office365.com
 (2603:10b6:806:d1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47 via Frontend
 Transport; Sat, 14 Oct 2023 10:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 10:54:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 14 Oct
 2023 03:54:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 14 Oct
 2023 03:54:51 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 14 Oct 2023 03:54:47 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v5 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
Date:   Sat, 14 Oct 2023 16:24:26 +0530
Message-ID: <20231014105426.26389-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231014105426.26389-1-sumitg@nvidia.com>
References: <20231014105426.26389-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 751b30de-297a-4937-5548-08dbcca4011d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2gWBq4INISk6zZBPLVEpxDJf03tNfgDmn9kdkCG1h9mItUNA9djw+BhKxNjlqkOI++MnckiUW5HKhxjZ+2tzpqt6oRelxgmzjhuO0gkPZmeciMz4zFQ3wEl3mNJMtCyvLyVNYxiavcZjHDdN63U9sZYOSY3rXS6apnVXiTkDOZdarKuSaHdsg8+KKbh4/7hpn9VDPsBXTdDdagLhnHlDXMVncEZWFGQwcrmRxV9g/N06xgwPRVpCneh16CdGn1mZ0qApqJOFL3prC+fssgl9tZ2fC8C1Xxd/9A8lewKk5zNE1UpQtk7K/o2f7hhWKpRGpYujWhuW4jG3wHoCz8Qu3Z1efBq5rif+RGsGf03VJ6V/9oGRAXd0/bmOn2pn/TrkndZjWOr66bY/VhqFfoR1BckxfgZDm4pVkHQlWr5ZGrxYdo5pFUfgTdglMFl4nVoFT7qjnt+K0p/+LPHTb1pPy5WCX6I0ykO+qnnDJZrGs/eLmdwTmKF9EtD1wvUsDQYy9yn3qs/6TdqbCtITHlWDMlfonIptvEwWVldkG1izv2MnVXkqQZNUuHBgyTj0pkwhgdbYq8ghCwuCReGlOW5Dv/k2VgDDgBSREoSKyQeC8XzpexrUd+vAtLNRgQ1DXka3hXaPP3A1EvE7YZjvNNTR1B9GdkRcit3l7MJiEM7sAhcKmvejlj6DuAi0aKgSPfKRVnWQbT4QSrKVbU6V28T4Ge8LBHbMh/iFrXuLntbfs82+kBeF/PzFYSaow8w/a4EG6EQBhbl0XiTLGt1oJtSkA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(40470700004)(46966006)(36840700001)(478600001)(6666004)(7696005)(83380400001)(41300700001)(107886003)(2616005)(1076003)(316002)(336012)(426003)(26005)(2906002)(54906003)(4326008)(70586007)(110136005)(5660300002)(8676002)(8936002)(70206006)(47076005)(36860700001)(356005)(36756003)(86362001)(7636003)(82740400003)(40460700003)(40480700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 10:54:56.7053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751b30de-297a-4937-5548-08dbcca4011d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
index ba3f601b6e3d..407617670221 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1541,4 +1541,13 @@ static inline void acpi_device_notify(struct device *dev) { }
 static inline void acpi_device_notify_remove(struct device *dev) { }
 #endif
 
+#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
+int acpi_thermal_cpufreq_pctg(void);
+#else
+static inline int acpi_thermal_cpufreq_pctg(void)
+{
+	return 0;
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.17.1

