Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA7792CC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbjIERyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbjIERyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:54:40 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A32938AF4;
        Tue,  5 Sep 2023 09:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBVnfwnlErKsNvouzu0+JbVmz1sunvy+xq4hR4JtXle12eNZFpRRw/ebMlns+Vipb5oVZrl8iiGI2lJe7xF7TRZ+G8UmuaxHkTSqqaGa4O8y7F0f3qWtMg4y2fuPLLukoKvoTifWUDGebbcfdbgSBwF2YIInQ9fjbc2pNJE0bvx79SaWaNuh9q2E2Z0iRENbqxErKmjGpyYpNMZe6teHWsjjxCkSCGVZBaZFguEdEomOFwzM5kCLKpy8Es8+iIsycKDpVtP/962LD8vDkQkP0v5tw9m8nnXh7nguM0NJbyLh1hf5APDQDtZqxkkDuql5kAqcXIZJkh4AsajhoXsA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=M76QtXttg/kVAHqfnZ95MMgXkXYM8E+1IxWK81To3y2VruHzFmsfBDe7AWxmQzLHxPxZCFbiyr4c0NXKwDCrENcC3R1KvoyND9WYZQMm6uBqhw00ztoVYFoe2/f++wHLaprfURf32asvSsm+ona4i8D9xYiLHUV6Y0zR39P/Ugc2cFueQGEheniIPhjdDWiyL5WvpjA6rCXutBAZzIiteIty4IKFhZEiebE8ItIuQzSes20A5BpnWLwdL9VlVvzP5P+GdcONQLz47F2vAk3+3GavVaH5DqKOPDdU1RnFQ3r/UgQ2yrf++GhHY5aHvEWhhQA8BoZMSlojS5HUeApvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=ZmYTsFJI2oR5IgEUi71Apjgwm7CgwUcIP3REeSIPXg9waVVhM63hNmTv28wtuiBSGlDKlhwpoXwYYIP92qaI+o9DaafhK1G7Vkp57o+srOMELdj9YbvhHRYo6/4pcOdqVMl6vL680wsh43dtmBnBzyabtEAiz3/cl0uq6Kiy/y61EV7sdtgOAHw7gG13FYh2duKy6JfKFk178W/Nsis8Qxi+PLBtV5d+d/saRIWL8Lu28quHgwMTyrLPbYRjdVmTHrvz8OB1EpAlC89h9alBeBn5DTsvLMnmqTD11ozegHpWSinbLxYh5RwKPj4c/ITIBRqW0+8W2RlB5b86tNVv+A==
Received: from DS7PR05CA0020.namprd05.prod.outlook.com (2603:10b6:5:3b9::25)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:36:41 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::6a) by DS7PR05CA0020.outlook.office365.com
 (2603:10b6:5:3b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25 via Frontend
 Transport; Tue, 5 Sep 2023 16:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 16:36:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 09:36:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 09:36:19 -0700
Received: from localhost.localdomain (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 09:36:14 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <sumitg@nvidia.com>, <arnd@arndb.de>, <pshete@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <kkartik@nvidia.com>,
        <digetx@gmail.com>, <petlozup@nvidia.com>, <windhl@126.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] soc/tegra: fuse: Refactor resource mapping
Date:   Tue, 5 Sep 2023 18:28:19 +0530
Message-ID: <20230905125824.2947-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905125824.2947-1-kkartik@nvidia.com>
References: <20230905125824.2947-1-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7084fc-efd0-410e-469b-08dbae2e486f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHQ9PYHJ0gvLehOSk/JDv03C7hbERL0h5kjHo13EFnlRy5vzbfC3SwnUCAmLpmnF0rVCWfGALxdlVfZecYPq2FamxhJSTkiKiTWnA+3mKmW3Z1WZ6ejINce8d7hhE+lYDcz4FwgGXD9UeD6FX+IiBZbuPnQFl1EGNFS2cokwWIj2mh3IeXK7AXXT5Q3K2DFQaaLWGqlIYlMXIurfBdHfIutQnno6Ahlg3oKmulCq/qJMOLSjvsYQL7hyHxX92r8t886fN95dUsbsDY0Aul/wUw94/u2QGoF/Gki6xl7JZ0jko9kMUgSttLLGPzCC10hHktlKVL0a5np3Z6FwXSUyXntOCjquST0NF0O7rgsf589YMAl2OTlOf8EULSJMDRVnlvlKIVH0t8zfSdGr6l0P09qtfujVf6Y09miPriRyZncEp/i3hrv/3mu5wstxriwNaWCYhX9UxjoiQl5mEGrhNyohdl/WPoEpZ2cLi4dDbkul3qvy5wcr+bdl1I95lvcMGaANw2AjB0OIKPghYRO1G/yZ0wgyOg/+ohs0P4EGlC+ar4QmF70VrjI0wKNKfVUNJFQRyZ9PfcG8AMYpAWjvOiW0lCw1ESdRwUSuB1oG5hrsfHuYyUiql7eXqwiI9D3mNAMg0vbSLr4rzGyC7M/aGu7+i8ORjBs+/5leyB8uytXDkHd356KHEvRzveHTE/q9ISOSzys+5KBpeaX0upZBlsa4q3qJWkHqLVilFMPObmdH0oiYwAc5ySaJinxTYdGJJDT1J+K+3ZLgU5Yp7Y1ucw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(82740400003)(356005)(36756003)(478600001)(36860700001)(5660300002)(921005)(47076005)(8676002)(8936002)(2906002)(7636003)(2616005)(1076003)(110136005)(41300700001)(426003)(83380400001)(26005)(40460700003)(316002)(70206006)(70586007)(336012)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:36:40.8631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7084fc-efd0-410e-469b-08dbae2e486f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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

