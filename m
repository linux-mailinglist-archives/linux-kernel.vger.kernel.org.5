Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A577CBA08
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjJQFYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjJQFYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:24:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19431111;
        Mon, 16 Oct 2023 22:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Vi2ypg+G3/u7o+pqAsl61BqOGY9OrKBghkEKSbOTVnX8PQuk5fpa6rUkp1l5kaXNnr71nRgQ2Hf032HrZqOLrQGvlKFKPRW5ArAIEj1ekj8bQZ1mITsdSb0tu7iBrNQHeW8ruSdTC9c5w2DZ6a9NLuSJZuD1YizC/tP08gXJZ2giQdiTmfqqjIMYIbyWq/k/y4F5UDlvbdd3XtHfzaOef+27v2UmctGiNLVk7syVU+TWJb5pwAZpUgpgskpstQ7Vj7pQrH/u7CBYFbTpuGpiny1WOqPcgMHunA55UoMpIkc3/LdWaL/1+96Ur/BVfHqCubRjmppcfHkx2P3lrlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Boe9hAUW3Y1DekcyUmXJ4mkqskHoBpTocROHHjVt0YM=;
 b=fJXq5Tw3BLz8YET6QYWamAxYUdnjfzOKo0bVUs8gZz2cAiD1gOoKwUwkoUT0svGKE6KJoQPTPNvSYgCb8pYTYpdC+f1TBYRV58Ej/NNEejAQarMnnh5HOMOBYKhQYcfTroWXlqiaEQOsC4KCK8dk7hH8XYEs7FIEnwRlwjLAl02CeJW9fbxmx/0dRy9Ol+zZc6+I1yCfkoVHjCY67T0XHStiqxPXwvQzePQeNK2Lpml3m7UL3XUEdEXPlL2BtlcaNMPYZWXs50oqpxxj8bfCH5b0bUCOirlOUlyC5E3RwtkbcShLhnXOSWBEfVwjKsk6D3cUIWjTfma2rXHuYfOT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Boe9hAUW3Y1DekcyUmXJ4mkqskHoBpTocROHHjVt0YM=;
 b=gFMUNfbgyqBiWWXa2k1LRhprlevUadh/pawwKfXsb00DJbKLA3xlYaWtYro3MRZi2+Ys1tBgPJ5jSEECGB0n7F3mtb9RQdelGZQr2GlmIyh1N5jbVuz57p+TNcgQJUDfuP5IvuP7Z9rz7K2s4KAr3/zelvyZRda11BFpJvdEAgqK4PKiR6oT73q2YgUPErYcSSL84O//J82Bl+3LnHXBOI0NmSCPkw9mUPN6RSELLMBUXeLHd68HpynJ2hq+srx9ISYA3XQ8ILCFSTqNn/sDecCw27YmHgJD61cVQVW+yrsfgsBLQKt3bMvyxPihtSb0eiAbIKs2WNEYvUUutnGZ6Q==
Received: from CY8PR11CA0030.namprd11.prod.outlook.com (2603:10b6:930:4a::15)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 05:24:18 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:4a:cafe::85) by CY8PR11CA0030.outlook.office365.com
 (2603:10b6:930:4a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 05:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 05:24:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:24:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:24:07 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 22:24:02 -0700
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
Subject: [PATCH v7 6/8] soc/tegra: fuse: Add function to print SKU info
Date:   Tue, 17 Oct 2023 10:53:20 +0530
Message-ID: <20231017052322.2636-7-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 7919098c-4785-4549-9803-08dbced14f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MI9zK/Q2X3T+4qiNGS3sUGbkIf9OJgJ5lJrPD6iMM5x+YgGd/iyVjCAISZZ25ruMf1hhfWFiEhLB9DvRPiT7/t7uJBHcY9jyKVrdl1kOex7W+8K7PtYTv/W+p7qNgW5FrNMUaF3aXrMYe2YPBZP1+I0iBz3PYZO2adiY3NFU1rJ73xS6fOzMFzmTtulEV2MW0ZHhURZo46OIG45cCY6oUQYDa8dWTXZDOlMIN9BBdyOfVuSxhhfH9N9F7b6D6/vZIT1uzeuX/PnRSrYuvcqlX9qTJ9+Q8GnL/4/txrnL9nTi1LDeYOJa4GR3PPucdtY3kWj7EABUj+DbrfTAl/n+rHegDRbjKdK5cVZkhoCkEHLwPzxnbrorfXsml+PBnzHQmubxdMX9qjev/y5QFEgYba+Of5zM2th5oTn2T4kuNcroNGAyAqQTlOM2EUF4robT1v9BocgKJ9rBSW6mh/fg4bdLerf+mROCt6hjHghwIyIWuZIk9WkkNeLTxUmNsca+TotayMg8kIJMr4h5n4gOcxLRVp15aRvAsPEFg4qEm2AaGcuYZ1gjh8KOSB4I+gOdO2B/EYCjyhAkeuKaRS79PDMH8lE02hRT5nemQBxPG5ZGXmGzcoryt11gREXuCXx6wmLT1Bj0BKZzi4v1F6PZ5dsvzVPNy9Ra8xOTFAIFNt/itx8uR5rwfb5FEqvQKXX6q8oVS8VBhXzV//fBz3flWfie+MosQxbxqKENzFbWyZqvKyZd1eLAnoMjn50xqbpp38AanErdS1YKa2PMk82cTTkuJaiFtDPXxNBVJ2XXMB0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(36860700001)(7416002)(26005)(2616005)(478600001)(6666004)(5660300002)(41300700001)(47076005)(83380400001)(8936002)(1076003)(70586007)(70206006)(316002)(2906002)(8676002)(356005)(110136005)(336012)(426003)(82740400003)(7636003)(921005)(86362001)(36756003)(40460700003)(40480700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:24:17.9277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7919098c-4785-4549-9803-08dbced14f80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
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

