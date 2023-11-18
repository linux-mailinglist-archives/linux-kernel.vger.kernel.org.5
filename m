Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0847F029F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjKRTdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjKRTdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:33:17 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE6D4F;
        Sat, 18 Nov 2023 11:33:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRf37yPECWfcNhYFU3g8OfFqBXzWC3JBspDDTQk9rhXnqtS43hZYZJdCll07uiZfKtO9/R9KG3qypRAyyHAx3uMA0Z2pu4HPUjl8jQXXIclm5OgnKtlRrxU4Pbxcy1crBDd732KtZOCuO7GC9Pyb62/o61KQxytFdeSWoDNBU0My5Rud3ptbhMGWsMJcV6T1xugPPacpSWI71em6w7WytsqPg94TEd8MeoqFGUHy/Yx3rC/SLAcNQMf9qHYUrNMRHo3+8rbEdPORa7EJ3PnUezRYHtqHHytMcXBkF6HfMsl7KIMhVenY4Coo/R0U9Q5wXdimCWZ7G8gq/u1bL8/JgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxeTI/jPWnrt+K9AWv7KqyXw6quRWOiAlsHSnLrFJRA=;
 b=U+n6Km1/MtMyFwogbP4jYbGwsLfvsHx5SOjHcE5wUEpJ0oPANujFGOgcufqXPUG5OH40ihyKS0V19H9PZj+kV04PLHlYE+AEMvosnMRKr21y+xhCgXUbDwV7T5rnG+1a/IMDYzpVEaKZ18sfYgPuy9La5k6Zzh4hjvrqU4gNT7wiSseyrJ7PwPHoL8RU5IUtilUJzmrmvCkdnxOBna9xMJED93Iv3oFlTYEneLqDX2CI7xP6J2E6ahVlVFtdg5UyprGhTIJpQSg/RsJjRt73bZGoA+G1J+bgbbX2LLrE3oOrcqoiWKmD/rxv8PNxdeXRwPbHggbqqoKKXlPtSy9Egg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxeTI/jPWnrt+K9AWv7KqyXw6quRWOiAlsHSnLrFJRA=;
 b=nQdWL4ebpBuJLRQ1M0C59hZWdsmDGA/cyQ2FZt0GHpYF7VmWEhYMEceqirxcbMIT/N7bowOwcrhLOS0VSxSp7OVDEH4bh/cNE1sSt/hR05qWExRuqEAa+2YL0E7JgczBpIV/Y2o+dQqLZBngyLdefN2mJkQWuP6sDLcyDMFm+Ck=
Received: from BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::32)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 19:33:09 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::1a) by BLAP220CA0027.outlook.office365.com
 (2603:10b6:208:32c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Sat, 18 Nov 2023 19:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
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
Subject: [PATCH 08/20] x86/mce/amd: Look up bank type by IPID
Date:   Sat, 18 Nov 2023 13:32:36 -0600
Message-ID: <20231118193248.1296798-9-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbc47bd-ecd5-4949-403a-08dbe86d3203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSqapbTX70yzhvBAwfCQTY35ZK+0QfB5A7k/cbyD9oECQvkA+7N+Iniadf+4pJ0s5xKSHI3i7SkBp9Iu1rZExxMP3qPGOK3c+fdidqQqbsMGKVJFOnxOJoB0p+M0HPZsoBfvrozNlVXlb/AM/hgHkYDISyKRbw203yWReiJIjWTf6VQwForpzpDjN0VDbISU5XZwiTixoOm1qkeewkGpGYwWBQBQ4JxTOzQ1hPzcM12HwXThFFuccTzwLmRWM2rJIsrWWHaJjlcjFp1SpXNozA6PTtq8yjOgu4KRX5Sk1c6dTHkpsc8Ye7+VbT8b1gfw1/hE3OlLJ8Hyt+khQQtDrnA3Oz37hTW/Uob2JS83Nd35TS2UoCe9kfxYFGNR1SLT5kZzVt7ON0bgFaUOORhuCpMRPuddPVRnpsIlt8L4qy6kNrKCJeqqUHyWHlwkE1VOGpAwxOfeX1/gjMeDQV7RNZuzB7qVBkX8l5HonEiwuwOzMGtQuqIo2qMpiMtH57YAjhz+Z7awIxJmROTt+WPvGGhXI9UBzVJS1VfwUYNhTTlKP2nlAQ0AjF65CMtvjsP3HDMYCX6fsC5e2Bb34I3DXozFtq1TLBayCO7DL3Ia7Ftv5yIicYa+5wSQRnIN2lCzp5pU27XbRgj0EkFX2BYmZRSk8rgqW39v6wj1drJb7+DTMYd/Iqytnt2evDgbVSXo6j4nYToucMKszlBGNtGRHYHfBhUV08vEwNnuZiPKkbzPlsV7k26Jq6N9BgVxIyk09sBynzQIJd9GZeh/GjDU7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(46966006)(40470700004)(36840700001)(6916009)(54906003)(316002)(40480700001)(15650500001)(2906002)(5660300002)(40460700003)(47076005)(44832011)(41300700001)(8936002)(36860700001)(478600001)(6666004)(4326008)(70206006)(70586007)(8676002)(82740400003)(356005)(81166007)(7696005)(426003)(336012)(83380400001)(16526019)(26005)(2616005)(1076003)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 19:33:09.0741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbc47bd-ecd5-4949-403a-08dbe86d3203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scalable MCA systems use values within the MCA_IPID register to describe
a bank's type. Other information is not needed.

Currently, the bank types are cached during boot and this information is
used during boot and run time. The cached values are per-CPU and
per-bank. The boot path needs the cached values, but this should be
removed. The run time path does not need the cached values.

Determine a Scalable MCA bank's type using only the MCA_IPID values. The
only current user is the MCE decoder module. But the boot path will be
updated to use the same helper function.

Keep old code until init path is cleaned up.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  2 +-
 arch/x86/kernel/cpu/mce/amd.c | 88 ++++++++++++++++++++++++++++++++---
 drivers/edac/mce_amd.c        |  2 +-
 3 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 012caf68dcbb..9441b89afee3 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -341,7 +341,7 @@ extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
-enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
+enum smca_bank_types smca_get_bank_type(u64 ipid);
 bool smca_gpu_umc_bank_type(u64 ipid);
 #else
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6e100024498a..95843ac7979d 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -129,7 +129,7 @@ static const char *smca_get_name(enum smca_bank_types t)
 	return smca_names[t];
 }
 
-enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank)
+static enum smca_bank_types smca_get_bank_type_old(unsigned int cpu, unsigned int bank)
 {
 	struct smca_bank *b;
 
@@ -142,7 +142,6 @@ enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank)
 
 	return b->hwid->bank_type;
 }
-EXPORT_SYMBOL_GPL(smca_get_bank_type);
 
 /* UMCs have HWID=0x96.*/
 static bool smca_umc_bank_type(u64 ipid)
@@ -160,7 +159,7 @@ bool smca_gpu_umc_bank_type(u64 ipid)
 }
 EXPORT_SYMBOL_GPL(smca_gpu_umc_bank_type);
 
-static const struct smca_hwid smca_hwid_mcatypes[] = {
+static const struct smca_hwid smca_hwid_mcatypes_old[] = {
 	/* { bank_type, hwid_mcatype } */
 
 	/* Reserved type */
@@ -221,6 +220,83 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_GMI_PHY,	 HWID_MCATYPE(0x269, 0x0)	},
 };
 
+/* Keep sorted first by HWID then by McaType. */
+static const u32 smca_hwid_mcatypes[] = {
+	/* Reserved type */
+	[SMCA_RESERVED]		= HWID_MCATYPE(0x00, 0x0),
+
+	/* System Management Unit MCA type */
+	[SMCA_SMU]		= HWID_MCATYPE(0x01, 0x0),
+	[SMCA_SMU_V2]		= HWID_MCATYPE(0x01, 0x1),
+
+	/* Microprocessor 5 Unit MCA type */
+	[SMCA_MP5]		= HWID_MCATYPE(0x01, 0x2),
+
+	/* MPDMA MCA type */
+	[SMCA_MPDMA]		= HWID_MCATYPE(0x01, 0x3),
+
+	/* Parameter Block MCA type */
+	[SMCA_PB]		= HWID_MCATYPE(0x05, 0x0),
+
+	/* Northbridge IO Unit MCA type */
+	[SMCA_NBIO]		= HWID_MCATYPE(0x18, 0x0),
+
+	/* Data Fabric MCA types */
+	[SMCA_CS]		= HWID_MCATYPE(0x2E, 0x0),
+	[SMCA_PIE]		= HWID_MCATYPE(0x2E, 0x1),
+	[SMCA_CS_V2]		= HWID_MCATYPE(0x2E, 0x2),
+
+	/* PCI Express Unit MCA type */
+	[SMCA_PCIE]		= HWID_MCATYPE(0x46, 0x0),
+	[SMCA_PCIE_V2]		= HWID_MCATYPE(0x46, 0x1),
+
+	[SMCA_XGMI_PCS]		= HWID_MCATYPE(0x50, 0x0),
+	[SMCA_NBIF]		= HWID_MCATYPE(0x6C, 0x0),
+	[SMCA_SHUB]		= HWID_MCATYPE(0x80, 0x0),
+
+	/* Unified Memory Controller MCA type */
+	[SMCA_UMC]		= HWID_MCATYPE(0x96, 0x0),
+	[SMCA_UMC_V2]		= HWID_MCATYPE(0x96, 0x1),
+
+	[SMCA_SATA]		= HWID_MCATYPE(0xA8, 0x0),
+	[SMCA_USB]		= HWID_MCATYPE(0xAA, 0x0),
+
+	/* ZN Core (HWID=0xB0) MCA types */
+	[SMCA_LS]		= HWID_MCATYPE(0xB0, 0x0),
+	[SMCA_IF]		= HWID_MCATYPE(0xB0, 0x1),
+	[SMCA_L2_CACHE]		= HWID_MCATYPE(0xB0, 0x2),
+	[SMCA_DE]		= HWID_MCATYPE(0xB0, 0x3),
+	/* HWID 0xB0 MCATYPE 0x4 is Reserved */
+	[SMCA_EX]		= HWID_MCATYPE(0xB0, 0x5),
+	[SMCA_FP]		= HWID_MCATYPE(0xB0, 0x6),
+	[SMCA_L3_CACHE]		= HWID_MCATYPE(0xB0, 0x7),
+	[SMCA_LS_V2]		= HWID_MCATYPE(0xB0, 0x10),
+
+	/* Platform Security Processor MCA type */
+	[SMCA_PSP]		= HWID_MCATYPE(0xFF, 0x0),
+	[SMCA_PSP_V2]		= HWID_MCATYPE(0xFF, 0x1),
+
+	[SMCA_GMI_PCS]		= HWID_MCATYPE(0x241, 0x0),
+	[SMCA_XGMI_PHY]		= HWID_MCATYPE(0x259, 0x0),
+	[SMCA_WAFL_PHY]		= HWID_MCATYPE(0x267, 0x0),
+	[SMCA_GMI_PHY]		= HWID_MCATYPE(0x269, 0x0),
+};
+
+enum smca_bank_types smca_get_bank_type(u64 ipid)
+{
+	enum smca_bank_types type;
+	u32 hwid_mcatype = HWID_MCATYPE(FIELD_GET(MCI_IPID_HWID, ipid),
+					FIELD_GET(MCI_IPID_MCATYPE, ipid));
+
+	for (type = 0; type < ARRAY_SIZE(smca_hwid_mcatypes); type++) {
+		if (hwid_mcatype == smca_hwid_mcatypes[type])
+			return type;
+	}
+
+	return N_SMCA_BANK_TYPES;
+}
+EXPORT_SYMBOL_GPL(smca_get_bank_type);
+
 /*
  * In SMCA enabled processors, we can have multiple banks for a given IP type.
  * So to define a unique name for each bank, we use a temp c-string to append
@@ -324,8 +400,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 	hwid_mcatype = HWID_MCATYPE(high & MCI_IPID_HWID_OLD,
 				    (high & MCI_IPID_MCATYPE_OLD) >> 16);
 
-	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes); i++) {
-		s_hwid = &smca_hwid_mcatypes[i];
+	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes_old); i++) {
+		s_hwid = &smca_hwid_mcatypes_old[i];
 
 		if (hwid_mcatype == s_hwid->hwid_mcatype) {
 			this_cpu_ptr(smca_banks)[bank].hwid = s_hwid;
@@ -1104,7 +1180,7 @@ static const char *get_name(unsigned int cpu, unsigned int bank, struct threshol
 		return th_names[bank];
 	}
 
-	bank_type = smca_get_bank_type(cpu, bank);
+	bank_type = smca_get_bank_type_old(cpu, bank);
 	if (bank_type >= N_SMCA_BANK_TYPES)
 		return NULL;
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index b8765292d26e..701bc9556414 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1207,7 +1207,7 @@ static const char *smca_get_long_name(enum smca_bank_types t)
 /* Decode errors according to Scalable MCA specification */
 static void decode_smca_error(struct mce *m)
 {
-	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
+	enum smca_bank_types bank_type = smca_get_bank_type(m->ipid);
 	const char *ip_name;
 	u8 xec = XEC(m->status, xec_mask);
 
-- 
2.34.1

