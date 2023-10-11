Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1702A7C5170
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346135AbjJKLRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjJKLRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:17:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A149B0;
        Wed, 11 Oct 2023 04:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A15J5edtV39g/zg2UvX3slzS0aPXrE9NhAcaPM5zTRQewiIswKcF84pZGGi2AQLQMCldnh3sQrODwhL/gtQNz+E+uYxzf6heEBiA9/7GB7fINyIEw3KSdcjS7crGliX5AQxbEVDz0MOMN5Sk78AnX6Zf3M9WAeXatKm4np5BdrIJnGGlVsOll2kqfdRLlA/1Z/qNf8GWpBUkk2GZR8FXlpowhJo6VdZLhbrJXrWVhZW9+btPfN2K09eoMwY8IIr6zij23uVAOcA60U4A6uNEo8oi8SHe0qADjSARZnIcszUbU2SLvhUVZ4Q8iRfMzzOP7x1zs58k0R98a9v34ps7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAxNN1B8Aq1rvOj2d6rD47BDQcgdbvf1bV0VdIQGpLo=;
 b=Y1ApsIpVnNjZs1zPfLvVr9AYPdP1IMf7XkUGGKaB4dSeP6pm6LM0RE3FJ+/q3uvep56dxuRNto0gA5Qei4iVxbzumeG6QmHTk3xkSbpjdHrj8xd3IJV/btA4bPYPi1yX/DjBH1C/jRcR8kjqsn0S09IBBhyLUn/D/0RLqkxpFvoGBMkeq1wW9Ixrfxj4cgYtUWhslqoxmVa3i7OLQfc/myN0xgPFGPHnUVbYClYyTh2uKX0jUfJ0XGcqZei3lMGsUl05930X4G9JTt3bTlXVPmjLkROMJMfB5lWDcdc39J+ttI/BF1qNb+pFTg0VbYKwOYClj216QPq+WPNJUVzmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAxNN1B8Aq1rvOj2d6rD47BDQcgdbvf1bV0VdIQGpLo=;
 b=JNUyNRhq5UVrSdtW3SJ6kpNs06kjQkchI/uTWs+UxYxtAVS0a40Mf5oa2pNQSasUVXVSEL43x641wWBcIeaWnLnJAjaFpRyWYAI91oPN7tXyu1EuFEH49YXcCSlnANxSwMqJ6uErMmi423k+phHIVGDgo9Xsvpx6MtbCvIjghVBvlRRDhWDpYBaNIMUHbGb729od57SruUJpcA92QSoQGjzGx0BmuyeIVHaOlBA93fsZqiNTjMdaAGYhzPLBLlr5+LiWL0sz0R9ggAHP0TehF8UArHZDvpr1VLwINf5YVCuBN4wMSLALhxASrePTtez2CuhmNUx33r/ZbEgZaVA95Q==
Received: from DS7PR05CA0094.namprd05.prod.outlook.com (2603:10b6:8:56::11) by
 PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 11:17:11 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::9e) by DS7PR05CA0094.outlook.office365.com
 (2603:10b6:8:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Wed, 11 Oct 2023 11:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:17:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:16:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:16:58 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:16:52 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <petlozup@nvidia.com>, <pshete@nvidia.com>, <kkartik@nvidia.com>,
        <ulf.hansson@linaro.org>, <frank.li@vivo.com>, <robh@kernel.org>,
        <stefank@nvidia.com>, <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 2/8] soc/tegra: fuse: Use dev_err_probe for probe failures
Date:   Wed, 11 Oct 2023 15:04:06 +0530
Message-ID: <20231011093412.7994-3-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: c8330e9a-3b30-4c8a-4b19-08dbca4b9d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1D9XXqEEDjzDVH8NlzOLxpkWwoN/gnjGsdg5L3hhwdoRYoNfLWJppWPg08zVZ42Kdjvd+LpETi30t3wQV08MGKoyMZWn475qU4kzF+NeKDyiMFlb2/beDqmJBnEn1y+DtCmoN+tfOhL3j9w/oePTAmxCM6/wO1Xdu52U2uGfMMVtOUCtOjD6k8isp+czPolU0nszAtSlQDJFBdqdhyZpYddePQ3yBwNW+zpDI6sh2+3N+psef9+pjwAj0wOmfj7cGhYgexrytxBnLBHA+vDl42nLaTGtsBVYZJ7mUl/IWC0OXjGwNpmwTLErn0XjS1KMR8FXqienkGlSruuQ1uD7fgXdPAvVB8GSfrB1Rc6JM9gITynZQJsRNTpPnXEcEHVL4T3jWh9owr7tGxLH0Nl172z6RjT4dHft8BiXzBogdVVwAQ8qtZ/5NDkkNnsVfY9oGAc/yON7gJOlHVW30XPuXP2lnjawnllNtv+GITWwhdhYrAuaFMnAm9TmWf1TJk6NDcUqFCnTYbmfbxXnlV2F3Lwmrv0d9qToXHp5N9JBN51JOavijSoGOmC6h4P0t0q3a9KqFTugYKYqgy4x0h81L4q5TTKIvXrd0JC9+FPGz4VaOo6FCk/Ze6Fw4q5c5gMFBzb82C89XCFN44cA3xdxjdZ4zZ7Uq7j0FEIMnhcfD1UN3FM9CNErZqP97sYthqk5wtgLL7YCy2gAK+Lsq7bvy4g7eK/OK/wdcKK9XR1VsyOpWIqk3bV6l3I9Nt8lLOm7eMI8suVqhpNOxNEGhv2QvzOipA+ojzqIPyaZ+RiN8E=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(26005)(426003)(336012)(1076003)(83380400001)(2616005)(6666004)(47076005)(478600001)(40480700001)(8936002)(8676002)(36756003)(5660300002)(41300700001)(921005)(82740400003)(7636003)(356005)(86362001)(2906002)(36860700001)(40460700003)(7416002)(110136005)(70586007)(316002)(70206006)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:17:11.2767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8330e9a-3b30-4c8a-4b19-08dbca4b9d5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in tegra_fuse_probe() if clock/reset get fails, then the
driver prints an error if the error is not caused by -EPROBE_DEFER.
This can be improved by using dev_err_probe() instead.

So, return dev_err_probe() if clock/reset get fails.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index a2c28f493a75..98805885158e 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -131,13 +131,8 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	fuse->phys = res->start;
 
 	fuse->clk = devm_clk_get(&pdev->dev, "fuse");
-	if (IS_ERR(fuse->clk)) {
-		if (PTR_ERR(fuse->clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get FUSE clock: %ld",
-				PTR_ERR(fuse->clk));
-
-		return PTR_ERR(fuse->clk);
-	}
+	if (IS_ERR(fuse->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->clk), "failed to get FUSE clock\n");
 
 	platform_set_drvdata(pdev, fuse);
 	fuse->dev = &pdev->dev;
@@ -179,12 +174,8 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	}
 
 	fuse->rst = devm_reset_control_get_optional(&pdev->dev, "fuse");
-	if (IS_ERR(fuse->rst)) {
-		err = PTR_ERR(fuse->rst);
-		dev_err(&pdev->dev, "failed to get FUSE reset: %pe\n",
-			fuse->rst);
-		return err;
-	}
+	if (IS_ERR(fuse->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->rst), "failed to get FUSE reset\n");
 
 	/*
 	 * FUSE clock is enabled at a boot time, hence this resume/suspend
-- 
2.34.1

