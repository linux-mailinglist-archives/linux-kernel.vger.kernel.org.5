Return-Path: <linux-kernel+bounces-40744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2883E512
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD159B21F24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B9C5465E;
	Fri, 26 Jan 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uOmqq04m"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51051C2D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307420; cv=fail; b=BGNadXix+UXV7uj7UbW8ZiYf1eLBxGYVj06Y38iqDWUxPtpnh4U5F9gj6snqShbejliojlOb8Uk5nDTQ6tr4W8LTEKj9Akivv8nyHCTfW9mUaXJVFigLVLAwuzRXKgEaouljk7SiTHjZV2/iIIFcI3RIfBvWcYsuzELIuwY/3W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307420; c=relaxed/simple;
	bh=ckWkCbCh+ZZVATMX9CWYHgNDekKjBfdqCGr4a7aut2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEQKPM5EWLGeWkVHOViefZx3uSBg6dcSrrQZj0Ie3LEdmBeldVZiUBT2zYFq0UU6DZA3nMGyLHM0wOTeGtwMPOycHbwtA9JDIm0coq1Z/XaAB0o1Wf+L7TATvYsjh1imou8wU5LwuOPA7L0UKN8A48WBfPKg/kZYM57xEIASjWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uOmqq04m; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHXMVCBA3NTHd/Gawke86/tgeWb+ydCVVmxQvQ2Nfl6zd14r1BTe+0Zk7JriS6pfjHT5iRch958HX7nXMe+n4wgiZjFs++OFtNOnHSaXVtY6GeAHUpaX3JQ9fU/zJLhpujByJpsr9PLEbnCyFFX/HM8xdrxAhX03C4yR9mlAqdou1cDCjJLEtASiDwI+vZP/Eercp3Xl3MTK/ACZRQg9jWJGWgxgUQnZ0rTJE3OeC9Kr7ck/WTqhtPgaNr8ww7ZPam61izdo7An/TxCnK+XguloSKRLxOdnzzvRAdewWBjE8cYXvTUEvnMMlY4+q0XRfgtnua9ndcnpjigQtjOJBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27n8vr2UIOEyWHE5Xeqq8EiSVBZ3qjjxLrr0LbEd/ew=;
 b=mZFXNElJouKMo9sY+bzI7Qn31wPdXlQ6idX9zv/FmFBKXyRgU3f4i3puxdYPiz2cspheAe5KHAGWAc2cSIXQ2egn6dmHR9KSrOC0lgiehGpl/OAdQl5QCNK2pqzb3i4wt9vPGtwkqHrCvNSEQ/FxjfKJEVSeSPBYC+qOj2cRGykSvoBkXDQ5a+0AxhZRrgXISXp5PjgIC91JPvNrOLkm11Z3Y04ip+7W+/zxbip5X57RB5shagy74r0eBvVA32IpSiduE0r5GtNZ1sDFCLEQ8Zb0uOlr7kaJmpb58gENdsUhb93gThzVo6rW/1Mai/op3q1Hfo/lucAZMljliYUAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27n8vr2UIOEyWHE5Xeqq8EiSVBZ3qjjxLrr0LbEd/ew=;
 b=uOmqq04mVy6Rr2o953OZwYk1h/kFPVJUXUDkj8DulE7/OhjyMldzSHz1Sayng1W8YoBFQsJyzQgl0x2T4KIgIVnERR8Ln7JxnqgQ1etIlCfMa9CwdX5EiiMuj6eB7aD1CIxhgt+cMh3TSSA21+UffnmNEH8D3XzT0pbHBK/QXwM=
Received: from DM6PR04CA0002.namprd04.prod.outlook.com (2603:10b6:5:334::7) by
 CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.27; Fri, 26 Jan 2024 22:16:54 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::28) by DM6PR04CA0002.outlook.office365.com
 (2603:10b6:5:334::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28 via Frontend
 Transport; Fri, 26 Jan 2024 22:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:16:54 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:16:53 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 06/11] x86/sev: Use the SVSM to create a vCPU when not in VMPL0
Date: Fri, 26 Jan 2024 16:15:59 -0600
Message-ID: <bdef30d612044652aafaa82a0abbd81d975fb484.1706307364.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 703fc87b-ce9b-43c6-5786-08dc1ebc80e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7CoN27Wu3PT77FLbEGYLs0LrG1pbxxX6RnLwW/AdLIdfXe83zWnwm3j+5w2F6Lo3pEq1/bskMA+23NaL3Sdt2BEadJHGmE6F/RXQ9VTSG8c0uMMm2PJlu0aTJ22NYX3rSddr3y8E1cycEsptNjNI12BqKcbQJGQUaxNZWSJHR6sc/wxrX1Sovd0nYGxJ8HdijwDZehVcGWA3MY3OxZpLrBUOvapxO+X1BGKqfl+BkR+gvh6Ct3s4TSETWJM9Be+W2dDYEP3TdPi1Q7GtC/w4qOidLA+oVPCAoCGf8J/nMPCrwhx7kABF91xL4bT9GIAvFB0jvhXC4PQC7DGyA3H6myVqcXauHiKO9i1Ymtx7UIPaDm3tVqtWizTfhlBLTW9MMCS6j7ynnJzHULN8fDmnP/KzXFfzW6TIHT+a0AK012JZxjzAE53lU1F9bIl2JRoQMrhuBHr886MgZP+dNwgfu48NM6o15Dx/wRwlTuxvEQOt6y4i2kRsICs+xEGsjvOB3i1pIue5Jj3jNFfGdo0RVdzdYyBaSGjoPm4rs7XCsjqb5/73Eh6ZdvskmyG8ZrqN9Fti87wayVqY87vIQQXdyRf7VuEt6cn+TlxjoZ0tdONIYTTmWk6+Q+uhwQ908IYpZr2g3CIG/UvepgogxgsERe3lCaf7YmKs3zN7nvVSDl3mJ52V04/aoO/O372tgUmAHTRCDxdyP8xWhfXYlGoeGc1haIpHpOdwmc3mkkY+e2n578v+JsnPf5P9j7wmNafC2xzz6Lx4DbdzZpgF0TaTdg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(47076005)(83380400001)(36756003)(356005)(81166007)(86362001)(4326008)(36860700001)(8936002)(5660300002)(82740400003)(26005)(426003)(2616005)(16526019)(336012)(8676002)(316002)(54906003)(70586007)(110136005)(70206006)(41300700001)(7416002)(2906002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:16:54.3756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703fc87b-ce9b-43c6-5786-08dc1ebc80e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072

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
index dbd7fd041689..372bc6183b29 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -214,6 +214,8 @@ struct svsm_call {
 #define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
 #define SVSM_CORE_REMAP_CA		0
 #define SVSM_CORE_PVALIDATE		1
+#define SVSM_CORE_CREATE_VCPU		2
+#define SVSM_CORE_DELETE_VCPU		3
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2fd21090ef6b..ddb9141f0959 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -995,7 +995,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
-static int snp_set_vmsa(void *va, bool vmsa)
+static int base_snp_set_vmsa(void *va, bool vmsa)
 {
 	u64 attrs;
 
@@ -1013,6 +1013,40 @@ static int snp_set_vmsa(void *va, bool vmsa)
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
@@ -1044,11 +1078,11 @@ static void *snp_alloc_vmsa_page(void)
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
@@ -1059,6 +1093,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
 	struct ghcb_state state;
+	struct svsm_ca *caa;
 	unsigned long flags;
 	struct ghcb *ghcb;
 	u8 sipi_vector;
@@ -1105,6 +1140,12 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
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
 
@@ -1152,11 +1193,11 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
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
@@ -1172,7 +1213,10 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
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
@@ -1190,13 +1234,13 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 
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
2.42.0


