Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE411792CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjIER6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241916AbjIER6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:58:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683493B060;
        Tue,  5 Sep 2023 09:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8/JR8n3C6Ef9ROU6X52W9UVaB8hin0kEcaSI9URmaGGePUuq0QGwCjFXDtF3aFLyPqv/sMt5m42DZe+lQwbRnjf8nOKWIT8jJjmExk4pYp+iculrkUurgNWNgrj2gJKSb6PKY9kE4f1l0wttsSLqV8ggDGSBcWNJdgI1U6WMMt3+XJDOgh9jnb8uyEvHuyWAB1JhqqhtXtxRR12qPgdWjnyFYEd7zZpE+83qBxOwuXgQdnh/zTVYoxYFc/ZyAM4boGMA+nVarcdFbVzaogthNnAfeKcEITQieO8GaktFNzueJ47IJwKLu4rR/9wmkB0giL9gEJDxjDi6KiSmq/mng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp6eGBd9z4s7ABrrY6Deo/xIhrITUXxGjV5BMctBBo4=;
 b=DtCcBGosDdxCqoFsSzv7ljuabSfqOsKdKQbXcRszYjDeBXjkS/T79+xxA14/YkHje6qfk64BGTWnKegqQ5sxHF4FnlCAlDTFr/k0+CKQ4ovttmJop97OtS7kovFxnogoOXCaFXzA7MwEdtXb1A7k8WOOIbeNA51vvk4qODxj2+DiVA4JPpz8euqVmOLpazKJgQt4u8ec8ewkTbTDtDXRXi3o6jYKCw9X3glaY9uKzG16G1sh3W/6GK0VW269n4JxDsWahVvuKtF6mk99Wo4A3BrzpVdmNIVsL4xfk7c1FOv43Fr+rC7i+OROeblUJiJvaoFe1lBHQd8YMoJ0qDGJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp6eGBd9z4s7ABrrY6Deo/xIhrITUXxGjV5BMctBBo4=;
 b=c6K29ARCxP8/xpIAn+tUUKwn5bd+/s8f3iRI811LVbCHsVqeFkOD7Pitna9UP1IEoEIjYNGw5yflJ847R3mHDpoc0wGnf1eWE68CI7O/LojW953rp6KcEoPxZ1k3jGL4tqwwldwbvYNkibp52u0lDGsY7RiCDD6lzQfCWRKWkyPo0o2JBDQnGJzLKjyr5ZN2nBbp25xm/rpMxr+8FLK7m6sK5oZIXffPL7kfpj2aijLwwhirN6qcAzr1iYNkAnYkvPWTaZleyQjXC0RcK/yC2R+qLZdzAoQbFYRoo/CY0x5dTt4v424KlxzLkWjFiLo9i8MFaeeXi8Cv+Ww556jMPA==
Received: from SN7PR04CA0207.namprd04.prod.outlook.com (2603:10b6:806:126::32)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 16:37:07 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::92) by SN7PR04CA0207.outlook.office365.com
 (2603:10b6:806:126::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 16:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 16:37:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 09:36:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 09:36:49 -0700
Received: from localhost.localdomain (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 09:36:43 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] soc/tegra: fuse: Add support for Tegra241
Date:   Tue, 5 Sep 2023 18:28:24 +0530
Message-ID: <20230905125824.2947-7-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: af02c357-4440-4052-009c-08dbae2e577c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bxdcf95kmJSngdKVScn6mYB3zegdNiAohNgM7+TQ0QAYVBlgOUUlBSxvyY6h6R4TpjuiP352QSblHNo9iqz6ZvlNsVW6RVRZBTUQHi/dstsyyblStsFaD6zdgZ73thtHPN7NCtpFzyAtrtFIdKR4dQqMDPMQM4N63lQVjtD9tHd2HJyyz9t6N18J1NNloTLjLa36t7nVrDIfRqb813+3bU5dM8qz1oLcdiSST9wzHJ7o8el6zAVZLbRbHDf1hNoj/3WbeNOxsvrN2teLjjRyjvNPXmvesktPWvrRYsEQ8Zr3uA0UcB2EDnE9nKJjmGMJMnKVQxWCDOVJnP7nbWtvVjjYzNw8GeXyVpBb80ITp2ybRUg6fTHRugNFWVM+42Ap2UPgoO8nSspY96LwGOCUt+I0MNVgFj0PRImzWaQzzppf/u/lZkh59e1NCCBzQ93LK8BZRMuYye31FLu0CmcxuZSuo9Mg+F/bcOS5x27orUNrtbkoFijGvAoLfGdCRuXHy60KAgi40A3jAN4TY4nL0RtRKuyPN7oK7Of/hvz9R50hOzsTR26tfNPYG9CdS2jG2c+c5Nk5i352zJmF0IOolnVd2Z5SUi8fYjsnaYNKjF137f4C6biU7HKnazjyXy7pVhTYT0A2F2w5LO6Kr1+twiGrGsHS+bKpLj7Q2NRm/BYD7A1A2+o8HaTGsI4wpcjYFUnRTQ0IQuS6326hnH0W/2rbdIKXhlEggOW9rAozH6OCAQePfKqFYBqEoSHE+hl+bJXlG8yLU45DKMIQcTlvg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(70586007)(40460700003)(7636003)(82740400003)(36756003)(356005)(2906002)(921005)(478600001)(110136005)(316002)(86362001)(70206006)(6666004)(40480700001)(8936002)(8676002)(426003)(1076003)(5660300002)(336012)(83380400001)(2616005)(26005)(36860700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:37:05.5655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af02c357-4440-4052-009c-08dbae2e577c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/soc/tegra/fuse/fuse-tegra30.c  | 21 +++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h          |  4 ++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c |  1 +
 include/soc/tegra/fuse.h               |  1 +
 6 files changed, 37 insertions(+)

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
index f35f9651a653..eb11465e8092 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -172,6 +172,11 @@ static int tegra_fuse_probe(struct platform_device *pdev)
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
index e94d46372a63..34fcc23a6449 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -678,3 +678,24 @@ const struct tegra_fuse_soc tegra234_fuse_soc = {
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
index ce8c3c25b6a6..f5b241a527c2 100644
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

