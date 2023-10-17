Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE467CBA05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjJQFYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjJQFYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:24:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21173100;
        Mon, 16 Oct 2023 22:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coWhvQVuiHPc8TNeGTSpUfloKd1cWm9GfCD9RiPai2z9Y7vka/c34WAKP9WjgD4WvhW4WFSRKf6p032hx7zSXBpqKlqqjsn+t6Mz8aOyPB4PoB0+B2onhQRAuUpopm+Pdw+Rk7ckPhCbU+eXm6O5mtfZANWdLaJuM1uTNluZ5HeH5rAb141Hw9jZFJPrQc8Hg43QpelhKvIhev+TS7bWzw4kzUX5TeBowyVvq+BBgkO3RO+VgnfldOaMZvsS/JDoTVM//34IxV0yc/05G3HQH15CfQxxyfFn4Ew6WzoCx3rZdVpXy82NE6PzxBWYhCakd8T74IkYM7FRC/xpSnPPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Huwxg3aaNBgwNNxWl7rYicXbXEr+ZCJVJJKyE4DsCNU=;
 b=K4RcV8IdENh+rEt8q4eEivHBv5+8C/lkAU3eAFuT50EybLO0rD3SwS+13ZzesC7PlOuZd+11xuv91+H952kKfCx+Mw6B5VorBymmkGMZAL1WRi3tSx4yb5mHsGUtKyr6D7p5gBsJj0q9gs8sbjz0M9OznpJb6BY8EyoMsfBIjFZvrooPEZv1Ppb6QhCayZXKI5J07lvjl8FWwLN5I7pR8eaGqOOjpNbonalKgC2SBJtddG9fRiOjQx6THUJ6FMlCDBLIsJiwfov2l4rU64LqpIqIzP2iBi9X6GWabZPLr56nb0F2IbwUCMrSdooDeUPGPAH5lvv9NU1/LXjupmi8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Huwxg3aaNBgwNNxWl7rYicXbXEr+ZCJVJJKyE4DsCNU=;
 b=EQcix4wxtq8PeonDfjIFh4Mt2CnYYG1YBPb0Hc6zSQYaWm5FMJirGnZnlhV7z0k2TYT6Ern5tMPoX5XoXVzBsU3fh6GEY7/SzdDd3Igit5bWZUzVrwEzC639sKXbO+rBwnP/YC5p9/jd+hRTKa9Rq4Os/VNHhUrsgjNc0edTSiopsUUlBcpCBED5tJtniR6ZW8n5bxX75YKr6eXryWeEF4MjTgqBhSoc/EvsREQNvO6rxuT7KorRQGblbGbiNjP58hkLnrUdAPp0PfR2VHJzLDR/5aLZgsDFkQDZDv3g8sBdXs6guEax9a+7cmvBOuHpsBkolnb+V5R9Bbk9r2Pf+Q==
Received: from BL1PR13CA0356.namprd13.prod.outlook.com (2603:10b6:208:2c6::31)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 05:24:12 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::e7) by BL1PR13CA0356.outlook.office365.com
 (2603:10b6:208:2c6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 05:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 05:24:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:23:56 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:23:56 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 22:23:50 -0700
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
Subject: [PATCH v7 4/8] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Date:   Tue, 17 Oct 2023 10:53:18 +0530
Message-ID: <20231017052322.2636-5-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f92d06b-939a-46aa-b034-08dbced14be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnIBcqdocDIksvFTeYMVv+MSxraqllpCbnEk9/8VZifHzrRoIK12t/lSzic5n1z/1kOAO0rxj4nBt09NIxBGx8LYDh3UjD/r8DHPy3z3uAdrZHUk9J1uUU947kf5IwSRywfFeWeIkEBYrZBj2KIe6HQM9iNQtNo9BWsh/8I4FtS6t5/EmFvMEvv1JEkGubFB7pZJhddFxGYf6nTMz2t6KD5wq0w2f25lLTO7mq4BgMYX70KgLpPyEkNQVKv25KI6NH0kZAT87/n6AKU7uBsssDvrJkp7Fs/ddFhL+d59oSMwCbQu5eUxFdfBMkzqQDGhRMNVm4Vlz5ZAAAgJ3mRp67ru51FUbzNJJzaRzyk7IG8yGdVSouCw9Q65BgIrK13IaiE3agK3yUWSZLi7/QCHCHY/8befmxv4trVLxfoAojIO4nTOhj76SOozgiZwEHwPGg57wKKeUli6cfwN0fIRCuwOiDhwrhqX6qAqHkC9IJbo/KK6DuG+wo4PI26xyxGK4m9KQtsvgjot7Ze/kHbcZdRlB08e+kIJ8/AKd8IxT3BpHAnEVHdMiCNxn+tf3GqriROTkDtyPl/UT2kVqy2w9Eat53HXYmHWrSA1TJ02F9igxOtPyCFgzEzNlMOUW2+kz8EFEWne5yCuEuTFj9gxa3sJi71aPQIDqSpS2qCHY5iSkiUF/awM4LwDbXGmhw4iM709cLuoVrvojpiUMEXUCZS6SSMeljRhIdISd596Ug2gibZZV4qIGxsuk9q7QIt2VEniFk/VxXQAQLWjoYiMR9T8ViRoET3cyF2ZiMPraRWqvzeNfjSbm0JYZGIjRXs0
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(110136005)(478600001)(70586007)(6666004)(70206006)(26005)(316002)(336012)(426003)(1076003)(2616005)(356005)(8676002)(8936002)(7416002)(2906002)(41300700001)(36756003)(5660300002)(86362001)(47076005)(7636003)(921005)(36860700001)(83380400001)(82740400003)(40480700001)(40460700003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:24:11.7634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f92d06b-939a-46aa-b034-08dbced14be4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
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
v3 -> v6:
	* Use resource_list_for_each_entry() instead of
	  resource_list_for_each_entry_safe().
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
index 06c1b3a2c7ec..6457f80821bb 100644
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
+	struct resource_entry *rentry;
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
+	resource_list_for_each_entry(rentry, &resource_list) {
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

