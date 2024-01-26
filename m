Return-Path: <linux-kernel+bounces-40743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4A83E511
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DE21C2388C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A951000;
	Fri, 26 Jan 2024 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3viWUttB"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7938950274
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307414; cv=fail; b=R6Mvm9fIHFprLcRD7f1qjBb2qA1ylrj9y0ViE34Wu9iCF3SSQ3SAi1srCIkxnh6PiZWUEVLrUuMEcNzb+cCe2bZWiop5Ir7kpOucqQj+JOvpaLJe6LJW1L0NW+h+pwsGz9OfNaJijDZc4Xb3sY96uuPpHBXtaj9pQk+N/Il+Chs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307414; c=relaxed/simple;
	bh=8v6dQpaOlKJgTaTV0zh7zHJzkv6Xg2BA31rSSN/0mZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocSg3FU2lpKPiyepVzg7K1UdeiSnhjQD33IchTa/srADalV2pXZq39K2S6Z4Hn3JwqY6qBJA3Ya4N7ByRWLpdMb2obEzpAffHLc7BrtXfPOhvmLhGo6qwvcfeO0jQUfwJ9Kw96PCBum8MD8pH9fVkZiZ1wqnKhkjFNs9vJPybL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3viWUttB; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7rVgZcCjrm/CZib9ikUesUUCuGSTvXqPTFIhLIuC4lmPIa4YhyzleIImXBCCjwOeyHSrc3RXaEMFNxJYQ4/eDL/aRM1JzTCjXK8GmqQ9758Vhi1nWTgxm7SZBliGxQyaeSiRn0HHWZm1T5v5gB2U+KP+ECmnzfySHMR/u5ibVrzjev5YhntYXES5eVRfSTQ3DakFS0UTvbVHFG6gky5Sl/9/0t4w+4uRxsiiQ+E53ccRI5OXmBSITLR9/asY+KXEE9Ci+lyhqapf7NkpRpSMur0tEDFC/fIM/hiwsB3uX/6A1i/ZmsaSIbQvI2AMn+3hel3ucI+U/x9XP/G0oFzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZaiXg0XOAUycPigfvWnAtcnJgY+VGJf7lJr4f4Cmwg=;
 b=PHNu6D24h1zCbvTSVe7R7Qxb3dW1xhTOJWzsP5UvWdDriHABtARMX9MewygUjd0lXTfHlXHpKtHW0v0F/2uxmO3Xni8JulV2sF1Ikbtd/iA2eIRQM1SkqiTLkjbouXg+DGBlFtLyCYuvCFN46WHxzhk6ll8/3PHQ9HPXUQnqozqsBGNB1Vo0j02DEngleUgtqsaYaZj1h0T7W+XZ1QZV0GPR/9l1t2FgU4u/dR4O1/Z3V1Hs3+0t2IlTHNpQgVeJfLaQU2BHxRSwt/g5zuFMLmdfm3pfnybWplV0ctZH0kR95ADD26HRyqO4ZaO/PpZnaHoDWwIQB+pOd3nRLEAqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZaiXg0XOAUycPigfvWnAtcnJgY+VGJf7lJr4f4Cmwg=;
 b=3viWUttBZbA8FXM2Qy5OqtvM8DPB+Z5rHwLovjHokzqjoF53EWaXzBVOmn5V7RNRCYU6WN+DAFq8sSG1SAultk1/Xic0YZuwG9PEJm03xF5u7jZQhnfyUUACF3Ymw8K3Hz9HDnRMKudexI61uj5vel31DOQlgq8Xg4dSFWyy4JQ=
Received: from DM5PR07CA0082.namprd07.prod.outlook.com (2603:10b6:4:ad::47) by
 SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Fri, 26 Jan
 2024 22:16:47 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::e8) by DM5PR07CA0082.outlook.office365.com
 (2603:10b6:4:ad::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 22:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:16:47 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:16:46 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 05/11] x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
Date: Fri, 26 Jan 2024 16:15:58 -0600
Message-ID: <d89b9ebb592a2436a1969304f826ddf3866682bc.1706307364.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5753c0-cd2b-464a-b234-08dc1ebc7c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	prYiOjtjaSaIru3tqkmc7YX9CodzNQ2FOylZu+IhNz9xYlDGmyH9qHTUgvZolsS7cuSE8Yti6a9D8uZ054anKqCC3KzVqKVmvgRq4+OPhGfn0id5W/dkKH8QUoKV31mHZLTe1rLr/bmhAOgYETJmlv9SSPS7T/F285qL0aPuHmSieLaf7NnyTwjTlHfG0fYh7Tdfi6NhKcGGvPD2KcqEYTclPigP6LYCvlUaTKu9jPrGP9izZC9plRuRp+HOFRdg2/vom7Leb6DYOSgCZ7ucxEuXqcjJBcyaN0/sOTUpZunxCcfYLmZ/wXF/+Cw7eQ/cH4yuGrWRv+b0ZiFS/LfBQEhWCsmgwpcoIhm2/R0TQygtBmMhxKlCPrLaRz64/grR2ZBam0L7lnCmBQ8MrAc82JhgTZpBvyjEBMrMM+tyFZr5CBLoPBXjd2t4B9bjV5mjJ7BokuQ5+Kn0mrx0eeZ45a/J/jonptwkG+VX/ipaOXhSz+xHZflYTMFMY3Zgx+kK8W8shXr4KTgF6vY8TIzM1Ky30HHXaitkThIW/CPLy3BS27dBxv26DRIZPqDiWqI1XC0wGQOusGMeishbKMO4MN1ltoVUbhclua6m5Yict3jOZnVRtajWaYOkxkRzq4DeP8VMhfpXMOx53GqAoSw/l9m9H2SnlcmhPDlJX7wk263IG0uyCkC15NHUZpQTv8mwzaPZmifW2Zi4rlOXoaRglgOeCQNdCPlNBgT3VnQMM8oweeWQncASUhdlL0Qb/VvbjWngU/qUbZJZZYgXG+991Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(36860700001)(478600001)(86362001)(6666004)(81166007)(356005)(47076005)(40480700001)(40460700003)(82740400003)(83380400001)(2616005)(8936002)(54906003)(4326008)(316002)(30864003)(2906002)(7416002)(5660300002)(36756003)(110136005)(70586007)(70206006)(8676002)(26005)(16526019)(426003)(336012)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:16:47.2355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5753c0-cd2b-464a-b234-08dc1ebc7c9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942

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
 arch/x86/boot/compressed/sev.c |  42 +++++++-
 arch/x86/include/asm/sev.h     |  22 +++++
 arch/x86/kernel/sev-shared.c   | 176 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/sev.c          |  25 +++--
 4 files changed, 247 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5d2403914ceb..3fbb614c31e0 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -38,6 +38,16 @@ static u8 vmpl __section(".data");
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
@@ -135,6 +145,24 @@ static bool fault_in_kernel_space(unsigned long address)
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
@@ -151,8 +179,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	 * If private -> shared then invalidate the page before requesting the
 	 * state change in the RMP table.
 	 */
-	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(paddr, paddr, 0);
 
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
@@ -167,8 +195,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
 	 */
-	if (op == SNP_PAGE_STATE_PRIVATE && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		pvalidate_4k_page(paddr, paddr, 1);
 }
 
 void snp_set_page_private(unsigned long paddr)
@@ -261,6 +289,12 @@ void sev_es_shutdown_ghcb(void)
 	if (!sev_es_check_cpu_features())
 		error("SEV-ES CPU Features missing.");
 
+	/*
+	 * Ensure that the boot GHCB isn't used for the PVALIDATE when running
+	 * under an SVSM.
+	 */
+	boot_ghcb = NULL;
+
 	/*
 	 * GHCB Page must be flushed from the cache and mapped encrypted again.
 	 * Otherwise the running kernel will see strange cache effects when
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 2f1e583769fc..dbd7fd041689 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -172,6 +172,27 @@ struct svsm_ca {
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
@@ -192,6 +213,7 @@ struct svsm_call {
 
 #define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
 #define SVSM_CORE_REMAP_CA		0
+#define SVSM_CORE_PVALIDATE		1
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 7e9fa5d8889b..f26e872bc5d0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -81,6 +81,8 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
 
+static int svsm_protocol(struct svsm_call *call);
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -1181,7 +1183,65 @@ static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
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
@@ -1215,6 +1275,120 @@ static void pvalidate_pages(struct snp_psc_desc *desc)
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
index 3bd7860fbfe1..2fd21090ef6b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -161,6 +161,12 @@ static struct svsm_ca *__svsm_get_caa(void)
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
@@ -777,7 +783,6 @@ static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 {
 	unsigned long paddr_end;
 	u64 val;
-	int ret;
 
 	vaddr = vaddr & PAGE_MASK;
 
@@ -785,12 +790,9 @@ static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
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
@@ -812,12 +814,9 @@ static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
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
2.42.0


