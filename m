Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E996C78362C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjHUXQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjHUXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:16:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E258B130;
        Mon, 21 Aug 2023 16:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGNgSoNXdxjz/KBK+DKIKECzFLBTebaazG/QDSlPvq6mCRnovATEp0OIaelZNQd02N4kx0w7HaI4GeHJc8l5DbVEYDMkJF3Ha75ooPpF4WMDwFWUxlwbHkdXdVA6Dx3cqiU4+YOMXUWlBxRMhiuFhy9NRWNU4PUegGQI8s9zgLUGai3NIwC9e/CkFVU8tlM9ZQwOVIXeDaL9Vriqa3U9HmRz7zxPdyInbEXzpc3C3mZlHtLLE9mpoQAi8eeO++HXTdHwRl7Hp7rArjDhKJu1m5B/TTDM6wOvTfOMkO4ZvVAykT/LqwTlqZfQw3G1rW04tgbVQNopx5aixfzi3JcCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8zaN2OzO62pHoB9RJ9UQ7t+qDIG1Js7xZnYrkLq/UE=;
 b=iqZhOWMcZd40xPMcl/hUPcM0BIGhqoC6lQyvSzaG/8BGnLVr3727UbbswgYnEp3VB3azkIiurrmYVleJfY0iEXifBVpu0eExcC3B7V8yKtvwaDmhXOzwKGciJ0Fbymai6HahRtkcee1tajX2V4SnSqtFzXmjYv96K1N4eP34FLPDaCXlYpHtU91KfGb6UUysr61swEQJioAajaMcy9dObHy/etErJn+4OOfiPMRqZf/l7rY+/h3jsPI2fX9iabjDZtQWZkamBOX49VT6iTapRrtpSVC0aiP8Rbs5I9q2Pk5MwCeZAhuzyxzCWu1zzYhKKuDSPMfE7nVSYMcG0Hfczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8zaN2OzO62pHoB9RJ9UQ7t+qDIG1Js7xZnYrkLq/UE=;
 b=o0LgxekauNHtvswU5AUXIDipRlGCJFVC0hvKkkHTkpT5B3SpAY3QJ0jDkvLnaRjSDO9HdyRhgppdATkqIU0pkFTJu1VkxNTPv5bozc1lwWoaTVn7tN35OtEt0tC0+qmuH/4Ofoj58dUY0TNBT8f+JmRyu6JUqNHfoAGFAtJBYZ8S1/XIXR0J+JYqLG5d0QZ/mXmTQ2JHeylp7VUG+j2/rNwjlyUPD35sGuVKHcm5y6M4ILmZZ4JNLTAkXAqSCYw06m3XR/Mo/HjW7UBQ0dCJc3aRPN/akT6PAdgUORBVQkzO/kpxfzeNaH/Zs/MvyKfV1ueK15faT3ofn8Bp/J4IPw==
Received: from MW4PR04CA0145.namprd04.prod.outlook.com (2603:10b6:303:84::30)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 23:16:35 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::9e) by MW4PR04CA0145.outlook.office365.com
 (2603:10b6:303:84::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 23:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.2 via Frontend Transport; Mon, 21 Aug 2023 23:16:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 16:16:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 21 Aug 2023 16:16:27 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 21 Aug 2023 16:16:26 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
        <ilkka@os.amperecomputing.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <rwiley@nvidia.com>, <efunsten@nvidia.com>,
        "Besar Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH v6] perf: arm_cspmu: Separate Arm and vendor module
Date:   Mon, 21 Aug 2023 18:16:08 -0500
Message-ID: <20230821231608.50911-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0f2cbb-cd71-497f-5550-08dba29ca9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z73a2EcYOo73Pw/qcB/pVQXEAp4hJhVavrYB+grjXrCUjldwjH8CO7k4wExfYvq4lsgHC8JTIW0NUQZvmiVkS5u0Dr4dCqTml7K1SeN3pwmj2szQMqoUQs71IcZFz8lLu0TA2bSVNvrCay3GPgCQoH8y/mtLAKzBj73x0rguSxeIk5ClhgG/HUcOLO6Jxm718OH/V3Pbyr9UGXUzT4Vj/jn1v2/TugDbj+GmhIElBKzZoUAGZulNGsRNizexneWvxl/wqYpwFcwgBvvn26F/Oz9QVar4UjujxY5oN49UV36wkDqWvPDvt0mTTH+UgIa9gF0mDEzWHafCKpfYhaFKZTDwYnevP4MgVQdLp1LWFzpfdid+TjaPCIz3ZuQx2E0SRZ9CzAPzCPBL5znZ6uVaJzOs0AqDHGAQw6HZ0cXeofA6kW3YliSSRImB1on28nnDVYTWSGSqBByHUUsxSnOafETEsAlFf5mjB5JcInHorYxc3YlkudP88aaqjRSnRJ1ec+G5Fueq/bvlkMAjFxDdGgFkoQPIcKb3QUU8yop9O3/TFhTKAy1LNvkx3OIINt4uOOIofZir9MEkjyoF97b5DLmTxcQMnwKZposCn52wTS7tAjwG0bYHSYOtbbadVEeXHbQ5ZUlim1+/py2jvhWdsChAY2W6RKE2TJ2O2agQIy9iK+yfO7EuWEoKiGBT++VmRcNQEjOzex9Njc2G/Q/QSQ3aEJOV6Wdg5OfBEup6caXCu1WXEjNch1forfEDZhrNAe9OhqMcWyevp78PHt5zD5HtK2gggCh4Mp4p5CdE5Tc=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(186009)(451199024)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(966005)(86362001)(36756003)(478600001)(107886003)(40480700001)(2616005)(5660300002)(4326008)(47076005)(8936002)(8676002)(36860700001)(426003)(1076003)(26005)(336012)(83380400001)(2906002)(30864003)(70586007)(70206006)(110136005)(54906003)(40460700003)(6666004)(7636003)(316002)(356005)(82740400003)(41300700001)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:16:35.1121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0f2cbb-cd71-497f-5550-08dba29ca9e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Coresight PMU driver consists of main standard code and
vendor backend code. Both are currently built as a single module.
This patch adds vendor registration API to separate the two to
keep things modular. The main driver requests each known backend
module during initialization and defer device binding process.
The backend module then registers an init callback to the main
driver and continue the device driver binding process.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---

Changes from v5:
 * Incorporate review comments.
 * Fix arm_cspmu_impl_match_get not returning NULL if no matching impl.
 * Fix impl_match.module may reset when registering PMU.
 * Maintain backend module ref count until PMU registration is done.
Thanks to Will, Suzuki, and Robin for the feedback.
v5: https://lore.kernel.org/linux-arm-kernel/20230705104745.52255-1-bwicaksono@nvidia.com/T/#u

Changes from v4:
 * Fix warning reported by kernel test robot
v4: https://lore.kernel.org/linux-arm-kernel/20230620041438.32514-1-bwicaksono@nvidia.com/T/#u

Changes from v3:
 * Move impl registration module back to main driver module.
 * Rebase from will (for-next/perf)
Thanks to Robin for the feedback.
v3: https://lore.kernel.org/linux-arm-kernel/20230505005956.22837-1-bwicaksono@nvidia.com/T/#u

Changes from v2:
 * Move sysfs_event/format_show definition to arm_cspmu.h and move impl
   registration API definition to a separate module so main driver and vendor
   module are independent.
 * The registration API now just sets the impl_init_ops callback, no reprobe.
 * Add PMIIDR table that maps to the vendor module name. During device probe,
   main driver requests the vendor module if PMIIDR is matching.
 * Keeping the name of the main driver module as arm_cspmu_module.
Thanks to Robin and Suzuki for the feedback.
v2:  https://lore.kernel.org/linux-arm-kernel/20230418062030.45620-1-bwicaksono@nvidia.com/T/#u

Changes from v1:
 * Added separate Kconfig entry for nvidia backend
 * Added lock to protect accesses to the lists
 * Added support for matching subset devices from a vendor
 * Added state tracking to avoid reprobe when a device is in use
Thanks to Suzuki for the feedback.
v1: https://lore.kernel.org/linux-arm-kernel/20230403163905.20354-1-bwicaksono@nvidia.com/T/#u

---
 drivers/perf/arm_cspmu/Kconfig        |   9 +-
 drivers/perf/arm_cspmu/Makefile       |   6 +-
 drivers/perf/arm_cspmu/arm_cspmu.c    | 168 ++++++++++++++++++++------
 drivers/perf/arm_cspmu/arm_cspmu.h    |  25 +++-
 drivers/perf/arm_cspmu/nvidia_cspmu.c |  34 +++++-
 drivers/perf/arm_cspmu/nvidia_cspmu.h |  17 ---
 6 files changed, 199 insertions(+), 60 deletions(-)
 delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h

diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index 25d25ded0983..d5f787d22234 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 	tristate "ARM Coresight Architecture PMU"
@@ -10,3 +10,10 @@ config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 	  based on ARM CoreSight PMU architecture. Note that this PMU
 	  architecture does not have relationship with the ARM CoreSight
 	  Self-Hosted Tracing.
+
+config NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU
+	tristate "NVIDIA Coresight Architecture PMU"
+	depends on ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
+	help
+	  Provides NVIDIA specific attributes for performance monitoring unit
+	  (PMU) devices based on ARM CoreSight PMU architecture.
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index fedb17df982d..0309d2ff264a 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -1,6 +1,8 @@
-# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 #
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
-arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
+arm_cspmu_module-y := arm_cspmu.o
+
+obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index e2b7827c4563..c59f1e5a35a3 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -16,7 +16,7 @@
  * The user should refer to the vendor technical documentation to get details
  * about the supported events.
  *
- * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  *
  */
 
@@ -26,11 +26,11 @@
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 
 #include "arm_cspmu.h"
-#include "nvidia_cspmu.h"
 
 #define PMUNAME "arm_cspmu"
 #define DRVNAME "arm-cs-arch-pmu"
@@ -112,11 +112,10 @@
  */
 #define HILOHI_MAX_POLL	1000
 
-/* JEDEC-assigned JEP106 identification code */
-#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
-
 static unsigned long arm_cspmu_cpuhp_state;
 
+static DEFINE_MUTEX(arm_cspmu_lock);
+
 static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
 {
 	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
@@ -373,27 +372,37 @@ static struct attribute_group arm_cspmu_cpumask_attr_group = {
 	.attrs = arm_cspmu_cpumask_attrs,
 };
 
-struct impl_match {
-	u32 pmiidr;
-	u32 mask;
-	int (*impl_init_ops)(struct arm_cspmu *cspmu);
-};
-
-static const struct impl_match impl_match[] = {
+static struct arm_cspmu_impl_match impl_match[] = {
 	{
-	  .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
-	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
-	  .impl_init_ops = nv_cspmu_init_ops
+		.module_name	= "nvidia_cspmu",
+		.pmiidr_val	= ARM_CSPMU_IMPL_ID_NVIDIA,
+		.pmiidr_mask	= ARM_CSPMU_PMIIDR_IMPLEMENTER,
+		.module		= NULL,
+		.impl_init_ops	= NULL,
 	},
-	{}
+	{0}
 };
 
+static struct arm_cspmu_impl_match *arm_cspmu_impl_match_get(u32 pmiidr)
+{
+	struct arm_cspmu_impl_match *match = impl_match;
+
+	for (; match->pmiidr_val; match++) {
+		u32 mask = match->pmiidr_mask;
+
+		if ((match->pmiidr_val & mask) == (pmiidr & mask))
+			return match;
+	}
+
+	return NULL;
+}
+
 static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 {
-	int ret;
+	int ret = 0;
 	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
 	struct acpi_apmt_node *apmt_node = arm_cspmu_apmt_node(cspmu->dev);
-	const struct impl_match *match = impl_match;
+	struct arm_cspmu_impl_match *match;
 
 	/*
 	 * Get PMU implementer and product id from APMT node.
@@ -405,17 +414,36 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 				       readl(cspmu->base0 + PMIIDR);
 
 	/* Find implementer specific attribute ops. */
-	for (; match->pmiidr; match++) {
-		const u32 mask = match->mask;
+	match = arm_cspmu_impl_match_get(cspmu->impl.pmiidr);
+
+	/* Load implementer module and initialize the callbacks. */
+	if (match) {
+		mutex_lock(&arm_cspmu_lock);
+
+		if (match->impl_init_ops) {
+			/* Prevent unload until PMU registration is done. */
+			if (try_module_get(match->module)) {
+				cspmu->impl.module = match->module;
+				cspmu->impl.match = match;
+				ret = match->impl_init_ops(cspmu);
+				if (ret)
+					module_put(match->module);
+			} else {
+				WARN(1, "arm_cspmu failed to get module: %s\n",
+					match->module_name);
+				ret = -EINVAL;
+			}
+		} else {
+			request_module_nowait(match->module_name);
+			ret = -EPROBE_DEFER;
+		}
 
-		if ((match->pmiidr & mask) == (cspmu->impl.pmiidr & mask)) {
-			ret = match->impl_init_ops(cspmu);
-			if (ret)
-				return ret;
+		mutex_unlock(&arm_cspmu_lock);
 
-			break;
-		}
-	}
+		if (ret)
+			return ret;
+	} else
+		cspmu->impl.module = THIS_MODULE;
 
 	/* Use default callbacks if implementer doesn't provide one. */
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_event_attrs);
@@ -478,11 +506,6 @@ arm_cspmu_alloc_attr_group(struct arm_cspmu *cspmu)
 	struct attribute_group **attr_groups = NULL;
 	struct device *dev = cspmu->dev;
 	const struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
-	int ret;
-
-	ret = arm_cspmu_init_impl_ops(cspmu);
-	if (ret)
-		return NULL;
 
 	cspmu->identifier = impl_ops->get_identifier(cspmu);
 	cspmu->name = impl_ops->get_name(cspmu);
@@ -1149,7 +1172,7 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 
 	cspmu->pmu = (struct pmu){
 		.task_ctx_nr	= perf_invalid_context,
-		.module		= THIS_MODULE,
+		.module		= cspmu->impl.module,
 		.pmu_enable	= arm_cspmu_enable,
 		.pmu_disable	= arm_cspmu_disable,
 		.event_init	= arm_cspmu_event_init,
@@ -1196,11 +1219,17 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = arm_cspmu_register_pmu(cspmu);
+	ret = arm_cspmu_init_impl_ops(cspmu);
 	if (ret)
 		return ret;
 
-	return 0;
+	ret = arm_cspmu_register_pmu(cspmu);
+
+	/* Matches arm_cspmu_init_impl_ops() above. */
+	if (cspmu->impl.module != THIS_MODULE)
+		module_put(cspmu->impl.module);
+
+	return ret;
 }
 
 static int arm_cspmu_device_remove(struct platform_device *pdev)
@@ -1300,6 +1329,75 @@ static void __exit arm_cspmu_exit(void)
 	cpuhp_remove_multi_state(arm_cspmu_cpuhp_state);
 }
 
+int arm_cspmu_impl_register(const struct arm_cspmu_impl_match *impl_match)
+{
+	struct arm_cspmu_impl_match *match;
+	int ret = 0;
+
+	match = arm_cspmu_impl_match_get(impl_match->pmiidr_val);
+
+	if (match) {
+		mutex_lock(&arm_cspmu_lock);
+
+		if (!match->impl_init_ops) {
+			match->module = impl_match->module;
+			match->impl_init_ops = impl_match->impl_init_ops;
+		} else {
+			/* Broken match table may contain non-unique entries */
+			WARN(1, "arm_cspmu backend already registered for module: %s, pmiidr: 0x%x, mask: 0x%x\n",
+				match->module_name,
+				match->pmiidr_val,
+				match->pmiidr_mask);
+
+			ret = -EINVAL;
+		}
+
+		mutex_unlock(&arm_cspmu_lock);
+
+		if (!ret)
+			ret = driver_attach(&arm_cspmu_driver.driver);
+	} else {
+		pr_err("arm_cspmu reg failed, unable to find a match for pmiidr: 0x%x\n",
+			impl_match->pmiidr_val);
+
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_impl_register);
+
+static int arm_cspmu_match_device(struct device *dev, const void *match)
+{
+	struct arm_cspmu *cspmu = platform_get_drvdata(to_platform_device(dev));
+
+	return (cspmu && cspmu->impl.match == match) ? 1 : 0;
+}
+
+void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match)
+{
+	struct device *dev;
+	struct arm_cspmu_impl_match *match;
+
+	match = arm_cspmu_impl_match_get(impl_match->pmiidr_val);
+
+	if (WARN_ON(!match))
+		return;
+
+	/* Unbind the driver from all matching backend devices. */
+	while ((dev = driver_find_device(&arm_cspmu_driver.driver, NULL,
+			match, arm_cspmu_match_device)))
+		device_release_driver(dev);
+
+	mutex_lock(&arm_cspmu_lock);
+
+	match->module = NULL;
+	match->impl_init_ops = NULL;
+
+	mutex_unlock(&arm_cspmu_lock);
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
+
 module_init(arm_cspmu_init);
 module_exit(arm_cspmu_exit);
 
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 83df53d1c132..7936a90ded7f 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
  * ARM CoreSight Architecture PMU driver.
- * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  *
  */
 
@@ -69,6 +69,9 @@
 #define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
 #define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
 
+/* JEDEC-assigned JEP106 identification code */
+#define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
+
 struct arm_cspmu;
 
 /* This tracks the events assigned to each counter in the PMU. */
@@ -106,9 +109,23 @@ struct arm_cspmu_impl_ops {
 					 struct attribute *attr, int unused);
 };
 
+/* Vendor/implementer registration parameter. */
+struct arm_cspmu_impl_match {
+	/* Backend module. */
+	struct module *module;
+	const char *module_name;
+	/* PMIIDR value/mask. */
+	u32 pmiidr_val;
+	u32 pmiidr_mask;
+	/* Callback to vendor backend to init arm_cspmu_impl::ops. */
+	int (*impl_init_ops)(struct arm_cspmu *cspmu);
+};
+
 /* Vendor/implementer descriptor. */
 struct arm_cspmu_impl {
 	u32 pmiidr;
+	struct module *module;
+	struct arm_cspmu_impl_match *match;
 	struct arm_cspmu_impl_ops ops;
 	void *ctx;
 };
@@ -147,4 +164,10 @@ ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf);
 
+/* Register vendor backend. */
+int arm_cspmu_impl_register(const struct arm_cspmu_impl_match *impl_match);
+
+/* Unregister vendor backend. */
+void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match);
+
 #endif /* __ARM_CSPMU_H__ */
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index 72ef80caa3c8..0382b702f092 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -1,14 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  *
  */
 
 /* Support for NVIDIA specific attributes. */
 
+#include <linux/module.h>
 #include <linux/topology.h>
 
-#include "nvidia_cspmu.h"
+#include "arm_cspmu.h"
 
 #define NV_PCIE_PORT_COUNT           10ULL
 #define NV_PCIE_FILTER_ID_MASK       GENMASK_ULL(NV_PCIE_PORT_COUNT - 1, 0)
@@ -351,7 +352,7 @@ static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
 	return name;
 }
 
-int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
+static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
 {
 	u32 prodid;
 	struct nv_cspmu_ctx *ctx;
@@ -395,6 +396,31 @@ int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
+
+/* Match all NVIDIA Coresight PMU devices */
+static const struct arm_cspmu_impl_match nv_cspmu_param = {
+	.pmiidr_val	= ARM_CSPMU_IMPL_ID_NVIDIA,
+	.module		= THIS_MODULE,
+	.impl_init_ops	= nv_cspmu_init_ops
+};
+
+static int __init nvidia_cspmu_init(void)
+{
+	int ret;
+
+	ret = arm_cspmu_impl_register(&nv_cspmu_param);
+	if (ret)
+		pr_err("nvidia_cspmu backend registration error: %d\n", ret);
+
+	return ret;
+}
+
+static void __exit nvidia_cspmu_exit(void)
+{
+	arm_cspmu_impl_unregister(&nv_cspmu_param);
+}
+
+module_init(nvidia_cspmu_init);
+module_exit(nvidia_cspmu_exit);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.h b/drivers/perf/arm_cspmu/nvidia_cspmu.h
deleted file mode 100644
index 71e18f0dc50b..000000000000
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
- *
- */
-
-/* Support for NVIDIA specific attributes. */
-
-#ifndef __NVIDIA_CSPMU_H__
-#define __NVIDIA_CSPMU_H__
-
-#include "arm_cspmu.h"
-
-/* Allocate NVIDIA descriptor. */
-int nv_cspmu_init_ops(struct arm_cspmu *cspmu);
-
-#endif /* __NVIDIA_CSPMU_H__ */

base-commit: ea8d1c062a0e876e999e4f347daeb598d5e677ab
-- 
2.17.1

