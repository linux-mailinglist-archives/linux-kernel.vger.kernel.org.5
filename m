Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7FF758E32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGSG5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGSG5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:57:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDD41BFC;
        Tue, 18 Jul 2023 23:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvoNr2IbS8DAH/bJRa9bJq8xRkEeI3Amt9Da+5uxl4G+NvsxTSmWXekG6Zv13xK+aiOAjWKoYneBX9mM86w8xvAcyeYA1c5z5MLNenF53R/xi4gbLK780N4idNrln/QOLkhibD2quxRZ6evnBVYS0lGVzJCRtM0YzMZI0NGWYFkRWoQM7Z6SfWGjjeVqLUGt38XD5f9kEIigtzVPeu1VDJP8dsXGaPRyUdQEAcrwr/bvEjZdOHSzRC5e3MzNfLlmjEw5YQA0XBSxrgt4WQx/8zXkqMscZSxEtTp+cRSWcbOcifq8diXOMzG2cvdO2HTdNC6IYW7Hbdp9xOVbOayL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9pe8Pz4uvzC9jXjKNl0tRB+NGLP0LTS2GUx/M/t2dw=;
 b=oYQ2Cp0nksbi0DBCkreg8Bp7yAMcFXUbiFMDXW1noQ1MhfNoTJMTp4vwNWEU33FPBbLu1KfDxOjfzWxoWOqCLVnhcCYYzMQv86BgSeEpGk7aT+tWs+0znkzOAwli51caanPNlXIw0KObtPEh4WcgPziRor9Yi83Yk3BguXRHEygVK+09W577APpgnJHGenoYOi6/GYM4dtjdWIaXjfx/2W0KVqJUhI5vlxVTXPYaNqgvSasncjrqDvfqSO3UU19rKy0DBnkGDn140sKwBXMdRWYP9tz2yhQ0e2q6tUpKtuNAvs4xM6fZhcHMMHahkbOkHummInIwjux5vS49T1GnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9pe8Pz4uvzC9jXjKNl0tRB+NGLP0LTS2GUx/M/t2dw=;
 b=mQQJ3nr8V1TkYTKAAg1hHAQfwXs/1nhWdiCz9XD/RYgImdF8gSgwBJ4Fp3Q9kRVlTBZYs9tWijPRs+ln+seEQ6k6kDYD74JjwopGZyU6vuMRCh779uw85ozhgG8vtJ7LB9Wyc1TmYVnts0HzuGIzxwTruFy0DO4OKANzvbb1wtM=
Received: from BN8PR15CA0027.namprd15.prod.outlook.com (2603:10b6:408:c0::40)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 19 Jul
 2023 06:57:28 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::ce) by BN8PR15CA0027.outlook.office365.com
 (2603:10b6:408:c0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 06:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 06:57:27 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 01:57:07 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 3/6] x86/cpuid: Add smp helper
Date:   Wed, 19 Jul 2023 12:25:38 +0530
Message-ID: <827723d8f506411700c68bccc5072ec8d918d2de.1689748843.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689748843.git.sandipan.das@amd.com>
References: <cover.1689748843.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdd8ef2-c606-4d12-499a-08db88256a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bxj97Nqg+CKGgrgn4L3ee6CZDQz9Tesb5PSRlp4GBQYsuKidkZL4brSO35jxbDJVLgOKFjmOoSxeKy/qu8F5QVyASobLxeiOp7W0IqKgs2tN39T9ad4hqGzxqUgw+SGJ7kzXGPKBllu3KE+ZkOfKB883kqZFU6q7YoGqkXtxI8VDLDTj7tkVUHGmGW9EX+VbBzFR/hSnVefuN27YuZdM61b4/LkxK7M65gF/oyO6ryBJ8XvYFY6/Pkrn8eIzPywLa76WSjdfp4WNtTYlJke43a9oUQyuUB2D8lPrq0jTV6ude7MzTa0rk7asflqWplThAugqPnEgE2NJ3g9WOgkq2VPwSE12HtzMx5u/p4Jt4LnN6FR84bzRp8FMdGBElvWMGvYJ+2cZPt+gAvu0aCEkF9/gj7pN6rExuATT2CvDHqfszrVBeTpFmy31oIUKEAh3emOzIO5VxkmIwlwQDNKsFVqiynt9emezMTcqDTFta8qBkYULGGtXuCkpnEgDiu6aQ5VudyrjZOr8uDLH8SaOPT+lk8ht5Sib7YQ4uEPRB7znq4vnVwhhX0toLuaXwV9sBKSf+yKAZ7JJ+HB1UgiF7LEaiPeWUbBAQ4W1PXLFTYHzimpX67Gs4qY43WUvjeTOPH2W2jqm47xEKzthjMVNXGUOyiyI8BuUIvWspGD/GmnvBzv91E861xWI8DsSGsUWN6z1gvDAOa4NiYr5Y79utTatpEos1IMHCM4xn9aBCkeMiki7208MrgTzFVgjblnW9g3VL7av/t1Ii2U/bqnqdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(82740400003)(2616005)(81166007)(83380400001)(44832011)(26005)(16526019)(426003)(36860700001)(336012)(5660300002)(47076005)(7416002)(2906002)(40480700001)(70206006)(478600001)(110136005)(36756003)(6666004)(54906003)(316002)(8676002)(86362001)(4326008)(186003)(8936002)(41300700001)(70586007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:57:27.7732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdd8ef2-c606-4d12-499a-08db88256a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on which CPU the CPUID instruction is executed, some leaves
can report different values. There are cases where it may be required
to know all possible values.

E.g. for AMD Zen 4 processors, the ActiveUmcMask field from leaf
0x80000022 ECX, which provides a way to determine the active memory
controllers, can have different masks on CPUs belonging to different
sockets as each socket can follow a different DIMM population scheme.
Each memory channel is assigned a memory controller (UMC) and if no
DIMMs are attached to a channel, the corresponding memory controller
is inactive. There are performance monitoring counters exclusive to
each memory controller which need to be represented under separate
PMUs. So, it will be necessary to know the active memory controllers
on each socket during the initialization of the UMC PMUs irrespective
of where the uncore driver's module init runs.

Add a new helper that executes CPUID on a particular CPU and returns
the EAX, EBX, ECX and EDX values.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/cpuid.h | 14 ++++++++++++++
 arch/x86/lib/Makefile        |  2 +-
 arch/x86/lib/cpuid-smp.c     | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/lib/cpuid-smp.c

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 9bee3e7bf973..17e74d4584f5 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -150,6 +150,20 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	return false;
 }
 
+#ifdef CONFIG_SMP
+int cpuid_on_cpu(unsigned int cpu, unsigned int op,
+		 unsigned int *eax, unsigned int *ebx,
+		 unsigned int *ecx, unsigned int *edx);
+#else	/* CONFIG_SMP */
+static inline int cpuid_on_cpu(unsigned int cpu, unsigned int op,
+			       unsigned int *eax, unsigned int *ebx,
+			       unsigned int *ecx, unsigned int *edx)
+{
+	cpuid(op, eax, ebx, ecx, edx);
+	return 0;
+}
+#endif	/* CONFIG_SMP */
+
 #define for_each_possible_hypervisor_cpuid_base(function) \
 	for (function = 0x40000000; function < 0x40010000; function += 0x100)
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index ea3a28e7b613..e0097ae55edf 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -39,7 +39,7 @@ $(obj)/inat.o: $(obj)/inat-tables.c
 
 clean-files := inat-tables.c
 
-obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
+obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o cpuid-smp.o
 
 lib-y := delay.o misc.o cmdline.o cpu.o
 lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
diff --git a/arch/x86/lib/cpuid-smp.c b/arch/x86/lib/cpuid-smp.c
new file mode 100644
index 000000000000..87340893ff61
--- /dev/null
+++ b/arch/x86/lib/cpuid-smp.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include <linux/smp.h>
+#include <asm/cpuid.h>
+
+struct cpuid_info {
+	u32 op;
+	struct cpuid_regs regs;
+};
+
+static void __cpuid_smp(void *info)
+{
+	struct cpuid_info *rv = info;
+
+	cpuid(rv->op, &rv->regs.eax, &rv->regs.ebx, &rv->regs.ecx, &rv->regs.edx);
+}
+
+int cpuid_on_cpu(unsigned int cpu, unsigned int op,
+		 unsigned int *eax, unsigned int *ebx,
+		 unsigned int *ecx, unsigned int *edx)
+{
+	struct cpuid_info rv;
+	int err;
+
+	memset(&rv, 0, sizeof(rv));
+
+	rv.op = op;
+	err = smp_call_function_single(cpu, __cpuid_smp, &rv, 1);
+	*eax = rv.regs.eax;
+	*ebx = rv.regs.ebx;
+	*ecx = rv.regs.ecx;
+	*edx = rv.regs.edx;
+
+	return err;
+}
+EXPORT_SYMBOL(cpuid_on_cpu);
-- 
2.34.1

