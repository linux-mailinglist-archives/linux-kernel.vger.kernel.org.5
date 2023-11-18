Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279937F029C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjKRTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjKRTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:16 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B751D47;
        Sat, 18 Nov 2023 11:33:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB1iNoFqjBmK3mwxaq9yPUfaEJhSvP+Q1SB2uS+9hGieCI31g0QM/GfsfwXmGwZUheAed3VIIutOhGUGgSfrD1xlLy7MiiBUgCKtLVyrkKrDZQpd8vUgz04pRjwz+5brfsx66k7CxFbsfzMQUZwpO3Y9885/PKFnApfI8G+2ZB2CilzMaosbe1niFrMTEQZVofgYmf7kBDg2zGpUa/0Y5SpwhFcaDw08rv5pqs0uZua6vEgSycBAmJRz1BBxu6pkrtG+oALO40d45dd+DY4gehOgAlzv/7Ay2T1cTxlPq4kSOqFnaUWuernBcoAcY0W8uP++YjMHy693Z2o5Qt4JqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6oJsM7/uKjBUNpT6M/DT6f1NyV7YhKrHXcs9EK5yw8=;
 b=Ogo61QgNWQLbSXw/mA6VlEzV7oCaXkVaob6ooZgVt4yxjYbbLI+MFx6zmDWuPNdc8/CKekPSDgC8VnMJhGIArH0hD/WQYDLogZZYOIMw+EXlChUihUr4PcGa4bweWzGvYZageLkFzogAM5Id5Bx1EwuW6exXXA1+CgojLBhPHKNdXl3B+h6NkixOZdigoO6UBXl8UjzRZ0F6+egKUpVgEfqHENjGPmr/IjLDL7lE89ag2tnWmCNnUkyS+saw1qAO9AwMJXqHAlAi7z9jSKl0mkkyh7J97/3npNIOXhQ/u4OwoCliPsGeFBhwx8/8KjY+M0ORvkIp6pOoneKerE0NbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6oJsM7/uKjBUNpT6M/DT6f1NyV7YhKrHXcs9EK5yw8=;
 b=eDggnHn4LhtHNPas+9G+fECZyPMpzwmHgTcB1mt6n0vSzjtKSwfoCYFiUocv5McPqmkoJpkxnKCFawhD/x9w4JykrjbBCultXKZceniCiizceAshcG1/nWr6ZqICfqpgwlgT94qTOjLRxUW4R0UAIsGoTJptxAPFaYZdzvCfJ4Q=
Received: from MN2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:208:120::32)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 19:33:09 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::75) by MN2PR10CA0019.outlook.office365.com
 (2603:10b6:208:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:09 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:04 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 09/20] x86/mce/amd: Clean up SMCA configuration
Date:   Sat, 18 Nov 2023 13:32:37 -0600
Message-ID: <20231118193248.1296798-10-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 96356b73-12a2-4a76-7b41-08dbe86d323b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruzxZSndcahK/siT3DKfzijT+Nw4LvlwjU6frmnLaQHDlr1mRMyxnHwGMdbX+YG8a7lSMG3botXMIZEXl8l7R1JbsKsUKyveacuyoNSwRWJbja69yWeOdu7SY6lQ+PVnUQwiTZy1BHK88Hp/fu0O5JLNrwpvLUAE1dhjHx4eLtFnSVXEbsNcjUyWOKTKP/iR2jvkNemU+xz2UV/JUgEk0QhSGvftScUSR0bhRR76hyjpBXbWn2eYQsWcju7q+uxpUcjdksY76XcOXZGZ+0L8t1vN9QgdXsITDqplpjiJs8p7zm1Kq3WIgh2z7wCyTxmXCKjrOr4tvWNuq9m3JGWGqkj8QthuC0n0IOhd8vJVCKq5Czf1nTwdvUY0wLyrb6Mk+7oVGFueFsDkyaLckiM4sIpEuDE1WKksRAF1tBdfER+4jqDUurQegA4kVAWEtftN22ZQsnCVNF/dV8MBuflNHDhq8+mo+om7hH0Hw9im1b4O+QgdqXvb4sRCWkGqH/nQaHqloOsE48NDMoDnyOse2muNi7MNTpX9bO0XxFEUU1WPM9G2mL2GTjVEPuf83v9ZEouMxNNdIZ5zUl6gFtKA4nJX+DTwAEqZcNgsoRJgJjBt1bIr2TML08jGRsULWQSvFVOFb11NJ+uFEAeRZ5swh9B2CUHUiEODL/ybARVSxGKS3YDolKvboD+83jG7lWvsw1CSQKB49224ZrYj5N0O7IVxeRfuwLXbZKXu8pozkXjcRU8LsFwMXTMCFsZF62BHMF+TJmwpMksPWX6WW6duNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(36860700001)(54906003)(70206006)(70586007)(6916009)(316002)(6666004)(478600001)(47076005)(44832011)(8936002)(8676002)(86362001)(2616005)(7696005)(1076003)(26005)(2906002)(4326008)(16526019)(5660300002)(41300700001)(336012)(356005)(36756003)(426003)(83380400001)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:09.4426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96356b73-12a2-4a76-7b41-08dbe86d323b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/x86/kernel/cpu/mce/amd.c | 84 ++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 95843ac7979d..c8c92e048f56 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -50,9 +50,16 @@
 #define MASK_DEF_INT_TYPE	0x00000006
 #define DEF_LVT_OFF		0x2
 #define DEF_INT_TYPE_APIC	0x2
+#define INTR_TYPE_APIC			0x1
 
 /* Scalable MCA: */
 
+/* MCA_CONFIG register, one per MCA bank */
+#define CFG_DFR_INT_TYPE		GENMASK_ULL(38, 37)
+#define CFG_MCAX_EN			BIT_ULL(32)
+#define CFG_LSB_IN_STATUS		BIT_ULL(8)
+#define CFG_DFR_INT_SUPP		BIT_ULL(5)
+
 /* Threshold LVT offset is at MSR0xC0000410[15:12] */
 #define SMCA_THR_LVT_OFF	0xF000
 
@@ -350,45 +357,51 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 
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
 
@@ -764,8 +777,9 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
-			smca_configure(bank, cpu);
+			smca_configure_old(bank, cpu);
 
+		configure_smca(bank);
 		disable_err_thresholding(c, bank);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
-- 
2.34.1

