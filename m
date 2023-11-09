Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1F7E63E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjKIG2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjKIG2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:28:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9843111;
        Wed,  8 Nov 2023 22:28:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIhlsCYsgXxMio/Da/QrSo6bsylj3VeLJZZICeEIUeMveaHJwjjSXyB40OBbvqeW/iJO8RMFPIL5SNAicD6P4QD6/FGvP0eCLC3sW74qEgruK/YW0dINGusfzWPHjOJDL2WgGm5owqvoWAIZDEOZdkHFuPhuOm8K7L1moStCIeCusT1uCWJkL3IuHRw3VvZd7EBHCXorGnjOpmQI18GNu7a8IvriSWjnyKK9exh5Nw0ymD2m7K6O3mfydAaYpRQAVL2/qp283AjA2qMt3PC+ndFpTbgaD3ivtQdXxzUZgyuGIpPsctHDnuifMVdaiox74khPw34ZhoGT0ZbBiZZzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IghFubGuRArlMOa1u4bDjhXvsObaTeysHTFgn0VMu48=;
 b=lVSafv0aHtkD8UiBHZE8ORnVf1AgnLtYl4KKUjr39kkqmT/7p9mJ757eJ7WDkvHTQMLLQU/HNaJ3VNHWOY2oanvsqolvntJURjoyEsdfDw/CD9/k6eraxbx+mV2VRQPORh/FyeWnStT1z2QNFREnW0llYTmOQVrIiBD1tkcw/2XnE4AUU8aaWDpbvo2PirODt3pCnSk7oCn8XW2Q4KkaGtimsaoFVkIfX1ugSXM9PodZJOJYOvWQxAnRO25muUpB+27XYEpV7V0JSKvLzoGSFSEbohEOvxqBpybwyW9sg2tBgx2qLaZ0OhMfm0t17Rlz1kWZuHIpz1D4vOERv/330g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IghFubGuRArlMOa1u4bDjhXvsObaTeysHTFgn0VMu48=;
 b=Wry9tqY5UFnbZg6F0+vvWIqyWLwS0pTQcTX6zLqMmQO4QX2B2oXtF7tnm07/A8WnE2VD/wFAa8q51iAdNLY54WNjc84O3EsdOLEiLaq4TrICXDp6G/n1H2qy7OYp1jgGizyHHRiVXh4vq1qQYVG4IOiPe1A0AKwKZ5+QH3SbxIc=
Received: from MN2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:c0::35)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 06:28:32 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::e) by MN2PR05CA0022.outlook.office365.com
 (2603:10b6:208:c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 06:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 06:28:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 00:28:30 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@amd.com>,
        <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH] fpga: zynq: Fix incorrect variable type
Date:   Thu, 9 Nov 2023 11:58:23 +0530
Message-ID: <20231109062823.3268724-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb82247-a0ff-4bb2-f57e-08dbe0ed1812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2WGK003gqJ1QMYfixsPwsE2hnmuE7EVbgtZls4I8gs53siRYg1oTsrC60a/pPkwog4AwEyN7aeZBNk7oQbbXaNXxgqslm32tdUMJymypG7sW73WiCWEeHpO7hLtTCWflECYvdoQbftgKF/5osq7z9bTcUvx+7MbWF6AFNXrc0AJiKZw0td2ul5BGlsvC07qTSKzjd3+OggA1S4VmoqocWkKxoRIrTl0K9BACeNlfdYlDFaN38TMQyU5G2OBvUakW1eQlbEZ41nHSw5aWPvVkaPwa9oITIDEkBqghBDrxROMFAAc4Q4jULSLzY8vivYK05LxCddjTdVnE5I9WmlhdLNrphc+tsFxfaTayQnKavsaZduPJMwd3lPU454SVNdSPvuSsK9w/tv556T5Fyzcfu8N8IqnPXY27rYJehR1CFBBa68B5jHBuGPgJL1mMw3SIPjv2HcR/wCu331Mb9G35X/FP7Fq8WV43Cj7XFiywJz2T17BF/8XwvL5ZMBVEucQD6Ul0VQHa5fBdAICFoNLsrC/yVdp7lNezwpQavu4V8VfipiQWBXILgnqJxelD8d89ke8eW6CpgTTI7W1Sks6hDIK4XGad6oOjqkzTSEXDiIEHTOpknHwXccAi55S6qXPk37HwB9Gt37fbHsMy7hfNDyt021sTvX5YBLIHfm0FUNIaJyQ43W9G+ClxQucwMNgtcxFDoCXCHaZOiKQCufzE8AOljpx3S282lcgqubMudLgSnmsiFhYpUy6IlsGwDc+9bYTe08nqqy/fH6ly/5V+zcOLMOstWygj3Dy3vgmTxs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(83380400001)(426003)(336012)(16526019)(26005)(6666004)(1076003)(2616005)(47076005)(36860700001)(40480700001)(70206006)(110136005)(70586007)(478600001)(316002)(36756003)(4326008)(81166007)(103116003)(8676002)(86362001)(8936002)(356005)(82740400003)(5660300002)(2906002)(40460700003)(4744005)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 06:28:31.8355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb82247-a0ff-4bb2-f57e-08dbe0ed1812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

zynq_fpga_has_sync () API is expecting "u8 *" but the
formal parameter that was passed is of type "const char *".
To fix this issue cast the const char pointer to u8 pointer.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/zynq-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 96611d424a10..988853137ac6 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -275,7 +275,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
 
 	/* don't globally reset PL if we're doing partial reconfig */
 	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
-		if (!zynq_fpga_has_sync(buf, count)) {
+		if (!zynq_fpga_has_sync((u8 *)buf, count)) {
 			dev_err(&mgr->dev,
 				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swapped .bin file\n");
 			err = -EINVAL;
-- 
2.25.1

