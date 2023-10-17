Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF17CBA07
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjJQFYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjJQFYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:24:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B963197;
        Mon, 16 Oct 2023 22:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOTplJNavhfStBVZygHbB+ToVSN9rzmkpoLbw7mABfeWeTlbHAYgB1vDn7eGIzhlOEKWI96jSTEjCL7DY9YnLVDDikGRMhkFxqFYFh1rk1WwOtldg/6lUNnH9tJlHwnRwvHj1jVmKegZmmZAZFtRQ2812C7l/g66cVaZTgI2QBG0UatV0ZRzPtwqktDbt/Yazq3ZuJ72u8jGwvPQlGSEKF7hposyG6HoPWZ27HICVI6QAaJHG5dtuqutOWLxCQvDpm4aPvCs9wvb++VsIHcxDdUNuuvvzhx1pIwWT6/OobLSnd2537SK2YrxODVrcQcbn674P581Z/hY7mwKPppOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHnqTB/I/hBTi1klkL4hU/OmFUiU9wc9yjCWyXOOe8c=;
 b=XyrTYiQOHkSgRSug7BICbZWZDwT/yxtBtJlqVz//WPPvVAjI54F1o6oNlBOJUvS5lPH48JOLJmk6SU5l1sgtqbLVtkbuWnpSgVu3rdPt6o9DirjMZDbkRc5EFd0d+d6sFCKbPAObU3/chB81BQt/U1H4zRSce9DYPQ5YfW+t7J8x+O0sSgxA9ZXoZgDNpZw1z6Jgdu4uryrJ0RlMEJAD6+japUdvI+jN5ujxyq3SEMDgWpobdAZM+w972DHOS6H070A02dmkO+yS9OeCmh7P5trzntPBUNkcT0zA/8zUe3sx6NY8C4qUgjpE1Ze8q+zQRV84krGmlGfXifY9l9cS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHnqTB/I/hBTi1klkL4hU/OmFUiU9wc9yjCWyXOOe8c=;
 b=CpPIvtYXRVfIx01bcVLxgn/Z80f7qeZdR1uRoh8MPTEPLJy+kDLblKtGSB5XpKivJ2JaWK2AVGkDzS1Z6cBur87xDhvwSHuC9/nGB5O8ngO0KjLyk5yehPMI2qjuRzDZKaSeOiJJK+lVTNH8KlPiCJGHFekmvo8nWjMhUR8S0wO65CLVcGUNdlBuOYkenhUIwW7W1xJC+jof7ci+DfLtxVr3w78o9vTW1FtohJ2pXs60/m+D21cVoswuJOlNEnFN8WpCr1Twgj08ix/BLHxNPDtH0v8omhEyz/BD4Gg7/toB/BG4lPRsCYh3RPWH2I/P0mfZdmOtzpSaPHzo7sJSPA==
Received: from CY5PR18CA0053.namprd18.prod.outlook.com (2603:10b6:930:13::29)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 05:24:12 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::d9) by CY5PR18CA0053.outlook.office365.com
 (2603:10b6:930:13::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 05:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 05:24:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:24:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:24:01 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 22:23:56 -0700
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
Subject: [PATCH v7 5/8] soc/tegra: fuse: Add function to add lookups
Date:   Tue, 17 Oct 2023 10:53:19 +0530
Message-ID: <20231017052322.2636-6-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: d960c8cb-99b3-42fb-c4af-08dbced14bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xckobBb4avj+xd7GeGyAtQ7kcUpONUx3lks1n3lavPkjzYE860A6PpgwahF92PRuXuV0ML2cAem3KtvO5/CqDXzcbzF3+fynA1WY0+/53JZXPOtTlkCKvmNYtGabDZfbY99ud4bRyALOaateDEZcPb4/u7pdhkEUNIqifxjnqitB5VOxzgSCP+O5CVFfFqOTLBU9LhGtuq8hslcT/EVhOFaWkwMFIQ49lA7E/Tp5gWn5/OJabAwtGhFQJyhbKDdWAzauNFgESfQ32jGnasrYVAmOoqiArAzvOwVQ65Nn9lABeyiBSD6aTZ1u0qym3rJRk105pel6M9opIC9wOlNBb06KWl9AIC6qGN5XeeUQr5GE8g8fAZkoj3gJNht+lJZDxQXJeoyFnJWRezfwq5A+4NSZc9xc8WJuHZ39TreVTbGfOAOtt6INfjkP/ZP9DZ6fm7yKoTtTqcZCZsVdl3FUnbJT4By21zJFq1eN5E9LHTmWJ48pJvRdWYOsm2H+Aa36rLGGTRG2eAYrgxUw3b+PQH5xfNAM/nvfGC3ZBCUZC80XdeO+DDRPCUnZTp6MeKVrI6Q90ixFMlJpXqBC5NhWx7eQvzq1SpUOQs738X+xXjhVi+sF6+Kcr6hbGw2s2Yi2XlY9/X0Ushyx8OD1EXwlMxYruwcQxT1aJBn2UsjVFOU+Uj87MaqlgYCON/t7NCV/BF34keFipN8zwvssemWpIvb5mmyteAPXPlMqGIRpp55ouaFKKmfvJNELGUsWsWJhKzWbXuBA6oNPgcmidQJH5tv9vo8SyvjJlNuLC8sepFoWqF28SGbiQUigvfnQu4AXtR4r45D5k1HYCWYr3xqaHw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(1076003)(2616005)(26005)(82740400003)(336012)(426003)(8676002)(8936002)(5660300002)(47076005)(83380400001)(7636003)(921005)(40480700001)(356005)(478600001)(41300700001)(86362001)(110136005)(7416002)(2906002)(316002)(36860700001)(6666004)(70206006)(36756003)(70586007)(334744004)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:24:11.5325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d960c8cb-99b3-42fb-c4af-08dbced14bb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

