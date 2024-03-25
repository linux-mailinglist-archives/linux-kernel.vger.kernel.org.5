Return-Path: <linux-kernel+bounces-118104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F6688B506
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852C6B3B20F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026180044;
	Mon, 25 Mar 2024 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mijlasm1"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFF839ED
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405662; cv=fail; b=Slmti9mqwhQqTua2WyxXFRAwJd2iUq66j/dPGlOFD7qYEmm981ujIZ0Xo+ljA+zR/iQwB5tNpzDT4pxAsq9wnWsp7TxxuUe04Bz5tNldLAxaixmavjFYbiaS5+3sAg3M5o3utM757WBD4uZznHuZHtQ/g6GLMB7ZrHeE0XfMWgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405662; c=relaxed/simple;
	bh=+uLA34KELh/HMXYaV67TH/9MLk/g6ENrRMGD+cuI0wc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRdqUD6+f4IeuLXjl/mzLZIZds2KOvcsEZ2HvSpLEWG0KVAKbHL95KUeuyDImgviTbprRlR13tg67t4AA23zLaLFP9kqixwtobPzGD4nohZ19OAHb23Wrsjy0ckXQe3BfpXXkyBOmPlX1cWfpTjur5tcW0epS43rlrQh1XN2kaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mijlasm1; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBY38ccDL97KXm/388pt2Q9OF3EaleemdOYYMc8dX4JNwxUputHGFYInELgz7cEYPA5bHX3eNvDsY/OTEwEq+OapgPr4q7a8ccwZ5JAINf6Q7S5qch5RZQrFoVYVTcNpbaBCDfHy9TIJJ3biWf7kmGRADySq+Hoob9bWfEU8wnVvc6lKQlz302GgH0xhxBPeQfYL8utn30SDBDvQ56feDA16VIYk5o0qJkXpQnMnmtGQsd4QccfIIOcTKk4SY6iVAvWV0jjD7WO0xvlWYtbT7w992l/vPDEdOp/l5wMk8YshTKA60+LBcZ9TMdN7y2ma/k42zBNUjfjUxo+C5of+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzA5pECaIDf87S7AUfWsYLpoq6tLV5uBE0LPeK9qlBQ=;
 b=k1aCNDIT696olwKWAMkMk+ksAqwPvjZx3ym2N7+ii5fWp1StMihlRnBKymfttlPGSef3fPRyB5lg3mgu8lH+UwI18FkoRc8y+5P/O2e+waxT19jxBGAsPU4EByPD+pnu3YbJJ6tL365/9ZziBpiZom/O1izZp7hfBGq0vc465E89CQqm9zX6h0I5g0q2o3ZZ+TaZITVnejgnuGHOSsqpxaosWRWI7ArrUf8u5SYwmViFTK6U1LjfgY0DYO8CtimQK1q1/JjZLfkR3UyyGoKV1pfnr8VYhv8iC2N8HnCenZKAQ5uGOKcKvIhtMCpmsPw97zqOjxQ+//SkERt4yrqj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzA5pECaIDf87S7AUfWsYLpoq6tLV5uBE0LPeK9qlBQ=;
 b=Mijlasm1jUGuN650zGkwxvkugj3Uz4Sbw4bL5ed4Ww8TUTdQt0wIdp11wYmNOC9W6oVdUx2lFTTcmsyTLscKGjbmJ8Z1twQBeaqPUxGSlg69ERGJ1BOVV8ojGldElK3UDzKi+wknMPeomtxwFci7G7rkc18pFTVutUs4Lk9w+E0=
Received: from BY3PR10CA0003.namprd10.prod.outlook.com (2603:10b6:a03:255::8)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 22:27:34 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::c4) by BY3PR10CA0003.outlook.office365.com
 (2603:10b6:a03:255::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 22:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:27:34 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:27:33 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 07/14] x86/sev: Provide SVSM discovery support
Date: Mon, 25 Mar 2024 17:26:26 -0500
Message-ID: <6468ce125086997ffb043238d12a347f77c7a3fa.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 9713a4eb-7e34-4e6f-3e11-08dc4d1ac496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S6O8LaYvuaKgtCXDMuVcDa1XZeLSnlqJBuXvpd/fO9MfTPhGphsmkEec/uDs5F8Rq6Wj8k2n1rW2PnKG13u5wCCmG1IIHo2HjYXk2DtHa7tG9AaQtvZWSoIgIJjVfL2PBXPTTp4WeUy7o0nlA+cmmSoiYblohdctiSAddbbQmhGdocBm47cQgLL3Akg0B9MPYDSVATi5QDF7rkcTgcSOjCtPsYxOe88AEuBcT5ClQ3Qh5TepbIMPVPocjOeGrClDRqlc47AoSRFfd/CUiYTPHOV2mjBTY3tl+SfAj7roDvSDDqEo0On+FiFvALy7HnJCgWKR23NAxJ9uEvhGluV+9RjotLPxx/Cs1zK/tuWr322ar7JjUu1dxKZS4/gmsxfSzW9rtgCmf9iLM7DuhlXiC1BA9J07gVFHy8nnAM1POKen4TF3ZZfXv5bb12TcYrrOTomKO6RI91/cjC41Bd2wH/FF0Q8ecY2MbtBvcydj8IJ8EtRXa1Mcwp8CgTTBhAn4a7qBGyHHz4zJ3M4uU7oQ06nUD4XxMz0S1XAO+mZ5IKoPIennistc94Akta1fp4+aBGWjTEQ62hlvqZsior9jU1N2HkWzMZaX7EIKCA/Dap3pdhccJzJc94x/cAeVkeFIuwW3wqFwkqpal/KOfEsjHr2Ddh2inn7XtlBkobj5p2zTNo8DiU0AfkEGDgeLNbRM+W6KPDC9D0ewHbodm2dhB15PfcI/tewvJjt9Jlw3co0A7jlRK6G1gGzNZkoKKlgB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:27:34.1343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9713a4eb-7e34-4e6f-3e11-08dc4d1ac496
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

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
index a38f8f9ba657..51e7c879f057 100644
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
index 05956bd8bacf..cc4de3379265 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -654,6 +654,8 @@
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
 
+#define MSR_SVSM_CAA			0xc001f000
+
 /* AMD Collaborative Processor Performance Control MSRs */
 #define MSR_AMD_CPPC_CAP1		0xc00102b0
 #define MSR_AMD_CPPC_ENABLE		0xc00102b1
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index e63c0a6eccd6..17eb42c4ae71 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1559,6 +1559,8 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
 {
 	struct snp_secrets_page_layout *secrets_page;
+	struct snp_cpuid_table *cpuid_table;
+	unsigned int i;
 	u64 caa;
 
 	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
@@ -1596,4 +1598,13 @@ static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
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
index ea8b43a0f01b..7f399ea87a3c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1347,12 +1347,29 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
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


