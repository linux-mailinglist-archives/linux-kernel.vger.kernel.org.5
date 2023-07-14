Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF77752E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjGNBCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjGNBCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:02:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958102D66;
        Thu, 13 Jul 2023 18:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIO2aaLgwdQjH7RjFcYSVSMzeETjDkeKNjy5RzIz+8SCs1zrGcyrJWcf4yUX1WY7Dle7wVyw1baUS4TLEE+22cYa7pJppUs4zCky0BZCkyUzAju43Pyie5/SVOty9k++W4nUpBhC1Ce2WoiowkUQ/KQpq17qZgTz7Hw2uUDyIu/WGjhZSR5I0opB8HDh0LkjElhV8/WB8U8G0fos6jppAIdLdfk9JFKeRaIwJnPy+8mcKJbHFmxtdxOQhTCH9LmRbC51eUu6UD65oTiFaHqaZz2Kp8O0dKxBxRBgtlECk94wCKnANpMAA2Xc8dUbUOF06iBkeeU3Q9UDu8INjL2D9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIA3BobmIQp2sWJuWbi2lQbPJe7Nqnxq9l9pxYxcgAA=;
 b=GI4BLaMhw8OaKNlGi25uu75+PXqO1HjyY+iXSbcg2N+zGNr7B4DzRc8qoa74qgeaR8lGf2K57r05BqN1fX4Ul0gJvGITrxj+tazsrMj9/ri8rifg/PNPz4n7aLUT+61NNgWopwCCJjOYkQJFycMnnaZDuBZNTAUFwvzakKBPOnh9u0D5pKT0Gtlf/gAVs7IZK23AGhgZ9eMIGNw5MknOtCJcVXu3SvqotZ5tH4h+0vLggJdOJaci4MB/1TH2icdcnO6vN27caaFPXCHKMwZ3WLolIhiiJahGUxlMsSuHWFbqpAYPi2qvz7PwsPOloP0TpkiU6esoq2EU21MfwBwsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIA3BobmIQp2sWJuWbi2lQbPJe7Nqnxq9l9pxYxcgAA=;
 b=E8FSmHRwwtmeXmgmTm7Q8GZ7F10qK/ILE81yjRsZ6vYgW0YUSsKzHmqTpKgXyna9onK0CiEhyD4C4tD48RjAcKHHBY6QCAchpR1QJ2Q3GuagawPpXCr76g6rGUBsEG0a9SAkIr3sfcYafPzS9QoWnuvYT7xpatHf0YxBVGfz4Jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BY3PR01MB6611.prod.exchangelabs.com (2603:10b6:a03:36a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 01:02:35 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::235a:622:9239:3963]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::235a:622:9239:3963%7]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 01:02:35 +0000
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
Subject: [PATCH v5 4/4] perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU
Date:   Thu, 13 Jul 2023 18:01:41 -0700
Message-Id: <20230714010141.824226-5-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
References: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BY3PR01MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: c243c8a1-345e-41be-5b22-08db84060260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsNT27R3ZCnXzHg/J8CZewj68WhbnaeNwXe5W6BrsmAZAue5trt/+63Wvi+T77fNun+SyGWAbijas8of/Szka4I9yoFljgXWZ2Hee9ZpCt3lnJzltK1zWr1D9HIx3oVGoorcOKdGcu3ukGwzmZpKQqnZn8hCoW/pZpO+aBziN1uin8njem9BJgz26Yf2EZKtNxKCUK4H9gyh6iUPaeV1Gq3LVUxwlOlwKsEtv8rthNyPnzsLHptbHYOQIacBpCKVDLPGN8GwF+oTqH/M2swUgf2Gq7xGH6lK2A1tRJ+uCPzlH0g4xLd4d2ab5+Ap4EqpFrgAMNsle+Hu4yyCpe2hvjF017FwQwjMM2sKV1xlDiLixepww4i3vTR9FTTJhEnBvrSlVU2LzLhlfNgbqW1tBBFktXbU22GD33ii1SFCiHr4lOgu4bxk7XZxGu0Nwop1eJVqTnwxdhgk+FowTwE412MDNX0jh2MzyqMJy3+GIDksD05QPAfNdfEVfAwjO/KCHzVHiy+jb/5Kh0Ug3fugaFmZfozV4WTP704IXZHQj1KM6IUrLy+gJqLMPnza0RfXD7qrFgBzreRlnodLWuyMXFMr2vOz/KXFCOsyMZ6jNfqCMeI6KSNNLAFGBHYjBFg3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199021)(2906002)(38100700002)(38350700002)(6512007)(83380400001)(186003)(2616005)(26005)(1076003)(86362001)(6506007)(5660300002)(8676002)(8936002)(7416002)(30864003)(110136005)(478600001)(6486002)(52116002)(6666004)(41300700001)(66946007)(66556008)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uublSBsIM4nP6ZhIxeaptklNeh1NVnmHR/tVyPJyuxPuFYvONbRmiuok01XW?=
 =?us-ascii?Q?BjZbmy8g0Grz90wDp1UQvRuKG9wVDc08mk6S95TCY/mSgO0BrvOI4FRsTwNO?=
 =?us-ascii?Q?XsSJlQg+GNowGrfQ3GcVi5aJfp0aeWzrQQICvFivpZD3186X1A8BYvNmAdv+?=
 =?us-ascii?Q?pcuKzwBCpE3yYl9y/jPOBj6JqbYtvLQX5Ws7MVRD1xD/6AzUs+lX4BeH6wMe?=
 =?us-ascii?Q?bCBwUwEZlATx8fHZwvhKsHmDigj+inJLx6ULzmXKE8LD+ZDsdswFk/Anne/D?=
 =?us-ascii?Q?kSYNn7d8AQOTu7Xu1LomPp/vjmkhatuzXtVMbbNRDseFf2FBSPJwtwJLaOhs?=
 =?us-ascii?Q?NUuQrtnnr/Vaa7jMLYJvtM8jw6DywIMiv9Tn36WIwvcyB/YHHB7y0mGV+CSx?=
 =?us-ascii?Q?4mDA57WRnk8azKZu1RylgsGLEOaPbF6xhd7ZwjwLa0TU+CzoW1ak7aAUmHLP?=
 =?us-ascii?Q?lI5KmVs5iDsPdwknivLu8PHQYow5k9KxNgFqwZJDXJYavXr2WY+mQEI17vka?=
 =?us-ascii?Q?vdG0/qqsFH/VbsTBaymLIzvYlfOdNejTxrnql8LZHfQ194aFbnO/Dd/x0sM2?=
 =?us-ascii?Q?aKYzJysZscnLGW4v+sodpoV2dkfXpxcuEiDI3Ih+Bb84twlBXJHdSuG7CaC7?=
 =?us-ascii?Q?xdPq5Bq93Pgqlrpf7qn2v0C7yT75zCLED2qNrEJTMEp060Y4iDuDASOfEomq?=
 =?us-ascii?Q?jhZfjiuNT0hSu7qqAe3eKQcT74jYHTIWBkmjpF433UjnKm+ooOdFl8aUeYBh?=
 =?us-ascii?Q?+tAb8Jh/Wzsmu/HiXQ3L6c9OyiBGXSUfGudbdZSzTDUHUZIL6+1tGfbtVrT7?=
 =?us-ascii?Q?2AmM/UoaYcQUPWGCp9l8cacS/ic6r0LDx/wCu+46jfivjU0dlvJHnQLnKf4Z?=
 =?us-ascii?Q?JXdITMP0hIWwbZ6NbbrCELjTvyrFrXnbPqcMdtWE5cozCmKdB5Sg/6A2m12k?=
 =?us-ascii?Q?PHIue/ksVA1OSN3b6nXvodX3IZeW582UFlnx4gzY8UwsJ2pgV35AjrpGZOAD?=
 =?us-ascii?Q?+ZRx4bEqm0SO+KCuc711a7FeoaYcTlbIqbcWVBRlSQ42505gQEkT0JyCcT/6?=
 =?us-ascii?Q?jgwqGjtnZmTkNsY8vIf3OkZWAf6nGXYHb9CQuYaPGmKW1UZ6jazDNEo7so4N?=
 =?us-ascii?Q?MvjsfC//EYySpms6FGk/WLDYZFZcFD+96VRR9zUqMzPzQNSV9+4aQwjb2QXJ?=
 =?us-ascii?Q?Rfstl+0vTmcZct1dYTYuZ6Ht6sPdyZN0d3oWnMM2WGQfqH3Oq6SAu8BjuafG?=
 =?us-ascii?Q?DGTw7+/xpQRZBzOxxJk/0k5lARK60XvMmr3w5Q1IE8LRE+WJgUIQmRLUSFoj?=
 =?us-ascii?Q?FW25aAGbc4xcCYg22Sr53765YGHAjzJSR/aWGKyMAG0VtP9yaXAbfxPoAAEq?=
 =?us-ascii?Q?K/zdN80je1TuvOosEdainbu4Vn4kZuLkgDnChjhx4LBB/IINblSji3GsOFOg?=
 =?us-ascii?Q?uFrN2KrVpPZIVe2vRy9KfKXe8QYiAFenuP5yEbCdZSWkfU6RgilHiwzKrAV9?=
 =?us-ascii?Q?cQ0AF5xvCM4iRujVMVtDs+u+/MxpPeyJ0YLU6q3VKbG6WqGl5ipUn+GQKbKA?=
 =?us-ascii?Q?Hu3w1vxbQhD/wtAsk8iYe/68xX1sjZGAkuvhEjKT7+llDDXA0olWq781Ycb4?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c243c8a1-345e-41be-5b22-08db84060260
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 01:02:34.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMki6SCdhjcaS+cU5TrfgGwzuf4zL46po50ZpIFOmbGSJK3XU8VQ3ho2x0Ou8b0C0ZkPSCDfap7Drg3pFQSt1EQohU7AEUjO5kZw5qi0EiJRnUmIJHlo3CcTWA8+RZkA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6611
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ampere SoC PMU follows CoreSight PMU architecture. It uses implementation
specific registers to filter events rather than PMEVFILTnR registers.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../admin-guide/perf/ampere_cspmu.rst         |  29 +++
 drivers/perf/arm_cspmu/Makefile               |   2 +-
 drivers/perf/arm_cspmu/ampere_cspmu.c         | 243 ++++++++++++++++++
 drivers/perf/arm_cspmu/ampere_cspmu.h         |  17 ++
 drivers/perf/arm_cspmu/arm_cspmu.c            |   8 +
 5 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.h

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
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index fedb17df982d..b80a8bd8da54 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -3,4 +3,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
-arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
+arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o ampere_cspmu.o
diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.c b/drivers/perf/arm_cspmu/ampere_cspmu.c
new file mode 100644
index 000000000000..cfafc093b694
--- /dev/null
+++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ampere SoC PMU (Performance Monitor Unit)
+ *
+ * Copyright (c) 2023, Ampere Computing LLC
+ */
+
+#include "ampere_cspmu.h"
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
+int ampere_cspmu_init_ops(struct arm_cspmu *cspmu)
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
+MODULE_LICENSE("GPL");
diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.h b/drivers/perf/arm_cspmu/ampere_cspmu.h
new file mode 100644
index 000000000000..9b3e1628d1d6
--- /dev/null
+++ b/drivers/perf/arm_cspmu/ampere_cspmu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Ampere SoC PMU (Performance Monitor Unit)
+ *
+ * Copyright (c) 2023, Ampere Computing LLC
+ */
+
+#ifndef __AMPERE_CSPMU_H__
+#define __AMPERE_CSPMU_H__
+
+#include "arm_cspmu.h"
+
+/* Allocate AMPERE descriptor. */
+int ampere_cspmu_init_ops(struct arm_cspmu *cspmu);
+
+#endif /* __AMPERE_CSPMU_H__ */
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 471d6d7ac81a..579f2697b419 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -30,6 +30,8 @@
 #include <linux/platform_device.h>
 
 #include "arm_cspmu.h"
+
+#include "ampere_cspmu.h"
 #include "nvidia_cspmu.h"
 
 #define PMUNAME "arm_cspmu"
@@ -114,6 +116,7 @@
 
 /* JEDEC-assigned JEP106 identification code */
 #define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
+#define ARM_CSPMU_IMPL_ID_AMPERE		0xA16
 
 static unsigned long arm_cspmu_cpuhp_state;
 
@@ -388,6 +391,11 @@ static const struct impl_match impl_match[] = {
 	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
 	  .impl_init_ops = nv_cspmu_init_ops
 	},
+	{
+	  .pmiidr = ARM_CSPMU_IMPL_ID_AMPERE,
+	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
+	  .impl_init_ops = ampere_cspmu_init_ops
+	},
 	{}
 };
 
-- 
2.40.1

