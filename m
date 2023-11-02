Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EEA7DF173
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344509AbjKBLnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjKBLnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:43:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D569B1AD;
        Thu,  2 Nov 2023 04:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDv4tjY5hlFme/KaRdaacQ/vgHu/nPl8zLNO3qvdgIg5Ky28OP7HoeEjPWIgSTQLXye9TstGGW1i5ldxwREq8I392yC4/OVle2Efj1QXLvYOy6fwvuuMYB+MQ3i6CqB+/o46y7WYdOtRQtl33C4WON5uO5Ln82psA7Uw12p2+Y14gLiz4NljTy61/xu7V/CL1WzQeBld5oGgspU4Qcth23VLaCF49/v2xpQpylA4O9jXRzs1FhbcD4GA7GFfI3Le+ofs1atyLPB4uYiUdA/qY917qGLiLezW+44vQA5w7OCsJ38dLPl19rvEQc2HADx3Oi+eD3wegM+BE+05qsilpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZjU784blIskKylWr0kv3DWJsauOLV/nFVrY0b7A7sU=;
 b=Y1lAdC9Vaxm/Pb0LR0BsUrsZcLYUt1dvzyVeMPkl2hLqQbiNj67p5RtXK7mBzJ/8RfdZnXocyGhbsgyPMPAhQmdlHP3prCEGYTkByHLsm0vx7bd0bA4WFC5DuqFo5EaJdC7e7iMHYyLE91eZ3aOkACGtoOIlwMf3L5JdA8EVOzrvgb/Hr+fcUE6zN4WTOPGzS0jAyFdUXvT24UAtb/1JB0bXoqHJ32NxGg2EgQjWt2jslMu09iBZpyRYYVu9k40WfV2djOQyKhFrEVe6BRY0/cuIHNwDJ8zwYbyw7q7ERj5RB4G2zqZ6El9QGzQ7G7yulPkMYt8smNjT7e/9ndmcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZjU784blIskKylWr0kv3DWJsauOLV/nFVrY0b7A7sU=;
 b=yln32oZVJK3cqz0qGtEgcvP4VahoSlqTvTYWIr6XYp0i6n8w/Bs46iyfUn1B9OtVagOrLJyGVgcGYjYKbRbXucSbrIg5z6Au5UPihM3IRgdqOq0x/4yRkb10cXuoYNsPlUCOkCtzaEavPaPWlTdECxhSSqv26duouN587phhEgo=
Received: from CH0P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::15)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Thu, 2 Nov
 2023 11:42:53 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::99) by CH0P221CA0045.outlook.office365.com
 (2603:10b6:610:11d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Thu, 2 Nov 2023 11:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 11:42:53 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 06:42:51 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v3 2/4] x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types
Date:   Thu, 2 Nov 2023 11:42:23 +0000
Message-ID: <20231102114225.2006878-3-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102114225.2006878-1-muralimk@amd.com>
References: <20231102114225.2006878-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: c893d8f0-943b-4f43-d864-08dbdb98d967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PD5dPBVC/JkoLxzi99JDswLVzKp8cC+TXjPC7R7E/76tMZomBmaXs9/tASIXIpYsg/qJtvhSh8UNnc44+MVds9jcd2dIlLTQF66ZlDWuT1mQX0NdM9KOIB4GUc9oO9ky+n0CXN42CMbsbfX32iKMHLkJQZJ/8JnS7/2JpRP23nGpbEKvbUUkHucMpJMMB9vLXn3fFuBdrk0J2bcKRd8zWo0OKM1mJtOBKl8m36eKrunCEdONmc0UvME7Ue2hSO+48NmRQg+n1CIXvr5Az19o3nUyymso1sSoeIlc7sc37bsBRnKzqtMSp2/AAcOtIKbK+DCKzmcYl4wT6e1o7h0s6/808LpTf3XNKnaSmoxY3wpdzXhnbaMOC0dUHbLHCy6XwCZs3CxluK+J1vCzq+UnUNT4ZYIksgYns1VpLmXkCfkKN0R9Z52CwtIwf4Csbvf4GHWE0xafMMkh1CYQ7gUP2ox9SqswnezX1VEkZ1HT3uxUr2tYRp9lIvKATrQ7KyMdWE2uzTvsl97trYA8oeeiF5QGjVMacFna/xV2OMU9oppPYOV661PlqzCnttSVm1CNQHHFhzrtLQBNl/I4ILRWdXiQboEg0cieFQ8sqeioBwDbyz+PYmVcaCob3i4Om3Feq08LZfrkNJk+PRyxHho9EncQk06k552Pzi4CEQpDbE5esm5j3NsUNES6/cLTeLkTMu8UdTlDDHGP/JptV6Le7fx8vRFzQgJdaHCeh9Ba5tYMKgEeHHlI//QL/f1Sq11miS/jpikiCEyG0vLbTL+B/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(5660300002)(2906002)(15650500001)(41300700001)(8676002)(8936002)(4326008)(36756003)(54906003)(316002)(81166007)(26005)(82740400003)(356005)(36860700001)(336012)(47076005)(70586007)(6666004)(6916009)(70206006)(426003)(2616005)(1076003)(40480700001)(16526019)(478600001)(7696005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:42:53.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c893d8f0-943b-4f43-d864-08dbdb98d967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add HWID and McaType values for new SMCA bank types.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
Chnages:
v2->v3: Rename usr_dp_pcs to usr_dp and same for usr_cp_pcs

 arch/x86/include/asm/mce.h    | 3 +++
 arch/x86/kernel/cpu/mce/amd.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6de6e1d95952..9e2bb7bdc3b3 100644
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
index f3517b8a8e91..4814d8a25ef8 100644
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
+	[SMCA_USR_DP]			= { "usr_dp",		"Ultra Short Reach Data Plane Controller" },
+	[SMCA_USR_CP]			= { "usr_cp",		"Ultra Short Reach Control Plane Controller" },
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

