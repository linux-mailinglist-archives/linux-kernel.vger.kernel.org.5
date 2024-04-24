Return-Path: <linux-kernel+bounces-157271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A988B0F42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FADC298E24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1E3161314;
	Wed, 24 Apr 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="umVpiWhr"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301A1607A2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974327; cv=fail; b=Mbm/41DZOlpi7wCUVEDxNpTiM4OZwxaTgqRixIh/z6vY+Zr6iovPSgH6jOXVXZTiAwjocSJw4sqiDLMHrY3M5msje2eRVtnGU0u0wLZZ6yp5ZvZe1/P/hEeO2LWD1Hi3bc8XYDFni6YjgplEcwNuwoLEss9qFhbP9ikNRQzPJI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974327; c=relaxed/simple;
	bh=hGY0aZ2pkvJy0ri57i/f7i49Ef7mViQiA4B9s/3dkZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6r2kgnya6F8/OhZcBcq0qB/uF1/AqZivcZLph5M0c28VSwT9zxCEy03ZiSk2/6+bm/QXZxCk4BcurESMulbi36MlEqkKda4vvaGto2AFuWrfcdLcFTjU0HCLiVLVfiuaZYR5vXMtxZXEo/Som1w7e4l9/rybzptHbSlMvr1irY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=umVpiWhr; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9Tjpi7fcvlURIg69BAMZzt0Q4AWeuQeHV/c5LRSZs1km0s+ZqncOkXrsuUfAgQ696qaWiwzscfvl1PiOnpHgnX1t7gBwJmG3rtfOWToRNDTV6OY6r6zX0y+yuCazPDjIO9eVYMUolptIxbhe/KMFyTTq/KNohyFi9hxxusdnJgcHmVyWl8qsp6gACcuH2FVhkTw6tLxaM2u4rOeLXD5Ee89a7mLm7/JCNy20CQcs38UZrcyft4Dibf2jnw6Tbc/CWE7qEQZA2Vkvug3cYy97pa+FZ001b0ThSV1EGKZ6wpacGyX6/LvyegFphM0mtjbEMhpxGsScerTJnwNM7C+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15ew4f9ZgZLu4/xHtI+LHBBQOnr2HhxMiiEK/WZoX5s=;
 b=eV8+w/NSvT3wOUwD1dzegW7hv6oBKv6st+oIidzwS8L430UPt1Gu/7UqMpUe2KWl8eDzwzz231TjYR7yOEMCLaLupRIWJyZizZwoMmXy3RKi4LuYwJsXExNyBss8EIJUR0C2FRJTIQtlZC7aEVGsXNHihWXARnBibhAfW7Nq6Wt+5R7o2LmBEH/xhvUuaVCQVBUgqhY5mP/HXbK96cpei8vhbQ/6HVJWytQniNNFhjl5WsqQAAIVUMI7x5iQhylnvL1Blkm3rfl9MmqBTAGP+2a95DlMaX8z1qk7SNm1wiYpvSIOFhybnlfq3HZNeeogkMurrjOccNI+ViP/eEPSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15ew4f9ZgZLu4/xHtI+LHBBQOnr2HhxMiiEK/WZoX5s=;
 b=umVpiWhr/DYllRDBrFIb0VsItuVNbsLGz3RbM3/F+AH/aGhbabAY2b45dG1Z3UX8ZYPFqo9/TOiGxv2Pafmfbhy1RiQvo7xKOw85TtjCfxSbmrZyWi5VQiK8vBcoxMOlVZv7nXWWwu/PL0bY5sQaJbaPfOSvYMEUL3B0evHqGsA=
Received: from PH7PR17CA0021.namprd17.prod.outlook.com (2603:10b6:510:324::27)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 15:58:43 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::82) by PH7PR17CA0021.outlook.office365.com
 (2603:10b6:510:324::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 15:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:58:42 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:58:39 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 02/15] x86/sev: Rename snp_init() in the boot/compressed/sev.c file
Date: Wed, 24 Apr 2024 10:57:58 -0500
Message-ID: <afda29585c2724b9698003f24cefa77eb35f4ffb.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c73520-3685-40f2-9a19-08dc64776a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400014|36860700004|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Orpz8IxLAX9h6TLjK26euNOyQAe+4/vOXQ6Vvp2bu3s2jdp4I8t7OJo9ho4m?=
 =?us-ascii?Q?PCvG7I+q2XK2vxGxVnOwbmDn34ICF+IGhLwVmQnS4EVN5kIUojbjRH4ShgG9?=
 =?us-ascii?Q?1FKQVZ2lVS55Sash1EvNfufTM/WUSnUZ8zNKB+zVBjUMrQ/kwD+cB+dtK2rN?=
 =?us-ascii?Q?YYqU1letawhnljdraicrayMXzjJgbKG9OHzDSbPHTyd9QvPd3aycjCx6cqAV?=
 =?us-ascii?Q?knOhWK2etrCsgg5vJLYP7pu5KbXJR6DwLOA7qkpuu0OHhsPUOUR6wc2Ie8mo?=
 =?us-ascii?Q?yDcCYkCUtsvRww2z/T/AfwIUXx56/jaKpIq2Jdz3t/3/ZBmE/jcR+9GD4wDJ?=
 =?us-ascii?Q?WHNENsRBe3Wz3eo9jILPHKFIuK6uLNGz/kOcTJkBgbz9xkVZm0DBSYBMcGJf?=
 =?us-ascii?Q?372SuiHAhg7mNZPMn4Ky7KGcKjy+ZbUXcANeYitNwcO6+sKY8VuEHvSJI2G/?=
 =?us-ascii?Q?qwVoYpVXWpS9eJpmupfVoK2vX9Hh7+eDXIMZsGR5sOlz+uhl9wBOWaMcSYRH?=
 =?us-ascii?Q?aMQSHVkdJT3OP4MnxdvTD6HwEfkJOVqL61J5GVKdRqESPoBP9+9tEhKg1y2E?=
 =?us-ascii?Q?04ckep1VCNR+BvmZQ3MDFH8Gm+fDvfK+5HBJxtGH3XUq6ibIxMX+p0nn+2JY?=
 =?us-ascii?Q?KZ+5Ln17D1Ez09exYjYTeUlCjUoZfBB8hIuhFJ798KNsBaYTy92bG+j7a+uV?=
 =?us-ascii?Q?C1M92HWk3mTDHTc4sUk3BV6oOaJUzPyilnLVmURQe7xNBCvwLjKfYeF4eRel?=
 =?us-ascii?Q?V5cq6JLlc9kFJ8tM0pS1CjtKtBvf7aUqf+D2dGuHTR1ix2eknggOGpLC6sDK?=
 =?us-ascii?Q?Tz5HFSrnHsiJLaXce90gwclI01ou0l3tUImUg0vOBsSm6UlXklfhoJAMqvFo?=
 =?us-ascii?Q?Kj3cOxzltnJXZ9dA/pHQRPoZalIxlXG5IkZ+5u2pqbzGoGkHgYxSLRZbwaMw?=
 =?us-ascii?Q?SdbvU+2CZ6BAiuitDCCsKLSxOd7T00Rt841OBZnRv7FM/cEuKXYsPjjJhVox?=
 =?us-ascii?Q?L6G5wRXt6wHbi/A2+JSZ2o5I1YEUVGxqcntX7ahgl2hexVRY5IPIgFUmuJIt?=
 =?us-ascii?Q?Emh96suppSOW7jKW43OP9e6dGtCN4B8QfqAJ52EeWIemmRQ/eWw3P2N4xzts?=
 =?us-ascii?Q?anuF2pXdtY4hjMwMc0pY578r/yjp29GvhiWlqaBFObpWZYWl2+ff26mEutLg?=
 =?us-ascii?Q?+aZJW59cCjDw5tXcjzyfADEQA1d60raUFjcDlIouhIRnblulYxwbnERkojba?=
 =?us-ascii?Q?vvKsAi9CeI8COUAkZUMBObF4GerRboTu34WZscOheMPUyM3Lkj7LfEnwGuip?=
 =?us-ascii?Q?zrIRRfU90PVZra6Aonbns9kvh//vWX7+NaDy9KHpHzQIZM0R2feY4OOJk+sa?=
 =?us-ascii?Q?alSOgHBD+2hth4TFZeEM/H/FiFtV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:58:42.7314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c73520-3685-40f2-9a19-08dc64776a66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482

The snp_init() function in boot/compressed/sev.c is local to that file, is
not called from outside of the file and is independent of the snp_init()
function in kernel/sev.c. Change the name to better differentiate when
each function is used.

Move the renamed snp_init() and related functions up in the file to avoid
having to add a forward declaration and make the function static.

No functional change.

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


