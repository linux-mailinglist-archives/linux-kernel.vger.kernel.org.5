Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC27CBA00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjJQFYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjJQFYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:24:04 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A6124;
        Mon, 16 Oct 2023 22:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnXRQjD/iJFaxDNy1IcgwswGiqe7krcaRvNdAnrcc6FahToiZNCAr7pOf5Xvm77wBP5IKHreNHh1we2qs640MJF3vW1YV0sa5horI4n9/iB3pt0ZgSz/JoiQDMv80H8BckvoBW4Yll9Itnc0+DMtTvhz40z521Z5Zn6iatAIwj1W/4dMWSbzyzQRCFEjqOI6nqc8aSBi+d3S29KeYnlaI/tbmjDRS01VT7vk4n4COCJPL5b//2GF20iKiSqmMhhBAxQjXix4occiBvvuOuVYjPfFyECHBZe+qsmR3y9i5OXON89TXjrDT5tfmp4McW3+x2V4tOhuhymDVtzgAXFAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAxNN1B8Aq1rvOj2d6rD47BDQcgdbvf1bV0VdIQGpLo=;
 b=ErPwMVFa48kycsnE/MRrX5fNi7sHNBB0pAbqxjwW++On3Vt5j2rKgZfMK2hhG3226MTIOrJeIU/fYOB5guAigTPeF9rQim4zCOTYufBVX6kjE8cle42d2mJYKJlaMF7uKRpv1tc7Ca47iSnzo5EtPv4aeEKszrXvcSqFkunbzLaX/B+emTQGsKTOB+hdE4ITPC630Bob/xYIlk2KQBvWN7ewGj9i4r1aVWiDsxfQkt9q0oSLFH0VptB7AiSsYEulxhiQj3FEr6e75DvJYfh3ZfJgzjwEgVevLv/vcHgqUcMQf8amJFysV3T4vjowEiHaROkA9/0Xofv8v943AVtsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAxNN1B8Aq1rvOj2d6rD47BDQcgdbvf1bV0VdIQGpLo=;
 b=GDNjgi/EaynN+uyjOk+YzH5Pn9nb88XD0SAeaf2z+e2pjp71mMhRSPGtrS/Vjs8nJ8ygBo3TKw6dyc7dWCfRURUViRyTXkZjCgtEb87WoFslVM85QttPwVVccasU++xIsBYqZtWe0QNzR8VQqODR3q9KkTVRoz2nqZ7EyZxclicvLCPuVBncvhRfah7ZcCgbonypwhKYZfhFiVTrAXt4W6qVfHebmbn/1cvwY2X/9JdwK3mOXE9c1yO8uRqX0+78KLj+AT5u1r2txnn7CsK/zCMCHjZYvFBytfQYGvOqZdaIgf3TPdm28ukwsYEq33uFXrGoghQlG67SK75ByE3yDA==
Received: from BLAPR03CA0088.namprd03.prod.outlook.com (2603:10b6:208:329::33)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 05:23:58 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::4f) by BLAPR03CA0088.outlook.office365.com
 (2603:10b6:208:329::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 05:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 05:23:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:23:44 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:23:44 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 22:23:39 -0700
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
Subject: [PATCH v7 2/8] soc/tegra: fuse: Use dev_err_probe for probe failures
Date:   Tue, 17 Oct 2023 10:53:16 +0530
Message-ID: <20231017052322.2636-3-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: dd115096-4825-424c-7197-08dbced14392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALzXqaJ7/YUxyog8aqnMhBjAcsip5IqPcS8dfyngeRtxfsDSLh5VanYSmhy1e3jcEXbb7lalJcSEjxbl8SEvy0umSSN5yTyZuwrjGwnrhqhliSP2orrk5AnWv4YSUjQ/ac+D3EKZK0bVsQVvDMLGeAVLz0AfrYmQHC060qucNK5CQ0ZqTmZ93TXKfsB6gRQ+brEfe3GXJ94GqXdRbAHYaCxDP/hPnPPjBM6GinPYUKG0Lu+pYncfIqWNBoIt78CYqqyZS1ffAnqzhBQdXupYCozZ760ioJX+6uFo6G+sb+aU/aXmqAgjwjRL6lnDkmqzkePqUiOh8ddUJ9nCefsgnjRxFkOH1etlaJamEXrcIiuc9FfXjjp8Pui3DhRTRU2ZGNJ7vAkJlFzNn4X/KZoI6AoO6zB1U5H5uISnsXuWT2N0Pi1lhJvxUUFN+bQC0L+4SMp0iwc79gBh8zZZ+EvCBYBdMb4hqe1vYarbUiDChZOTLh0XNUiuBLiePUr1I2KkK6XEcYMXx8kGldL3fepzMuMjODDyeaDwVECeTjfA9Yi25tIv5piER4d7EWwpTC2Ndb4OC1efSSD5SJ3IjVOJPw75akGRsaHbcAb8zLFN6/zyLhHWxloUzESue2+3ky+9l7K1htumZmUIshkGl+3ChQ/9lNRbAeRwuPkaEiYe3VQjCjJC4Ixv6bImhrGUNn+EAEsczGoQiOush70Mv957CUdE0UE67FiO0MlC/jQPuF6FjS23x34DDSTMFOFr2S5iouOcUXeWPqvwmwg7SfWEQTm4SX2uIwGpuMD17bJMDtE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(36756003)(40460700003)(110136005)(316002)(70586007)(70206006)(86362001)(82740400003)(7636003)(921005)(356005)(36860700001)(83380400001)(426003)(336012)(26005)(1076003)(2616005)(6666004)(8936002)(2906002)(478600001)(41300700001)(7416002)(47076005)(5660300002)(8676002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:23:57.8339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd115096-4825-424c-7197-08dbced14392
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

