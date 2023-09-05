Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD417792D20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbjIESK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbjIESKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:10:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1897658B8F;
        Tue,  5 Sep 2023 09:55:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6DWgo5+Hbj4xXpH9CcUdKMgUYqfbYfSHqHHfcrN91NKepVlzl2xs+8oNyGEjw4HIiAP4b1lQcx2nXLa7A8O07iDQ9Ajd4k8cHN6oXJ6I+VJdqewNlix1zfeGj3XoeN1IH46kRyCLruGNW2KI5V4U4p8c3GVv7h0aat+9U1+U9GYGzp/rllJbT6/YJ5jZxU4wV9fDjZG1QehUh+wsqBm5zEg+5l6FmmJ9W8rXtHbXafX+SB9tNwo/hmDXWQDSfjHlHP+w9ork3skEUaQohK5XIQM8kvInhGtd2GxGVtTz5Mep1QGM+FLbOBRNkdYk1DGtbwvi8JTo63A+wiiRCLd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROiLYAaVHUrGDrfxs8Pd0CG5e2N46o408depLf6ybhM=;
 b=kaARNbt7I70THjY1pBES7Sxu2cz5A+oRp/uDtKNXfDqBtjXmKpCGIUw5u5e+PvugoqUdUKeeQuT6jYuSUO0MON5ghdSpcmLmmQfCWkNqSr8vjtYOnQxwqqNX0LUEQ8EJC7Hj98xiO4G5m57BTFJRlQPY5AyF6fmYRtSbYqDqz7yxkEZE5IOA5DfGbrvFjLfMbG4OPtEJ7Y3MQIjU2JQfr1FFgCRW9QPwh4kncVaktM7Q604aNbrBKq6KKTxVc76pOWDzuUXkJV/HW+auWASBNpijaHEbsjuukagK+/zWHGgzl4fM62dnAceGCmqkgONmhb7JZEcvKbIiFGtaGeiGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROiLYAaVHUrGDrfxs8Pd0CG5e2N46o408depLf6ybhM=;
 b=quQkyBYw+HvFVB2J8X9NIECuqk3LC5412Eoc8UTuSj6keUhz3htQ39k+nBok1lTqVyrcrlwAcwr0aRqti76o1cnjYugP5PEBg1luRCNrPn50j1CEQvK0Xj3ndibXGdB/Bd/cgMnsKIsCKv9NkS9vBpP0EqK3DA9bkOqngUwnWqyRtOFpnetdMtA1OFnPoE4a0BpplvZhJDgNrTWjkw0/nVb+ZQEMJ3B5WFMPkezYY0Fq9niigUiPQSdV3VxPJkmhCwnpRRfOJ4k7M/W6j6a6k6V5xrGfntDqSR47tErv5ncXF2kpxt05eBkaUbkh4EvJMPSGslA8DegKOB+Tx3NmEA==
Received: from PR3P195CA0027.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::32)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:37:02 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10a6:102:b6:cafe::89) by PR3P195CA0027.outlook.office365.com
 (2603:10a6:102:b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 16:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 16:37:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 09:36:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 09:36:31 -0700
Received: from localhost.localdomain (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 09:36:26 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] soc/tegra: fuse: Add function to add lookups
Date:   Tue, 5 Sep 2023 18:28:21 +0530
Message-ID: <20230905125824.2947-4-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: cc39bec0-7b58-4129-96c1-08dbae2e541c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5p84VrVnOCRIlkDIhE6Ex1KXz1qYl44GMAjcheKMZYj5eLxHXjtCy3tqW0iyzydpRhFZrMunwGjKjU8hoDYtnGgA7KczuOV9VFaOMKxzZVx8PsnDxFEnULEMH0VR+4Ezbl6wp2FqCKwAn3PrhLxR7EiOMt2Gh0uS1aLwA8aRyqnBmUdXf0MHE4pLlN1m592RfU6iRQ73g/zUIb3kNY8uNcT97bQfVLhrcUrFTuMicgJahQzWcEAafTgPsPVuaAppKG+SXsGENc/MJwDT3GQWy7RQ2w69s3nrTZsSGe08o9wtlACv5mYDLOaLkvo8bACpOQebdWNKM7IejMBecl7wWJoAR1WdRuxt1UHd46a2USHfpYbool8F/MD0Ycp50OusxZsp1Zr/F0fFLKakGL3vxt9dxIqs1i40jnflIDlT4e8z8BHkMZ+5yAoHE4A0N954knq855PX7TaUuNvLn6L/CfreJLDfaimlOCcgmwAYhgDgFP1KmVfC/RC/bTPY0R3cMEId3YXMSIjhGLLEiHow9Z3cFT9DDctZkIhipUQ1M9OEynItnlvJoU6SlhSdMiFMCrY2Ovf5OmKvw2zFnQTrYQECD3XTBqQ00aJxbfTa8SlVrnOW1H8h3JRA1gzPhM9wMQPX6erHWbP0fzHEfyA688yfBrUP107oxkDtdz0sm9YtujdNu0MQ708equApLaGoS9YqCoPNklbpxmnioBJIiYiLSyWXPNHo2tktLrJAQ/gfNX1SU4Wp+Mm96SuEn9zadCMkto6mU4zhoBL9o5Z+w==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(110136005)(41300700001)(70586007)(70206006)(36860700001)(2616005)(26005)(1076003)(6666004)(478600001)(356005)(316002)(82740400003)(921005)(7636003)(8676002)(5660300002)(8936002)(47076005)(86362001)(426003)(2906002)(336012)(83380400001)(36756003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:37:00.4383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc39bec0-7b58-4129-96c1-08dbae2e541c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function tegra_fuse_add_lookups() to register Tegra fuse
nvmem lookups. So, this can be shared between tegra_fuse_init() and
ACPI probe, which is to be introduced later.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index a2c28f493a75..821bb485ec45 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -113,6 +113,24 @@ static void tegra_fuse_restore(void *base)
 	fuse->clk = NULL;
 }
 
+static int tegra_fuse_add_lookups(struct tegra_fuse *fuse)
+{
+	size_t size;
+
+	if (!fuse->soc->lookups)
+		return 0;
+
+	size = size_mul(sizeof(*fuse->lookups), fuse->soc->num_lookups);
+
+	fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
+	if (!fuse->lookups)
+		return -ENOMEM;
+
+	nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
+
+	return 0;
+}
+
 static int tegra_fuse_probe(struct platform_device *pdev)
 {
 	void __iomem *base = fuse->base;
@@ -407,6 +425,7 @@ static int __init tegra_init_fuse(void)
 	const struct of_device_id *match;
 	struct device_node *np;
 	struct resource regs;
+	int err;
 
 	tegra_init_apbmisc();
 
@@ -504,12 +523,10 @@ static int __init tegra_init_fuse(void)
 	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
 		 tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
 
-	if (fuse->soc->lookups) {
-		size_t size = sizeof(*fuse->lookups) * fuse->soc->num_lookups;
-
-		fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
-		if (fuse->lookups)
-			nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
+	err = tegra_fuse_add_lookups(fuse);
+	if (err) {
+		pr_err("failed to add FUSE lookups\n");
+		return err;
 	}
 
 	return 0;
-- 
2.34.1

