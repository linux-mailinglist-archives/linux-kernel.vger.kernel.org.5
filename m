Return-Path: <linux-kernel+bounces-157278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C058B0F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE70B298EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB7B16D4D2;
	Wed, 24 Apr 2024 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jwnfxq05"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0816D4DF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974362; cv=fail; b=YVepQ3Xpf59ZdRGHCI5ipEypOBiQBXDybrD+J2/txYqLzkB2mduaXPKfyBHqfROdKTK2IJyP3EEPTSK25Tnc0RnXMLLreClEqnyJFxXFgEHmzwqEWs+kv7mdb09ngKumnuiHNGgqqfTp07BPL/v7Jk+tX0iFkio2z+HFeghp8dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974362; c=relaxed/simple;
	bh=g0lvhI16/x1l6lhdM7mujOiwopYTLwY1K46pX4MklJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMLt/ifvglqt+4U7XM1BXrTwloSzrU71bMsdk+jqibtqsv9mbdC46OcgeNQbgMsjOmsCkQKJfscPf/LwRqI22PD3TfWfHUPv8yHpf52JO8BHvkvigoYKAu4OnzDVy4yQ7pcWt8O6N+c1eNxfh5TLf0gAENX6PFNN1x6651FqKZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jwnfxq05; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7sOIXe/WjGWpmxzTYxGvfX0KNs/RtVlWSY96jqjeCaMCLBQ5T0ILNqxgBY1Vik4YHw7FFtIdQBfR/VxDjYOpPyJPhGG3M2N2/OerTtdb1r6tHm0QrIjNWSrTQrwdESi0PRH3APOfFLtWBwyUKpNX05hQIuPs4fl53HGinGkxVV0xhB6VwJlLa+wdE7LKiKsi/VgJPfhThlcTDkox6Pc8v9zGCCFgvdr8eOzXAKrqUIgekh9O+scL1/friQIXD+kue8FMvSce+ezIvrde3eRU6c2K4vqtf4pp9tIfovTl07pt3QYfiomWLwHIfO/P2u3aJRsm61v2rg4kXr/ZOyi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68XD4w4zy2aQ37wXDm6eqki0dDbqxQElwvNiTKlVfis=;
 b=i8IFQT2VjJgMRt06JJsP3NzZ+JTDTaelq/wvPdB2XlUI82ve/o+0AlEWGvx96G6+JkrgDuRdJ7XeRtXVDF7aqG398GIGNePuNIKep88jPbNSwQHpphRTOj/4hu69ZZi8Zhd1NwkNFf4qqXm6SO7Sn1Xg9SxllM3nj0hX03sNa5IH12SyOCow9oZNAStkseXnuZXXm23tsf9tRFtKVXdpXSGvDvo1AN67bXxHJ37oXPExKwnofkAuJsEP8s2rUCTGXwB/v627iN/jA0gEHE8BfiFGU1heeWz1UT/QoKad0BiamwmXKXXz1VkZi8eyfPUO9Fla3dNHf1EUy2OBwzAVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68XD4w4zy2aQ37wXDm6eqki0dDbqxQElwvNiTKlVfis=;
 b=jwnfxq05Ox0vERDUBhG5ARj6QTtm4WbVehA1PGCq+U2Na8h4QSWdKXr1uc34uWZpaOMye4+4L109fLDFTEqWTblcWdEv+RpEUVkuVuvGrRGCjTOPOxQFbdhik2JEnsayiBl+x7LJ5036s3BEuEgtwQjjcuJB0p3ULfXyg7GmowU=
Received: from BL1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:208:256::19)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Wed, 24 Apr
 2024 15:59:16 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::d5) by BL1PR13CA0014.outlook.office365.com
 (2603:10b6:208:256::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:59:15 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:59:14 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 07/15] x86/sev: Use the SVSM to create a vCPU when not in VMPL0
Date: Wed, 24 Apr 2024 10:58:03 -0500
Message-ID: <aa7f311d90efb49dfa6f4589854ee43c049b7b88.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 612b44eb-d6fd-4364-7678-08dc64777e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbB/4X2Rh3aPY7uLJ5Uf5eguMwS4gt4U7cGWC3NqLsjbDhOCt0Jf16/e7Len?=
 =?us-ascii?Q?bI3loSLRwuE/dsH75nLeq3rq4vHXm699D4uRbevqlDYs019sux/nLI+VnQ/U?=
 =?us-ascii?Q?Gw7kuAQZZk6TKvKs3k7V8nD8kINa2aV32NjvhQ9Dul7U299e7tZxmUEWdnlK?=
 =?us-ascii?Q?oX7gRFWqytSoRqv4ZK291eRz3adRfT1UJz7ejvaPsoBARmYQBvYq/dBR88HZ?=
 =?us-ascii?Q?uGoOQ589dPGnX5jDPXL8cTNWyVXojBryJZJtobTtcr3pHSIRKhGfeaBRHSMM?=
 =?us-ascii?Q?fSKltl05vL5lfbfLDKnFj5Nyv0N2iQUNQtsI4qUGpOwz61bhvQgfYeDw51vf?=
 =?us-ascii?Q?whZcNr6lk+GO1xP9OfPS5cqO8M343j+1SI/kI+g9UsgMp6+j5Gj3sAqSnATL?=
 =?us-ascii?Q?VlSyHlhZAQdXSrYVx2wHuMLjtj8uhdIO4buOqBaNMkOjlhN8ICec2HD5BBFd?=
 =?us-ascii?Q?srLWypLX36SHo8R0kZyw7hosBheFWIl+QFeLVD8kyS/ceDpFzX/Qxopr6Yoe?=
 =?us-ascii?Q?Ylo/zT7L66wiJ/uIiyWzUXmAJd6qScUNVRj4boI9WsBHgZDTc9kozGx08ocx?=
 =?us-ascii?Q?eLMvOjZJts3fGvJqZ+19+o5ajsPg2p/ck6/2DzMmO2BsHVZTbqWZGmv1Xgit?=
 =?us-ascii?Q?Spp2ri3wGG8IkCYnw4FipEuBmuRq7Ujb9no0T5fEYbomiQb758v3eZx47UVb?=
 =?us-ascii?Q?+jdZ/uv2AdU/uUO1YufPqqHqpswUa0dfhrBGxRHuxWJQ2RpiMh5+9fpfagG0?=
 =?us-ascii?Q?7ohBhqjVr1qNyCpuGltwuQFuZxMeiJLT4A3unJqi/naPiBvnSRqR0EG0ec3U?=
 =?us-ascii?Q?pT8qN0DHzyQAcgBw7r7/xzaB9lyt7kjFEiP9Bst8CdHyJXq98EAoOiCHrmxB?=
 =?us-ascii?Q?TDP8QOiNdZpO0XhHtzfUmi0ZhWow5zK/cbBZ4dlkA2TUoTS5oquxwo2E7Akc?=
 =?us-ascii?Q?6kj6XzU0gn8HDOin984cUPikU9lxUyufTCwMstslmj8lwlEO6XLALV3jgpsc?=
 =?us-ascii?Q?J9vrOf3Ljj+z2aUtsa7W5U65KB/SL4/FtEGW9shAIvLdILpcSq1yRH4zkIqo?=
 =?us-ascii?Q?wTOLLStUdQOOLfOv3Q7v47W8TzKXIQi8EzmOB4NY8NhawZFLk5H6M8w5Wmb7?=
 =?us-ascii?Q?JMyASsBfwc1ItYtpceyt/8sM1BKwwlMu4JVpcYesRPfw6fNmm+gw205eNJfQ?=
 =?us-ascii?Q?X2SZhIxFQYghqeQVSn7PgxxHuFGThmA+GK8HlvcH5dAV2qh7RbU3lhbMkqoi?=
 =?us-ascii?Q?l6fN9c2EDSoQkXpZcXBr4nDQTzO4dCggWUNhm0EGTXUb+/bqcKj9XQhvSuZd?=
 =?us-ascii?Q?ayLHeFxYA5apKcYJDNgUbrdCTXUI2Plf5I0Pk/j0K+KxcQg1ghqPdp+xsqtk?=
 =?us-ascii?Q?/UiOZiBbHRGN9Hmz98de6nHKyA6X?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:59:15.8324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612b44eb-d6fd-4364-7678-08dc64777e12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065

Using the RMPADJUST instruction, the VSMA attribute can only be changed
at VMPL0. An SVSM will be present when running at VMPL1 or a lower
privilege level.

When an SVSM is present, use the SVSM_CORE_CREATE_VCPU call or the
SVSM_CORE_DESTROY_VCPU call to perform VMSA attribute changes. Use the
VMPL level supplied by the SVSM for the VMSA when starting the AP.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/kernel/sev.c      | 60 +++++++++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e6f1ed3f6ce3..a7312b936d16 100644
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
index 49cf4a6f1f31..3f4342b31736 100644
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
@@ -1044,11 +1078,11 @@ static void *snp_alloc_vmsa_page(int cpu)
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
2.43.2


