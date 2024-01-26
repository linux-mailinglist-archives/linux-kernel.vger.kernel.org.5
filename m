Return-Path: <linux-kernel+bounces-40749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366783E51D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71E01F23B31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D42945968;
	Fri, 26 Jan 2024 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R9kvv2Kc"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8041C9B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307457; cv=fail; b=gFqpPgjXwMREHrwi6eiPK6dr2jfIbZyRP81UqVmtaAjTkcMuqcVqj4+LkdES//AddJEjh1DPWvdDG+UeBUamjsnt30m/LVCTpYkq/iXPoLMn6z3WWd4C7AhaCx9j5col3Er1szJPe7Y3JniOmF0oZn7YoSvQuF73tPXhFWVRtE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307457; c=relaxed/simple;
	bh=F9Uq61zorLEyRYVf+AcwG/Ld2eqNDwiyh/SWKBADdnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRKRUyQMLIO7Hu/aWz3BNDLwadXqLcQJuX3vwOkTrkptbavXcSuFXhChCtaB2neFcjV+avCa4ZtuMdT6+NVxl0t6CJJdq5+0zffv2zyQe5sG3UcCwIF6XR7c8bYnZSZ4TAYGikAoj8zUtLJ6oGeLpSiaTqnNEdO2+HvpMxGdBv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R9kvv2Kc; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmcSGaGdfLeIsLNABUla75aM6ur5bDRQcuZEUdVOgZ+asgUk5PdEUDdzcErC5ZwhwCRBSAyefJsozB8TvD9AdhaE7+jbdIxnxM+V9y3oGhIqnumiSSt3JdsWENaSgJB1Z6rrl/Fv8NDBRNqD7sgPF4k7vkMe5J04aFHizcNbfWvk0LpwjG/51x7vFVKnD/fyBMRkBBEOcJ/8Vq3zR06mm/5bnnhuRnNCJy2pU16p6yuTehxiLs//myzVBEz1MRA+JHOgV7e2Mbw63XTrF4sti/ydmGrzT3LUuF7xh0OMO900EVLyd/NGIwmzwDbpeOukMG8w746qr2grU3kKjSvxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfvsnk4nOTqvQjmwQKlkw037x589HbEiEY57gt2pI9I=;
 b=ccYSSdkf80iIPumsW9V/J1mfl/nsPY1XQrR/eTs8Xogq2eV9AyjqvDTHsbUKRMsrKvcOdO+w+x+iAp+ZEhbM0GD4C1SezFpDhutm5tXh0/ij5I08Ofvy1BboMuPoozK3fGHccnQAlHjlc037BWwhc558n6hoa9lyrz5Y6eP18iB7ENZJwCEafxlhqd2pzE4TNRCBAc7ylwVIiIJ0jKHuFKM7SIKeuu8hU3KSs28zaWIaeM2ubccyUku3jf2llwdqhdujL2Ib6VgpRlAMF6sHvhRmAXD+U2RT0AgYZ+FfOb1432WnK3Aha/3VSolPLepcZcA8umMD0WcVvLapeCHhRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfvsnk4nOTqvQjmwQKlkw037x589HbEiEY57gt2pI9I=;
 b=R9kvv2Kcja7FmmJ/hXSp8IVr3WeSeIhM1VhbFeRVhCFbeKQj2B4QpNwP+3nbIhx+MBQtZ1bPjVBA12vcgKZnl3PlFa9J5OL0cuzuoZbeNHxNflkqDafn1pK0xmWfXaeKbM9deDgegPhuKOgniBX/XRHNQrAADnKB6NIJFG3q6VI=
Received: from DS0PR17CA0009.namprd17.prod.outlook.com (2603:10b6:8:191::9) by
 SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 22:17:31 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:191:cafe::e) by DS0PR17CA0009.outlook.office365.com
 (2603:10b6:8:191::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 22:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:17:31 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:17:28 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 11/11] x86/sev: Allow non-VMPL0 execution when an SVSM is present
Date: Fri, 26 Jan 2024 16:16:04 -0600
Message-ID: <c5fdf53fdb1aa8a54ceea16b0e1ba158c0835725.1706307364.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1706307364.git.thomas.lendacky@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: a690091d-45c8-4bcd-82b6-08dc1ebc96ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7V7RPHMOgcBHncJX16y4jyTwAVuoqBkGjCgSPdlxIpdq1NNrXtP+h6mKWa5d2sCw29BVcshnC8Ha1vLMwMojW2CEphNfqDgljKduBJC1AfgjEPHTpEfWShTjjDWTrsD8YU/7hQXYxqmUtGlip06G6JSID6+LM2f4ewT7NeRm2GakTQ0Kq8T1VVKSZK1XjwuW6buOevJer/TN6vPElMt1lKwJ5lajXiTr9BUKxzN7nggpK1eRVbvBRj7RtYIJhgxbeDR0Pfwure3Ixaw175wbrOXf6sSFfOtyRQSBi/APc95LpCv0FkUOPstsuDF0rs1C7PVh8cnO2ZSz2t07zTmkXRekoKlPBpmGMoGrZp/mRu3k6Eq5ADP1QjH6mGekisClwWuGJQ95no7hNteRmwbXnpDNnytXNufX2Xb/wkXenCqS0lOWS0NoSRcZRBsY3/GCa7fgwygPLBdIjfB9bgEkm1m/mRTegFAmxRnYg3Pbx4jdBpsl5vAIvXJutSsV8oxqOmg/FAO64J0NEHk4/picmn+aAncQ0tRhZM3Ittg+jrNSCVyOeQqsRVMPgmA++pgjDNqKEeiINLrop14uMbDT5AhdK6UDfYtV1NwoN0u0qQQsAjL1gYSj+b9LjSB+bqZm92A/dxBAQmu2PHx+yVa/X7/5WIlkG6KerSsK7XNfoeqvXaChf6M73TDE+T/uC1BoHSM+Fh5fYV3OKb8SPbuZLsg8v+eLr1iUGXl+nuB6mbdk8YFIouYfgMc02xC/55cUE3xSmLijpOoBMLt4n9qm6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(41300700001)(426003)(26005)(2616005)(336012)(40480700001)(40460700003)(16526019)(6666004)(36860700001)(47076005)(54906003)(316002)(81166007)(478600001)(83380400001)(82740400003)(356005)(36756003)(70206006)(5660300002)(2906002)(7416002)(110136005)(70586007)(86362001)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:17:31.3950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a690091d-45c8-4bcd-82b6-08dc1ebc96ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968

To allow execution at a level other than VMPL0, an SVSM must be present.
Allow the SEV-SNP guest to continue booting if an SVSM is detected and
the hypervisor supports the SVSM feature as indicated in the GHCB
hypervisor features bitmap.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 11 +++++++++--
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/kernel/sev.c             | 20 +++++++++++++++++---
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 3fbb614c31e0..6740f6298524 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -608,10 +608,17 @@ void sev_enable(struct boot_params *bp)
 	 * features.
 	 */
 	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
-		if (!(get_hv_features() & GHCB_HV_FT_SNP))
+		u64 hv_features = get_hv_features();
+
+		if (!(hv_features & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
-		if (!running_at_vmpl0(&boot_ghcb_page))
+		/*
+		 * VMPL0 is not required if an SVSM is present and the hypervisor
+		 * supports the required SVSM GHCB events.
+		 */
+		if (!running_at_vmpl0(&boot_ghcb_page) &&
+		    !(vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 71db5ba020b9..3de377a4e981 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -118,6 +118,7 @@ enum psc_op {
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
+#define GHCB_HV_FT_SNP_MULTI_VMPL	BIT_ULL(5)
 
 /*
  * SNP Page State Change NAE event
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 83bc5efa8fcf..a2c1a28335a5 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2344,22 +2344,36 @@ static void dump_cpuid_table(void)
  * sort of indicator, and there's not really any other good place to do it,
  * so do it here.
  */
-static int __init report_cpuid_table(void)
+static void __init report_cpuid_table(void)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
 	if (!cpuid_table->count)
-		return 0;
+		return;
 
 	pr_info("Using SNP CPUID table, %d entries present.\n",
 		cpuid_table->count);
 
 	if (sev_cfg.debug)
 		dump_cpuid_table();
+}
+
+static void __init report_vmpl_level(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	pr_info("SNP running at VMPL%u.\n", vmpl);
+}
+
+static int __init report_snp_info(void)
+{
+	report_vmpl_level();
+	report_cpuid_table();
 
 	return 0;
 }
-arch_initcall(report_cpuid_table);
+arch_initcall(report_snp_info);
 
 static int __init init_sev_config(char *str)
 {
-- 
2.42.0


