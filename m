Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2C757797
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGRJQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGRJP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:15:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE633186;
        Tue, 18 Jul 2023 02:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZqv1Ex/HZLrzaNoxvCO2lBhLsIrswKw4ybdhL/KkFKqn7MMyUk0yAme3GzscQ48gmBhE1SIXYhNPzSdwedTYtxWxBr/mNdfgAoHiGVhpbdrVwbl4Pv1Pa17iiTb6SQ70bvaSzzeHdVIzJVLWcmTdWYoGbhV8AGRUU1Wm/xGvPDfjlEjggiBQyvCJBDcCIaEKEn8VZe8SqwKNZETwS62w/oujGWIpy67g+hwNlhBSY1GYW3XLYQVGlTNyY0knHH8/KH3FIP/snxAZ+LILh/83s1Fx7sA01VnAEaXEs789veNAtW6Za/1OBcTbLcn64tYufpfJnreSGEJJt6M0ERn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CXc0FDAnD6YYYfn2lsYbQC10nZG1E92oOOuSrt0mT0=;
 b=NuIkJCFsHjQb2xkTelA7t29jV5Scqx719PlRwy6fDmdPlYBUA0medqaV3D4SDp+tGYF84pA7iVWVCbbeNi4FthPRrNTpoRqHmDPifl5irUenqTYNcq+2OiIxB/8VQ36wLr89TSUcl2ctJ+rHPDe1qex3wnWkSW8s9QEGjq+cGq0GmfBQg8DXRsgnSC1tTo4/A52q2oxWX5KNv4tNSwUJEHkj/QgXjCQM3ybYl9hj9vbPpZHRTQu7RTjfXB4CwTafGgBOuHQnXsldtv4GQXTChtnZRv+yr4K+7MRoKteM6887HzBJP8SDtIKFeM/yBDsR/HQd4PUD2REoCvVoEX5Zhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CXc0FDAnD6YYYfn2lsYbQC10nZG1E92oOOuSrt0mT0=;
 b=pIrXoaC9FhX/1KLqLLykRYnB88Mmm7XHcd3BKEpibyqYatXTG/8EKCBdP8X6xrI926XqJGIUT6uWHqgu6RIhU2h2twXlpkDzr1epy63vBYXdn4RdyzOiulw+mieSDGlgHHgc1P1ysPQUlO0CO5KqguV+bmRCDChe+6Sbo+PmZU+uhah8ZooOXoKrClZH4LsTyELcMU3p1pkIRLHrzFn2exZsQOz9Ly/BYJ0ijpnSF0Mo/Q3QJweaUSGTyaAC9siPuOAUf7qHGUpeAL0dqnniT7eKiafPz8jM3rxrKtE9vJ2N3zXvmqnM5Y/PH6S0YeRGcL56urD2Dj1EzRyYutx1lg==
Received: from MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 09:15:53 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::cb) by MW4PR04CA0370.outlook.office365.com
 (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 09:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Tue, 18 Jul 2023 09:15:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Jul 2023
 02:15:35 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 18 Jul 2023 02:15:33 -0700
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wayne Chang <waynec@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        WK Tsai <wtsai@nvidia.com>, Henry Lin <henryl@nvidia.com>,
        Haotien Hsu <haotienh@nvidia.com>
Subject: [PATCH v2] usb: xhci: tegra: Add shutdown callback for Tegra XUSB
Date:   Tue, 18 Jul 2023 17:14:25 +0800
Message-ID: <20230718091425.307589-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf39c10-0bf4-4438-6b4d-08db876f9624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbYTMhy3GoaS4ZBiG7HbsUV9kl+a5CCugvy7JH/Dje96cAGjINCrlr+zm8iI+EdaiYowF4Js6rMYWPhhH3V4Qsr4FIXTMOh5wcOm5tKEo30xuy/HSKM3ayyd7lBwSmhTRD8QmG4ajIVmCqby97kRObeF+gggpELXaRQlBjEtF2LGdZyE9dMABecV5sgruSbHvJmG99rZaiCCa0DlCaKG3VAmKjFWkm067Xqf86yOu3RzrkXm/lu0UKZW/6dIEqhUGjv9g0zngaQtbmIYnR8gbCxpYENTPKbZpPq2wB6e6e8GS+7ExXSTj0g9cL3QpvuCRUAeOTYGgFOQJ2icpeKmv4/Rp11grYX3ydBZ+o6ZTriOnYBITid6GF92MrrsMH/Bl+/TG/zRam9N4yx35gTODh6bLiuZhM1iRcZABIyT36uEu0jxUdRgKngjnsw84QS0x/XT89WbMQmvVVemrx8jy8kUgH5qwF//qPKJWTHhfdYZaCnT/lCF5Hped990u7c6CTYyqDsQVAkey8xjoi4aQ0Fan5hQQn9Qtq4w1LkgKs6oFB3LA3BynJiUAAn9t4OMhvbT4+p8ERD6quDL/yPQSnAiCpwnNQkQr8PkSi6Xxe8kjfCyQpBNPKYKSdsG6kO9TCNCLcpGzs6w+w9/9S4zApBbCcFeeWADw4QVgIduEWhrleg+YDJEXM0lGBxNdaSfIZSrwMkjnkdGWMfNEmBLzfAQmJNNAUmLVg5XPWa626BGrjO4oVQrjhjz7kT4OLTs
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(54906003)(7636003)(356005)(82740400003)(6666004)(7696005)(110136005)(70206006)(41300700001)(8676002)(8936002)(5660300002)(478600001)(316002)(70586007)(4326008)(336012)(36860700001)(186003)(16526019)(83380400001)(2616005)(26005)(1076003)(107886003)(426003)(47076005)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:15:53.1739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf39c10-0bf4-4438-6b4d-08db876f9624
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
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
Acked-by: Thierry Reding <treding@nvidia.com>

---
V1 -> V2: Resend for the typo in the mailing list
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

