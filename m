Return-Path: <linux-kernel+bounces-131693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF2B898B22
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73460B2DBA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3254412FB06;
	Thu,  4 Apr 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4idU/gXw"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144912AAF4;
	Thu,  4 Apr 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243672; cv=fail; b=H37U/tBHTT9q0BkIf1gcydwpxjwvUr9fDROm+91Y2GMOkmGZsgo3yjk1++IecJr3WBV2aSVYnE+binQmKcPQZW+KA3J4qu1Ln+EhITHkDHtoSkX3ff4exkqc+JGtsWkUtbfTeIASfnaXWzdc7aprwZNbqwxv6o0vyWfUib0vRXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243672; c=relaxed/simple;
	bh=aicdAFUQvlfjeof2BuotaRdK++xylrNMuzB/AcRK9o4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHv0os2YIMOkXWVx9d12aEC8crNowEEW0ydc1L4dgqUo1eiomhJedg4UIcKck1ULcLa2sGFBqd8b3MeJM5Q3ts1t+GT4/2oR0ksdyHSD2CZZ2bSwtrrZGc0cFGwSkkbpHeC0aQWqlWudZyfZGKqWJkZgKJmCzjAD+vTay6BVAzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4idU/gXw; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaLLKlYyIKBo5CY0MdlvrNs3VCMfVkNo0SgkAY+sQcC8czl/GitfRvmEMPR+ekPLAC0Z7rprBoohgCuD7uY+rNSxeFrXLJ0aBpz5bwWNq3LCxtWi5KTXOEKPibS+pxFZ1T61QfumG8e2NvknCsWGK+842wxRnSQoytvjNcP92NUZL1tZhJm/L+Zs9N6ekq9FS+tiGKSXmrMKcPUVVeiErs/IGThOYSx0eBHWtACVlhYhGX+FoOx9DkVbewcskmKi7NQf6piCTOQ2wSz7WohvnrsBWOCDffmR1Y6V7X2Xf/RKkxiit0pst0Y4z+D0OnD2jDSIjJq+sNaKY3w68Ew+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jf6CKd1WvxPatLAOJhdUzKqpCUxGqOIbKpOseiEWfI=;
 b=lqIxcBpqwLX0GbsOTnyVDlPKJNSflP0Kii4CQNgXGg4q0urfehw1duc1az7ncIsoES97aMbdRKQyM/SJ/gRwcJ20QuqWH/0Nl/2VBps84lc3VjOseugcMnSrYkJPq4VRv4wdN1cv3Qvxp2vvc/pytnnXdFjXCeAKXdP6h6XDc/8vRpBR+1SWKuHk3Zn+kt1bTolGlAwAfGPt6eZjwUr3cQ+iY9Jqgvg3nl7KB74wZfM65ja4H5ag0qyoWwiSjsDwg/g3GQm4U7Eu9jM59lj3NNKHxyVxhnoWO0T1uVmvpulaJkKf48qhIHpCMn2eQz8ynwMLWGyglciLtr71VGk4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jf6CKd1WvxPatLAOJhdUzKqpCUxGqOIbKpOseiEWfI=;
 b=4idU/gXw6v0N+Ddl0zUbKuuPRCDun1fTrTnpRhpAzxB63fnSS2MxfTMjBCZd2J3BgM9jL9d67lLaVKwIsvsGXrfby3G18dTG2OsS66aVwELAVBUbt6rNWfRpX/jqxLhYYwzJ50YU43+c7THMrPqbRWilzLUzr0zcWKGz7YLEup0=
Received: from DM6PR05CA0057.namprd05.prod.outlook.com (2603:10b6:5:335::26)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:27 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::dd) by DM6PR05CA0057.outlook.office365.com
 (2603:10b6:5:335::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:27 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:14 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 12/16] x86/mce/amd: Support SMCA Corrected Error Interrupt
Date: Thu, 4 Apr 2024 10:13:55 -0500
Message-ID: <20240404151359.47970-13-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: e250a6af-8726-40e7-ba70-08dc54b9eba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gkvimopCcH5PK2PxvWW3qr8ATcR123IkkBCLAM4GFGTmADYCH4uq+xY6ffE14fLTZGIkkBnO3I3YadrXMedTRLmY9CPPkMaXiZO1RvI20nF0s3Ef86gPZ2kdRYqBdT7DbajIkc2y0nyEHq3HPoyqpPU8uM+zL8HD/ZJJZgkdUsYkzqPsyFZCQ5gJKI8oqEmN1XT2UQO016MElpJBXjZRDLxyjtXj3A1UalHIjPKeUnOMXcGXOjZmT4BlEkX773NVAuxJ4TH3pMJjF+owAQ6FBcFD/Kk/saRhWtr8u+PgXXdnhzQ1x6CK6gM+m6tapK1F4x+FjuqxyPIHEw2u+Z574UeRm1Izo7TST9+TRgOaDfv0O3a8EWJDi27FxivHLdyBN6zHUb9wHJD03aY9U7mBoNUWGkxk1MKS/cmIyY8hV1kMmlJc2lbL+nWABVwLrE4yoVAO2ffZYQR+mdxaUN1OAQktSe/9rCInHMmsKibzOAkDuXBiXQFhU7rKKN8mDl+NZZUsFbl9m6KoVjMqRntq0iY0vMoKd7VKAAdvD/IVx+W12i7b366RIOvuZp4M2NMwDfANmo2T2J29HrwCnTDTCoUopilmD3PHmsOrSFssR3oeJL0sGqQHZbrecGlgy3k2ga+vJUJMWlhKinlLJnYgG0KZeF7Sdxgoh5qlLn2szWeaORfyQe2i/BC65dLoUbJ6G2InFD3aAgq7/oYY15Obkw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:27.6860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e250a6af-8726-40e7-ba70-08dc54b9eba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188

AMD systems optionally support MCA Thresholding which provides the
ability for hardware to send an interrupt when a set error threshold is
reached. This feature counts errors of all severities, but it is
commonly used to report correctable errors with an interrupt rather than
polling.

Scalable MCA systems allow the Platform to take control of this feature.
In this case, the OS will not see the feature configuration and control
bits in the MCA_MISC* registers. The OS will not receive the MCA
Thresholding interrupt, and it will need to poll for correctable errors.

A "corrected error interrupt" will be available on Scalable MCA systems.
This will be used in the same configuration where the Platform controls
MCA Thresholding. However, the Platform will now be able to send the
MCA Thresholding interrupt to the OS.

Check for the feature bit in the MCA_CONFIG register and attempt to set
up the MCA Thresholding interrupt handler. If successful, set the feature
enable bit in the MCA_CONFIG register to indicate to the Platform that
the OS is ready for the interrupt.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-17-yazen.ghannam@amd.com
    
    v1->v2:
    * Rebase on earlier changes. (Yazen)

 arch/x86/kernel/cpu/mce/amd.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 08ee647cb6ce..a81d911d608e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -47,6 +47,7 @@
 /* MCA Interrupt Configuration register, one per CPU */
 #define MSR_CU_DEF_ERR		0xC0000410
 #define MSR_MCA_INTR_CFG		0xC0000410
+#define INTR_CFG_THR_LVT_OFFSET		GENMASK_ULL(15, 12)
 #define INTR_CFG_DFR_LVT_OFFSET		GENMASK_ULL(7, 4)
 #define INTR_CFG_LEGACY_DFR_INTR_TYPE	GENMASK_ULL(2, 1)
 #define INTR_TYPE_APIC			0x1
@@ -58,8 +59,10 @@
 #define MCI_IPID_HWID_OLD	0xFFF
 
 /* MCA_CONFIG register, one per MCA bank */
+#define CFG_CE_INT_EN			BIT_ULL(40)
 #define CFG_DFR_INT_TYPE		GENMASK_ULL(38, 37)
 #define CFG_MCAX_EN			BIT_ULL(32)
+#define CFG_CE_INT_PRESENT		BIT_ULL(10)
 #define CFG_LSB_IN_STATUS		BIT_ULL(8)
 #define CFG_DFR_INT_SUPP		BIT_ULL(5)
 #define CFG_DFR_LOG_SUPP		BIT_ULL(2)
@@ -352,6 +355,17 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 
 }
 
+static bool smca_thr_handler_enabled(u64 mca_intr_cfg)
+{
+	u8 offset = FIELD_GET(INTR_CFG_THR_LVT_OFFSET, mca_intr_cfg);
+
+	if (setup_APIC_eilvt(offset, THRESHOLD_APIC_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		return false;
+
+	mce_threshold_vector = amd_threshold_interrupt;
+	return true;
+}
+
 /* SMCA sets the Deferred Error Interrupt type per bank. */
 static void configure_smca_dfr(unsigned int bank, u64 *mca_config)
 {
@@ -375,7 +389,7 @@ static void configure_smca_dfr(unsigned int bank, u64 *mca_config)
 }
 
 /* Set appropriate bits in MCA_CONFIG. */
-static void configure_smca(unsigned int bank)
+static void configure_smca(unsigned int bank, u64 mca_intr_cfg)
 {
 	u64 mca_config;
 
@@ -399,6 +413,9 @@ static void configure_smca(unsigned int bank)
 	if (FIELD_GET(CFG_LSB_IN_STATUS, mca_config))
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = true;
 
+	if (FIELD_GET(CFG_CE_INT_PRESENT, mca_config) && smca_thr_handler_enabled(mca_intr_cfg))
+		mca_config |= FIELD_PREP(CFG_CE_INT_EN, 0x1);
+
 	wrmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_config);
 }
 
@@ -791,7 +808,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		if (mce_flags.smca)
 			smca_configure_old(bank, cpu);
 
-		configure_smca(bank);
+		configure_smca(bank, mca_intr_cfg);
 		disable_err_thresholding(c, bank);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
-- 
2.34.1


