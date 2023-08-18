Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D8780883
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359237AbjHRJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359248AbjHRJbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:31:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6903C1E;
        Fri, 18 Aug 2023 02:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPC6rOnQqzANFXXPAgSxgsJWnqs+uRU1yCkw/UTpM33oUjv5u2UADS3P1xFRXDyzbSIBtcphhdZQR+psOboa77jMJKaxbGy733Glg9kiO/w3oveIt5s9P2si7bwqmUGllUJjB8fF0lX5Vb+ENbv2m6yQ0iITU7gX5pqMUHmghQ79/bfJ/UNmSDMSHDEITUSaE1w1tNdAKwwBr+yjgUEk+juw4zSUNLQJ1IRlaI2d8hKyHaYk5nTj1LCmrw8y7zwEvSp2orbzhnnD/z08GF5G6nhF6Ku6g3hYVrpUh2uNziZnk7dAUg3TyuX5hvvh2fsKGl8BJUHbdmhvArArkIycHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uOsGYkdQkQzDk9L3JjtJ3hBT7gwVvXCFJiPfePWRTg=;
 b=nEOQETRr+uHpWJsLntZXEJSq9SadFhvz+RYqfYx1IxnXEioiuZe6DehoNIekW79+0YWvJtzhU4SrnX7uA+01R/AFvL5G0fPL2v/zdksHjdqQQXe2pGarY8s5lr1phUlGYRZSX3VykvJCSVYKVX5hjrXkKRJOzJhajYze9HWjBOdR4gueoTP87ovlEm9dI+eDb6CA8ad7OYURFHMM1fFGJOAs2bx7c05nveb/WwT5YcjV0XOdr9g3OX/4rmOQHKgSRSMG7oicv3b97N1WfNZmG4AlZaondNIibFsT2XuJ9ripE3F2wDF4tAViAY32BOunUUltA+bdLfcSn5fA4vn/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uOsGYkdQkQzDk9L3JjtJ3hBT7gwVvXCFJiPfePWRTg=;
 b=EqFGSF8JLX/V9sbib23TMSW6MAQkvDNGP7JP0IIAsvJLSl/IuxEUTSJNDL/a3vP7bpPM3GvfCfWE7noyMRoBdAbLauQ36OM2lwSWKwzbtTs2izh6Bpxw+e8cL53S+CsWKKDieTDXB+Jc7DgcO+YU1VfPaIbmTw4FE6Uze4HmkxDB/t6QH/dhhvoQcpgbShbdsgYPUgfkr5VeWs9ygFEEI4hkkZy1dZMIhMBRSazRilZdF9JcQHIwz+IUA0u7jcyHu/8teEbNBxLZxCM5d7rgkgvVzo0NmtZXk8NOGbvFaQ8FCp+bwf9Q3KuscGlr6ts4oWv+Q9RhvA5yw8JxY9wy4A==
Received: from BY5PR16CA0021.namprd16.prod.outlook.com (2603:10b6:a03:1a0::34)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 09:31:11 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::a9) by BY5PR16CA0021.outlook.office365.com
 (2603:10b6:a03:1a0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 09:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 09:31:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 02:30:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 18 Aug 2023 02:30:56 -0700
Received: from localhost.localdomain (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 18 Aug 2023 02:30:51 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.co>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] soc/tegra: fuse: Add function to add lookups
Date:   Fri, 18 Aug 2023 15:00:25 +0530
Message-ID: <20230818093028.7807-4-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|BN9PR12MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: c94b4671-2faf-4dc8-e3fc-08db9fcddb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FWrmSef64WX7a5BbRBZyAx72E1/aKAO/R3DDk+IXJe+kbdDAtSSo70aL3mIn37lSg1UxpRK27hpumVmd0St30Yf4qxqn0/Qw3cA7fB6lL6V4Nk06EjsuyszGFmVSeP30vJ2rR+WEOcjK5ONXpWOsNL+P1eqR/jylfhw8qhlj7UeiL+9t2Gb2YImcCjslhmat0cEMGIhhz3CvSHnlEpyLFMnGu1LpkDTgjNNaZkHXQJCdsooBpdriUau0rrgVK1qnFkuQyDZ35TASLJtsPIphPoT/Tn1XtlRvF929n2sNo8g/iMvWGqRyM+FyJjFPnf7i4t+ulqpoN3jklD/bkoNV6ycAdaE61Mylz6LXbdGqS6iloYdm/IHEsAMAdw7NHqpEIT11MAf2t2G9omhjjRQVZlAF4qA7XhLavasUkzjne4t2gOaWK9D3uAnYExKMw/9HS5cPEYqZzicseXIGtI7d2QUm+BVMGw1bXBfD1cY1zhMFgNHng8O3LkLZrkVgBCk+cr5c9q3OVWf39vLUoaHQfaltmrSmeiO08Tfdm5glVxQ8xT4331lI3TXUI5Z/zdcH8NnREd0nPGAuKuXZBH+1EC/JQN+PdgKIT0dJyth5Dy5i7k1Efehrwq1gQhQZAGTf3xnZUzJ2Yaz+/7jT5FnV/6WP50S1kv152gm3LazBbJ+CIqL1E6oHxNtbb6KE9BktVlRnhebsI8/nKrKIkgVKbyGme/5EtSL762C2L5ZGiFj8R8G5HUx6zIoRmsqmO6HJkuk+iXZ3qeBsCzJtGyw9A==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(40460700003)(86362001)(336012)(426003)(1076003)(26005)(40480700001)(83380400001)(36756003)(36860700001)(47076005)(7636003)(921005)(82740400003)(356005)(2616005)(2906002)(316002)(41300700001)(70206006)(70586007)(110136005)(5660300002)(7416002)(8676002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:31:10.3527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94b4671-2faf-4dc8-e3fc-08db9fcddb99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 45784ac6393d..bbb1a5c4823b 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -148,6 +148,24 @@ static int tegra_fuse_nvmem_register(struct tegra_fuse *fuse,
 	return 0;
 }
 
+static int tegra_fuse_add_lookups(struct tegra_fuse *fuse)
+{
+	size_t size;
+
+	if (!fuse->soc->lookups)
+		return 0;
+
+	size = sizeof(*fuse->lookups) * fuse->soc->num_lookups;
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
@@ -419,6 +437,7 @@ static int __init tegra_init_fuse(void)
 	const struct of_device_id *match;
 	struct device_node *np;
 	struct resource regs;
+	int err;
 
 	tegra_init_apbmisc();
 
@@ -516,12 +535,10 @@ static int __init tegra_init_fuse(void)
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

