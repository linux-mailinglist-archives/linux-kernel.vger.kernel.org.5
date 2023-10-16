Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ECA7C9EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjJPFfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjJPFe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:34:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900A8127;
        Sun, 15 Oct 2023 22:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEnHW0+I0hcVKdERWb4BJ3ZUJMEG9bMSEwftNQMlKAAcfxgJdQtbcSKr1NGjPldXnMmRP4KBGk43zAS/eByZTP/LygPjMRSqFwtVpKZzNDuoLz2zgFysSzZnGyD0UCjalCeKmeWKccnaoTQYhQr2A/JoO0O29XdFFxRwsJWMcE2e7vMljdonG9PvI9q0xy0izSxJuaG4cPWn5VxvWlmvofEFH4etjuOsNHpYyA1MYhxcYYv1dKujoudim6//Jc/er6TlSV8wjA6RirFAwTkw6GstrDIICn8RLzQg+pHFOff5VpAs+VSfwUD2v+Z+fXq/CqmeOM6Y7mczCdfiuklcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+Fro14rgalH/06qabhLwOLhxQnp+Tg6JsjLLk27Cig=;
 b=mdYeQifIyCnTv/msJCmWj7O5FRd+MLXEI/hFFV/d7x0AZ3eF4g5K1jPPSkzolAR/dikaT7B1tuVsItHckZ2hztoFW8YoRE+ECIRJG1/UWCp4rEVsJIsuBiGt+OrIYOcLhKoFRrW9jf2yqXjXGYzrCqeD4EZJt9QNDNR0CaOz8EkgRJR5qABKPTvkGJWvGqhY1M8Aa4cMrR6uJpJ45ES6m+XKoiEcxeWz7CU4Qs9GNuMeqjd4XQ8VJsQKJTWc+MgxT4+CFv4PplFcATJeUGV3R8pRqjCqzX/nSj5YBA1DUbqfHwe8tSn/91/kOJMMNa+cVrHDkdBc6Nj6N5GSZwTc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+Fro14rgalH/06qabhLwOLhxQnp+Tg6JsjLLk27Cig=;
 b=EJhiHXw/eQ0qSI0b50LirdGXbhE1hJAvKIrw96d8T/yvx+MvvN1ed0eENKkcO/KzodEaTzBng2DMeCkKnh7OLL3Z5BWA0GF2tOlcwne5n+kDVLg96twZ/Rcyyb2qPp4ZXmQ4QcH2glrzOH5MbzsQwzy41j9mhgZ1PeueKm1KTjuSTXStPE/NtlGzXaeqI4D7/EPSeWDv8iXUccGvWBx26/lr2Ix9H0DIGCBD06zN2iCEQ9gEq9Bj9YaQL3bfg+WP6WqF3+Vy/I/t/rPgy7P8hBTIas/30T6pG/70j7aufnDOAiotBFAWky1ADupdJNdaDhUf7rph0hIU9zh0FBKxxQ==
Received: from SA0PR11CA0085.namprd11.prod.outlook.com (2603:10b6:806:d2::30)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 05:34:50 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::a9) by SA0PR11CA0085.outlook.office365.com
 (2603:10b6:806:d2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Mon, 16 Oct 2023 05:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:34:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 22:34:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 15 Oct 2023 22:34:43 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 15 Oct 2023 22:34:38 -0700
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
Subject: [PATCH v5 4/8] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Date:   Mon, 16 Oct 2023 11:04:07 +0530
Message-ID: <20231016053411.3380-5-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016053411.3380-1-kkartik@nvidia.com>
References: <20231016053411.3380-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f06d93-628f-468d-7eec-08dbce099e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qP2r2GZDdysf7gyp370SU2VOGuNHyE5GxwcGlvPGzVC95X9NYVHnMS8VQbquYFgZuS2R/CqzDFkq1WCYxS6Al90XipBg+6zC3hjSWyrhFZpjtQt0AFf+OH2N4MeCvO6VEl+GMuMa+uPHPdw2oCj3M8mVqBDtRS8E2QN0YI8Fb8fUC0RIyA3LA8PhUpQpsLghhvOktMbgVzY6agGaP5rHlNbjivOp2ll7EQ1VL8sNf8ADpeFztE9xvqBiAqhtbxNR7yGkkM1LxqJB4dLe6hL1nARo51wfdVuFn2ct/cmHlT57v7Tsui5qFW/jZYQ2wOPkyc+IW0PLtsZrD6qnkT5XZejRrpRRccWlqWQJMpeYpcaVTTstP2BIKAiGcKjy8juECINaWVIXj9Ja5cV5wx+yStJO93fPgqJHGm8amQnSCDKbrwmq2Xr4/SCO8oBfr+CGwMFVKC9SaRAKK0V873+WQFrBF1dfk71WyiH48u+21GzIacerjZo7ZsxoRERchMoxK/R5B11JKNwm2yCs6jpm1xMEzXbuR+2XKJld42tDBDgOUWfCgO8Tld9uaKEWUfD8nVjcfQS7lLtcnu6x/SRuK7toethCXvjm0xUBuQ5qlv6pJwAuck4hyyziRpH+vQGTebLQ5fJfNB13CZi8HJ3fjgz4qTqQbjHLlp38N7FNsuT4s8EnhXSgidIbrsQcl4SS5jIgSWvsNUM6Rk/lmmxTBLLohjBOJnuHlBZVGvJnskrMzWiIwUES8EH0C51xQDy8aAXjMG34zEORfRP4dUYF4zhiZR0YJzoqDW4D0XrNUArIrBuEXT22JI9c1khz6Jtv
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(478600001)(7416002)(36860700001)(26005)(2616005)(6666004)(5660300002)(8936002)(8676002)(83380400001)(41300700001)(47076005)(1076003)(316002)(2906002)(70586007)(70206006)(82740400003)(110136005)(336012)(426003)(7636003)(356005)(921005)(86362001)(36756003)(40460700003)(40480700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:34:50.7058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f06d93-628f-468d-7eec-08dbce099e43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to ACPI support in Tegra fuse driver add function
tegra_acpi_init_apbmisc() to initialize tegra-apbmisc driver.
Also, document the reason of calling tegra_init_apbmisc() at early init.

Note that function tegra_acpi_init_apbmisc() is not placed in the __init
section, because it will be called during probe.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v2 -> v3:
	* Fix build warnings seen when CONFIG_ACPI is disabled by moving
	  tegra_init_apbmisc table inside #ifdef CONFIG_ACPI block.

v1 -> v2:
	* Update ACPI ID table 'tegra_init_apbmisc'.
	* Add comment to document the reason to call tegra_init_apbmisc
	  at early init.
	* Fix an issue where acpi_dev_free_resource_list() and
	* acpi_dev_put() were not called if
	  acpi_dev_get_memory_resources() returned 1.
	* Update logic to fetch memory resources in
	  tegra_acpi_init_apbmisc().
	* Fix build errors seen when CONFIG_ACPI is disabled.
---
 drivers/soc/tegra/fuse/fuse.h          |  1 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 72 ++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index 90f23be73894..a41e9f85281a 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -69,6 +69,7 @@ struct tegra_fuse {
 
 void tegra_init_revision(void);
 void tegra_init_apbmisc(void);
+void tegra_acpi_init_apbmisc(void);
 
 u32 __init tegra_fuse_read_spare(unsigned int spare);
 u32 __init tegra_fuse_read_early(unsigned int offset);
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 06c1b3a2c7ec..e2ca93de6c1f 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -3,9 +3,11 @@
  * Copyright (c) 2014-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
@@ -180,6 +182,12 @@ static void tegra_init_apbmisc_resources(struct resource *apbmisc,
 	}
 }
 
+/**
+ * tegra_init_apbmisc - Initializes Tegra APBMISC and Strapping registers.
+ *
+ * This is called during early init as some of the old 32-bit ARM code needs
+ * information from the APBMISC registers very early during boot.
+ */
 void __init tegra_init_apbmisc(void)
 {
 	struct resource apbmisc, straps;
@@ -244,3 +252,67 @@ void __init tegra_init_apbmisc(void)
 put:
 	of_node_put(np);
 }
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id apbmisc_acpi_match[] = {
+	{ "NVDA2010" },
+	{ /* sentinel */ }
+};
+
+void tegra_acpi_init_apbmisc(void)
+{
+	struct resource *resources[2] = { NULL };
+	struct resource_entry *rentry, *tmp;
+	struct acpi_device *adev = NULL;
+	struct list_head resource_list;
+	int rcount = 0;
+	int ret;
+
+	adev = acpi_dev_get_first_match_dev(apbmisc_acpi_match[0].id, NULL, -1);
+	if (!adev)
+		return;
+
+	INIT_LIST_HEAD(&resource_list);
+
+	ret = acpi_dev_get_memory_resources(adev, &resource_list);
+	if (ret < 0) {
+		pr_err("failed to get APBMISC memory resources");
+		goto out_put_acpi_dev;
+	}
+
+	/*
+	 * Get required memory resources.
+	 *
+	 * resources[0]: apbmisc.
+	 * resources[1]: straps.
+	 */
+	resource_list_for_each_entry_safe(rentry, tmp, &resource_list) {
+		if (rcount >= ARRAY_SIZE(resources))
+			break;
+
+		resources[rcount++] = rentry->res;
+	}
+
+	if (!resources[0]) {
+		pr_err("failed to get APBMISC registers\n");
+		goto out_free_resource_list;
+	}
+
+	if (!resources[1]) {
+		pr_err("failed to get strapping options registers\n");
+		goto out_free_resource_list;
+	}
+
+	tegra_init_apbmisc_resources(resources[0], resources[1]);
+
+out_free_resource_list:
+	acpi_dev_free_resource_list(&resource_list);
+
+out_put_acpi_dev:
+	acpi_dev_put(adev);
+}
+#else
+void tegra_acpi_init_apbmisc(void)
+{
+}
+#endif
-- 
2.34.1

