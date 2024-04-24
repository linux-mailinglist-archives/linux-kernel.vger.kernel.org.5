Return-Path: <linux-kernel+bounces-157277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC518B0F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955FD298E62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE56165FB7;
	Wed, 24 Apr 2024 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ysNm+zs+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2D16D4D2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974355; cv=fail; b=PHtwSEL6pG3heH/UWnAKeDBq5zJSbkV/0ngSaIQf07EOI8nWdAf1rGFu3lTQmmU8kBGX+M24eqgZ7nSjrnn0dTvL3I+wVH+VrH0rQ9Y0Lakm8veG4j8aMNSMC28QQXZv74irlunn5gwicYZUuLAaf3TXnF1JjP9xIgSbTbmzNnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974355; c=relaxed/simple;
	bh=sCcOo5h4Z+8EsVu4ndMgeSUqeVaeUN9UzDUDT0H6lbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeS3sTX3l/IwjFkQazPEonsKI5pzqlMO7cWoH1r4HYK0uHjq6gOfWQFC8oTfuKMOwrIWD2GC50Gn1pUdwQaAg0pdEDBgiI/m93gxcfU6DBc3NKAgp+9aFqdZty9NiE1+56lZkoga7heWVery4r/y3SQqCDOCRn0PDphNhJPM654=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ysNm+zs+; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE4jmMFJciqYyK3tFDvUndckYlbIb8f1yQbUknPYMCwhlj3c/nH1JgGBgxBrWiWVJu3KN81s6/ZQGp+3DJtM+0MQqYHodhX24zOo1Ojkae9SAn4dvmubWZQ0q5Jh75oTtVeg1KYsfppAI2AWFq7oA8I5a/HHX3XmVUWHnZ4g3SCLneTpG9B8o7kqn8Upm0l/jEw2ld6KzcCu9r9DsEJ08Mn05m2cnvDMe3hcbcIrNOdmqxJFv+7g2n81KUSjRwxwTacv1n/j8Yy1270T0P/+Edo2Kysm9crqGwIyMzfFqXrM/FK7knqqbquPGnoLj7t9rqY/yDrLbjDDo6/XFHHdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlYJi1OB8n2mSK38q8l9MCV/mrF8TxZGEl/0Xxm9djU=;
 b=DeJGe4D5NdPEzlGPTWemxi5hiT0/G2U+oxmPVhO2At3cmf3rBH8tTtthdQd2rultBHfRP5YJL6Y5NUVLqiBPaFMKRcz/V7mHyxjcZLg3F+gFKWpsl8HjcBvyohxurmBoMWBB/qwxL2Qvip/Vc74/pE+11TuDGu20EAra6pVltcDNYB2nUKky2Rw8RupYsFKd+rpYSoePTj215EotwfToHUd0SKnLPy8lYFOH7EynX48aSPtFENWqlX61Ww+QRnRzvPUGYyPliC65u7B0lP+rzs1eX65o06BmG970cFexTtztDhw/hVWE/ycGSwp482nI/LKs/BBqMvLoo2Y6aL5SSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlYJi1OB8n2mSK38q8l9MCV/mrF8TxZGEl/0Xxm9djU=;
 b=ysNm+zs+fYFJHWEeP3n7iFjru3k3SkMbOFL0EvZ0HTgdh6WDWWR6m/9oVtMiAuXQ8BvZPKWTpTwbOrcoGexS9beAh7EMYyhZDCTVyHlQcaQLvy/KMyBQuoQxUiB1xDQMbL7UkP9WMtrVPTeTNzv4UyM00AoHdzm3ss7YrWiYEKQ=
Received: from MN2PR22CA0001.namprd22.prod.outlook.com (2603:10b6:208:238::6)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:59:10 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::2e) by MN2PR22CA0001.outlook.office365.com
 (2603:10b6:208:238::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Wed, 24 Apr 2024 15:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:59:09 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:59:07 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 06/15] x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
Date: Wed, 24 Apr 2024 10:58:02 -0500
Message-ID: <ce5f7ded87868adce2f4724415313229a8bf3eb3.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec7ae87-eeb3-4b9a-c188-08dc64777a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aB/UlrTvhaJmgkfBsqksTsJt8EGV5EoBeNSqxSa+qjyG/D2zK7xUX4snY2UK?=
 =?us-ascii?Q?K1CaHR99mIOMtsLhXFC5f4CkY+/gX4jKunTVgnF8rn2mCawyoYkgnskRelgQ?=
 =?us-ascii?Q?skv2yTQMfa8QlekQumFVC2hS5KXAOq44lICtXITVgHRCa74kWmpUO0s20tsM?=
 =?us-ascii?Q?5KS66rdf+0gbDCbOteQXkQUOK27E5pTbkTkA5IfmqVTo6eXTVjlqnQyAL0Lv?=
 =?us-ascii?Q?fAYM7CRlDILm33yY4FLQ08zNIxoCSFjOJ3l8ZTbApQHa3nopi1tZt2Zxl2uZ?=
 =?us-ascii?Q?xcjFFrw/11E4N/g5UdoeuWl0O6GyBrCP1xkJBD0ILDEKpMggqy3/4u8u/aKN?=
 =?us-ascii?Q?EG7b/O3y/YDMa9g8gwPy86PWbVGL0w3QCY2o535COodfr6LaHaGxX8GT9MIS?=
 =?us-ascii?Q?pF2u1nDKZY67g6NWNOXdUpPCxGGqVyoZNIF/MQUPYCNVJjGMqJgYqhqD6Tpj?=
 =?us-ascii?Q?c9GNVh4s1YAU6IOdXVgaK5HO8k0D/z0XhV2y1dkTq2DOdV6n4lDcwn7juAkx?=
 =?us-ascii?Q?eJevctBWQS4vpEZ3ApsrsWemGtegjRjm0d3PV7VKD5wJWStK6OZOwTAKuj+I?=
 =?us-ascii?Q?OvbYwgdxl6m0slW5fSbUjj4eY32BPjnNhZy5VjfRSwVpJ3M7RxQGoh62VlIX?=
 =?us-ascii?Q?uAz244/jBtANiGdfs4QsggHvUFaWX8BMfTeRiEltEevU4U251pw6jkuyMl9M?=
 =?us-ascii?Q?HSFAMHsWH6fEqpaleh3YFi+Hn8t82VLEww8kb+iyel0gKAgrFKVS3KxKH/sn?=
 =?us-ascii?Q?rz1lbukTOE+7FRqct3eGOxJWS7VHHeiLirs+/ke0cuH/LtfEVSEKcGOyG8Ty?=
 =?us-ascii?Q?Riiu6SIqqbUYeBPEgHwGPEF0DRz3z1cvuOzp4Em5O5njAA8dNJOkhILNduQP?=
 =?us-ascii?Q?Fg+kaYNQNbF+Y1balZozLkBCcdSIibYppwbVD6U+l34ZUFOO735a02hIFz44?=
 =?us-ascii?Q?A3UBVOHWn9SQ/9IiCcBC0/joOL0gvIujxdHFhy7PKjSqHEMQiRVhx3zVAxok?=
 =?us-ascii?Q?jfc57yuS6xhVD0w+Hq7gjDCX27RHsMxn7jfS/E21/JHf4ZWVsvPOAGnhzKKR?=
 =?us-ascii?Q?a6UO7L5IMM5K1cgPBmfXWbfru84ofYwEOiH1+mKU7PtEFqGNjrX73rpIjmVB?=
 =?us-ascii?Q?WKKRo+mXTRNJAlx6EiTQhyJWkbrB4RJEYVLPZK4WSccDe2YIhDShm1iSpCTF?=
 =?us-ascii?Q?lojlHqWBIsR1zduPJLCoChyoOmgp+jtigL5r9gyh6ki2Q/HgM5+w1Nsg6iMU?=
 =?us-ascii?Q?r9vqqXPA5wO02yLxmNliBcDuYAScyK4NsjupUqszdrzT79HRUNvDOegF3ITH?=
 =?us-ascii?Q?4p5R4NSzqTowuJEjE9GIzqG18iUMX9S+cak1tfDiv/B79doMlRlS2Xpfti3b?=
 =?us-ascii?Q?ZxQAfm5W5WtN1zVqhRihuB3UCbMS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:59:09.8377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec7ae87-eeb3-4b9a-c188-08dc64777a7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250

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
 arch/x86/include/asm/sev.h     |  22 ++++
 arch/x86/kernel/sev-shared.c   | 179 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/sev.c          |  25 +++--
 4 files changed, 253 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index cb771b380a6b..32a1e98ffaa9 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -130,6 +130,34 @@ static bool fault_in_kernel_space(unsigned long address)
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
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
@@ -146,8 +174,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	 * If private -> shared then invalidate the page before requesting the
 	 * state change in the RMP table.
 	 */
-	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_4k_page(paddr, paddr, 0);
 
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
@@ -162,8 +190,8 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
 	 */
-	if (op == SNP_PAGE_STATE_PRIVATE && pvalidate(paddr, RMP_PG_SIZE_4K, 1))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		pvalidate_4k_page(paddr, paddr, 1);
 }
 
 void snp_set_page_private(unsigned long paddr)
@@ -256,6 +284,15 @@ void sev_es_shutdown_ghcb(void)
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
index 8f180fd3cbf0..e6f1ed3f6ce3 100644
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
index 6f57eb804e70..b415b10a0823 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -40,6 +40,9 @@ static u8 vmpl __ro_after_init;
 static struct svsm_ca *boot_svsm_caa __ro_after_init;
 static u64 boot_svsm_caa_pa __ro_after_init;
 
+static struct svsm_ca *__svsm_get_caa(void);
+static u64 __svsm_get_caa_pa(void);
+
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
 	u32 fn;
@@ -102,6 +105,8 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
 
+static int svsm_protocol(struct svsm_call *call);
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -1186,7 +1191,65 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
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
@@ -1220,6 +1283,120 @@ static void pvalidate_pages(struct snp_psc_desc *desc)
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
index 21f3cc40d662..49cf4a6f1f31 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -622,6 +622,12 @@ static struct svsm_ca *__svsm_get_caa(void)
 				       : boot_svsm_caa;
 }
 
+static u64 __svsm_get_caa_pa(void)
+{
+	return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa_pa)
+				       : boot_svsm_caa_pa;
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -792,7 +798,6 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 {
 	unsigned long paddr_end;
 	u64 val;
-	int ret;
 
 	vaddr = vaddr & PAGE_MASK;
 
@@ -800,12 +805,9 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
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
@@ -827,12 +829,9 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
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


