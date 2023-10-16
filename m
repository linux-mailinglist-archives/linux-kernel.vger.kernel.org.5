Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29A47CA516
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjJPKQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjJPKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:16:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75A7D49;
        Mon, 16 Oct 2023 03:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/2MZ6FdFOw7AM5lE2jSam/dD/SDRm3UWLSgK9cSY59Hw6g+SAh5DRSg+IdMPPAPabJkXTLr0hlv6PtyIogH9I5nrHK8MqoVNnk9maN7L/vaRwvzIM1LTsSODsO7YCmHbSprhOobOJOy1Ha984y0iWXRCnAMjAOxkeAbpWJH6L0ngVwNscwLYFbn9NH7COcf92Ho6+6wl7GSSLtPrwRqvCNi9RqkMW4gc33dR/IYyJH1IzlzcZ2u7XbJ96F2peQF3Q1vlqnmkq/JxvihIxb6zVpykDOKw8uqgxH14+X4OUrLwxBKMMe/f/DN/7+ZGBR/5ordIUORXwTtMzS/pNUfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnCLkKiG3WoNwvXMTh+9d4u1aDhdbcmtKjbLuTY7D9k=;
 b=OZ5flYqwDa/8sSbjkh5fOnGr4CnUrVFI6jSx2Njt8Vj+q4ytFXcQTzcVfFAK9/wnFDqR9Yey9h4ktSdM9I5Rf91fbqxktd2qQ92QRh0Ac8CkRBt/jhmBoo+SJ6EB5543lclH4kmpCxphUAGD56ENAx+69E0eYArMq6tkfkTrM8bh4pMvLTfedxVO6PQiewOq9jJ9XLG7oXKBLfEVso9d5CghW1JzKmlfHMFnku0O9n+/rMEt82X2C97KCYZ6wiC2LFbcuRp2ozo2w5xoTFKDGps1DG6isDgITmlCjS01745ufVvQniqk3uVOctrLPUFdrXjWCtSZ9Zh48WNkZNyy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnCLkKiG3WoNwvXMTh+9d4u1aDhdbcmtKjbLuTY7D9k=;
 b=tHd0OC60KHVezR1q/NyJVSMSvNuDQpHZ08ykri3DrJ6UOuQz785KPImKGV8OLyZXp8CUSFmC5omrbk16etiEpljljE0xsH+MBfFtsYWZ6h6mK8mbj6MEkuQLDPvHkvOIGVEIyrb/Wo2XDqHPzL5oq/2tex1GEgAzB+Tg1Ikt8v1U9Bl8x4vKLeW7wj4rl8ufky7mamgOfSP8ffyViNm4jlbnTUPBJIjJ+nNwaTFIn54xEjWIN9ulTP18beImHjsRKnMb2MCmkLBLOGy8Sm7djIRwTdrffnCTJ6hkHi3mUR8EK0r+uGIrKXG9luYRx1y9iU/9FATHr806vGTmX2ehDw==
Received: from SA9PR10CA0014.namprd10.prod.outlook.com (2603:10b6:806:a7::19)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 10:15:47 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::18) by SA9PR10CA0014.outlook.office365.com
 (2603:10b6:806:a7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:15:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:30 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:29 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 03:15:24 -0700
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
Subject: [PATCH v6 7/8] soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
Date:   Mon, 16 Oct 2023 15:44:35 +0530
Message-ID: <20231016101436.7146-8-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016101436.7146-1-kkartik@nvidia.com>
References: <20231016101436.7146-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MW3PR12MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c74d648-26f5-4277-33eb-08dbce30dda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAJ48sWstUPNxt8Uo7a0vtRBzyzVJY4eYZ7ly+Qnndmu46Rh1A3SLW7Avsut8dE5oBQGKDBmq6wgnSwjDnOVQVLjf0ahkFdAKWws1Bt6zHlGsBnBCdcbKXaUfyQgo50S8w+bm1PILl0dkpzrXJhFw8RD5hiHIq4Qu9UAT1/DA9CGn8aJPHG5htrKtjgXEkICeOcy3VjsbDUcqbLPQfwsOA3qUZQHuH44pk69iXwUt+Ill/mA5pUdY39fz3xGruquG3o5psgVcLUwLj2IeptmX26nZ7D4Jl3H05+pypljLumpbUpW8lazA1FGLtySMMVPkN0RjoVVFaz4utecA0Uiqmp5QSZBhdXWEV/pdsCPSCPgLfsDek8ES9I47jpuZjDuu7OzZXC5D5d+V3IuBGMjIF2PO1EvCoYxxFpZTGbhg40BMdAz2n50IgSub6v2Vls6pVP8z1w2Y1Ar4ZgDsu7hZWHZLVOziu7fT3TIqutc3tt7VBNjD6o4PbjTNUe1z8MMqOAOYkRUKeTsaQvFrQMdLTuRoPhw3XkP09kkD7h7UxxTXQsrZxuIhLV/u1cslu1J8JiBYCGckUOFuGOFKTTben4xQ5yZNTvlOwmNOPiRcug2kkqh5IOCUZ4R9b2Ma5aH44/FeaELktKN3egs0NlGvFCPmu0iA9SDwoCTSAF3HixP38kBM9X9a+EFDqahljmXjaGi7OZUEvfpw98edH5EA5KwUX/0MBByQ69Q4mQtyJwfcEIlUheCDODgTtyZDqd1KDug69GGSOAz9Xh9x9wsks3g6B9rsI/3FrVDjdzVG1Nts2VrO5aOMXkYGova6jbb
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(110136005)(478600001)(6666004)(70206006)(70586007)(26005)(1076003)(2616005)(426003)(316002)(86362001)(336012)(8676002)(8936002)(7416002)(2906002)(5660300002)(41300700001)(36756003)(7636003)(921005)(47076005)(356005)(36860700001)(83380400001)(82740400003)(40460700003)(40480700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:15:47.3994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c74d648-26f5-4277-33eb-08dbce30dda5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
 drivers/soc/tegra/fuse/fuse-tegra.c | 52 +++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 7a93c6512f7b..39a59545c93f 100644
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

