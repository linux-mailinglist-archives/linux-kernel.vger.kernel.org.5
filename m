Return-Path: <linux-kernel+bounces-157288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA28B0F54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA5F28778C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD66F16E885;
	Wed, 24 Apr 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A2fLWdqM"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A516E88C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974423; cv=fail; b=bF6KXpgXBks/EZ4myFaJsRUYurlshStY9XeyX02Wk6f7Lvy3KdsDhvwFWvPQls1wVX9e7nyVKY7gTMHdXLGBqIGGDAD0BMmgNgt4OgPmd5J6JUSxtGjB1GU5lpSecdInk5RPWjVUm7tFx/SbXNVADRDeztfQ3z6iUCNM/rCWX1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974423; c=relaxed/simple;
	bh=+38lmpMDTgZ2Niu7oLxh2G+nJKe19ji5QylGc4FUHaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pW5GmD81GcQSdwjyEmwgmKgMy/35yQnIM5rxomKbuuKSJggwFSJCtWSlc/ks3tcRzo/zlH5V3CxwHT4/tHzmH7O4YgbrHHphovIdHBCaS2Es0Z/jTBvczjqQb8U+5m3Ep9AW75UbMzUiYBCffh7yzLvvXoYijs8yiRfQerS/LoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A2fLWdqM; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZiE4/BiG9Z3lkvb1ZReoap9OKj24kK4bUaZU8DNsv8l5NeelHkdkhzFLiraGwmtJ/laUawwME6yIagwpnkY5W5YaT3o5AaPBTtfZ5BtxKkGBL6QqtNIEqjQFXpgfzQPdaRiwSGDkTgSFXlZ8OtqK3rnJ1BFbluNgxlf0c+duYynccY3sBp+k9mHqY/bORJ+r+HZ7dUdxKDnu3J59CattJJjlGabaPERN4lX2N9Xyl1P6H5jGfykQoR5dW7afe1QkQcO1CM+FXVJH6M/ZZIVJR6qxIr3ilSQvreLOCiTTZyVXXvgQk4z43SDq//wqqeWywnRqkX6swKfuHmoR+UNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC6wYJAT7yq+DcXjqFCtejixHwkeemgza4tXTDKb0Hw=;
 b=VsE+ur5/TVQ0uSqHLpYP+HlEAhD9/xl+sFAVtE/OEpfNymZp2gUdCX6Uw4uPZKHT9k5RS/Sa4IZ15VAo1szeuQddsWTpkurL0JZNZksfDDi9gd6FGomINcyAdf2xgpII/aoI4H3EJEzlUnwRsdGrRweOyfJUrO9PvnuAEzW/9TI6rrWNQ0FMwFc16NGLMo+H5VnjbnPXWhsb7Whx70gDbsayHyRh8oFvRMEzE9JH0m/n5kOf3BvqfktQmbCy3f3x6ZryjX9T+ZeSbUH5FfLZti8SK2PE90cbdAgQi/8CGdnTFF2TliEGVcHv75OUbAebyUWD8iI80GwJeFeSBhfZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC6wYJAT7yq+DcXjqFCtejixHwkeemgza4tXTDKb0Hw=;
 b=A2fLWdqMVAD7JNJoL0XWK4fD3+lHBWbTi8ogXQzFLwJLTHUGL0ks5OQ4nw9eIQ6b4WFABH0fP+L9ZsCzGkNXJ5fHO5refMA0yuhdrc1HHsjLlQHrcmgCiM/ZeSQ5YoPnI+YCIcM6AaSEjOi4vi9yPwb1mIiCMEUVKOc37zmsmsI=
Received: from MN2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:208:239::15)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 16:00:13 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::6e) by MN2PR08CA0010.outlook.office365.com
 (2603:10b6:208:239::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 16:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 16:00:13 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 11:00:12 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 15/15] x86/sev: Allow non-VMPL0 execution when an SVSM is present
Date: Wed, 24 Apr 2024 10:58:11 -0500
Message-ID: <e377d148acac799f6905fc544fbb8bf2ed76e078.1713974291.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713974291.git.thomas.lendacky@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: df11f22f-7735-410b-7a31-08dc6477a039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SvnuNda6EsdiMhvpFvgG/XKYbaVoZhFIPBw9HzVQ4L8RzOYXFoMDUP2YKmBB?=
 =?us-ascii?Q?p3Dsm+KNblMGLUXDHsvNdm0y4gMMV1p6LkDpeuFJcZ1v/7cvuplLCFwXt1Pd?=
 =?us-ascii?Q?/uwm3i9SLS8i3bUh5JTpECKTLzwuJnyyM0FH7LZF3tg3CLciAjO31LpIKRiz?=
 =?us-ascii?Q?mSm/5f0SHB/CvHrKsl7EiXVeDoQFkUdxDjuio23wH+VKKlmgRMNcLG2mF8xr?=
 =?us-ascii?Q?RPBXWtLnbokeMZbrP1CnnoEpsFeZAULOszMKXl4Ypg8gPG/E9Lr6VlTSTeKk?=
 =?us-ascii?Q?oKGvyEwPb0TfGuyb3zmmYtSA3n7m3zpZEWtvPzHJMY1jSbM4QrsrPO+VfKvo?=
 =?us-ascii?Q?qAca0A/4D+CJ9jTtBykTEriSKXZFyyrwjpWw3Gf7q/UE6nClSAvsfz1HHOjw?=
 =?us-ascii?Q?WgBfccUwdZ2bDRpgA6EvwhN5ICDZfne/WXYS8X5qkPO4XHQNCSYLDrWNItcH?=
 =?us-ascii?Q?ve9Q6BOgI1rmhb1xoG4UjJc+UxdIAAOkD64PY1dnNZrcCVTO1qgTIDx5TPPi?=
 =?us-ascii?Q?Mw6TLYgHZA4ZEfKCqZWAOEXHqnmvAngoDQD5uFJsG9zZs/swW6R3/F1KLy3H?=
 =?us-ascii?Q?7DlEm0wn84J62MZQ0g+hAT2uSPKa0duj3pbmeFvPuNS86fW2ICxr+kNC1A2X?=
 =?us-ascii?Q?JP4j0liaN6nxBnYYlqKL7DOjb5P4CFzJqLWdg8gX0+0DEbADalizospLvt26?=
 =?us-ascii?Q?xkHbymn5C72x/gDD3tgHoecd17lpm6GUZM1Lr7yPNyjmH7v8KB9afXVWEW2G?=
 =?us-ascii?Q?yGc/GDCA5Y4bbPau9Oc12ZrQn0GFR4GtMOQ13ZpbgClvbaehl8lL0YvAM9iD?=
 =?us-ascii?Q?jXT95jNcXhytNdnsXuDqm5KSiQCw5BVUGjIMXnTuvsEHOrIOYvQV8L1sIER3?=
 =?us-ascii?Q?KnGQXmj8aAOh/JsPVkjt2U3m+zR80KCxiBJuWuw4qsjrJY8hs4repXGv0O9p?=
 =?us-ascii?Q?QN6k2JSyNGwEEcFe1pvhQuSnfkEUjS6ruiSt3JHGmwpuC6Y1WEj2KYBhm99z?=
 =?us-ascii?Q?7tlhdXNWjHrvBOTAA0hJgGQiYH+12lkqaemHhoV607+IRET6jQBDNXLlNbS3?=
 =?us-ascii?Q?FIA9WaAnE1Piac39gi+kpNtWpVJVAp4Qkiy4ISb4Fn/QrJNZK8Ub04fj0lJG?=
 =?us-ascii?Q?KZY42dhRYGTW5lVW2DEFcSIBhxNYCvKoQVpTL1tN6ZGsHOJysD1N+yUPVI/G?=
 =?us-ascii?Q?P+iITkSop0PnnfyzAMmvvwQR8YeWFFdoJd3SXXSOyfO3O6E+SxZar1yYlbeC?=
 =?us-ascii?Q?SzdeOC9ZS9EasdbjiJMLKzNJxj8b8nPF9Sa+s5Wfl2oKMZuMhGp5F3fjc638?=
 =?us-ascii?Q?qpxLQGDReCPdWWQxVn9lh4roIPHjYHTJdotp5aHAABaiRUj2+HBs3snVxyHv?=
 =?us-ascii?Q?oeynzqwQHADowykIoppY23AkDgpr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 16:00:13.1306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df11f22f-7735-410b-7a31-08dc6477a039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898

To allow execution at a level other than VMPL0, an SVSM must be present.
Allow the SEV-SNP guest to continue booting if an SVSM is detected and
the hypervisor supports the SVSM feature as indicated in the GHCB
hypervisor features bitmap.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 12 +++++++++---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/kernel/sev.c             | 20 +++++++++++++++++---
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 32a1e98ffaa9..fb1e60165cd1 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -610,11 +610,13 @@ void sev_enable(struct boot_params *bp)
 	 * features.
 	 */
 	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
-		if (!(get_hv_features() & GHCB_HV_FT_SNP))
+		u64 hv_features = get_hv_features();
+
+		if (!(hv_features & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
 		/*
-		 * Enforce running at VMPL0.
+		 * Enforce running at VMPL0 or with an SVSM.
 		 *
 		 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
 		 * higher) privilege level. Here, clear the VMPL1 permission mask of the
@@ -624,8 +626,12 @@ void sev_enable(struct boot_params *bp)
 		 * modifies permission bits, it is still ok to do so currently because Linux
 		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
 		 * permission mask changes are a don't-care.
+		 *
+		 * Running at VMPL0 is not required if an SVSM is present and the hypervisor
+		 * supports the required SVSM GHCB events.
 		 */
-		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
+		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1) &&
+		    !(vmpl && (hv_features & GHCB_HV_FT_SNP_MULTI_VMPL)))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 4cc716660d4b..7a9d09458989 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -118,6 +118,7 @@ enum psc_op {
 
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
+#define GHCB_HV_FT_SNP_MULTI_VMPL	BIT_ULL(5)
 
 /*
  * SNP Page State Change NAE event
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 5e71c94b952c..50754cc45161 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2356,22 +2356,36 @@ static void dump_cpuid_table(void)
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


