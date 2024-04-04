Return-Path: <linux-kernel+bounces-131691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF9898B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D8FB2D6A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A201E12D75A;
	Thu,  4 Apr 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Fjcn6gE"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E112AAE0;
	Thu,  4 Apr 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243671; cv=fail; b=jR2KtMBPiVjBxv98m/AeU9nlIQa7a2oVOfVu3lltEVz55WpHhIO5mj+Vrok1lGsqSJ8tvHygz1KJUJvt0IJh567iwuy4PisLi0bME3A2jhN4hhSTIIkD0XN6Iy9J2yiV8Gu+P8HTiESerrbRp6eLsHcSHJQgqNq3MdP+uFcWF54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243671; c=relaxed/simple;
	bh=ciSK8iw59uQpGRmu8Bzw0PQtZYiGnDsesBKd1sQemFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdHSAMzVKRoUoc0iFarzVwKfv0yyD6GjncJxD72TTi++KYyIzMa5T+dYQ3T8JGmJtnRYsWuaimirv4/zYiBQc4YRg0TrE2bX4ZdKNIHT2zYmoLQdjtZsxnPHRmqC7UBx+HzMUbGvv1t3Kh7lBHxRoZ0aRaig4Xt1HN7GQmvihFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Fjcn6gE; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjcLxwZnT4K5yu22sZHHYs266J18WWI9pkeLcX/clJBwCGCtMbzW2+miwipy6C0+w+89ejt1zWcDN/DWF8rUagy5uIc30t+VVz62rQEhR5u5hQ3XEFmNwEMzcnhE57rUJEm66105phnWXGaRZk/Yw1mg97KRsW7iXeY2Zp3A/Yd2/MqKR7du7ClBQwq0IXukSZkt0V9gudzlW3p96V4/w7WGkGvvlS28ApzaeTnFmRiBReFbhOl/iup2Xy6xhMKfDXbSRZkVaagyQviqW7RnjzuajCxWX7v1YFXpYYcQhOWSbszmZoA7pcdVrGMn5zn8Ye+UUgAZbMQaCqob4iVh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28d7CehSLGwCI4JyYjtOVg7dRBNVxN1Bz5bAYyVcpps=;
 b=LC8OEPHupk1qbZgR7BbvAZEGmFMkbCk9F7NNpokcL3Yb2SkJZk5ziQtPKIXv9tlsDZaXienYTDiJm/b0vN34STBtS1NWbQm7gVHbyFVIuNQatd/MKAFbIaCxhb29SThaMvjgZbUf09EWbfaT4/+NsKyjSdhPCt6gJ73Ya2usbDc4MkMuMto9VvYtWOD5zSN2h1c/uv+AVJxTUB/zqL2FFzC+wAnDsWNtyHag1BbguiOrlzUypUaaNFqBu0Mfr6UrcozklzIwzxocxht09VK/akEf3fqW8oQ5y3ImOOdxxUFKBWrp7OqMTAxWZRhHq5Ohj+nOAq3rFH3UZ1yDLASfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28d7CehSLGwCI4JyYjtOVg7dRBNVxN1Bz5bAYyVcpps=;
 b=4Fjcn6gEngA+P6KzdnzTK/OUKJG5YiHFZxRBXlh5Hr9oNH4qFNjuP6FbU8K0f54z5PUZQSH9y4YBEg79dXa0Ez9S5vWRgQxMo3lqJzYiwf5ZbHw4sTJTn4VK7fwZSH4qlC4xDao3ykORT8FZf2VbNqW/KESt6z3VCd3AbVriQZQ=
Received: from CH0PR13CA0052.namprd13.prod.outlook.com (2603:10b6:610:b2::27)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:21 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::e0) by CH0PR13CA0052.outlook.office365.com
 (2603:10b6:610:b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:20 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:09 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 01/16] x86/mce: Define mce_setup() helpers for common and per-CPU fields
Date: Thu, 4 Apr 2024 10:13:44 -0500
Message-ID: <20240404151359.47970-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404151359.47970-1-yazen.ghannam@amd.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be12f94-e401-4283-5e3a-08dc54b9e73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IS1IQuBE4bA7Nb5x42g+tgerGkvgepGP0TWUa7InmpHkP4fv+JjBrgcI5hDJElUVvfZeoqCu7sp6d61A5CvG8KVTcfDJjJYT1zYwU/p2QjyKgJeF4cLX98vciqAiN59awy00q52pmkGfrqOjvhCVwMlcwVHJUrxdrOq14fyh8xO4nlowD/PcRc16uvneOlUuGaMYsN9mYWruTinSKdg+H1yNLvTnusUdKzKyKenIK3Qz1AK1ov03QfHV/EHljAzhAlYnCzFvGkumGKYq5+95pjBHU3RGGIkYAk4Y50mxrMGR2JGo2ycezrJRhIyY2jOetW/85HoqyRWBKXLJEx7WPfsBucsG9/90jwMULXoGCSSNKbms759bt4E8MQbdN9hs8ZZ88MLs7vh9KFYvplc+ar4P+1amcMi3jaDRfp6ZLvW2tFt0VE/2ntKrg6HqPwCwvo2rYNMoZeTWuhEk1nkZXsDQt9ww3STQW+nHyOr0oFFS1XTJh8vjYiYyfe6AIehGugurahXrucPj/Rk8B6LzzhHzWlPJzt52nxGL8GUV81eGbM5ZcJV8u97h/RcbqnkqhkIGoRA/OTlQWJWqyNxcUS3BLXfUp0ftQv/eKH/BLueLG81iirVLGz8TV+zhMCTyeBTiqWv3B8qSOMmIukRtEfsP+NXyyMSSlGytYR5N8wWR62XD81eBosl+XhW6o9vfUgk6k4+ECcu/0oy8NZOOhg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:20.2443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be12f94-e401-4283-5e3a-08dc54b9e73c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945

Generally, MCA information for an error is gathered on the CPU that
reported the error. In this case, CPU-specific information from the
running CPU will be correct.

However, this will be incorrect if the MCA information is gathered while
running on a CPU that didn't report the error. One example is creating
an MCA record using mce_setup() for errors reported from ACPI.

Split mce_setup() so that there is a helper function to gather common,
i.e. not CPU-specific, information and another helper for CPU-specific
information.

Leave mce_setup() defined as-is for the common case when running on the
reporting CPU.

Get MCG_CAP in the global helper even though the register is per-CPU.
This value is not already cached per-CPU like other values. And it does
not assist with any per-CPU decoding or handling.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-3-yazen.ghannam@amd.com
    
    v1->v2:
    * Change helper names and pass-in CPU number (Boris)

 arch/x86/kernel/cpu/mce/core.c     | 34 ++++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b5cc557cfc37..7a857b33f515 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -117,20 +117,32 @@ static struct irq_work mce_irq_work;
  */
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
-/* Do initial initialization of a struct mce */
-void mce_setup(struct mce *m)
+void mce_setup_common(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
-	m->cpu = m->extcpu = smp_processor_id();
+
+	m->cpuid	= cpuid_eax(1);
+	m->cpuvendor	= boot_cpu_data.x86_vendor;
+	m->mcgcap	= __rdmsr(MSR_IA32_MCG_CAP);
 	/* need the internal __ version to avoid deadlocks */
-	m->time = __ktime_get_real_seconds();
-	m->cpuvendor = boot_cpu_data.x86_vendor;
-	m->cpuid = cpuid_eax(1);
-	m->socketid = cpu_data(m->extcpu).topo.pkg_id;
-	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
-	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
-	m->ppin = cpu_data(m->extcpu).ppin;
-	m->microcode = boot_cpu_data.microcode;
+	m->time		= __ktime_get_real_seconds();
+}
+
+void mce_setup_for_cpu(unsigned int cpu, struct mce *m)
+{
+	m->cpu			= cpu;
+	m->extcpu		= cpu;
+	m->apicid		= cpu_data(m->extcpu).topo.initial_apicid;
+	m->microcode		= cpu_data(m->extcpu).microcode;
+	m->ppin			= cpu_data(m->extcpu).ppin;
+	m->socketid		= cpu_data(m->extcpu).topo.pkg_id;
+}
+
+/* Do initial initialization of a struct mce */
+void mce_setup(struct mce *m)
+{
+	mce_setup_common(m);
+	mce_setup_for_cpu(smp_processor_id(), m);
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 01f8f03969e6..e86e53695828 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -261,6 +261,8 @@ enum mca_msr {
 
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
+void mce_setup_common(struct mce *m);
+void mce_setup_for_cpu(unsigned int cpu, struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
-- 
2.34.1


