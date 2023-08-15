Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ECD77C7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjHOGhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjHOGgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:36:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2112.outbound.protection.outlook.com [40.107.223.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B933919B0;
        Mon, 14 Aug 2023 23:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFW6h2sCzrNlgOOB/fUpONHohNh6DOytjZ1svpdKfnlTl9BI1vWr4I1ON2kliAdHva5xEO/EdDfnrjQUj9Zol8+xbSvqp277t5kCzzVUtpukPRgkYt47qTR491aFCtHwkxnISPG3UNe6Ev2qPFTwKQSGvRwDrqgGQwqcYay7L5GmSqNZ3VFpTu+u7g0qK/KdtLEdL2JbJ4IY7gryU1RkhKXz+diiR3Kb8Fps4OCgV6Cx5gW/JOayWOrBZE8VtwyYZgzMdqScty/pXV4Z9ggSBKjjuo5chDv+f0g0D1V3X1HY4TxAEVk2p8bYz1/fRN/9H1euHdpo0Q4rSYRBnCsbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwmrClqCm4mQXvvoCUBR5siufIkn/wKEHZmqRWl7REo=;
 b=U2s7Db8DlGCd/YmAg7oM+h8iC+Aci8JUIPAnqSeVmxEyw/kCbgJ7zew78lzkV2zInKhZrMyJpVwGuetFar970pa8IuiDw92zinG8h3jgwePDUeemKb0itUfgNGGdWT79lABigBP41913HCjbfjsT+sZOBWIRQmYGmrj7X2w90pjB9F5y0VZQRiDhNk5HvNrJdzuH1X3DoIYDha4qMYa5riggZsQU65NGNyBWBB+X8RtngRAZ/9DO+me/6JXNy86I0wwJCr2q5EER3YNxyLW0rOaWc6E+Mf0hVgD21NFtn9KgM1YTfVmsA7jJU8yaoZW9FsCPE2kxECKA1LWwoB83AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwmrClqCm4mQXvvoCUBR5siufIkn/wKEHZmqRWl7REo=;
 b=R0t6mRLPRxRpgkxj/FPYt6Z2R4ebbHN8sLlMhOkLMHkuDSoveI05EyjrTxxu+hGgkrzjsRKYwjrNRz2yAb14u2mfg4YhZfIntM8jOGLen+60grzrt1om1Y/rS1HANOE+RpIKalYAT/WFFmdJB3oZtTvwnFceDo4ZPfdRypjZ4m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH0PR01MB6117.prod.exchangelabs.com (2603:10b6:510:9::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 06:36:16 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:36:16 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 4/4] perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU
Date:   Mon, 14 Aug 2023 23:35:26 -0700
Message-ID: <20230815063526.9022-5-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815063526.9022-1-ilkka@os.amperecomputing.com>
References: <20230815063526.9022-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:610:11a::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH0PR01MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac9a48a-c20d-4bd3-0a81-08db9d59ed8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nr3KHMFUMziWSppwRobPxWQxivHisiUIhvre6mMy6ptYen5/C5wfHzdJaNB+xjHzzK+JQLPQCPJNlAskbizOXgpzd9rJ4n8/uaPPRFNVpYht5QQi0D2+CBqJ04L92GC9xWtzvyfevU5Jkw5jEcIZKHL85Zj0d612mLHwN+k+aqGOpPBkQ+0ZufhZeM3FX3Xq+LBojzjn/Kp7uAw7y2gMqLoL1xYC6NCtQ2u1pJgD75lFHTAoC3v4nSlfkmyc+PQP71qId2lF/fS9Fsn6WY+XG5L7e8h/8Iw0CPrvtasxb8PGUUCt6dLadJJO5GvJ7+HasJdCNM18Xj0X+QFTEhonUtprxv0J03Ae2tDlRl6uMy5rSGKPhiF4J97bIYZSpM+z1jhMN8iDxyQsnQD+9Oo0mIPm4lZBZI9tQ7G8N4i6xYFgeJqHerL5qX81wX67Q9n1poQ7l4HPrsTYTKFl0Wo1S3pmLvL6PnoiLlD6hrcOA0uauy1I6A6UaPRntyy/3hVIykNYKsJ7BGI0xxVo8eGOusBcHIBkFC3+H6Vhh1//QTiSbv0iQNCGGqZ/J9fBDoXvWSjRGLnXLt+umN7nSVKOf854Gn7thGpc10s7bZbiDSMWAcj80b4iVxfWXk+Sqbul
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39850400004)(451199021)(186006)(1800799006)(110136005)(86362001)(478600001)(52116002)(6486002)(6512007)(6666004)(41300700001)(5660300002)(4326008)(66556008)(38350700002)(316002)(38100700002)(66946007)(30864003)(66476007)(2906002)(8676002)(8936002)(7416002)(1076003)(26005)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ch4sB5mhBrVrNKk32t7ElHEJY+sHhs84WtcdCwTfvUKKOADiwrLLA3Il5o6e?=
 =?us-ascii?Q?UUBIRZg88e/2/yY0XwGsT1E6freyh7ZdhqtaLHSiDoqPz9IxoF1kIiGmu2cF?=
 =?us-ascii?Q?wWkkIoS7vJibDTOWfBKoXV/7HV95CnULGC69q1kNTOr7+B7me/sYxpkbjMcQ?=
 =?us-ascii?Q?WpghrB8Z1+45M6uPqzQxmycgJi6MZ1nM4Ys6z2H7OK49ZnSZuXvxY96t7Dv7?=
 =?us-ascii?Q?mQYFxXaCYHhmqGtfiX0yWGREg/N96p1LUOdXlV4d2sKQp8RkYALwkYCjFlY3?=
 =?us-ascii?Q?9PsXibYNERfXPXU1RYKfN8+A/Eq92n/O4bu33y11ldmaVIzcYcHiKn6gQQeO?=
 =?us-ascii?Q?B1kTr7MMbatIrT84H4BWyJ6xpbY8pKRTIihhSauiO6iXEhjdIl649c7RKjRD?=
 =?us-ascii?Q?1muds3FAI1XK34xWdPYSruaqAb9maEx4fZQ/by/N6f7dfAx2t2Y1BBLQErCG?=
 =?us-ascii?Q?ESX/w+jyshKN+U5ldarczQFNhwNNj13dZYudq/71xfebB71Kk8bAXSd3C5bl?=
 =?us-ascii?Q?6ZGaXkGVky87FRZBAc4Z4Kva2QsmSCjkhYPZBGQeWHI0lMA/kZruSRLJiG/U?=
 =?us-ascii?Q?Rc1p8la8liBQvLZqDl+N1VYjmOM0upIeCoXh8Si/tln3N0jklEX5aOWCC+1c?=
 =?us-ascii?Q?Ue4MDfnFmtxQy0S9mTg8YtBeETsFy4SZdySn17Qc9fDB9Bh7I412qZCWSiJU?=
 =?us-ascii?Q?03lCrWPcGaT60I6PjC+3Dz0PfBnERMabxC1m9NH6WXenC1lioHEtueDhBV0f?=
 =?us-ascii?Q?eeObvmIDYBl8LJXYUwlLQ76LrqNrI6DXK03dk0Q9/Odp7uR3texk1BxiUwye?=
 =?us-ascii?Q?4gEcPyJ+L2P0NIW+elKLZRn5ZCJeLphGJhQeQwYuGM5G1fTmSbfgMwxxiBp/?=
 =?us-ascii?Q?ixzD60W3TH6Dg2xnj0iLbk8g6FFf35CBLmK28+EMO18bPkDl/UkZN6WDPDh6?=
 =?us-ascii?Q?5xwBANyFZjqlX76dksdN99CzYSRAewcVnTiG8Q0FcBa7t9+htNK2s3RMfbY2?=
 =?us-ascii?Q?PoQdGcwZsLC4EUCDJBsQrzBLGIKs/eypMHWMBV4vKlTwpN4mJ/xvr7CCDuJg?=
 =?us-ascii?Q?RHXvLw/bOnPELtYWUbu5m9YD+fvnaclb42U1+bIA7snU8BG9YJSIipFLcYEn?=
 =?us-ascii?Q?BMtQsRR16WDwprep8NqYbW1YiHHUDkE3CARVuaZ0bv+cCG/JL9BlxhMPfV8C?=
 =?us-ascii?Q?zUL3Nl4ZXPbs77LspqlANT0Q1EePIkV1tXMDFWWAzVPSQmnxT25fzHQXPaC7?=
 =?us-ascii?Q?GQXgkD12BUAW6md8Fw+nutZJfvAN7AbA7boopgcv61I3iKqcxklNrtpvrMR9?=
 =?us-ascii?Q?eIv1FQ5BhmGqraERjc818Ujs2mgoTQ0dIGinzfEazsMN2/I4pQHL2fM/42yc?=
 =?us-ascii?Q?dRNdv5XoXEmkLs4O6EbjpcFpj4xuSqk+nridCNJFI63dGe+nyElQjOQsq5DN?=
 =?us-ascii?Q?Vs5CaGrAE21c6KJ8L3oSfRqwLLflCi1mk8n1aklalOU3lr7XrFJjEyVtr2cU?=
 =?us-ascii?Q?b4r2WMI9nRV9+c49+idt4jz5WTMYpbii+XkmcEQzCQYsu0TYwerBb01r9Q8B?=
 =?us-ascii?Q?7mvTc7mcXOOgWSVmrZNuh65P96ziOq1WYQEhJtQsAe5YFF0QT5VrJlsozwYC?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac9a48a-c20d-4bd3-0a81-08db9d59ed8c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:36:16.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3yy6q4QX8f01+5qMMU0VsWuK6OSBOaRKH2LR5QcIQNxPgiVYBczMX5GD4j5JUzLLLSoX4Ng49ENfXviDi35iVQVnBowOiDr7ymhiXadzjrPR21g+549ARXO4mls7EGb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 000000000000..a365f59fbfe7
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
+static DEFINE_IDR(mcu_pmu_idr);
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
+	id = idr_alloc(&mcu_pmu_idr, NULL, 0, 0, GFP_KERNEL);
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
index 585ce96ac03f..d6c50e06c5bc 100644
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
index 05577f74b8a0..586441d4dba1 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -71,6 +71,7 @@
 
 /* JEDEC-assigned JEP106 identification code */
 #define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
+#define ARM_CSPMU_IMPL_ID_AMPERE	0xA16
 
 struct arm_cspmu;
 
-- 
2.41.0

