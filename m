Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4447C517C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbjJKLSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjJKLR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:17:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63146196;
        Wed, 11 Oct 2023 04:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXKvhKK/rp/EdyXx5VPQHBd+jvnTlBRRtEjcH0ziEkPr3YZQT4zVACa3Y/KGFwTUQugdYl+M1BqTP+HWFbHfEDrrb3dMsuftWGZafE06Sgz4boVA4w9BROMPNMx2XfkG/oyvo0Fc66WCMZphc2Q7bHb44TO5YWBB04vRHd5I5SNZNIoqMbug6VlNwXd5QkarzwSmPwHo2LfnL5tTsV0nUfrKgcX0MKiK66erIthIYN7dRmc4CfAvZuy0JV13z/Yk3Bol0aLyW78Wsyo9xXQlDF809O4hfB0W8/Oni6kzNC4Eee64QlZtNKuZwW7KlyCGDVZb5kVbTo77w+OlqjYsKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WurtSdXatK1MVYtezFb+hCbY0OtHluU+OZ20OPVdfE=;
 b=JSj1nVD1jrQ7kdLocWUQTyWeqtcC9wvV0TEnBwwX3nWO3oacnXj8ppXQT1763HQ1K0XRIfQgwPBteSAKOTKD9Qd13Ze2Tqaw08CYxMNSqLZhNbLOyO8rYquHbL4nJAz8qifSgknGGI7zlJX8fP9WR7yqkpuY2TjdXHguXhRKokBPoYXEXbSjoAISGG+GH/avtVz+tjlfU+lkODH4sZYyoAby9B/GkxZCddQnmLO9o6uBVPtx9wEqITcjkkhGLI76XcBtG3QxM2PrncTYQx97JR3n4RxNO1BYAb2bXzk5MeGG04ec8zbDMgQMBv8KD3eQv+/00PxduenSB05kPGx5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WurtSdXatK1MVYtezFb+hCbY0OtHluU+OZ20OPVdfE=;
 b=iePqMS0q0lXwlTNIQduA1y4+DVfcfTQWlEXRX3jzDXLC33UDlh+EAWz52I6c0RNvpq8Yf8/so4Ub+MzNiGe/4mQFy3plfZVCGOfByNY8Qw30XEzhCBRBSqpJTPiDrMUR7/mJ0TtmYvVdeO6xRFb1M98YTwIS9q98pfpiUw6fIccvq8Q1Lyb1mcyHrgvBEWpJWm8GFq/J/XQG9u6AMdarc5PsEfEvmwgNincpCeI7/MY4FJnveN5TK+vyDjGoLiPdos5b/5RCn2ZWtwrQHB+vg0SH8w1nW43IrsDCzcLbvg/sUR+pNoEeHR8zeRs/3ZYgUQ3+pmkKkKdsbhFnJ0NvPQ==
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 11 Oct
 2023 11:17:49 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::67) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Wed, 11 Oct 2023 11:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:17:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:39 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:17:33 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <petlozup@nvidia.com>, <pshete@nvidia.com>, <kkartik@nvidia.com>,
        <ulf.hansson@linaro.org>, <frank.li@vivo.com>, <robh@kernel.org>,
        <stefank@nvidia.com>, <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 8/8] soc/tegra: fuse: Add support for Tegra241
Date:   Wed, 11 Oct 2023 15:04:12 +0530
Message-ID: <20231011093412.7994-9-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011093412.7994-1-kkartik@nvidia.com>
References: <20231011093412.7994-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 9101d8a8-6faf-4406-16d4-08dbca4bb39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ibVR7mdqv3/A1+KPmHGe3j324tcfzuuACl8X/madPwHwR3qoQOPEOhSdLhUKjkQ0lMIwRLEl7taEzknOWeh0gyQpMK1555ojq6YBhvHwbI+AgnxWPJ4p/1BfC37Tcdj5WXeyEGWSEt/Vv3Qes2x7i9/Ql29d9WnoVx0iA8c93tdU5zAh6EgCwt+AYghIDMAikuzCF7004yK7iZUElE0BWZbmLrwaFkMOsgYLNaL65ThQXAhrT8xCvMIL+AC6ShMKE3ZHoxp/5fch8q4yEk4vpsoMO1bapomxh9uu6TEuHOzs+6+wlQhLh+zK9kPp/ccQ7sbwZXLyFRJlZzST10AV/xe98pEjiu/hLZWvqVD7zz/qvvLe1M9sICHPUygLtnjqdUYo36cpunYkYQNuTsipLOeiHxuO0IKhuX046B3k298fT4p7jpqasRNxX87JVKhwB5B7VGOWx75gqv5MOIzsLw0ZDrwKtl8+W5qKUMijX3JvzMFJP5HN4zG8DS1Xx5hg3YcBn4V3NLjfo0X0ktYD8MBZFvevianJXz7rFce+XSeMe/2XJoZi0W+i2LEZI2uT98VKVms6J2hcASHtRRgniHOHixpMEMOxRTDeT6QL2XLNCMAnNyrDJl6NXS1+7Op1mXYoq6i8MR4Gk8CfEIeRL+lg6kx3YDlic6XXayqryqim9gMES+h9Q69Jk0/rLP8ckFeRZ0WrxzPTnaXt7wqniE+/u9bmjG4rAsZlrs6qei61s2oSiLptsVmdFK9dfiSntpXrUvtxV6pcxlzp1+j3Y+UpInqbDKgAInmSG3rPgwoaxI30FDEM8JMZZF8W4ik
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(82740400003)(40480700001)(40460700003)(2906002)(7416002)(41300700001)(316002)(8676002)(8936002)(5660300002)(921005)(356005)(36756003)(7636003)(70206006)(1076003)(336012)(2616005)(426003)(26005)(36860700001)(86362001)(47076005)(478600001)(110136005)(83380400001)(70586007)(6666004)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:17:48.6294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9101d8a8-6faf-4406-16d4-08dbca4bb39b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Tegra241 which use ACPI boot.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v1 -> v2:
	* Removed few entries from tegra241_fuse_soc which were
	  initilized as NULL or 0.
---
 drivers/soc/tegra/Kconfig              |  5 +++++
 drivers/soc/tegra/fuse/fuse-tegra.c    |  5 +++++
 drivers/soc/tegra/fuse/fuse-tegra30.c  | 20 ++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h          |  4 ++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c |  1 +
 include/soc/tegra/fuse.h               |  1 +
 6 files changed, 36 insertions(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index f16beeabaa92..33512558af9f 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -133,6 +133,11 @@ config ARCH_TEGRA_234_SOC
 	help
 	  Enable support for the NVIDIA Tegra234 SoC.
 
+config ARCH_TEGRA_241_SOC
+	bool "NVIDIA Tegra241 SoC"
+	help
+	  Enable support for the NVIDIA Tegra241 SoC.
+
 endif
 endif
 
diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 167a6fe6c43d..94bfccd719de 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -174,6 +174,11 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		case TEGRA234:
 			fuse->soc = &tegra234_fuse_soc;
 			break;
+#endif
+#if defined(CONFIG_ARCH_TEGRA_241_SOC)
+		case TEGRA241:
+			fuse->soc = &tegra241_fuse_soc;
+			break;
 #endif
 		default:
 			return dev_err_probe(&pdev->dev, -EINVAL, "Unsupported SoC: %02x\n", chip);
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index e94d46372a63..2070d36c510d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -678,3 +678,23 @@ const struct tegra_fuse_soc tegra234_fuse_soc = {
 	.clk_suspend_on = false,
 };
 #endif
+
+#if defined(CONFIG_ARCH_TEGRA_241_SOC)
+static const struct tegra_fuse_info tegra241_fuse_info = {
+	.read = tegra30_fuse_read,
+	.size = 0x16008,
+	.spare = 0xcf0,
+};
+
+static const struct nvmem_keepout tegra241_fuse_keepouts[] = {
+	{ .start = 0xc, .end = 0x1600c }
+};
+
+const struct tegra_fuse_soc tegra241_fuse_soc = {
+	.init = tegra30_fuse_init,
+	.info = &tegra241_fuse_info,
+	.keepouts = tegra241_fuse_keepouts,
+	.num_keepouts = ARRAY_SIZE(tegra241_fuse_keepouts),
+	.soc_attr_group = &tegra194_soc_attr_group,
+};
+#endif
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index a41e9f85281a..f3b705327c20 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -136,4 +136,8 @@ extern const struct tegra_fuse_soc tegra194_fuse_soc;
 extern const struct tegra_fuse_soc tegra234_fuse_soc;
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_241_SOC
+extern const struct tegra_fuse_soc tegra241_fuse_soc;
+#endif
+
 #endif
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index e2ca93de6c1f..c72bdb3e4e2c 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -64,6 +64,7 @@ bool tegra_is_silicon(void)
 	switch (tegra_get_chip_id()) {
 	case TEGRA194:
 	case TEGRA234:
+	case TEGRA241:
 	case TEGRA264:
 		if (tegra_get_platform() == 0)
 			return true;
diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 3a513be50243..8f421b9f7585 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -17,6 +17,7 @@
 #define TEGRA186	0x18
 #define TEGRA194	0x19
 #define TEGRA234	0x23
+#define TEGRA241	0x24
 #define TEGRA264	0x26
 
 #define TEGRA_FUSE_SKU_CALIB_0	0xf0
-- 
2.34.1

