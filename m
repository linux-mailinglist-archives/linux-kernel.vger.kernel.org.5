Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A087D610C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjJYFPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjJYFPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:15:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F7912A;
        Tue, 24 Oct 2023 22:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpST5ZdpsZcHyvviu8CDBG1vd+Qr81QWlaJXCsE1nAoJg3NvxMNLJ8g10NOQ5+FiV8ULVg5lNLpjEhMo/OrjIjIpBXEAfc+pWAjDAB03o+l9cka4ir/peNBTQUh+8y9i+H2e2RNrjZ6K0uppSe+0gvMLIMkf7+sW3isdoEnfZHsZ5sla6OBWqG9xeQd/LoEphTDRm0/bu7Hgg8eUtswEq6/y8YxvQL0yaDHcoH68emOMyOgErPpq+3iS/Kjn+cWC/xEhg0JMm5pFuudl6Bp3E1IGBiXgOcrJ3LK8G3WJ5WNMt43Dn7DDAbqPSqAJ+IVSoYCZ7/inl9kWRyrh9sHCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8X6KyujaQgzHsIKVt/r6IY7JzVxUMlTGKlF1jYIAgQ=;
 b=Hgfmn8FjdQ8vUV2as/tob3EZCJRw9d3uqcw41iDn5F3HVFO3QnhFF/meDrq/SNc2G9wV41/1eHAcaidZaM0IBtCJq83eFERU4UD48R1Xw0v+6RhUc8OCWgquMfTKj+tHM7ZmRNl1ac6wUKJCgYpMOeBxUwlMLa3zzoFmfDGr9RjUdjVZz2s+CQz67GM+JdjgfHz9im5tsIFLLiPzHk3+Kl/Ndn7n9ggLWVWFMd3AeXMjaqT6TNJ8iEuE6cKISSt6qUo1fDG95Hf6RINJtzw85cxe2oYfQsFkw9//9nbeRDQ7HYA0EDyus2vJI/6xUiwXBUX2Iut8/zk/a5OjbLV3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8X6KyujaQgzHsIKVt/r6IY7JzVxUMlTGKlF1jYIAgQ=;
 b=l2u8RjX7cttelYSzQr3vjyxjIWQJh3ZRzcr5FwFhD1urXH5/75glBHKX5tHrlSk3ecsc9RlDYTUahNS3yjtV41JL9QqbbqfkMz199ORX83wnrap9IAzcSjLL8QrfDOkL2HIQevfOhSiLjeAoyB5Qt+k/czqm3TMeeOH6CTJdrSw=
Received: from CY8PR10CA0002.namprd10.prod.outlook.com (2603:10b6:930:4f::7)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 05:15:28 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::fb) by CY8PR10CA0002.outlook.office365.com
 (2603:10b6:930:4f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 05:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 05:15:28 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 00:15:25 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2 2/4] x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types
Date:   Wed, 25 Oct 2023 05:14:53 +0000
Message-ID: <20231025051455.101424-3-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025051455.101424-1-muralimk@amd.com>
References: <20231025051455.101424-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 409cff9b-85f8-4ff1-f485-08dbd51966fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AEnl3Uq/U/KwgNE/4kg0ZMsgj2SodWlVTLfwjiov42b5dSVMNcwysIMMEtHnwMWkPMOYUmWJiLE91X88O65C8x4KQxqydMqin/mkYfMFVA+mbFRUKDuCjAy0O/bkmar7S+SAhKK/KkzZZBii3gK/hI8KgsxxtW0JvJy5KIHUyg0hqJKt67924+u015GhmrdRpBpAYaTjimRB6kNEXcxxQLFubtlIDAi5OeNaN59C3IkTvBLS4q15u/0Evc8aSKncOWr8669zlAqlb15PA3fgnUQqdN9DJTNL/qETAnhxaFAurs0w8QqYpe6vv+XA3CsxyS3Fy+zYAB2hxtfIWH1zqgl7vjAU+1fVEGiZr7VG6rhenvEOVUN3q4Bo5dUqLUYHvQ4GzgLxvF2Plh2M93gKcoCOgsSq8zMI7iM6XC3+xyGME4mmyVPrQnoSUEFulQKSpJs0boFt1KnFFXOP5/dFqA5o4xTyZpoW2tUxJi6RyZlNX5GJxctQPjQeyu6J49K3Z6RyEbl+D64+ocCvmWBSCqn/BN7O4X4M6ongKwY8r/RtN5ND7q//X4LgtFTDy6IwMAKcfs40h47GBDtdEWIPxTVleEciId68oAlZppXGqLFjv2wotsTfJAkH0yOEb4aYR5Py7txYK9f+TzRmi1vQCLpN6lA+TrE9G1Ibd7TbkduwqveMxvwJErF7UZm0Zu+i2/zoiW/Z71ZdjMj7U9bTOArbnKpRaXujRL6aRfzeq7ZI+GZplRgF36EHRcP7h4euZPn2ibPxA1rhUYZw2exRmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(8936002)(47076005)(426003)(36860700001)(336012)(1076003)(41300700001)(15650500001)(5660300002)(16526019)(8676002)(7696005)(4326008)(2616005)(6666004)(26005)(83380400001)(40480700001)(36756003)(70206006)(70586007)(6916009)(478600001)(82740400003)(356005)(81166007)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 05:15:28.0584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409cff9b-85f8-4ff1-f485-08dbd51966fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add HWID and McaType values for new SMCA bank types.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 arch/x86/include/asm/mce.h    | 3 +++
 arch/x86/kernel/cpu/mce/amd.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 180b1cbfcc4e..8e0ed4b86e29 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -311,6 +311,7 @@ enum smca_bank_types {
 	SMCA_PIE,	/* Power, Interrupts, etc. */
 	SMCA_UMC,	/* Unified Memory Controller */
 	SMCA_UMC_V2,
+	SMCA_MA_LLC,	/* Memory Attached Last Level Cache */
 	SMCA_PB,	/* Parameter Block */
 	SMCA_PSP,	/* Platform Security Processor */
 	SMCA_PSP_V2,
@@ -326,6 +327,8 @@ enum smca_bank_types {
 	SMCA_SHUB,	/* System HUB Unit */
 	SMCA_SATA,	/* SATA Unit */
 	SMCA_USB,	/* USB Unit */
+	SMCA_USR_DP,	/* Ultra Short Reach Data Plane Controller */
+	SMCA_USR_CP,	/* Ultra Short Reach Control Plane Controller */
 	SMCA_GMI_PCS,	/* GMI PCS Unit */
 	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
 	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c267f43de39e..767361215044 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -107,6 +107,7 @@ static struct smca_bank_name smca_names[] = {
 	/* UMC v2 is separate because both of them can exist in a single system. */
 	[SMCA_UMC]			= { "umc",		"Unified Memory Controller" },
 	[SMCA_UMC_V2]			= { "umc_v2",		"Unified Memory Controller v2" },
+	[SMCA_MA_LLC]			= { "ma_llc",		"Memory Attached Last Level Cache" },
 	[SMCA_PB]			= { "param_block",	"Parameter Block" },
 	[SMCA_PSP ... SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
 	[SMCA_SMU ... SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
@@ -119,6 +120,8 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_SHUB]			= { "shub",		"System Hub Unit" },
 	[SMCA_SATA]			= { "sata",		"SATA Unit" },
 	[SMCA_USB]			= { "usb",		"USB Unit" },
+	[SMCA_USR_DP]			= { "usr_dp_pcs",	"Ultra Short Reach Data Plane Controller" },
+	[SMCA_USR_CP]			= { "usr_cp_pcs",	"Ultra Short Reach Control Plane Controller" },
 	[SMCA_GMI_PCS]			= { "gmi_pcs",		"Global Memory Interconnect PCS Unit" },
 	[SMCA_XGMI_PHY]			= { "xgmi_phy",		"Ext Global Memory Interconnect PHY Unit" },
 	[SMCA_WAFL_PHY]			= { "wafl_phy",		"WAFL PHY Unit" },
@@ -178,6 +181,7 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
 	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
 	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
+	{ SMCA_MA_LLC,	 HWID_MCATYPE(0x2E, 0x4)	},
 
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
@@ -212,6 +216,8 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_SHUB,	 HWID_MCATYPE(0x80, 0x0)	},
 	{ SMCA_SATA,	 HWID_MCATYPE(0xA8, 0x0)	},
 	{ SMCA_USB,	 HWID_MCATYPE(0xAA, 0x0)	},
+	{ SMCA_USR_DP,	 HWID_MCATYPE(0x170, 0x0)	},
+	{ SMCA_USR_CP,	 HWID_MCATYPE(0x180, 0x0)	},
 	{ SMCA_GMI_PCS,  HWID_MCATYPE(0x241, 0x0)	},
 	{ SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)	},
 	{ SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)	},
-- 
2.25.1

