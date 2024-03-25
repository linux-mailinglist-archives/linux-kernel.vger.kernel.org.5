Return-Path: <linux-kernel+bounces-118096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B035688B3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D691C3A1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DF875805;
	Mon, 25 Mar 2024 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KFnQfFA7"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5A763F7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405616; cv=fail; b=pBBTDzg6hZoVxhnUnZ8VHEwUDfmDyt6n7Kz6JGb9NYvO3Ozr9lcnK3O115aPA9pH8oMqo8YxB5t2MQVp8lOhKWCVg2R92iDJhMqMon8NzLK1m4AlBPQbHpEzdeAmdQnlexf7cuVGDNjK66IiWpvDaN2zBBk37Gt6o0EbgIM1Rq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405616; c=relaxed/simple;
	bh=/p//XbU4+2CDUGb8+GVs8AmBxw+VQYCrdyK9Zdl1kK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQA82R57ndes2I7LwmAaYXHB1kjLdxtg3uleptAHLiIc0lJnkR/m3bHWypXOOpL/8f0J6CJnV5YAYW2FYIccqu+KSMiHehdKEonj9qPTlxrFqQDBALZ7mqH8P8/tiDdOEnJoEqGwwWzVPKPH2vR6tlwDkvIdKaApl9IdWaTsyUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KFnQfFA7; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLBTSaz84wavkwbl42rwh7+g9rwRzN1hw1cN2jUV2gRVl5ez7kMmxEvHqoBpOnI4FdZiyW4h2CGOtSIb1zZAgcc9FPhgr/i8hERe+lUywgthpJnmUzrlRvb54t3C2ZEuKbOmsqQrmzw1Uw08iEThKf0GHbE3BoHD/WuQNzpeJ4MzOYENKWe2WxjgOKNvpARANfWM3HczM39KhLGplfDg4tgJL6Ms/HENBX+YL9nfAG+GTIwYTgpHJmPEg3r3Ec2EBcfHXzoyjaBALtKWA2xYkQ79uUWeo0iImCG7T32ltUi4+Veztvu5qnfvEJ0wJCNVOS9u0zPAUzB326wI3t9Xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU4myvcDtCnR1U+pxZrwfxKRIdvQWY1JvfuKBFtRs3M=;
 b=OrJR48o7P5R51JNdiKK42O8RUWLzwtVlSoxmeRpDrb6iolHIjegoHIg0TZpDkOXsP3xMYOcdkPARM8MH+vnO0+g2h9e8QDRag+m22iv0r5M5Z2AJnaIY0ntswIHPUmyL8VRgXq7DCPsWDFvIb9VPyIX5zccU5w0Z0fNuRzBPXJJKrlLQhIiipYYJbqf+cCBgmkGqpaiggoMG1Onbki+j5hptoveb2UZxKdVB1aIF1BbRrooOkatve7w+6ysgmfgpurtsG9voqBDzIIBO/+pVYLiQmxuhSurbw2200piL9V87sCISQfvK2baHZtTeNVC0BRY49aqQqBcwOZvWStl7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU4myvcDtCnR1U+pxZrwfxKRIdvQWY1JvfuKBFtRs3M=;
 b=KFnQfFA7AmpVa2GTO5493mnBSLF4Qufu0x0C12fgmvRPDbImXVNbACBMUg1vCB+GfXb+UBOQIC8hmJ3adaqI6rybTot3TSF2AG4Da8k6++qIVPwPuBkWalDGmxvFY/kN8HYfJPg2q9Brf5TnwULXVov77QWUzveznfnj0HvdxwQ=
Received: from BY5PR17CA0021.namprd17.prod.outlook.com (2603:10b6:a03:1b8::34)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 22:26:51 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::f6) by BY5PR17CA0021.outlook.office365.com
 (2603:10b6:a03:1b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 22:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:26:51 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:26:50 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 01/14] x86/sev: Rename snp_init() in the boot/compressed/sev.c file
Date: Mon, 25 Mar 2024 17:26:20 -0500
Message-ID: <425afa6512994b1ca1bb366eb7abfb24d65175aa.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: b51125f9-73e3-4d14-0e9d-08dc4d1aab23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IUSXffQmIb9gtVlGtw79g+HOEjSA1cJLtb9Tbf4DhQz6ZX53FIqRQpliX98m7BNkzFp5vESp6WSQCxdk1rxYSdmBIyZMCIwZyaXq2boFMutOnE0GmcpmWLN8qo5DIwi0ojxcb3wIaJAh5v12WGQX871fRl/bKDJTbfxAUURL4Kl5fuvVqja3sYgFeAWV83ZTsZ6qMsBuLgZNj82xqJhNWT0Z+njE0gY5l6kwIzozcQtGOSEH2Ygm2JVwqftLMB4adVdysYewbmCUKhBi88lp+TodOF0L6gh0PPb0dxjavlIVx332Wmsi9XYxRC+mZDulqbmz2DFj16ztOSK6rPD8wbg+kFFYct9px/S95wCZnC/H7kMnDaXanTfOZ7Dib+KV640iIDYwMhwgvBqa0kQSDPrH98xwzimKGLcHZJDIhwWT2OEaMrx/7YDHzTvUOEzIaL5q9n6br0/pnkkayN8UA0HDa/zj9TfzBrxDpBBpbVscf6kwyG57+gb7L99cO914pBH3rG+KoKYm6VItDblYAEbnXFmZXMQgnSzslsaM8/lR8bWJuse+0dRraOaXg1ti/Mtq7tZkJ2Shd7jBPxE2pMJLcj7xriUxOwh3CpAfgwXeYJ3Qv43U9/j9JQyMHJNW7R8pVUEfVb91U5BJM2OTU/Ks75u1y2SoA0QqO1+9HkC/AsEnRbjGjMmQbDdL6jsW63SNGwIDzZNTP3UUd1EeK0I81OwUwtLlvQcySzyXH2gfHnPR/E2p+WO0yjGEp/zw
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(7416005)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:26:51.4052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51125f9-73e3-4d14-0e9d-08dc4d1aab23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

The snp_init() in boot/compressed/sev.c is local to that file and is not
called from outside of the file. Change the name so that it is not tied
to the function definition in arch/x86/include/asm/sev.h. Move the renamed
snp_init() and related functions up in the file to avoid having to add a
forward declaration and make the function static, too.

This will allow the snp_init() function in arch/x86/kernel/sev.c to be
changed without having to make the same change in boot/compressed/sev.c.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c | 162 ++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index ec71846d28c9..5ad0ff4664f1 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -413,6 +413,85 @@ void snp_check_features(void)
 	}
 }
 
+/* Search for Confidential Computing blob in the EFI config table. */
+static struct cc_blob_sev_info *find_cc_blob_efi(struct boot_params *bp)
+{
+	unsigned long cfg_table_pa;
+	unsigned int cfg_table_len;
+	int ret;
+
+	ret = efi_get_conf_table(bp, &cfg_table_pa, &cfg_table_len);
+	if (ret)
+		return NULL;
+
+	return (struct cc_blob_sev_info *)efi_find_vendor_table(bp, cfg_table_pa,
+								cfg_table_len,
+								EFI_CC_BLOB_GUID);
+}
+
+/*
+ * Initial set up of SNP relies on information provided by the
+ * Confidential Computing blob, which can be passed to the boot kernel
+ * by firmware/bootloader in the following ways:
+ *
+ * - via an entry in the EFI config table
+ * - via a setup_data structure, as defined by the Linux Boot Protocol
+ *
+ * Scan for the blob in that order.
+ */
+static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	cc_info = find_cc_blob_efi(bp);
+	if (cc_info)
+		goto found_cc_info;
+
+	cc_info = find_cc_blob_setup_data(bp);
+	if (!cc_info)
+		return NULL;
+
+found_cc_info:
+	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+	return cc_info;
+}
+
+/*
+ * Indicate SNP based on presence of SNP-specific CC blob. Subsequent checks
+ * will verify the SNP CPUID/MSR bits.
+ */
+static bool early_snp_init(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	if (!bp)
+		return false;
+
+	cc_info = find_cc_blob(bp);
+	if (!cc_info)
+		return false;
+
+	/*
+	 * If a SNP-specific Confidential Computing blob is present, then
+	 * firmware/bootloader have indicated SNP support. Verifying this
+	 * involves CPUID checks which will be more reliable if the SNP
+	 * CPUID table is used. See comments over snp_setup_cpuid_table() for
+	 * more details.
+	 */
+	setup_cpuid_table(cc_info);
+
+	/*
+	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
+	 * config table doesn't need to be searched again during early startup
+	 * phase.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+
+	return true;
+}
+
 /*
  * sev_check_cpu_support - Check for SEV support in the CPU capabilities
  *
@@ -463,7 +542,7 @@ void sev_enable(struct boot_params *bp)
 		bp->cc_blob_address = 0;
 
 	/*
-	 * Do an initial SEV capability check before snp_init() which
+	 * Do an initial SEV capability check before early_snp_init() which
 	 * loads the CPUID page and the same checks afterwards are done
 	 * without the hypervisor and are trustworthy.
 	 *
@@ -478,7 +557,7 @@ void sev_enable(struct boot_params *bp)
 	 * Setup/preliminary detection of SNP. This will be sanity-checked
 	 * against CPUID/MSR values later.
 	 */
-	snp = snp_init(bp);
+	snp = early_snp_init(bp);
 
 	/* Now repeat the checks with the SNP CPUID table. */
 
@@ -535,85 +614,6 @@ u64 sev_get_status(void)
 	return m.q;
 }
 
-/* Search for Confidential Computing blob in the EFI config table. */
-static struct cc_blob_sev_info *find_cc_blob_efi(struct boot_params *bp)
-{
-	unsigned long cfg_table_pa;
-	unsigned int cfg_table_len;
-	int ret;
-
-	ret = efi_get_conf_table(bp, &cfg_table_pa, &cfg_table_len);
-	if (ret)
-		return NULL;
-
-	return (struct cc_blob_sev_info *)efi_find_vendor_table(bp, cfg_table_pa,
-								cfg_table_len,
-								EFI_CC_BLOB_GUID);
-}
-
-/*
- * Initial set up of SNP relies on information provided by the
- * Confidential Computing blob, which can be passed to the boot kernel
- * by firmware/bootloader in the following ways:
- *
- * - via an entry in the EFI config table
- * - via a setup_data structure, as defined by the Linux Boot Protocol
- *
- * Scan for the blob in that order.
- */
-static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
-{
-	struct cc_blob_sev_info *cc_info;
-
-	cc_info = find_cc_blob_efi(bp);
-	if (cc_info)
-		goto found_cc_info;
-
-	cc_info = find_cc_blob_setup_data(bp);
-	if (!cc_info)
-		return NULL;
-
-found_cc_info:
-	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
-
-	return cc_info;
-}
-
-/*
- * Indicate SNP based on presence of SNP-specific CC blob. Subsequent checks
- * will verify the SNP CPUID/MSR bits.
- */
-bool snp_init(struct boot_params *bp)
-{
-	struct cc_blob_sev_info *cc_info;
-
-	if (!bp)
-		return false;
-
-	cc_info = find_cc_blob(bp);
-	if (!cc_info)
-		return false;
-
-	/*
-	 * If a SNP-specific Confidential Computing blob is present, then
-	 * firmware/bootloader have indicated SNP support. Verifying this
-	 * involves CPUID checks which will be more reliable if the SNP
-	 * CPUID table is used. See comments over snp_setup_cpuid_table() for
-	 * more details.
-	 */
-	setup_cpuid_table(cc_info);
-
-	/*
-	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
-	 * config table doesn't need to be searched again during early startup
-	 * phase.
-	 */
-	bp->cc_blob_address = (u32)(unsigned long)cc_info;
-
-	return true;
-}
-
 void sev_prep_identity_maps(unsigned long top_level_pgt)
 {
 	/*
-- 
2.43.2


