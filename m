Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D73B7CA512
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjJPKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjJPKPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:15:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6374B109;
        Mon, 16 Oct 2023 03:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foYmv0pVzymGenQmeCJ2M7Y9BlLVVhsn04awBQoVViJZlUujE5jVzZc4uiFrilSO5l5V1q49TRnqIy5UAVg04XI5Ysh47ZVOvj+u+vPU4xgcE2Py0bQGpS9OgPOZ2jYofuAlr7BVINdz8AX3zU0r5WfOm8K4BONjVcmCt549kh1OmLDEWoqmOPEimrem8WzJ59wMqY9pH0uJmSe0PLV7AuXDWwfRXP2pHPDw6TzlNBLKbAxWr4cYBYJ+xmq+zjMFH1YXB/j9TMbVazcO0G5PCDVnTmVpy8SG4uM1GG/f5xTsS9Eov8EwDTcnSNv2zpBmyEMLfb8WO9DG3d4Jx4HA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHnqTB/I/hBTi1klkL4hU/OmFUiU9wc9yjCWyXOOe8c=;
 b=Jo6YVWh24Czukgvo1w7wMHq/vCMzi57nfaDIQQlT3Nx3brZLsbQ0zdv2u1ZymJUoNuOCcWx0vbjkanqJhC6vn8yzkLH1N20sKMJBs2cv/U7GR4KyUye28QnCjQtpQY/+P90/bAOwf8qrL7Fx+OQs+xpIIQhqGeZQqCd2eEsotL3B2Y9TmHSc9FMw95ZRbs8X59p21puUE5ccEK8bBRPTcKz07/REDN31AA6fm3YMQosNFgCXm7nZLAg5jDQqTk4XVQi3udCfz9yA4bfo8nVCJeDpdQ//dUbyLKCPS2QhGdnyWl7yD7t24x2dvW5krixmrxhHbpHmvYnKa1PAYbbSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHnqTB/I/hBTi1klkL4hU/OmFUiU9wc9yjCWyXOOe8c=;
 b=Q0KCnjBjaWIYsP3gV6WZik7Xaw2efOFp5lC9IpdTpe+GO9+G32zLS0wkx2EXBpWwYMmmAgO5R2hWlE8xm+OXo0MoNoUwUlOYe/jPvnX9z5jvpHxrqL0fNJnvLVvZyU30oBkahm7Sx/ijYCoLOY+XLFbOKSOygaB4CKXXVAmOADWvj67stOqmiSHGk84I74JKb1uVi4CJzNSJg0Si9guUIml9WD3aS+6dBhBfdxYJ2AFL04Nm1mm9aS8EccnE68S3NPr0czhDh0wePGsx0KF3aCFvcuEeJuWY5laaxO94bJrD1FRT3MJPnLnInXo7BKH5Ae46WOmUHAyydD/+QveVhQ==
Received: from DM6PR10CA0003.namprd10.prod.outlook.com (2603:10b6:5:60::16) by
 BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 10:15:31 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::38) by DM6PR10CA0003.outlook.office365.com
 (2603:10b6:5:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Mon, 16 Oct 2023 10:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:15:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:17 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 03:15:12 -0700
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
Subject: [PATCH v6 5/8] soc/tegra: fuse: Add function to add lookups
Date:   Mon, 16 Oct 2023 15:44:33 +0530
Message-ID: <20231016101436.7146-6-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: b62457a4-14b7-4380-8e55-08dbce30d411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mk0LP8BUIStzTxQ2wtmF3yyB/C5EOqvazvEOHseQ7JBPFt37IU4PoQo4BWxSHtph2TKHnt/MFE/iWT36/KEVKoqt9J5HDeuSLUybBoMCvAOrLoFuQGkbyqI4MnnHlY/omDCx5/CHqEUUh50v6YY71flzvxji457HK++wMBcHH2RFARpGDvU3EX/Y0mDnos8LfYhATF/FXBuXNVvP4eGfQsHmrMYxiweeFY0ews8BzsKxQVHk+WJy+Yx48wPzxtEvK29qD+RVpHX1S9dyLBSqtZkhzNE4mowiUOHqZINSZh8+Wls8kz+R/ruZf9xq2iXw17tS9BGOh5XY/T0b2/dO+t9rwPs9hFmBrTILKeFqKXcHH2JHNLwUapDI+oTyTUjYl5dOTF9vYlyN3IgxJ7BNE9qmsmEhWwwTgMqgh34NSNdbx/favm80gMtwwnbz/W9BucCqOWzU/IpgJ5Bw2wIzR+hJuLDcAQKqBOrh8mX5E2x8PDZBOJKR9TAfuq98lpdk966W50RKVOE0YI5iQCXknRAy70NVYlqrDSLqThaYNcKBVK1vnysKUzg5NFoZlcYOdQSaC1zFmirtXuBBpWlvYhn8/5fIl2iZFKsBeau7YU7hcLP2+Zi+dHKkxWkMXdlwautHCgwwFGqgDdqaqF7qn7xLGH7QxxO7alJyHyGwfvDIG053CmHgAsFt0VmzIl4a3XwVnuKfCiH4zc7mg0dvsazyCGUnipLJqu5mNWfKL2SvuhMnXr69vE/pQqgS9cxKmdDLbjpOwViHDCvzBYQSbB9+9O1W63Mi7DzF9V9k6uzDi9VrHZagHUzJ/2oE7oDZqyt37ty9+Sgld0kpZae7fg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(47076005)(478600001)(6666004)(70206006)(70586007)(316002)(110136005)(1076003)(26005)(2616005)(336012)(426003)(8676002)(8936002)(7416002)(2906002)(5660300002)(41300700001)(36756003)(7636003)(86362001)(921005)(356005)(36860700001)(83380400001)(82740400003)(40460700003)(40480700001)(334744004)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:15:31.3167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b62457a4-14b7-4380-8e55-08dbce30d411
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function tegra_fuse_add_lookups() to register Tegra fuse
nvmem lookups. So, this can be shared between tegra_fuse_init() and
ACPI probe, which is to be introduced later.

Use kmemdup_array to duplicate fuse->soc->lookups.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v3 -> v4:
	* Use kmemdup_array to duplicate fuse->soc->lookups.
	* Return err at the end of tegra_fuse_probe to remove
	  redundant code.
v1 -> v2:
	* Use size_mul to calculate lookups array size.
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 98805885158e..4ebb5597a77b 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -113,6 +113,18 @@ static void tegra_fuse_restore(void *base)
 	fuse->clk = NULL;
 }
 
+static int tegra_fuse_add_lookups(struct tegra_fuse *fuse)
+{
+	fuse->lookups = kmemdup_array(fuse->soc->lookups, sizeof(*fuse->lookups),
+				      fuse->soc->num_lookups, GFP_KERNEL);
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
@@ -398,6 +410,7 @@ static int __init tegra_init_fuse(void)
 	const struct of_device_id *match;
 	struct device_node *np;
 	struct resource regs;
+	int err;
 
 	tegra_init_apbmisc();
 
@@ -495,15 +508,11 @@ static int __init tegra_init_fuse(void)
 	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
 		 tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
 
-	if (fuse->soc->lookups) {
-		size_t size = sizeof(*fuse->lookups) * fuse->soc->num_lookups;
+	err = tegra_fuse_add_lookups(fuse);
+	if (err)
+		pr_err("failed to add FUSE lookups\n");
 
-		fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
-		if (fuse->lookups)
-			nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
-	}
-
-	return 0;
+	return err;
 }
 early_initcall(tegra_init_fuse);
 
-- 
2.34.1

