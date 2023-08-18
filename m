Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FA4780889
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359200AbjHRJcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359298AbjHRJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:31:34 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FCF3C2A;
        Fri, 18 Aug 2023 02:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxZ4BsEGKrU1g7mBtdhwYfd/9FktZ7psEUMFSNxHSTrQIfBf/Ehpav1xKERyXY+FWU0weDwAogUHzZy/CjDHcrBLrF+zj2g6aWc2jOYx0bQ7jZ6XTQHG+q3rWpBsNa2uQCRuAkxcAt4uwqU1k8UoKQ1Awgx3L+D2WFIJOQbJOz31x0gTqOdxdi1K0OBr14np4AU70OybPrlXJODtFnTYgE9Y7AJWp/yNFDZ5zQkxDZUsfWFRd/HKYOfNeL0/QGs2XBvw6o+Ua++QWiqsHCpgRgaxqfJGaLC/lnmgmok1iVCs1IaHy1apdtCBO0pec8rwDBnvqIz8ckQajxcpIDF4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo7Nxb5b//JMGU4qBijr5r+jTdCh/lqT596saPUMp88=;
 b=TQaxucxtp2QEYtYEWKDZoZ16XpysDMa1NchB0TXqIX+DUxKdHDYNtoeznm0HEHxCUiHMiiDbc4uRJWPta7SdlKR0jcCyW81Xu9pqin9TfiwE7oQC04vhwNDPQ5Pg9ht6jr1qW8p2cWEKPFnN0DvYD/IkaAYSGvK0/+n1He+udGRIF0B8uRcb4a3gOkVKTP13kYFHZ+iouYtxARFszbB215Ll/6lFOKQjvZmmX6PldS+BoBSH48XzV4/olqCjpxqZ0DAHFhk1xInITptjWTq3BCo5Rjzj783RhzPhL3gLFDgNwq59/sZulGAc1B42HppqBmj0q51MTmXVW52/7Bg8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo7Nxb5b//JMGU4qBijr5r+jTdCh/lqT596saPUMp88=;
 b=MqMkPOY/YpFp4ujBZjETv/CN22ixAbWdLur6DU9vafgluH9kRfzOGEx4RnicRG0I+Qlohi8sFiTh7WwS487QlKndoOgroUcThWFpK3Y1g86vZGVtpNE3pn463CMw/+n8GyoWcVDyU2dDTPjqxAYsIJU5am3zpUNN5+fYOngqpOz6/7mOGQqrbXVS7U8Pp///c8S4KiovG5iVueBZdXgl5t7V7bUkqewI7Cyws2xhhBBYYdevmK5glzQX1IuqnLVAFYcfYBufq+uDDToueBvCi3FZMcMCin+NrlsbvyG5DJmcFHaXwC84Hb6hkpoem5r899nOp8DigEWn9HqimvQWhw==
Received: from CYXPR03CA0050.namprd03.prod.outlook.com (2603:10b6:930:d1::15)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 09:31:17 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::4a) by CYXPR03CA0050.outlook.office365.com
 (2603:10b6:930:d1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 09:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 09:31:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 02:31:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 02:31:06 -0700
Received: from localhost.localdomain (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 02:31:02 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.co>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
Date:   Fri, 18 Aug 2023 15:00:27 +0530
Message-ID: <20230818093028.7807-6-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818093028.7807-1-kkartik@nvidia.com>
References: <20230818093028.7807-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|BY5PR12MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: a666e4fe-ca35-442a-3f7d-08db9fcddf7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDHdIz7JFvTO9sWggXRrCU5trlkHcTpsw8cptJTNkzg8BkpaHE1dfZUDWX6xg2DZ20ZZTYSMzX7KS/zw99X0/1etNJX+ih2A6Bu5WEjr+z5IIaRujxPjOVNmGW1bLuFbrLS2GCVKauXCpQ9gXiuURby8PQPnnegup98FnVTjsulU4v4Us2u0O8zXEaSerYKNE1VWSnjLRvp7Rgicl73H6sn0VUheRNnSNv/PQzG0NQglCLjViEBmSaqoZo2EC4ZHIVyqJrHl6msH0p9s1WMqxeKWv+YkpoGgnOJUUS7uEuzBke9k1WPVMOa2fWU2aJjUAYBt5ia+s3rdC9ts7o3AGApZm5g08CdyqK7ka91socfoRKc3uGheTbo804yD3tO+30zuifxr88bcrXatAe6gkullWWjrvzrqxMHMc1aOOCKN89NsKO+GIG8XvPIp6ThqM8oigY9AYp2ZAvVU0+mstHa+4PyY+iwVUyfQJlP5LPRe2Yo3mbxFYzboTSK4cyclcDd5uqSsLui6TFYcNY5lvz//SgBb934gSgcTBuIOaLAtcxa+HQHbUjMqeQlChx0j+kcE+xe8igqnCAE+njZ7uq4P9Y/Tpj+1PkQxT+wvhbPEY3UfpnJDNzq9u6pKycMexhMQ291UGBDYkqgmr3U3L18cdhKK7utF9DrAn9/sV7WJ++fI7bwqr7WgD/iD2S3W48thaBaV8yqf2/MNcvBMK0OLIrAiOHVoHsCl2GnWSHt85smfLtcajGMJTX3foIseidgPlrKpxwQSj40wtZrRqQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(40460700003)(86362001)(336012)(426003)(1076003)(26005)(40480700001)(83380400001)(36756003)(36860700001)(47076005)(7636003)(921005)(82740400003)(356005)(2616005)(2906002)(316002)(41300700001)(70206006)(70586007)(110136005)(5660300002)(7416002)(8676002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:31:16.8824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a666e4fe-ca35-442a-3f7d-08db9fcddf7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tegra_fuse_acpi_probe() to initialize Tegra fuse while using ACPI.
Also, drop '__init' keyword for tegra_soc_device_register() as this is also
used by tegra_fuse_acpi_probe().

Note that as ACPI subsystem initialize at subsys init, function
tegra_fuse_acpi_probe() also contains the necessary initialization
that we are currently doing for device-tree boot as a part of
early init.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 67 ++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 70e8eeddcbd9..9c5596d968a2 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2013-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/kobject.h>
@@ -94,6 +95,13 @@ static const struct of_device_id tegra_fuse_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct acpi_device_id tegra_fuse_acpi_match[] = {
+	{
+		.id = "NVDA200F",
+	},
+	{ /* sentinel */ },
+};
+
 static int tegra_fuse_read(void *priv, unsigned int offset, void *value,
 			   size_t bytes)
 {
@@ -176,12 +184,65 @@ static void tegra_fuse_pr_sku_info(struct tegra_sku_info *tegra_sku_info)
 		tegra_sku_info->cpu_speedo_id, tegra_sku_info->soc_speedo_id);
 }
 
+static int tegra_fuse_acpi_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	u8 chip;
+	int err;
+
+	tegra_acpi_init_apbmisc();
+
+	chip = tegra_get_chip_id();
+	switch (chip) {
+#if defined(CONFIG_ARCH_TEGRA_194_SOC)
+	case TEGRA194:
+		fuse->soc = &tegra194_fuse_soc;
+		break;
+#endif
+#if defined(CONFIG_ARCH_TEGRA_234_SOC)
+	case TEGRA234:
+		fuse->soc = &tegra234_fuse_soc;
+		break;
+#endif
+	default:
+		dev_err(&pdev->dev, "Unsupported SoC: %02x\n", chip);
+		return -EINVAL;
+	}
+
+	fuse->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(fuse->base))
+		return PTR_ERR(fuse->base);
+	fuse->phys = res->start;
+
+	platform_set_drvdata(pdev, fuse);
+	fuse->dev = &pdev->dev;
+
+	err = tegra_fuse_nvmem_register(fuse, &pdev->dev);
+	if (err)
+		return err;
+
+	fuse->soc->init(fuse);
+	tegra_soc_device_register();
+	tegra_fuse_pr_sku_info(&tegra_sku_info);
+
+	err = tegra_fuse_add_lookups(fuse);
+	if (err) {
+		dev_err(&pdev->dev, "failed to add FUSE lookups\n");
+		return err;
+	}
+
+	return 0;
+}
+
 static int tegra_fuse_probe(struct platform_device *pdev)
 {
 	void __iomem *base = fuse->base;
 	struct resource *res;
 	int err;
 
+	if (has_acpi_companion(&pdev->dev))
+		return tegra_fuse_acpi_probe(pdev);
+
 	err = devm_add_action(&pdev->dev, tegra_fuse_restore, (void __force *)base);
 	if (err)
 		return err;
@@ -306,6 +367,7 @@ static struct platform_driver tegra_fuse_driver = {
 	.driver = {
 		.name = "tegra-fuse",
 		.of_match_table = tegra_fuse_match,
+		.acpi_match_table = tegra_fuse_acpi_match,
 		.pm = &tegra_fuse_pm,
 		.suppress_bind_attrs = true,
 	},
@@ -327,7 +389,8 @@ u32 __init tegra_fuse_read_early(unsigned int offset)
 
 int tegra_fuse_readl(unsigned long offset, u32 *value)
 {
-	if (!fuse->read || !fuse->clk)
+	/* fuse->clk is not required when ACPI is used. */
+	if (!fuse->read || (!fuse->clk && !has_acpi_companion(fuse->dev)))
 		return -EPROBE_DEFER;
 
 	if (IS_ERR(fuse->clk))
@@ -410,7 +473,7 @@ const struct attribute_group tegra194_soc_attr_group = {
 };
 #endif
 
-struct device * __init tegra_soc_device_register(void)
+struct device *tegra_soc_device_register(void)
 {
 	struct soc_device_attribute *attr;
 	struct soc_device *dev;
-- 
2.34.1

