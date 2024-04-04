Return-Path: <linux-kernel+bounces-131701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7E1898ADD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B9F2833CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE2132C36;
	Thu,  4 Apr 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ytNh7Vg2"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6C12D76B;
	Thu,  4 Apr 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243676; cv=fail; b=bHVjsDBqU4XCGQJiGbtFTZmPYDtv/P/hyN89Vu1yASp6lSPf6VPKph84UwLj2Vgvty+uvZpHSYzL3aVbjDhaWP6hNq7za+wZRccI2yDJcRFFxKa1/Qq94vVRYa5/8Zl3jIRL7fLqcik+gYZJ45jTa7pr2ipD3iQZ9VmKgfAyHTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243676; c=relaxed/simple;
	bh=rEsvVp68GCtkyB58v7Zz59yEpCvnBk8M//vuPQPHyu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyWPSdn3TOkRd4/7Krpap8fmLE/t5eXDdd0Ac9BzNROE9hdCeRUYR0EgT10fxFgi66ZYZmoWvMho2yECZMg4Tgsb5l1/kydzXT0TY4WIHEO+jD8U+if/5o/4xaNGu37UQP0r9h/I/L3HUa03RDCMG9A6n8Ltq8WD2tycMwQK1TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ytNh7Vg2; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6Nlv/mR7ixsPmYKj7/9fMXKv3+3mEoCXyK0OgT4ublIGJzJK3GZRB7NHinP1jIFFqBbBBG1IOO4P3PSMGnDkZCYGzyP6jFof3kPMQdnCwoTEz8JKeKYnullthEA5wCM90jJo0d0+63xB4ZarzDKXVxxWPgpUT+YJ94D+FvWLqDUdThA5yp1+D8so9hkKaMOoi0k/iPiPbaHnF6g3IJR7ZeSWTe+1q+7/a0kyjQ/ZWfdIZqXuNoY21+etUTOLMKkDt9jWNwhzlFNKesm4/vJNFPpAQMna9cEuyXv3XgNlytU3vFtsJTGCRQTRVe59rXzjVi8DGoonMEgweY6QyZ8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxfzmX3za9sE4uwVkeaWKWNez20Kcsh8WGOOETPLKl8=;
 b=V/qWcWfR2/PnUp0uOSBrAy+khMSMeuLWqALy55S5AxhrY4qYzWnzNhDjOzDKoZL3YqA8ZIrX8CquD5aLrJj7I/AdfEr56XHTkOmC9nZ10Iv4qiBNq6s6GLx+LJYDlRHQgWtmlLLHS6acIvO9L90ECRelVa6cPQnyxp9isTA/P6Bm+I+tLCbcE8yYRCVa87p0PV+znnEUQY3JvxHV1ASTw/vIZBuf467Cg2iSXOLEr0U3m3tE6oSsh9DhO9HUxdbi54Ur54UhtSCuVbQvSUi4waz9s3gNb0NBaCW6re7zb+wDJCKr4w+uGp93wKWHFqfWc+HAFIBRTTv4WwWPrQEsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxfzmX3za9sE4uwVkeaWKWNez20Kcsh8WGOOETPLKl8=;
 b=ytNh7Vg2PVHZCu0m3sxqPnxKtqJqlTTtn3Ke2fc4iqLXerwuDSAGne5LmIiicUxEZw4yVBNIr+z2GdtuiGIBuTukMEdWpfcEWP/yr6sEbOh25y6vpcDgAsRHJg37fKFxs2cEchi5/I6OBPkeuV0BpnKJm6c12B1B1lo+1sN7Xww=
Received: from DM6PR18CA0025.namprd18.prod.outlook.com (2603:10b6:5:15b::38)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:27 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::12) by DM6PR18CA0025.outlook.office365.com
 (2603:10b6:5:15b::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:22 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:11 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 05/16] x86/mce/amd: Clean up SMCA configuration
Date: Thu, 4 Apr 2024 10:13:48 -0500
Message-ID: <20240404151359.47970-6-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404151359.47970-1-yazen.ghannam@amd.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e17c1f9-5229-4c0e-d545-08dc54b9e8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OQVVt6NJ9NcFBfWeDje9cLCVg3+gnWvGf3EyzF26tBeuW16thwezrsbU/T0W16mdbe0fgNvahZVyP7gRmiUP57uSqbgXA1y1V/n9KLx12FnR9831m+C4CDAm09Wh0gvoO2y63JvKoWuZpUIEQLOqNiyZm3KT/RedBdqBOADMMTjZSl5xyBDYAtHrj7qbUtRwpFaBqP0jTolTezuvY6vuZ/FlpPomkCsZgITdbTKAZKsLvpEe4cHJSvVh47T/fBxwpuMPbz+eAYfCgYW/t7v4uM4UHbBRB6Z335XhNnz//IyDYzwuTLheurvageDEP9l7gzfZ66ST2RtodvpAMzIzadwxvN5muWx25TFBKKAnpe1aUmyeZVRwN89cgzjQxEou7/V2V43XN5hFkhgyZoTJljnNtjq4I6nzTxQZE189xkL7M2JFN44C6HNUubZKi1k+a2rbrN8kYUyijSZgVkXkl/ZSX22OMLyltZTbog68mMbXTAKNmbOjMLJigrsLpWM1MUeDlzGZtC7OTQzAM5r1ByA1cZGorALlqj98biJEZ7M7YQOY6X6sr+HwqQF3xDUJZevSjv0z3ae/x4C4MFhbsskRFxXPsyp2UFYdncZwhZV0VM3bs4OhOWWh2KHk4/UdB+cR3bOZIijL5YYzuIh1Om2XwNcNes2Fj7Zjin6uyDevRwHx7l0a5U5Vd7l+ziEyDK0K+gMushXoq9PrkrXlbQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:22.9933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e17c1f9-5229-4c0e-d545-08dc54b9e8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372

The current SMCA configuration function does more than just configure
SMCA features. It also detects and caches the SMCA bank types.

However, the bank type caching flow will be removed during the init path
clean up.

Define a new function that only configures SMCA features. This will
operate on the MCA_CONFIG MSR, so include updated register field
definitions using bitops.

Leave old code until init path is cleaned up.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-10-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/kernel/cpu/mce/amd.c | 84 ++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c76bc158b6b6..3093fed06194 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -50,6 +50,7 @@
 #define MASK_DEF_INT_TYPE	0x00000006
 #define DEF_LVT_OFF		0x2
 #define DEF_INT_TYPE_APIC	0x2
+#define INTR_TYPE_APIC			0x1
 
 /* Scalable MCA: */
 #define MCI_IPID_MCATYPE	GENMASK_ULL(47, 44)
@@ -57,6 +58,12 @@
 #define MCI_IPID_MCATYPE_OLD	0xFFFF0000
 #define MCI_IPID_HWID_OLD	0xFFF
 
+/* MCA_CONFIG register, one per MCA bank */
+#define CFG_DFR_INT_TYPE		GENMASK_ULL(38, 37)
+#define CFG_MCAX_EN			BIT_ULL(32)
+#define CFG_LSB_IN_STATUS		BIT_ULL(8)
+#define CFG_DFR_INT_SUPP		BIT_ULL(5)
+
 /* Threshold LVT offset is at MSR0xC0000410[15:12] */
 #define SMCA_THR_LVT_OFF	0xF000
 
@@ -344,45 +351,51 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 
 }
 
-static void smca_configure(unsigned int bank, unsigned int cpu)
+/* Set appropriate bits in MCA_CONFIG. */
+static void configure_smca(unsigned int bank)
 {
-	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
-	const struct smca_hwid *s_hwid;
-	unsigned int i, hwid_mcatype;
-	u32 high, low;
-	u32 smca_config = MSR_AMD64_SMCA_MCx_CONFIG(bank);
+	u64 mca_config;
 
-	/* Set appropriate bits in MCA_CONFIG */
-	if (!rdmsr_safe(smca_config, &low, &high)) {
-		/*
-		 * OS is required to set the MCAX bit to acknowledge that it is
-		 * now using the new MSR ranges and new registers under each
-		 * bank. It also means that the OS will configure deferred
-		 * errors in the new MCx_CONFIG register. If the bit is not set,
-		 * uncorrectable errors will cause a system panic.
-		 *
-		 * MCA_CONFIG[MCAX] is bit 32 (0 in the high portion of the MSR.)
-		 */
-		high |= BIT(0);
+	if (!mce_flags.smca)
+		return;
 
-		/*
-		 * SMCA sets the Deferred Error Interrupt type per bank.
-		 *
-		 * MCA_CONFIG[DeferredIntTypeSupported] is bit 5, and tells us
-		 * if the DeferredIntType bit field is available.
-		 *
-		 * MCA_CONFIG[DeferredIntType] is bits [38:37] ([6:5] in the
-		 * high portion of the MSR). OS should set this to 0x1 to enable
-		 * APIC based interrupt. First, check that no interrupt has been
-		 * set.
-		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3))
-			high |= BIT(5);
+	if (rdmsrl_safe(MSR_AMD64_SMCA_MCx_CONFIG(bank), &mca_config))
+		return;
+
+	/*
+	 * OS is required to set the MCAX enable bit to acknowledge that it is
+	 * now using the new MSR ranges and new registers under each
+	 * bank. It also means that the OS will configure deferred
+	 * errors in the new MCA_CONFIG register. If the bit is not set,
+	 * uncorrectable errors will cause a system panic.
+	 */
+	mca_config |= FIELD_PREP(CFG_MCAX_EN, 0x1);
 
-		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
+	/*
+	 * SMCA sets the Deferred Error Interrupt type per bank.
+	 *
+	 * MCA_CONFIG[DeferredIntTypeSupported] is bit 5, and tells us
+	 * if the DeferredIntType bit field is available.
+	 *
+	 * MCA_CONFIG[DeferredIntType] is bits [38:37]. OS should set
+	 * this to 0x1 to enable APIC based interrupt. First, check that
+	 * no interrupt has been set.
+	 */
+	if (FIELD_GET(CFG_DFR_INT_SUPP, mca_config) && !FIELD_GET(CFG_DFR_INT_TYPE, mca_config))
+		mca_config |= FIELD_PREP(CFG_DFR_INT_TYPE, INTR_TYPE_APIC);
 
-		wrmsr(smca_config, low, high);
-	}
+	if (FIELD_GET(CFG_LSB_IN_STATUS, mca_config))
+		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = true;
+
+	wrmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_config);
+}
+
+static void smca_configure_old(unsigned int bank, unsigned int cpu)
+{
+	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
+	const struct smca_hwid *s_hwid;
+	unsigned int i, hwid_mcatype;
+	u32 high, low;
 
 	smca_set_misc_banks_map(bank, cpu);
 
@@ -758,8 +771,9 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
-			smca_configure(bank, cpu);
+			smca_configure_old(bank, cpu);
 
+		configure_smca(bank);
 		disable_err_thresholding(c, bank);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
-- 
2.34.1


