Return-Path: <linux-kernel+bounces-131690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A68F898ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABDF1C22F67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EAF12C7FA;
	Thu,  4 Apr 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b8LTzeY5"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7412A172;
	Thu,  4 Apr 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243670; cv=fail; b=Y2u+AQSeYcQfLkgICtLOXLGZzSjmEsaneJ+5x2pGFQUgv+vBwvI+w31L/fxPR8HevhDEEmg2r9Ri50VmOqEExxdkoQVOGxp18S+ZeqAs5oPrPxCfdvbQP8QS2hJPIKmS1xrDuPKB4C6E9WZrN8omZJ92cbWieksJzDMlgQs4Fag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243670; c=relaxed/simple;
	bh=yMCkcMcMfBryg42eoKZvhY+5T8pIjEi4gap3WRYUE48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRvxc0PJi/iIUFqne0QDOYnEQu8wpD5h1c7SuCVKF3EMh04HPyj9ZoBxhGEqa8b72c1c/7ZpjYNBse5lsfCjMZZys7qqXdy8Vh0r7+8LrAKn7QExhr/7355Z7kxz6ec4y1edBs1QzrLosi10+6KZNvzs3KKVQaezPh/ORGdlmvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b8LTzeY5; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHSOu7TzbEJFv3akHeFy292PDJUyFJa5Cx1FzIg3t0arF3dYQ6b+8APMBkVRQ9pmmkYFV3fglnMg9a5JJONcBtKGtnJaO77pVdcW6yPwY1yTLW/EOBXbpgbHTzkupwIAjceTcOzLGngWZiJA5hnGPb4vfq8Sw3V8V8I1H7pAjJg0BJaeUZ8e+SFsD3ctRud/RapV1KCdK6QMwcVL4D3Eaq1SWWJBtHjgqWTsP1ul8GBrDR0zTsTHSZfdvb0OTKZ5m3q5CK/O7sPdix4uL+Kj+bep377tqaW6vLZ8mCOMvXt8C/lg76DaOpe+iLQUnsBH9Bvq4qyNPM2cU8Mi27VoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baqrihR7gr1slglaOsLWSPt9ZTz6c2VFnWfH+kGz6yc=;
 b=gAKJKhEpH1Q4Rdu/njQX8o4hoVz8/r/i9IExuoSY/dUPXGiHVQv1iYa4IezrBFbAIDJktcJkq9w1dfHzwzg33nnLt6aboVEnqtIuF+JlSwmMLX2PYwm4SiFNbY9Uerlq7+bahilriCZJLsOV9g4NE3SkCbnF0T95N9HIrStB852bak41kX7/SiKp+5qeUzbCnakSoQrO5Hwn2G7K8le5fuxdGVK+/s/jWwe/VOKAh9GX/4rXu1Bq4DrpLnr2DJjAFt3ZAscKQWfQNEv8VZQO3X9Nv1NRG49x0+UIgN/xsXQcb9fSRW7a4oaL8JVRIUV+WMRBnDbzYnzgCiiHNHF8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baqrihR7gr1slglaOsLWSPt9ZTz6c2VFnWfH+kGz6yc=;
 b=b8LTzeY5e8iesnvjrKY2gBRGEjGwTMz5aU3jHgTcBAoSmIRLqlU3/FbhBF+CeHadzzjImTrIX3Y5KHW/Su3zFevOlPfLoTQmqryFCcm6pvYpcNdvcJgx5+clS94loze4eSzqsiIm8IxfniDxjS3uhtUfQ6p/Enx7AjCd2HbW7Yc=
Received: from DM6PR05CA0044.namprd05.prod.outlook.com (2603:10b6:5:335::13)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 15:14:24 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::b5) by DM6PR05CA0044.outlook.office365.com
 (2603:10b6:5:335::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:24 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:12 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 08/16] x86/mce/amd: Clean up enable_deferred_error_interrupt()
Date: Thu, 4 Apr 2024 10:13:51 -0500
Message-ID: <20240404151359.47970-9-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 421092e0-9573-47f4-cf9b-08dc54b9e9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZoxqSwgS1OxLj3H5byfyNMlmedomcByqS07iwR819p9yJZe3UbOznvpnkLmql8XAnG0VBIlQ64lDaByy3dtTMOkBowaY+FFvgknIX4S3rrcrRnJIa7d2Woe/mEywWpGvwyMgnBnpiagwdnH+zic+TmKqXGDJMUAVL2adv/nQ8LVzU1J/Ba93OkNf/rD/8V+yqQXNgjTwWGWHjxa9E/TvY775Cf2M8AZZjMal1FAPKTIhMwynAXXwYWYtEo1c4P95fJzbtIaD5sbeBmytxoqthYj8a3OLMxCJn0auD02WuV5TNnL9qzpOZwF85D/0tAhMSockoknUOJfIgVI+rN9KKJMRrzcK5hlh6zK2v2o6QAE7ajDVnNGCylaSjhdbJxgMGRd3+zXtesEws/uccFvSb5vWcRTMTMNPbFdNB3+QIpiVfW5TpCtcWgzlbj91MOSYPFpaa8VV3c6wKs0l3PaQA7UiBd2H2nZUYtq4sSMxI3v4YC4/gSuJSHFlhT7+12kik0T0kPBiCa7mzy2z3HbYlx7/vSS3/q1gIVor7cKaTQ3H13E+eEJIhdAyH/EuY+HO8yJ8U+LxFCfZsljYP5ymtnjWaHZc69zLEvZ6j/5ZVXQQeeqo7tIrBpv4tRjyMETLTteKz1wOZDkr/Fjzpu7nl5SYE/vaOnPW3evD/XCczqhv3omoWPETds/xResG08w0jmzP9ldLIqnaLjP2yuAGPg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:24.5454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421092e0-9573-47f4-cf9b-08dc54b9e9d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

Switch to bitops to help with clarity. Also, avoid an unnecessary
wrmsr() for SMCA systems.

Use the updated name for MSR 0xC000_0410 to match the documentation for
Family 0x17 and later systems.

This MSR is used for setting up both Deferred and MCA Thresholding
interrupts on current systems. So read it once during init and pass to
functions that need it. Start with the Deferred error interrupt case.
The MCA Thresholding interrupt case will be handled during refactoring.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-13-yazen.ghannam@amd.com
    
    v1->v2:
    * Remove invalid SMCA check in get_mca_intr_cfg(). (Yazen)

 arch/x86/kernel/cpu/mce/amd.c | 46 +++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 32628a30a5c1..f59f4a1c9b21 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -44,11 +44,11 @@
 #define MASK_BLKPTR_LO    0xFF000000
 #define MCG_XBLK_ADDR     0xC0000400
 
-/* Deferred error settings */
+/* MCA Interrupt Configuration register, one per CPU */
 #define MSR_CU_DEF_ERR		0xC0000410
-#define MASK_DEF_LVTOFF		0x000000F0
-#define MASK_DEF_INT_TYPE	0x00000006
-#define DEF_INT_TYPE_APIC	0x2
+#define MSR_MCA_INTR_CFG		0xC0000410
+#define INTR_CFG_DFR_LVT_OFFSET		GENMASK_ULL(7, 4)
+#define INTR_CFG_LEGACY_DFR_INTR_TYPE	GENMASK_ULL(2, 1)
 #define INTR_TYPE_APIC			0x1
 
 /* Scalable MCA: */
@@ -574,30 +574,30 @@ static int setup_APIC_mce_threshold(int reserved, int new)
 	return reserved;
 }
 
-static void enable_deferred_error_interrupt(void)
+static void enable_deferred_error_interrupt(u64 mca_intr_cfg)
 {
-	u32 low = 0, high = 0, def_new;
+	u8 dfr_offset;
 
-	if (!mce_flags.succor)
-		return;
-
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
+	if (!mca_intr_cfg)
 		return;
 
 	/*
 	 * Trust the value from hardware.
 	 * If there's a conflict, then setup_APIC_eilvt() will throw an error.
 	 */
-	def_new = (low & MASK_DEF_LVTOFF) >> 4;
-	if (setup_APIC_eilvt(def_new, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+	dfr_offset = FIELD_GET(INTR_CFG_DFR_LVT_OFFSET, mca_intr_cfg);
+	if (setup_APIC_eilvt(dfr_offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
 		return;
 
 	deferred_error_int_vector = amd_deferred_error_interrupt;
 
-	if (!mce_flags.smca)
-		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
+	if (mce_flags.smca)
+		return;
 
-	wrmsr(MSR_CU_DEF_ERR, low, high);
+	mca_intr_cfg &= ~INTR_CFG_LEGACY_DFR_INTR_TYPE;
+	mca_intr_cfg |= FIELD_PREP(INTR_CFG_LEGACY_DFR_INTR_TYPE, INTR_TYPE_APIC);
+
+	wrmsrl(MSR_MCA_INTR_CFG, mca_intr_cfg);
 }
 
 static u32 smca_get_block_address(unsigned int bank, unsigned int block,
@@ -751,14 +751,28 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 		wrmsrl(MSR_K7_HWCR, hwcr);
 }
 
+static u64 get_mca_intr_cfg(void)
+{
+	u64 mca_intr_cfg;
+
+	if (!mce_flags.succor)
+		return 0;
+
+	if (rdmsrl_safe(MSR_MCA_INTR_CFG, &mca_intr_cfg))
+		return 0;
+
+	return mca_intr_cfg;
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
 	unsigned int bank, block, cpu = smp_processor_id();
+	u64 mca_intr_cfg = get_mca_intr_cfg();
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
-	enable_deferred_error_interrupt();
+	enable_deferred_error_interrupt(mca_intr_cfg);
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
-- 
2.34.1


