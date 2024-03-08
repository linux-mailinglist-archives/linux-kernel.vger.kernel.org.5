Return-Path: <linux-kernel+bounces-97461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857BD876AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37291C214A2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C72D044;
	Fri,  8 Mar 2024 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kLND+P5l"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1252D03C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922972; cv=fail; b=eHxgOmNuwCN8ENmTulotmQAvj8XFkKSe6ieFM5t/bjkuwfRyH3Op5Dm7TN2LgJagpxT9y06WC7W/SpDslHNbegh5d3htAbm1HSdaGP4Ald5Hv7WulhZvQXkPzlZsyrNZNqbvX66Yw03krdME/HSS0RHrz+s9Xq/5FVZ3tO2qhTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922972; c=relaxed/simple;
	bh=sM0DJrAsZdPehe0gKbdP1TFsldMB3SeUgoIocCVJtBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqL8bJjD+C3W7ypt9imBeR0gj9gSPzUC8yqHOOsbJ3dnZJI30sUVwXi2lInLV9AO9O+7wyWVjDEL2Apd3rvbDhh4IRR1sZODaY8RTpYF2Y/sONPF3zWVwfzrMg2O21vToEhUecJiCq7w91Xt0atW3jWLfBq0+Bh5ykxOqUel3yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kLND+P5l; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chOEdsfvRkSEocGvu1OHy0LvGtsIyLhsVP6gC4kQQ+9RVpBafRztv8e4ZSuSqisQu8iC8ofO+oH00kDOPRvYPgmdrNs9RygRRff1KV2Oj15k3iSSuSluRvkIftnnHLTYpPy6TaRLLOmvVG+00dl8zr1mPXHL4pAAtNUtOBPLGcsc/5jzGCnJ19eFJ7AKI0t6zSWazdkXbmevPCu+V9eJ57WWSUFuwLQGSMtabNiV4GZ3XVYFCyLP/MsmipXyC2eDuC3L5LjXQpiwVCziGuuSnMKL3jwtdD+BLh68gKapYx24L9YXWW0tjcBroarMmAh3Fr13vt2iJ9w8vmaJyi+jWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPGegpyF+rnRjhAHRiZLbJweMjq1Cll4XE3MKG+rUGk=;
 b=hJBWAxUvRII4lp8STE87U3eaTp4hyYWl5bOKTsIp0WE0KQqtw7dmgd1orqwu5B5q/2zXtCNyatgEbt28aWNGRkKCgOH/ae1ArYFJmMxqZ+rXnpQyPgHTOtAWI9wk05OGyPtMe17fiYHYJcNVlHO9tky5L+Osb8dzVfbC5I49T94SAiRUspJcbKkpClWI7eTjtJdAxGvmBi8DdzTKnsi61M4K5IMK/YpBkWjdDbR0hEGIkGn/5Hs3Gpe4r9IsIS2OSsBWQhE+dtGMpr/s4AWURynTe0yHeFvdW1BWYhMj8oELExxc9em7anf0p8X0PMHoV7SeOAe87hfMOdG2Vrjd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPGegpyF+rnRjhAHRiZLbJweMjq1Cll4XE3MKG+rUGk=;
 b=kLND+P5lwelPx4gYRul9RhW3QDb9sbMIIu86Iy1JOdnLJZunxVI2AeGAMFAq25pA+8RyWBC+mA1tHtkhtjgYtHEl/IR4aWBBilXBtAwIAY6I4eDhxp87E3KH+UsU9ABPEbUJAuEBmdi2tODzLlboYv+3qGVQVYDKDvzl83pjsmU=
Received: from BL1PR13CA0301.namprd13.prod.outlook.com (2603:10b6:208:2c1::6)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 18:36:06 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::3d) by BL1PR13CA0301.outlook.office365.com
 (2603:10b6:208:2c1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23 via Frontend
 Transport; Fri, 8 Mar 2024 18:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:36:06 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:36:05 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 03/14] x86/sev: Check for the presence of an SVSM in the SNP Secrets page
Date: Fri, 8 Mar 2024 12:35:18 -0600
Message-ID: <bbd56ae7a73dac0436fa3af43c06ce3ac2d0c7fd.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ace0411-1acd-400a-4c73-08dc3f9e9dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JOEvw239pv+Q7WEZ3O3CxxP/QAIchtICEctIoxC9xDQf8OQQoeVoJbh2I17Qw69prE1tGnUb2PKS0xQTe1GoT0cg60sP3M5knalCpcNRE8dVoH+v4nPT/2xiYB3yFnReAV+nf0g9Ym/ybxjLGt5VNWrzIYCHoCfvgxxNCEoB7QiLe/FxTHbgUpUZplRDPZgm5L6wu+rjFaKGwWXOYqXuSBJM8vhPXV8tKAAtdrsODPTj5o0JmFEduTfRJEY4mcYEZ1Djomz6RTVT2gjFpu0C4lmK2zFq6meviF+PZTUciz0k4Y1LE6iB/2lv81RZv3/s5qsn+eqLKW9333tCFrE6giHQp3utSJl2PmMY9pNvNb2+M/zYxadwRnTEr3VjbouowiPEdh/aV9I097E7HHq8LRPfp3DxJVPg8olS8KXya1c8Lm7H/NB90/5JKEkJ1AX+6opbYl7EeA+Atme8KBK3I/pPZ8A2JhedjrxNtcE8dbHAspin27z0UyXcKMKiHghn0TsK71I4syOimm251eyA2CYH4sCpLUh5lPimXV53AkUSY8zovNIKjGvk0sGLOsjCjSgNa8SQS1wMe5eVufWX/xEQ1Qdxtp0l53+DnQlHksAxcqWmS4AleHu0C8hxb4ABLwQZHw+TRI0Bi2+2Ybs7Djwg0EY7pDMvK2knKu2BW7AV64qKdlDMsadpvNI3r4DOuKSGUFhJzAIzuonOYG3rXJYIHdWG5+xN+VCoMLnYfc3MDoU/2Qw9fZusffT9+j0H
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:36:06.5273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ace0411-1acd-400a-4c73-08dc3f9e9dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179

During early boot phases, check for the presence of an SVSM when running
as an SEV-SNP guest.

An SVSM is present if the 64-bit value at offset 0x148 into the secrets
page is non-zero. If an SVSM is present, save the SVSM Calling Area
address (CAA), located at offset 0x150 into the secrets page, and set
the VMPL level of the guest, which should be non-zero, to indicate the
presence of an SVSM.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c    | 35 ++++++++---------
 arch/x86/include/asm/sev-common.h |  4 ++
 arch/x86/include/asm/sev.h        | 25 +++++++++++-
 arch/x86/kernel/sev-shared.c      | 64 +++++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c             | 16 ++++++++
 5 files changed, 125 insertions(+), 19 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bd7222aad540..f54c0ceae1cb 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -12,6 +12,7 @@
  */
 #include "misc.h"
 
+#include <linux/mm.h>
 #include <asm/bootparam.h>
 #include <asm/pgtable_types.h>
 #include <asm/sev.h>
@@ -29,6 +30,15 @@
 static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
 
+/*
+ * SVSM related information:
+ *   When running under an SVSM, the VMPL that Linux is executing at must be
+ *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
+ */
+static u8 vmpl __section(".data");
+static u64 boot_svsm_caa_pa __section(".data");
+static struct svsm_ca *boot_svsm_caa __section(".data");
+
 /*
  * Copy a version of this function here - insn-eval.c can't be used in
  * pre-decompression code.
@@ -335,24 +345,6 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
-static bool running_at_vmpl0(void *va)
-{
-	u64 attrs;
-
-	/*
-	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
-	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
-	 * GHCB page. If the guest is not running at VMPL0, this will fail.
-	 *
-	 * If the guest is running at VMPL0, it will succeed. Even if that operation
-	 * modifies permission bits, it is still ok to do so currently because Linux
-	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
-	 * permission mask changes are a don't-care.
-	 */
-	attrs = 1;
-	return !rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
-}
-
 /*
  * SNP_FEATURES_IMPL_REQ is the mask of SNP features that will need
  * guest side implementation for proper functioning of the guest. If any
@@ -480,6 +472,13 @@ static bool snp_setup(struct boot_params *bp)
 	 */
 	setup_cpuid_table(cc_info);
 
+	/*
+	 * Record the SVSM Calling Area address (CAA) if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM to perform the SVSM services.
+	 */
+	setup_svsm_ca(cc_info);
+
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
 	 * config table doesn't need to be searched again during early startup
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b463fcbd4b90..68a8cdf6fd6a 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -159,6 +159,10 @@ struct snp_psc_desc {
 #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
 #define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
 #define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
+#define GHCB_TERM_SECRETS_PAGE		6	/* Secrets page failure */
+#define GHCB_TERM_NO_SVSM		7	/* SVSM is not advertised in the secrets page */
+#define GHCB_TERM_SVSM_VMPL0		8	/* SVSM is present but has set VMPL to 0 */
+#define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but the CA is not page aligned */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9477b4053bce..891e7d9a1f66 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -152,9 +152,32 @@ struct snp_secrets_page_layout {
 	u8 vmpck2[VMPCK_KEY_LEN];
 	u8 vmpck3[VMPCK_KEY_LEN];
 	struct secrets_os_area os_area;
-	u8 rsvd3[3840];
+
+	u8 vmsa_tweak_bitmap[64];
+
+	/* SVSM fields */
+	u64 svsm_base;
+	u64 svsm_size;
+	u64 svsm_caa;
+	u32 svsm_max_version;
+	u8 svsm_guest_vmpl;
+	u8 rsvd3[3];
+
+	/* Remainder of page */
+	u8 rsvd4[3744];
 } __packed;
 
+/*
+ * The SVSM Calling Area (CA) related structures.
+ */
+struct svsm_ca {
+	u8 call_pending;
+	u8 mem_available;
+	u8 rsvd1[6];
+
+	u8 svsm_buffer[PAGE_SIZE - 8];
+};
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 8b04958da5e7..00bb808be44b 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -111,6 +111,24 @@ sev_es_terminate(unsigned int set, unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
+static bool running_at_vmpl0(void *va)
+{
+	u64 attrs;
+
+	/*
+	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
+	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
+	 * GHCB page. If the guest is not running at VMPL0, this will fail.
+	 *
+	 * If the guest is running at VMPL0, it will succeed. Even if that operation
+	 * modifies permission bits, it is still ok to do so currently because Linux
+	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
+	 * permission mask changes are a don't-care.
+	 */
+	attrs = 1;
+	return !rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
+}
+
 /*
  * The hypervisor features are available from GHCB version 2 onward.
  */
@@ -1267,3 +1285,49 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 
 	return ES_UNSUPPORTED;
 }
+
+/*
+ * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
+ * services needed when not runnuing in VMPL0.
+ */
+static void __init setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
+{
+	struct snp_secrets_page_layout *secrets_page;
+	u64 caa;
+
+	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
+
+	/*
+	 * Use __pa() since this routine is running identity mapped when
+	 * called, both by the decompressor code and the early kernel code.
+	 */
+	if (running_at_vmpl0((void *)__pa(&boot_ghcb_page)))
+		return;
+
+	/*
+	 * Not running at VMPL0, ensure everything has been properly supplied
+	 * for running under an SVSM.
+	 */
+	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len != PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
+
+	secrets_page = (struct snp_secrets_page_layout *)cc_info->secrets_phys;
+	if (!secrets_page->svsm_size)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
+
+	if (!secrets_page->svsm_guest_vmpl)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
+
+	vmpl = secrets_page->svsm_guest_vmpl;
+
+	caa = secrets_page->svsm_caa;
+	if (!PAGE_ALIGNED(caa))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
+
+	/*
+	 * The CA is identity mapped when this routine is called, both by the
+	 * decompressor code and the early kernel code.
+	 */
+	boot_svsm_caa = (struct svsm_ca *)caa;
+	boot_svsm_caa_pa = caa;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b59b09c2f284..64799a04feb4 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -135,6 +135,15 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
+/*
+ * SVSM related information:
+ *   When running under an SVSM, the VMPL that Linux is executing at must be
+ *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
+ */
+static u8 vmpl __ro_after_init;
+static struct svsm_ca *boot_svsm_caa __ro_after_init;
+static u64 boot_svsm_caa_pa __ro_after_init;
+
 struct sev_config {
 	__u64 debug		: 1,
 
@@ -2122,6 +2131,13 @@ bool __head snp_init(struct boot_params *bp)
 
 	setup_cpuid_table(cc_info);
 
+	/*
+	 * Record the SVSM Calling Area address (CAA) if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM to perform the SVSM services.
+	 */
+	setup_svsm_ca(cc_info);
+
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
 	 * it here like the boot kernel does.
-- 
2.43.2


