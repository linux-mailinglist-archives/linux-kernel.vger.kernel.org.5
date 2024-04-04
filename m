Return-Path: <linux-kernel+bounces-131697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C3898AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FEF1F2B476
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9864A130AD7;
	Thu,  4 Apr 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gKEdyBAQ"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB212AAF2;
	Thu,  4 Apr 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243673; cv=fail; b=ayE28q+AdONwkjC9QYY0k5EmYNJGl7SgFBj0g+ojEXnUWW4CDpMqA1RQ54H9WmWVUxMHKo9upmxmWkm0VYh+VhoAkiCMYwjKuL7SFmeZsqLdJPGq9jNpFo8SPfT+D/6vM54LvfUZzmjxluB6Oadc1/XLYvRmF9jO/aLT7OxWD9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243673; c=relaxed/simple;
	bh=l1IfGhAprb4MXyxttDnp262mOHHRz2QlO69nfS/Pkus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpomCofvEGlQ1ne1km0ypcPHcm+FwXwZIaEgok4d0lxVxrYDfk0OTy38/iJO06FpSCZhGtA/SrWh6XjMY9BbG/2wea3s4gX+XES8h0YDURelpdSEGdhfJiqWVAw/pbvgEcWbLi+rz9joqiUe9DXE/xawd/v14BlmvqJJVED3yCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gKEdyBAQ; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao6El1XuFphas2y7rXYS2nULKRe/sGZPM1wsAX+L8EgGcHWHHmZd2/1hOHPiKrR5Mu1GBG8lyv3I134jfTCNO4u2T+Qn9SAatAxbYwp/BFu48Aluf/tbtUexM2HRdVfHAPTSaumsjwUCrC0+BvTh/RERAjm/D3TJ57quUMHO3Hw+9DYUGqqZS2Et3+xZ+9T54sThpGQVR393hE+Eqy5NXK/4YfjWxjcXd+/N5l2W0FqabccEotTZ0Vl73KkCCY6YfOc4KGexsHqpp1mMs6AAGxYOYrA70KXcM4Urtg+wPTJykvF7JQSvLBJ4IwhyWMbTe/0kTFPGnvyxqm6/iPonzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Lz+p388J6AoIRShka38TwLszdNjbES/X4b4hJsFWDY=;
 b=QNBeAIyN5qHQcPD+ZUO1Y96WCHC3h/6tFuCyT/kDJtk8ZDOLn/K/kjMAzJGEssbjrlzuFZf6aFN5QK9gDA09fKN44s9RamA77492oMginWOPHdrHrQYnSNl+agyat359oSpFwBplqMKqEluEIx+PJ4Nfvt4Nn7JueKS+ZDJx9w1N3Tl2j6Ao57QXHgCa7MYvqytOUIxl4NwvroNbBodmWm7RTg7844K8usPzjtUBMNJVnXeUsCteulySxmhRImYwEYsFWCkbKwM+7jN1wNEQsS6ezP2yoIjidt1UHmoEX305Sp0Tc2IFy0omdidZ6aCkKpxo+qEd2PTKMURBiLoMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Lz+p388J6AoIRShka38TwLszdNjbES/X4b4hJsFWDY=;
 b=gKEdyBAQowiKZdJ9c1hmF5eJ863fv5PWFyXBC12rNm2WmQC3pMxMeGdlNEHtJywHMszrNMANnXZgp2ONv/JiYeBHOUTycoJogfPB0awjIdBO71dhHrBHqXAixPSxbSKit2GaGFzk/823+RlHd9i7A8Xm3EdgAQxRdaDPvYitr3c=
Received: from DM6PR05CA0041.namprd05.prod.outlook.com (2603:10b6:5:335::10)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:25 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::4a) by DM6PR05CA0041.outlook.office365.com
 (2603:10b6:5:335::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:25 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:12 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 09/16] x86/mce: Unify AMD THR handler with MCA Polling
Date: Thu, 4 Apr 2024 10:13:52 -0500
Message-ID: <20240404151359.47970-10-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: e02aaa20-7d65-4899-2dbe-08dc54b9ea33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kJ0JT0GRpJjWZdaSmYS31xUXpQ2tFvYUB0uwFEr4AXuDg4IgfRX1rf+noQ3lDNg2tEEKJvGc4Ac6x2ot+3SidzfZDJgkmpNdV1C2jwOe1JRgqeKyqyf0oqMGjbzD4EGs58RyIjQPWD6XgjjAEZMJ08zU/7FMkkwF448kkoX3ZSYirASL2a1w2G9iRVU0eix15S8RANnYBAvGby5JSnQt8/4mXUr306B4Gbafnbt0AuIXlIuGnrLOXufrR+99CEQUfyegIx9DDLpw7d2woOrD/1lseRkyll9Rw/+yALW2KeCc5B3iye6jPGv7Z5DhpPRcxgmDBW5IxuXKVaQw4bH7hhu+92nH0yLdVQXNDqe5ij3MM8RGxfv1J3VS4mJJN7KompsN4l22qfG9n4+sVDcJjIWiTM+gYfgFaFjQFI5wMLUPdN5EqO9HnztUxPBKOV3+iz5CxIDyxbS0scf+gFZ0uiMzLDKyx6c9Ng7kbxrHJQFgVoK61egS4plw1pz52QzS8W2s8sAetB+E5+5d7xasJHiiIDO/MCd5VmZQK33L7bcfw0GgCJKCZE/8DAkGHWmtkQwk6QDxvRdZ1DTZulIqhcC1mJzEQ2I6hBDeR/IuozQqUwH/+Cb2C3YUlnp3i/wyebST8qWwEfbKE/EWslWkoUpLbtU9M99MeeYpWXJAonmQG5jFloiBsXQhRu0sy7684lXiYvzyz+0sKSNRJhRo1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:25.2485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e02aaa20-7d65-4899-2dbe-08dc54b9ea33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829

AMD systems optionally support an MCA Thresholding interrupt. The
interrupt should be used as another signal to trigger MCA polling. This
is similar to how the Intel Corrected Machine Check interrupt (CMCI) is
handled.

AMD MCA Thresholding is managed using the MCA_MISC registers within an
MCA bank. The OS will need to modify the hardware error count field in
order to reset the threshold limit and rearm the interrupt. Management
of the MCA_MISC register should be done as a follow up to the basic MCA
polling flow. It should not be the main focus of the interrupt handler.

Furthermore, future systems will have the ability to send an MCA
Thresholding interrupt to the OS even when the OS does not manage the
feature, i.e. MCA_MISC registers are Read-as-Zero/Locked.

Call the common MCA polling function when handling the MCA Thresholding
interrupt. This will allow the OS to find any valid errors whether or
not the MCA Thresholding feature is OS-managed. Also, this allows the
common MCA polling options and kernel parameters to apply to AMD
systems.

Add a callback to the MCA polling function to handle vendor-specific
operations. Start by handling the AMD MCA Thresholding "block reset"
flow.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-14-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/kernel/cpu/mce/amd.c      | 57 ++++++++++++++----------------
 arch/x86/kernel/cpu/mce/core.c     |  8 +++++
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f59f4a1c9b21..75195d6fe971 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -979,12 +979,7 @@ static void amd_deferred_error_interrupt(void)
 		log_error_deferred(bank);
 }
 
-static void log_error_thresholding(unsigned int bank, u64 misc)
-{
-	_log_error_deferred(bank, misc);
-}
-
-static void log_and_reset_block(struct threshold_block *block)
+static void reset_block(struct threshold_block *block)
 {
 	struct thresh_restart tr;
 	u32 low = 0, high = 0;
@@ -998,49 +993,51 @@ static void log_and_reset_block(struct threshold_block *block)
 	if (!(high & MASK_OVERFLOW_HI))
 		return;
 
-	/* Log the MCE which caused the threshold event. */
-	log_error_thresholding(block->bank, ((u64)high << 32) | low);
-
 	/* Reset threshold block after logging error. */
 	memset(&tr, 0, sizeof(tr));
 	tr.b = block;
 	threshold_restart_bank(&tr);
 }
 
-/*
- * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
- * goes off when error_count reaches threshold_limit.
- */
-static void amd_threshold_interrupt(void)
+static void reset_thr_blocks(unsigned int bank)
 {
 	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
-	unsigned int bank, cpu = smp_processor_id();
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
 	 * handler is installed at boot time, but on a hotplug event the
 	 * interrupt might fire before the data has been initialized.
 	 */
-	if (!bp)
+	if (!bp || !bp[bank])
 		return;
 
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
-			continue;
+	first_block = bp[bank]->blocks;
+	if (!first_block)
+		return;
 
-		first_block = bp[bank]->blocks;
-		if (!first_block)
-			continue;
+	/*
+	 * The first block is also the head of the list. Check it first
+	 * before iterating over the rest.
+	 */
+	reset_block(first_block);
+	list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
+		reset_block(block);
+}
 
-		/*
-		 * The first block is also the head of the list. Check it first
-		 * before iterating over the rest.
-		 */
-		log_and_reset_block(first_block);
-		list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
-			log_and_reset_block(block);
-	}
+/*
+ * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
+ * goes off when error_count reaches threshold_limit.
+ */
+static void amd_threshold_interrupt(void)
+{
+	/* Check all banks for now. This could be optimized in the future. */
+	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_poll_banks));
+}
+
+void amd_handle_error(struct mce *m)
+{
+	reset_thr_blocks(m->bank);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7a857b33f515..75297e7eb980 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -672,6 +672,12 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 	}
 }
 
+static void vendor_handle_error(struct mce *m)
+{
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return amd_handle_error(m);
+}
+
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
 /*
@@ -787,6 +793,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 			mce_log(&m);
 
 clear_it:
+		vendor_handle_error(&m);
+
 		/*
 		 * Clear state for this bank.
 		 */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index e86e53695828..96b108175ca2 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -267,6 +267,7 @@ void mce_setup_for_cpu(unsigned int cpu, struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
+void amd_handle_error(struct mce *m);
 
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -295,6 +296,7 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 #else
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
+static inline void amd_handle_error(struct mce *m) { }
 static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
-- 
2.34.1


