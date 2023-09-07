Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AAE79740B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbjIGPdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343715AbjIGPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474A1BF4;
        Thu,  7 Sep 2023 08:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqU4fRZ8f1krhHIV5xjAHNFnxavQVXHEPA6xVgDtT31Kluiq94DVsLzWjbJG9pXj77Uwr8K9vwoL5uJm6heAqfh/Rtcll1wUF0jZqAcKno5vJjWVCvu2Q/4EU+GT6ktHSkIO6j2h7jTEx8inXUJTp6JVdssA8P1gcxYKlCa+XmH55FmYel1UyFKqe2GCW0ltvOmYYbl/xnOVR52aj5siQCymECCk2SgD26GB0Cv/XGZxqDvdju5Y9F8oJT8nWw/lHRhwQK4PqZe+IKD23YmcjHM98btp48U2FRQMO6ZosD9PfYmYote2aFnyQzafuAGDNsSnqxtUt6uAdSUVFyjJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=PBZC/rJs46a5hd13wsPAFAs97MUqAgIDLKEaDEHaEJEP45BjJQZtQWqHGEFkMwTg0t8kwaAwALXfAMnxW0QJzFfk4pxCTwe6bnkjB50iZzCXOoGiVhhLLr1trnzRIvcbCXkOwUg2UK2GRH+1eL0/MmKNiXwrld5wFTSib1Hk47MtGtRnYblXDOQ5Sy5zZUcIFyihUvDEcP5+nowe+RtiScfVogUtXvYRbms+Qmv6jEoiEc/YCjLRq2m+vw/i2jv0rTDPsQf8mw+S2zlA89BF/kKZH+Ri6FZrT5U/pCJs5vj3iIn+3WxaHjrtTaIHjf6mn2ppGuHoryuRn6F4eG64kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=PvJow/Si+HdYK2tQ0Sm+AznTclWummtYTV9F9OdDG0dwHIW/5WOsSCqf0JyeeG7oDcilz1H1JhH4QwiXPtv7R0JsZ6mZrqa3tjRG/1VtEbr2kg6jisgKz2UXPU7036bLDwnu1Q5zFuhZWR8UWsS9E2itkUFGRUXYzdaJQ2owfY0FPUxYATDXRGGHC7aYVVbrpaAgnyrevmuyghXH1fDoVIUdkt+Gxz0xkSw9vlhFwS929XKCgu19wAyk73kC0hLPc4yU3jX83TOqWviOjZzH/2BWJHUqXsa1GiTmG0bksV/owbYR+tDAZYjAwZYOfSzDfQ+Vpc6ImJBu2mRXKjqzkg==
Received: from MW4PR04CA0358.namprd04.prod.outlook.com (2603:10b6:303:8a::33)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 07:11:22 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::cb) by MW4PR04CA0358.outlook.office365.com
 (2603:10b6:303:8a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Thu, 7 Sep 2023 07:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.1 via Frontend Transport; Thu, 7 Sep 2023 07:11:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 00:11:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 00:11:09 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 00:11:04 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/6] soc/tegra: fuse: Refactor resource mapping
Date:   Thu, 7 Sep 2023 12:40:47 +0530
Message-ID: <20230907071052.3906-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907071052.3906-1-kkartik@nvidia.com>
References: <20230907071052.3906-1-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca7ce1d-c3f9-4770-f496-08dbaf71a422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 925nd17JBPO//ArRLMuE9xtO1k0zUnvgD0hV78svJrx2tknjPFkPXxQSAvcb5oC0nx2OvTQTomVNKQ8SreA2cc/9HYtuGnaqt161bsCo3V3om+FWEG+UWnVPxMTy3A7tsoyHYiOXOsD/AQH6AeVSDHXMF12GHCJxEx0fGZ2Fc4UyILK+axkVyi/hdlDJQFGmqfR6qQ4qMzzYcgGN4Kx7i7/6Gs1JT5NBn1qto7iD0e+gViJ9pIWoswM1qW+97HcKMAqqglvEd9BoMZatO0Mg5A6i/wEJ8o5NRuDe7yFLkHLFVKje6Hsp+UScgxb39tmgpmwetXdejVK+97yRRBO+7DphmfKxmkxqLWxLGdQjkCRRhYHljPuLr/BmYCnuY6ZlSmGZ3WcvZnuH5YdqK7eEgGC/DPJOyJMw6arpaE5FNlGAWcl07ctszk79sRhkYGSIWkBh/XWjbYaXK8zuX/gmYt/6dyB4sZQCqUo9gJrSkdTA4cqm6LRqBpmZqp6DjiDhqwRaUNMEiCKS3AtPq4phT1rGneef6PYX02NHf1YvxhjokhFDaFHO698jDH1z9uGuY9toK8ewJNsROvQ8o+Q1A2Jwr85saJCYNbcP83B7WW7Vy5UdYITeb46SUJTEndtsymA10E/J/IwFMOGc4DaCBM3H+eGSNnbcN1iyfxMZm5MDK2COLSblYon3tbyI3wClWOYzC18hGASXs3GhGzOpIivunDcuQ8bj3kZ1C82taR834TiJXKznYKpqCtTALvqkiHh0bfkj018Lya+VVrSd4Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(356005)(7636003)(921005)(6666004)(40460700003)(86362001)(36756003)(36860700001)(82740400003)(40480700001)(47076005)(1076003)(2616005)(2906002)(336012)(426003)(26005)(83380400001)(478600001)(70586007)(110136005)(70206006)(41300700001)(8936002)(5660300002)(8676002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:11:22.1570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca7ce1d-c3f9-4770-f496-08dbaf71a422
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for adding ACPI support to the tegra-apbmisc driver,
relocate the code responsible for mapping memory resources from
the function ‘tegra_init_apbmisc’ to the function
‘tegra_init_apbmisc_resources.’ This adjustment will allow the
code to be shared between ‘tegra_init_apbmisc’ and the upcoming
‘tegra_acpi_init_apbmisc’ function.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 37 +++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index da970f3dbf35..06c1b3a2c7ec 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -160,9 +160,28 @@ void __init tegra_init_revision(void)
 	tegra_sku_info.platform = tegra_get_platform();
 }
 
-void __init tegra_init_apbmisc(void)
+static void tegra_init_apbmisc_resources(struct resource *apbmisc,
+					 struct resource *straps)
 {
 	void __iomem *strapping_base;
+
+	apbmisc_base = ioremap(apbmisc->start, resource_size(apbmisc));
+	if (apbmisc_base)
+		chipid = readl_relaxed(apbmisc_base + 4);
+	else
+		pr_err("failed to map APBMISC registers\n");
+
+	strapping_base = ioremap(straps->start, resource_size(straps));
+	if (strapping_base) {
+		strapping = readl_relaxed(strapping_base);
+		iounmap(strapping_base);
+	} else {
+		pr_err("failed to map strapping options registers\n");
+	}
+}
+
+void __init tegra_init_apbmisc(void)
+{
 	struct resource apbmisc, straps;
 	struct device_node *np;
 
@@ -219,21 +238,7 @@ void __init tegra_init_apbmisc(void)
 		}
 	}
 
-	apbmisc_base = ioremap(apbmisc.start, resource_size(&apbmisc));
-	if (!apbmisc_base) {
-		pr_err("failed to map APBMISC registers\n");
-	} else {
-		chipid = readl_relaxed(apbmisc_base + 4);
-	}
-
-	strapping_base = ioremap(straps.start, resource_size(&straps));
-	if (!strapping_base) {
-		pr_err("failed to map strapping options registers\n");
-	} else {
-		strapping = readl_relaxed(strapping_base);
-		iounmap(strapping_base);
-	}
-
+	tegra_init_apbmisc_resources(&apbmisc, &straps);
 	long_ram_code = of_property_read_bool(np, "nvidia,long-ram-code");
 
 put:
-- 
2.34.1

