Return-Path: <linux-kernel+bounces-97459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150FB876AC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382281C2094B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550111C2A5;
	Fri,  8 Mar 2024 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cza/e9aS"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BEE2C194
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922960; cv=fail; b=icAK94twMRuzpcIVSS5Q7kvuEtbv8C4CKnZ/f1M06Agr/4lOAkunmZLIsM1538P4Q7lWQD4Gh8Q1fuo9F/SOsFZdVnrZgWRIP9L47bi0DY9eBwYF2jnCEs3BhnmgBwh+2n3BrrHMV3J+G4xZ1Cl7w1im45OAGwcu5xsSokHIhwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922960; c=relaxed/simple;
	bh=W2hj3xSFDez+xCmjfAWi53G18Dr8p4TYUdRZV51IURM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/uGiu6/ZAy1uIsDRrPhmXcTsFN8U2ZDXwyETra5Na7iD2NRWvr0RtvnP1joNlc3XyWPeZYUpByPCgyWco445sjdx7xPq+jvnsNk7nbwBYGY5qnU1KZVdtX4kIEgeuiKJ2GNvD0H3UBFkAuYeNFUKVPtzh9TnSDGw1v27S0FalE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cza/e9aS; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP+qCXxI8cmni0ITd5M3/XjkpHnz8xJpeUMKJ+IBNuYnwxwZRBCPX8MjLraNP0532slVle/Oh4/b64jnoY1jDrrWKmlZZafR1csGhAx0gVyr2+g7ywcH1rOIbpn0I6wdqwdTQGVm4B1bcCUrlhEzofCus40fz1YNJbuqIbWpN96NN1hgYr7LdGji97lF8wY+VG9VEE3LXBql4lm0t2DGkV05teEsSr0nPIRz27mGfErFh/Q7KUJxReOv3HXHnIn6slVjXhPsDRTAuvI+6chUmlt7Wl5u3r2DfXJRomZphernrsIirW6wiKzAots3srR2pvIkigsYEsWVkukTMeF/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L//mfpG9pAkMjFLXKWnNFdtdRk5J/OvIEI+Yp2aLYec=;
 b=SEOyVlLt4l5Tbun3Mg7JPeumm2MEN25FppHJ0PlaBBSnDHJ0li+ghswJ7y8CTtGEyJM/ClV3AxyhZ2vLQe256rhch9IqpOoJLKzvWsV3OCu4gqOiRw97SKuePh/Bdjuw3TvfQ3/vef+PBgQUmkG2R0jAHb8YR+Hd9uNk06rOIdVGmeSBBPqJXk4rhTjYrIgnxviv7bIMqU4DQXmEU0NH5zdlTQS2moksS086p39e+BJhX654XWLsgsvMK2xy9UU6ojVSqWtgsKzTeQgOviTUMKQahREjTK5PzBwrKMi5jJyBd8Yjpu9DOnsvDMELAGlI+l2HBh3LuLX0mnj7BP4Vjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L//mfpG9pAkMjFLXKWnNFdtdRk5J/OvIEI+Yp2aLYec=;
 b=cza/e9aS5AJMCil1cHk/cqRYf9aowVDd5Rg74VbgMlmLG2CljvW76N3kAvzo7kXZ0BWRF0WjP6sTBGa7EnpMWtISb4/SfQHcjbrQGv/IxiT3aKJzjsz2HJr7MjaxHl6eDj+AHHo2A1Vjyjo6xudK++bcySpsq/O+mAv33OOFdHo=
Received: from BN9PR03CA0852.namprd03.prod.outlook.com (2603:10b6:408:13d::17)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 18:35:52 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::74) by BN9PR03CA0852.outlook.office365.com
 (2603:10b6:408:13d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 18:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:35:52 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:35:51 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 01/14] x86/sev: Rename snp_init() in the boot/compressed/sev.c file
Date: Fri, 8 Mar 2024 12:35:16 -0600
Message-ID: <d558343480a78b53ac419ce67fc9f13d631672a4.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 519ba04a-fd45-42d3-59cd-08dc3f9e9579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	frIUn4j2FNtD1MDsGKAbQglaY2IC54Dp/jZ9+laYAK0umPr91x5ZF5xCXb2ApRT/xjmxkYHTM9IJ8y+SAL0nmjCgB4mT1C+pmo4NdMVrsJRI61JlP+tp41YZ0sMkw1Zj/PlRlHyAbL45Rj0RVj4eyqouEAV7FjsL3a95Wf4xr/EGPxM6CLMSBawGP3u1B5vpweOlKhxZ8REj/mvDskMietBvurWuQMOdFqdDOlyOg4O9SRFzggq1axpKYigBk7LOvnxmkCqYk4hSmj8lZzYPHR8F976WNxDUK1EtQ5KhsBkz6v6Sucs1KPtqPuBu/OAgQPNwF2YMcRoW1j/fC0HOevsBlb8Gi6VdaKe5zGejy/23w8WF4tRr9Lia85CYXkNpNVLbYR7reD9UZj0K2KTUg5oPTRnGqI1dDsJvhvoIVw1U9ZZYzEa5Wi0uh7MHNUSgjUey2xJGwpq1urbUhUWrh6Y2gX4HAmvix6BrycgZp5JMCA1G7UGAPJSmp1w344dpl5CTJTIXQnidBVNbhPr4bMbyvj/r7QiabM4AXP+ba885ZNnwUbjlps9yWCQsfRXK0dKm91aCGA8pzWQzObwKBrkDIHAk5i10hT1Vbra9igi0sdMX9TIBgJKfYbwb4q2wEO78PVAnitF0AGF7GfKgK8UXATbl2c3nQ1nXRcv4mYEsnFMdShPJxEZR0ihaplM126CZr31s3wanrFT3KFprcVyV6rB8wuaF6oSz14dK3wfDQXVxTX+q7mQU1qc18qFV
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:35:52.4439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519ba04a-fd45-42d3-59cd-08dc3f9e9579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130

The snp_init() function is local to the boot/compressed/sev.c file and is
not called from outside of the file. Change the name so that it is not
tied to the function definition in arch/x86/include/asm/sev.h. Move the
renamed snp_init() and related functions up in the file to avoid having to
add a forward declaration and make the function static, too.

This will allow the snp_init() function in arch/x86/kernel/sev.c to be
changed without having to make the same change in boot/compressed/sev.c.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c | 162 ++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index ec71846d28c9..bec0bbfc6403 100644
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
+static bool snp_setup(struct boot_params *bp)
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
+	 * Do an initial SEV capability check before snp_setup() which
 	 * loads the CPUID page and the same checks afterwards are done
 	 * without the hypervisor and are trustworthy.
 	 *
@@ -478,7 +557,7 @@ void sev_enable(struct boot_params *bp)
 	 * Setup/preliminary detection of SNP. This will be sanity-checked
 	 * against CPUID/MSR values later.
 	 */
-	snp = snp_init(bp);
+	snp = snp_setup(bp);
 
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


