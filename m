Return-Path: <linux-kernel+bounces-157273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD48B0F44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01621F213A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DA615F406;
	Wed, 24 Apr 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pf2W+TG0"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391B1649DB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974339; cv=fail; b=jLSBPLTopfNremhjAoieySFJTHe4SpS+QBVwJK5GLSgyt2+A7egO3qslEbuj4w9Yl7bZvQOJx/RwhGsxRgNDxD/0J5+7TvWeUsCg+bwigBHRlcn0qu8GmGNvEtb+3F/5V8McYHN0mIk7CSXicuAnBK53kRYXIlV7fatHWojEsK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974339; c=relaxed/simple;
	bh=1rq7LJSUQAHQZGrsm7htbyZqFp3tpiGuY2jCSOMF3HU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1YnPgGnlvdKNhvkaskAkFKbebAGh5vaCxl9tU6/CrlE55EQFo9ImMcKpiCOLa7cRw3CwI5JyPbm7p9735/VFMbjKverr9vy8EPP1pCMBmzVQwPgo7sOb9iUYFsEHjVStzOlHwDCBxLDbe1YMf7ZKzf6ZRqN1z9S2lKhpbB7+sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pf2W+TG0; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OftVwEIsqurTy8PitjHP7k6MiVUYRWYDio+Bmyp8rBt18MnbnKXtvEZl1NARivWNr846ypIMNYWq6niAH80M4HOcaD5qGEINi61bV1jcvC3f+Dz0LKvDX1lHUcOhferxpOrO81j/hONA5DozR2Vlb3w7yvDeE4zAygZFAH4MAI+KHKJ5veZvMYvzwDbyPW5Gf465rekokGkRZIpecjzBjvjpGIUE+/v+wwMWCHYjiXdxS4Cvroo69ORoQ3YAmkV79dmZwT8JdZJZnO40QwXG4cn/CBXc/Wnw/cEefC0tUb9huEAXgpOp+Yi7vEiCnR1qIq/8zby91rXoZQ3/9fTCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa9qGzd4f67WtUpq1M7yG8u8qe9Yy9BZe6DqeXmZ8FA=;
 b=Cn2YRaCrIrin9e2vGl0bilW0FvY4+/hicKlK7yzrKVi6awcVoV0DqegAgSR3LBy1U4q0C2JnfOZxpA2DdnyNYdUyFH1tfLVHOUioyGtDLCtvMuX3daXupBemNDYgE9XBHk9NCJ0L/J9/pQvjUemPaIz2WtLXHIXbS28Tf8TzwEAamfbz7eOVVbSIal3kO0KU7lf77BVJE18xB6j1DdCU3eagsZDdLEP3hJ3xU8zaiGoXw4jkoB8596o8Dfne5TtMuDOaz8OfwKAPHrMpZO9B8c1aXs/QurZtXoAeYNMOnpW5Obl+iDBx7vih6n6vE+bKI84Qy3xKcgiQu3WuiUhXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa9qGzd4f67WtUpq1M7yG8u8qe9Yy9BZe6DqeXmZ8FA=;
 b=pf2W+TG0b6qDFYJAS+O9dypfwQiq42TjgBcyJNb6WBHUgxkMDHv20YEtsghPFJg/BJArNtMAIA4mDV7VluW/6Nbn19lvaffJWn50wWWYj6TiC31sx0MVSKRMX0Sl4LfUxe/yfcvGsQ+DK0EOeRBYw8MwFKua4adEJrTv2rp/A9g=
Received: from BL0PR0102CA0064.prod.exchangelabs.com (2603:10b6:208:25::41) by
 MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Wed, 24 Apr 2024 15:58:54 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::23) by BL0PR0102CA0064.outlook.office365.com
 (2603:10b6:208:25::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Wed, 24 Apr 2024 15:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:58:54 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:58:53 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 04/15] x86/sev: Check for the presence of an SVSM in the SNP Secrets page
Date: Wed, 24 Apr 2024 10:58:00 -0500
Message-ID: <6cf54cac47f212f4c2b59b123855d8c183989022.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 84658c38-b411-4e66-2d21-08dc64777151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|376005|1800799015|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PmGNqMO3veAitb+XPlMp5UVOCyeNq5T0n0WuDUVOIz4IOetlY0UZHcw4nCMy?=
 =?us-ascii?Q?35e8rMErkRvJ/EQYdS9RchM4Zj2FLq0W7QjGgMdC5cLPZCi4PGuu7QBWogkn?=
 =?us-ascii?Q?I66zD4gDvqRzv1R4Entd+kprQ9uMYrAYnPKd2KItTSp0GihcVa1ADoDe1ZSP?=
 =?us-ascii?Q?oV+1aSDXfka5TZD1kOFBAQUs5ZjUcL3VLO2E51SkGI0c+lqt8+Qd25VPWkQD?=
 =?us-ascii?Q?Lckw2xNmDgo971wXxzSYkXVh22JF0I4BuTldmPjNKRtFdipuXqNDMkbOhRkh?=
 =?us-ascii?Q?XYArAVAEunxZgd64b3eJqZi/zHLiI2VduGZauMWWExN37/cmYEL2MvzkMoXM?=
 =?us-ascii?Q?dQ+qYsMHKXW83w0mCM35f/80lJDZhNyN3ZW5mJYsnhTtNh7porOQxveN59Dz?=
 =?us-ascii?Q?tym76HRPc/wggxNfXFkv1fckc5D7Da+HMAiwN9IJzWi3FdzMQnhnmJzWoSWQ?=
 =?us-ascii?Q?uvTW2PX+XKMSaPO7sg0EKKEl1GgyeuocjDiybWnD4kggMWCvguRTcl6Y7n4S?=
 =?us-ascii?Q?S0tlMlVtityIVN3EhlDoJ9ODF3UZybo1+BrHXTWfbcDaPIqLHVlaK0ENHIpW?=
 =?us-ascii?Q?0Fe1JAI9hV6gxABSqg7hlw342tTxC5t1iT4HWksvGjJxegvjj+4w33je+HuR?=
 =?us-ascii?Q?MkpRcQVrVeTu1LX5sQ8qQgoEu13oyTispq1AhI26oVZB6CAEiBMnld60J/Jh?=
 =?us-ascii?Q?ztLMp0DYLvADDbLxmFjlvApeFMoJHswJkTbrBOBXN0HTtPP1awIXEoS8F5yG?=
 =?us-ascii?Q?takVZK+bJTzIhofkE19qJNu220EWHktrxGPT+v4Ucmsve8y7jhlsoTvmWSKg?=
 =?us-ascii?Q?M5aGi8qn16E5UUYcMyeB+WxSpIk4xO/1amxEUG3kgvmPFEYorS/jRhZGjCu+?=
 =?us-ascii?Q?Lrhnk9bkDn0JufccSBAznARufxhXeUnY8ePkRDg5LcaUL2ak0h0DyOUfR/Nx?=
 =?us-ascii?Q?g3Uuwnffq++MDojNkEP4DLvEWwg/5J4QIQrPm+WMt71KRzJPh2F2xVe+cC5E?=
 =?us-ascii?Q?fYjcxzNhSvHkKhKPLNfqGYRI1n2QGSMkdIdxFAVvchdaj1UwVHw2u5q2vLk3?=
 =?us-ascii?Q?ilS38sgv8qbsdDWI3he0zF1fXT/PcF11BVyu5GstBsSwFsLihASEzsL5MOIW?=
 =?us-ascii?Q?85zHKEYXCTbr7+wi7v33f8SHY6bdGTpekz1RVf+g5l8xa5WGJG0zwwqv+kGg?=
 =?us-ascii?Q?iNvW89MJTBgeDrF74yjTzBcJiKx0J2X8tt9yzYgxtqDqyOlhtIEvGeBupMUH?=
 =?us-ascii?Q?G3M5C+UaxLGIfx0b362GTSoVwlR+jo5kIvylQqvWbmpht57HVwjgFxbkGlNs?=
 =?us-ascii?Q?IsPlFEeOiw5DUqDl5sxq7YdnIhyqIY/Wav6ynlNBFnA148b4xWNK0XnANc/1?=
 =?us-ascii?Q?tHFqL8w/pwHlwG7OJauxwe5Mrwsx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:58:54.4330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84658c38-b411-4e66-2d21-08dc64777151
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239

During early boot phases, check for the presence of an SVSM when running
as an SEV-SNP guest.

An SVSM is present if not running at VMPL0 and the 64-bit value at offset
0x148 into the secrets page is non-zero. If an SVSM is present, save the
SVSM Calling Area address (CAA), located at offset 0x150 into the secrets
page, and set the VMPL level of the guest, which should be non-zero, to
indicate the presence of an SVSM.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 .../arch/x86/amd-memory-encryption.rst        | 22 ++++++
 arch/x86/boot/compressed/sev.c                |  8 +++
 arch/x86/include/asm/sev-common.h             |  4 ++
 arch/x86/include/asm/sev.h                    | 25 ++++++-
 arch/x86/kernel/sev-shared.c                  | 70 +++++++++++++++++++
 arch/x86/kernel/sev.c                         |  7 ++
 6 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
index 414bc7402ae7..32737718d4a2 100644
--- a/Documentation/arch/x86/amd-memory-encryption.rst
+++ b/Documentation/arch/x86/amd-memory-encryption.rst
@@ -130,4 +130,26 @@ SNP feature support.
 
 More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
 
+Secure VM Service Module (SVSM)
+===============================
+
+SNP provides a feature called Virtual Machine Privilege Levels (VMPL). The most
+privileged VMPL is 0 with numerically higher numbers having lesser privileges.
+More details in AMD64 APM[1] Vol 2: 15.35.7 Virtual Machine Privilege Levels.
+
+The VMPL feature provides the ability to run software services at a more
+privileged level than the guest OS is running at. This provides a secure
+environment for services within the guest's SNP environment, while protecting
+the service from hypervisor interference. An example of a secure service
+would be a virtual TPM (vTPM). Additionally, certain operations require the
+guest to be running at VMPL0 in order for them to be performed. For example,
+the PVALIDATE instruction is required to be executed at VMPL0.
+
+When a guest is not running at VMPL0, it needs to communicate with the software
+running at VMPL0 to perform privileged operations or to interact with secure
+services. This software running at VMPL0 is known as a Secure VM Service Module
+(SVSM). Discovery of an SVSM and the API used to communicate with it is
+documented in Secure VM Service Module for SEV-SNP Guests[2].
+
 [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
+[2] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 0457a9d7e515..cb771b380a6b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -12,6 +12,7 @@
  */
 #include "misc.h"
 
+#include <linux/mm.h>
 #include <asm/bootparam.h>
 #include <asm/pgtable_types.h>
 #include <asm/sev.h>
@@ -462,6 +463,13 @@ static bool early_snp_init(struct boot_params *bp)
 	 */
 	setup_cpuid_table(cc_info);
 
+	/*
+	 * Record the SVSM Calling Area (CA) address if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM to perform the SVSM services.
+	 */
+	setup_svsm_ca(cc_info);
+
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
 	 * config table doesn't need to be searched again during early startup
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b463fcbd4b90..1225744a069b 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -159,6 +159,10 @@ struct snp_psc_desc {
 #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
 #define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
 #define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
+#define GHCB_TERM_SECRETS_PAGE		6	/* Secrets page failure */
+#define GHCB_TERM_NO_SVSM		7	/* SVSM is not advertised in the secrets page */
+#define GHCB_TERM_SVSM_VMPL0		8	/* SVSM is present but has set VMPL to 0 */
+#define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but CAA is not page aligned */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 48bc397db649..56f7d843f7a4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -152,9 +152,32 @@ struct snp_secrets_page {
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
index b4f8fa0f722c..46ea4e5e118a 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -23,6 +23,21 @@
 #define sev_printk_rtl(fmt, ...)
 #endif
 
+/*
+ * SVSM related information:
+ *   When running under an SVSM, the VMPL that Linux is executing at must be
+ *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
+ *
+ *   During boot, the page tables are set up as identity mapped and later
+ *   changed to use kernel virtual addresses. Maintain separate virtual and
+ *   physical addresses for the CAA to allow SVSM functions to be used during
+ *   early boot, both with identity mapped virtual addresses and proper kernel
+ *   virtual addresses.
+ */
+static u8 vmpl __ro_after_init;
+static struct svsm_ca *boot_svsm_caa __ro_after_init;
+static u64 boot_svsm_caa_pa __ro_after_init;
+
 /* I/O parameters for CPUID-related helpers */
 struct cpuid_leaf {
 	u32 fn;
@@ -1269,3 +1284,58 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 
 	return ES_UNSUPPORTED;
 }
+
+/*
+ * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
+ * services needed when not running in VMPL0.
+ */
+static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
+{
+	struct snp_secrets_page *secrets_page;
+	u64 caa;
+
+	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
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
+	 *
+	 * Use __pa() since this routine is running identity mapped when called,
+	 * both by the decompressor code and the early kernel code.
+	 */
+	if (!rmpadjust((unsigned long)__pa(&boot_ghcb_page), RMP_PG_SIZE_4K, 1))
+		return;
+
+	/*
+	 * Not running at VMPL0, ensure everything has been properly supplied
+	 * for running under an SVSM.
+	 */
+	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len != PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
+
+	secrets_page = (struct snp_secrets_page *)cc_info->secrets_phys;
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
index 6949fbccec40..a500df807e79 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2108,6 +2108,13 @@ bool __head snp_init(struct boot_params *bp)
 
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


