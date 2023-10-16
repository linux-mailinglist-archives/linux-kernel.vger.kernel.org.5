Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65DE7CA514
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjJPKQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjJPKPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:15:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A951C123;
        Mon, 16 Oct 2023 03:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNImDBtYW+aExC4B48HYeJrW2rSAEJod++pVHNFCmbkQsqyHxMVzuFd69GjkZcwU/jL6Tmp5/95LpJLJHLw5hiAtUFjycW5zopvGcN8lxm3NIe95i4+Y9/c+U3Dhs8Tc2vesW/sCpUK0jKMgOtAa041sts9591tRP0e0zh3QKqYd5X2pBlpOjeltvSpOCRO6QOefJKnw/bZguKaQZAf2xVEGrRnGUIUEAeoclQzJLjHj4+MfhsTnYDH6D2CB2cyDNUAxvxhQcDtTyJGXjbRYb222fCjIZ109UcNG/ogqQw4daeTUVAqgjE1vfVuAPn7J+Wsn7Jg6VAMOxJ/Y4lhC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Boe9hAUW3Y1DekcyUmXJ4mkqskHoBpTocROHHjVt0YM=;
 b=etuZbUc6tiIlcq6D7uygKutbsrJkaeHX0AKfTzSjaXpzN6dxa2CtQymow+cY2j+cSiwkdQ6midlTIqcUJAJgszivHWTUDszOCus0NyMBSevoBx6Ed1KOWgzFLsg+iIyhnGd0N7hWKRYhbYXjEmbi5AN2uSRPI69lwaSvR2/3xHt7Pr/bMuuXqswIxKZIpunwHkEVsnVxiswlYweKa4ExSKLgvbOkPxsFYaUwTkfz4iaB9quoM8CTZoIKFZJuU/xpPJacLJTGheObg2iLWYnMaufWNOGIX+2WDuL6vV2+Spx+fWOWNLKAXIiHj0OuyKt2BqqoKcwYrtbcp04YcnILwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Boe9hAUW3Y1DekcyUmXJ4mkqskHoBpTocROHHjVt0YM=;
 b=lNRne9lUlD9wSr3q+JRP7qYMxy+tOen3kxVPqB30ko4mvC/UGMoyePJghUtwHzF2lykT7TePFjEntmYFfPl9Hk3cAgKZ8lK9ydQNWW+qkHCDNCP5TZzJ6lwWqcliVIqKIcl8fnjZZO7omWKqukCWEik2AW5Q3ez1gOv4EcJzckG/2uEVzfKSIMp9WdGsDXrMsujZMplcRfvoWeF2G/ut3c3lGuQX42LPayQx5m0sgj5NnaW/VswcEFMbJIU9qRhfVf4dU+Fo0oFIJsjxSUsu2PzS+6TU9g37juig1n7+CG5Ujv3cy0QzaXW2hx6s3iBFw5qtlUIA735S5rNr1pg7GQ==
Received: from SA9PR10CA0028.namprd10.prod.outlook.com (2603:10b6:806:a7::33)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 10:15:41 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::d) by SA9PR10CA0028.outlook.office365.com
 (2603:10b6:806:a7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:15:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:24 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:23 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 03:15:18 -0700
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
Subject: [PATCH v6 6/8] soc/tegra: fuse: Add function to print SKU info
Date:   Mon, 16 Oct 2023 15:44:34 +0530
Message-ID: <20231016101436.7146-7-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: c2730010-b993-46d1-eb60-08dbce30d9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vyj5hgZUNf/Gu0aqe+M9bZUgr6TeK6JZ8STXp2Jez0/rk+nr2RRQ5+i0WDlLdPgzu11g4UCcBlGgIYL7NXTLih0jhv/LRiki3RcAg1oeEF7NgahH3E+Lii7U/yx9ew1ku+ISSVZRqcq8L/ttka57uJilAFeSVxIGkUYVe4lUrwZxb6/+zoe1AvNbaZkuKbo7FBquvk97rNcGtRoUzUWfVfsupmkM0jLf4TibJubQaPKJ14Tgmhl46McHpvKy9O2ifLS1vuC9yqTM4MiDl1a6+d+B8xOl63Xyv2LKa1LDmYcgQuTIFmhHQ57AHyO9GGD5uWgv1LfRKewglTaJdgpdrCwYyNM4VO3uLiMqqXXdFWVU0ZlSF/suRM7QE3k6tR6DNJ3t7bBysdCvVLHas1qv8n4Q+gjwksEwiwGR3qSrQks/p4glm8vlLjmdRgGI6Sg6BQDz1W/Np0qKzdw/drj2Pn8AtUvOSyR1xBq7861YitFGN1jZ4KikVNND5hY+iDFfHi/DsR6NsB5lTvZf/4150lVdWO7dPlsSjo+32Hwk6nL5i2Bp7mYMpovL3S0L3LUqaHmuW9Qu0MsPW28Rk9WZ1AQoEIt+gwDIhnfaJj9ORgTrjpa8IZ+ep0ylQBe1g5pzQJq02NgBO57r/vJ6h44A8Ux+tkSvtUF1laJ3j8IyzH5GzR0bfXH/h3XAjGv3kGM8upYHaoPeOq+hr6CM5lQO9kug/LUrX+2WuSJGspTKQIoDTNvM9qsm66rfRFchdVVsgcVvMhxNnZn0quNqqAx6QYeU4AdsmUqGMy6PtopbiAg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(7416002)(41300700001)(478600001)(8676002)(8936002)(110136005)(70206006)(70586007)(316002)(5660300002)(40480700001)(36860700001)(47076005)(921005)(7636003)(356005)(86362001)(82740400003)(2616005)(26005)(36756003)(336012)(426003)(83380400001)(6666004)(40460700003)(2906002)(1076003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:15:40.7431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2730010-b993-46d1-eb60-08dbce30d9af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
index 4ebb5597a77b..7a93c6512f7b 100644
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

