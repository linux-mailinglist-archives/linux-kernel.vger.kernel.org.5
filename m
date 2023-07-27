Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C504E76496D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjG0Hyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjG0Hy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:54:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01943584;
        Thu, 27 Jul 2023 00:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/tp78msW5eVmXVoEd/4OO+wOIdsoDYevqDNnIxgC+Jxn6dNoC9dz4dtPMwxXa7dN+DnNOm17MNLdKvAZKsCpgJJSmGtPXNBnaw/qftPLnENw0WLJyt5onWM+vkzsAZysEEbPwYq1z/6rKh5NlOFTHhdBiyMdg6y6KlekWumLMCw+cwDx3DFL9Rg/pFsLdt94KIwzIBr3KkevPgS79emRe7CJYpDnfF01oF1rjvHqUO7Zur9g8t2Xv/7AijyFrIn6KziKeRpLCsVeNphcPhk3E0HHHg9CiiMlZPJfbshHUKwoRsX5te3CS45SSVUc3DMq9hW3TFvc8bB0/LTMvU8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivlxkMbSRBxIQNAYt0u9SQO0eIBCBa3hj0duiL1k7rE=;
 b=Qc6DqmyDTSnK8fnbwy6bhDSPw9S1chwiB71REz9uAGxOYkytQMkXs+KXjvCvpnTHCuR3uX+fVJhMmGUDav9iPrGbzM7RgLlOD6Q4W8k8hzcLVAnSAEOpzV8q061ZlmS5fzxk89VNeVIacjhU6jPWiCMyyT+DQP5PW8j4J03tikC8sSmdTBEJb6e4SWCZcToOt3J5mduN7dwKveMksYwmi0wxX9V7Ah9ulw7jAg6t39jH2r1nGZJpVcv/yZnYfjh39AjaR2+4AQP2osmz3HLhjaBrfBlcA6bGnEEghEKTxfnjlfWK4nHEGqRMsxgD9SbGaDIhz6BwHa5jZ3ybPBkByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivlxkMbSRBxIQNAYt0u9SQO0eIBCBa3hj0duiL1k7rE=;
 b=sGP/VdfKCkQKHnvcFMp9DSZPtDXPiyuXBWqmkXgs/NdDB2zHaAPp1nDG7VyPvRS5Gqbm1tIqSn8Eav5wuO2lUDqd2mdi2Hc2etwSoF9yzeCIJKq5y42uFaj8s7sxTqSxjVB/4uV9D57BBBTU4sPi21PYC7LZoegeshyaQ0chUiOjZrIRfGlYBuQyG/8ek4cy7BNOJOz9G7hvpKHfGT4xJlKSyHXdHiJZwtOjEVtO96epAsJFnc/ciMIV0f64iBgeKWXc9Ci1UMs+nEWseX8aTDi7yyRNWxq57inKWhoiMkCZh65qGQscozH82ysolS1X5tiimFTr0wCfXfr+k79FDQ==
Received: from BN0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:408:e4::21)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:49:56 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::21) by BN0PR02CA0016.outlook.office365.com
 (2603:10b6:408:e4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:49:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 00:49:40 -0700
Received: from 0e64808-lcelt.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 00:49:38 -0700
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wayne Chang <waynec@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        WK Tsai <wtsai@nvidia.com>, Haotien Hsu <haotienh@nvidia.com>
Subject: [PATCH v3] usb: xhci: tegra: Add shutdown callback for Tegra XUSB
Date:   Thu, 27 Jul 2023 15:49:27 +0800
Message-ID: <20230727074927.2428611-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: cea44179-c367-4e32-3c6b-08db8e761152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ma9Bxo5Jjw2BK9CLq04EyWkA7QfCGNkTiGKg1bvqDw8Qubn13d7YOQ4zKcvASHfwku/RebhJM/RXHt5SvhUYXJzXdou0io440zy8r3KzvHPMzcK0Rg173R5WJ5/8zp4Y/zd3scs78aBLj4DbtHPX14iyQFXm2dXTCq1dGwDmD7qYAoWwytwA5+CvbdY9BW4G6hor1nGumHoUgrC3e7bMzO3GtM1LnkkreVlTGJX9SSuk+TI48qi1L6KukL98Q3eDUZ7s2YFfZZBIBgMYXAF4r80dqtseXlfto6Fnql3/RxZd0m4zQ4uw555qaYvBAfsPTNerTluqI8/w5E7SZW6vXBI7RcXgOdL8T4RrUks+MqKwSwD1dUuvSfm4FHca3DFCylzG0pPVgO2miwqXbMUQiVBDjJMsshHRYqnBP3qiROvtGZpS9eP0CkQ8LAdOZA421qwnmmbeSG4PE4CTU6giFQxSZKnqz60gVkyBGVS3ZMnJw2h1h3WmmGCf7wtEGKstjuyDEkH+hyOaA2BMG/jjsP+52+coIf628p9ttqd4KLZBNIh8s425udvvoC2pRqnH82SYyQDIPkIuLFfVhofwKcqsxfvWhsYoZoB0hSZUJae7VOWkP2TGLa0t6BNpYnDvt+wdrck6BA5oiJpNtrmq4QlFnu9/1LiJNIsKldCH6rwzubYg2kBx4leHp+4OkuwLG1EWSXk1Ep6ptni5xy3k9FlpSxT0AYKS8jdy52ZS/hI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(316002)(8676002)(8936002)(5660300002)(40460700003)(41300700001)(36756003)(40480700001)(86362001)(426003)(7696005)(6666004)(110136005)(54906003)(82740400003)(478600001)(7636003)(356005)(26005)(1076003)(107886003)(16526019)(336012)(186003)(2616005)(83380400001)(70206006)(70586007)(36860700001)(47076005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:49:54.9069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea44179-c367-4e32-3c6b-08db8e761152
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
V2 -> V3: Rebase to v6.5-rc3
---
 drivers/usb/host/xhci-tegra.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 6ca8a37e53e1..0e5d2d3180bd 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1912,6 +1912,15 @@ static int tegra_xusb_probe(struct platform_device *pdev)
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
 static void tegra_xusb_remove(struct platform_device *pdev)
 {
 	struct tegra_xusb *tegra = platform_get_drvdata(pdev);
@@ -1934,14 +1943,18 @@ static void tegra_xusb_remove(struct platform_device *pdev)
 
 	pm_runtime_put(&pdev->dev);
 
-	tegra_xusb_powergate_partitions(tegra);
+	tegra_xusb_disable(tegra);
+	tegra_xusb_padctl_put(tegra->padctl);
+}
 
-	tegra_xusb_powerdomain_remove(&pdev->dev, tegra);
+static void tegra_xusb_shutdown(struct platform_device *pdev)
+{
+	struct tegra_xusb *tegra = platform_get_drvdata(pdev);
 
-	tegra_xusb_phy_disable(tegra);
-	tegra_xusb_clk_disable(tegra);
-	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
-	tegra_xusb_padctl_put(tegra->padctl);
+	pm_runtime_get_sync(&pdev->dev);
+	disable_irq(tegra->xhci_irq);
+	xhci_shutdown(tegra->hcd);
+	tegra_xusb_disable(tegra);
 }
 
 static bool xhci_hub_ports_suspended(struct xhci_hub *hub)
@@ -2652,6 +2665,7 @@ MODULE_DEVICE_TABLE(of, tegra_xusb_of_match);
 static struct platform_driver tegra_xusb_driver = {
 	.probe = tegra_xusb_probe,
 	.remove_new = tegra_xusb_remove,
+	.shutdown = tegra_xusb_shutdown,
 	.driver = {
 		.name = "tegra-xusb",
 		.pm = &tegra_xusb_pm_ops,
-- 
2.25.1

