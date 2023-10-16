Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5637C9EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjJPFfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjJPFfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:35:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55D136;
        Sun, 15 Oct 2023 22:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHKpMQ+wEqxL95cdClz8Nr+Tm+WbGuHVCs+PrOqshtIOfrDTk/fU5UTFdbS8yKyHB4s4V4BmxXArSWS+iZAHPohyga8MHWtDOsKmX65g+kIaQmmEZiy0QkvHEZmS7cEbZXERrEy6h2VsSarkJlOdUXW5oXUuExAOVgtza+NmH+AAUN2z0dUYyLaFXK7zuQ6oeeey2DAcLxwFLJ0KS+kB/ln+8n2c7Ot2dO5apY1EWC0E7i45D8XQi6qPGgvGmvygFaLaVCE7L1efNhpo0jg5aP0Jr9f3dSLapRXKmDIqJ0ENkANBTzT6rCFw+bsaqgOxtINRcNUBzZMk6ONqEIhSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXqsHU6ogXlp1x2pbNwnf9ALqPnJ0NoVRvhf8LgRRWM=;
 b=acX7rU5dDZADS+KlxpqTwbdcdLQcfGxcYaZS/wpppkI2NliRFaD4lli+4PJZPGh4wLS0WYxwPnUl73q3VtC3xxPoVSqv7RFomB7if1YUh1jB5iSPl6kHH1a3sMHPLin3qaca5yZMRswSsSQOGPTc11B4dbOZ2cvnuM5C+bnUwdeO9AEIEkRLIrLS/Q9JFrt17TTotc31NAC9ky8DaUOzKileE/pttkWUD1p/vgr7SIoYlJhUr9v+POlNN0haRjP4Tups4M6KBjkWVi9hc8TIAFo3CN02UbXcadHTXVIrh25YaCSUGhrvbCG6strbQFytwzelPYnPsHMXMlIix0ACPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXqsHU6ogXlp1x2pbNwnf9ALqPnJ0NoVRvhf8LgRRWM=;
 b=RrkYXmov4OdL9r0k79dWXpEokdT2Tit2T9vvQMWV+D5qqTHB0GN1SZSvGAUuCVc9ogb+tKzDlttxSVZxoCX3QyqLwCO5GbL9nHhfJo/2YfjkEZUwZ5Wp9/5OfhUzOW8UCrYg6ngUhxLYUwd7Dq+lgmhpH2trbvn7txfPMF6dnQ3ki0OhLapzyhHV0HKAwoZIKCUI/tgSLGeEJl0vJMK+v50Wt5c1COuHxJdwSKReLeVlsx1Bfain5gOEyHkY54QHcfQMbtj0o4VcnUyFYemchLzJsJszi+gBIkBl8kENKHbbA5Xq89zR8wUVAg8dCJqGdyFx51OdnVmCpIm8S0+0zw==
Received: from SA9PR10CA0009.namprd10.prod.outlook.com (2603:10b6:806:a7::14)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Mon, 16 Oct
 2023 05:35:06 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::f) by SA9PR10CA0009.outlook.office365.com
 (2603:10b6:806:a7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 05:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:35:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 22:35:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 15 Oct 2023 22:35:00 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 15 Oct 2023 22:34:55 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <kkartik@nvidia.com>, <pshete@nvidia.com>, <petlozup@nvidia.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v5 7/8] soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
Date:   Mon, 16 Oct 2023 11:04:10 +0530
Message-ID: <20231016053411.3380-8-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016053411.3380-1-kkartik@nvidia.com>
References: <20231016053411.3380-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: a019253a-ccd6-4e34-fe3c-08dbce09a72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mz/FNMb5wwnMmYSedSFgsJbsEN54AQrXsSv2TSoDrcFRYMJs26KUwKE/uZTVmUF1+Y/bGpiQUyyCQEIsVAdZCToPKr5pPATVBd4NOPpJuouyUKcjboDcK3JYSB/6vLxeKYLQ8iHm/m1zK4WkudmXFU5VaBi9JIqO6p9JLqOnrF+ouEfReOP/nn2zCk5tfkgIlhKnG1uHAae4mgJnLncXUEmUS7gRHa3y5d3kZDtiCg8uex653QOStXWAZuyikdNxZCESXpXAE+lvtruU6WHT5Ksa/54ebFNwevvtFCQ8PJZVympL+yLuC9Sf2xuov1qUsv4U59zBQ6b/MG9ib/MmrksWW83xb955bVb5CinyuGzT9I0xfpX+l/Wh94NfA0pjWB/0vkeWU2VwzzHm4S2FCjHQwm9KAEvupyybtXH7V99lgQBPEwvRJV3AE/P3rw1Z3bDF8w58a0iLpIU/ZhoSzIT4esHy9rZyFK+7pIcmNazWSvxyl/O6yGKukPBU2vXJ/qK/+vzCqVN3sox8tluXUVSwQeWe96+jUZb7boHhQFm3hUnqpRbPSSzH/8zJcOjKobaPZy3VyKRnF5x9WCbYi/4K+0B9oZASHALtWfd+JKtAAM4ZkGPDC79c0fU5BzlFkaH57SMYP2vSKKe6gbotmmq5H2m9YO8a0qyr+jvGhgZ5GsPbZNIy2pQVnSyIveA+zVRSFoAdts4F/7MGXBNA0vf8GNYSzS0L7q+O9s8QpVl7VXoQrMhZLQY1Ha2flwBsiFfyF7XYUUXcH1ohHbJXjGbp/avASFforH1IcVZT4K66/cKWqRWeXbQ1mYs1K1tL
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(40470700004)(46966006)(36840700001)(6666004)(426003)(336012)(83380400001)(2616005)(40480700001)(82740400003)(26005)(40460700003)(921005)(1076003)(7636003)(356005)(316002)(70586007)(70206006)(110136005)(36860700001)(7416002)(41300700001)(2906002)(36756003)(8936002)(86362001)(8676002)(5660300002)(47076005)(478600001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:35:05.6512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a019253a-ccd6-4e34-fe3c-08dbce09a72b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
v4 -> v5:
	* Fix build warnings seen with tegra_fuse_acpi_match when
	  CONFIG_ACPI is disabled.
v3 -> v4:
	* Use dev_fwnode() to dereference the fwnode.
	* Add MODULE_DEVICE_TABLE for tegra_fuse_acpi_match.
	* Moved tegra_fuse_acpi_match above tegra_fuse_driver i.e.,
	  close to the user of tegra_fuse_acpi_match.
	* Moved the improvements made to fuse clk/rst get error handling
	  to separate patch.
	* Moved ACPI related initialization after fuse->base is
	  initialized in tegra_fuse_probe(), as this triggers a warning
	  in tegra_fuse_read_early() which is called from
	  fuse->soc->init().
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
 drivers/soc/tegra/fuse/fuse-tegra.c | 50 +++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 9bab758a60f2..daf39f0e6d93 100644
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
@@ -152,6 +154,37 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		return PTR_ERR(fuse->base);
 	fuse->phys = res->start;
 
+	/* Initialize the soc data and lookups if using ACPI boot. */
+	if (is_acpi_node(dev_fwnode(&pdev->dev)) && !fuse->soc) {
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
 	fuse->clk = devm_clk_get(&pdev->dev, "fuse");
 	if (IS_ERR(fuse->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->clk), "failed to get FUSE clock\n");
@@ -275,10 +308,17 @@ static const struct dev_pm_ops tegra_fuse_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(tegra_fuse_suspend, tegra_fuse_resume)
 };
 
+static const struct acpi_device_id __maybe_unused tegra_fuse_acpi_match[] = {
+	{ "NVDA200F" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, tegra_fuse_acpi_match);
+
 static struct platform_driver tegra_fuse_driver = {
 	.driver = {
 		.name = "tegra-fuse",
 		.of_match_table = tegra_fuse_match,
+		.acpi_match_table = ACPI_PTR(tegra_fuse_acpi_match),
 		.pm = &tegra_fuse_pm,
 		.suppress_bind_attrs = true,
 	},
@@ -300,7 +340,13 @@ u32 __init tegra_fuse_read_early(unsigned int offset)
 
 int tegra_fuse_readl(unsigned long offset, u32 *value)
 {
-	if (!fuse->read || !fuse->clk)
+	/*
+	 * Wait for fuse->clk to be initialized if device-tree boot is used.
+	 */
+	if (is_of_node(dev_fwnode(fuse->dev)) && !fuse->clk)
+		return -EPROBE_DEFER;
+
+	if (!fuse->read)
 		return -EPROBE_DEFER;
 
 	if (IS_ERR(fuse->clk))
@@ -383,7 +429,7 @@ const struct attribute_group tegra194_soc_attr_group = {
 };
 #endif
 
-struct device * __init tegra_soc_device_register(void)
+struct device *tegra_soc_device_register(void)
 {
 	struct soc_device_attribute *attr;
 	struct soc_device *dev;
-- 
2.34.1

