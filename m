Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD78D79F5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjIMXl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjIMXlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:41:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2102.outbound.protection.outlook.com [40.107.223.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236FD10C3;
        Wed, 13 Sep 2023 16:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCc7pM4g2Q2dW3MjEOdvbj1WnScBY6tu7irbE04A8Yvuu0AGwEtSp6hwsf2BVzyzLOmIPZ5MlxdMgOJCO2yl8QF4kuvhdqydPBtouBZUkq/xZ1fzOUdRZNADD0nG0dzayBctH5yapf7XieeJBWwqvmvVPLqureAC7LE4HqjS0PE6sFxWkCwPqJFW+JaUUIFIgLHC1vPYhNZRwkPz9x8jJibFuGunjwVmEipBxqq2HEqmCo8Ktn7us+yXArJAsE5e0rixytxiQ4HceiC+JlNz005qDXArPbSyfklnEr5eb+Sl8N/Bp5vsDvgvtRuHCHjiyEDqgKkAxYmzow+B2rjTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr2hAVYAfczEQ9flj6cyX5xctyinyV8zWgmA6aK30FE=;
 b=jJbf/SV5IGqdTWMK7omxiNPzQ+/ayWDIgpD/cB1YZZpIRr4qw2fWRdHEfyBOVyE4QpeBl8YrqYo9L+D/dt1NuaLJiQx/Hi2TZv0TsLWemGsY0h1d8leihkjBQ1ID+YFs97CWAnbjlBi88zqPm2Stfqedenuhi5MnnYNnlTI8ZvFaM3hZUYc3PqUT/NmlPEvCbLGBphhOic5P8dDM0fH24jL24MS3di79uomlNxBdJ7C5YT40MsVU3q3nehr1MBGZSiNHY38TGZsHPdzXp+FBBMBrTWjWY/utVyWIKFnCicVLSjYDK/KG3FDZNJO1uq4spvKNoyehBUg7iwynSgCccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr2hAVYAfczEQ9flj6cyX5xctyinyV8zWgmA6aK30FE=;
 b=NI9vMi++j53IxDFqT/2F0EJM1Wwg0pAWvGvI/cq6FiY/KhVCNWVGK21DFpXmw6Xs6lknp85ndDYq5Usghcl0L1B+JbW7KIL/gGdF3f6yp4AYou7Ug1hKVVwk6GyMQRHY97blfkyCP6pFytBVrD0oJ8KlV934S6rlI5vLJ3Og2L4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 MW4PR01MB6241.prod.exchangelabs.com (2603:10b6:303:64::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Wed, 13 Sep 2023 23:41:12 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 23:41:12 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v7 4/4] perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU
Date:   Wed, 13 Sep 2023 16:39:41 -0700
Message-Id: <20230913233941.9814-5-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913233941.9814-1-ilkka@os.amperecomputing.com>
References: <20230913233941.9814-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0040.namprd18.prod.outlook.com
 (2603:10b6:610:55::20) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|MW4PR01MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a426b49-e515-4145-c8be-08dbb4b2e99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RATTDo++RE6lNJRP9ilYH9k2rubkSrjTLYwKztpiLnJW4vOMQ4pFTcGHgBDjZ0/wqJ/TU0WZDjJVFVAVqr9y7FkH1xBngsLiHdddRHwjFJ8ou0tFKT6cqY59kKjUgHuyfbvKXt91ARNDhKa32lmcLD1oyhb0xTIC2y0XdxiuUUvqwo8rTT3XBhLAdSlFGEaQD9+i3EUI0CA4mMkUIidng2wOsNhBvDHClqdTYEbwVjl9eLOZ+FUOjE5AoV6DJbr7AMM+TLl5dupUBcrbBgBfM5MmSY3B6H33pnB/Sqhl5Udab0SyiXl5JxTpAZl8WCTrcb1HZ915Ny1bzc5doFeGBwUl7AxqLEs38XMF0gJ8HCFd+T9iTfFqaskwV5kLPATfiLdmnoEJc2VkELHwNGMalYQn9FjaKzWRJqDuHygSHPhIu/CpsBo2DVnE1CucKNXx0ITrdI1bwE5mmBKgJghsXqSEVgAaz9Yvg3WbhtqY67Lapz6sDagFdt6gGF9w2UXlXzx8au3nk5bCSKC24zFO2jNsjiI0fQi/wiupK1cdI9y+m+Y+rvoPL6ej++pEVASZIBDR06owrxp8bXqG7ZulFoxzgvT2wNoSUdo7+EKvwGW+TgKe7awFkBt+ogKE4+aK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39850400004)(136003)(376002)(1800799009)(451199024)(186009)(7049001)(52116002)(6486002)(6512007)(6506007)(6666004)(478600001)(38100700002)(38350700002)(2906002)(2616005)(1076003)(7416002)(316002)(83380400001)(26005)(86362001)(66946007)(66476007)(66556008)(30864003)(110136005)(41300700001)(8936002)(4326008)(5660300002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G1HFV0WzWjqj64sZk9Q17B4ocmS2h62WdD2nnieS+PpUKLNf+fJoWz+nIxJc?=
 =?us-ascii?Q?bNZMbMOqLrtGalb42frZ7V07jF6qnGAvw+62kEeYIpb93yC7fEKulMe/W37j?=
 =?us-ascii?Q?X3w8I/zn2bcbmjXcZIHaWtiMj/XcIOz3lCWtYaQg7i0tQ+WCbOJMHKj6pC/V?=
 =?us-ascii?Q?zDZ++oxFUVxiXTHewKcttkMZmAad8zHLpEmyPG98OWHk6Rvlxii/tXyvcutt?=
 =?us-ascii?Q?si0R7XCWoh5s1c2bbk97OstZJTqRjX51e1AXcQFUy7O9uCfByfOxr7v1KV52?=
 =?us-ascii?Q?V7HM29/IY3fcYstvIgKoOmRkXTJWD3+FjH0inqstIxs9sVRHAs5x5WR7YGVA?=
 =?us-ascii?Q?dGaff50VIsXb0T72jaS4I6bE2+NCSZ9li0vpu9uq2IyGRvxVwCHl7/2cqmfl?=
 =?us-ascii?Q?3D8NGSM0fCQJiI/Sa30P+TeS1lmnZPRz3QXnN7/+yLBlm7ktAC9FErrrx2lh?=
 =?us-ascii?Q?bTmke/S+Jn57ENsqnYZE75isOk5YcrBzzGAaF8QPugGMc7tWwzZV7P9TbRHR?=
 =?us-ascii?Q?pVv/NNFaWQlrSPyK1wsZRBIzUwu63zbvRb/RlZOVjQgiZL0MPNbUIWStNQqP?=
 =?us-ascii?Q?AOXZSkoD7THOQFdcKvDXCdPGeg88ls1wAiNvXntxOrqRUNNFa7NCEGfT/+5j?=
 =?us-ascii?Q?s+ZDdY1sGck7hYdc/nhkp78zNST87AF9B1rsQOeBdt/YtUHcALoVQXdZc8zQ?=
 =?us-ascii?Q?ajSM80v5/Eea1XnfVuLhPHq5OgMGYLfI9BcnjO49pvXsfVYw4TbXQA0rz3XK?=
 =?us-ascii?Q?1YphbxbXqvXH4+0V+oocjH8/uWLTpNZY14IOyRL/syBaVVy0nZVKBd7OF8NX?=
 =?us-ascii?Q?F/vt1f4yCWz+Ybap7t1PueVlOTzvr7JUronUU1jQsJMcbYBm/BXOdKTqQf16?=
 =?us-ascii?Q?oI7w/0FIhr/eAotXzNQvLjf84egS6JA7QC8RZIz81s3bpmdOtQcQFIZzctMN?=
 =?us-ascii?Q?VS7HZodQkpG+sZ9/KexLC/jrxrewMRR3XEUlJvebVMZLJogV5TKW3W9dl+Ms?=
 =?us-ascii?Q?LO20K5iZFR81yU7Z7V9PoihXjcw+lOvV0t0C2Q2bc3+0xHOHR8fXO3yWKNh9?=
 =?us-ascii?Q?BR7cKyYFa4snwbYIPcdkZR4f3oUsCo8jzwiK8MpBA0sZYiYvxTRgzMq3fm9Z?=
 =?us-ascii?Q?PHouB/+1p0F/Jkn3ksWzPSqCnpDW+O0r0U1SLz/ieBOwBuIHBx4JWW8tY0F0?=
 =?us-ascii?Q?E6PSwZlxLZMeCcKaSMSKjnwf7jEAPYFey1KdfdJZtrPPUayOWU75i2pmZl0g?=
 =?us-ascii?Q?AWTW4QJLOps1wC5sOJyMj5ernW0ODvkf5UOlQJgkLoq28nxbrU/0e7a2y6PT?=
 =?us-ascii?Q?TVtNim8NDImOKPKUfSrb5dqJGoMzROh/KpshC+EZV2oMpj7sVAngMzTdSNlh?=
 =?us-ascii?Q?QahNQ1syysrJJDnDIOH40MErcA/ebnNjm4UUL08/BACIBL2MpOVoOasvh7uz?=
 =?us-ascii?Q?OIDxf25W3PBDyZTUHLdX63y+tLF5Ah7hKea+RDtuI62l+eZpHbFyjwtX6k0I?=
 =?us-ascii?Q?9kZIKd/lkEHfsM5Sq4XGjFubPTBu9qkFJPfRB5F3Dync2nkVOdAdTgF/GA/m?=
 =?us-ascii?Q?kt3Cm4FDxxyqfj4Qd4meqtNM8erDN9fcFQLqfTx8G/A0GMgAICLazCPvWDQ7?=
 =?us-ascii?Q?a+9AQvCaIG30HmBnrvzsUqM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a426b49-e515-4145-c8be-08dbb4b2e99b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 23:41:12.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvLAy8koh6fej0rwpV3EZhwWNe0uo8iLQ2ag3J9Yw8OhBAPxzCr7rR5f7uzcu5b5Jn1YiAhxQBIp7jG3UKeEobzuymI7W3BwSxi5k80YMv1DGPNfcGgi95LeN4v0sjJs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6241
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ampere SoC PMU follows CoreSight PMU architecture. It uses implementation
specific registers to filter events rather than PMEVFILTnR registers.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../admin-guide/perf/ampere_cspmu.rst         |  29 ++
 drivers/perf/arm_cspmu/Kconfig                |  10 +
 drivers/perf/arm_cspmu/Makefile               |   2 +
 drivers/perf/arm_cspmu/ampere_cspmu.c         | 271 ++++++++++++++++++
 drivers/perf/arm_cspmu/arm_cspmu.c            |   8 +
 drivers/perf/arm_cspmu/arm_cspmu.h            |   1 +
 6 files changed, 321 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c

diff --git a/Documentation/admin-guide/perf/ampere_cspmu.rst b/Documentation/admin-guide/perf/ampere_cspmu.rst
new file mode 100644
index 000000000000..94f93f5aee6c
--- /dev/null
+++ b/Documentation/admin-guide/perf/ampere_cspmu.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+Ampere SoC Performance Monitoring Unit (PMU)
+============================================
+
+Ampere SoC PMU is a generic PMU IP that follows Arm CoreSight PMU architecture.
+Therefore, the driver is implemented as a submodule of arm_cspmu driver. At the
+first phase it's used for counting MCU events on AmpereOne.
+
+
+MCU PMU events
+--------------
+
+The PMU driver supports setting filters for "rank", "bank", and "threshold".
+Note, that the filters are per PMU instance rather than per event.
+
+
+Example for perf tool use::
+
+  / # perf list ampere
+
+    ampere_mcu_pmu_0/act_sent/                         [Kernel PMU event]
+    <...>
+    ampere_mcu_pmu_1/rd_sent/                          [Kernel PMU event]
+    <...>
+
+  / # perf stat -a -e ampere_mcu_pmu_0/act_sent,bank=5,rank=3,threshold=2/,ampere_mcu_pmu_1/rd_sent/ \
+        sleep 1
diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index d5f787d22234..6f4e28fc84a2 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -17,3 +17,13 @@ config NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 	help
 	  Provides NVIDIA specific attributes for performance monitoring unit
 	  (PMU) devices based on ARM CoreSight PMU architecture.
+
+config AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU
+       tristate "Ampere Coresight Architecture PMU"
+       depends on  ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
+	help
+	  Provides Ampere specific attributes for performance monitoring unit
+	  (PMU) devices based on ARM CoreSight PMU architecture.
+
+	  In the first phase, the driver enables support on MCU PMU used in
+	  AmpereOne SoC family.
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index 0309d2ff264a..220a734efd54 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -3,6 +3,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
+
 arm_cspmu_module-y := arm_cspmu.o
 
 obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
+obj-$(CONFIG_AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += ampere_cspmu.o
diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.c b/drivers/perf/arm_cspmu/ampere_cspmu.c
new file mode 100644
index 000000000000..992c61d79518
--- /dev/null
+++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ampere SoC PMU (Performance Monitor Unit)
+ *
+ * Copyright (c) 2023, Ampere Computing LLC
+ */
+#include <linux/module.h>
+#include <linux/topology.h>
+
+#include "arm_cspmu.h"
+
+#define PMAUXR0		0xD80
+#define PMAUXR1		0xD84
+#define PMAUXR2		0xD88
+#define PMAUXR3		0xD8C
+
+#define to_ampere_cspmu_ctx(cspmu)	((struct ampere_cspmu_ctx *)(cspmu->impl.ctx))
+
+struct ampere_cspmu_ctx {
+	const char *name;
+	struct attribute **event_attr;
+	struct attribute **format_attr;
+};
+
+static DEFINE_IDA(mcu_pmu_ida);
+
+#define SOC_PMU_EVENT_ATTR_EXTRACTOR(_name, _config, _start, _end)        \
+	static inline u32 get_##_name(const struct perf_event *event)     \
+	{                                                                 \
+		return FIELD_GET(GENMASK_ULL(_end, _start),               \
+				 event->attr._config);                    \
+	}                                                                 \
+
+SOC_PMU_EVENT_ATTR_EXTRACTOR(event, config, 0, 8);
+SOC_PMU_EVENT_ATTR_EXTRACTOR(threshold, config1, 0, 7);
+SOC_PMU_EVENT_ATTR_EXTRACTOR(rank, config1, 8, 23);
+SOC_PMU_EVENT_ATTR_EXTRACTOR(bank, config1, 24, 55);
+
+static struct attribute *ampereone_mcu_pmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(cycle_count,		0x00),
+	ARM_CSPMU_EVENT_ATTR(act_sent,			0x01),
+	ARM_CSPMU_EVENT_ATTR(pre_sent,			0x02),
+	ARM_CSPMU_EVENT_ATTR(rd_sent,			0x03),
+	ARM_CSPMU_EVENT_ATTR(rda_sent,			0x04),
+	ARM_CSPMU_EVENT_ATTR(wr_sent,			0x05),
+	ARM_CSPMU_EVENT_ATTR(wra_sent,			0x06),
+	ARM_CSPMU_EVENT_ATTR(pd_entry_vld,		0x07),
+	ARM_CSPMU_EVENT_ATTR(sref_entry_vld,		0x08),
+	ARM_CSPMU_EVENT_ATTR(prea_sent,			0x09),
+	ARM_CSPMU_EVENT_ATTR(pre_sb_sent,		0x0a),
+	ARM_CSPMU_EVENT_ATTR(ref_sent,			0x0b),
+	ARM_CSPMU_EVENT_ATTR(rfm_sent,			0x0c),
+	ARM_CSPMU_EVENT_ATTR(ref_sb_sent,		0x0d),
+	ARM_CSPMU_EVENT_ATTR(rfm_sb_sent,		0x0e),
+	ARM_CSPMU_EVENT_ATTR(rd_rda_sent,		0x0f),
+	ARM_CSPMU_EVENT_ATTR(wr_wra_sent,		0x10),
+	ARM_CSPMU_EVENT_ATTR(raw_hazard,		0x11),
+	ARM_CSPMU_EVENT_ATTR(war_hazard,		0x12),
+	ARM_CSPMU_EVENT_ATTR(waw_hazard,		0x13),
+	ARM_CSPMU_EVENT_ATTR(rar_hazard,		0x14),
+	ARM_CSPMU_EVENT_ATTR(raw_war_waw_hazard,	0x15),
+	ARM_CSPMU_EVENT_ATTR(hprd_lprd_wr_req_vld,	0x16),
+	ARM_CSPMU_EVENT_ATTR(lprd_req_vld,		0x17),
+	ARM_CSPMU_EVENT_ATTR(hprd_req_vld,		0x18),
+	ARM_CSPMU_EVENT_ATTR(hprd_lprd_req_vld,		0x19),
+	ARM_CSPMU_EVENT_ATTR(prefetch_tgt,		0x1a),
+	ARM_CSPMU_EVENT_ATTR(wr_req_vld,		0x1b),
+	ARM_CSPMU_EVENT_ATTR(partial_wr_req_vld,	0x1c),
+	ARM_CSPMU_EVENT_ATTR(rd_retry,			0x1d),
+	ARM_CSPMU_EVENT_ATTR(wr_retry,			0x1e),
+	ARM_CSPMU_EVENT_ATTR(retry_gnt,			0x1f),
+	ARM_CSPMU_EVENT_ATTR(rank_change,		0x20),
+	ARM_CSPMU_EVENT_ATTR(dir_change,		0x21),
+	ARM_CSPMU_EVENT_ATTR(rank_dir_change,		0x22),
+	ARM_CSPMU_EVENT_ATTR(rank_active,		0x23),
+	ARM_CSPMU_EVENT_ATTR(rank_idle,			0x24),
+	ARM_CSPMU_EVENT_ATTR(rank_pd,			0x25),
+	ARM_CSPMU_EVENT_ATTR(rank_sref,			0x26),
+	ARM_CSPMU_EVENT_ATTR(queue_fill_gt_thresh,	0x27),
+	ARM_CSPMU_EVENT_ATTR(queue_rds_gt_thresh,	0x28),
+	ARM_CSPMU_EVENT_ATTR(queue_wrs_gt_thresh,	0x29),
+	ARM_CSPMU_EVENT_ATTR(phy_updt_complt,		0x2a),
+	ARM_CSPMU_EVENT_ATTR(tz_fail,			0x2b),
+	ARM_CSPMU_EVENT_ATTR(dram_errc,			0x2c),
+	ARM_CSPMU_EVENT_ATTR(dram_errd,			0x2d),
+	ARM_CSPMU_EVENT_ATTR(read_data_return,		0x32),
+	ARM_CSPMU_EVENT_ATTR(chi_wr_data_delta,		0x33),
+	ARM_CSPMU_EVENT_ATTR(zq_start,			0x34),
+	ARM_CSPMU_EVENT_ATTR(zq_latch,			0x35),
+	ARM_CSPMU_EVENT_ATTR(wr_fifo_full,		0x36),
+	ARM_CSPMU_EVENT_ATTR(info_fifo_full,		0x37),
+	ARM_CSPMU_EVENT_ATTR(cmd_fifo_full,		0x38),
+	ARM_CSPMU_EVENT_ATTR(dfi_nop,			0x39),
+	ARM_CSPMU_EVENT_ATTR(dfi_cmd,			0x3a),
+	ARM_CSPMU_EVENT_ATTR(rd_run_len,		0x3b),
+	ARM_CSPMU_EVENT_ATTR(wr_run_len,		0x3c),
+
+	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute *ampereone_mcu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_ATTR(threshold, "config1:0-7"),
+	ARM_CSPMU_FORMAT_ATTR(rank, "config1:8-23"),
+	ARM_CSPMU_FORMAT_ATTR(bank, "config1:24-55"),
+	NULL,
+};
+
+static struct attribute **
+ampere_cspmu_get_event_attrs(const struct arm_cspmu *cspmu)
+{
+	const struct ampere_cspmu_ctx *ctx = to_ampere_cspmu_ctx(cspmu);
+
+	return ctx->event_attr;
+}
+
+static struct attribute **
+ampere_cspmu_get_format_attrs(const struct arm_cspmu *cspmu)
+{
+	const struct ampere_cspmu_ctx *ctx = to_ampere_cspmu_ctx(cspmu);
+
+	return ctx->format_attr;
+}
+
+static const char *
+ampere_cspmu_get_name(const struct arm_cspmu *cspmu)
+{
+	const struct ampere_cspmu_ctx *ctx = to_ampere_cspmu_ctx(cspmu);
+
+	return ctx->name;
+}
+
+static u32 ampere_cspmu_event_filter(const struct perf_event *event)
+{
+	/*
+	 * PMEVFILTR or PMCCFILTR aren't used in Ampere SoC PMU but are marked
+	 * as RES0. Make sure, PMCCFILTR is written zero.
+	 */
+	return 0;
+}
+
+static void ampere_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+				       struct hw_perf_event *hwc,
+				       u32 filter)
+{
+	struct perf_event *event;
+	unsigned int idx;
+	u32 threshold, rank, bank;
+
+	/*
+	 * At this point, all the events have the same filter settings.
+	 * Therefore, take the first event and use its configuration.
+	 */
+	idx = find_first_bit(cspmu->hw_events.used_ctrs,
+			     cspmu->cycle_counter_logical_idx);
+
+	event = cspmu->hw_events.events[idx];
+
+	threshold	= get_threshold(event);
+	rank		= get_rank(event);
+	bank		= get_bank(event);
+
+	writel(threshold, cspmu->base0 + PMAUXR0);
+	writel(rank, cspmu->base0 + PMAUXR1);
+	writel(bank, cspmu->base0 + PMAUXR2);
+}
+
+static int ampere_cspmu_validate_configs(struct perf_event *event,
+					 struct perf_event *event2)
+{
+	if (get_threshold(event) != get_threshold(event2) ||
+	    get_rank(event) != get_rank(event2) ||
+	    get_bank(event) != get_bank(event2))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ampere_cspmu_validate_event(struct arm_cspmu *cspmu,
+				       struct perf_event *new)
+{
+	struct perf_event *curr, *leader = new->group_leader;
+	unsigned int idx;
+	int ret;
+
+	ret = ampere_cspmu_validate_configs(new, leader);
+	if (ret)
+		return ret;
+
+	/* We compare the global filter settings to the existing events */
+	idx = find_first_bit(cspmu->hw_events.used_ctrs,
+			     cspmu->cycle_counter_logical_idx);
+
+	/* This is the first event, thus any configuration is fine */
+	if (idx == cspmu->cycle_counter_logical_idx)
+		return 0;
+
+	curr = cspmu->hw_events.events[idx];
+
+	return ampere_cspmu_validate_configs(curr, new);
+}
+
+static char *ampere_cspmu_format_name(const struct arm_cspmu *cspmu,
+				      const char *name_pattern)
+{
+	struct device *dev = cspmu->dev;
+	int id;
+
+	id = ida_alloc(&mcu_pmu_ida, GFP_KERNEL);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	return devm_kasprintf(dev, GFP_KERNEL, name_pattern, id);
+}
+
+static int ampere_cspmu_init_ops(struct arm_cspmu *cspmu)
+{
+	struct device *dev = cspmu->dev;
+	struct ampere_cspmu_ctx *ctx;
+	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
+
+	ctx = devm_kzalloc(dev, sizeof(struct ampere_cspmu_ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->event_attr	= ampereone_mcu_pmu_event_attrs;
+	ctx->format_attr = ampereone_mcu_format_attrs;
+	ctx->name = ampere_cspmu_format_name(cspmu, "ampere_mcu_pmu_%d");
+	if (IS_ERR_OR_NULL(ctx->name))
+		return ctx->name ? PTR_ERR(ctx->name) : -ENOMEM;
+
+	cspmu->impl.ctx = ctx;
+
+	impl_ops->event_filter		= ampere_cspmu_event_filter;
+	impl_ops->set_ev_filter		= ampere_cspmu_set_ev_filter;
+	impl_ops->validate_event	= ampere_cspmu_validate_event;
+	impl_ops->get_name		= ampere_cspmu_get_name;
+	impl_ops->get_event_attrs	= ampere_cspmu_get_event_attrs;
+	impl_ops->get_format_attrs	= ampere_cspmu_get_format_attrs;
+
+	return 0;
+}
+
+/* Match all Ampere Coresight PMU devices */
+static const struct arm_cspmu_impl_match ampere_cspmu_param = {
+	.pmiidr_val	= ARM_CSPMU_IMPL_ID_AMPERE,
+	.module		= THIS_MODULE,
+	.impl_init_ops	= ampere_cspmu_init_ops
+};
+
+static int __init ampere_cspmu_init(void)
+{
+	int ret;
+
+	ret = arm_cspmu_impl_register(&ampere_cspmu_param);
+	if (ret)
+		pr_err("ampere_cspmu backend registration error: %d\n", ret);
+
+	return ret;
+}
+
+static void __exit ampere_cspmu_exit(void)
+{
+	arm_cspmu_impl_unregister(&ampere_cspmu_param);
+}
+
+module_init(ampere_cspmu_init);
+module_exit(ampere_cspmu_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 1ba00d640352..0e3fe00d741d 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -383,6 +383,14 @@ static struct arm_cspmu_impl_match impl_match[] = {
 		.module		= NULL,
 		.impl_init_ops	= NULL,
 	},
+	{
+		.module_name	= "ampere_cspmu",
+		.pmiidr_val	= ARM_CSPMU_IMPL_ID_AMPERE,
+		.pmiidr_mask	= ARM_CSPMU_PMIIDR_IMPLEMENTER,
+		.module		= NULL,
+		.impl_init_ops	= NULL,
+	},
+
 	{0}
 };
 
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index a30c8372214c..2fe723555a6b 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -71,6 +71,7 @@
 
 /* JEDEC-assigned JEP106 identification code */
 #define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
+#define ARM_CSPMU_IMPL_ID_AMPERE	0xA16
 
 struct arm_cspmu;
 
-- 
2.40.1

