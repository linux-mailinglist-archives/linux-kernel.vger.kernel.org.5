Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152B9780882
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359228AbjHRJbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359221AbjHRJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:31:16 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F83C27;
        Fri, 18 Aug 2023 02:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0LpIErdeBQATDODVWKCW6Y7qioa9HH82k3ycHzMCmzCgKCUPFXruTs7qwdxEBS26QzFikw8c1XAOPp9FgB7Bf/hcBCRdUOklrJ0OBX+s+9d2H6D+iI0eNrwUo3C67UF/9sgrtqBidcX3Paw/V9XCiRQJgy2v9qLH8SfLy7sOVy8f0f0fB+Wny6Yra2xDussuVBniOTvep+yyMBklGfLldizYihTndEicl8FePn/GL9Qin6WP0Jw9z7ko3FddUBCMgcwBhqiUg4JNS/T8HAERFUSlfz4QKfNVXkwgdZSavRpEHi/K0JkmhRySrHHPWW5LbJG0LcerhvcagKTi+kW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKsPtqJaane6upZ0d9uK3PX7zervTKIc8w2QONHL8lM=;
 b=cyvuFMzcOn1FOdwMDw6bpfaXD0ERBfJSjE+FGAMKWT1nbP6HaBw4g7uJ+lWnoNKUNHuxr23Z6KZRWPsygqB6Xvwvk2UFdFa8c5/rmkBsub0M0GeyedGrrcWJAyfLSbMnqXzl7aEYQIginc9XmnfHkdJmmmGMqzfSG6mWAJnj8MuloWq72uDsVYqLZYBpp/p+3OosCz8u/HVfLI8klbB1N5QIj2WW05rKm32q3FIRRrK4foqMVmpMhwQVfIt/uHX1Xw2KZS0UEy8XFiuStBoXnv1mWeGpreEthm7IrRVmPMSZYQniOhOk9ay5ELavK7rmcKl4u9HNGx8tDMksHTQ1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKsPtqJaane6upZ0d9uK3PX7zervTKIc8w2QONHL8lM=;
 b=iwGiUJ9vxYPuj7N7R2i1TnHBbA+Y6qTwOHmDx2UrCXYeXRZKK6TRZ5QbWRfXLg0gdOhoQcJ3ptZuh8uUbF5TGDxxXgRarHSwhX6mTzPw5bGZXBB7j4twAy3KBYjdVRmPgEws4LIGy9ivaz0VJ7vFvs7h+/t89m9OMUTsdmz4rWsamPROSHTEzUSq6IzomfVXMVcMlyfM0b0hfn56yhmkC/bdyLqiDl57BFmfOOvrC7QiBVrQnuNPI1J3IcYQ1ek2ADy9PUXg/UIs4RMdqJueqoo2TAiO0lWeOhYz9ksChVyhxFTC0MBcZRQJuQSkAYC8yUTJRwgld220o9VYhe8knA==
Received: from CY8PR11CA0025.namprd11.prod.outlook.com (2603:10b6:930:4a::19)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 09:31:05 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::cd) by CY8PR11CA0025.outlook.office365.com
 (2603:10b6:930:4a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 09:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 09:31:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 02:30:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 02:30:51 -0700
Received: from localhost.localdomain (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 02:30:46 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.co>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] soc/tegra: fuse: Add function to register nvmem
Date:   Fri, 18 Aug 2023 15:00:24 +0530
Message-ID: <20230818093028.7807-3-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c52defb-38a2-4316-94e5-08db9fcdd852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMXrbx6c3KvNWEHM0RHbC/kNq8ld/TZ6Ff9JhjFcQWrPKzMyHYHTInn5s9hrAtJ4grnhUDJHlxMG4ggbysDLC268LIzc5PMXJMsq740TViAlpogGlclvYpsZTMa2XXgonYNV+VUUvrdPSm5CbVJ+QQrSDvdBRIpOusA2JDq5pNVyjYegm227CpnwEvfFnzl5ra2JXxrro+dMCbY7xpFomehaCxe3HIwr4qNCTZC8zMzKqpy47ccV6okW/oDTt/q78kGqfV+NuEhoCSlQi0tck/sAK/p+kRfh89LdXnaBPZZJtfgS/mlzX4cnVe7INmqiQSQc6KFqB6Ig1s0Vd5KjiysFa0ErXaEEjYs/1+QN0hysjR7sN3RKfoT5OktgBcYYvSjxpjd8X4h5TrBlaVCQiRQrXVyEk4ystuzTZR0b8BauiE8houvmxvESNvpwxIpMy11N8mQhw5D9rYTMw8hiZzhlBijdUhq1qpPsgwbrfCwJGbFVaXNtN4QU66x7oQ32mAceZC+TlgoOI+NYCIxVW8+kkyIRWI9t6t3sFR0mS6L7t6+OBb31vdk5ABMzBl+xyzRvXxvLDlZEZtP1gw031puBkJwrCqShDA+I8Y3QsReexi58rJVnOe6fTp5HZ6hmEI2ExDvTeft7hZUfqv3610upkykeDGrlGl81Gj39R79DogtHnpw5yx69mFrSa7vKfus8FrPbBaeIGuFzjDUZcgSqhBnFwqMkWxcXI9ExayHy3PWvEGnz+n8crYFLENFPup0EAAUu1lkN8rpiQ71eKA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(110136005)(70586007)(70206006)(5660300002)(2616005)(41300700001)(2906002)(316002)(7416002)(8676002)(8936002)(478600001)(86362001)(40460700003)(6666004)(36860700001)(47076005)(82740400003)(921005)(356005)(7636003)(36756003)(336012)(426003)(83380400001)(1076003)(40480700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:31:04.8522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c52defb-38a2-4316-94e5-08db9fcdd852
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function tegra_fuse_nvmem_register() to register
Tegra Fuse nvmem and use it in tegra_fuse_probe(). So, this can be
shared between device-tree and ACPI probe, which is to be introduced
later.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 62 +++++++++++++++++------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index a2c28f493a75..45784ac6393d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -113,10 +113,44 @@ static void tegra_fuse_restore(void *base)
 	fuse->clk = NULL;
 }
 
+static int tegra_fuse_nvmem_register(struct tegra_fuse *fuse,
+				     struct device *dev)
+{
+	struct nvmem_config nvmem;
+	int err;
+
+	memset(&nvmem, 0, sizeof(nvmem));
+	nvmem.dev = dev;
+	nvmem.name = "fuse";
+	nvmem.id = -1;
+	nvmem.owner = THIS_MODULE;
+	nvmem.cells = fuse->soc->cells;
+	nvmem.ncells = fuse->soc->num_cells;
+	nvmem.keepout = fuse->soc->keepouts;
+	nvmem.nkeepout = fuse->soc->num_keepouts;
+	nvmem.type = NVMEM_TYPE_OTP;
+	nvmem.read_only = true;
+	nvmem.root_only = false;
+	nvmem.reg_read = tegra_fuse_read;
+	nvmem.size = fuse->soc->info->size;
+	nvmem.word_size = 4;
+	nvmem.stride = 4;
+	nvmem.priv = fuse;
+
+	fuse->nvmem = devm_nvmem_register(dev, &nvmem);
+	if (IS_ERR(fuse->nvmem)) {
+		err = PTR_ERR(fuse->nvmem);
+		dev_err(dev, "failed to register NVMEM device: %d\n",
+			err);
+		return err;
+	}
+
+	return 0;
+}
+
 static int tegra_fuse_probe(struct platform_device *pdev)
 {
 	void __iomem *base = fuse->base;
-	struct nvmem_config nvmem;
 	struct resource *res;
 	int err;
 
@@ -152,31 +186,9 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	memset(&nvmem, 0, sizeof(nvmem));
-	nvmem.dev = &pdev->dev;
-	nvmem.name = "fuse";
-	nvmem.id = -1;
-	nvmem.owner = THIS_MODULE;
-	nvmem.cells = fuse->soc->cells;
-	nvmem.ncells = fuse->soc->num_cells;
-	nvmem.keepout = fuse->soc->keepouts;
-	nvmem.nkeepout = fuse->soc->num_keepouts;
-	nvmem.type = NVMEM_TYPE_OTP;
-	nvmem.read_only = true;
-	nvmem.root_only = false;
-	nvmem.reg_read = tegra_fuse_read;
-	nvmem.size = fuse->soc->info->size;
-	nvmem.word_size = 4;
-	nvmem.stride = 4;
-	nvmem.priv = fuse;
-
-	fuse->nvmem = devm_nvmem_register(&pdev->dev, &nvmem);
-	if (IS_ERR(fuse->nvmem)) {
-		err = PTR_ERR(fuse->nvmem);
-		dev_err(&pdev->dev, "failed to register NVMEM device: %d\n",
-			err);
+	err = tegra_fuse_nvmem_register(fuse, &pdev->dev);
+	if (err)
 		return err;
-	}
 
 	fuse->rst = devm_reset_control_get_optional(&pdev->dev, "fuse");
 	if (IS_ERR(fuse->rst)) {
-- 
2.34.1

