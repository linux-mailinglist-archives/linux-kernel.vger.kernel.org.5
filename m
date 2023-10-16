Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E9F7CA518
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjJPKQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjJPKQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:16:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B035D4B;
        Mon, 16 Oct 2023 03:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEh/PCfLYBex2xQ9P3yg2SrM7VZ4pL6oU41VRbRd91FZ/kTr2nWYJB/Bo0SIck5t2bsmYDbKRTWvrBNwZPEMcRg/CJ4HLpbgO4mTwFxUAybDyz5RrF1JgX2UtGvXpI6Tm+peUIo9zrjFuKM9KGe609GE0Sp6c2F265rD0oiyyRug5CZC0/8IMFCfDMKVwt50EGXxMMhe5BQKhQwSFBmglvwuc3N7Y+QabvVaWOit5coNRmnSK88vBAjSxd++fFfjPXHLNFvkvcTmrfj0dyAh3jeq5clV1TjBDaxVl7Sc18HS4VV3xindaSH9dTrn6wDCashbNKsb1ug11ASsAHoD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b6A1/4Co5BKI2JVzzuIO8+xdLoWsK1IncyT9iv4Tgc=;
 b=CySMYKHDMWXTWbiDfGv19E928BhKCrM8rETUm6GQYy2FeHVrowGvuKF25/NCfF0Ii9EJiM7mqZ7PrM2XOU4yhoRmQSWF3L7NGzCtX9jQh+nHdijub3Wb0t9dxR7k8X2M5dIJAJSYK1HtWoYplC3lZtCSwDRAfo9D8ka4fLUWr0olPz5W5wh2pZ1QBIsg7U3TtbNA8rYQwe+4uJ6YRukodKwcgSuAR8Q0vMf0QgoNBUzblwPgXw7zuiQmsRHbi0ARJmHvzj6vJP2gFmogyuYOuLPxho3+4Bi09cdOIzl1U03WF0/gsplnLg9oK2PStvR+aTEFx1kRBlom66HgpNeBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b6A1/4Co5BKI2JVzzuIO8+xdLoWsK1IncyT9iv4Tgc=;
 b=RqDIbZdV8u6euTRJ2wDzj9pACLWR4UMZdfY4VTm4hrgDBMtpNNjg2lJWGZl7Ky5ELdGIOuKxXoAknptNy+7FkVM+WQgWDtkbegV8mO/meNwbzdj4kbtbwomdle/eFhoaLngJNlMpuolKy2aRz6inMJBw1iphLNUTk4OO6iJcIT/qDXz471v3VcsvJOb2v/hm8fqICLuTi2I5F/FPLZ+khsIZvs8KCRUGSmGHv3YayHCIA1nLLIUyfckBx2SpIT8Kj9x7LtQbSN/jqEk6qrDorM5Aw2BiBp2rT6fV1fNkDlkgHfgeANO4Lup2ayZ/qd+nFgFDzPhOVj9vaovlB1sEvg==
Received: from DM6PR21CA0027.namprd21.prod.outlook.com (2603:10b6:5:174::37)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Mon, 16 Oct
 2023 10:15:48 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::8c) by DM6PR21CA0027.outlook.office365.com
 (2603:10b6:5:174::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.2 via Frontend
 Transport; Mon, 16 Oct 2023 10:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:15:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:36 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:35 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 03:15:30 -0700
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
Subject: [PATCH v6 8/8] soc/tegra: fuse: Add support for Tegra241
Date:   Mon, 16 Oct 2023 15:44:36 +0530
Message-ID: <20231016101436.7146-9-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 35501aed-6597-400d-cabc-08dbce30de1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDjo7XemUXDn1njIO52G3Bz2qvTFC6LSS4kEaKaRrs000AJSLg1u34Ek7G8rPPcEKg9irVtE1x1XLUoT62BsITkmoBFMQpjbdvZCqN2VKFLfyww0W0vPxJv2gR5ZjtEMH7T6SUHFkY1q4ftQQv2j4kEiSWhiDHgRQPhUl6i+JQ5eSVlwiyn32RsC7EsLPeuzlPj5wP46croWSYZAQq0I+6wJ9L6nOwg/pfolDzJ8FBkYzSpRG4B+5/2UXA2+qH/ILmbm8rn1NDGBzy3txxMmvn4d9epvBY8p/kITjiVozjPURDoFdzQWO0MfUZn6CJ1TuxHrUQZVa7jPfAoVZ0Sc55ZqIsD8JxieRTCvpISAe2dw+ekrlsrcmSZaplPdOI2B9mAM+HEWW42dwl2cpaqTHQosBsvfhZqzxWDI1NyviLJVBFqn6jrsY9OidJBnRPurOwYE9X44wNeinpbBbVc5DW1ZhGkDgagOyyYylcHwlg9HHACrUPh/1XwHos6bICDBbEDd7e00RYslVW3kYbZ8ifnH/+XzeXWX6wA+PmMIOg7fgcLSTVT5rvli5mvhvWqAbt2VDVNB1+HLkZpc/DDn4lZNMq1hEqX3k7eD9Sot6mU2Lf3FN1BVZjH64/6tNEdSUyeKr9GjEQRHUwlXELJxDoZ+uL4RodEdnDaOgkKP37BwSdRhM9I2bxqQ+osfOdso6C/7/sTSC1/p8X2HYRNFvLfru9npEbHfqfJJCRMdvQgIh+3cyYDcNpdA35OvwknrsAMYNDieiIwdShORrV6lqF3aReaQpZER6R9J7LrAjuCqekb7eAVXtwcOkEo5qNaG
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(82740400003)(5660300002)(921005)(8936002)(356005)(7636003)(41300700001)(8676002)(40460700003)(86362001)(40480700001)(7416002)(2906002)(1076003)(36860700001)(336012)(2616005)(478600001)(26005)(36756003)(70206006)(426003)(70586007)(47076005)(110136005)(316002)(83380400001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:15:48.1806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35501aed-6597-400d-cabc-08dbce30de1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
index 39a59545c93f..240846dd56b4 100644
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

