Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC8792ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbjIETYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242928AbjIETYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:24:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1B119D23;
        Tue,  5 Sep 2023 10:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9c3coxxkeMac2uEz3DeyF71BRsnGzX9xi5hguekI5MaTnRZnROvIQRppwP94w6pe6py3GbRMau5epARUh4qNipNgqGuQtsJAIk9MP63ZOA6I35fzAEaD+tMpUOLf+vJy96OZurfGDY1MM8I4zHdKrCCiHnzcUqpASvnt+Ut6TxZdNmvvyERwpIYXb9BtTdM1/828GXsaS31BbOPkL/rOFCQ6FRhMH8sowiV3JCR80pjAR2Xdo5Pj+EY9flFZiy7n5/vNTa54QzY6u7dPPGg+K43pHNPCD/Y2h2kSEAWUoobxGGyLSwGLZK6rR5TPHo04uMjzaM6aB9nFps21Iq1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZj5q0r1BtlZ17H6sNoLVvMNz0XTmg0UN7FCU1CVnVc=;
 b=GJxj+D6pA3Au1BDBdaHvxihwHw+ku9fYDurPka3Id9i6fhdJ5acHWkHmB7qbkbGRE6VSfpEYfTjQkdXEksPAgfi4y04z+kvetbM7mt4xmZ2fCxLd8noArq+alrt8HoeMdhbU9NoYlOzKJ0KJ4f+7t4IILNHaI1UoV1BvdPjXzxIyjp3drCcodSVcDAke1F6fFgBTfKokKI5WhY7nuTPqLsqyfgkfV+b4W5Qqty/k6X9dELN4mPQw4STC0qHQIca0HpQbifMGGCaOgA2hu7525xkjSjsNGtSKRXmZp6RBd/gNl9W2GowTN2E6Z9eWN+seNjBI/upCM6MCmOjHmtXDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZj5q0r1BtlZ17H6sNoLVvMNz0XTmg0UN7FCU1CVnVc=;
 b=e3Sbp+zVQTiup/M10edfCb68HllkFEsS9PAQWyf+h6it3Si9PU2/5sxpvLMOrKMHLxcpkrMUgP06scTk3NlMNJHoCM0N/4neEZ9nbnEIyt7oxlsjG3eTZ7sidBRn/Q0Ccw1W6Ki9LLIz2y8C57zRiY4wxBZRs4nYNoY5J4AKyNSwjQwovk2bKT3yMPAsVcx5BS0rH5R46z4BY+Z+EFj7VP10bNyjRo/IJ2mTblf6HVO7IvU3nV4SnNYW1DkdkOsyhutmFzLJKd5ZKmOTuamrCl+yhxvYNjyep+tW8tUceBQHRo57t9DXoCx3bAWS18U0fHtlNZKT9B78RQyqHpgD0Q==
Received: from DS7PR05CA0006.namprd05.prod.outlook.com (2603:10b6:5:3b9::11)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:37:17 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c5) by DS7PR05CA0006.outlook.office365.com
 (2603:10b6:5:3b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25 via Frontend
 Transport; Tue, 5 Sep 2023 16:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 16:37:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 09:36:43 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 09:36:43 -0700
Received: from localhost.localdomain (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 09:36:37 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/6] soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
Date:   Tue, 5 Sep 2023 18:28:23 +0530
Message-ID: <20230905125824.2947-6-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905125824.2947-1-kkartik@nvidia.com>
References: <20230905125824.2947-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: dc626c45-6239-4372-afba-08dbae2e5e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98cjkFVUGBYb7mL17d5Mbpvie6XRhnGzn0QcRjjCDYDTbyzkSlcfweCIFihwu2GwMArDZ9pNA2XrOo2lZ13xF3mHjNvev3sta8Tmpx3a6RHxGE7Pu20nJ2JIR5gRRF1qCNkxkF7jYS5cc6HM2sFJOWMFb1i4ewO3/8q9PXgg3c8HN+yEeXN9161tkV7+bdLrNRqIYBnxoK3Lvr6THLO5xBJzREMzDQ1eKx5oxun43AYOQ11mSCovoo4BpKX3Ya2AD9pDSSJ06TrS1hr66Z+ZWo7beLs8Andem0f0zolLnIghDkzQjXlx1MHfOoDSItVdIyZNmYT4stRdK95IIie93Z8wf/J26wSholRr+15jYiej4gcQ3RtLPJqs4/hCMVjwvTMPESFgs7FWSo8W01/fKj+nutjklSB6fOxr8Ii1kcuj9O8/0Ph8RTmQ/tFiyb8auFR40jcyprUHuA9QMM07ectHhMrmUc0Pwi+2LwM6FChmC8ejNilbmoUzjKpd1nTcYsxuvhGHvVB0ssmwHarQdyUt+I+HKC4gQI0t4BA0eyzoc+eyjsZyPVHOAspqbZi/fmXHCZzv7TIv6KnH+jhBVdKQ1wghpCAEWOn949ICuJ+juUtx7aF3AuQPJ8db0+vtWQOoZivh+hgaWZyTpcYp7SVVNaIZnpf4QUdnwfSMH5DWpa0IijjrWMWPYhXR89ChzIKZom/yerjB9NFdxUBvl8MMEFmfUtU8G4we/hUsi9YB4zllI9JJqsuyPNApa4Aq
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(8676002)(5660300002)(316002)(36756003)(110136005)(2906002)(70206006)(70586007)(8936002)(41300700001)(40460700003)(36860700001)(26005)(47076005)(1076003)(336012)(40480700001)(82740400003)(6666004)(426003)(921005)(7636003)(356005)(478600001)(2616005)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:37:17.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc626c45-6239-4372-afba-08dbae2e5e19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support for Tegra194 & Tegra243 SoC's. This requires
following modifications to the probe with ACPI boot is used:
 - Initialize soc data.
 - Add nvmem lookups.
 - Register soc device.
 - use devm_clk_get_optional() instead of devm_clk_get() to get
   fuse->clk, as fuse clocks are not required when using ACPI boot.

Also, drop '__init' keyword for tegra_soc_device_register() as this is also
used by tegra_fuse_probe().

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 68 ++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 64f7001823ce..f35f9651a653 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -3,11 +3,13 @@
  * Copyright (c) 2013-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/kobject.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
@@ -94,6 +96,11 @@ static const struct of_device_id tegra_fuse_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct acpi_device_id tegra_fuse_acpi_match[] = {
+	{ "NVDA200F" },
+	{ /* sentinel */ }
+};
+
 static int tegra_fuse_read(void *priv, unsigned int offset, void *value,
 			   size_t bytes)
 {
@@ -148,6 +155,37 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	struct resource *res;
 	int err;
 
+	/* Initialize the soc data and lookups if using ACPI boot. */
+	if (is_acpi_node(pdev->dev.fwnode) && !fuse->soc) {
+		u8 chip;
+
+		tegra_acpi_init_apbmisc();
+
+		chip = tegra_get_chip_id();
+		switch (chip) {
+#if defined(CONFIG_ARCH_TEGRA_194_SOC)
+		case TEGRA194:
+			fuse->soc = &tegra194_fuse_soc;
+			break;
+#endif
+#if defined(CONFIG_ARCH_TEGRA_234_SOC)
+		case TEGRA234:
+			fuse->soc = &tegra234_fuse_soc;
+			break;
+#endif
+		default:
+			return dev_err_probe(&pdev->dev, -EINVAL, "Unsupported SoC: %02x\n", chip);
+		}
+
+		fuse->soc->init(fuse);
+		tegra_fuse_print_sku_info(&tegra_sku_info);
+		tegra_soc_device_register();
+
+		err = tegra_fuse_add_lookups(fuse);
+		if (err)
+			return dev_err_probe(&pdev->dev, err, "failed to add FUSE lookups\n");
+	}
+
 	err = devm_add_action(&pdev->dev, tegra_fuse_restore, (void __force *)base);
 	if (err)
 		return err;
@@ -158,14 +196,9 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		return PTR_ERR(fuse->base);
 	fuse->phys = res->start;
 
-	fuse->clk = devm_clk_get(&pdev->dev, "fuse");
-	if (IS_ERR(fuse->clk)) {
-		if (PTR_ERR(fuse->clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get FUSE clock: %ld",
-				PTR_ERR(fuse->clk));
-
-		return PTR_ERR(fuse->clk);
-	}
+	fuse->clk = devm_clk_get_optional(&pdev->dev, "fuse");
+	if (IS_ERR(fuse->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->clk), "failed to get FUSE clock\n");
 
 	platform_set_drvdata(pdev, fuse);
 	fuse->dev = &pdev->dev;
@@ -207,12 +240,8 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	}
 
 	fuse->rst = devm_reset_control_get_optional(&pdev->dev, "fuse");
-	if (IS_ERR(fuse->rst)) {
-		err = PTR_ERR(fuse->rst);
-		dev_err(&pdev->dev, "failed to get FUSE reset: %pe\n",
-			fuse->rst);
-		return err;
-	}
+	if (IS_ERR(fuse->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->rst), "failed to get FUSE reset");
 
 	/*
 	 * FUSE clock is enabled at a boot time, hence this resume/suspend
@@ -294,6 +323,7 @@ static struct platform_driver tegra_fuse_driver = {
 	.driver = {
 		.name = "tegra-fuse",
 		.of_match_table = tegra_fuse_match,
+		.acpi_match_table = tegra_fuse_acpi_match,
 		.pm = &tegra_fuse_pm,
 		.suppress_bind_attrs = true,
 	},
@@ -315,7 +345,13 @@ u32 __init tegra_fuse_read_early(unsigned int offset)
 
 int tegra_fuse_readl(unsigned long offset, u32 *value)
 {
-	if (!fuse->read || !fuse->clk)
+	/*
+	 * Wait for fuse->clk to be initialized if device-tree boot is used.
+	 */
+	if (is_of_node(fuse->dev->fwnode) && !fuse->clk)
+		return -EPROBE_DEFER;
+
+	if (!fuse->read)
 		return -EPROBE_DEFER;
 
 	if (IS_ERR(fuse->clk))
@@ -398,7 +434,7 @@ const struct attribute_group tegra194_soc_attr_group = {
 };
 #endif
 
-struct device * __init tegra_soc_device_register(void)
+struct device *tegra_soc_device_register(void)
 {
 	struct soc_device_attribute *attr;
 	struct soc_device *dev;
-- 
2.34.1

