Return-Path: <linux-kernel+bounces-118102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D788B404
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C2F2C7DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F0782D7E;
	Mon, 25 Mar 2024 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AjbQXagK"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9076408
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405652; cv=fail; b=E9SiuKUPusyKdAha1cATbxB6DkmEAev5/+lQUDeJvHUsBjhjXcoq+yxaeQqDXsZJ/Aa+9ZiUFdezKL+RiGwmJy7/W/awnIZT/ErDQ0x/IF6ZYxvKBURIMwLX8vwXyuHGHO3Mj+VmQSAtjN1VEadFJFPdPTExkEBHFHm/uF77juk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405652; c=relaxed/simple;
	bh=X2v5cEkAcRCX1dyqyKw7iILJUex4l2tWxy+ANKC2a74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLmAmcZzij4gGB8P/mFH8JMEr+NcWf3eOcQ6jjdaZkXLBp89eHcxxLmbYzqrsy2WuCcO9aen8MM4/RrSkid9/cVC26qHU+SiZRlhDVz3NlE9SzCj7jcfVqgLrqNfXX3IoFFmQ3yFJa6mXH9xg8KymH41LrIoAfQz+4cAQ0Ll88o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AjbQXagK; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB+ldLuD1SxUUoI9qk2VlnrO3Mrrh8OnWpDM6GfTteZ+6ZKGWm7g38cXewo9fTm2cln403U7QDRPcddkmbDAIddOQC8EogM1NvXrLV1DMr9WOjB5kEQNRbpw7J2IhuDbV4qLKLzODHFC3J5JGKQMisEog/X6Hklrfrj9iaNeqmduWFr06jz8fB9q87Yix81hGl35J5W2OtJjWygb19FeP5uoFTOZo+kds87eIsPU0cyK1gowyy3P/GNUucwwK2qxrw1lBlB4dlEKxHdGQ7gIT7uOCVqfhnAqJxee7zKQCMgIdBu9AeMw8bqzIPa1p604YakGLkVBTI8wnB4Wjmjaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDtEpCB9mVaxWH0uRMNOlsWbvRGbagEam0dsVHi1Nsg=;
 b=KrXoGAM9t4ACprDH/Qq55UbU8us/f5NEQs55Ei/LnMxaFp6WghxjHTpEZCwluBEP9GsqnlpKpC5GCam7riuBw1OGJX/tkyVD7ACeJcMzWHA5zv8+8O4msv0JrkHeTah5SbnokEZBsKpU1+orQUep/ngiZbsOJcNVhWKq/Hesb2qFt7c5nxIK4flkJdJdtv8VyflOboXPo7f3MQJzPPWvJ71zIjv2oPbzp+cfF4S+xpK38IlrCUuh1xxwvJpAt2yRVa5MrrnRoVkU6i5qpkE4DY4utikx8wfWo4L3xaTESYLPSwGr7OevNMB1Nn+/nxkIbk8FT2pdF1SxbVpO8dy6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDtEpCB9mVaxWH0uRMNOlsWbvRGbagEam0dsVHi1Nsg=;
 b=AjbQXagKt7U3wUWrdhFlHCWHeMXIDElEft3fwwN/h0fa6tVvPk/1NNWT7fDqm9sf+KrEjloN50XO1ePMkO91vwyszA8DNonISuQorsxbDplFB30mordYyupfzr/0paIoxfb7/IR3Kt5gVoZQ43pchoJ9mZgcyIAktXoGoMhhHjU=
Received: from SJ0PR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:334::15)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 22:27:27 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::f3) by SJ0PR05CA0100.outlook.office365.com
 (2603:10b6:a03:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 25 Mar 2024 22:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:27:27 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:27:26 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 06/14] x86/sev: Use the SVSM to create a vCPU when not in VMPL0
Date: Mon, 25 Mar 2024 17:26:25 -0500
Message-ID: <b91122a1faf096ec89bb49653d7959158a614528.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 63940f3a-ac36-420a-d5ef-08dc4d1ac058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K/oYJ+Lg3W7lS1EymmmSsaqh05kmR6on7u5b/cokpWGDDROfcS5qB8OtGt/8Bw51rZIHvl9szI4gBMtfkPk864HNPjQZIXbwfNhiAa/uTypzN9kVZLkHVmBCYe2O1qKkdOa6xKMdIB5WftHyms2xc+7Je2xcczfKHTsR+GLGHyn4ebxlI9ZBlsxdhVNgRE+HeueV7dasF1oiIx+MyLfTVkPclX275V1pEnffJWzVse+oOP3s6kjdnqkcoYAA0Au0zE12ZiTUuaBAzrgyPtUNEnbNFg2W7ivmzscMothhxk/6Jkb8vHvt89l5Ebk1OQWz0OUm0NYTFRwKWv4legOchLlpuT8BY/X2ZjjKBNx6EcFMv0LMOph9xBxt3RnIaimOlhKjy3f1q4yEqAEgyETBzXS22VQnvllqbXP72rjX/gb+zyMv8GzBTbbVSL/c4gR6mxKXgzK8wl5+eR4nd5rAT2rl9H3dREw4gFu3qH4WGRzfxEAuZ1DkSkaYgeDQxCjMrD0rQ3/ek2i7oofUn/nBY9EiAYVdlZebQxD+/X6rW70O9AIwyFYrrTmZkxDb0VekKgswRhsxbCyPZBwGjcfc3V41hVU3qYvNUUmpNcyZ50z1drr+VzQPtJVxlh5pq9Buxf9DTdcA2InXUJpIsOCepLZHdx9UwzQN1y/uzZjLU94VEmaucUFgzH/dEegSW2RLIo5DeGUKPkMtoGznR2iAZ+QX2L5DJ0vypojkmiHtO2t5ar7Lk14DGvIVdjI0iF1s
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:27:27.0053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63940f3a-ac36-420a-d5ef-08dc4d1ac058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762

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
index 204f0a4857d6..d7be613b7372 100644
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
index d3e182d69d65..ea8b43a0f01b 100644
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


