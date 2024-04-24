Return-Path: <linux-kernel+bounces-157279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EC78B0F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257761C235C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50A16D4FE;
	Wed, 24 Apr 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a/Zd+kLV"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135616D4DF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974370; cv=fail; b=iiMgOB8/0zY8/cHm2U4r3JQfWMS+4Svne1HEAfJkfOx0uqlVOZzLtrDZDt6InLApFatR9jqPy6yPtwZT3RDllgE/zXMqTOXISfJT0zbOoNtBoDagEZjZ97DjMm9US7UKaZczK9P3dvcueHjX6DauNu0PZGefpkfzFd4O8bRrqj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974370; c=relaxed/simple;
	bh=JhAdD1wMcgWO6XIuEnFwVsj2aXgmWch6vopvUUiVyyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoNv71HADb4dfFcDwJIlNjynBTTbsAySlH4k8XWObLPoYrei3HogXmHmeAVfO5IyHNWFJHtuFuBoWjgjF7AwLusFerUos4U/z17c3UWqSWpwMMhUQuppO+fMbSWz57cztFXfg27KFl3yagZmqwyXvs/3qHLdgIs3diMI4SX7KFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a/Zd+kLV; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDAVogOjkKs1MeuiNcIgg71JrE4CY+bRt6lWq1H4jvfdR1H7S3Vfir3sdI4f+/m0ZZY2X8gMquy3ASjKEtnm6xwGc6m5hwcfHI5GHcXFc8eqV76gM4se2jLYn9M8v1X531T1rIEL0uJ5LcYv7INX6K50ZBq5UOrk0rkFTu7TDUFZoS+TfPJIj6UkBtQD+K2onF/AVaTl3XKpM93mUZnTuqiP0ehOL/HWEQWWwBiikUCTs+b0DxdcskMsmbd5JqPelgi3CA1I0DW5UAfW2QrBRHos1N3OtVJNgoI6n5K3AJ0O5UdT+RhD0Mton25iI6oJqCpUZzaztxcANatucrm7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K3CwHj8lUBipV0Su0kgRY2TCUaYltx9lZIDJlMISiw=;
 b=Gkz1WMQUZAQDPjsrBG3fT5DeBluhyL6nEwFzYNZ1kad5iO4enC/EMh1oWlbjYORlGoRj84CyCJ66EkFJ021CKa6kikFqBwqt+D9fHeknwu2cdUU5P+/GfddNKeAjgAdo9APWBdBuuhguOt0PO0RdUTHmfNZ/6c5ctwXQnR9QC9Z2pwjytKh4PqwJNU4iM5AfHxM/QoSMkLafvmUxffJX0gZXx5OVl0PKsbSqGi0biSTdcgJEYjcTMB35lUJBtvNgRVkl21tl793O/ASrgpEtC+HwrrQ4slEphxZnTZmOHchZx584rfB9cBIa7lGMEXjW/EOME4uLxoM1QY2Q046oGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K3CwHj8lUBipV0Su0kgRY2TCUaYltx9lZIDJlMISiw=;
 b=a/Zd+kLVQ5Hows3UvJxT0nnkoE2jEw81YTGUca4dOcaNK8i1thHJ8kz/nAbPGNQ10Kg7hmJc39TWaVS7G55fhByZMYP3cZOAQlpQV1PXhEEAQzk6dlF9b9CeNZ6o7VWRRkk7B07cjtdNhrSSBEcrdHNuV8x4R1RdX4gnTA2/FkA=
Received: from MN2PR22CA0021.namprd22.prod.outlook.com (2603:10b6:208:238::26)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:59:23 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::2b) by MN2PR22CA0021.outlook.office365.com
 (2603:10b6:208:238::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:59:22 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:59:22 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 08/15] x86/sev: Provide SVSM discovery support
Date: Wed, 24 Apr 2024 10:58:04 -0500
Message-ID: <0b460ba621d39fda47694332f09301b440619efc.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e670ea-64c9-4117-b974-08dc6477824d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5pG56aI+kruH1sSsb2+f0JLZbXd+HYyqhJ7pMaQTSag/ionZIVPMu0Z01gu?=
 =?us-ascii?Q?cB4r7RogQXw19GPnHGZ+T7FfgHf9QSTLtKR41RT/BjIdv+G/QS3mM4qTskpQ?=
 =?us-ascii?Q?VqN9f+D0vlJKv4Ds2vMapIHJlum0lOOOmwyD8RylxodLKw3/gflWs776nstv?=
 =?us-ascii?Q?wDNfxTW3jWy0A8PLyGeSLxmZjkbJXM8BNBXehrxigo07fQsq2Xh+UK5Z8gvl?=
 =?us-ascii?Q?dLmT4ATxg6Y9mBcFiNu5ieYc8CTfI6wEfUFt1gfFYxDPFQUCZDixX7Itjg+p?=
 =?us-ascii?Q?ZFdawXxMentwO3Y/ox9ZEt3dHcyvljkiYP3S1DHMgVzE7EGnwJCU7Qtyr1EB?=
 =?us-ascii?Q?tjM4/lujZXYrjwRzPJP6GTl7ijhzzz+Fmb/xRDnVRhw16qWocqpeAYY4Yz7n?=
 =?us-ascii?Q?RIFOrZAEPSjsK7s+FHDMhf1FnGyfvLWiIk9lJP4NSjou+dz8mIBVWhn9a5Nk?=
 =?us-ascii?Q?AG3ENxxCNMKr7MKlRvjWCt3r9pQWiAl0asYO4v3fQ7wxP6WYxhpEGwtghZPM?=
 =?us-ascii?Q?SQUEcPfgZ2tt6ObPBPJsw3AmBzb64K1KfNZpfSKHP53cT8Ndtsm5Oovzns8R?=
 =?us-ascii?Q?xyuBJ57Gv/vj/CkrzyV+2w7UpAomroVaJfdIoNF1kiMXwVGfyP9P7TDLFW65?=
 =?us-ascii?Q?cTvJ22oxsPRLeIMdEz99GWR3aKy+TsgzXG3cpvSkBh7IiU849TumaL59m3Tu?=
 =?us-ascii?Q?HEwQM1V+ErwzbSQYP1dEbBxz0v8M6n2zRyK7xpl1AUEtmVB8PdcXSVycsqZb?=
 =?us-ascii?Q?XEKvPP82JGs/n5daSUM/rIJQ2cmKm7USQR/SRHOi2btJK2HnC3gI9+5wMfcH?=
 =?us-ascii?Q?Hb/ccEeZBhVgnQ1QmOUNIMBOXLpO3PjbLtN8fVMtu/fVqn2Vla8R9sxHtx1B?=
 =?us-ascii?Q?7z3aUazbqvpH2pSnCrbnh0G49HmKu7Xs0ATTp/KDtW1XS5vNn0bLzI5jmd6q?=
 =?us-ascii?Q?wnWzouHyv02nKZSI9ZZBLd6hXENES4dTDn9x+jeE59EbPt+O0XajdIw4FCHo?=
 =?us-ascii?Q?ENLnEn4VZTMNLKvr9Uxb4LkMvjiqqUEdY4rg4rviTvNItdMjeJcWvT/jrNb1?=
 =?us-ascii?Q?2dXJQt5FUC/SmtQOY8zZk5z8yB1bEIaIdBv0gSslmiUbNIi+iFXqJEsidv9d?=
 =?us-ascii?Q?1h0UEc3vW5Nk35prRmFg2wxuCtA3ANF41DEIpkvxu2EXUeNfeOjKEYO5mido?=
 =?us-ascii?Q?SCazqm3BCazER+oOnJXtWEgO5V40JB2FdlccOkNl9LlDuSV+XkxYNvqtmXBV?=
 =?us-ascii?Q?zoxBWMvzwm2P9+XgpxmjexazyV1dsv1mpIbBaCzgT/nWfy1luXzooStsnAiV?=
 =?us-ascii?Q?WJmC17FCvT6XDopVgWQimKqZ6yO3tj6hOWK00jwkp5SA3IYRyQb1/TXZYBtX?=
 =?us-ascii?Q?v4a1zlM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(7416005)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:59:22.9316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e670ea-64c9-4117-b974-08dc6477824d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375

The SVSM specification documents an alternative method of discovery for
the SVSM using a reserved CPUID bit and a reserved MSR.

For the CPUID support, the SNP CPUID table is updated to set bit 28 of
the EAX register of the 0x8000001f leaf when an SVSM is present. This bit
has been reserved for use in this capacity.

For the MSR support, a new reserved MSR 0xc001f000 has been defined. A #VC
should be generated when accessing this MSR. The #VC handler is expected
to ignore writes to this MSR and return the physical calling area address
(CAA) on reads of this MSR.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  2 ++
 arch/x86/kernel/sev-shared.c       | 11 +++++++++++
 arch/x86/kernel/sev.c              | 17 +++++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..a17a81b3189b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -446,6 +446,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_SVSM_PRESENT	(19*32+28) /* "" SNP SVSM is present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6eb766c..45ffa27569f4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -660,6 +660,8 @@
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
 
+#define MSR_SVSM_CAA			0xc001f000
+
 /* AMD Collaborative Processor Performance Control MSRs */
 #define MSR_AMD_CPPC_CAP1		0xc00102b0
 #define MSR_AMD_CPPC_ENABLE		0xc00102b1
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b415b10a0823..50db783f151e 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1561,6 +1561,8 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
 {
 	struct snp_secrets_page *secrets_page;
+	struct snp_cpuid_table *cpuid_table;
+	unsigned int i;
 	u64 caa;
 
 	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
@@ -1607,4 +1609,13 @@ static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
 	 */
 	boot_svsm_caa = (struct svsm_ca *)caa;
 	boot_svsm_caa_pa = caa;
+
+	/* Advertise the SVSM presence via CPUID. */
+	cpuid_table = (struct snp_cpuid_table *)snp_cpuid_get_table();
+	for (i = 0; i < cpuid_table->count; i++) {
+		struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		if (fn->eax_in == 0x8000001f)
+			fn->eax |= BIT(28);
+	}
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 3f4342b31736..69a756781d90 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1326,12 +1326,29 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 	return 0;
 }
 
+static enum es_result vc_handle_svsm_caa_msr(struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+
+	/* Writes to the SVSM CAA msr are ignored */
+	if (ctxt->insn.opcode.bytes[1] == 0x30)
+		return ES_OK;
+
+	regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
+	regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
+
+	return ES_OK;
+}
+
 static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
 	enum es_result ret;
 	u64 exit_info_1;
 
+	if (regs->cx == MSR_SVSM_CAA)
+		return vc_handle_svsm_caa_msr(ctxt);
+
 	/* Is it a WRMSR? */
 	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
 
-- 
2.43.2


