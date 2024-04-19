Return-Path: <linux-kernel+bounces-151532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587508AB021
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1F51C22C46
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED6B131BBB;
	Fri, 19 Apr 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GA2sgwYv"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012E130AFE;
	Fri, 19 Apr 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535373; cv=fail; b=MxmNwXhDamwN2xOdGi//A8jOGB6PHAwT1o2zPXnD+0Xx27Au0Bt0VcH0EUXAR1Ej8XG5Ayhwnib8AuK0dXG1ixA5LuKXEpw0xQpEGdgSnunV53nWn806r/PKmzjvsIOn392wJ9uURV5BZV2I594VAaew4nSP06H00kAPs0vBDik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535373; c=relaxed/simple;
	bh=0dGTOaXmCHT9NZpE/+vGsWAUidT0E2ucvppgSGZ9Rvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRykPrH/PV7qluFVIGUS8bu/V1uC7mLDDMhB/SdpuAby2tnn6ILjuvlAbEIiYa9SVnZ3CFwWMDRhSkuPE+evJTqdARcF8WJxmBi8/AvLs4hvAIOz778D6Ejy0rJfi8erhD+cqS6S9axEdy4XJlGllmatmYngMN1+714Wsw3k01g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GA2sgwYv; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyV0BdAVrftaaDnTtqf1mImTgKKiu4YUfNY6s/3f6IneTioBLaTOBxTLMyS0EpXvBlFIMmiT5DdsmZhQjlKsP4m/OeHUFFHNy23/+TXNj0mache0EotclqquEy57Q0wtBuI9FZsLfxToEFgHOQ1s+72HZMvTfjOInPCCeNkLmrSqbExztCMVPpPp46odeLkgOBYxVjVIfVytb+UUVACLqDP/24EgEl/LjfS2ij5u2tIovetjk9DCS+sVDKH3C10RO4bL93i0fCji87LqlP3Uaahkk++2xQZz/3TFpHYOIE4AkQsN3DbrQChuy6fMWM/JS40WvB1liwYr1iyyy+xCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcRR1ousZU1GbIQ/nb4zR0ItljQ/fF4EYkA4fz100MQ=;
 b=gYPSmtgqjNyvI/51LcHpGFI3OTwvqfuWn4jW24poo+eku826dIX5jzp4cl9QKYhN1bU2HCu7ICZpkUnpwxEkzSHuxlodtuVb9nlt2csjpsRPo3Ldh+euD3OYBAkiLFCVo/lXpXfoX54AW5UGBKF9B5FOYNr+nOQu+h3Bza+MQa/OHflpiMXhH1PO/nZo8D2XlIwZoLUrck9O8D1uEqzvKLDNvCk7xwlSRGlLhw1UN6d2aG4mslXrHxNAzW+rnM/atQoBAXJAqtZSCTPYNSpaNGyLn4IYgHsQjcGCL7IDaHccKg2OEEDhrKRRbfFZLVzUKd0axweZ1AJ4STG/JaUnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcRR1ousZU1GbIQ/nb4zR0ItljQ/fF4EYkA4fz100MQ=;
 b=GA2sgwYv6RyePcmcWpN4LziCulVJPdNYukjBUD4lha1X1mO37sHkIf1Cc0yoBwhQk4roHg118eeTUBKkFBorEal58MeHZQn+KsZ87fqzyCxBC3YmlFFqj85sUrvEXIT5u1XpV6haJNSR8QlqSaB1aPKU93t9CWMqdcdAb38CFV4=
Received: from CH5P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::8)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:02:39 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::84) by CH5P221CA0021.outlook.office365.com
 (2603:10b6:610:1f2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Fri, 19 Apr 2024 14:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 14:02:36 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 09:02:24 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Dan Williams" <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 1/5] x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
Date: Fri, 19 Apr 2024 16:01:59 +0200
Message-ID: <20240419140203.1996635-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419140203.1996635-1-rrichter@amd.com>
References: <20240419140203.1996635-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ffc03b-02a7-47bf-7dd3-08dc60795e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	en9X1ENfRD2ydp/Bbv88VJhCvXYHF9fPOgtHi6lo41WjpgtWlA2wtv+jGhpb37bwbWYIx/civTatFfW3LE7yjIR0LtUANWTyjJcudIXq/1z/UiLE915ANUb2c3xTRWs2xaCXTrIlGmnZCE3Unl3HOwGcUQEZBahOiox8n8Qnc0rVHkgbt3XDFYBQfByVgfWN3NydWddBpWtSgc9OW5doGgHQCvDK2RdYXRuu/xyL6gAOyElowu0ey4Sg2n9Y3DAPU1s4FpOwp/BEgzXfNKpx+wTwnprk1ktUVVLe4JZ4eRTY9FZwZfj2gURAIfoEM2bczakLT7WD9Zp5jVsK9nsxCNm77B2j+he8s8iC4cMY+ReESu8JlKLB8np8DFMwTgld6uCpfHUgMFx7MaXsr+sJqiJ2ZYu4VpGYRQHZfXvw96FC9i1tpS/dH1LWFEwf+VfawvrxOGf5o+w48vwO2pnD1ElpqoYYN9XmOy9cu+k4I58pbwmDc6ntkqAkkn43YwcfaOOuCWi4hri+9FkfBI2ly5NjZdbG4OklniFicn1bY2tfK9yaTO0fuGxAKK5azpXjoyHny0kIiMbJFjePanerq0yxTsqPBAv5FgGUkebUjm0XF9NULzEqAeU/y2YOyIWxd3M+bAj4MidO7vxdm5VNvuhJd2pcmX7gvSPp9HTwK4aD9wbwzHKwkNLCmHSjFVzW0Pvt9ZBZLFJ32Zx+vuRlNzBwrk6KRKEzcC1+XpXcMeUSb3t1Lhu2Xn7DWkU6RBt3k+EaTi2D1UV8JDb4WYBC3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(1800799015)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:02:36.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ffc03b-02a7-47bf-7dd3-08dc60795e2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346

For configurations that have the kconfig option NUMA_KEEP_MEMINFO
disabled, the SRAT lookup done with numa_fill_memblks() fails
returning NUMA_NO_MEMBLK (-1). An existing SRAT memory range cannot be
found for a CFMWS address range. This causes the addition of a
duplicate numa_memblk with a different node id and a subsequent page
fault and kernel crash during boot.

numa_fill_memblks() is implemented and used in the init section only.
The option NUMA_KEEP_MEMINFO is only for the case when NUMA data will
be used outside of init. So fix the SRAT lookup by moving
numa_fill_memblks() out of the NUMA_KEEP_MEMINFO block to make it
always available in the init section.

Note that the issue was initially introduced with [1]. But since
phys_to_target_node() was originally used that returned the valid node
0, an additional numa_memblk was not added. Though, the node id was
wrong too.

[1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
    CFMWS not in SRAT")

Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
Cc: Derick Marks <derick.w.marks@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 arch/x86/include/asm/sparsemem.h | 2 +-
 arch/x86/mm/numa.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1be13b2dfe8b..1aaa447ef24b 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,9 +37,9 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+#endif
 extern int numa_fill_memblks(u64 start, u64 end);
 #define numa_fill_memblks numa_fill_memblks
-#endif
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_SPARSEMEM_H */
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 65e9a6e391c0..ce84ba86e69e 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 
+#endif
+
 static int __init cmp_memblk(const void *a, const void *b)
 {
 	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
@@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
 	}
 	return 0;
 }
-
-#endif
-- 
2.39.2


