Return-Path: <linux-kernel+bounces-97462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC782876AC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2643FB22016
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763882BD0F;
	Fri,  8 Mar 2024 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RbLUyWFz"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505357867
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922979; cv=fail; b=eN+d0BGRm1tuvRt/f+74kn/MkfCJkJ2Q7hhTgDLEshJ+4Y2l7jivvJrDC3oyI27NBhO/BQDUprzgoP3ij/2FVZbP3kZ22+A1awSOfo268kridpme9I0KZCtEmaLIEyiPTuu0/M/1QbyLZMBfh/usuQQfJhNDrtxnqGSib2lmSvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922979; c=relaxed/simple;
	bh=4riNp0ipzUQouNjrzCzLJUqpcSwk6cd826uzLFbPKiM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOqhsgGYrX65J5dYls7QZMQck3Zz4slXPRgDRo1vo6YE38ii4mzYy5UVaE3Q4J3VdiPSVTzgOUJUo1xm+B9SwL7Z0Mfq3lQpD8aah30MJ09M+K39OF9ZroShHHCk5eAFFffxOkRoWw0Q/cHy+g37iJQdfXNc/ZYikA8LA/LO1GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RbLUyWFz; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ5lBKF7c5WlvLmtPPzv2dWcSYC1ulZ9Jus7z8LhMe/Gs/+loH75xuXuE4T25I5YRo5EaMEpgp/YAyPf7/lSoyYy94uQVh1KRjI76rhuvXDsG0QePe+1v5BODmvHkblwINxrxpUfizmMXWdRiDg1OdDiWUP0CARQ9Lv91HnDMy94LxeybFUTaDUpNOlrni1qziA5cvwtt0VA8GUizuydDg+nZa7DHZdtIdMy+cLI4Bwd3WH5XZDRENCiVQZJoIXN5x3+Jx90i4RURKZx7uBxMcuSRkkkPRUwfS92tEJVfOYQdBjQbEIkQSvXk9uwNly0rsgkPoAF55xxutBoyL53Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx0Ye91lVGlI1ShC5R4C/4V9kR7SjKBEcUzwWtyHkkg=;
 b=T2CeMqf8qpAtVmxpM8dTf4PG4ncPh59Z66j2qrC+FibnGpq95qTlJ+OmANt4J8UzDSsFck27P9Mt7t3+LUIf9X0xj+mBrZ+VUgSfh7wikghpmSKbqbrUMuHFXkME9fyaqxiBZyCo3dguf162sKHPoqDeXfmHfNnxvFxzwekAKglllYdgsnQ6eEhBUebquJTG3YcXozIbsdEEE7cg9YVp14h1fwBtzHh1x+yYzoXoSNS0Geqbx2+5oD9H9f6xCzkOZsugM1bU9VtmSXxEZMMyc7M6tgGxOCkX714yO+4DOMQSJ2YybWtt6HBB/lOTApZwQN3mqHxfP1zakZB6yQPevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx0Ye91lVGlI1ShC5R4C/4V9kR7SjKBEcUzwWtyHkkg=;
 b=RbLUyWFzhCAF5U5hG9tAAuaX6pm72xe1CBev57854pxC8GebImpEfj6KZo82uxodXSTA2+RyGf0zS8W7yC7j0FMgckkZFKNJJDARnsHXNq2i/qOqzC//cX4VwyUWAcGLqdL2ssFu0qNzEjRHydMl3s8JpN2TpFxwxQ5puAm0kAE=
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 18:36:13 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::5f) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 18:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:36:13 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:36:12 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 04/14] x86/sev: Use kernel provided SVSM Calling Areas
Date: Fri, 8 Mar 2024 12:35:19 -0600
Message-ID: <2fd8d078429ada2c01705f121a5a9e1db2851b58.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a7c9a5-8abc-4577-63c8-08dc3f9ea226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cXdYJJYCCwWv4AanDAD08ldJn/5/0ubD+s5IePOxdmAkbTNVpsZ7vvY9eyB5REgFNUlo4cHiJn8gECYMyfOFlSMtPRfU5bzGYIhJxZgGy1COI8LRmtEnJua2mf5bxDPsdMXSpE2F7IW4rTf1s+60JsTC6uorTHse75DTMsfofEv8L6h8FTYQN9t6z0W00yPjhwYmrZfJcTFUV2nHwtcA63YiboagmSi8xC/ndaBgLsbarDTkvc/KAlHq5O0/ZS8ZAaVvpkN9pgw9t1g8Iz1u6AKFCe/SFO+KGqWHfIbSmvTg0zehbTgDBr9PJ4bf9Ffoa1uWGshmVnqB3MRXcpfBSc7EMCjWjnP/rAVerKM3KWJAHE3lSr9xV6rMrkq8OETUe3sTS+hkRlcwKoZB4h6ud332iLrdUXLXDazqFd+8TtYYFueq8qENDgETywJYTjuPSjqCrJHonFVPdJCMr2B8H2n9+C7uQgBlvPuk5P8wyP1csg9bAtjdM8TjQqWX62umayDDDb4QiL7z90innBCQ8dGAZ01Z2XIrXaw4FbtKHJvD81hmFvoKMJJDm//sppm3DSwnlMsT6EOG4uZbO4PtoP1hut8IS2wJV0L/kr43nmrc5j02USEH9GI0P7simyuLP3FuS/IdFdQ3QB6LnHeAUpgu7cJWErwPIdPojPLlfvBclG2L28Vg5Hrua+eh4bfTzpLxpVlS7XoRJarVnio+L4vbYoS3ktQWp7K9GCQq7ZPVzb2+EpZdoq9Ozsc+tJPu
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:36:13.7262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a7c9a5-8abc-4577-63c8-08dc3f9ea226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

The SVSM Calling Area (CA) is used to communicate between Linux and the
SVSM. Since the firmware supplied CA for the BSP is likely to be in
reserved memory, switch off that CA to a kernel provided CA so that access
and use of the CA is available during boot. The CA switch is done using
the SVSM core protocol SVSM_CORE_REMAP_CA call.

An SVSM call is executed by filling out the SVSM CA and setting the proper
register state as documented by the SVSM protocol. The SVSM is invoked by
by requesting the hypervisor to run VMPL0.

Once it is safe to allocate/reserve memory, allocate a CA for each CPU.
After allocating the new CAs, the BSP will switch from the boot CA to the
per-CPU CA. The CA for an AP is identified to the SVSM when creating the
VMSA in preparation for booting the AP.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev-common.h |  13 ++
 arch/x86/include/asm/sev.h        |  32 +++++
 arch/x86/include/uapi/asm/svm.h   |   1 +
 arch/x86/kernel/sev-shared.c      |  94 +++++++++++++-
 arch/x86/kernel/sev.c             | 207 +++++++++++++++++++++++++-----
 arch/x86/mm/mem_encrypt_amd.c     |   8 +-
 6 files changed, 320 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 68a8cdf6fd6a..71db5ba020b9 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -96,6 +96,19 @@ enum psc_op {
 	/* GHCBData[63:32] */				\
 	(((u64)(val) & GENMASK_ULL(63, 32)) >> 32)
 
+/* GHCB Run at VMPL Request/Response */
+#define GHCB_MSR_VMPL_REQ		0x016
+#define GHCB_MSR_VMPL_REQ_LEVEL(v)			\
+	/* GHCBData[39:32] */				\
+	(((u64)(v) & GENMASK_ULL(7, 0) << 32) |		\
+	/* GHCBDdata[11:0] */				\
+	GHCB_MSR_VMPL_REQ)
+
+#define GHCB_MSR_VMPL_RESP		0x017
+#define GHCB_MSR_VMPL_RESP_VAL(v)			\
+	/* GHCBData[63:32] */				\
+	(((u64)(v) & GENMASK_ULL(63, 32)) >> 32)
+
 /* GHCB Hypervisor Feature Request/Response */
 #define GHCB_MSR_HV_FT_REQ		0x080
 #define GHCB_MSR_HV_FT_RESP		0x081
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 891e7d9a1f66..7dc1e81cd0bf 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -178,6 +178,36 @@ struct svsm_ca {
 	u8 svsm_buffer[PAGE_SIZE - 8];
 };
 
+#define SVSM_SUCCESS				0
+#define SVSM_ERR_INCOMPLETE			0x80000000
+#define SVSM_ERR_UNSUPPORTED_PROTOCOL		0x80000001
+#define SVSM_ERR_UNSUPPORTED_CALL		0x80000002
+#define SVSM_ERR_INVALID_ADDRESS		0x80000003
+#define SVSM_ERR_INVALID_FORMAT			0x80000004
+#define SVSM_ERR_INVALID_PARAMETER		0x80000005
+#define SVSM_ERR_INVALID_REQUEST		0x80000006
+#define SVSM_ERR_BUSY				0x80000007
+
+/*
+ * SVSM protocol structure
+ */
+struct svsm_call {
+	struct svsm_ca *caa;
+	u64 rax;
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 rax_out;
+	u64 rcx_out;
+	u64 rdx_out;
+	u64 r8_out;
+	u64 r9_out;
+};
+
+#define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
+#define SVSM_CORE_REMAP_CA		0
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -253,6 +283,7 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void kdump_sev_callback(void);
 void sev_show_status(void);
+void __init snp_remap_svsm_ca(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -283,6 +314,7 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
 static inline void sev_show_status(void) { }
+static inline void snp_remap_svsm_ca(void) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 80e1df482337..1814b413fd57 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -115,6 +115,7 @@
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
+#define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
 #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 00bb808be44b..05f5367b136f 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -18,9 +18,11 @@
 #define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
 #else
 #undef WARN
-#define WARN(condition, format...) (!!(condition))
+#define WARN(condition, format...)	(!!(condition))
 #define sev_printk(fmt, ...)
 #define sev_printk_rtl(fmt, ...)
+#undef vc_forward_exception
+#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
 #endif
 
 /* I/O parameters for CPUID-related helpers */
@@ -247,6 +249,96 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 	return ES_VMM_ERROR;
 }
 
+static __always_inline void issue_svsm_call(struct svsm_call *call, u8 *pending)
+{
+	/*
+	 * Issue the VMGEXIT to run the SVSM:
+	 *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
+	 *   - Set the CA call pending field to 1
+	 *   - Issue VMGEXIT
+	 *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and R9)
+	 *   - Perform atomic exchange of the CA call pending field
+	 */
+	asm volatile("mov %9, %%r8\n\t"
+		     "mov %10, %%r9\n\t"
+		     "movb $1, %11\n\t"
+		     "rep; vmmcall\n\t"
+		     "mov %%r8, %3\n\t"
+		     "mov %%r9, %4\n\t"
+		     "xchgb %5, %11\n\t"
+		     : "=a" (call->rax_out), "=c" (call->rcx_out), "=d" (call->rdx_out),
+		       "=m" (call->r8_out), "=m" (call->r9_out),
+		       "+r" (*pending)
+		     : "a" (call->rax), "c" (call->rcx), "d" (call->rdx),
+		       "r" (call->r8), "r" (call->r9),
+		       "m" (call->caa->call_pending)
+		     : "r8", "r9", "memory");
+}
+
+static int __svsm_msr_protocol(struct svsm_call *call)
+{
+	u64 val, resp;
+	u8 pending;
+
+	val = sev_es_rd_ghcb_msr();
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_VMPL_REQ_LEVEL(0));
+
+	pending = 0;
+	issue_svsm_call(call, &pending);
+
+	resp = sev_es_rd_ghcb_msr();
+
+	sev_es_wr_ghcb_msr(val);
+
+	if (pending)
+		return -EINVAL;
+
+	if (GHCB_RESP_CODE(resp) != GHCB_MSR_VMPL_RESP)
+		return -EINVAL;
+
+	if (GHCB_MSR_VMPL_RESP_VAL(resp) != 0)
+		return -EINVAL;
+
+	return call->rax_out;
+}
+
+static int __svsm_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
+{
+	struct es_em_ctxt ctxt;
+	u8 pending;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/* Fill in protocol and format specifiers */
+	ghcb->protocol_version = ghcb_version;
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+
+	pending = 0;
+	issue_svsm_call(call, &pending);
+
+	if (pending)
+		return -EINVAL;
+
+	switch (verify_exception_info(ghcb, &ctxt)) {
+	case ES_OK:
+		break;
+	case ES_EXCEPTION:
+		vc_forward_exception(&ctxt);
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+
+	return call->rax_out;
+}
+
 static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 64799a04feb4..c54acc68f860 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -134,6 +134,8 @@ struct ghcb_state {
 
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
+static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+static DEFINE_PER_CPU(u64, svsm_caa_pa);
 
 /*
  * SVSM related information:
@@ -141,6 +143,7 @@ static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
  *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
  */
 static u8 vmpl __ro_after_init;
+static struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
 static struct svsm_ca *boot_svsm_caa __ro_after_init;
 static u64 boot_svsm_caa_pa __ro_after_init;
 
@@ -158,11 +161,26 @@ struct sev_config {
 	       */
 	      ghcbs_initialized	: 1,
 
+	      /*
+	       * A flag used to indicate when the per-CPU SVSM CA is to be
+	       * used instead of the boot SVSM CA.
+	       *
+	       * For APs, the per-CPU SVSM CA is created as part of the AP
+	       * bringup, so this flag can be used globally for the BSP and APs.
+	       */
+	      cas_initialized	: 1,
+
 	      __reserved	: 62;
 };
 
 static struct sev_config sev_cfg __read_mostly;
 
+static struct svsm_ca *__svsm_get_caa(void)
+{
+	return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa)
+				       : boot_svsm_caa;
+}
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -580,6 +598,33 @@ static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t si
 	return ES_EXCEPTION;
 }
 
+static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
+{
+	long error_code = ctxt->fi.error_code;
+	int trapnr = ctxt->fi.vector;
+
+	ctxt->regs->orig_ax = ctxt->fi.error_code;
+
+	switch (trapnr) {
+	case X86_TRAP_GP:
+		exc_general_protection(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_UD:
+		exc_invalid_op(ctxt->regs);
+		break;
+	case X86_TRAP_PF:
+		write_cr2(ctxt->fi.cr2);
+		exc_page_fault(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_AC:
+		exc_alignment_check(ctxt->regs, error_code);
+		break;
+	default:
+		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
+		BUG();
+	}
+}
+
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
@@ -608,6 +653,42 @@ static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 	}
 }
 
+static int svsm_protocol(struct svsm_call *call)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags = native_save_fl();
+	if (flags & X86_EFLAGS_IF)
+		native_irq_disable();
+
+	if (sev_cfg.ghcbs_initialized)
+		ghcb = __sev_get_ghcb(&state);
+	else if (boot_ghcb)
+		ghcb = boot_ghcb;
+	else
+		ghcb = NULL;
+
+	do {
+		ret = ghcb ? __svsm_ghcb_protocol(ghcb, call)
+			   : __svsm_msr_protocol(call);
+	} while (ret == SVSM_ERR_BUSY);
+
+	if (sev_cfg.ghcbs_initialized)
+		__sev_put_ghcb(&state);
+
+	if (flags & X86_EFLAGS_IF)
+		native_irq_enable();
+
+	return ret;
+}
+
 void noinstr __sev_es_nmi_complete(void)
 {
 	struct ghcb_state state;
@@ -1369,6 +1450,18 @@ static void __init alloc_runtime_data(int cpu)
 		panic("Can't allocate SEV-ES runtime data");
 
 	per_cpu(runtime_data, cpu) = data;
+
+	if (vmpl) {
+		struct svsm_ca *caa;
+
+		/* Allocate the SVSM CA page if an SVSM is present */
+		caa = memblock_alloc(sizeof(*caa), PAGE_SIZE);
+		if (!caa)
+			panic("Can't allocate SVSM CA page\n");
+
+		per_cpu(svsm_caa, cpu) = caa;
+		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
+	}
 }
 
 static void __init init_ghcb(int cpu)
@@ -1418,6 +1511,31 @@ void __init sev_es_init_vc_handling(void)
 		init_ghcb(cpu);
 	}
 
+	/* If running under an SVSM, switch to the per-cpu CA */
+	if (vmpl) {
+		struct svsm_call call = {};
+		unsigned long flags;
+		int ret;
+
+		local_irq_save(flags);
+
+		/*
+		 * SVSM_CORE_REMAP_CA call:
+		 *   RAX = 0 (Protocol=0, CallID=0)
+		 *   RCX = New CA GPA
+		 */
+		call.caa = __svsm_get_caa();
+		call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
+		call.rcx = this_cpu_read(svsm_caa_pa);
+		ret = svsm_protocol(&call);
+		if (ret != SVSM_SUCCESS)
+			panic("Can't remap the SVSM CA, ret=%#x (%d)\n", ret, ret);
+
+		sev_cfg.cas_initialized = true;
+
+		local_irq_restore(flags);
+	}
+
 	sev_es_setup_play_dead();
 
 	/* Secondary CPUs use the runtime #VC handler */
@@ -1842,33 +1960,6 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	return result;
 }
 
-static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
-{
-	long error_code = ctxt->fi.error_code;
-	int trapnr = ctxt->fi.vector;
-
-	ctxt->regs->orig_ax = ctxt->fi.error_code;
-
-	switch (trapnr) {
-	case X86_TRAP_GP:
-		exc_general_protection(ctxt->regs, error_code);
-		break;
-	case X86_TRAP_UD:
-		exc_invalid_op(ctxt->regs);
-		break;
-	case X86_TRAP_PF:
-		write_cr2(ctxt->fi.cr2);
-		exc_page_fault(ctxt->regs, error_code);
-		break;
-	case X86_TRAP_AC:
-		exc_alignment_check(ctxt->regs, error_code);
-		break;
-	default:
-		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
-		BUG();
-	}
-}
-
 static __always_inline bool is_vc2_stack(unsigned long sp)
 {
 	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
@@ -2118,6 +2209,52 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
+static __init void setup_svsm(struct cc_blob_sev_info *cc_info)
+{
+	struct svsm_call call = {};
+	int ret;
+	u64 pa;
+
+	/*
+	 * Record the SVSM Calling Area address (CAA) if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM to perform the SVSM services.
+	 */
+	setup_svsm_ca(cc_info);
+
+	/* Nothing to do if not running under an SVSM. */
+	if (!vmpl)
+		return;
+
+	/*
+	 * It is very early in the boot and the kernel is running identity
+	 * mapped but without having adjusted the pagetables to where the
+	 * kernel was loaded (physbase), so the get the CA address using
+	 * RIP-relative addressing.
+	 */
+	asm volatile ("lea boot_svsm_ca_page(%%rip), %0"
+		      : "=r" (pa)
+		      : "p" (&boot_svsm_ca_page));
+
+	/*
+	 * Switch over to the boot SVSM CA while the current CA is still
+	 * addressable. There is no GHCB at this point so use the MSR protocol.
+	 *
+	 * SVSM_CORE_REMAP_CA call:
+	 *   RAX = 0 (Protocol=0, CallID=0)
+	 *   RCX = New CA GPA
+	 */
+	call.caa = __svsm_get_caa();
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
+	call.rcx = pa;
+	ret = svsm_protocol(&call);
+	if (ret != SVSM_SUCCESS)
+		panic("Can't remap the SVSM CA, ret=%#x (%d)\n", ret, ret);
+
+	boot_svsm_caa = (struct svsm_ca *)pa;
+	boot_svsm_caa_pa = pa;
+}
+
 bool __head snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
@@ -2131,12 +2268,7 @@ bool __head snp_init(struct boot_params *bp)
 
 	setup_cpuid_table(cc_info);
 
-	/*
-	 * Record the SVSM Calling Area address (CAA) if the guest is not
-	 * running at VMPL0. The CA will be used to communicate with the
-	 * SVSM to perform the SVSM services.
-	 */
-	setup_svsm_ca(cc_info);
+	setup_svsm(cc_info);
 
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
@@ -2328,3 +2460,12 @@ void sev_show_status(void)
 	}
 	pr_cont("\n");
 }
+
+void __init snp_remap_svsm_ca(void)
+{
+	if (!vmpl)
+		return;
+
+	/* Update the CAA to a proper kernel address */
+	boot_svsm_caa = &boot_svsm_ca_page;
+}
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 70b91de2e053..8943286f9fdc 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -2,7 +2,7 @@
 /*
  * AMD Memory Encryption Support
  *
- * Copyright (C) 2016 Advanced Micro Devices, Inc.
+ * Copyright (C) 2016-2024 Advanced Micro Devices, Inc.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
@@ -492,6 +492,12 @@ void __init sme_early_init(void)
 	 */
 	if (sev_status & MSR_AMD64_SEV_ENABLED)
 		ia32_disable();
+
+	/*
+	 * Switch the SVSM CA mapping (if active) from identity mapped to
+	 * kernel mapped.
+	 */
+	snp_remap_svsm_ca();
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.43.2


