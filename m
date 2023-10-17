Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3B7CBA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjJQFZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbjJQFYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:24:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA53FF;
        Mon, 16 Oct 2023 22:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl2Y2Co2jCcy10K/IQJAanTeLvqLwNyZVpfYkNS8yr2LQG73gUNBa7ZFXNNxB4HgmYn/RVw1yOO8J2FtNkK2XDCZUn6hEn7Wps2gvZQBvyPZa6HDg55+RB4V31O+RP/iJXH4A5Nx5ubPO52KaWwqf+NGw+QyQuuIIprtIgLKYDnDg5vxJanhskQi62L0rspTbL82afi2Jr23kPs/nBzbJXsM8KbpnKo6oZEFsDT5+dGXNLwredDWEPOXTutf78OD9P9KfiDY3Hm6+IQ8eqCtVTp0kt7xqhwVXJIjV+JQBb8/s5pu285gfVVeBX7Nol3L45RaMYi4cZ4lMPmjZY8/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXHGduJtyi7mXIsshVNZYDX99dwCb7TKZNhicwBr1bc=;
 b=WZXmUs+Pafbmh6/eURBu9YRy14XFUfh38uxbUQ9bOLp7ut75lnN3iI71GtW7gAae4i2NprKU5BfpFthGmHCjIkKX3ifgRMEwtQLv2pxVcg/e4sDh9htm/Jj3GltejNttTkBEnoffz9S87s6C/NJPPZ1M9c4kMoxXEm8PUhdA5N0EnS5EHwL2CrCrNBx+Qa4tPvNTMrX7S+7xIxeVF0d1SAJrpSvkqUsklKxO/wZM2Jt/SWa74Y2eQyp0XkWt9a/28QQ1wKvr+Np+GF/MAiRbZoRYLxfXEOuJf3I5oQBxgUKlaTmLwhQF3xZan753Ke3p8GbFVw8jvfnP+S3TKSDCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXHGduJtyi7mXIsshVNZYDX99dwCb7TKZNhicwBr1bc=;
 b=oL5r9aSfQK0G1lsWhA0w4PbEUCuqi19mWfL6FLXHRf11PLE4EHyJAqJIuPRnr5W3Fu8YKHFgF15wc04rPe0MO8RraBmQnx0K/nOO5A41KqYMXEDxMPLw03Vsib+1EecfMsMTcetNBQLWPU8gA9/mVoYdqQ35WVOkv/sQoe/nAUtGI8V0UD9Wda1/1/U5qnBuWjIqeBgh85k8H3gRFaz9+o68CjFp5DNJBjyhjFS4BYYYIbN/SMUf8ZUayB9/JdP+Ybk47qeJY3PiCp+dwE2hSYcP5pPxSqBJr+ExApBIMkool5uTOTmiEJssLJp1tRqw1Oc0MQvd6ueLc8Z71u23Wg==
Received: from MN2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:208:1a0::11)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 05:24:35 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::da) by MN2PR07CA0001.outlook.office365.com
 (2603:10b6:208:1a0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 05:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 05:24:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:24:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:24:19 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 22:24:14 -0700
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
Subject: [PATCH v7 8/8] soc/tegra: fuse: Add support for Tegra241
Date:   Tue, 17 Oct 2023 10:53:22 +0530
Message-ID: <20231017052322.2636-9-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: e012618d-d03f-4220-bc2c-08dbced159fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANxHDQJD7Glq8PKjNFBUE14y4SZ27R/L26hGqiODdZkkiULhM1BhYUOsMRRj+pwi9l9XmuCGgC1Yu7V6r5Ot2LxRFSg/oeo68u3ZDiTSDNzprtinGe+giHhLFrgQ8saCIxs7fsWD+fxoM4eUzIGFOU5VlQVUDcGYTo2lgoovaG16eTy/erw24r8je46sfNraczxuTo8NtK0Kc5D/xX4z6EeuGHAMIWWurFR21VY3OsTU1HWQr7rSXZDlEF2sLss7la1vbl++jMqsMEpr1Gnp1j51s4qY40QJNY2Y5l32obxdqnIkck4o1iU4ggAB2IyfHj/EnAqBVX8mIXW9uXG1pKKEFvGmrPyocTQI4ZWkgk27bXG5zyTKUmF5NIXKxoWQke5QNFMa3kpC2WyQdbdKalEPWrmZpnHcxXZTnA4jwk0adyXYP4h6Pk22lOphRrFYJgWYs3cVdkMj/Ivdf6iiKM1ym6CyzSVIqG36EsHeMd+cRPJYL+eDjqLZQELcL6Q4FDQMOeaThGsOsQdPNdZIKn38PHzj5Pjey8sWq7VkstY6yFljKFSN+55idaIjZIGJfdoH0rAd1x1YyQTBRGVi3X/pNdmDzYBRxfKheNlZoYSM0SbUqSwSNVJamtGGDHOrTKCcHROD351tDh1Uw/VyxEi0g+JxANGOAM2CGFXHYStSlVTaWf/lIlje5I//YN1EQK/XRUmLQ86weq8kJ32fnswK+SvOMid1++5dmq1gvhn2m0e+4gY/EeJF/iz3CgsiqaDvIwmOSy5DlZYrcgf9R0lD2waTVEYFTzA6mlpEf35vDqpH0YF1WgiLSJcy2XHx
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(478600001)(70586007)(70206006)(110136005)(6666004)(7636003)(41300700001)(47076005)(921005)(83380400001)(36860700001)(86362001)(82740400003)(356005)(2616005)(1076003)(336012)(26005)(426003)(5660300002)(316002)(36756003)(7416002)(8936002)(8676002)(2906002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:24:35.4117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e012618d-d03f-4220-bc2c-08dbced159fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 1c758f121f91..233b8e7bb41b 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -171,6 +171,11 @@ static int tegra_fuse_probe(struct platform_device *pdev)
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
index 6457f80821bb..e2ca5d55fd31 100644
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

