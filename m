Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B80E7CA50E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjJPKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJPKPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:15:32 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7743123;
        Mon, 16 Oct 2023 03:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQYu2kY1U5G5H+F8oY4M+GmA2enH6EUnbNNp64joTtV926fZdvrTLc/bf3GihX3PQmndXNtccqZ+lcGNUxmscZX67gX2ZnvQsuM3hfRNyMYZg5KhrHe804/QHOLxsaa3CdCVRZARMgKo+w8bRQ+1iUORcL/PzIfZ7wwDrixu1n1QVtpo7PnsRV6v6WHRwqiGnMJ1egWZBl6FF1ajuXNyML68brME5x6uHDZ0h47FLRNJGQmm214uk/Z5it/OwU4NsiaKmCf3+5xnnn1mobP6h8bUPKDac9DbG0fIe2S0A4h/gkpcOtlqXuUZveAwrDU8OOdwy4p9BJW7kexsfhl8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Huwxg3aaNBgwNNxWl7rYicXbXEr+ZCJVJJKyE4DsCNU=;
 b=khI81Aeem5EyyAMCMHBGrMsCpN6TsSN8ZCnDhi7L3Nw7WGSTa4h4uotHV5v++FqP04rkKIK0OYWJP4VGFrLqj96GIAocsEeyKYW5GovR7LC7Hh9wnRYceObpu29gs2dLvOeZdSnFuHYxE8E07ldVS/eP6v2r880ysxq1YruVnEVjHsBdZbZpQc7GvDSrG1VmIkjrjUIXMNjdApLT231/nwLXgsBb2sm6AdZUh+qk54D5UTa1Pz1j26Lvu0a7L3ZoFAzI2pUPCbNYLHN5/lja4ByyH38l1E99KR0Z6sDnyiGQJ/DDYC2CV7Tiv9nmjFk8ApQ91B0z4649H6CSe2U8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Huwxg3aaNBgwNNxWl7rYicXbXEr+ZCJVJJKyE4DsCNU=;
 b=SoJ7vhugt4aft1ur0hmCyj63dKhf0J1DWWPKT2LT2rjl/Isxa4B7nZZ23FDDA9nul8xTVrjV+KUTRLVAntOvmjX4GekLOOqiZY6mcHw/uR5j1W4rMQfDoVvh6DZHAJ4EEzsyxQ7Sgj9mhC+1ODqrzeWZBZE+wrwUJ4GXgYkktDKcELoOgze9bAMjoK848zn6dVkCWhWrJdIetwjPgavLZxbQknYpuu6pH5JuQigSR1+Tf87fOoMklKUnO0inXlYVdm8e3MLJPWiSdXrbZybz302vC6y88AoAaT0bREAjd+IbSr0BRZ9ZrMhOTcv2FX6L/29fPldFZZY0x6TXfrDIjQ==
Received: from PH8PR20CA0002.namprd20.prod.outlook.com (2603:10b6:510:23c::6)
 by CH2PR12MB4876.namprd12.prod.outlook.com (2603:10b6:610:67::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 10:15:25 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::fc) by PH8PR20CA0002.outlook.office365.com
 (2603:10b6:510:23c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Mon, 16 Oct 2023 10:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:15:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:15:11 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 03:15:06 -0700
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
Subject: [PATCH v6 4/8] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Date:   Mon, 16 Oct 2023 15:44:32 +0530
Message-ID: <20231016101436.7146-5-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016101436.7146-1-kkartik@nvidia.com>
References: <20231016101436.7146-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CH2PR12MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa599d8-4bcf-4453-fbe5-08dbce30d057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnXXmtuxgWYd/mOFSVEgjRhlE9vZwtFDy2fyzT5Z1VSzLs/6QCVp8eXcUQxDFpMF/J+dTS2tc1L63dnR97wTfdvpMPdKWvdq3ryevT+FWz2C+Ah8vpJzjfOZxpOI4oTtzV6yzEsJNNfkqdXy21pjTeyQ0oOvDykWoBgH3UAeGxdOlB1LoQvR/6QurwXsEvec6q1/G8IIM1GwuF+j88ctmWQbFU8K40svdbnF38MxojeGToOc6ojTk1Uk0Dz7doJPIuh6ACPIEZvVWm6T83AwoMKYaWe3ovWi8L2EZrJfC7ktrlDWCXQOfjF62g85D5EY4HwJ0PdwtP/FZFxag/MRM1cfzwESQCMEjZSwSu3rYmqrgKSIDhKNrtMknwwK00STNLqEbE6wt10qRxJg59nYe1qVr73x4HopE6Ax7isCMVToYetaDlsy8H8u7zmXqueqHEThe0/5DD2ccqk0bYRI+PXph7DBZwMaqnxn+zXIwUtDCAs6/e/hwVD6pllPireiG45yhVcePlms4CZ+gsXOoGJJPIL4rKONd44zKD1vepHwcFLqU0OB3mA/JXW9tHvtzeMAlUJYDNdhCkUxTFT+Rd74LQtlADbhWaehosvLZ7RqrFYsX4qhurdKx02AKbkc9aLKN9YXLI68UWR5x4tvnooJXV5bptMVB0CDWw4zzwpBllNa1zPE1Dw0f+PZLwPwRemjZ8u6bqulSDyRE9IBi7IaVJtxrdvfUN1UpeIe3ekW6qkQ1+5KB67Fsq8k51lkAcXDIMzL+D5G1CarG56X2UOSbuelZchOUrfdMyExy1oaLVjIyhB97EmoRMVgVpST
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(82740400003)(36756003)(7636003)(921005)(356005)(36860700001)(47076005)(83380400001)(6666004)(26005)(70586007)(70206006)(316002)(478600001)(2616005)(1076003)(426003)(336012)(110136005)(41300700001)(2906002)(7416002)(86362001)(5660300002)(8936002)(8676002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:15:25.0517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa599d8-4bcf-4453-fbe5-08dbce30d057
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

