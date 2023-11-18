Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822007F02A1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjKRTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjKRTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:18 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2459D54;
        Sat, 18 Nov 2023 11:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4BYpB1ols22hJ9WtRMJA6ObVVasRBLkpNRlS8pBCP/RN3GSb7lBShGKP1F91nG1dFzimJ4ftxoqa0fdlpDaSkBDmKTyVb2CAhqzjImgJ1RgfoJNzMxbd/y9HzFnmc4vW3ffTFOFbwRobSC2TDz0l/dH1GU2L6hIsVb0ehE0Tya55X0I6L0uxNcwQHpOmg9BemAdCZ4cImkFXcxWd3gdmCiZ704EECkn9Uv+IGfhyLzucJ53AbgGa68PvYgtbOre2emveWVR4VAHeYrTs086rPcvqKUCvG8Y4eT92n9jNkVvMzkPxG8N4ul0xY8/OkdWboGVTPSfWJDKP/qHczOgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCX2b74YqOZid5i2qA8UACVPtiAsbHP7fKr7YTf7RPw=;
 b=F069viHCZN8+czWvTyVa7Q5Ls0ZE3MZfpeHmM2tyWOYhgfqTiUeehg6X4tSDfbBVsSwcaAyRbg+DjBU3kvGG9bPnplnnQghExaGYMSqMpOP7A3CQyORxLadJj5hRLwYAPQrAB7ML3vakZQA/LYUxFknWt98ItcFh2CX6bOexEVhzhBLAuivPd3NYXrxaXhhVk/A0lDumPWvsv+4Vci1uRck83l8oiTvz5tCoC1BiqWi5NUhl3stVf0olInzWKz8/HMZjuErQ8pDg7vA8cv+Rk7RZwa/QOCh89YmrVnlttHcYD558Ng9h5gY5IX/jo4/l79txWf2ZJUB5DsRPvx8v+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCX2b74YqOZid5i2qA8UACVPtiAsbHP7fKr7YTf7RPw=;
 b=Npszxh6ZNz96Szam3C5FcPSKIIv63fz5Pl076McgndPjYHVXvptaZ0MfJNmR63mIzRUTVd0NMnZu406jWDSaslFS4Ry/6BqJVCbdbaeyvvON2XDPJUw+Fd7stZ5c7ckETZKbtg5xJ+evtPdgVwWrUyty14963m3RLlB5zl4Ur0o=
Received: from BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::25)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 19:33:10 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::cd) by BLAP220CA0020.outlook.office365.com
 (2603:10b6:208:32c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:10 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:06 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 12/20] x86/mce/amd: Clean up enable_deferred_error_interrupt()
Date:   Sat, 18 Nov 2023 13:32:40 -0600
Message-ID: <20231118193248.1296798-13-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 922e5fd2-c54a-4051-7483-08dbe86d3299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPtLAzPWxVW/zPGioz8m10jwnR7lNFS/do3keZR7XiQuBtE1pezwNaeb2y4pVpVC4HqVS35+MASxRalwMXnnZhRdywxqqoQdJBpH2KPfnnmZTnpzlc/VcNNu0C1gs71RsjbuE2TtwyoNTgD28LRWxEP2U0KzC4V0/qHVtqwYGtYGJfriOSZwmfjNDTjov+Vsf6YdpcfLybcnxU9oit9iwW1hjVVf2oV5Hu1/3+1I+5LQ/YquHk4FPM8CwhJUGmo4JJ3VwB8Yb8alszcRmQdJJG6DF4xG4D5sRLLzwCjEfwWEay3scF0l1UZUyrHojVMJOdf96nSfn/HzB8ozP+k/PqUkB8Jpnf7K0h2LOfsYVdCe480F1pcJAykJfV5+I+MLYo94iB3QAMlbYvr14GKgfe7P8qvcLrEh7FofGKUhXhlL91lF/EdZWHA4Dmgola+JzgO9unFoZEEnerrhAlcpc4Ls1iacc1V/l6scLOVvN0fttEB0sQBhZE+KUIkZwPwRo8TD5J7snj2hPWPXBwmMYWIFoQ72Ny8PQuzXWmZns5lturIsy1edD6qM4FX0163mbWBIlTXPSyR0fQwbzMSm4IyLupcttpl42cGfuCEKo3ztb83mYPuDKxpgExosJU4RF2Yh+04JNz5WPoBLyvMv67x9zn1dFCdlYB9EKnwxC9ETqkYfOVzyOSds3YlRABxSDin+i06UHskEMWDWVg0gVTk5B9mNdjOE3xXONUOe1CLw1u2+9x63IQDO6M708lpDTVeze5oOoGzhMqE8TWnB8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(5660300002)(44832011)(2906002)(47076005)(81166007)(356005)(82740400003)(86362001)(36756003)(336012)(426003)(83380400001)(7696005)(1076003)(26005)(16526019)(2616005)(36860700001)(478600001)(6666004)(41300700001)(8936002)(8676002)(4326008)(70586007)(70206006)(316002)(6916009)(54906003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:10.0585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922e5fd2-c54a-4051-7483-08dbe86d3299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/x86/kernel/cpu/mce/amd.c | 46 +++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9197badd9929..83fdbf42a472 100644
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
@@ -580,30 +580,30 @@ static int setup_APIC_mce_threshold(int reserved, int new)
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
+
+	mca_intr_cfg &= ~INTR_CFG_LEGACY_DFR_INTR_TYPE;
+	mca_intr_cfg |= FIELD_PREP(INTR_CFG_LEGACY_DFR_INTR_TYPE, INTR_TYPE_APIC);
 
-	wrmsr(MSR_CU_DEF_ERR, low, high);
+	wrmsrl(MSR_MCA_INTR_CFG, mca_intr_cfg);
 }
 
 static u32 smca_get_block_address(unsigned int bank, unsigned int block,
@@ -757,14 +757,28 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 		wrmsrl(MSR_K7_HWCR, hwcr);
 }
 
+static u64 get_mca_intr_cfg(void)
+{
+	u64 mca_intr_cfg;
+
+	if (!mce_flags.succor && !mce_flags.smca)
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

