Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA17973F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344717AbjIGPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343778AbjIGPbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:31:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10161FDC;
        Thu,  7 Sep 2023 08:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTMd4ocH+6XHXrM9DGm0ailRrk20qqyKrDmw+UfpqMPtCQ+9bjxvNbSN/Rs67dpqfAFH1jdwUzu06J3+0yP0o3OKGWPdUYSQCzWLAXwgyl9aJ6mmwEhZdJekKpkRstHYGInOO4dB1Nlnct5tOdWW1MYFxbihu+bxoMAJvW5g5fXJozSfz3cMwUF+z7CHQ2I/P0eZtDBHfhWDzj0BvhyLmELr44NNxqE7294bgvX0C7C5kS3a42v/cXcIwSfjkEcURtQ32lwWCaI/rSMQTek78P94U7uy6Yq3ZjvqGNx+PbHTZ+wd2rO4md1TPL3e55LT88DmPn763i57rCJbvUDPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lljyv2F95CF7BnmLdyyZVTvI5083DfMTY3dwl/C/pBw=;
 b=iT/hwook3gedUr9tRaQhMOIG6n/IgVRtKlsOSAvuncRdy9xODkAIehVi3RPuz9n2kruPcWVEjD3oFB0E511VlMkhdLrdwpeQ8tYibyWl6a1Y0wCMG0mQH/OtnCF+S8Kb4fkBLc2ZvM6HM/2yHKSnEpkIkDg75YaTG1q9lXhhyCRJ1pdDkZcNY0Fsl/xPCDifzgB75F24lGAwpJZ2bQGJEs7fk3iTO7P7eMMrl/eKoe/v5/F1J3ETUYX/6suyRVy2RsVzKZe6plj/09Tz5Hlv8XUi+oweHpWsAad+wkkVq6Sx8EDbIwt+SiYCReLlAc3yTmvR+rqf+YlKlB6VKo9VpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lljyv2F95CF7BnmLdyyZVTvI5083DfMTY3dwl/C/pBw=;
 b=t3mJfTvf8tTEyOOAgpfc4dQXSm9bGsmNykV3UvzO2yzD+hYGnuKLoyW980EZXSbSmISPPUjPzPO2u331iO70LZupqSzDPkMNBgkooYIPhzbxDSjKcYiNA+UWBvTgQTDRuAeHpzZBI9/IXkZ0fxwva28ENxctYJQ/zkqApiWzHYYvXBDlcfCihV9kEH7IWvPbpNU2xnT3PHW7JF4zj4LZmCjkqMWA5cBhgtQvljoAkzxr4D0jYv4fFd5/mbaLbGjaiXE4TtvsEDNZzOC+RkzqVr2/S0/vd8OxI2evjE7aQH5kux+SwvEgYMMMMj0rW3Jgeww821xnEVF43Exl993uzw==
Received: from MW4PR03CA0249.namprd03.prod.outlook.com (2603:10b6:303:b4::14)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 07:11:41 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:b4:cafe::8f) by MW4PR03CA0249.outlook.office365.com
 (2603:10b6:303:b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Thu, 7 Sep 2023 07:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.1 via Frontend Transport; Thu, 7 Sep 2023 07:11:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 00:11:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 00:11:23 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 00:11:19 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/6] soc/tegra: fuse: Add function to print SKU info
Date:   Thu, 7 Sep 2023 12:40:50 +0530
Message-ID: <20230907071052.3906-5-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907071052.3906-1-kkartik@nvidia.com>
References: <20230907071052.3906-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf9c358-ce01-443a-dde8-08dbaf71af40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2k04lPAj0usnCbUtB+4YxVDNHLr37g/C1tQtC9RVDlk0rWT4Mg87BR7J/XnQygDqz5OSniLtss4jtUakQK8yUAEGlBFVFREkScMqwQvgfxeT5H3e1W1lJtdPJNarVVewj6SfWFIkw2Vn/Sr2RIM6ZJFVDakwW+xabIBizTmi4aEMnFFkXK+TIXh2TZ/6V25LoIHNY02jQd8IiFqTImKpi8hSnC6OiJJYBdRw7vcsv+nvgY5fOPw8wmUlHPcj4ILxVvYqU4pDv3hbxG5XodvT4/dCzd+hhGzdWMcR6+C4DGsXcJXVQvMoewLDqk6bBjUV3AtPgeYSB1wOw5LDGlUJuCrgPpFLgzVSBLF7Mrk4h/hqMDzzTZHmJtNZtk1/lI9ve55emgiqUj0mkdkoIJbGiluORUfwCjji9vR6QWDULUFCvJrtA3FkG29fvStX0/Ox+5BSD0/Fzu6sP4DrkWWkRUTiTQJ/0jcQqACRS8QJzgnSBR0t54aIHiEMcqZQ7Nuozkbtxeme6lyNJz+Dg6I6RBRDAlMhBay717yTb6AOQMGaGXXxfeKMmndON5KZZ54y6E//IIpblVSNEOXhk0VR3QWgY9EgFAuZEXHfLgfA7NUM3SdAAOKMMt4G6culJ7bpeEVldmsUUZ+60BLhQENbsfMbsWYT4sJeswj5NmCdxQAjdfEtBj9OBs38ZIMfR5EA+xV0ZJ07GxwtRnb5CTyiyvaSZVQHnw6iz7tN60qOuF8B+2+pqZB57UZpjWCtrc71
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(82310400011)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(6666004)(478600001)(83380400001)(1076003)(2616005)(26005)(426003)(336012)(2906002)(316002)(70586007)(110136005)(41300700001)(5660300002)(8936002)(8676002)(40460700003)(40480700001)(47076005)(36860700001)(36756003)(86362001)(70206006)(356005)(921005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:11:40.7767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf9c358-ce01-443a-dde8-08dbaf71af40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

