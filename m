Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA879740E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbjIGPdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343835AbjIGPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:31:25 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B0B1BF3;
        Thu,  7 Sep 2023 08:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha+kg29Yk3QrtACsPJBjDJvkZDV1pXpYTybt+Hjbs5JRCQo/yl7SrEEQyQKqYB0y8XvGo9WUzcrPnsT4jzLPmFOezuG7RUM6t5KlZ4mt9Qi8JsA7tMeG42TXZsxR9sSckyAQYWCPZ5kl/4+A68rFbbt3CUtvzfXiDMqbGJ8lbajuc8PsixjjekJ/8Zc9B0J1xpHwp3/TJBsfwh/wk4rjThMH98FXP+LHjUPncxSwuvz2o5jwt4fd6Ut1o0JMcAKLJOmk9ZxyDocnNac0DJthkmCHbXsd7rQ92c7kz25T/VaIHqLQP3NqDQgZxSzi/pHowg2V6h8Yycj13CJtA6V86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJb3yGjKQBiwOKEVVqTy+EZq4dyhLV5v6aiamhf/zXk=;
 b=TESk5gTs+8+KbeK9kg9kTv79Ivg9xp9RnvYMKho06p1UjjViyqpl2bVCCKtWjX9HxdP937W02ikrSz1QaUNARiAwrBZNtnbEVRz65qXwt09tH2qgIbrHQAMG/ajhsNB5NiXgSVZxTx24o60KOxXSCYY0VtWTosQjwQA3v0zmbMdk1UYeauxWL/d0c6os2s6Ddae5gKEvYFo2qMiN614v2HQpTfMIXkofzxnS1xnohT7mpJXdJBtBuJLSz1O3rPgP+eP2JbDH/B4RPGzgjeya9LbwpAytbKRktPsAqJN6EpdyL9gYxllT1Apxo8XN/xrSPWxD5VtYwLZJJnfglwsHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJb3yGjKQBiwOKEVVqTy+EZq4dyhLV5v6aiamhf/zXk=;
 b=NOG/bKvkuN2uXnqKNjrQAj4r/Zh7UJy6wyAU3R1tDy/iwuKoJMarVsVhBXRBHRltt6euY3Fz/3kDUc1xt5Py8mC/Oj/JCgQXbwHKO1HS9Cl1o5Y3GP8RTddQbViOCE0cAZID/0KOVo/ZjR/980oRR1tX/H96cEQqOVP8INu+dD8hmv6Sf01YYNxdxivjQWjSTvEgcNmrP+P1tLD/1WTcIHVnQbxBifLQhLu7Pht9yJ78lPRV2zT/cHxD58l9LphhHFkxzcA2yu8HzIH+tV0hUSkGYKPoa6j967316U1BEg/xEtYulDuCc9ytcMkx/rNEmb5tFe5JMN3jm3/Tb5V+NQ==
Received: from MW4PR04CA0066.namprd04.prod.outlook.com (2603:10b6:303:6b::11)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 07:11:46 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::4f) by MW4PR04CA0066.outlook.office365.com
 (2603:10b6:303:6b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Thu, 7 Sep 2023 07:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.6 via Frontend Transport; Thu, 7 Sep 2023 07:11:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 00:11:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 00:11:28 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 00:11:24 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/6] soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
Date:   Thu, 7 Sep 2023 12:40:51 +0530
Message-ID: <20230907071052.3906-6-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907071052.3906-1-kkartik@nvidia.com>
References: <20230907071052.3906-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f74103-5462-4c4f-78fe-08dbaf71b294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbVSmXue0yG7CXq8wkfTc2nNHwprDcH3cWyVTiOZmz836Fm9xEbQp+hxPKepHulICpKjBYL5JW0COHh+n27nBPmBx5EGdzSIdhNIcLgScM/7fX2NOl1kMywigN8DuNSTUhKEob6lPsmCTNBpfjwOafwOkCVBnjAPh4T83mlSf9eBccekimLtnc4yTmEpMNnjEuz963Iu9ceIDeK9/HIjDLzJHRqM8cvH9pkCz7t/+4riSfQJRLHmjm5sBMN7opWxiEx3fw1OqrZmAFqJxIvuB/tpZcws9iaJSr/D51Moh9MBuqDc+ex9g1G4gR/SAAltNYL2+o4lXwCjkC8cdSlHhByW3ob5QJa6uaQXTOTC+Nz8rqGSMsnIkQHaHsLTIL5CqxYahMqz78uTVx7UiZYxRZ6vEkqs+M5tU6uhGdJ9FKPNg8lGnTyhHDvdLiR2rI1vR6KCZCIdjKhihrpaLxdura3HBmdkoDJUZQxUwzbevMJ6NLv8jTZiiQ4uRtAxCxSHgwouLSQHFZtMi0kYtHDxXYwgL+C3nGfoYD+DGJ0V9VwP/Kjv0Oln66e4mFoSPdB3tisWrWmj41WDwnRsn/8EqSFxeLV1HMdN5p6hDEcsz/+vmQjHN2jVolFKdRP4GmasnhNmFmvie/7vRg3Pi5QEcUz5j8s18oc3qROk0ChmM5TsJrOi05aEK/ZOKaPPYm9OZUbB+58gg4kNBq5sMpUaxXGqdO9WYbc3BLya930snz0ImSzlbYn0fRb6jTBaCqtp
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(8676002)(8936002)(83380400001)(47076005)(426003)(36860700001)(478600001)(70586007)(70206006)(110136005)(336012)(26005)(2616005)(6666004)(41300700001)(2906002)(40460700003)(921005)(356005)(316002)(5660300002)(7636003)(82740400003)(40480700001)(86362001)(1076003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:11:46.3734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f74103-5462-4c4f-78fe-08dbaf71b294
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support for Tegra194 & Tegra243 SoC's. This requires
following modifications to the probe when ACPI boot is used:
 - Initialize soc data.
 - Add nvmem lookups.
 - Register soc device.
 - use devm_clk_get_optional() instead of devm_clk_get() to get
   fuse->clk, as fuse clocks are not required when using ACPI boot.

Also, drop '__init' keyword for tegra_soc_device_register() as this is also
used by tegra_fuse_probe() and use dev_err_probe() wherever applicable.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v2 -> v3:
	* Updated commit message to specify changes related to inclusion
	  of dev_err_probe().

v1 -> v2:
	* Updated ACPI ID table 'tegra_fuse_acpi_match'.
	* Removed ',' after "{ /* sentinel */ }" in
	  'tegra_fuse_acpi_match'.
	* Using same probe for ACPI and device-tree boot.
	* Added code for required initialization when ACPI boot is used.
	* Make clocks optional for ACPI.
	* Use dev_err_probe() wherever applicable.
	* Check if clock has been initialized only when device-tree
	  boot is used.
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

