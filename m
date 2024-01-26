Return-Path: <linux-kernel+bounces-40740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D08983E50B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85801F21439
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59AB25637;
	Fri, 26 Jan 2024 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CNhGzjZm"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22A45C0D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307400; cv=fail; b=poSmwpxqcSXrWBe99GvOIdVxbDPVW5oFdl5HmgUhsHFiOUJVR4pyIZB8QH9/CguD11cwTqLPSqDUtshDb7uPgBD0OraIbyoOIPPr+LkMH2Y9uvjWhF8bK6rrXirXU6ZDjNjM/ngIVZ4FwS1BKQyoUOU1+M4qWaAM0YqYnnidtwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307400; c=relaxed/simple;
	bh=pvR9fQWUOImS51FhVQRU+xcGU/pl3Q4BluYPBNhmXgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftc4EBoL9o2V+AdnNAQelv3tYXZz4wCssZwQM2GRBoH8NN/RZBJxBILBpqiLUkZiCvEEqxWm7ruCqw8zFu5mx5aBu3KTXckQWV1fo002jO9FBufVok1h9VJ0dRca1icokXMXtqrh81Vr5ZrV5pXQOjYgTOY0x2lCOtVPNZFiXAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CNhGzjZm; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmaQ0SfVvxgoL0k3Ymv3qd0gPyelwZRzLCGQBdfJRobhkaZlQ0Ni22s0nCB3wqOwdpjwmj8k83HEA79blIWhfv57FPrJl2mg6KDLteHjiqq25mbDtdcmEa4uxqLObKvY94oeKC9Qij70MtcWgG60nqXU2vwRUnmvbLQ0WheDYTxPAZwF6xsYx5wQgCRFrz/xy8uboVMaMORLl22agidb9fDIn2BfqNM7W9QISxZiWaClsRQj19LnmU6E0sa4AZG+u81/Mr8X6V9LQXca3Oz94TFtfhKZJaScMPrKYbadBq56u/CFyK+tCCWsCHEw7w/snxO5Kdu/z2WEYbBcwQ46sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSLugvkcOil97t6MP3bxL1boJ/lRFI+I0MLgG2nrOng=;
 b=F1ZPtouFWIzH1V2Q9x/5EzU+9ezNXikzlzb6ghe4AkmLA6ZeAkXo5AVrJ9CH9zND2i1fNCcHFFLfaRPF2DNjBGx/cQpqChC6UyOt6WHIRMki7ZAKLYQjiLAMyK3kfaRPg7ldSwWfo61sRY2qRR7r1++HZ0zvoJuirtIKpj4gA5BjCvEOtD+j9mqg+VRDDfewgiExRcHCQmo4ZAPg5xzGIG0tEanT/7/mHwjmirV6omJwrJw8w9QD0xL8Sj2GbrpGWZfTX5CRN3fKtCrk46t2Cp3w9sx6F/yk2KsCFWSFhIx3AByBKkKl+dndGFoR2CTHTdQ03lYlr2FBEwxFjQ4lbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSLugvkcOil97t6MP3bxL1boJ/lRFI+I0MLgG2nrOng=;
 b=CNhGzjZm3qR+T+C7pjCJaxOxiCkgpXPG3TX0i4Jpksv1lYANnQwydC2d1UK2dXJI+mwJQhE2wqNYByLAKuhd4CEZmoGSHqhl3ya7bLaewkUhMQZCKhQs8aFRpVFYvNyXXtgs83OoKy0HhXtOCXt3dcLaysfr8kANsAEtUqDdosk=
Received: from DS0PR17CA0020.namprd17.prod.outlook.com (2603:10b6:8:191::27)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 22:16:33 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:191:cafe::fc) by DS0PR17CA0020.outlook.office365.com
 (2603:10b6:8:191::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Fri, 26 Jan 2024 22:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:16:32 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:16:31 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 03/11] x86/sev: Check for the presence of an SVSM in the SNP Secrets page
Date: Fri, 26 Jan 2024 16:15:56 -0600
Message-ID: <190632a07a86c47e7269eeb4f44cdc358a19d696.1706307364.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ba4f19-d8be-421f-930f-08dc1ebc741a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HcXq6gIaW121rUtiPNPn8ChAxtg+oqCm007r7NFVFtlF9IDCpCgJbSmmZwWHDJVqNzgoarVQeG51EjkhfsHFk3nUUpZP4iOoHf+sa3Iudx88SLtxgQXfwHbVUmY/eaGtbwJbEjscJ9K59HfOOi4X9gPL6HU3hl/L2rLbTKJgKTuPZuNUiKGrv5QYwSMnKR4Q0EZJcKVkuDPGdPxA51wo1vikncLNYIOI1GA7GYhbPrwHVLjEQ81Wq9jyioIETWHDt3AFlqPWl3Zd8OYv8qzB2bNEGyvBo5IATSEtrrG6FeQde3YtLH1R4ZUpBY4uT0nts/1//jcZ8ocoDu2HZmPI0V/FGhdYoeGjTZMeWEOZfU9peKcTKwoDRjZN5efCjXQIfbOH7Hx6PugQ5mm1zXcnCyqWBUIzsQyaiw/iV3CkWhsqZlGlGHoYOJwn4UVqZVT4fFIq0piBkElFCy0mk7vz7EgcMhW8Y1zuORKicfU4XX2xzGvyc+sRCFawPWpbJhapUW9rdlobNhOYF4y0vq+sD/eKj9kdccj/xtbTjB8Kalymq8CS3ng4Sa5t9dxFBNnbzkNrun+UdjCPuWuHsMvpqKLys5WfAT50vz56ff6qGcVj9VYnc1Bcn+0nrcXqJ14iKPp6CoujYZCN76ukbh++ubKljVGEajEa/sWXS5Grm8m5qswa1hbAJ6gz3VJAzuEELhmg778SXi/n7kPb9xCpRx8Mp3M+USS0IAvmLRU2wKjN6YslJ1G9j0syMM2Q9V3WY998O3vEbrR6tW/iEebu8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(36860700001)(2616005)(47076005)(83380400001)(356005)(5660300002)(16526019)(26005)(81166007)(82740400003)(336012)(40460700003)(40480700001)(426003)(6666004)(316002)(110136005)(86362001)(478600001)(4326008)(70206006)(54906003)(70586007)(8936002)(8676002)(36756003)(7416002)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:16:32.9570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ba4f19-d8be-421f-930f-08dc1ebc741a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482

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
index c44fa52d2914..5d2403914ceb 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -12,6 +12,7 @@
  */
 #include "misc.h"
 
+#include <linux/mm.h>
 #include <asm/pgtable_types.h>
 #include <asm/sev.h>
 #include <asm/trapnr.h>
@@ -28,6 +29,15 @@
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
@@ -327,24 +337,6 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
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
@@ -472,6 +464,13 @@ static bool snp_setup(struct boot_params *bp)
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
index 5b4a1ce3d368..207c315041ba 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -137,9 +137,32 @@ struct snp_secrets_page_layout {
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
index 1d24ec679915..99170f129eef 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -104,6 +104,24 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
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
@@ -1170,3 +1188,49 @@ static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
 out:
 	return ret;
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
index c67285824e82..7066afaa8133 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -115,6 +115,15 @@ struct ghcb_state {
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
 
@@ -2098,6 +2107,13 @@ bool __init snp_init(struct boot_params *bp)
 
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
2.42.0


