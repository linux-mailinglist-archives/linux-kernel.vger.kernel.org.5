Return-Path: <linux-kernel+bounces-118099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D1488B401
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AA81C3FA24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3387F7C1;
	Mon, 25 Mar 2024 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RC7BqtuK"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A57F460
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405632; cv=fail; b=D/Z1stHsSsIpS61aW7KdRMVZU6DTB3OT81xYCXQXplUvjCDJ+bDKEogkIyaSgZj6OZzgF8McHIfuSdPdEgwA0vJ+JB1OCr9oB4M1ipdnf3q5r5Kt441h12rlxyggbvjHXkYWxVejSh2R8XC7G6Rj+LiyuXyahnQEL9dZ7X1G9Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405632; c=relaxed/simple;
	bh=/KUj5qkMAEtD+t6qHDZiPmcngZT4OhjXs8XrdueYYbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jD4Kx3pW00RZyCW1nR1SXrIESflYpa+NTr0QDpBKrQywdAYtpkeNR/umRB6T/lbfEiWiCQeUJReGb7UE0BNSvOA28Afmlp803cNvsvjA8WjD04Y62STb1DRBsMkQOrFjzJJ3RouPN9rJTN7hvEsFktai5N0LPjA9gJuGHaFK2G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RC7BqtuK; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbhr83X/JlEVlPt72xhYbPanyInCzXr6Myv+g81PD4WjFXGHMrK64knLIvoMNewUni6wILZ0N86UF8vIL1/XVIaknipE7IQEeZ/7wBiaEHPzvgXnq7CCf4NXFEM3K92YKlXICOmAVOlepYm60nYxVv7/maJz6aQimEnqo4Mral5K1bZf8He3lmIXw0wL1gCCbhZQWNuoFwoNXPtzyqt1sJcZiL9miIG3okWEQU2iWNY6whVu5k5wy+nOeDRQ+zD3fqGdMuVhVbNnZOtEuZAER6dseP5BJuV7eBltA0IhuOm4M1ziPQXBJveiaIhvr/MId408DgZvHVvnhTzJke3Z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TDtg9k/dOEDJFCyzrJQCnvaqeVp7dyvWBkPtoY2Pkk=;
 b=iROJqyQKqumPiK2FnPSL5bj+KqO87VU0peouKI/JK+OInjxTgIpGQ3priovB8XjLho7+VhtVTIUiP5oGLZnq6eLAriTTwA4PFQVvaosmZQS3Eat+CUiIphEKXpG0BlQGh5t2e2I4C5BWXAav1vtHPhAMdqpuY6ExyUt6ac7d/rcHAfNhTUZKO8K/Z0Nn1a1xxP2vXig2+5LY6iyOgdXNlXnyTHK8IQYN7749KbBLBFZL9/74TxBB26whGEqOFm5QATeK2qQpUiNkVOptduBg2YgVVgvAitlxgpyXnemKZ7c2a+r9/K1/uY9femO0taV+QeKuUCbvJeB8Le6abiR30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TDtg9k/dOEDJFCyzrJQCnvaqeVp7dyvWBkPtoY2Pkk=;
 b=RC7BqtuKn1g0sCfSnH/qxrIpU0QfczUbsaTyYeyWf+waMi7ZG68QuCMKgJ+U3KbBbR+nFNy2Psjyr1YnteF07W+6xJs7fgWkVXA7QkdoD8BUpuOOaOj/XcheGdlZi48DG9c8PehxZZCKRhWFuuWhI//S3NgI2dfLhpBeR2eK6kI=
Received: from SJ0PR03CA0137.namprd03.prod.outlook.com (2603:10b6:a03:33c::22)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 22:27:06 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::be) by SJ0PR03CA0137.outlook.office365.com
 (2603:10b6:a03:33c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 22:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:27:05 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:27:04 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 03/14] x86/sev: Check for the presence of an SVSM in the SNP Secrets page
Date: Mon, 25 Mar 2024 17:26:22 -0500
Message-ID: <e8d4877f3b7248031931ed193c026c42dd3363ef.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c18fc25-9445-4ea1-7021-08dc4d1ab3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lqG6IaU/z3sMI/iHrIhUTuDZ5QYkid5TfwEHMxDLxNlkGtzPtjIxMkZdoacfc2RsZnMTzkwoxgpWDczJpwAmwOt3H9PnMgWjWNWhddywBreidF09SppPPdU0lS76QPx6P+Lg/LdpgbAq1Y22Lx6B/oMDsG4xM83hrPQmDaTw0MaJIE0o1eYzz3VLYml/FC6En6jHgr70+qMv+ZVX6IfOdcilZgKD9a3zPg2WYh/2gNq1qN4mbGy1I8/P36nas/gc5hamlxUZZrq9WV2jhPYiMo/TjN+o+eh3z2BvpF8Kv1PgfkS3/4Wt6lOi5ZZFyOzNQJzE8RF24T1Jjc/okAziXXsga7MRLerJDm0hICmzK0GwQPHgNpkmeN+Te0GMF9UG/TTs4KXgWxk1pwlUAD1DOCbg6y0kYHXX4AhObcX7nxc8xnS3qyY3zGiEEHpUgaM71F9qRrfvkbuIWH7vScpJ/0Hcsm5fLfEQDbNNveyGf2gCtsPF1kt1CfozbSHBfmG+2/0k8G1DgWfcVVxAev9BWE4yp8I3YSxbJSWpPITe0FppOLWHB+MFkmTEXMcylnHk+andBfMdi1tkrUbqmrPy/9//Yh6r3208McdiURLkRao6Qla2HJXXwXvhn2CTDdT3/sQkgkhdIm/pwQqfVbLXkYhw3Em9z3VfQgA/npnMw66ULdoSfALIe8NunZ6vAHLc5EwRtO1xv1hTyTnUptSHAXcr1xTk+h2Xt7uxCLam6vgA67Uq5MD0p/TRAZCVKmO7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:27:05.6970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c18fc25-9445-4ea1-7021-08dc4d1ab3a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

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
index 49dc9661176d..fe61ff630c7e 100644
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
@@ -480,6 +472,13 @@ static bool early_snp_init(struct boot_params *bp)
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
index 8b04958da5e7..66d33292eb78 100644
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
+ * services needed when not running in VMPL0.
+ */
+static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
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


