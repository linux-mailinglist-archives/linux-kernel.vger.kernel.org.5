Return-Path: <linux-kernel+bounces-40738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACCA83E503
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE591C22AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4371250EE;
	Fri, 26 Jan 2024 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pN/q8/gr"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B233CE7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307383; cv=fail; b=ck58eHFYDW8CNkfL7Y7FnHIWnXkGKAE+FBMXpbpTnQqLuWj67w0jn/kUusi1kjFiLvF9sBe1btMnP5Pkq5m0gE77Ngnk0uZ8WRKbJI4b0UrxfH2Gtuh1Q+K3LnNse+HlPvYNNOMZn9XR4RiIyDTnHZRn1L/iHOzcZaLtMgUpPX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307383; c=relaxed/simple;
	bh=rWIaZbHfpPkeXJqrlBlU26fGAMwT41Pfw0C5/YCwncE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kakBntJgUzhUPgMz757Ddw1hqGrISzTmwEAq8OKSmONpbgTdneYHoDWu6ztXd+9ACCFwfi0KVoLHpzn7bvgNRyQ7SSod2XK+2acSsDS/bsjYyUdHN/6ub5JmWSMemF13vgD8Fn4MWaPS1yqqp1+9h+A7iSfPRTse/XtC1E6ipv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pN/q8/gr; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyaVkhVKgTLoh80+wvFWyqUAPOferwCDCHx6x79HoBeK6uWZt8MKfXVb5DuSaL8yOraaUFmFv0H0N2KcTNFKjSlZPtDDsSEMzNGPybMASg8cc3p8slzeChE8jAIo3NZqunCKabz+HvXH4hs7YkpP/K37ifiShxAIJSOIwMOqH4dsw0+r50HOqP6yzZ0Hdf2yP0rCNMi80OGmR1fj2JomSh4GngFipvxT26BY1AMd5K0Sai7g+Xwk0uQ8QPwXyOhO3tzlcJq8323sszmyTfgus9Yss1WBAJ2BFxtypQ1nvja8641+8CxayDhPKt1GXXondO+xdSKtCQaM73q9xe7oPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZL/FEcAwKOrsFhtrSsNHfv0bAdLs+1yCZPr+pScf+8=;
 b=Q+CYFEUgkilZ31nWlSI2NgD59nbv2kn806b46I9MT1xrBZ09pz32MuuJYv8hUgSAaSpsOU1yWJOunt3sjjxVzJTPjm88i985w9Qq7EdjMX5lJHQ301WJd0eReEg1LmhQCwHXp0Uo8N3K8iLo5gokiu24z3/WrhkIT1RNoP4pJOyPFymyiGvML0c2X67OADNm/etbHf5wmEdLIsVMJfhw2eKhKDUJQ2z0hnS82p8IVYVYrCHPtqOfNzWyWo/IPJ4aA0sWopqoGNYIMFhkB6iJBnhy/L9dQgaLZow1yQNnn/BRC9NNZiTFReRjfqllvMeLC4ayZx6t5Cf9h6EDQkjVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZL/FEcAwKOrsFhtrSsNHfv0bAdLs+1yCZPr+pScf+8=;
 b=pN/q8/grXHgNldaNOsGaRqbbpEFTivX23IposFsgr91VdCy19jsiaeGl0ow/S3sAPED+nZKocyaO70ZEfKBbPZquYYSQSFAISoZ3sguq7ZFu+WXoGgzefbhtQxX6oVoljZSz6B1Y5uLdnhrO5NLKP9zY8415R+wzhMJF3EtjO+M=
Received: from CH0P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::21)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 22:16:19 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::c4) by CH0P221CA0039.outlook.office365.com
 (2603:10b6:610:11d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 22:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:16:19 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:16:17 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 01/11] x86/sev: Rename snp_init() in the boot/compressed/sev.c file
Date: Fri, 26 Jan 2024 16:15:54 -0600
Message-ID: <98db05934aa2d12e7df4e34ca33309b1aa8c0284.1706307364.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: f9baba13-2239-457a-456e-08dc1ebc6bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nWT2oII6DHCnkrE+cje4k1q/4S1G4V3N305kuXJBVJ7gZ3DHzMAxw16yYeOoJHZsy6lHGXZZv9IIFKHi24RdkXn00eJFe6o90xEgJE6fn64dWn6LqdFUSnIPHPY1/h4XZIl9OsiLxJVehgiSBfc/32g4Au1vIgTlViVU12hAflo/ScR3H9DMTzuctU1xwkxLIg80FIlUO2yFzS5mkIz47i+RvW1trlLAW+7X8dLS+zl3KRbpkZ21OWyvdUsqQMjW93mT+VUF0OkE2grl4LsJDXSccFFVkgW8rhPl8pUcqoRXmBFj7uD/ucJOZJfZTWFPDsi0YK786kMM207YRqOfxaN2I6hSRYDWRacQgwR+QfM00aCzet7+Y6lZn2J0P6alqezAi0SYcLbwW9EjXXl7ocQee7WGAXBXcbyRVZHj9b/pgV2cxaolFuNyNNrs91BghieP3cEHOEcaox9jKgo00TS6ymM4dZeI8xLcbLUXO8QR2S4SoFfOGup/98xYFIHE2qJfDZ13b7AexCOjm2pDNZ8redM+1QtNtW/LY3uWD1ihtKpfw1on+Cb2oxwF8u/5IovXIeSQ74OSKXwDsP/HnQXZTHcXD5CqOnErMUi2sLUftAPJjD7Yqg2C4sDr92NMnyBSJFsqKbDjSFUmPq/FH7IzNx+EKNjYFcwdGMNSp4GcmOmSAqMJHVwJs8nmhJxBDbnTthWNlnI6KvKoBtanXKiwolGOA9RaJ88XFSWDjTxU4YZn+5p1jQqB/x6kuvuDAmdq67k18QLK6fG9a1ahyw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(36756003)(83380400001)(110136005)(86362001)(356005)(82740400003)(81166007)(47076005)(36860700001)(16526019)(2616005)(26005)(336012)(426003)(41300700001)(2906002)(6666004)(316002)(70586007)(70206006)(54906003)(478600001)(5660300002)(4326008)(8936002)(7416002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:16:19.0720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9baba13-2239-457a-456e-08dc1ebc6bd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264

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
index 454acd7a2daf..c3030cfb6484 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -405,6 +405,85 @@ void snp_check_features(void)
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
@@ -455,7 +534,7 @@ void sev_enable(struct boot_params *bp)
 		bp->cc_blob_address = 0;
 
 	/*
-	 * Do an initial SEV capability check before snp_init() which
+	 * Do an initial SEV capability check before snp_setup() which
 	 * loads the CPUID page and the same checks afterwards are done
 	 * without the hypervisor and are trustworthy.
 	 *
@@ -470,7 +549,7 @@ void sev_enable(struct boot_params *bp)
 	 * Setup/preliminary detection of SNP. This will be sanity-checked
 	 * against CPUID/MSR values later.
 	 */
-	snp = snp_init(bp);
+	snp = snp_setup(bp);
 
 	/* Now repeat the checks with the SNP CPUID table. */
 
@@ -527,85 +606,6 @@ u64 sev_get_status(void)
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
2.42.0


