Return-Path: <linux-kernel+bounces-97472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB196876AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184961F21C09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F3C5A4C0;
	Fri,  8 Mar 2024 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hVD+w0B0"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285F5D8F0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923050; cv=fail; b=jENy5p3ZNcWDUQgZnDES3G+JFByDaD6gAgGqM8XvEr+2NIxTha/ez4IpWtTp5Tsb6fXcishY1T39rGAzHATFou/w8kRXiyoFc4F/G7oLpYpiXWWoqjFH6IXxzGfNivWlHYFD1Qq9DRXuwJRlJt58AosrTu5FKOSlh8wzVEw5XLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923050; c=relaxed/simple;
	bh=nSKNzf7eEZlXpHL+0K86NQUpzxbg98jMN2qwv5avi7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iexvjoku8wsRAytm+OAb6bVLkB2P+ca2/w2R5HQ+igx5LwPOgpv6D1rKSoJhXyIAMo7yU7fbzocw2yy+3ihzYqUxhBFfOGjsC6bnrhI+z6BPqKhXkMtA+My9lv/T1ssyesm6LzJ+/6AQV8SVDekApLLUY2Cr3X7BPK64N5stqg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hVD+w0B0; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgPdW9AKlLGk2m4m2cug2kZ/eVpT9OGsIasK9Paa9Qq/pOMA+ffOELbDPHvwkx684Z/RQYdc1sAJ++/9QYtiUYqLIIGa1ldFc3D7BjPctoXFSQRuQ6faQUxeWL1qrVGe5Jv+9G5SKDLAJ0fGtrrC77qjpISkQnkWf8eYLxR0P7O5Xe/3Yv0PEi/4R+TDuRZQeqnEYbGNmwee/K4/CO1KBIlGUBOIfvAxAiPWFl0akUV0xZh0q9AMbO/u4rrN4g9/7G1dsT2CqZZYOig5V/iijbVrmpOSN41762/B7RkL4HUd7vDM60p9WH83L2iwu27knqY5s67xYWly4adm5Bn4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmohMvpyfz3WBC1d8yf9fnxW6igZXtWnirj5lGKDJZg=;
 b=S7LJvq8lGdvNI7/gR8brsZecbei16SgKCMK/ERqh1Bjajq3QbDEOMX5UHFSYcZ2GfCtUAKfCGTrrjYhh6QyfqZ4yA7CLAGU0McQ8ZRGbgN/TgB2tsMHCq0TFnah2HOQJ93rcpqlVqvxQE4FjxCBTiFCPzt2GVhKeHkizclhuug/WfyhwwAalcfhKFnMjEbLZopmWptGUrykzMS3BUoYs4fPt1/WYvldEBYeF+iD9l+/EyzIa6osBt6WGFQcg87yPgKGHXtu2Wp3X+P6Oqy5CY/OHVfs7BtY4YZhktTcp7NMbQfF2r1yRF+bdlQcKPL93g5zAlxPFTbzyCer652biWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmohMvpyfz3WBC1d8yf9fnxW6igZXtWnirj5lGKDJZg=;
 b=hVD+w0B00lfNNi/K9U4JB8mtKUVHnK2UbQa2BRRTcZ0a9mVuotGUBFz2DgPawQP3XBBqotmXKmQOa3pzQY8EM/zMVHkDW+Ez86vyXV+Ejf6ch2eh/dd0Jet/7pv2ZT+QLT/oCSbJ3GcSjskXps0LCsyeyuV5lSqcaYa+f5CdFh4=
Received: from BN9P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::34)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.41; Fri, 8 Mar
 2024 18:37:25 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::28) by BN9P221CA0019.outlook.office365.com
 (2603:10b6:408:10a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 18:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:37:24 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:37:24 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 14/14] x86/sev: Allow non-VMPL0 execution when an SVSM is present
Date: Fri, 8 Mar 2024 12:35:29 -0600
Message-ID: <9e38551422f563831476aeb8ca82643fdf3e6cc2.1709922929.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709922929.git.thomas.lendacky@amd.com>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c038d5-6c55-4a40-dd99-08dc3f9ecc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0BqzrhsLrdkjyZL7HKc8c5NDdFPF0l8hys//v9P3EAdYnlSrSqbQZUugiJTtbxaz4UlksCpqINi9U1nEd4JLlSgb/J2DLG6mO1esIjU4Q0k9KUfPJgp80MTllEf0wBrHjdsew5EsbwG6Me5vWNCNGtN9w2F9XeqptKaS48s3Kh05DHZSQywfkhl1ygHQQ4oFawYTlL6v8Xp/PmduzR4laLGLkqM91NuF2j0ute348/ch0DI/YA0N26KT/hqX3WHjF3E8RQrbMl0/LI445cXoQArcQtVe2MXuXC5E7rdyYjb2umnefSpnZkXEX9SJ6bCqLLpWx7mSm7f9Of2NT1wQ53Vacx1gVcp1skSaEIoFWrWAkBbgtun52OBfZzsiefH8epfZ6M7hpCQ4lNtgEesZRChE3JftXqa/Ysq1OD3gFpIpoGbPZFbrACoDrZ1jV8ElZIwm0EBQlZPxLUCTq82ntWtoB4ltwa8OiYWCmkWqjfqq03r1PUZvDBjTnazrQ01MVYFcPMcMD/z2x/q1EKgbUopq/HFr8Z5V9XTuN+4TxgbfiDMqMeL0yos6LXhGoQSCeCdKrpIHILs3085G3vQTg28f1kZXAI2Z9G4fPM1H0QJsY2pgZksmXIrKwo8i3oVUP+5ME8N48XrLoWu2bV4YsMoOMw+onKjPdaRWJ78QdNek6J7cIx3ByqtPoiW0U5xIbOQ+XJzhQhdX5O3iRTp2DT1CWp+lkLDQpd5dLkSH90og5LukxZKs6w6V2yuJaEsh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:37:24.9120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c038d5-6c55-4a40-dd99-08dc3f9ecc96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531

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
index 89143f0aedb6..0f9c6f41caf1 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -619,10 +619,17 @@ void sev_enable(struct boot_params *bp)
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
index 4e460d9eba77..8ae962127989 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2368,22 +2368,36 @@ static void dump_cpuid_table(void)
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
2.43.2


