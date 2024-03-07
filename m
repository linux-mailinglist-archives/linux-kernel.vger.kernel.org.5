Return-Path: <linux-kernel+bounces-94902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 896DA87467F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D081F22113
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3CA12E4D;
	Thu,  7 Mar 2024 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n/gZzU+8"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D65EAD5;
	Thu,  7 Mar 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780634; cv=fail; b=br/CsO/YbOQ1WvgeqZqKsIzmHMBEtieDUodkNgsNVF2wjbBbe9s0Ih9QSjYQfaLwgxscGoV2LxgI/HEg4f/LAOtW3KBBNO6YyEGxqX90dgupMw8qm11A+3JuXCBnEZkqgzZ7oaHUlc6i6sxYz8MdGtqdq45k7bqNL+WTp8fxzlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780634; c=relaxed/simple;
	bh=lxPVqKIafHhoY8LmcgLm8pklPHxie30HoUAZmAKqINE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuLLsVgO7Cu0FuoEjFdPnS1FbzeP2D7AzNbMB/JXq2Auhy3it0yukcRd+V0EUE2QQwRKvdcZgZ5v+X4gaNjpyu0SoMayPNzJFYerAWBbDKQD67ipZJrlr49sMBikS1fkclKrXZFtBYSFggrTI+7S5TbAcQyhIFCpsU2TWWwQazM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n/gZzU+8; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg+hBz20SsmMRPOnOsLLecFMoRgLhA1D84AmuiXB8EqGvzCbS9IJkYBuBGzvrnzFgZnfq3/KDhf5kmE7GRGZMKlIcglQouzw/gdJfDaIT+V1IImnaANJEJOWL552HGsqr9QPl0Ju+XTKjPwPKQQlLHxJnoOm0fr78SQO5Bi1P1x7dg/c1BKy+EvPl9OAd8pwH3GVajCVvoYZ3kTwey20Bs62/2LHYhZQmlSHksCt6mKwNKWZBvuSvCGHRpp4i174uCa32K+GuYvl9siPwZV1B60VIFMb8ldXrPqEXQBe4FIvLeq1PilRvCONz5meFPXJ52fhV5CWgoCB2d9HeStoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqT6OVr3rf/KIUEPDk87qjqO3uja75xloQCTYQDw7BY=;
 b=gASwEeJ2N253jwEQtQPB9V7HzSaPXW09K7j6Jyjlj983biH2IT/Ix/BbDYhgfUF3TVmAgXehgxwSfQB4wvUxgkQzWPqTp54weYLiJtfRXkkeVMXmFwy1zEOe1AFReFKwfKHSWlPoOALoSxq/nP32cSANVt9ZhZ845rumI3mMwoIfzTCIy1CCH/tdYi5KF4CwZX7dKfZGbpXtZ4wEvZE6jIjDpSu4zNKz8JsXTcKn4WuQl0+MOQFKUmusWvb3QyuvkKxY7jEYehhF7rixDc6q8/zo4ozwOc4omG9gL3W/ESjXYYZEgFVdEjZeW9w8vepK+HyXqVmuF7/WkP5Gtym/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqT6OVr3rf/KIUEPDk87qjqO3uja75xloQCTYQDw7BY=;
 b=n/gZzU+8/x+arKpkfOxlJxTV8c7RIWxgm4NQ5xQ49jLIsGQGGoyFxNxjVLfIyfrl9YURbp4JSqBpxZlrnHYtpeB7dFEtljDxd9BNGGhsnfDtHrvgk6vCyUVYaqRZ1wrG0tCUmfiroy007khzU+CFnWEzNurlZ26h24xcmYpcjin37oKIn27IktfSmE+8VdWfMJ7oLSU3AjXQLfwU8yZ+kPbMmpJdzQQkr9IZsYgLi2PsbWj4AvR7DKMVmmARO6Hn8UzzrAMKI/ryzq4sR3OFcoee/RV88Kl5bZp1BKUfgQGAQad+KGbMqsAnukSPQ1dKPzxYas8cJo0RjRXXPXF1XQ==
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 03:03:50 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::5e) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Thu, 7 Mar 2024 03:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 03:03:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 19:03:38 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 19:03:38 -0800
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1258.12 via
 Frontend Transport; Wed, 6 Mar 2024 19:03:35 -0800
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 2/2] usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic
Date: Thu, 7 Mar 2024 11:03:28 +0800
Message-ID: <20240307030328.1487748-3-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307030328.1487748-1-waynec@nvidia.com>
References: <20240307030328.1487748-1-waynec@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 689066f5-5ca2-44cf-a26c-08dc3e5336ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KoGLjQSJiH5KCXSZQbcW53pfnFP8sg+p26eWZqBCvEw4PiUFjSMSyKvdfQvwj6qZsrkAhKJMS3tGQnXyxtGTFk6/F0hgypmA8/HGpgQLxV/ibHw+s1X2zqQAIRSSuOn0kb67vj6bv/QVUtkrr5ukR5/5MkiDzLo6XIgOFlLVE4ZbxrYeh9YqPtJsEASXKoGItottR9Sl5DBAYAOzMLorgFj2Tb0GFjK172j3lnZQ+RlA9me2o36Ah9HB/cxWFhM/04diVmjKTYWoYFHuxQggu+U0TrnCMU14XCR959FaPZvGiUy7gCafOQ27yj7tAfM4HiQc2wqk1W3T6gGhymkikCkb/N6XJOHgNjWGRTPmTRCAcy6kkIQZQh6t9zuFaHFXJrRMZRg8umKgD+uj/eAOxyxF6FthrmmyC5l6k9CEzkKYfyoTvF0yk6LwEMeNF+6+2in468qsYdowD1AsIk58MQsn3VSJc/DoOYUqLkpmN1Ads44PpYDavhKF1FeSVD+/EdSubKhOTOzTRdFCryb1IfrKks0Fdvhl01OBOquoCUjqfFrVi0qEATJYXaQ9cslK0DpKyu39pJ152xy0crcI+/Kz33Mf8ddVTUYsuWs5yBWl5KG0tfMxV+umjzri20qgDs8ijxvTeuXuaZtPFFDZ/7109Dh6WS0VHutWi7rJh7EIoBG0it8dz/XpCCEpmP0pApMh61hIC3vmEp7BuyC0gBjVHg/cqdz+j8Vc0i7fy7P4PSuMk2oAcZl5vAq3fhAk
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 03:03:50.3671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 689066f5-5ca2-44cf-a26c-08dc3e5336ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666

This commit resolves an issue in the tegra-xudc USB gadget driver that
incorrectly fetched USB3 PHY instances. The problem stemmed from the
assumption of a one-to-one correspondence between USB2 and USB3 PHY
names and their association with physical USB ports in the device tree.

Previously, the driver associated USB3 PHY names directly with the USB3
instance number, leading to mismatches when mapping the physical USB
ports. For instance, if using USB3-1 PHY, the driver expect the
corresponding PHY name as 'usb3-1'. However, the physical USB ports in
the device tree were designated as USB2-0 and USB3-0 as we only have
one device controller, causing a misalignment.

This commit rectifies the issue by adjusting the PHY naming logic.
Now, the driver correctly correlates the USB2 and USB3 PHY instances,
allowing the USB2-0 and USB3-1 PHYs to form a physical USB port pair
while accurately reflecting their configuration in the device tree by
naming them USB2-0 and USB3-0, respectively.

The change ensures that the PHY and PHY names align appropriately,
resolving the mismatch between physical USB ports and their associated
names in the device tree.

Fixes: b4e19931c98a ("usb: gadget: tegra-xudc: Support multiple device modes")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
V1 -> V2:no change
 drivers/usb/gadget/udc/tegra-xudc.c | 39 ++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index cb85168fd00c..7aa46d426f31 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3491,8 +3491,8 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
 
 static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 {
-	int err = 0, usb3;
-	unsigned int i;
+	int err = 0, usb3_companion_port;
+	unsigned int i, j;
 
 	xudc->utmi_phy = devm_kcalloc(xudc->dev, xudc->soc->num_phys,
 					   sizeof(*xudc->utmi_phy), GFP_KERNEL);
@@ -3520,7 +3520,7 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 		if (IS_ERR(xudc->utmi_phy[i])) {
 			err = PTR_ERR(xudc->utmi_phy[i]);
 			dev_err_probe(xudc->dev, err,
-				      "failed to get usb2-%d PHY\n", i);
+				"failed to get PHY for phy-name usb2-%d\n", i);
 			goto clean_up;
 		} else if (xudc->utmi_phy[i]) {
 			/* Get usb-phy, if utmi phy is available */
@@ -3539,19 +3539,30 @@ static int tegra_xudc_phy_get(struct tegra_xudc *xudc)
 		}
 
 		/* Get USB3 phy */
-		usb3 = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
-		if (usb3 < 0)
+		usb3_companion_port = tegra_xusb_padctl_get_usb3_companion(xudc->padctl, i);
+		if (usb3_companion_port < 0)
 			continue;
 
-		snprintf(phy_name, sizeof(phy_name), "usb3-%d", usb3);
-		xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
-		if (IS_ERR(xudc->usb3_phy[i])) {
-			err = PTR_ERR(xudc->usb3_phy[i]);
-			dev_err_probe(xudc->dev, err,
-				      "failed to get usb3-%d PHY\n", usb3);
-			goto clean_up;
-		} else if (xudc->usb3_phy[i])
-			dev_dbg(xudc->dev, "usb3-%d PHY registered", usb3);
+		for (j = 0; j < xudc->soc->num_phys; j++) {
+			snprintf(phy_name, sizeof(phy_name), "usb3-%d", j);
+			xudc->usb3_phy[i] = devm_phy_optional_get(xudc->dev, phy_name);
+			if (IS_ERR(xudc->usb3_phy[i])) {
+				err = PTR_ERR(xudc->usb3_phy[i]);
+				dev_err_probe(xudc->dev, err,
+					"failed to get PHY for phy-name usb3-%d\n", j);
+				goto clean_up;
+			} else if (xudc->usb3_phy[i]) {
+				int usb2_port =
+					tegra_xusb_padctl_get_port_number(xudc->utmi_phy[i]);
+				int usb3_port =
+					tegra_xusb_padctl_get_port_number(xudc->usb3_phy[i]);
+				if (usb3_port == usb3_companion_port) {
+					dev_dbg(xudc->dev, "USB2 port %d is paired with USB3 port %d for device mode port %d\n",
+					 usb2_port, usb3_port, i);
+					break;
+				}
+			}
+		}
 	}
 
 	return err;
-- 
2.25.1


