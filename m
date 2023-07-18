Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3A5757533
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjGRHV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjGRHVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:21:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA4EC;
        Tue, 18 Jul 2023 00:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eksCvzfmAbGxX5DoWqFX4dLKw9p6DMCT82Ht5Mg8MNDhN33NTA8kNM+a4AD+rDI6YjnpEcNMGfL/vC4ucVv3Lo7Hk5J2KdWiHqVm1ISpHkd727IupHYMFHxUC20vJ+E+WP50XKatmfGDKiEPS+m/742muGPgRE8AT+iYvmXN6NuP8DaFqYYqWa07qkrCooRn34X6+b8wZLMiJ6ovZqoeBOEJyjjO/5/mL+WpjcehnS3VRHThUL43+GTjvfnwDhXbUcJOHGpAwiYifJRavkZV3aWKq2UtyT79TuWwDATYOzHSG5GIiKivOmA9hqt7AgnDqm6n98L90Oms4Fl3p3/I3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bxv0tcbTsNipSGKcjMHCOl8Nlagbnn4Nrym5qIR4/A=;
 b=KWo44TmTzZ48YJ/vXlJjR4pk4d59PuY+tCJErDCUDC3IN3bwqxe6viWA6Gxj0UqBYaoM48dAPVlqF4dqvMAAn2Nia95TqfTyOiXEBJQRjMYdUrJyrfjfxdqxKtONd8z9e3Fk2iNdfjheSo3TGUrTgItB7luWfP3BKr9ItneKMnwNjZBoT7de+ETSzkvBqw4LTqJ0SITimsaga9e0Atfpw/xGGQFGjv/aRbqS/pZ/f3XLzlDljebQoTkHS64M69sVlRo0dQ9b3qdwTp4NHVXEY3mKF6Uc8iBrBQ3MofIVmMwsvLnzlHAsdK73RDOS8Et2N2znG5b7Ugknwd341VJyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bxv0tcbTsNipSGKcjMHCOl8Nlagbnn4Nrym5qIR4/A=;
 b=s8dxfERcw/zpS30BTpqCkYpPaG0mf0t01VzOutPX1nlSTMwt8Tukdh4JqOlaPlXA94Fy6q71bYkHG24rqQ4rD11lmmEyif4LCHR1H23HaqAALiE4u7XZqBArWUndJLvq4+DHpWXt9fK2j6VtGpu0RuEGymPP1L9K/tern6YWurisXsyxECUrt+F5SmudVTbG8j7+QqIc10WpUKpBBLLcf0sUI2BWkpiVj8mnm2ro86FDvQLH7R4Pnob1NHILaWAgefhNRmbzvIptMgx8QaTG7YhoNKe4LczU6BdfyVxCEyXxHIqzwoDzsY1gdXZGCsoYAyB+wAbLg5tCblZuj44a6A==
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 07:21:22 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::e8) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 07:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 07:21:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Jul 2023
 00:21:09 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 18 Jul 2023 00:21:07 -0700
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <inux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wayne Chang <waynec@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        WK Tsai <wtsai@nvidia.com>, Henry Lin <henryl@nvidia.com>,
        Haotien Hsu <haotienh@nvidia.com>
Subject: [PATCH] usb: xhci: tegra: Add shutdown callback for Tegra XUSB
Date:   Tue, 18 Jul 2023 15:20:57 +0800
Message-ID: <20230718072057.233011-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|BN9PR12MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d63ef67-e135-4f63-63b4-08db875f968d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ht9nDMfJSq9oy/P8YrYFadt4PVXWbX7WMu5jxb6ZGHXhNL47d5HnqHdmLncOKKbdjhBnQrgBXpPsRSj+h41QeJML4mhJYh0twarPhM1iuX1OsTeZRvWuBdmgPS5niKrEdvKwvsYJJ0xyiDQrr0/MbUZmELRkqxLWQ2l4Ys041Nef2Fsi5lSQp/bF1P1vLfNAojK/yRcprDnjaXsJerZIYue+xkgRM3olE2IVhYz8iESbBprUPO5eTFEGuh8/KUpXwF4ciAU7zrSLoMf41qXq98WaldLs8xgdyYG9trF9g19tPOTcVTys7z0tNX28K1YY3wdqzQ5ndVJQt69VxsaMHhDqsk/yl4p1RoRz6VCTSXuE5rXhGheYm3E6qcWcC2Pu92FmhsP2/ViIN4ZRw2SenFq4Tat+JUK2a50yaras7TAOyw/gkZ4IZmD1PvEKAjwKnX0NgVkg+HzKXvw8KA4YHjl9WT6PkOanrRGF+98O2BH9ZdpKei+DthbV48JwArLaSnDOqm9XhpcgwE95N67tYDvaQ8kWsw9QtAHeLEmfsOgZT/mGhfXMED+87qNUW1fn3C2B49RoY7KkAxRwd42GgYYIIAzzmp+0SCiQmWngIsbpFzuDO/g8q9mS2XSNpLQrNCR9lOQ3AEIY9HDpidRkYLvn3daDlw1jwvK5N4Jwv6Z2lqzXbopvMP34V/ZcAnArTfchMawfwjjxDFk5jEoAk6VTmvUpiZUvEFz3ytmi4xpnMtPEs+DL38Ng62HrsDG0
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(7696005)(54906003)(6666004)(478600001)(110136005)(82740400003)(36860700001)(83380400001)(47076005)(2616005)(426003)(40460700003)(86362001)(40480700001)(70586007)(2906002)(186003)(16526019)(336012)(1076003)(107886003)(26005)(356005)(7636003)(70206006)(41300700001)(4326008)(316002)(36756003)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 07:21:21.9611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d63ef67-e135-4f63-63b4-08db875f968d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Lin <henryl@nvidia.com>

If memory accesses by the Tegra XUSB controller are translated through
the SMMU (System MMU), the hardware may continue accessing memory even
after the SMMU translations have been disabled during the shutdown
process and this can in turn cause unpredictable crashes.
Fix this by adding a shutdown implementation that ensures the hardware
is turned off during system reboot or shutdown.

Signed-off-by: Henry Lin <henryl@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index a56cc81b9404..6ef2eac9835d 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1925,6 +1925,15 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	return err;
 }
 
+static void tegra_xusb_disable(struct tegra_xusb *tegra)
+{
+	tegra_xusb_powergate_partitions(tegra);
+	tegra_xusb_powerdomain_remove(tegra->dev, tegra);
+	tegra_xusb_phy_disable(tegra);
+	tegra_xusb_clk_disable(tegra);
+	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
+}
+
 static int tegra_xusb_remove(struct platform_device *pdev)
 {
 	struct tegra_xusb *tegra = platform_get_drvdata(pdev);
@@ -1947,18 +1956,22 @@ static int tegra_xusb_remove(struct platform_device *pdev)
 
 	pm_runtime_put(&pdev->dev);
 
-	tegra_xusb_powergate_partitions(tegra);
-
-	tegra_xusb_powerdomain_remove(&pdev->dev, tegra);
-
-	tegra_xusb_phy_disable(tegra);
-	tegra_xusb_clk_disable(tegra);
-	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
+	tegra_xusb_disable(tegra);
 	tegra_xusb_padctl_put(tegra->padctl);
 
 	return 0;
 }
 
+static void tegra_xusb_shutdown(struct platform_device *pdev)
+{
+	struct tegra_xusb *tegra = platform_get_drvdata(pdev);
+
+	pm_runtime_get_sync(&pdev->dev);
+	disable_irq(tegra->xhci_irq);
+	xhci_shutdown(tegra->hcd);
+	tegra_xusb_disable(tegra);
+}
+
 static bool xhci_hub_ports_suspended(struct xhci_hub *hub)
 {
 	struct device *dev = hub->hcd->self.controller;
@@ -2666,6 +2679,7 @@ MODULE_DEVICE_TABLE(of, tegra_xusb_of_match);
 static struct platform_driver tegra_xusb_driver = {
 	.probe = tegra_xusb_probe,
 	.remove = tegra_xusb_remove,
+	.shutdown = tegra_xusb_shutdown,
 	.driver = {
 		.name = "tegra-xusb",
 		.pm = &tegra_xusb_pm_ops,
-- 
2.25.1

