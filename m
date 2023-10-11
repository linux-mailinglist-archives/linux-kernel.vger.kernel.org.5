Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA787C5178
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbjJKLRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjJKLRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:17:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEBFD8;
        Wed, 11 Oct 2023 04:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNUBbXf2wkeiyjWPo5FlfgddwRFwn1uqRYRM9I+rf/53QosfycIbQZd8eQQEWY1Vj86y6Q82CBOtZydA63JgRq+qjO2E1BxjSeWvKd4uMSS4S50pKgHAbE4Bm0usVfDrAJxfLeugZ3NKHDfe3pB1pWn6zWjdrbAK1NKTeIMKnLyr7ftcsaP9n45XepnBSa3lyYMOImVIImM2QOcMpfr25dTAwHbSf7Bl1hY3o0iTza5E3quuszXU/MvroG5nSeFjU/lXM2TENKnvH5cn+by77s2dIKOmx6zt5wuOl7vEjmJHdV48yLYjK5Ntucra4Qp+l6iw9DqCjAP8r/QMq5su5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlaNkyQtsx9cx4kudwhzEKqtEz9OQ7zyAYec9tu4C0U=;
 b=BX9d6CRzewdKgBQkmPBM09ZaYuArIuhdtQIrXvpCoin4igOr7hvBX6doq0oC9aPNkktj6k42bociPNQW7+OMNQU+hNgxIcLb13xu0c12KmckdCiKdvfebhFPi8/1gqSSMzuDfdbnRphXCbZBr2OmYL4soy3EdP+0ME8RReP8AoP9CT4r1Ngsmj7/VEzGWcCqueJchMNyvVyaBHYmECWB86gZU642yC9ZfSXVG6LlPwNcILDYcPJJczH030IIoLUF/S9Qo7J3LxtbwWKMyWr+IpYQR2dRwIN7rhM35DWj7FZLZ+gfrAnGE2kLd7iUDdxbgUPCGjygih7I4X9a7aOVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlaNkyQtsx9cx4kudwhzEKqtEz9OQ7zyAYec9tu4C0U=;
 b=CoHlvqlHphJVfVF69EQUOHnm2qfyIMZnaWWkGyqWErZ3gXbCA3BrhoTTL/FufMFiRFDDFEbZqIXif7FQoE6aN5WOhUc+jVPxumjGSJ+Tc2xqmMR98vHj3GuQtOZtEBJS0oyRXCWE8pD4P9yRA7t5e/WVFzFqG6eSQ1bpdOCZhzmqWkjZZ/JSK1SNtMx6+9cc4fNGSnMTqF6hyeh9yfevoR41fppK33PfSwvcG7QTDwhAlwmP7ovlqRgWWM88atvGnRF1g6T1ok0KeV5/OGw+64v3A/dPlGOgqFk0YiIKbr+FkiUpGLMf0QV9A5AnGrWPhLxD+nokDxWjSRQBrJ5Ujw==
Received: from DM6PR12CA0017.namprd12.prod.outlook.com (2603:10b6:5:1c0::30)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 11:17:38 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::7b) by DM6PR12CA0017.outlook.office365.com
 (2603:10b6:5:1c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Wed, 11 Oct 2023 11:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:17:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:25 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:17:19 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <petlozup@nvidia.com>, <pshete@nvidia.com>, <kkartik@nvidia.com>,
        <ulf.hansson@linaro.org>, <frank.li@vivo.com>, <robh@kernel.org>,
        <stefank@nvidia.com>, <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 6/8] soc/tegra: fuse: Add function to print SKU info
Date:   Wed, 11 Oct 2023 15:04:10 +0530
Message-ID: <20231011093412.7994-7-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd8ef6a-eef2-497f-8465-08dbca4bad6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzKgAgL5nF4Wm5OSvGzcHkLP+MByMDbwG/BuOzk9H1kZdBobd4ViyBwaDkKaMw7n021IYSeHxXfBfUf9gIo0Hc705aLiubdVempOPVC65i8QV+wrncfgGfvJdMrOJ794n5BghVcIvAk2xV9nnC8rEEw3qwe3D9p1dMqLCPsNRYcdkGh+1xEXKAg2hPcJb3M8ZiX/O/6u27X8Dr8fehwIUeFevPUZgtUU8FG7GpYEdKWRy3sXSfYJAmqjqdvf8rBdTdUDfJu72MomvdiNqxIMsSnEpK2W/+pFj5k01GeWjlr6/EEP5gXQZdMyxNs7/Uw47MxcJZWT8CFhDSjwmBTtDbHdMbHG333ZXxji2/zr+rvu3Wzoogm8XzouYVN/11p/B7qBbBNiTdQXGolZpmGCoY9HWRszbfW8BkPVuOX6EFVgbRSus29bkgMs2YD9Cw6oXk/bZj4aSBS98m+HYsc777SWbufQcWjGVOzu/PIlMf2/JN8LuIJONWXn4lHqu7sRp4CLyTGsjfinjOL4kDSCCDgMWtYoJFt0qKVhJPGlN+M6j3s2tH8L1UcuhNTv/ZYT/WCTW5k9ZAFzGEemi2LxmzF4FiajM6Fx83A6xf80hs8fdG6dmWEntT2E98xOpaqS+LYBHrZShq2k/QMU7Q0lFbbKM4TYSaLHb9ky1BfL8cUwNbOwOSNvkRcuWlEiYnWPLRN6pWOhDy55YFXfpf6E9xTrXZAtjy/qf21ZgN5moKgEqX7iFTK/TF/crnT27wZDrkOA5Mwoejx2rEho4RjvD1Mzlle/vN1FToUA2A5b7I8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(82740400003)(7636003)(6666004)(921005)(478600001)(356005)(426003)(47076005)(36756003)(336012)(26005)(83380400001)(2906002)(86362001)(1076003)(2616005)(40480700001)(5660300002)(41300700001)(70206006)(316002)(110136005)(8936002)(8676002)(70586007)(7416002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:17:38.2710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd8ef6a-eef2-497f-8465-08dbca4bad6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index ddf25a1bb19d..2ac9e7a03d05 100644
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
 	size_t size;
@@ -504,12 +514,7 @@ static int __init tegra_init_fuse(void)
 
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

