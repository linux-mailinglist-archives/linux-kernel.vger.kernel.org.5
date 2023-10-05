Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1897B9F09
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjJEORG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjJEOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:15:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC11024EA9;
        Thu,  5 Oct 2023 04:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjzpB3+554tHaGDHPytL/jgqkiL+vGWq3kQrUcgfx2sUphCVenwlaJD7eI5FwqcoGH5B+nLpT/uqeLaOsV3Tk1dNi/CDjg1S2VFhWTdlWsEhmZd7krirIkj6z3L9UYdVcftmbiIibMmXUHwVZS2LFeFeq1nJzEXL3e0E8a4NiUPfANwMaoqMho1SSChaX7m99S7N+FudH/NdR1+4JpRGwebtHT7AaOowugzYyu7xg9gAVUOt48GOmTn2xD8CawDJamXSP0k7sajqyQaIpKi4WfnvxM6YwcfDvNsmUBl6fnrFQTezgV0yObFhN0GxR3gBSLL1sX5SPDNvtHbe+QlcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIavWWJEftVPDFWJ2r6zd8KwV7K7mVa2mPC0LmzmTrU=;
 b=HGSnuRtxuXQ9Di17XxnkUmNVRZUKR3lGEMAa4eHl2p22us4mYnZKqODj+lkl09yY0BC+jIlw3lZJbKsGpoZU7kHmfsc7V/wyTbrjIqfmr7TuHuAA+HXJQDQCpu6rNYBOHjH+D/NicjVqf9vdRO1ZrvaKIbF2OKfheCRDWrMKOPZCjtJQdaCsDU/uVNChISmXpZh5Usts+17KubQlY5pnw/tVyo6BtHgai2dSzWK98yGemNdEb4pqn73/mBdZvlpG1yuPfodvulloFtuz54PC/FTE+xSu23u2G8c4PA0ou/Swg5W9UdRA4VrdhJU7PUOSNPbp1FSxUnbOCty6CXX8mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIavWWJEftVPDFWJ2r6zd8KwV7K7mVa2mPC0LmzmTrU=;
 b=xlK5RJPsx1L50RT3jNe1aSyyg5RknRkxBvu7x2gHt9kVKT/AFjgssWwVezTTaGXSVJIeNXs/maWJHbEH8hPP1c+sZfP9IE0dbqU10DrlCmmbKvqZnsoaCuXvAc3QGIRgIo0ccBtEdh239RiZpIkAmd8CL7PlQFw69H2dRJQybQ8=
Received: from MN2PR13CA0013.namprd13.prod.outlook.com (2603:10b6:208:160::26)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 11:36:40 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::da) by MN2PR13CA0013.outlook.office365.com
 (2603:10b6:208:160::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Thu, 5 Oct 2023 11:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 11:36:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 06:36:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 06:36:29 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 06:36:27 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <Thinh.Nguyen@synopsys.com>, <robh@kernel.org>,
        <herve.codina@bootlin.com>, <yangbin@rock-chips.com>,
        <pgwipeout@gmail.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH V2] usb: dwc3: core: disable 3.0 clock when operating in 2.0 device mode
Date:   Thu, 5 Oct 2023 17:06:24 +0530
Message-ID: <20231005113624.8329-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: bc892bbd-bebe-4e5e-6dd3-08dbc597574d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVUab0/zFpnWoTdCW/xWb5ynv+IhuodgMO4haNKv8LpJ2bihRp/WMpde57RFI1jjRbpIh5sABxWUYVRIXuagjTAQf+8sx4GI2OSO4w6Z8KvA91TekSDBBMm6K4ZL2115hfwtKD8krrJ+lpJ0HVcL6qpRPKRhTmNVc5YhRoTyHcyU5bSAhJiBgXY0ZX6og0LbjRMaOk0wiIwRdb+SJ0g9o2QNjo06+EjCyKRnVU80TfLirLrg37xp6qL0GEIJrqU1+LvxEBROU2dUS9Z+7qgovMABsr6afocfUHTdsXOf4eLZAHMwlDLMgPsKs30yykylAznCpOvrz8UxmmQj0ybG1EGIw6TKU5QsDdZcq5VbMrFAz5WYM4J6gZ8rUAxQ6dIzwES9/fkXAdcyWQV+r/jfrQn11MWr7Zx5CnXqYB5ptmALWl0HAhh/H0qyMzfOXfDjTIltNV/gCdwmMKySf4+3ghuCPfYJtvlyNRZDtHa6K7+T9YKKBhMyVukmmfqaP51DvUil+Rph6qjoO8Z9BP/S24D5CfXkHtWhIdxPnG0mx8Xrteoi2cUHugV/w4LZV59b+oDDYrMsKsc4TLwdK8fVo2D6oQpONBAVphd2eJR4MHrl7g7jDd82FUqamjg9e90Q+ds//JNTBgWYwZh7+7BtIt5EKw/DhVrXtpel4pH+CrfS/bRP7dP91MViHdUFkPRovbc3ZXJPtXuqo8egfAnTekWe15A5ZA4nGC+ZiflZMgcxYG3kyf4K5ikrvrQih0LKvrPb3dJWkQZuUuSAnbPSvqYwAateEIHMaj7wnRGF7XE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(70586007)(70206006)(316002)(40460700003)(54906003)(41300700001)(2616005)(1076003)(426003)(336012)(26005)(36756003)(6666004)(966005)(478600001)(82740400003)(81166007)(356005)(47076005)(86362001)(83380400001)(36860700001)(110136005)(40480700001)(44832011)(2906002)(4326008)(8676002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 11:36:39.7857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc892bbd-bebe-4e5e-6dd3-08dbc597574d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GUCTL1.DEV_FORCE_20_CLK_FOR_30_CLK bit enable the feature of internal
2.0(utmi/ulpi) clock to be routed as the 3.0 (pipe) clock. This feature is
applicable when core is operating in 2.0 device mode.

When this bit is set in host mode and core is in 2.0 device mode (maximum
speed = high-speed) then usb super speed devices not detected on host.

To address the above issue added usb device mode conditional check.

Cc: stable@vger.kernel.org
Fixes: 62b20e6e0dde ("usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode")
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
DWC3 Register Map Link:
https://docs.xilinx.com/r/en-US/ug1087-zynq-ultrascale-registers/GUCTL1-USB3_XHCI-Register
Register Name	GUCTL1
Bit: 26 
Bit Name: DEV_FORCE_20_CLK_FOR_30_CLK

Change in V2:
- Added CC stable kernel email.

Link: https://lore.kernel.org/all/20231005102725.8458-1-piyush.mehta@amd.com/
---
 drivers/usb/dwc3/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..0cf1fe60628b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1202,6 +1202,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_HS;
 
 		if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY) &&
+		    (dwc->dr_mode == USB_DR_MODE_PERIPHERAL) &&
 		    (dwc->maximum_speed == USB_SPEED_HIGH ||
 		     dwc->maximum_speed == USB_SPEED_FULL))
 			reg |= DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
-- 
2.17.1

