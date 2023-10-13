Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D5F7C8642
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjJMM7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjJMM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:59:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EEC91;
        Fri, 13 Oct 2023 05:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV2tF6YA6zxaJwuQBtQsBVh9o8lWSuT6RCB5EnA2TfsvJNx4Daoa9dm+9/oPksVjoJ3nEatm73CgcnzAF85W6y2P7xUud7AYuX80zzjNloapqQ0BSHzs848HuasRJmMhVH+p2p7l63YOkqxr9J8CBZ39JZhGZVsx5WfrdAztjdpbs6e3Mpe9lKVoOHo2tAmwpJCWiV+ZmK+oPuWkYOdcpWmnwKZUPr2GLnvk9ZNNNUzoPvgcQEBTd9QG6/kMjDWs66CXGIXoVhE603sz6z5uQnDfRD9daLNJC4RRsSilK9nM6zcfZm6ErJlZZpzYG87kGXkhfTzD0jOBns7dPiZvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYfomqZ4+rLICC4/N2/K4WrcEuyyny2NI8siBHZ0T2s=;
 b=M8TcYBPMnrpoexLp7tX+dasUrI4Sg+0LJfk3hhKNWLFJOY63ojJtf26MUAQGZHnM1D2sdf8/JqCn3rN9QaNqgjezThML24Doxu45QSCQDFxpvybOGV/lAAcakMX1mP05IhdD36qJh0sGeLlkMzb3rNuqkWqa/dS77lcMiTp/jl2o2E5G44gqMgHzJ3R8iBQXnSPSiMESoygwdXvAEzeQYN+GApNZx6QkuZXXX/M/RS/BQC7DVXbu5Ue4sFnU1GxN3vt0F2WoJxcTjrW21uxNggYuC3KbSX8Wt47kmFAVUgs8jMUyykWV+pYFeNXAADl8Rgxfzl5Le/0pvSSA6pc9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYfomqZ4+rLICC4/N2/K4WrcEuyyny2NI8siBHZ0T2s=;
 b=lvT440EThI6bx38/Qdgrl2kHOHpV0A3qLw9ea3v3p0/omHPxcT84R9FSCgueNDmZ9iLJ2FgBi8WcldZbIekxrmbY1kIbxIcEoYvgUCpaMz/40vaJoUDJwoU0mZlXOAJehe+hQpfEiTJ7f+LKYp5i3zejPO4OHETxf0NBH0DUU54=
Received: from DM6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:5:190::20)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 12:59:04 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::5b) by DM6PR11CA0007.outlook.office365.com
 (2603:10b6:5:190::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Fri, 13 Oct 2023 12:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 12:59:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 07:59:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 07:58:58 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 07:58:56 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <Thinh.Nguyen@synopsys.com>, <p.zabel@pengutronix.de>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2] usb: dwc3: xilinx: add reset-controller support
Date:   Fri, 13 Oct 2023 18:28:47 +0530
Message-ID: <20231013125847.20334-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8efa3b-5e5c-42ee-3c72-08dbcbec2dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VECu/kBxf388O3ZeEGxtepLMsCr2l6Iy/23UL0YZQIsbkphvIl5m+mJOZQvNgXFEwde4I3WLVI8oqCM8soBSMRSIqFhPeNcQbwQoIVTCQJ6t1s41eEW/Uyosslvln4vz91LQAPFbeyzMwGtMCz1UXIbPNy1YEGGgXAJIy4IN4/UWWBVrzRG/oIH160a543Cb2ObQpb2ity1UM0ZiHcnONvXLTvW4ppb2ecU4BgA4mhMrm6WuVtWFqJ6rKozxfsf7V9BY3d5EySiOBLT9BdD+8EA5Jop/+d844IJvm3AtpCmU+zFIUY4s8C3OJC8IGfAMhs9HEny+k4KD2xAvmJ+pzXr4K5mxjdqz3HFtjwPZzCuubOLnNE1f+INcLb53uMQb5a/k61rBFzECxOGU0xIhB4vTosjnz7+ORBr2fuNs1Qjb/Zh6nDIv8ZYrk+cTVf1ZhtrOMNkbkpqsAtxogpA1clxQ9L7K+WfAO2mejWT1Otr1oALh1IHIFgB3vWR9o89v5/hzvPzMOz3Skg4lxWorUs+0hwxKMUrortGQUkn01Mfl4tVdIKZAOz8mEz1deHtzHyp50e7bcCfbE9gpiegqyiMRfEfgctY+BLXVMAyXyzp3PwNFYY38fHl+igAqdULefYi6g9t3GwEwiduzihvogLTMwJvPpDhocJ/JsIAYwZlmvVfpMuZC9XrJ58kh/DlwmK+cm0aTrEyCnI7SdzNLPiips2cnmr0+fxwbbSxAGhjgcXsHwz4nv7S+hxxmZR6uHurqyyKtu8rN2OYBS6XYbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(47076005)(44832011)(478600001)(81166007)(966005)(2906002)(8936002)(8676002)(5660300002)(356005)(4326008)(83380400001)(36756003)(426003)(26005)(336012)(41300700001)(86362001)(316002)(40460700003)(70586007)(110136005)(54906003)(70206006)(2616005)(36860700001)(40480700001)(1076003)(6666004)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 12:59:04.2372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8efa3b-5e5c-42ee-3c72-08dbcbec2dbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset-controller for supporting Xilinx versal platforms. To reset
the USB controller, get the reset ID from device-tree and using ID trigger
the reset, with the assert and deassert reset controller APIs for USB
controller initialization.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
Changes in V2:
- Removed unnecessary delay between assert and deassert.
- Updated commit message.

Link: https://lore.kernel.org/all/20231005142215.1530-1-piyush.mehta@amd.com/
---
 drivers/usb/dwc3/dwc3-xilinx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 19307d24f3a0..5b7e92f476de 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -32,9 +32,6 @@
 #define XLNX_USB_TRAFFIC_ROUTE_CONFIG		0x005C
 #define XLNX_USB_TRAFFIC_ROUTE_FPD		0x1
 
-/* Versal USB Reset ID */
-#define VERSAL_USB_RESET_ID			0xC104036
-
 #define XLNX_USB_FPD_PIPE_CLK			0x7c
 #define PIPE_CLK_DESELECT			1
 #define PIPE_CLK_SELECT				0
@@ -72,20 +69,23 @@ static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
 static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
+	struct reset_control	*crst;
 	int			ret;
 
+	crst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(crst))
+		return dev_err_probe(dev, PTR_ERR(crst), "failed to get reset signal\n");
+
 	dwc3_xlnx_mask_phy_rst(priv_data, false);
 
 	/* Assert and De-assert reset */
-	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
-				     PM_RESET_ACTION_ASSERT);
+	ret = reset_control_assert(crst);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "failed to assert Reset\n");
 		return ret;
 	}
 
-	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
-				     PM_RESET_ACTION_RELEASE);
+	ret = reset_control_deassert(crst);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "failed to De-assert Reset\n");
 		return ret;
-- 
2.17.1

