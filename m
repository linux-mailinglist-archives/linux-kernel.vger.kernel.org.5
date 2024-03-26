Return-Path: <linux-kernel+bounces-118828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C388BFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D011C28CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB6748A;
	Tue, 26 Mar 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AbI+vVcJ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B51BC46;
	Tue, 26 Mar 2024 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450074; cv=fail; b=adu7bZ7xzH3UO05RLp2hMSlKnTPXhPv2zVJ0aa09chpCFy0J8q8wW7wScm3chnp9aWiqLZNmgx0Mgq7ypyj1AfKwJRDgiiRP5E+bCsu4lvo/gJQHVwi71qAvisa35CtCjddaRZqEmK7c/T3fZaeihlBUYDCB4/RFiWUqfXaBO5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450074; c=relaxed/simple;
	bh=U1wk8y+BhqOMDJzZajcRiFQ8pqMlkSxIlj0bEdBrBmU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvKpAdgxkJvan2Jm5UaCkGMQvudu3zZQ9pk8msfkD2oBjFoHyWvp0TGwJS1/kPNUTvXCkauNWpcF/v9DD3inQN76qZdFyy+sRD847jIHavvLqGQn5tAJyhhJsiy1deNEpfAw+rJaHyF5AyhFecSwD4iSRYEQIF4bqmJUOM9qI2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AbI+vVcJ; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXPDbGraChxYgSbYYJO6h4Ggdfp1k/MI2G93rrCpTpAZF38k+1Ztu37mcPh6Vn6eLM7S6Fx6qtmwcB2QV1LIE9gQ0TWwa0U5xNdzzm0NyUmzBvAXk1vHvLjcYw4T0AqyhFlSmIJz3SGoP5KLptrj6QdKzEVQYw1B5Wr7Y8Ld61V//5gk7UFUvCxWuje4jXy5SwON50OqutkxCloPQB18y2l2tDZQw26BbBG5owLzXk78bgCN5y0Nmu/kds2NgkNgrPCIA97M4OCl7pU2+XWkf//CX7N/XGthB8wzHk5hQtqDL0628fJJNbIPlv6ViBXxXiRAtQiwLRRLmKCF87jRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8/hV0CjDxFc6wzjF4+MNtX/I/fU+FjyLUL0JhUakV8=;
 b=m5Hppgg6Wbm1CAr0icU8XdVHH7tLm2AUOGNZdlv3r5e4xU2j43RTzS5hm6m31FAQkrA5TYjqddA+x7kCjEy8asKxWKN8q2/xG4X8VbcUbDomrMJXzMtLd2u51a7MRMsHJwwz0lVsKbHNwUKxMKPAKQrmR2aJjqIio3qZJdYeDhETr6XlZhtP6SRWDbSA6UC+Utze0vCEUQ390jgO6E9leOo56CaYbOkOWnb0StD4V6LubPN1f3+uWGECCRXpjV/ls80PgqVbdsRjVf8PDzB7/cGzpG78hBLPqsaJOhdHJXJbnJPShS4p4+2zr9zMmXHMWi+Ed8Paeml/m/EEO69AfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8/hV0CjDxFc6wzjF4+MNtX/I/fU+FjyLUL0JhUakV8=;
 b=AbI+vVcJVUUv699Auk2ZLvW04I0wXAKWpX0vnQ2gbVKPixeHwA6jQlHvHJUI4KbQPN+p2yU4g+UTjoQXv0GyQxSYseJqD4esrulNxuBjg/g6n5jlzO9lKAY2THYM07BYtN96Y/ANytQ5UpmQ2pfpfz7fmDrBeTgiRfPkHqUzLJ75mh59NcNnVyL4HiF4YcTpuhbIpCsBYlonAMvbY5F9csscCeIwl1uobHT5qtDARU7CiwPTiS5Jqdw8yaaeqZC5bwUXk6Ha3rypHEjxVOl8+qCB8L/K6KDDX9i5bqSwh1hllJ8gkyQ6myuOV7MGjFNuQ1SCqU51TheyTM8EL/vU/Q==
Received: from MW4PR03CA0130.namprd03.prod.outlook.com (2603:10b6:303:8c::15)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 10:47:49 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::9) by MW4PR03CA0130.outlook.office365.com
 (2603:10b6:303:8c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 10:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 10:47:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 03:47:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 03:47:31 -0700
Received: from build-spujar-20230918T214410352.internal (10.127.8.9) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1258.12 via
 Frontend Transport; Tue, 26 Mar 2024 03:47:31 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <linux-sound@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lgirdwood@gmail.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<mkumard@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] ASoC: tegra: Fix DSPK 16-bit playback
Date: Tue, 26 Mar 2024 10:47:25 +0000
Message-ID: <20240326104725.2895151-1-spujar@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ce102b-f4ab-48a3-3c72-08dc4d822cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k+Q9eZBfTW6v8VOvehv0P1h1geurrjA4BqNWY1OjfsQizjYeMX2WrEt5XzKkcyGvF4UrvLQ1Q8LNm0XiXTonex/emP+iMyUht8Tq3AlFtgPPyv1r9Hy/FTA2X+V+RvBi/1r4u5NabuBDz8XaBhCSQFyrNIwdXWaSFqW4gpRTlWhlER70fHTV/exy/v4vn9D29A4FVXrZ54rFyIcOH0CXz4E5rxbLIcyDcfwWFEyuXn/xfSXJvaw9gSdFZz1oBihno19LE5tBI2CHl42jh6sE2Yu2Lom+8s2snIUmkroTvU/ep8RDcye3cG+Q5Fh6RX9vxqhx2qbKJSsxJlVeBeM7nbrhZyuPSzC48UvmYR8Vnt3hTdaFQ2LTyFmNjw6nV3sNtYZ4ViLFpRVjp9KacV/1XrkchKjJfWAxns44kTkOUXhS6puSWGAGLGqvODEYdjTJQnuNzfVTUVR1CObh11P3kpGhXOAO4gnV4xJW/3ekmjetsD8E7dWJZTWKarj5mhxq7Di75Jw97elc2yE7WnNUrYEzZB97EuxrovqcxgECfVxLafqhwXjFT1Q4wKDg0jBpgGFQSFgwiXKRKTQS0UcP4acpkMNg6vi0N1v4qBQIGqM1W6NFTBEw0toIKBhPKz0Vb0+GVZ8BHm3RFIeqgXaMPZHOLbDDiYLd7HHxSWlvIqugOoqoKNTdWDMVM7RK/dpd5Vxk7SHNXQ8zyKEX+6fWUjqwOdit0B2vGNuldctzPtQldgMSFf+lBIlzc+ajApPJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 10:47:46.9402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ce102b-f4ab-48a3-3c72-08dc4d822cac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

DSPK configuration is wrong for 16-bit playback and this happens because
the client config is always fixed at 24-bit in hw_params(). Fix this by
updating the client config to 16-bit for the respective playback.

Fixes: 327ef6470266 ("ASoC: tegra: Add Tegra186 based DSPK driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 changes in v2:
   * moved common setting to S32_LE switch case.

 sound/soc/tegra/tegra186_dspk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra186_dspk.c b/sound/soc/tegra/tegra186_dspk.c
index aa37c4ab0adb..21cd41fec7a9 100644
--- a/sound/soc/tegra/tegra186_dspk.c
+++ b/sound/soc/tegra/tegra186_dspk.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: Copyright (c) 2020-2024 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 //
 // tegra186_dspk.c - Tegra186 DSPK driver
-//
-// Copyright (c) 2020 NVIDIA CORPORATION. All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -241,14 +240,14 @@ static int tegra186_dspk_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	cif_conf.client_bits = TEGRA_ACIF_BITS_24;
-
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		cif_conf.audio_bits = TEGRA_ACIF_BITS_16;
+		cif_conf.client_bits = TEGRA_ACIF_BITS_16;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		cif_conf.audio_bits = TEGRA_ACIF_BITS_32;
+		cif_conf.client_bits = TEGRA_ACIF_BITS_24;
 		break;
 	default:
 		dev_err(dev, "unsupported format!\n");
-- 
2.25.1


