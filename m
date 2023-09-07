Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7AD797409
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbjIGPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbjIGPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F33F1717;
        Thu,  7 Sep 2023 08:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOmXazedVba9B19B2wpkb6F64MuF1Uqs4nk7Av00nsnPAXlMev4aVRatP4QiU7Mkx7MaCv5cudHk4o6hXaD1GNBSkbjICoNJi0AVMmlIo7bUnE8azStih/1Wp+LieOX+1g3DpN70pkAVX+WXWjGaxb6ITLoMdFnxdIeYX/mQWmdpR9h6/9qvV0RBDgBXfT7VtBb/FSbRVBad6oi9rH4XXnt2xH2XKgh2h11DWAGSCuILMNL2MpkUL4BOqYWLhHo/QHv3aZFtYDQw3TduNhj6UHij/xJClO3X7NHHPHeFr3d56qCAqPre2GNgvLuQwAnDRZm98Ij6Q9VVCM5E039Gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebOE/zjW9GGAjv5RxHROWc6oen2fedyGFfkAkpTfTTA=;
 b=IQSmB1PMqrm+GD2+iHQcDl4DrraClFDoX9qhZDYb9ITLbU8tcNdzS7kOvIPp/4SYR/5HJpWErUXPjZE5Isielj39uxci4KwGlX6GgIjRVlv0ideApWP4Ta7JDjKN1qfdqSKlGB26Nk/sXZSyZBQLsDFGBN0WABSViNnWt1v2vgyscTm0cLzryRAh+weDMALyIdcSI25qH/4Kv02jh8kKOcVu6T2/EIkH3AUu+GwM9raYSB6EJat64D0kbJ8rSBy4TpNHRhGyPbdLdoUC0C5mjgMFp9l8h4C00sT8nBwMAavfW+9bm0mcWWlwFTafwXlLRI6nsA6rtC/UcIHMLup3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebOE/zjW9GGAjv5RxHROWc6oen2fedyGFfkAkpTfTTA=;
 b=jmdGrMBLBDQU7uCzUy7BA6ql2amsqk/3x6Xp5i2uzHHLD/Khc5CyreH4catzivZLdqimDWU9ZlMHZjwnMkOCPQg8URHDP9UM1qP/qQXszRm8z5P25JRDmjAuA2Q9sZubP2HNg3VtG9/HFhTjlB5LpuAuC2R+NKHKDScuBrMg/W+QEcD/UkGkQubi42RxBdcMw+5qGHVxlU8P7M1SOGCooaFPJd1qxs0GW64JSdt0N+5oE6t4xvGHEooNACxJ4Twu63Mvl83ycXyGDbHpEJkn72dYSqhT4mB9UzxNovwJ9qF8VctTlFCDfApZ+yo5V3ElkDOABE9caPe4jYY+LOABzA==
Received: from SN7PR04CA0181.namprd04.prod.outlook.com (2603:10b6:806:126::6)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 15:03:12 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:126:cafe::84) by SN7PR04CA0181.outlook.office365.com
 (2603:10b6:806:126::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 15:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.26 via Frontend Transport; Thu, 7 Sep 2023 15:03:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 08:02:56 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 08:02:55 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 7 Sep
 2023 08:02:53 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v2 1/2] ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol
Date:   Thu, 7 Sep 2023 20:32:24 +0530
Message-ID: <1694098945-32760-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694098945-32760-1-git-send-email-spujar@nvidia.com>
References: <1694098945-32760-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ade335-9dd7-472e-3c55-08dbafb38e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FAQ9Hxc0k6G9UqyVbkV9zjHBj9qE+xBTQx38IVaqKf6he/nkwBPD9tGsRmd+Q0gPSv2ehHR2lTX4801Hfom2umhL0aKR/lY4oRnvHjQTSyGNpbPhsiaL/acOdMO63O++OtUpIxEMkJMzGvTS9LsWPr0Pxl8VJ/WP0aRp+iy82W88q2h7kOIIiI3JxaHLtz78aWYivG9D+gkOH7NrGL7XjL1RP4sdmsiR23Ki+oo0uyffYKcGPlSQYZRZPlY7rEXSweG6fRgVxfjlMLXhvgVe+UCBwvVMCud85tAKV3QgdW+8ijVFvMB9hHh6QMDI5G+gxDHYYj/IWUVKgHpe0zUXg6JeVWPuACyLZL6TTdX90YA8+73i6/XEEL3drRqGFnHe1uKjViyxQkppO+giO22hxge/HjSG9MhsrRUMi0bRKy6oNv98793PHL/0Y9Q8Kv3oyoeWKANAPUnhPVCFPlL/oTBPp5PhrGY9HrRoFk7ZsBHzzsciWXABgakSEQeIcr4MO5E0RkA+Iv/AIEaYyPhSNJ2ls46kbl+rnUVX7WOniUC3VR+u/30PWccI1OY/31DzskjEMk8Tf7bJGWLbSFw7l6t9xyjB+wQAqH3cDEuzS7tLa9drLmMD/zCYIoYBAny1H3qZxcfNeQW39otR53x5X+Ua7LCE1AHP5k8qEmoBr5ca5dUbKxvtTopZKfbChbMxjgh3j75Qqd6ACyQqCpuiCzl7Eq9rCu6QBsR57PzFPo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(7636003)(6666004)(7696005)(356005)(40460700003)(86362001)(36756003)(82740400003)(36860700001)(40480700001)(47076005)(26005)(2616005)(4744005)(2906002)(426003)(336012)(478600001)(110136005)(70586007)(41300700001)(70206006)(8936002)(8676002)(5660300002)(4326008)(54906003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:03:11.8299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ade335-9dd7-472e-3c55-08dbafb38e04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export symbol snd_soc_dai_is_dummy() for usage outside core driver
modules. This is required by Tegra ASoC machine driver.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/soc-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 11607c5f5d5a..9c746e4edef7 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -217,6 +217,7 @@ int snd_soc_dai_is_dummy(struct snd_soc_dai *dai)
 		return 1;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_dai_is_dummy);
 
 int snd_soc_component_is_dummy(struct snd_soc_component *component)
 {
-- 
2.17.1

