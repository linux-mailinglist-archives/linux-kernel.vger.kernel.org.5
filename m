Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B957C5173
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjJKLRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJKLRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:17:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6440DB;
        Wed, 11 Oct 2023 04:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+40+o+V0WDK1IDU4kGKMG2KWtp442eF9gU/sLFzQEZ5YzKdRj8a6+fXC92ghg1OEW7kF5Hp3G6p0VUJ9jRZG7FY9AEAEkXDYDGzfosxmLiOwTrRIg9Eoq0dkxF4yDsgdOjwHigKmj4r9HK5lHEVsamJVfxk2gtqQI8hiGdOblYgcEx2idc4bc/AeRctUscSL6IDhPkDhNIj21Zu6A/nhOVlSHAy7tdOwgdmEbdferiS4Mniz3NpfTk56v59oqg/HShfCfagUxuXesnZ639BBWJ2b2Ki2Tw8yTCeT1MCQITlJUOvF8Mc2+dOrZ/JIZlld1ckS2m7bmIK0mzFbsxwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+Fro14rgalH/06qabhLwOLhxQnp+Tg6JsjLLk27Cig=;
 b=Q8fq4ELYY4OEHR0GbbFAUHObqj5i2y6ZT+J0ZdgoZxl+aD7pr6hWzL0UHUVxmZZr6al7VrPfLu1BSqFbqa/817DQ7d/ZrUZABRWzgUYJOpgnC2uQELkHz2j5cWACNzmb/6FsqhCuIxHJpuD6zmOmkGR2rH+WJMoNmfPuwWnPssfbISbxpOBtJFjFxhyqaoqLMEM/N1GxAYpOD/FSOu/w4ZPaQVd3ytbQsZRHTRWPBTcbA+GcbFBfsPtAUpljloEOz5VhsIE7lr+Igj+xCLWkSWh2k456ENyAQaeqD/RQbmVyMYvfHubKh2/5evNrROvWH/LcZeQaaw1cEP2y6j7MlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+Fro14rgalH/06qabhLwOLhxQnp+Tg6JsjLLk27Cig=;
 b=tXYCzHO64jG/fBuk/a7MAH4gReE3nxIX26NOAevDgGs7m0YIXFnQwNcn5yktmE0bFkLv0IYyyoAY0yWpXwmCBWAngYEsy6F91GZd/DgDM+fHPw8olkuEvx2GLpBnuf3o/rpl5FxduFoOk5Z4Y9mfvIPKrJVrETO7s+LbcCrshagIDIJn05c1D6I73buAMlOuc8/7lFJUxd3wAd7flmhjobXZpx6DyybLmb9MT3mTjNuIlyHKukWU4TcIZh1zK4SpeEADxxPTLURlF6P+63E01RsJmOJv5QdGKBfFQ6x1HVyOSTSqh+Y6nQkpQ3hjENCV3e2WIH6xQUdeDSb6khcjkQ==
Received: from DM6PR02CA0096.namprd02.prod.outlook.com (2603:10b6:5:1f4::37)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 11:17:25 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::9b) by DM6PR02CA0096.outlook.office365.com
 (2603:10b6:5:1f4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Wed, 11 Oct 2023 11:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:17:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:17:12 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:17:06 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <petlozup@nvidia.com>, <pshete@nvidia.com>, <kkartik@nvidia.com>,
        <ulf.hansson@linaro.org>, <frank.li@vivo.com>, <robh@kernel.org>,
        <stefank@nvidia.com>, <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 4/8] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Date:   Wed, 11 Oct 2023 15:04:08 +0530
Message-ID: <20231011093412.7994-5-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: fe57b8fe-d4a3-4d8a-ff49-08dbca4ba5a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aA7PdbWy6LrcRoSoTw+RLMu9cPi28pDywdupWVPToK1b1zdBfoah+7bLTwCOmVzWzPCJP/CSDHZ1qr852Rzms+rvVEmRGWCScery5dJKUGv7FtMLRIAhRjgOH1UgLP/MIuOLA1HuFQqcV4hgsBIUGPRzEKvQfEwg0I6IRDNwtTGijhU8z8xCM8fwX/Sy/c/AOBoCnkcgEpXE6Tr7vlNI87+9tOwUJxFlCukTu9aQ82ea7X+rn2P6JSphLTYlgVWQqUoT8iGVGB47p8EWgAgqRiSfaQMEy9vlJy/lPzaZ/4fXHBBBtzIHupNE8V6hTI1d4elqxQkXOMw9U6jRx5kHpr9Nf6NrQ+x1ocV/SsMCW7hjxxEfrgdM2oxq/ycyEfhMlr/jjiJvyK0ImAbkjqq9B0Fzsgx0PP3Oq+s7nnv7Loo0eImUEFr9VrKZ2ooPj9VwaIKmWoGYWqNF9EeEJM1pHgVCco16cJpuWSbZNa3A9izU9hjXA9bAeOUXO20uDeU4mAQQvqaaPw/hvKC5P+GrVGB85Q/982Qyllbg3gi6HNgErYhJHeaoNCaXkkrytkAo33aHE84qaGrmhOcCflFq4Z4cxXbwyX7G/Kxyf+iX/rV4/GeBgVCOy/WT1RSmIbCPFeQD4LVPHXPdF37fo7zfn+M/oxMT1TPx71THwZxvMDeyOyVkJGhyTrAKzO6gdKptg8WBAmQuRdRz8HkLMtjXVDEd0IaOmiiFHXu6Kml8EnvMvYLRHnxWgKZfiH4puxzK2HP3RkTNXdFNUrqx6xlKdLD5fcDH69vgFxNyBhT4U+rfM/Dhi101CmUq5Wi/AYso
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(1076003)(2616005)(478600001)(26005)(47076005)(2906002)(426003)(336012)(7416002)(83380400001)(8676002)(70586007)(5660300002)(70206006)(110136005)(8936002)(316002)(41300700001)(82740400003)(356005)(7636003)(36860700001)(921005)(36756003)(40480700001)(86362001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:17:25.2324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe57b8fe-d4a3-4d8a-ff49-08dbca4ba5a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

