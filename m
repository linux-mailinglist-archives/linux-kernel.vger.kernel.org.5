Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9595E792D27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbjIESLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbjIESLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:11:18 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614B12D60;
        Tue,  5 Sep 2023 10:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtHvh1eNLsQ9/Xjro1IDTdDCcFkezpGajOZYlMvZjaoF+eUfqNOc6z5UwFGjzxyJ38n7BoU+p8C6qce76Dg6yELLdz7KqgU/qgVCdVrXd2MF2pCVnp7kbTmoDf0ABCHOXa8H+2dZFhU0adBQwjR+7RL59LUzqBG6F1P4RyNDAz/7FYBs5uotUpF5KnLbhInyle8s8ceDqQDjrIfceryQS+lPyIiKuRxXEmmSEr1qF1+muS3hBi+CfSCfS3x92kR6vtb+TH9U6nbUESPxXAdmjdgDJM1faOH7au4xJYhgIhj8R3W+IfB1lGuN5EUXmq1/fDZvajfBmVKwzyNz3b/Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpPhWbb/nfGXXUk0YuEb2FBgC/PBXKwxEfQ6BWTcMks=;
 b=XAt+3ZAPnBtan51Ot0VkorYUfQD09JDKRKQU+BpjyKSiaaM+aDkeEeFzdH0d4/czUXowflNMgFZke6p/7iqfXNmcvvpKj91A+0M/1trSYuI11XvZEABLFquyCT4a5uYBp7xa4729Ww5AXxl5PuEIdAMuVh3ySCHB94Q9aHXKrlwLMiL6a4IvHh2628Imyw5MfAEA6PPrRljYr17Z0EISoBPbDCWtKPlrMtST8SnNFTkaA/9H68zqN9fHLu9htIi9ivWMXilr7t1vAP+u1aZNybYKP/ncvPqCdoyjaj/3V/gIe+DqhT3pYIayCVXGPpG+athL/SxznDIgKXhVflJSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpPhWbb/nfGXXUk0YuEb2FBgC/PBXKwxEfQ6BWTcMks=;
 b=Gqq0zFIniXDPaX5nx1FuOwATOPVduydOwp9ftuSDDsUjZU8jK/5Dw40yCovXdZNef0ukOtVsYlMCfcJqwsn0LyNay3xaOJnmSm+CYr6o/kg3OSO1dOLLlll3X5DpQ8QsosfwrkPVzANX3JjZ1ZJwiXGrsmq8+oLPenM87S/XDbBIQs2miPpAau8rh4PCjsHZ2HWIldwv/nEsC1H//bCYSc0yL09bll9XaJhEuzEMANDxSbb2fJUVtDIJslbwE/n9NfFuS2CGnKdHs4dWMXag10vBFAXf2vHBuh8KqslWovfQYDspCx2RXcyLU8llaD6p5eupQ4aC6lbPvYinUMh9Cg==
Received: from SA0PR12CA0003.namprd12.prod.outlook.com (2603:10b6:806:6f::8)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:36:52 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::3b) by SA0PR12CA0003.outlook.office365.com
 (2603:10b6:806:6f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 16:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 16:36:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 09:36:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 09:36:36 -0700
Received: from localhost.localdomain (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 09:36:31 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/6] soc/tegra: fuse: Add function to print SKU info
Date:   Tue, 5 Sep 2023 18:28:22 +0530
Message-ID: <20230905125824.2947-5-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bdab84-cacc-4d2b-b2c3-08dbae2e4e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+y1XkzesM1eGgZrEwS8pk3rNK9lwerjSEi3WDUSKPEOHGpuBZ2uMr/yY8Uv8uh26Z73Shx2DqZCl5+Aj9ErM8FoYIZw7v7Q5DraTXJVwCYA8UcdPKr0Ydwc/3gZaoiK+Y0+Uoh9F3OuFrtSYiiWv0hOAE/rlMhTlV6wVniCjA4qStdyAt4uUysCFYgTEQ+2x7t9g7Txv8J3E98i5NMQAkBWK5fFzHi0YIVjl2TxI+i9gn48JGyinOrbyLUwtjbNek0VLtViYBHT7FDbvdZUhePLi/UWOKJhsi5UDBvv7yuOpFRFmDNDDLk6lQSRIxv26BTOoRF9oYh8e7tmCevpBG/YhBHpLuKj1yDrf7LXYAYG1UyChP0+eUmgd+zTF42+sNVwtdv517G0A+ttPJKikc2PcljKAeHvgl9YqcbocHGxHvYJ2FU0v3dlVtAHha8ZRWfH9/BmvoNvzhpWiwU8uMRSlsktcD3a6GRmBoLLZtRBt3hnAVZSe6wlb4vmQuN0aF6BrTNtY4sSL1Fv9BHGMVWB11ZqmWah52m2mLjBbZtP49HvmlAKVGZYHYHh8XoGhTmiw3JRku7NdQVuTEBWRLzhq9gQOmuc2I9jlhdISI7/vvl4s06gxGmf+Mg3VrwpSeJjVY350CStgZRnFThAQC7fG9TrCMWsGPf07/E9joFFVZku//jqKDacMsBod5UhUpkES6RuB0jKGKEwrfE4grxqMtEqPCzWcpyNzsDakQOkgWU9bTBz80lcwb0lWHuJHIy4vowzA190OeRSRUVePQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(41300700001)(40480700001)(82740400003)(36860700001)(70206006)(70586007)(6666004)(47076005)(316002)(110136005)(26005)(2616005)(5660300002)(1076003)(86362001)(478600001)(8936002)(8676002)(336012)(426003)(36756003)(83380400001)(40460700003)(2906002)(921005)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:36:50.4170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bdab84-cacc-4d2b-b2c3-08dbae2e4e1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/soc/tegra/fuse/fuse-tegra.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 821bb485ec45..64f7001823ce 100644
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
@@ -516,12 +526,7 @@ static int __init tegra_init_fuse(void)
 
 	fuse->soc->init(fuse);
 
-	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d SoC Process: %d\n",
-		tegra_revision_name[tegra_sku_info.revision],
-		tegra_sku_info.sku_id, tegra_sku_info.cpu_process_id,
-		tegra_sku_info.soc_process_id);
-	pr_debug("Tegra CPU Speedo ID %d, SoC Speedo ID %d\n",
-		 tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
+	tegra_fuse_print_sku_info(&tegra_sku_info);
 
 	err = tegra_fuse_add_lookups(fuse);
 	if (err) {
-- 
2.34.1

