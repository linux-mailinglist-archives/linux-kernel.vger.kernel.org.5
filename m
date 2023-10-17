Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AF67CBA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjJQFZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjJQFYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:24:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790A139;
        Mon, 16 Oct 2023 22:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbRACPjyROivn/GqwHDhEh2wP3sXSeUAFWzXvu8J5C7j2vGHsq5zM/FelacFBlcvlP+37BiyOUt7seqvN/5wmOGtSvcR5zvzfpTEaMgbi6HeafV1stksexP+2BpoLLaAvXm/mpyiVjPpZlTkCf+1E7X+g8ZEgJfU8C7GPmFloCkzN48BC9Zq2yB1PTldxaHkBMuWbDsHteozc5MqV209ggAJZ8cpY0C8XVNafCux4iFMCuhNz5kdW5eQaTX/d0Q+AemM8KwitpVXf/4qwe1T/gpZPsYwOofaA0CI7yievSKWl7MaJqE0wNeWBEXqPAraIB2rKwqbFQmn9nOL2Dmwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r74qom2e6e0rOdRTH8EGCPrMjleycxKeBaoOpktxOrs=;
 b=TJzSoNoLRjdsjl6x5rBAnZoJtBC4HDqhxbL0sR4jecSZRDOhAlGI26t6uHoBpmj0U4vUbCGHHu5eBvMILvTfDEw0u4IQWxlu/Y8vGXlXaj+RxFT+8bzC+FuDq5BEMM8AMmgkD375DnPv2HrABvlz+6hxyzwLBmCbeBJPhYhJ7XvjAWY5Zh2J9RdCV4c62htF+MqgEx+tUk61O5C9uvhT0YaRBx3EDrowS20xyPqDPsMcf40GYGwvxCBhrusCzhR3tk7YP8cBfOVgBFTcIDKnGnAtS/OEWq2ZEiKKNTiVpusey4gMrhSlbUAzhexQPoS2hc/v7ryp8A2TbSxy6/5mMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r74qom2e6e0rOdRTH8EGCPrMjleycxKeBaoOpktxOrs=;
 b=jp09dq4W5flNkmUDtNUw7xQ/Lo/+4mFG30jWkwnl5tRLBajjkOcvgjkyOrc61to5qWm/1jEpByHgmV2W6hlS4vUmu6cXVBYzQUwTApGcqCT5/R7rkQbvTEhqCXzQN+aPt1yxHuIuCpiWrT/MBeYM4KzS3wVmbrBtApstp7DDLjCO3t6+GtOV1PKB153l2BQprxiYhOaH/FllTDxkopOj1oxBCmmwVPeIWkbKAuTfdUez3AWeXSlnbiswHRAXN3Zd+GB0ceHzAfa66bzSdcVeoMhG2U8s+QJosxFRBnULJIeYQ6p4Ur9GIgbYL0YcrPiy0YXU9EozQ4xoO1LT5iDJqQ==
Received: from CY5PR22CA0104.namprd22.prod.outlook.com (2603:10b6:930:65::23)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 05:24:28 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:65:cafe::47) by CY5PR22CA0104.outlook.office365.com
 (2603:10b6:930:65::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 05:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 05:24:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:24:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:24:13 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 22:24:08 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <kkartik@nvidia.com>, <pshete@nvidia.com>, <petlozup@nvidia.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <christophe.jaillet@wanadoo.fr>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v7 7/8] soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
Date:   Tue, 17 Oct 2023 10:53:21 +0530
Message-ID: <20231017052322.2636-8-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017052322.2636-1-kkartik@nvidia.com>
References: <20231017052322.2636-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 783364cd-923b-48fa-af9b-08dbced155e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33GxlSWrmeZ0Gvrv8PnSZ61A+fibyXUoQgfdNITAxpHidQHuFAjy9zNqC9JQCNz6/Xs64i8cuZovKqj4Y2mQnoIRPlEAxKGFiZwezsnIRUhlJTSAPyVtIlBFs0+YV4yVy0McUey/oyWP4f7f7nTUj4KJo3SqfrOqTyX/Lz5mZa/VioWKqtwTOSc+OVAP8pjfCop6ATZf4YsLa149K+8ZaqUZU0JLGqdnOWZmQNNgH+PaSUznQnoZ93U81AfF9fnm3+Sq3crUvEB9h8E6I441Ox4VRZVhRsdEyqKJWmExwANsS4KjIEmkUMAkVKyy33YXgPckDKc0vtDUjfbOsLmLlyUkmuawB9rAKdnXuTqalY4boaZVIFzRCy7jiRYon/yue03fNOdK092F1FpDNL/dvfxn0hvNvMjpAwkF3748jOSCpa/DEeZXJh71TB709wtwXoYh9iSDMDQy+iD4DGt4VtFn3J0NJMxFOAoedgu+7S9wLt38hSz1OaZ/enjJ/pnmIN1VIMW1zzC3zHjC2CBx0RBeN1wmzsgvVkOPca9q+Hr0VUys9KeUqRfWwNhTe90hK57ggNb3lsH67knz4qHW3F53ybZ8WS7I83Ged00jF9cAsycJZFenH/tnqGjvN2+tIKu2ruWKqHio5/jZ3oNSryIXKfMzPcWdpOJHMkJvTdSB1Nfo4eA0PcgrBia1sLD3IJ4x647UWh1M+EaEgYti9dylcanahwOLSbZzKtlDp6tZllWQgzxzAnf/apCw7jGq1gJ6FRCJOyeByqN5II9AU7A2kFg1U4af/2jWrAnVsYKRzhismgdfg3qlmCwtmuxE
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(316002)(478600001)(70586007)(70206006)(6666004)(110136005)(36860700001)(1076003)(26005)(336012)(426003)(2616005)(8676002)(8936002)(2906002)(7416002)(41300700001)(36756003)(5660300002)(7636003)(86362001)(921005)(356005)(47076005)(83380400001)(82740400003)(40460700003)(40480700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:24:28.6238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 783364cd-923b-48fa-af9b-08dbced155e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
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
v5 -> v7:
	* Drop __maybe_unused and ACPI_PTR() for tegra_fuse_acpi_match.
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
 drivers/soc/tegra/fuse/fuse-tegra.c | 52 +++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 7a93c6512f7b..1c758f121f91 100644
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
@@ -152,7 +154,38 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		return PTR_ERR(fuse->base);
 	fuse->phys = res->start;
 
-	fuse->clk = devm_clk_get(&pdev->dev, "fuse");
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
+	fuse->clk = devm_clk_get_optional(&pdev->dev, "fuse");
 	if (IS_ERR(fuse->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->clk), "failed to get FUSE clock\n");
 
@@ -275,10 +308,17 @@ static const struct dev_pm_ops tegra_fuse_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(tegra_fuse_suspend, tegra_fuse_resume)
 };
 
+static const struct acpi_device_id tegra_fuse_acpi_match[] = {
+	{ "NVDA200F" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, tegra_fuse_acpi_match);
+
 static struct platform_driver tegra_fuse_driver = {
 	.driver = {
 		.name = "tegra-fuse",
 		.of_match_table = tegra_fuse_match,
+		.acpi_match_table = tegra_fuse_acpi_match,
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

