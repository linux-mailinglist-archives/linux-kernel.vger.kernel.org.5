Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724997CBA02
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjJQFYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjJQFYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:24:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C2E18B;
        Mon, 16 Oct 2023 22:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPQhZNoQfH438ktxoAnnaK7S7kz5IbmdIqw34GyWxTYv5RFmulni2SyDyIj8eswUG55eAyhrx0e75SYoQG/6sBirT+3q4HR18xkPHokgqP9bWskzcRRT3cuX1nN6A4Pzr+CHa3O7MRtVfwB3MWFz6h+COSIb62DxqFwmBcsF2QKOViwOUTNctR/9f+afhW5Oax9/O+pB141ho4zMD6DbEFWwkjCchM3lXKWEunZYyU+UPEx6B2Mh9CnY2+yG3Uep416Yn9bII63Zqqb07gL1upLCF5G9P2iQTQ7HXNgMhzym16lzweIkXRyDzI6x4d4frjLzB9JQRDz4jHJC43znNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=btWo6ZutRZnimCUFA57qWDGGWjAtt3eX06d7eIo2kp9WzxWYWhlP8m+iWJ8/MQYiTVEjyZFDNNKN0x1S8sAPk80FB3b0sV5w38F9N3gwbkxFu6pN/d3IXKuaHzUSSC8Q0xo1DNYOBNViM29Oa8XVci4pHWr/KP6U0PJNOCBKuVhQeFXAwJeSPFzzSWpivv1k9ysM9tRlzAId3HD8VI6+yV9yZiAz3A9HghWgWQZsNBPAsDEB+aVuzhc2O/VKdFFf9K/gDFBagEOCttmLNwKJnadmgzAa/uSc8WPDssyqdKOcyRj2A3xQz4Ep9qCbKlJBozyhqxSrvPttUBrVdUHVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re29ps3AiOSg4y0WBx8YIBQJTME/7AeggREHZrD4b44=;
 b=s5GMWs+FQD3yFdRHu0A/0N1IJRuDpao69pKBMLXmMsnasGYJgyFuB1P7MnrZTnLeBQ9yBcflG280J/dsPHPFQSWknZhxhwwqIgAZWT4inv5sGWj8Hh449tU4YpkkzGuKVTS536LoD6yK10iYfE+iH/h3H7JvpkjgaJO6u6NCNIDSdruZMz1IUL9WbD0PXIwdSffxxBTZDH5U2rXcg9x2ixUNQgM5LAv/0l2wgh4YVRwWlkGkX2asvHfJYlExaJsx9HTaNDX6S18g2E3+7POz7u/nwZiysW+6jT2XRNDtA+D0Sgkp0CZLMnQ/NjjSUsEs+80G3vxaj2F0ed26xgJETw==
Received: from MN2PR07CA0025.namprd07.prod.outlook.com (2603:10b6:208:1a0::35)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 05:24:05 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::8f) by MN2PR07CA0025.outlook.office365.com
 (2603:10b6:208:1a0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 05:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 05:24:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:23:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:23:50 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 22:23:45 -0700
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
Subject: [PATCH v7 3/8] soc/tegra: fuse: Refactor resource mapping
Date:   Tue, 17 Oct 2023 10:53:17 +0530
Message-ID: <20231017052322.2636-4-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017052322.2636-1-kkartik@nvidia.com>
References: <20231017052322.2636-1-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: baa1d92c-297d-4b7e-2d24-08dbced1477e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9zlOvhayUrpxVfM0pMASmmoYZ2VSpAWk91JGlpksNauRLI/fjcd/eN6IUPpgbQ9Jqgoqhb5Q2/vsaT6ILztWxoS2s2LJN28OraqTnGqc7TTrucu46TeqDQYBNjWEt0wcJOWAvwFcjNnc5tVV3KHh6apBUrg/lNAWkFraFvF1sz/OJadipWLXcvSB2KcTyZdhb2frHo/Uqhki7l0u6KVKmd9qnhVu1Qob/CY0/S6UMr5uyJltGwXy9cEfUFZgE9LiWdlAVOafAd47B7+q6ndfDnKHZWyWqTWbEeGN0ulbCSThr0ovZeL3rLFuv6xJg2/e2/n5UP0jhn/o6zgdN66XARIX/ADyAH7hPqZwO5124EiiqyY4hTt2LNS9K/xg8QFtvnodDhuRsNPOlaUQ2T04A64Wrcu5hkJc3Jpn0ue9o1g4nLpYkmdW608ut8Z4qeVebdzeyLI9QEQxoF2zRHXVKIHPcDeFzznbwGc3w/nRztGaU0KF5U/HyxClBMlZGqP3zO3iuRDvw0sCwwdklg+EGqIXEt6sq5PZXL8pfQ48+TT2OOJRB+X3ymKs2Xqxwo9jgMdmNk9u2q/dOtQyWt84mrpMvgVwDb/UpW5UBJ3/gYyQi12fdu20tRY9IdU+ulbZkjN1lgMrjsws7Vk6rGQGDiRELOfOPQr9Bs00q1LByGrEbPsmEKte5F0iMdtDAjHA5Z1UnNmvEVsObUWmM8X9vIUsI9rNfrdFSSyN2WhU911XKidSvgPhSDHni3relNRUlO8o19UjmaH3z2OAgnoYCVTy1wkxjaFaiXTOGz16b0sk1zSIHTv71YYMESpKLMV
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(478600001)(70206006)(110136005)(47076005)(70586007)(6666004)(921005)(7636003)(83380400001)(36860700001)(86362001)(356005)(82740400003)(316002)(426003)(2616005)(26005)(1076003)(41300700001)(336012)(5660300002)(7416002)(36756003)(8676002)(2906002)(8936002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:24:04.3807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa1d92c-297d-4b7e-2d24-08dbced1477e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

