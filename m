Return-Path: <linux-kernel+bounces-97465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63920876ACB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867BC1C2094B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB1E282E2;
	Fri,  8 Mar 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MnQU47O4"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E75A4E2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923005; cv=fail; b=ieYJxiADDVQPltuqD4NwRwjmoN+ssqSpPpNiIbbKBk4Gxk/Ze8XeiDfMv8WqY86in6RBeLTH4QdDb5pVyV9ADIksOn9PyUOlJ0YN8CJjIhLaUcQXwGf7DD+68v3KnfhTJFmE2skU1Q3DTU6fzf4PlwSpctwoJu97V9prc1x36+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923005; c=relaxed/simple;
	bh=l3GxAnE6RHDV6+Vny1GF6HnzEmi4UT1gqVuxCOrJz/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcqnM5nrHkPwnNsUJQ8zzRyb1gguyayk5flx+zNaNxc4+f6oJOHaQ+28a+NVG4YkxcjbLlbHaYNkgtuh0g1DaqEL6JwdWvmam7yVTx4pLrTmb087Gk81+bCHO3CLeue1TlCSTziS/B/RK7ORqzj/qi+l1WvdyPvR78n414TzhZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MnQU47O4; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9/UctM7E/O8d85iCFnvfw4u/3+uLKdZvlKVTanHs3CEeWni5hQORuxa9+AIgZbre67Bg/E2/rsbmHVLLHFtfMKuHrYxd2ZfkDGxrnqYLcR837xw96g0efp3vG71wyc5wpkk3ASzalmkqvgs8JReegh9bVaqy3u55zfTs165bzVDst3u/UNL4dPXApXyKFefsmhOhkFFXeNPxTe7YWDyY1b46OAdKJGmnUaQQ4frNCgfGjxMLutucQ3Xzgj4iiOKgLAurxzKweu0hYEWDoURFFnvuxn8jx6xUrowdZj+SZs03UZuMh9x4c4u/GcMMFupXG9spqiujpst0CXdMu0+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1geKG9bopu54FcunLDyX/L1x7+HUzOPVKoH+TJm9yI=;
 b=KZ8COkLgeyJc1NKg93kCv1l6vZmWcybR/MoppLFGZRJls0nYyFXY1Se25s8H4NhQ+bwqeEXJrFd5QxBl7wKnD0HvztAUVkdk7GhqY8BJMzevW5tC9IMDr5HbrM27SJpteJzxKS9jLFTSa+crc7JmJu7aT7LRUZ5PX7qS31aHUKB3VDQneJhhDuSFg2vyobWBHQEojZq/0AQAfS1iGWZNXkv8zezxKJNqnR9YzRJEptZC2kkwjS7w4F0cRvdcbcLTa/qiZP1Z+7mWCvdRjeKR+/QFI6OhqylHhMQ/EZ1CwqYS9xH0RiIn8S5nlNuMDjqSoY1mM7/QMam3y86IMsRA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1geKG9bopu54FcunLDyX/L1x7+HUzOPVKoH+TJm9yI=;
 b=MnQU47O4h7tYOxDulxHz5Mo58kEWCwDAyuRAP0bm8CP80tSEVUIfvNDiHcSWUKmqQnOOelDGVhQpV8lSdTE3UuhAbS3S2hEOC7Qre9IgLLFye6QAv70ZMgpg0k3hG5udFxby3AxoA26CJ7uOZO9QCtXFO/bnL5EWoOFsOYGcs30=
Received: from BL1PR13CA0327.namprd13.prod.outlook.com (2603:10b6:208:2c1::32)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 18:36:35 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::aa) by BL1PR13CA0327.outlook.office365.com
 (2603:10b6:208:2c1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Fri, 8 Mar 2024 18:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:36:35 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:36:34 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 07/14] x86/sev: Provide SVSM discovery support
Date: Fri, 8 Mar 2024 12:35:22 -0600
Message-ID: <80fbaaba88d07541bed458dc01d12cdd6623086e.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 1121bab6-7647-4c3a-14d2-08dc3f9eaedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y426uIUDCKjA9XGB2F++L84OWfinY8YaENtjatwp24AK94tpp1IYhn0cEd47ABKYnyYtbMksWQJfTDWVp4ww0STWkCoruknd7gmj0Ph3sJWouaIs0n4MiyvXEDxYX4GfQg4UiHHgKDK+nEBch3hpHg5ESV0CbW1WcrQ0ANvppuk/2FENLwDLtuYxrW+BykGt2kphGNIEyLfBmR8BIDPcWs6UtQ7NConvS/rjrWJbJgwrYXWRYYOv3CM2rDIzzd3VV5k+YtLRRMGRPPrbjn6h6VyX50qTOJLPGtka5FS0GKDUAeH4ZVPK/P/Xh+B3x8ulFvuUXWxL6M6R2XQjHELCJcI2kT+CYGUqCDsK1rn7NIg0hPXMKszhhF9jncdGql2y7ydwMbHOW5eBWt0jRkyPFjIuzj73axl9MtAhTvlc6MNCdJep0TiypLk2tVYCF7H1dj4+W6w42idh9sKsiE+T7p1T+KuW0eOr7jfm+tawnH6W6oLWwrM8E+JV4i7LIgbntxRh5ymk+44GxZ/YG5DQaSXhUvJSfUf/qs/O/zqaWvMaLuxlfWl9ljAFYemhHlBtAlvi8q6Is2FYOk/b3O5SMYG8IaUYQkZWZkb85ZkVUD2SRC0gHLjIA5wJuKKyqknx3n05i7CdbEoehNtYq2zMZ51kpbuR44mjZm6aTJW8jYXOuQW5h+6kD2wj0uTTZbMZkwu9Lwq0B2kgbbSwkHqt8xFb49jFET5WFkjwrnE4D76hftudlsIXJWg+7yt4kVfD
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:36:35.0275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1121bab6-7647-4c3a-14d2-08dc3f9eaedb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

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
index 0343caa016a9..a07ce7b4ed0d 100644
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
index 24c575cdd6b9..7464f7ae6683 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -646,6 +646,8 @@
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
 
+#define MSR_SVSM_CAA			0xc001f000
+
 /* AMD Collaborative Processor Performance Control MSRs */
 #define MSR_AMD_CPPC_CAP1		0xc00102b0
 #define MSR_AMD_CPPC_ENABLE		0xc00102b1
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 46dcc0af7d4b..07ad088337e1 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1559,6 +1559,8 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 static void __init setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
 {
 	struct snp_secrets_page_layout *secrets_page;
+	struct snp_cpuid_table *cpuid_table;
+	unsigned int i;
 	u64 caa;
 
 	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
@@ -1596,4 +1598,13 @@ static void __init setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
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
index e11cb61f0d1a..b85f1b455eb8 100644
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


