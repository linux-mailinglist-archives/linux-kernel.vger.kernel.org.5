Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49477EFFFA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjKRNq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKRNq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:46:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F52131;
        Sat, 18 Nov 2023 05:46:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2jw6xbPW+wQ6JCbY/WsIiMI01/GtY4hknTVRxuw38d0JWJwTni0O9RhKmXDipd9MT0/wjndY3CvdtCCaphqagK/wknJI/ALFFNwaI9pEpd18F/IYYEIOBXRXerrv6h9hG4853TdYTE6alcY1idFxf2Yw+M6beKbbSeoSjCLBRjU3M4qj1w6hTCHLl65Dpg2PgS2ezofmOVDTUMfyB/343zirGOUP0D8cxDB1TLgKm7dyctZrEcbpBdP+AeB/3WxK3x20Ql+O7+CMSLWdJrSXqQyXH2nMDKDi7Ll+dId4j4wKQ+zbwmP/tsVMHlqpRW7lX+waH5A9J5S0IGvQq30sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KsypiKdqTvkjupfwpZNiFrAIZzYbdEyTTI0a6Ogywg=;
 b=b+VZV0U3xpWvqZOOa4rZ+lx1xfMvhb63Qbb/lhrClWBef/O/WkMophH8apuvS/pt/1LzE9O+/aco7Ta0XOAnVNv/F2umobD16nCrCm3hMEwTQQNFS58qUjFV+DDON2BhfSTXDS67nVO2PkqCtm1xv589xcwOnGgYQPogcVbxBEgs2vb0PniE7al8J5ZMt/otN57fDRRH95DSjJiC3Gnr/UDEpZK4Fz4nvc9fXKkn/tDZMjo2WuEYYymTOHc/wSD05ntnY5sFJNFCABOmFIyYNBEfmspiD86S4PDeO72g3fdAlxMmwSepARA3bdj9fbIRoUi21v0zC3WyLSJMqWRsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KsypiKdqTvkjupfwpZNiFrAIZzYbdEyTTI0a6Ogywg=;
 b=Assv0mtsHc2HxkxqxEvcDtS3C68CLhZZxlQ/+BUJs0V3H3bnCIK+uhSFrgEpUboygxjuOueh9dUlVHwfySZRebrDOxiWFNkxQD23eSUs/oY3R/WFAx2i9pMeOUoM7qIMzQAU1ZoOB+RRoYL2W3mTyc/62qbtYEilHT4IqgoVzWng2HcEGUwNuNC4IwoDpkj337G35Gm9KRAvEJ1LH2vsUXFToG1y0R9cUIphHrjHx0d6S81L+tN4IoIKJqp6D5ZtQfHjwh+yDxKlG6gMQZGlGDi8WRcOULvYs7jXbhJakQ7M/4cfdGQFcDOQX6c4EHnE1faZ+5S/nD9RhjeaMz1Tpg==
Received: from CY8P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::22)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 13:46:47 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:46:cafe::66) by CY8P220CA0010.outlook.office365.com
 (2603:10b6:930:46::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25 via Frontend
 Transport; Sat, 18 Nov 2023 13:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 13:46:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 18 Nov
 2023 05:46:46 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sat, 18 Nov 2023 05:46:46 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 18 Nov 2023 05:46:45 -0800
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for BlueField-3 SoC
Date:   Sat, 18 Nov 2023 08:46:38 -0500
Message-ID: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c0db98-b13c-4320-4495-08dbe83ccf16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3lzhZeAqc6UlhOok5U2reiVggBmg7TD4QsGiRm5SE7s9WOC9Wuvg5xqqQA3FP8AxKEfMEapYJn6gyXsTYGf+qajXhTkz4eWe60X/TFidIy++y5J2m2BX91t24fjuHfrXlXnY+9xEo88SDIgsJXhUIEnwiEFAmqFDhw/KKpPvaBDnl82+Rsx3udFO5AUTbJldjDzr7+xi566pRHLpSC8vGTFzNqbD2bxfE5XiokjGNJyV0mslF7CDG9ci685nI+GnRDM0p0DXLwgmQx6fusY489B4RFMUV27Jjn/WL70r3b0U/6sXNBhEvi2iIebVGsiEcOnhIna9GxVUufzZ6g7uPLZOVRhmTrbVSb4EddFIK60Nms/tBkslHLTtw84BnB1vJSCOeU5n+pKCKerEm2kh754WB8BuFW+2vH2xIOGh6fHtBXFZFfjBDXCjkAU7tfwZxY8v3leyQOlWAvRkIzG31V25w6YZKH5mZTkYss4u0a/xoAslPGQMILoiHN/3ti3tN/CrRhtTJ/i6BNY3EKIRzFGSQ9VuxQ2zaHo3b9p6WbYy727WI+Z3VvTO6hQklhJpKhaXSDq9iX+j4LIb6VC6Fr0GsvzsrrPXdB895WHhVZ7FQYrARyIOz93zu7yQivGrEtONK0Yrv6lMLlHaXdI+hb/BgoYhVaUEBuVU7WBLxybGzZVRVziGM6DFzmH8QIOCfrPzIc2dwTP2EoojZwkaL6SKqM8hZ/0FAJeMKdlTy63vRBJYE315ZdE5wqRxwyioZ699xkNgKecJAlZDAZtmQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(46966006)(36840700001)(40470700004)(5660300002)(2906002)(4744005)(4326008)(8936002)(8676002)(316002)(41300700001)(6636002)(54906003)(70586007)(70206006)(110136005)(26005)(6666004)(478600001)(7696005)(40480700001)(2616005)(36756003)(336012)(426003)(86362001)(83380400001)(82740400003)(40460700003)(47076005)(7636003)(356005)(36860700001)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 13:46:47.1988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c0db98-b13c-4320-4495-08dbe83ccf16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables SDHCI_QUIRK_BROKEN_TIMEOUT_VAL to solve the
intermittent eMMC timeout issue reported on some cards under eMMC
stress test.

Reported error message:
  dwcmshc MLNXBF30:00: __mmc_blk_ioctl_cmd: data error -110

Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 3a3bae6948a8..3c8fe8aec558 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -365,7 +365,8 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
 #ifdef CONFIG_ACPI
 static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
 	.ops = &sdhci_dwcmshc_ops,
-	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_ACMD23_BROKEN,
 };
-- 
2.30.1

