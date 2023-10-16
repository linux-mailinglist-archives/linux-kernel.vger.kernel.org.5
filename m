Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1037C9EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjJPFf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjJPFfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:35:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAD1138;
        Sun, 15 Oct 2023 22:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYm+dGOAYcvPlvd6vegUM/CgjYb130iNqQw74i1931GNSXbdhQn5YJG79ZaCx+in8jeFrzHvQ9IUveB/RBWSPzoMJrQsw4vPRqrVx77AgmP1djuly/OZ//JhzkPjoOvPCCwsHhfqgQJYg4b0VwkB50ff98omh/w2r1lty5i3ureQAvtxSKvdmDm87auM5GUxWWean+GZs9YB79Tz9/MOSrvtMyXpjy5QZREnuL73k77Qk2vpTVrOHXVCCvH2cFaNvrh3+v2yu8QFoh8cuNcknOUAAnPxqLC+JW4oYYnEUQz0WD2cvMSOPEjvviHKKJ+Hnrh8K+vSetnnsvifoXT7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELKSSmXMLGbNFUFnL8TV/EvgiM4XWsEshppFSZUpBQE=;
 b=EaY4hoJdHbtVxNsIdV09KMafEmZQp/LAmqJSEle2hr2ftF8dbbwJP4rloQkqTD2PYEuSCsx/RR6ZjqJE0LOaAcuJiJC+OoRTn3pglzVbG+uB9MvmohAr4RJdimgivNuX1o6LVLE7fAEXmxXsdne4842G7oZMTG/kSph3+1mRWCiXOYhU/5Jr/qzhN59Vd4Ba2aZfMCYDV7Mf0J19xXxKVLvor5SCvhUvYLjsbfigdHG4Eg4mswPo/bV86hMZI4Qdu4ExWu2UbV8EfuGy03LEiMMepH+VwTJwTSCpEKifEJZT33lqK2CeF8+fT5AnpzevpUkbzU0kvQC/Ap9G9ydSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELKSSmXMLGbNFUFnL8TV/EvgiM4XWsEshppFSZUpBQE=;
 b=BGsDk4dMKAbSoSpv1aAWheaTnKqKMYP6AXzUCKFOiYy9PEMf797H9r2qjjJ8XC9nRPlN8kSw8WHzgRZ2QOmrPJfsVIQC6oQG0xuB/r61CqJrDdoxUyr7R/E6bQ0pp6pSwaEEsoClcmUGn7YTsuymtVc0QFhsh6PqVH4BpKryXBsoGI975Ram6UtdMYVPI90pTl6wZ1hy1uH2F/xcoqUUQAE1UMQOrXvJxQ6jYMKyXCehnrVlhsWRc+McczYRvYkhgxVDn1bilJpypS0/RGZKTbSr7giXzUBSj/X3YToIa00+EBGFIHA2WgbLCCaMnOHPSCTDHk5A47fm8EJc8g6+eA==
Received: from DM6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:5:1b3::47)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 05:35:06 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::11) by DM6PR17CA0034.outlook.office365.com
 (2603:10b6:5:1b3::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 05:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:35:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 22:34:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 15 Oct 2023 22:34:54 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 15 Oct 2023 22:34:49 -0700
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
Subject: [PATCH v5 6/8] soc/tegra: fuse: Add function to print SKU info
Date:   Mon, 16 Oct 2023 11:04:09 +0530
Message-ID: <20231016053411.3380-7-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016053411.3380-1-kkartik@nvidia.com>
References: <20231016053411.3380-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6025d3-7c4b-4a1f-b61e-08dbce09a7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +m2Ph9orPCiC93IPmA8nMcpflSWuAYGLzxcJOuvI3VEmVsoCGIUKYheYORx0hWzIB6jyHhJ2sfQji+N0hasGzPCnhmSn1K5jxCHU0km6ma2OEHfVVCBZjM1T32Th0HELvg1ZVFDsM0H7UoXvEdD762q3ra0gYKM0MYDp5kAcAHbsnW3iMPBzJeY8tyldFnnDGwlklI42Xrx0cJAr9Q8nNmLber4oEDRRRe4Zov12Udp0DrKseQmDJfLg3QCZYkim7Vp9b4WsWBRJ1BScjaCeBw3bV1A1o8KFXv87GN0CJ1JJZke49lYDWtnNCV1IWupE6/38IKa3NdAptJ8qmX0aZ88TUI62ft4fjO6ZBWz2L0EG0DcFojkZ/WRjh9dDGfPlAsR5d1PJdSZ3PfMLiJBlBArNEhPd/rioatB8Gz0taic4EWZ+5H3sVuFRaj4cLx5XucTGurwVQvU1OxQubBtL/B+wkq/0aMuzyuKcFS7zHywipA4B4HmbdguTY7rumjbcgrrNPeDW6aRurLj2DNSxy3wamKN62bTrJGi/HdheYbMDy9QGWdNjUMQqHaZ7aRF1NBZLhia1OrFlLNGGLOMhelZ0M93/ICcsmvUP06CLkdMMeJG83Uqthb7EsdUVHMG/aBdLuHw5nmVjBOrLJMzv086x4Q2MfV2aueDXBd2t+HIsp8oogEG7eu7cSIg0lsV53CxBYjUkMQGNPan/qZ0UTEYHOIfyixX1AiGJmj0k+jKk91oU6VKa7xFWpGVra3TsSxr7d8vg+zY8JefB9BKMJ6ldr1RLAJHRNlHSuj23GUA=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(478600001)(6666004)(110136005)(36860700001)(47076005)(82740400003)(36756003)(86362001)(921005)(7636003)(356005)(7416002)(2906002)(2616005)(426003)(336012)(26005)(1076003)(41300700001)(83380400001)(316002)(5660300002)(70206006)(8676002)(70586007)(8936002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:35:06.5316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6025d3-7c4b-4a1f-b61e-08dbce09a7b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function tegra_fuse_print_sku_info() to print Tegra SKU
information. So, it can be shared between tegra_fuse_init() and
ACPI probe which is to be introduced later.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v1 -> v2:
	* Renamed tegra_fuse_pr_sku_info() as
	  tegra_fuse_print_sku_info().
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index c91194612a9a..9bab758a60f2 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -113,6 +113,16 @@ static void tegra_fuse_restore(void *base)
 	fuse->clk = NULL;
 }
 
+static void tegra_fuse_print_sku_info(struct tegra_sku_info *tegra_sku_info)
+{
+	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d SoC Process: %d\n",
+		tegra_revision_name[tegra_sku_info->revision],
+		tegra_sku_info->sku_id, tegra_sku_info->cpu_process_id,
+		tegra_sku_info->soc_process_id);
+	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
+		tegra_sku_info->cpu_speedo_id, tegra_sku_info->soc_speedo_id);
+}
+
 static int tegra_fuse_add_lookups(struct tegra_fuse *fuse)
 {
 	fuse->lookups = kmemdup_array(fuse->soc->lookups, sizeof(*fuse->lookups),
@@ -501,12 +511,7 @@ static int __init tegra_init_fuse(void)
 
 	fuse->soc->init(fuse);
 
-	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d SoC Process: %d\n",
-		tegra_revision_name[tegra_sku_info.revision],
-		tegra_sku_info.sku_id, tegra_sku_info.cpu_process_id,
-		tegra_sku_info.soc_process_id);
-	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
-		 tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
+	tegra_fuse_print_sku_info(&tegra_sku_info);
 
 	err = tegra_fuse_add_lookups(fuse);
 	if (err)
-- 
2.34.1

