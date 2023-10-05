Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082157BA522
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbjJEQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbjJEQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C94E20E5B;
        Thu,  5 Oct 2023 03:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRgerfsuS5/C6R7rgtBP/THa2hkMMDUevJ7SFOQyN+6q56y2KjUg332kR1z4zkZkOL4J+3GuQRuGQu/ACeV2d43ps0JzgOlCME7A04BkRcCst4I4qOCBCS1H5T/bT4oRNwVN1EotHAM2sttNK+6XeyvQ+VE5YFLwRzyYlOaWQrWkmqdmwJNx5p0sfEStA1roLjH+7+KJyA4oUIS5nEnCmHi8y90jtu85E9EKKiXifs+yF1sQpJwkRvDvfnK0D00ICVfykXT5ttyQXbKErSB8tW6/5DvchhEnKY0MP3yPDS7Zc4ADw3igWTX0O49GHaNR6QwvQC/tz0KTaWr7eULolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP1vEXGDwQNgBCAfu4Uibkw+clkHJSMzHN0SLowiA2M=;
 b=kIyuqGIs5phtJFpF+HyYurICurCn4CzZs+tfe4FSHz34bB4pqhF4AcmhVbhXf6WAotwK/gt/2nVKoAF254uD3jtp4kEivWiIbOH0Rs7NHmF2eV5mFD3y9ov2vaI3CmF1OUYTsI7MN5xsonJFZPOiNqlmuzkHBBaCpjQ9P9+OllMxOuf+/J4ErbDDY3V9+TCzxEKxKLPLqjIqEAA0qvOR2tHv29CqC6ry9joZ9LgWVfB7j4Yx/yuKTepsWvnJv8wcoPbFAiS4CtHQwr19pus/wBnLDgkfd2LH4U4XlFAU78Ztn6kBKK2DhG7+MIlBLS0MSaNur3Rm/Q6A+bIgk2GfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP1vEXGDwQNgBCAfu4Uibkw+clkHJSMzHN0SLowiA2M=;
 b=3LT/jAQxxBX8WUl99zCOEmSkX8eQhpuMWtVyqpgSFLS3PVEqPzgsnp8WBs3tH4U0GGgAeyOd6Uy84Uzmqo9Gcpp3/V24KjgJvo0Zlx4WLfISOPsz+TYatFhRfjUzXtHoGDOSRmLItn9v15UAhIxblOe+8Yz85DKW76BEungb/WU=
Received: from CY5PR15CA0234.namprd15.prod.outlook.com (2603:10b6:930:88::24)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 10:28:13 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com (2603:10b6:930:88::4)
 by CY5PR15CA0234.outlook.office365.com (2603:10b6:930:88::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.37 via Frontend Transport; Thu, 5 Oct 2023 10:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 5 Oct 2023 10:28:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 05:28:11 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 5 Oct 2023 05:27:54 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <Thinh.Nguyen@synopsys.com>, <robh@kernel.org>,
        <herve.codina@bootlin.com>, <yangbin@rock-chips.com>,
        <pgwipeout@gmail.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] usb: dwc3: core: disable 3.0 clock when operating in 2.0 device mode
Date:   Thu, 5 Oct 2023 15:57:25 +0530
Message-ID: <20231005102725.8458-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a802b2a-5a69-496e-8717-08dbc58dc74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcheHfE4Q0g+V48bc3ayo1aEGGkL4+h2lisIHS+l0k9vym0vi0ZMhSm839Jhc78ZxSMX4mK9ZDXPuullZgjeH2d1uys5UVAEFb8ji4abEGhLNJuF567JO+nRZXKeBpF9crNBiEXHZvzcrsQBmX3VdqKIVU6cgv8E5gUkJlLa4WWN5jRwzOryuGA0+Pt6hebkEJZ641FAoqZQATuhY0m54yzKvb326EqWo5/aQboztxwkjDkuTnvy+gPmgTMiUSM2xl5DBafDnf9DqTrRFvETATsN94TCUsLGtrG5ywk/bRSyWUgWm52LGZVgUD/wfitC9HdX2NQmcWJOQWjlatDxxOeMHhD7t7FNb5OAhiYOTqG4F1JHXIaFGLaG1tFeR1WD6jN/iyhWmFBohlqu2p1cMXAnEMife8lDzzt+nBHxHsoCCa6mv4kj0HaVXGIPnzP+mAiFUCBxsA5de3kdRbnH0JRQ7DDW24BzIxUhhqeLktKBaeTy185nBAXWQPqMb2hlNKKU2nYfLgYonVTKxQx5PygAMxrLmrMlvHb7gfT+gbH1/TOmmaPaKnVPXgtkcio1MoqoH4TTAP1PAonGc8EwSZSOxgcy4+G+sFkfE/3qOW7IgE7JF2RQudXpaTT4Edkghz47b9Q8t3+Ek5aJIVOcd+weeiViIY/8z+aAIlzZClho1Y4//PpFqqxpB6S5SrGOl6SsWsEmXbMO9w43Vjsq3tfOc0BQiSpYiRR+cHLJ+WeGK9mapSjY8IPbaFBxTjlCS0B4+ukdi9WSacty3UDQXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(1076003)(41300700001)(110136005)(2616005)(966005)(316002)(44832011)(54906003)(70586007)(70206006)(4326008)(26005)(5660300002)(478600001)(336012)(8936002)(8676002)(6666004)(426003)(40460700003)(83380400001)(2906002)(47076005)(81166007)(36756003)(36860700001)(40480700001)(86362001)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 10:28:12.6992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a802b2a-5a69-496e-8717-08dbc58dc74e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
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

Fixes: 62b20e6e0dde ("usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode")
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
DWC3 Register Map Link:
https://docs.xilinx.com/r/en-US/ug1087-zynq-ultrascale-registers/GUCTL1-USB3_XHCI-Register
Register Name	GUCTL1
Bit: 26 
Bit Name: DEV_FORCE_20_CLK_FOR_30_CLK
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

