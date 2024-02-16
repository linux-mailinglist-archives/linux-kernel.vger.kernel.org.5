Return-Path: <linux-kernel+bounces-68214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E18857758
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3760B1C219B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED0182B3;
	Fri, 16 Feb 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jzAxK/7M"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AD168DE;
	Fri, 16 Feb 2024 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070739; cv=fail; b=AZ4waYyYwu2wIGXi/0R24NmroaTTVnYOshb1QZuaa4fF5z7guHw92ov1IhbHHff6RGo9sdLm+eMvs2031ZCWE9INzP5fb5ZCHFECdk0b2r/s+TXiPcpOe/sc+E28kgE5Iuc35HxeZ/7wwcO714/8+/IJutt4PcDoE5ds6RUBFWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070739; c=relaxed/simple;
	bh=7dJpkKN1MNrXH+kFAOoK37CPXDTTKrM6aTume/eb+1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H1eaM7RvRai1qxY7iKXQDjCV+iR3kk7fGYKJd7worvzTPMfcT71YRQVYR58KZUNQ/udbaoMYDFox+RIkUcBoxLJU/x/1tdiayzMQEUaC45Q6qsK/z4K3t62PjKdo7bla5nzEPXzTyZ4Y4WksP6b4/KDGF5ULiAVSH4f97k7mdTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jzAxK/7M; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkVUa5nTgECqoU8I1yMp8j0jq2ML9bn3aZHdPM0wY4/m26xPy26BfnEQAXnb8bwJXkJ72i51slChWYFAPJP1sgAUBanpiJ749etlsyWduUp6t70P1/2fRA2HSbIJH1G0puWKFEMthtMF8W9uWsbGpQBBYHxQz0F5z8YVxvw4MsmA75XW5cOI2DDIqvMu32KtYnBygaWfBen0DHvEKyEx4EeFY7k7tRaSfbsUYjNuSi6Ulg/1ktMHPXprXRbt3Xd8zXGcD6J08W4+JZGU17GCTGC8v9n6+HfrH7CIcORC4j2nHe+4FUVkcfmhYa2kJ5GfYWrApemfPz1QefXJWqXZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMmm6YNaWPjNPR5PTOz9sJUCw5u5tb62au0y1+9LB3I=;
 b=KIg/cKJl/VsKwL/yaS2VgmAmlN3hyu1CAdDX4VL+K+SAdHKqw6SFNUW//I4kOECxypkuT3mrOclDRsTpSBeF3xFaJl54+fdKNK4FZjLtDDd9aPA6wsroMNLNdo2Z4KzZFAFzTMzChnCHvom+XqRQS9NK03MflfUvbu6jfsLShweLccFnaam+OzVXIx+EbCxnvbmSMLGyhsXGLhQUaNihgH2QWBKDU5urNWj4MaPYL0J0cMkV3Egm9gt8w0+Xx0QN3xaBKf3is+UjOG27VlvpHGOgjuDBXkt2RYylpC5xmzd2vYr4uddZ4Mu4Yx+3Q6ULzkALzq5Y3ux45ScvVGCJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMmm6YNaWPjNPR5PTOz9sJUCw5u5tb62au0y1+9LB3I=;
 b=jzAxK/7MhCJkToQx5TZ50nolwWawUSKDwvwfDH/MvvVud6GKCGAp2+I4a5AaXzo654rhGrZiy0TSm4n/jxEsLnPW9APF9jG8nqKj2vBwhonmtrMIbITubVtcfZPKo378vSH6dQ0znCpJ2HVi38QhrjON1cyC11+RCE0sZqwwM1kfxznXTHM35CgDv+tBucFbhQNDmAxhOk51j6x+YIMDrl6Fxj/2P7QlDdfvzOTC9PxLvUaVZSvgfvo89xqYZucS+dYhN7iMrtxrvi8VXshEiRRxuq+ieg335FXOl0LJud2LTFZMRxC0hTAogSFgHJuTd/TK6N0/h8eBzu8dWgbIWg==
Received: from BN0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:141::35)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 08:05:34 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::ec) by BN0PR07CA0008.outlook.office365.com
 (2603:10b6:408:141::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.43 via Frontend
 Transport; Fri, 16 Feb 2024 08:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 08:05:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 16 Feb
 2024 00:05:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 16 Feb
 2024 00:05:19 -0800
Received: from build-petlozup-20240213T094703367.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1258.12 via
 Frontend Transport; Fri, 16 Feb 2024 00:05:18 -0800
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <pshete@nvidia.com>,
	<p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
	<ulf.hansson@linaro.org>, <kkartik@nvidia.com>, <cai.huoqing@linux.dev>,
	<spatra@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <petlozup@nvidia.com>
Subject: [PATCH] soc/tegra: pmc: Add SD wake event for Tegra234
Date: Fri, 16 Feb 2024 08:04:50 +0000
Message-ID: <20240216080450.456135-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: aa580e34-083f-4fd6-9103-08dc2ec60d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9MzIabtXNtMZZyU5B4+aPnhgE7Rupb4JSNX6BiFzu10hWsXN5x8AafX9RwmadLeqcC4TiKve0GH6z5RCAr+KFkWXafj4x2pALjBO6XFn0dx2SB53Ut+8nV75xcjVw4pBVPMpC+a5nbcJUUXiJ9eMxW0F3yevFA97xP+73765UzeW4K2k9hPhW0w108LS5u4XYoqIXbfl7hmSkOdWPUYQaDFfN654n7WlGCqMGDdK8JNJPVxU+FztMS3UssY989TS6/69WbhDt/z4uqVNy2mSsSyFrcgkv+MVnHyrMnMROKEFtWM3OWa3Vq7TvIUkZbV9HgudAEqMeRixmj8ut3LV8H0Bh8oHRLLKlbpbo0a21RCicitjr5Zd83spT2YGHS4H/BkZxRErmp3UcO2UQBnK5iHL/wYyE7cjEIEGKlpeuA1ByiEJmgq8twBo9O47zj5IC32lTjQfRWoLdDp7EoZNKywxRTWihdtGyRHHXi0EGk1Hx1eOCgofIdRkN96spsbFEAzGylttKTe1I61sBqAPcJ1WD7k6yAfU/ZdjIDEYaCcegg8uwb7NiSGcG+pUhBabT+BWdN2zXHJ2V6wofkUR0CducbyCzf9Wg3EJtmcbgt6zhcDI9ayHM3yz/jnigtxdUh94YrqT2whMhSfc+SBctiTA0QbYa4gmrRMZr1uphT0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(36860700004)(64100799003)(186009)(40470700004)(46966006)(2906002)(6666004)(36756003)(478600001)(86362001)(336012)(82740400003)(426003)(7636003)(356005)(26005)(2616005)(83380400001)(107886003)(1076003)(4326008)(5660300002)(316002)(8936002)(70586007)(8676002)(921011)(70206006)(110136005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:05:34.4372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa580e34-083f-4fd6-9103-08dc2ec60d9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246

From: Prathamesh Shete <pshete@nvidia.com>

Add SD wake event for Tegra234 so that system can be woken up from
suspend when SD card hot-plug/unplug event is detected.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 6dfcc7f50ece..dc4eab3191c2 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3,7 +3,7 @@
  * drivers/soc/tegra/pmc.c
  *
  * Copyright (c) 2010 Google, Inc
- * Copyright (c) 2018-2023, NVIDIA CORPORATION. All rights reserved.
+ * Copyright (c) 2018-2024, NVIDIA CORPORATION. All rights reserved.
  *
  * Author:
  *	Colin Cross <ccross@google.com>
@@ -4199,6 +4199,7 @@ static const struct tegra_wake_event tegra234_wake_events[] = {
 	TEGRA_WAKE_IRQ("pmu", 24, 209),
 	TEGRA_WAKE_GPIO("power", 29, 1, TEGRA234_AON_GPIO(EE, 4)),
 	TEGRA_WAKE_GPIO("mgbe", 56, 0, TEGRA234_MAIN_GPIO(Y, 3)),
+	TEGRA_WAKE_GPIO("sd_wake", 8, 0, TEGRA234_MAIN_GPIO(G, 7)),
 	TEGRA_WAKE_IRQ("rtc", 73, 10),
 	TEGRA_WAKE_IRQ("sw-wake", SW_WAKE_ID, 179),
 };
-- 
2.43.0


