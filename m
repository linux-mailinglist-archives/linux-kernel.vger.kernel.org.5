Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0A7F02AA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjKRTeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjKRTdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:19 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57359D5B;
        Sat, 18 Nov 2023 11:33:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPirNl5lpDnUM06PYSQohD7lV411tp+D3EUCDXEVqRTh8jyJVZXk3KkTgLbQsUB987KzFO9+M2vhZe61LCBNzpA9qeN4/eGTsu+0AggWryTPOuNyk9hZ5E/ZpT5hq+xwgfQh05tIzFSUexIEii6j4mpv1RLB4vlG5PCdeZEg6wRKhpciMjbMoLloDfyAzzyveMGXoPkWgE8mIwYDLyghidLJIcvkzEcV8XG/XgHBOjMcdGq52tTqfndZKoOKRy9PqzX92fxzmwJwXjn68tLfUjAS3Z9hiHiTw0BbOqR1SMX5i+RxA8SJ4B1Qm902W21Mq3UIDWMNAlQ790r/F1RcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej+B2foXtxrklqhCyr7AbTQcU5R8TiSm9LWH3NQg8TU=;
 b=LxilFJvfyIKGi1ThEvD8w2O3hgrNgmLAhyZ8pnl4Z2SIFko5a2KBHEo1LcwtDFYlyoKWFh8ikLvPfccj0djf2VkBO59SWeNipjZBomZAgW+xQpvBHZ7p/WBZto1Gy64YVduChcrKflVMScbqssojNuCIdOnyXCXDrSaYb/UHCDz0cT2dqCjXmZVO0AQoOgcKgTRB36D/b3Oq4W1v4yXUDOTd4rLsOXsXToqJQVuAuh9Cr2sdkj1atGNEQGyKsyZgYd0t7DJe4cpIitJiqMLYCJrmCf/2ZLuTyGodvQArHJ3L6y5d6mI5D1Gqj/B2urYN1JHg70+kdS/2N90NrPZGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej+B2foXtxrklqhCyr7AbTQcU5R8TiSm9LWH3NQg8TU=;
 b=JtlO2MKYiCfYnQkJM8YWD/cxuTN23wJGlkeT0hSpUsSY1J8bLBJxLGo/5aiI3t6/Jl8dkGxMwZxaaC2tGlTjI6A+pKQCiDAWV6iydEoV4bb8B+HvJSfbEy5c4IJgkvMA198/7/pw8inMmonY/b1oEplPLgt8BlNGpalVsQjpUTo=
Received: from BLAP220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::34)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 19:33:12 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::41) by BLAP220CA0029.outlook.office365.com
 (2603:10b6:208:32c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 19:33:12 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 13:33:11 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Avadhut.Naik@amd.com>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 19/20] x86/mce/apei: Handle variable register array size
Date:   Sat, 18 Nov 2023 13:32:47 -0600
Message-ID: <20231118193248.1296798-20-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 745ad4b5-edd4-477c-793e-08dbe86d33e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXeLLThDd1yupZa6DwH2y6z9f/kI7aRtDon5XChOTeYaLA2scmlIVvsEUTYgNueKP/9YSChzF4SLptgN0xVk5jKOetsk3ptuOcsDm8YBWTuEHQYzPqlbiV/j8DaIlhuhxU9d1kNfiB8i8WEiChW0Jp8wWQ17KTtBg/ozT7rYA4Kmsy5rpKkZfABywyzDLDgiAu9Q39ul5BvDtwLCi1AiBoqU098sneM88eoAORCChheGSJOneFp/ogx6505ZtGSQ5symnxQvxSt5bg6g+UvIrqjEL28F2OXn/tQMg6KGIOh9Kvx7EzorL6kE/HJzkLcmvtAcg3ebhsyGNqc+YT9VA9z/nIhf5u0CZk6yULdiyXc43M5SJ0kxEHxg7GKR8HZX0Kv3whRfWwQJAqnGgu1b/CnU/xWcevkrX7Y58xL+3idTYyaV3Aq+Emm1nrAk2Cp+LHoOzECAlC6dwIv0lchK89LaxDLlUmb5ZAcCUnB+y2TGlReFRMcWsbXd5oTgrO4ye/3Wh5bqPI608NTcyZYlEJuyLxWfru0zj2TZhoxJByyMX8m09bM1sRM6ij+mlQElf00AjfmdbYaIPUbK5WPyF7O8s1ppNEwQkfGpNkteeZFp6i4eGXJQ+YdZIiHvdJDumZsj6U/rDCY3ZGB2QsrUlTSficjcOxDMPryycH61uRPqNV34JdVyta+JYWsSHlVF0LiyfC9f5qcByW2cVA+r/hBbt+pohfbH7IYKcUapg5vcHKzcxApEDjCxXeKjD5eusYkodSQJ2o5Aof3PBo8Q7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(44832011)(2906002)(356005)(81166007)(82740400003)(86362001)(36756003)(336012)(426003)(83380400001)(1076003)(26005)(16526019)(2616005)(7696005)(36860700001)(478600001)(6666004)(47076005)(41300700001)(8676002)(8936002)(4326008)(70586007)(70206006)(316002)(6916009)(54906003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:12.2147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 745ad4b5-edd4-477c-793e-08dbe86d33e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI Boot Error Record Table (BERT) is being used by the kernel to
report errors that occurred in a previous boot. On some modern AMD
systems, these very errors within the BERT are reported through the
x86 Common Platform Error Record (CPER) format which consists of one
or more Processor Context Information Structures. These context
structures provide a starting address and represent an x86 MSR range
in which the data constitutes a contiguous set of MSRs starting from,
and including the starting address.

It's common, for AMD systems that implement this behavior, that the
MSR range represents the MCAX register space used for the Scalable MCA
feature. The apei_smca_report_x86_error() function decodes and passes
this information through the MCE notifier chain. However, this function
assumes a fixed register size based on the original HW/FW implementation.

This assumption breaks with the addition of two new MCAX registers viz.
MCA_SYND1 and MCA_SYND2. These registers are added at the end of the
MCAX register space, so they won't be included when decoding the CPER
data.

Rework apei_smca_report_x86_error() to support a variable register array
size. This covers any case where the MSR context information starts at
the MCAX address for MCA_STATUS and ends at any other register within
the MCAX register space.

Add code comments indicating the MCAX register at each offset.

[Yazen: Add Avadhut as co-developer for wrapper changes.]

Co-developed-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 73 +++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 4820f8677460..d01c9b272e2f 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -69,9 +69,9 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	unsigned int cpu, num_registers;
 	struct mce_hw_err err;
 	struct mce *m = &err.m;
-	unsigned int cpu;
 
 	memset(&err, 0, sizeof(struct mce_hw_err));
 
@@ -91,16 +91,12 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		return -EINVAL;
 
 	/*
-	 * The register array size must be large enough to include all the
-	 * SMCA registers which need to be extracted.
-	 *
 	 * The number of registers in the register array is determined by
 	 * Register Array Size/8 as defined in UEFI spec v2.8, sec N.2.4.2.2.
-	 * The register layout is fixed and currently the raw data in the
-	 * register array includes 6 SMCA registers which the kernel can
-	 * extract.
+	 * Ensure that the array size includes at least 1 register.
 	 */
-	if (ctx_info->reg_arr_size < 48)
+	num_registers = ctx_info->reg_arr_size >> 3;
+	if (!num_registers)
 		return -EINVAL;
 
 	for_each_possible_cpu(cpu) {
@@ -116,12 +112,61 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	mce_setup_per_cpu(m);
 
 	m->bank = (ctx_info->msr_addr >> 4) & 0xFF;
-	m->status = *i_mce;
-	m->addr = *(i_mce + 1);
-	m->misc = *(i_mce + 2);
-	/* Skipping MCA_CONFIG */
-	m->ipid = *(i_mce + 4);
-	m->synd = *(i_mce + 5);
+
+	/*
+	 * The SMCA register layout is fixed and includes 16 registers.
+	 * The end of the array may be variable, but the beginning is known.
+	 * Switch on the number of registers. Cap the number of registers to
+	 * expected max (15).
+	 */
+	if (num_registers > 15)
+		num_registers = 15;
+
+	switch (num_registers) {
+	/* MCA_SYND2 */
+	case 15:
+		err.vi.amd.synd2 = *(i_mce + 14);
+		fallthrough;
+	/* MCA_SYND1 */
+	case 14:
+		err.vi.amd.synd1 = *(i_mce + 13);
+		fallthrough;
+	/* MCA_MISC4 */
+	case 13:
+	/* MCA_MISC3 */
+	case 12:
+	/* MCA_MISC2 */
+	case 11:
+	/* MCA_MISC1 */
+	case 10:
+	/* MCA_DEADDR */
+	case 9:
+	/* MCA_DESTAT */
+	case 8:
+	/* reserved */
+	case 7:
+	/* MCA_SYND */
+	case 6:
+		m->synd = *(i_mce + 5);
+		fallthrough;
+	/* MCA_IPID */
+	case 5:
+		m->ipid = *(i_mce + 4);
+		fallthrough;
+	/* MCA_CONFIG */
+	case 4:
+	/* MCA_MISC0 */
+	case 3:
+		m->misc = *(i_mce + 2);
+		fallthrough;
+	/* MCA_ADDR */
+	case 2:
+		m->addr = *(i_mce + 1);
+		fallthrough;
+	/* MCA_STATUS */
+	case 1:
+		m->status = *i_mce;
+	}
 
 	mce_log(&err);
 
-- 
2.34.1

