Return-Path: <linux-kernel+bounces-118112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E025B88B417
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106791C60267
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D109382D74;
	Mon, 25 Mar 2024 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JzqwUAvF"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1C7FBDB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405713; cv=fail; b=EqirtuoWHirvzIm7oi60y0Eq1lFfHx48HJ/Nzwx5+4samQ1RA/47mqbGiJWdtUrFikEMUGLlML9tOyl23YLoVgIvxZXjWpQMl1K/1Tg7byYB7SE2rIw/DAil9GDtShgn4X/3zbJ8zkq/RtkA8I2NQYLlpAuanEp8EVyfQzfEssQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405713; c=relaxed/simple;
	bh=QQhkyT6QIDBtWGX00rAc5lJs5zR7OM2eIzf1MVq0h60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlEpFyDb5GpHhnKGgcccfbaFg2ExB5JVPzp5KGTC1bo0ihuHcqGSuKA9DUbfIhAWI5/TQCbROQ+FkQz1kGU1MyyNrqSrN37xluIBF8DBfpJDdWbczY8W2UFG4NIiAbypcpOUDasHG8YKk9/7FWsOiCvE7qQxJnorO8bPnxi7qDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JzqwUAvF; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gij8HOA/UzqMiVkTDReBySqKxEvT18/diYjjpRNWJPC/f767X12sj8Jwu69KQp/16ZKxQSKpUbvKimXPwm/4benkYORv6eZrPZaQTFx199vM6j+CojRyZYw42W3yJsqGmh+On/zsblpRZW9QgDfQKdYi7DPCxM/xVz/S+7M+hITQ2I7BTFf9nnYtQzzhBGsczK+TK9Wh6W1nW25JzJ+GQ+hgG49+FeKSCe5nrN27p+9ncNGY872f54mM1TQs2TSN6N06oH5kJZhoIXXhYoNEZe2s9+/N9it1X6wRb8LI4UevvkcAksZnhyj/DhqssTkR8mq72zYDs8hy6pHRqB1tGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyOP7wRB6eRIlMoQiE2Kf+SIeSqP5YrGjG/YA52yKjo=;
 b=JqI4cdi0TXav6X4fxiAXWaTW60ou/MQcqO15ibQDBC7271YWaOxRx6jkhFQdGI+MiT02QsFcbM/MJUB4Ls7g82dZulZHQ/jh+ZHYT+M/TM8K4ohxQAws4RiGcOPC5hPcIUg83qrkG/ZkrnQwLvQWCei7U5MBoQcObHnUi7NTW4lOIIqOSY9HI6Lr1Kdbfc9sSx401ewEeG9IFf/tZsRMB2+sPrjyT9CE7uXzbxjZ0blj47CX8+keLoQNvDsFMziQlrRP0SDR2SH5gM8fSumCdYp+AmbnqPKm4VKHQM6QF1EQnX5bpOYEKLVBd2Z/ihCd8sfRhjCnNefEQrJ1gRSLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyOP7wRB6eRIlMoQiE2Kf+SIeSqP5YrGjG/YA52yKjo=;
 b=JzqwUAvF/wNPGMK/AIc48M/wt+tkJKzZTumGW/oc8Ye9Jo8iP739o9r/63wLY38Q9JLNDJ9xGI9+1JG/VkPCYUbwASd8/O1L5vQdB26FlgY0zyT+Pv65u0BReV7mbfBaW3rnXq0XV8bqq4MzgZpHH+HKtM2issczzTX9qCfTZTE=
Received: from MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::11)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 22:28:27 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::95) by MW4P220CA0006.outlook.office365.com
 (2603:10b6:303:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 22:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:28:27 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:28:23 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 14/14] x86/sev: Allow non-VMPL0 execution when an SVSM is present
Date: Mon, 25 Mar 2024 17:26:33 -0500
Message-ID: <da4c040f10f85610adb0e623b183e51d781b1ebb.1711405593.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711405593.git.thomas.lendacky@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 705f9240-2bfe-4e4c-8dc9-08dc4d1ae457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IWOb9zllJcGUFT1gcnyEj1NulCRvbX612wGiaS2fXUapOGN+ehGsF0nCpEdf9qAKUWqFyVx55OoM36hEUxl5bC03z16CVnX/OP/B6lV+n0crZxrEoYLeh6K4P8pu/o3TJU3Pp74dSZjmId97JYirjWRioW4Mr1bbXjpQmOQ6+c8387hTYyMWrHK5zouEKlAhhG+CZGdUchxgmaeSl0a1SC1Z42xCz9cf11Po2PGfogm6ztjVzeIzRsG6jB514y3X44YEbDLnIM9TQuNxdhwSu2znBxytYonTccpseaZDdFiWsLTBj/qVPiwpTR+Ry0oNLHT8u19GiF2MmnbC9BdKLa8y/0fnezMa1TMPqEf+4DE97SMSpAXIA8zcck32nW8Ffb78j5FQBwaz093qaIaGL+Gh6CQzrodHmuPzkQSgnqS2YG78pkXGBSs2HFBLQnrWxufnQlwacSFok5Teem3ZfT0H73ghFFbBzZmpOBq2figQzGl7Zt3i41toUrh5Db4jUKWxt9++vM9LE/hbBmexDI4JxdTq1hUCICN6f6eIqDalCi/skXXxFbJ23eqWO5V+BrBeRUlAVTlmKZnilU/grnMRZGJzDybbMUQPji4zNymPUqimmYG+B7zXLRkQ1RtRmeuBczVgY7dPPrRRiL97EaAG4nX9h8gcsJO7dqyq8z/rTEpRhr40QsmZ9g1HFubSiyvLbfLscPI8R/unCtcgzybenynNPLcDjuKry1fPt5kqOKKDKQm2Y3+QqDFvtQc9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:28:27.3480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705f9240-2bfe-4e4c-8dc9-08dc4d1ae457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

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
index f8407ee83ac8..974201ba2499 100644
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
index 0a06632898c6..fd3a832c65ec 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2366,22 +2366,36 @@ static void dump_cpuid_table(void)
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


