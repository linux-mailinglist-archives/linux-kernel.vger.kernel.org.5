Return-Path: <linux-kernel+bounces-118101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E6088B402
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5732D1F66CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A151976417;
	Mon, 25 Mar 2024 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0gHTaVQZ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0A73175
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405649; cv=fail; b=O+OxAWgoWS86XNwRg4rBi21Toa09F7JrDgRfXTsOB5dMpkyWAozc1W/BMseI3+DZzPqeZFRV4HXvMfHwS7gjyy5228L3dNS7Zh0iDYpbyvgJDf/fCf3rQD1dsPyZiXtSCwGvgE/Gb8RiH78Q5bIMzkYvgmXFQEW1/ZTE0QdU3xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405649; c=relaxed/simple;
	bh=xgZ9oC/wPG6vU4Kjtv6sCsL4G08D3NrdT5eDTMyX4ao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzYwinC36V3beY6UKp/tQ0hz9HShXL9d2c/g8DJqxqswjYA+Ar9nK1mpTvQ280JR99qE7t4JQyCSwIC8FVeI0ZGsFHZzPh5g0kCRAZIF6k8pLPHFbrCQeeNwhR4Cfz6oGs+hwSlwUTN4QpQ3mdCjZtHmO13JqFAVbMwNeiz+alk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0gHTaVQZ; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9XdD4LTsiXNKoDNQQZt578bHB65MVBgA10A6+iNyyiUIdy9kaEEIBdEKGUhs/FBXH6JNio0wOpTgn91QuyKbPOZO5gIowqzpEt7CMkSVqaxWPVVxQA9DWgaaj3oHqxLrKAyrL62eqKyj06AqAtvVCKMbOnsHkgKxco+n+glL6i3VSROz/Sl49xfOTy3s5JFEhMZ103RzBADskUEF/bG75R8POVLy/y37aBo2KB2RggoTYNuPNnMWyy0RAFD+VYgie9QyxN1KM3ZsrHnukWikfFbj1qvUN4fH4Nb2QSeYz98MBEuoWqVDiqacVVf9FoErBsv6NOTFGH88GZ5hG/Sow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQy/AAAIqsf19LIMZDnbL7cJdKBhGNCP0aelG2Ws77g=;
 b=WMoxoE5iGtcZ9XXJAvFaBle5Lpgt6VQ1uaHVvGE6nFBysQrwGRa54UBScMgqNioy8iutoa0f6C2zBx0a1uWinMzPx5yXNEcbt6bO24ymEodYzXjrFzg/8t3XV+ko7kV04fGklaIhuv96FkPyEQj1WMoc/v2awNivJJ2uUO5a6tU4+Nq38ekA5FbCKfdJogSb7e7BAoTaE6fOvFYLZuwCIIypZkASrVtLCSlHZBJwObIuyOABuHl8jUUclO/lttwuYfv+s8RjWZWI/oy9LfHHK+chylAPNdOWdW2XN8XSibmCBPEGEFVKsC90P5aoxY+2TtJyOsuf+jL/erdm6WGLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQy/AAAIqsf19LIMZDnbL7cJdKBhGNCP0aelG2Ws77g=;
 b=0gHTaVQZr0+WQVi9JF1lUjBd6Idyux75UTus+ug5ZJ0BRX0jekLn1iE3cs6KmGuv7xf2eyNW8iY/N14XWHFH/q/8wtYyD98eJHmWS2sIp20IBfVsO7kMYzsMaEtvXqs5tA29dSlfI3lS39P1/fskn1EGpVj8Dypda+XSGqEoCio=
Received: from SJ0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:33b::11)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 22:27:20 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::d6) by SJ0PR05CA0006.outlook.office365.com
 (2603:10b6:a03:33b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 25 Mar 2024 22:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:27:19 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:27:18 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 05/14] x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
Date: Mon, 25 Mar 2024 17:26:24 -0500
Message-ID: <2edc2899e35b6eced2778eba4cf9388586c2b97e.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 0883c65b-cf8b-4ddd-2283-08dc4d1abc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/FMFuAozrXWLO8lRRaTIlKSm51qykxz9QziSmhXcD7lb9sQZhzUyqey6z9V72FWXIXPsKEVGVIlBAoCxYSkCelLAaEVgNBzqzH+aaJnxWDiWvHFhfX0mrEG5sQXyu9U7AcGmXoJQYlhghPN/wBG6WQ6XI7UW/hwXAu2zqtbJAxmIx22gccoS6xKlNzG6T2GYy0tkRKUCkB1vvFL9uYYjP+tFy076mFQAsOa6voVnDgvlj6c83UqC3GnZqqrnf0A0IIAKQ/SItuigMv3myjaudUrVxJWeyxaCifLhhKgKhTeI4TqeFRFimaP2Lpesj4xZ1z/U460Vi4GFNCf4Pi1vfUqD9WT+xpUKLNcYKpd2RjteSXZRexexL/QCyr6t5syn60Q4tig2j4izoz0YgXLAVleAYReKntMemLq8OCnfGn4Cp2GInK+rW9Q4zrG15LWqa8SrcZP4S9mO34JI4rKb8zjeCfcIZ7dNMExS+rWyrnm8X5neuJGWZItItHe+1pwLo8yBn5KB3uu76sAkC7KOb/jd6kvtulslc2n770A2gDr8G91S9cm5++egp7UvZhFJk03WkIB3LcnpUZSHX+Hx/cuoB66AIsaA5jp0gofMnbrv/GepDMICvb6zR3n7ljgbv7GHY2+Sq2XiyGoSKK5Y0VZdRkL75y2NtmCCN/izkqC6Rd/wnDMD2NErZrIx8jlnk7vSf7yY8IAN1JLVlmzp96uz1qYLh0n2tliiAo6fTyhOGgUSi3yPleUcDBFFGwuv
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:27:19.9890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0883c65b-cf8b-4ddd-2283-08dc4d1abc74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524

The PVALIDATE instruction can only be performed at VMPL0. An SVSM will
be present when running at VMPL1 or a lower privilege level.

When an SVSM is present, use the SVSM_CORE_PVALIDATE call to perform
memory validation instead of issuing the PVALIDATE instruction directly.

The validation of a single 4K page is now explicitly identified as such
in the function name, pvalidate_4k_page(). The pvalidate_pages() function
is used for validating 1 or more pages at either 4K or 2M in size. Each
function, however, determines whether it can issue the PVALIDATE directly
or whether the SVSM needs to be invoked.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c |  45 ++++++++-
 arch/x86/include/asm/sev.h     |  22 +++++
 arch/x86/kernel/sev-shared.c   | 176 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/sev.c          |  25 +++--
 4 files changed, 250 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index fe61ff630c7e..f8407ee83ac8 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -39,6 +39,16 @@ static u8 vmpl __section(".data");
 static u64 boot_svsm_caa_pa __section(".data");
 static struct svsm_ca *boot_svsm_caa __section(".data");
 
+static struct svsm_ca *__svsm_get_caa(void)
+{
+	return boot_svsm_caa;
+}
+
+static u64 __svsm_get_caa_pa(void)
+{
+	return boot_svsm_caa_pa;
+}
+
 /*
  * Copy a version of this function here - insn-eval.c can't be used in
  * pre-decompression code.
@@ -139,6 +149,24 @@ static bool fault_in_kernel_space(unsigned long address)
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
+static int svsm_protocol(struct svsm_call *call)
+{
+	struct ghcb *ghcb;
+	int ret;
+
+	if (boot_ghcb)
+		ghcb = boot_ghcb;
+	else
+		ghcb = NULL;
+
+	do {
+		ret = ghcb ? __svsm_ghcb_protocol(ghcb, call)
+			   : __svsm_msr_protocol(call);
+	} while (ret == SVSM_ERR_BUSY);
+
+	return ret;
+}
+
 bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
@@ -155,8 +183,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	 * If private -> shared then invalidate the page before requesting the
 	 * state change in the RMP table.
 	 */
-	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(paddr, paddr, 0);
 
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
@@ -171,8 +199,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
 	 */
-	if (op == SNP_PAGE_STATE_PRIVATE && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		pvalidate_4k_page(paddr, paddr, 1);
 }
 
 void snp_set_page_private(unsigned long paddr)
@@ -265,6 +293,15 @@ void sev_es_shutdown_ghcb(void)
 	if (!sev_es_check_cpu_features())
 		error("SEV-ES CPU Features missing.");
 
+	/*
+	 * The boot_ghcb value is used to determine whether to use the GHCB MSR
+	 * protocol or the GHCB shared page to perform a GHCB request. Since the
+	 * GHCB page is being changed to encrypted, it can't be used to perform
+	 * GHCB requests. Clear the boot_ghcb variable so that the GHCB MSR
+	 * protocol is used to change the GHCB page over to an encrypted page.
+	 */
+	boot_ghcb = NULL;
+
 	/*
 	 * GHCB Page must be flushed from the cache and mapped encrypted again.
 	 * Otherwise the running kernel will see strange cache effects when
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4aa36905b047..204f0a4857d6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -187,6 +187,27 @@ struct svsm_ca {
 #define SVSM_ERR_INVALID_PARAMETER		0x80000005
 #define SVSM_ERR_INVALID_REQUEST		0x80000006
 #define SVSM_ERR_BUSY				0x80000007
+#define SVSM_PVALIDATE_FAIL_SIZEMISMATCH	0x80001006
+
+/*
+ * The SVSM PVALIDATE related structures
+ */
+struct svsm_pvalidate_entry {
+	u64 page_size		: 2,
+	    action		: 1,
+	    ignore_cf		: 1,
+	    rsvd		: 8,
+	    pfn			: 52;
+};
+
+struct svsm_pvalidate_call {
+	u16 entries;
+	u16 next;
+
+	u8 rsvd1[4];
+
+	struct svsm_pvalidate_entry entry[];
+};
 
 /*
  * SVSM protocol structure
@@ -207,6 +228,7 @@ struct svsm_call {
 
 #define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
 #define SVSM_CORE_REMAP_CA		0
+#define SVSM_CORE_PVALIDATE		1
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 78d2b9f570de..e63c0a6eccd6 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -87,6 +87,8 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
 
+static int svsm_protocol(struct svsm_call *call);
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -1189,7 +1191,65 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 	}
 }
 
-static void pvalidate_pages(struct snp_psc_desc *desc)
+static int base_pvalidate_4k_page(unsigned long vaddr, bool validate)
+{
+	return pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
+}
+
+static int svsm_pvalidate_4k_page(unsigned long paddr, bool validate)
+{
+	struct svsm_pvalidate_call *pvalidate_call;
+	struct svsm_call call = {};
+	u64 pvalidate_call_pa;
+	unsigned long flags;
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
+	call.caa = __svsm_get_caa();
+
+	pvalidate_call = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
+	pvalidate_call_pa = __svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	pvalidate_call->entries = 1;
+	pvalidate_call->next    = 0;
+	pvalidate_call->entry[0].page_size = RMP_PG_SIZE_4K;
+	pvalidate_call->entry[0].action    = validate;
+	pvalidate_call->entry[0].ignore_cf = 0;
+	pvalidate_call->entry[0].pfn       = paddr >> PAGE_SHIFT;
+
+	/* Protocol 0, Call ID 1 */
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
+	call.rcx = pvalidate_call_pa;
+
+	ret = svsm_protocol(&call);
+
+	if (flags & X86_EFLAGS_IF)
+		native_irq_enable();
+
+	return ret;
+}
+
+static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool validate)
+{
+	int ret;
+
+	ret = vmpl ? svsm_pvalidate_4k_page(paddr, validate)
+		   : base_pvalidate_4k_page(vaddr, validate);
+
+	if (ret) {
+		WARN(1, "Failed to validate address 0x%lx ret %d", vaddr, ret);
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	}
+}
+
+static void base_pvalidate_pages(struct snp_psc_desc *desc)
 {
 	struct psc_entry *e;
 	unsigned long vaddr;
@@ -1223,6 +1283,120 @@ static void pvalidate_pages(struct snp_psc_desc *desc)
 	}
 }
 
+static void svsm_pvalidate_pages(struct snp_psc_desc *desc)
+{
+	struct svsm_pvalidate_call *pvalidate_call;
+	struct svsm_pvalidate_entry *pe;
+	unsigned int call_count, i;
+	struct svsm_call call = {};
+	u64 pvalidate_call_pa;
+	struct psc_entry *e;
+	unsigned long flags;
+	unsigned long vaddr;
+	bool action;
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
+	call.caa = __svsm_get_caa();
+
+	pvalidate_call = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
+	pvalidate_call_pa = __svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	/* Calculate how many entries the CA buffer can hold */
+	call_count = sizeof(call.caa->svsm_buffer);
+	call_count -= offsetof(struct svsm_pvalidate_call, entry);
+	call_count /= sizeof(pvalidate_call->entry[0]);
+
+	/* Protocol 0, Call ID 1 */
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
+	call.rcx = pvalidate_call_pa;
+
+	pvalidate_call->entries = 0;
+	pvalidate_call->next    = 0;
+
+	for (i = 0; i <= desc->hdr.end_entry; i++) {
+		e = &desc->entries[i];
+		pe = &pvalidate_call->entry[pvalidate_call->entries];
+
+		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
+		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
+		pe->ignore_cf = 0;
+		pe->pfn       = e->gfn;
+
+		pvalidate_call->entries++;
+		if (pvalidate_call->entries < call_count && i != desc->hdr.end_entry)
+			continue;
+
+		ret = svsm_protocol(&call);
+		if (ret == SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
+		    pvalidate_call->entry[pvalidate_call->next].page_size == RMP_PG_SIZE_2M) {
+			u64 pfn, pfn_end;
+
+			/*
+			 * The "next" field is the index of the failed entry. Calculate the
+			 * index of the entry after the failed entry before the fields are
+			 * cleared so that processing can continue on from that point (take
+			 * into account the for loop adding 1 to the entry).
+			 */
+			i -= pvalidate_call->entries - pvalidate_call->next;
+			i += 1;
+
+			action = pvalidate_call->entry[pvalidate_call->next].action;
+			pfn = pvalidate_call->entry[pvalidate_call->next].pfn;
+			pfn_end = pfn + 511;
+
+			pvalidate_call->entries = 0;
+			pvalidate_call->next    = 0;
+			for (; pfn <= pfn_end; pfn++) {
+				pe = &pvalidate_call->entry[pvalidate_call->entries];
+
+				pe->page_size = RMP_PG_SIZE_4K;
+				pe->action    = action;
+				pe->ignore_cf = 0;
+				pe->pfn       = pfn;
+
+				pvalidate_call->entries++;
+				if (pvalidate_call->entries < call_count && pfn != pfn_end)
+					continue;
+
+				ret = svsm_protocol(&call);
+				if (ret != SVSM_SUCCESS)
+					break;
+
+				pvalidate_call->entries = 0;
+				pvalidate_call->next    = 0;
+			}
+		}
+
+		if (ret != SVSM_SUCCESS) {
+			pe = &pvalidate_call->entry[pvalidate_call->next];
+			vaddr = (unsigned long)pfn_to_kaddr(pe->pfn);
+
+			WARN(1, "Failed to validate address %lx ret=%#x (%d)", vaddr, ret, ret);
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+		}
+
+		pvalidate_call->entries = 0;
+		pvalidate_call->next    = 0;
+	}
+
+	if (flags & X86_EFLAGS_IF)
+		native_irq_enable();
+}
+
+static void pvalidate_pages(struct snp_psc_desc *desc)
+{
+	vmpl ? svsm_pvalidate_pages(desc)
+	     : base_pvalidate_pages(desc);
+}
+
 static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
 {
 	int cur_entry, end_entry, ret = 0;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index af5017ab9746..d3e182d69d65 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -181,6 +181,12 @@ static struct svsm_ca *__svsm_get_caa(void)
 				       : boot_svsm_caa;
 }
 
+static u64 __svsm_get_caa_pa(void)
+{
+	return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa_pa)
+				       : boot_svsm_caa_pa;
+}
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -798,7 +804,6 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 {
 	unsigned long paddr_end;
 	u64 val;
-	int ret;
 
 	vaddr = vaddr & PAGE_MASK;
 
@@ -806,12 +811,9 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 	paddr_end = paddr + (npages << PAGE_SHIFT);
 
 	while (paddr < paddr_end) {
-		if (op == SNP_PAGE_STATE_SHARED) {
-			/* Page validation must be rescinded before changing to shared */
-			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
-				goto e_term;
-		}
+		/* Page validation must be rescinded before changing to shared */
+		if (op == SNP_PAGE_STATE_SHARED)
+			pvalidate_4k_page(vaddr, paddr, false);
 
 		/*
 		 * Use the MSR protocol because this function can be called before
@@ -833,12 +835,9 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
 			goto e_term;
 
-		if (op == SNP_PAGE_STATE_PRIVATE) {
-			/* Page validation must be performed after changing to private */
-			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, true);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
-				goto e_term;
-		}
+		/* Page validation must be performed after changing to private */
+		if (op == SNP_PAGE_STATE_PRIVATE)
+			pvalidate_4k_page(vaddr, paddr, true);
 
 		vaddr += PAGE_SIZE;
 		paddr += PAGE_SIZE;
-- 
2.43.2


