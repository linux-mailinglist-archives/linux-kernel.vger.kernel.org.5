Return-Path: <linux-kernel+bounces-97464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80281876ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350C4281511
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785354BD6;
	Fri,  8 Mar 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GmqLjAzO"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3E5A0E9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922994; cv=fail; b=Pd3AHtlcvOYK9UURV4dvqRdoT8SI3ls/db1aj13oHzlA3ro6OdE5DHtDomprFi96BbGkgimXertUt6XsZ8nmmimKB5ufhUpFsdaz8DS2vRMYBmwGZ5oa4fnFN+m9MhOswnkoRFl9wVxff5W1KQQ4mm55/Td9DpvccVMKVpTI+6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922994; c=relaxed/simple;
	bh=ki26FRMRYx4APUDGv0EmbIj5+aLrGooJV0q7Frjbhg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDksKC1Lj5bp2HrLcanayrhX7NVLuB3R7PB7f82pf2O/s44EfQKNqwLBvB36iAEU5mCoLgHN9yq7T1AQHYmdOw0bO/K0/dmXpUGGNjH4+wrZy9n5k2bdV+ZrGuBo0kg6MUgnyzFlHHghrcI4ft120m0F0JSlc1x9kcDhp2F3c7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GmqLjAzO; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYalLUbduFQwz927eGg2x82o7tEbYp9pUWaXODuVPNEAEwrqIs+IMW8C4NlQD0bLcbiyg+YRn/6sR+5yDjYQ5BWH5wnCnMaijXj7l8+QNGHwbvDYmNsR/T8B134XhVMtNVNryvFEZeGwm+Umqe1nTqr5JmqASzm1gJSQ9mFqtsE6Obl4ry0c7IxmEFWl2YxZXkBHP7XG0a/GgQjjSxCoqNxnuh3Ut3RM20LlWnjimXYqPtEnE7QVUL2Md4nuD2aWBzS71QwH5b12dxA+1JOh1Zy4RGQECIi0J3mjqunGkQxsXR8elNoZvh60Nu0v4q3Yv6sGKjdGx2+twUbUvkgm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsHOU46oR+VevXidgNm7646SuAa1w1uO0VzymY0z55E=;
 b=HvOmemIEQ1lK+xMeS9azBMc/tI5w9a5f8UGwj6PDzXaiwH0KW1xOG1pwVbPLghN2Mt4NobsMFx7LthmmT8uMJqdnXJ3mHgOoGZ+RLnTWllTXiaVpTVQqTNotI4UjlRmtG6HgvYaGZo9yhDYd9cT7isDU/Xv5JDursCcwWxWJKoE0bdq7b3rrz3smtky0dbROgRlulk+RzwnTBGRguaDDFZbiyi4xCdyoPfBdHQFJqLDuoDbzqFNWDb5orA1sM7/4JsnOkb7U+i+7lGtT3BRcaYUlpShkoJM8qEr/aLbaufmUTcVIpLCMhEdlPP8ky40YzZmr4unGj6Gn/IVvrnwdRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsHOU46oR+VevXidgNm7646SuAa1w1uO0VzymY0z55E=;
 b=GmqLjAzOhmtSGdHXlVQHSyY0TswsAJQ/P+3gzkwLbk4IYGdGQ7XoNqcWq0hnwUjTj2RI25cr23BkBiYHNGlCSZPzHbLJ/Ln2lurR2D+c2/U9qgs3J7IXWmI6GaNnUulWVwNhiboKKiWq7VwetpehRzaXvvFUlvvYYzsy/m+1Z5w=
Received: from BN0PR04CA0194.namprd04.prod.outlook.com (2603:10b6:408:e9::19)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 18:36:28 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::d2) by BN0PR04CA0194.outlook.office365.com
 (2603:10b6:408:e9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 18:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:36:27 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:36:27 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 06/14] x86/sev: Use the SVSM to create a vCPU when not in VMPL0
Date: Fri, 8 Mar 2024 12:35:21 -0600
Message-ID: <49039ead4b8e5e3cd923b369fabfccc10dfdb3c4.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: ad35b799-45f6-4821-41c8-08dc3f9eaaa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xMzvLio8nLkidUl6RZlyflzbFQBxxAmTa15zB0M5C60r6CFxmhFfBG3NwtcTUSlX+mslr6VKjXTDkKa2Ry3BIoWXo9ATJ8y7e7Wg2vwfvB46uullQT4F1S26nex2M5tfX4NXyFW8plAWaBoeHt+UhH/LFUx7VeQ4l3x87lDj6gV2cHr6porFry/1KgEOQUUNPNy2we4LUgrnu8dGEY+VFW9f1rHbVf9Qmp3ZQDJoC+ZgDl63VsuoRMnpc0Qyb+jqQNNBAZtkV2rJnaiYwRetbUfcFQCELRl/dYhsaNZO+YXK8bw0nKFkuHAfDgfYhTfXTNW0b7cYeL0viMnAfauVJctVnMGl48WyldpoOfQM5d+vDfMJcewmJ4UiP5u0qVcNsDEPsJHdwsp0HGEklKD5Yrg4j1V6y00YI+tTwrwRp+jfTBnj9wBHCbQSXuNPMcw5OvNRnXF1iSpcPpgFxrDGpg3DxyCd5PfOryhSCGcVA6fuf+cH2gHP29kPiQW74jxN5O50C6mtXkZkkYHL6+GK5PBw+3IC/zB5pTn973AH6GrW8TZ/ExJRq83QYR6RYdYhK7BiKgnksrQhR2032GpYvK+lLvFvk55BEct6yD67LleVB20XN1mR7TaUqwPWKMAOlB+Akys6k7yvuIGxpLyJXU+/WbM/SikUj1d/0k09l47QjNJcxQozWIC6jvVs+PMQWVJHq902teJA5GG5Y5KUKs1c4RwIdGEzRXPN8BumYpyxkrJzbtaGdW0CajCeprkP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:36:27.9311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad35b799-45f6-4821-41c8-08dc3f9eaaa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294

Using the RMPADJUST instruction, the VSMA attribute can only be changed
at VMPL0. An SVSM will be present when running at VMPL1 or a lower
privilege level.

When an SVSM is present, use the SVSM_CORE_CREATE_VCPU call or the
SVSM_CORE_DESTROY_VCPU call to perform VMSA attribute changes. Use the
VMPL level supplied by the SVSM within the VMSA and when starting the
AP.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/kernel/sev.c      | 60 +++++++++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 69c0388ec37b..1a07d86eb9d1 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -229,6 +229,8 @@ struct svsm_call {
 #define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
 #define SVSM_CORE_REMAP_CA		0
 #define SVSM_CORE_PVALIDATE		1
+#define SVSM_CORE_CREATE_VCPU		2
+#define SVSM_CORE_DELETE_VCPU		3
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 288ce45c2115..e11cb61f0d1a 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1016,7 +1016,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
-static int snp_set_vmsa(void *va, bool vmsa)
+static int base_snp_set_vmsa(void *va, bool vmsa)
 {
 	u64 attrs;
 
@@ -1034,6 +1034,40 @@ static int snp_set_vmsa(void *va, bool vmsa)
 	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
 }
 
+static int svsm_snp_set_vmsa(void *va, void *caa, int apic_id, bool vmsa)
+{
+	struct svsm_call call = {};
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+
+	call.caa = this_cpu_read(svsm_caa);
+	call.rcx = __pa(va);
+
+	if (vmsa) {
+		/* Protocol 0, Call ID 2 */
+		call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
+		call.rdx = __pa(caa);
+		call.r8  = apic_id;
+	} else {
+		/* Protocol 0, Call ID 3 */
+		call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
+	}
+
+	ret = svsm_protocol(&call);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static int snp_set_vmsa(void *va, void *caa, int apic_id, bool vmsa)
+{
+	return vmpl ? svsm_snp_set_vmsa(va, caa, apic_id, vmsa)
+		    : base_snp_set_vmsa(va, vmsa);
+}
+
 #define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
 #define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
 #define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
@@ -1065,11 +1099,11 @@ static void *snp_alloc_vmsa_page(void)
 	return page_address(p + 1);
 }
 
-static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
 {
 	int err;
 
-	err = snp_set_vmsa(vmsa, false);
+	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
 	if (err)
 		pr_err("clear VMSA page failed (%u), leaking page\n", err);
 	else
@@ -1080,6 +1114,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
 	struct ghcb_state state;
+	struct svsm_ca *caa;
 	unsigned long flags;
 	struct ghcb *ghcb;
 	u8 sipi_vector;
@@ -1126,6 +1161,12 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	if (!vmsa)
 		return -ENOMEM;
 
+	/*
+	 * If an SVSM is present, then the SVSM CAA per-CPU variable will
+	 * have a value, otherwise it will be NULL.
+	 */
+	caa = per_cpu(svsm_caa, cpu);
+
 	/* CR4 should maintain the MCE value */
 	cr4 = native_read_cr4() & X86_CR4_MCE;
 
@@ -1173,11 +1214,11 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	 *   VMPL level
 	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
 	 */
-	vmsa->vmpl		= 0;
+	vmsa->vmpl		= vmpl;
 	vmsa->sev_features	= sev_status >> 2;
 
 	/* Switch the page over to a VMSA page now that it is initialized */
-	ret = snp_set_vmsa(vmsa, true);
+	ret = snp_set_vmsa(vmsa, caa, apic_id, true);
 	if (ret) {
 		pr_err("set VMSA page failed (%u)\n", ret);
 		free_page((unsigned long)vmsa);
@@ -1193,7 +1234,10 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 	vc_ghcb_invalidate(ghcb);
 	ghcb_set_rax(ghcb, vmsa->sev_features);
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
-	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
+	ghcb_set_sw_exit_info_1(ghcb,
+				((u64)apic_id << 32)	|
+				((u64)vmpl << 16)	|
+				SVM_VMGEXIT_AP_CREATE);
 	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
 
 	sev_es_wr_ghcb_msr(__pa(ghcb));
@@ -1211,13 +1255,13 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 
 	/* Perform cleanup if there was an error */
 	if (ret) {
-		snp_cleanup_vmsa(vmsa);
+		snp_cleanup_vmsa(vmsa, apic_id);
 		vmsa = NULL;
 	}
 
 	/* Free up any previous VMSA page */
 	if (cur_vmsa)
-		snp_cleanup_vmsa(cur_vmsa);
+		snp_cleanup_vmsa(cur_vmsa, apic_id);
 
 	/* Record the current VMSA page */
 	per_cpu(sev_vmsa, cpu) = vmsa;
-- 
2.43.2


