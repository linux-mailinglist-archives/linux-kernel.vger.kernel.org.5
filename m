Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80497F02A4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjKRTeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjKRTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F92A1A1;
        Sat, 18 Nov 2023 11:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak6fUYJ3J26xbazA7H6MR/koGtbTSGn1y14aLgGzOp0tcKDeBw+qObjcCzgjBrmTvDqnE0eP2/XuEUTp3a26t5JPQRuN9Ase/HHy3gilCZcXV7aIANIxaPZbu2v4ocsEU++Vgw238SFaXwRTsNrb2MvviWay/yHQ7KKdij0TJk+oYP8QpCKdwPChJ5u8pRkoTrYQH2fAzaoH/Mbf5NRL3Te6aCG9HIvnIq0waZRWl3F70ymeel/mbKD7+WbAka6uWEfksau9L4YjmfZxSWlV5gfL/YDksUlGHblEsOxXz1uh/jcgUFmvmGw60QNUzzoSbKdP7OBWE/Cxcn1Av9EXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6MC8q6jZgi3r0lJ4lVQl465imiOGSgxWM0O6MSYdBU=;
 b=mM8PdXia8ybVDL3NUpwm3UR8+jdmZrbkS51RPOMEQm3WB7t3qFY0DAm6qq/F7V8e1csY940nFRzVWazcxgRH/L5ikTZ6+fNyG2BZ9OXK4eggkHz7gpi5BfQoSWLP+aO1lMCaFWGe1AOxSb+2l0ynULcdyAApsXSBDsv7XTyOffmIyf/r/cIZ1H3ARU5qEKF+vVQHJ6f4OK9gFeVqNmOb2uA13Cp7VBPmINtrciNX7DLjdN6tCggwrtj5POsNRxb3RHysF+pm1TvmD/HRDitIkqQ0D/YG9lIXT+vxqcxod8sAxA3SO8Qw51yNNNoPeREQkDhd1Deg1DFNkYc0GNFiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6MC8q6jZgi3r0lJ4lVQl465imiOGSgxWM0O6MSYdBU=;
 b=gRVr3wzbjTCMaYSDtJyJoKgvF9QoradokzkHjCNYUrh0L5Z83N6PnAGdcMCevIZA2FeOlVYjTh/twJmwzRjtgIRkMc7Q27eSBVF/yfHSAU5rL22FV124Dkc13xzRQ5fUp/BlckouHdo1Hlvxc3Z8SbNq0xaGkvwqeluEc3dWsdc=
Received: from MN2PR10CA0031.namprd10.prod.outlook.com (2603:10b6:208:120::44)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 19:33:10 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::33) by MN2PR10CA0031.outlook.office365.com
 (2603:10b6:208:120::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:10 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:07 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 13/20] x86/mce: Unify AMD THR handler with MCA Polling
Date:   Sat, 18 Nov 2023 13:32:41 -0600
Message-ID: <20231118193248.1296798-14-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118193248.1296798-1-yazen.ghannam@amd.com>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ffbd18-ed28-40d3-c237-08dbe86d32e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wJgmux0inkZdbYIEyBvibwyK9woPWcRR8E/aqdo6vn0eZEsx1WO/jAg2YgZQbQaBA1vpcNdCbX0cVy0bnAlMjUh2+ZLmlS0fAKhbiXYyuDbs6E8GCZWMBlzaiHioCfLDCGcrPVR9d/zzgIdCnjJBPqg5d97oeEZoBpby+l943NjNuCBRoAGv/yUAQZM8U5VkuKJGOiu7OQPNh/uPyD0IdGBdiqlcqsKKjjGRs0n9/yGSHZ4G5iSPyXzzQ3Rpl+qtosnKKis6/QDYtd3gBswx9bHvPva/EllrQg/zgLkRUgfM6kg2yX4iU7NEpVTx5KHP8HZyNHCCBAuEGZUeb6wQ3kljH7YGjrHCvMOv3TsfefrHltjuZySK+Z5eop0QU6s1BjMWYpeER+wEIxqwFvCFK8/73aRMMzqfWbt2QjXc3nkCDpDuBVbD/w5KPQVZGsebKo3DEZg844/Bb0RczIXK6PBo86cC20MvkRrQeC038wRDwDX7sqcJEp5wY4deJmec4asHhNrUq6fqzZ3J2ciKlugpO9shektviWGD+7BW5hhyRnc0dTYNc7agwuoA6po/XuPD2XPQT415r98mJ9vD01YlBeTKeI6J0T1daQ9vTqDtv5M+kZ4S6pzEv/qZyX8cn7hEu4X3njdWLtLGvw8kru9WOGc0VSa+Bw0FbRLpAapcll385eMKe2OMkETpns+haEW0Ida1NsaE2+Y6qAeEiZ3sasRk3aBVFce/1URcBi3NzIf8Xy9tZbsnKdX+0ulzJtdhnGxWON/zg3WT6pXWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(82740400003)(83380400001)(426003)(336012)(16526019)(36756003)(86362001)(40460700003)(36860700001)(81166007)(47076005)(356005)(70206006)(70586007)(54906003)(6916009)(316002)(8676002)(8936002)(4326008)(41300700001)(5660300002)(2906002)(44832011)(1076003)(40480700001)(7696005)(2616005)(26005)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:10.5676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ffbd18-ed28-40d3-c237-08dbe86d32e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/x86/kernel/cpu/mce/amd.c      | 57 ++++++++++++++----------------
 arch/x86/kernel/cpu/mce/core.c     |  8 +++++
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 83fdbf42a472..8735a8b9b7cc 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -981,12 +981,7 @@ static void amd_deferred_error_interrupt(void)
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
@@ -1000,49 +995,51 @@ static void log_and_reset_block(struct threshold_block *block)
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
index 7e86086aa19c..040dc226c6a5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -655,6 +655,12 @@ static noinstr void mce_read_aux(struct mce *m, int i)
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
@@ -760,6 +766,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 			mce_log(&m);
 
 clear_it:
+		vendor_handle_error(&m);
+
 		/*
 		 * Clear state for this bank.
 		 */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 424c7461dcf9..8ed1035f013b 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -215,6 +215,7 @@ void mce_setup_per_cpu(struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
+void amd_handle_error(struct mce *m);
 
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -243,6 +244,7 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 #else
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
+static inline void amd_handle_error(struct mce *m) { }
 static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
-- 
2.34.1

