Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9280278088A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359212AbjHRJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359199AbjHRJbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:31:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58430C5;
        Fri, 18 Aug 2023 02:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSQGk3xtr/xnhzq1C4/2CwQ+ajw3Q8uCQBuwX2XSiWpMkplK0TBD3rePzknt44WLCUCF32XDAtDSFdDkktMMpSg5wRt0wfBxzdTARSKh96c+rDMFg1YPw7eXjOXcJHO5X629zguCldMNOI6A6cUfsPDLZrMHvt+B+MN2QfbN4+j4K2bXcRaK2dLA7yg9fxijdmNYB0pThAk9rUvJGGG6r1ghBi7sDihsJPsVoPiXG+cwWh2CCFLksz71r/MegVCWtQ2ZWpHSgTE9QjlDnckV3sBOq6Y3BWnRphaOfRMY3vIO9hArw82Q5041gGGZTSh+b7780ZNVSFef1cQwicji1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/zDBEu9V3s7l0QN6BOcLf5PelunFsY9DUJZq+eyXeI=;
 b=I/bYYUrnrzYVhEA3wTbxvOc6rhxWQyIQ2kym5HhiWyouNVoIPcgjKqqBhm7MQoztVGE70JMVxa2cpUObNGj6ybDJqt3AZ/OhGgE39SofmzYZc4ApPG0pAAFuidgR/T1uKvCv90OkRJDzWBSvUbEpwwrZacyFXduasIe8UgnTpP+r/8gtp3fOP+L0WwRUyxuJr+2oo49bYodw+miVFVWmJh2qAQlsUdg0TsfK8iJav4MhfS570Jx0rbPDMCj6ZsJ7ICs2cyS3q6y4MVGoRDqXL0b3/If+xmerL2B+lNNk8NRJk73rHAyuMjP1H55Ko85OcV6t+lUZeKZPkZ5TZTebHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/zDBEu9V3s7l0QN6BOcLf5PelunFsY9DUJZq+eyXeI=;
 b=FAzDWFyJgKemEeFsOqaScvBIo2afT83fWZEtct7RclW5uHmIa9Wg5ZXVOW8gZpK4zldx6fHyDnNYsK8/2pscH7Yc7PC3XwivhrPjSqarOqnCg4jMY38+YkCVOC6/ohEgx5BKsvxSCbY/txmMLzcexYTj15DegMCLbR9KkL+TA7NfKb3ag7kUzqJgxoe+kOjidmOC6WWlBK5N5tWwOh7/L2WJSqa9BEQf1x9FXCFYCJa8lhxjDDgM1Ilte4ZPyt44f+xWDDC9j0OYYxc5Ueyo+BU7X5Bl7QecOHRP+m+CXRclXwuaBIOQXfYKUqgq6GmO+mNkWPAn9w47iNW77P1GOQ==
Received: from SJ0PR05CA0210.namprd05.prod.outlook.com (2603:10b6:a03:330::35)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 09:31:27 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::78) by SJ0PR05CA0210.outlook.office365.com
 (2603:10b6:a03:330::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Fri, 18 Aug 2023 09:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 09:31:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 02:31:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 02:31:11 -0700
Received: from localhost.localdomain (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 02:31:07 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.co>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] soc/tegra: fuse: Add support for Tegra241
Date:   Fri, 18 Aug 2023 15:00:28 +0530
Message-ID: <20230818093028.7807-7-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: ef70e2da-088c-4ce3-f62c-08db9fcde590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Phkb98lyrj49J3YztqjO2DrbqsYnbY6H0BU5mVFWHsF4FyL7r8bJmuwEdUk7m9KKaQ3KBlXx9HRqdg1z6fDzE1rZTMwMEMibdx2hhIaepKWTXf20rhQdd6MJv+HTP8sGPx6LrTaKSuGi0RNLP+FLUMZjKSzY4015MjcXRrMA1ZjEUEFJgOZYpAdEdTJ0sMJE9KhsKy9fOrfCBP/QBPUSYZHzq1bQvlgB4on+1k/GGdeAt2+gdrnQ40ibIgnCku1pOiydoEgV07xpCzx1ZjEeiMGvaZWM31zLGJ84k69WmrMpYFEwURnAeffGSJNjKoErAzUUzpIJpIeqyjQIek0eMBch7zkGK1Aj3yrGyy9D52dfdgN2P05V4cvJaBY25MsqHcMbfU8BE6AbAeCuWo3I/f+lG6n4EeS94SNtCikfZ7CSqKAeXt6uxGBiwypjYFzo9UsWZ9OSBx3OIN3+3Qp8hn/zbbII+KgZIB/LJDhDZ+3Re2oTnf035j1f+jW7uAQCpEdEahuJ21VCeF/johEV8sPzYAPro7SfV3pkkJ5GKjYSzUKfMF8r5aShgWrSUMSqBdXkeNiKzOG0SVVvP2bQZPAKktSAJudYYULuV50LUv5NLqPoi3OK/rZcQmQK9oAAiyvQxBTwdz6YPdmBJ4e36Z4SnXAHWy3c35XRi8VfbU5SE4ag7XP4sVZ2G0MASiYBg+/8i2wIhjtwqiJb6OzvjDIHDusgX/xWATfW2jS9ACR9Ifh28UnDWNuSZftIk71s1pp2zPLaZn+0XW/OmRnrA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(83380400001)(26005)(86362001)(7416002)(336012)(40480700001)(478600001)(426003)(6666004)(2616005)(1076003)(36756003)(5660300002)(36860700001)(41300700001)(70586007)(82740400003)(356005)(7636003)(70206006)(316002)(921005)(110136005)(8936002)(8676002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:31:27.0714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef70e2da-088c-4ce3-f62c-08db9fcde590
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
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
 drivers/soc/tegra/Kconfig              |  5 +++++
 drivers/soc/tegra/fuse/fuse-tegra.c    |  5 +++++
 drivers/soc/tegra/fuse/fuse-tegra30.c  | 25 +++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h          |  4 ++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c |  1 +
 include/soc/tegra/fuse.h               |  1 +
 6 files changed, 41 insertions(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 6f3098822969..5f5d9d663fef 100644
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
index 9c5596d968a2..8750450438c3 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -203,6 +203,11 @@ static int tegra_fuse_acpi_probe(struct platform_device *pdev)
 	case TEGRA234:
 		fuse->soc = &tegra234_fuse_soc;
 		break;
+#endif
+#if defined(CONFIG_ARCH_TEGRA_241_SOC)
+	case TEGRA241:
+		fuse->soc = &tegra241_fuse_soc;
+		break;
 #endif
 	default:
 		dev_err(&pdev->dev, "Unsupported SoC: %02x\n", chip);
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index e94d46372a63..757bcf5ee82e 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -678,3 +678,28 @@ const struct tegra_fuse_soc tegra234_fuse_soc = {
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
+	.lookups = NULL,
+	.num_lookups = 0,
+	.cells = NULL,
+	.num_cells = 0,
+	.keepouts = tegra241_fuse_keepouts,
+	.num_keepouts = ARRAY_SIZE(tegra241_fuse_keepouts),
+	.soc_attr_group = &tegra194_soc_attr_group,
+	.clk_suspend_on = false,
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
index 79db12076d56..f830aaf3d92d 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -63,6 +63,7 @@ bool tegra_is_silicon(void)
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

