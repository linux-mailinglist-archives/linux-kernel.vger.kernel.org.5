Return-Path: <linux-kernel+bounces-132845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B711899B13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4861C20A25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5096528E34;
	Fri,  5 Apr 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DH6QKe6r"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200515FA6F;
	Fri,  5 Apr 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313807; cv=fail; b=uuVDyuN5qafm4rASgfwARhyHIyXm2697fBhxHtAV4TCtiFZML0gzjh4LJpDMnLw8N23FWm6pWhFqbUF9nRmsADGswwey3TO7i9gQY10y56qmS2fHyZU7sIN2EnRAuew+thMBbj2l1MwU7j1VQG4rYIK2BJ61EIxrdb2KTNl6Hu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313807; c=relaxed/simple;
	bh=1Bk7C76y/IMNMtP+wiu8AtrbSmwK+52e56gN9xmzSc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KaNLvyooXqI+wGmEcOjKMk1Nt3DUbuhblKBvHRAZuMxlV5ADQd7qsFAFErJANe08PJbw6+8bZGUnQe/qn9ukMfKr9h3GqT91rVdVw0JLrCuag7s51555NPlIeRqwH2JAVkHmAWjnhowKvrjROAHTrcWSn6GYI32f9A5Oz6b8Yig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DH6QKe6r; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD55jBPF0NSbQlGbQxd1ZexsY9pif18zbX2v5ynYcEdCUnhRESzoDJdinn6KWqOZzqldRzQQATn0aXIJxiJgjBN02CQuyM8Zc+/cJ0rJ2d5OjT1Yr1j3pEbv6K0WyqpZLnH2bDqwd34ii2Syizx8CzDCMOlFTJec7VYEqDAy8F91Yd8barvP7w2eOF7P9NCrICxuZex6n8WWOFu/7aE5oWkKQP1AeB9vQTOSxYx7M7XgTEor53fWDvw7QzrsUMYAUhYVN0rpngiVPNwXlQu1ei7E5taxApjgBgwCshLHaZlSiIPss5LGzf7YQ4EUZolkOxHgp8FKb48EevtW9bEMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8/hV0CjDxFc6wzjF4+MNtX/I/fU+FjyLUL0JhUakV8=;
 b=IQoz5Hl3P6AaeprCyFQnliBhKdlBL0tMGy/PX/M9SJO+yoRkjZPDZTSZCnRO229OAytZibKGMDtpdKjLac/kK8nBI55tJCZB0I49OI0qn7tF49/jYtn+Qk5pGH9/PJWI4049UvFqOZ0F64fBTktYPa5ItH1u9s3MxG/1636SLA2u+Lo5/zVOL5SXjgY6jaOBjnbg6NxhqD22XzlpfjN+9py4yAbvfd2xSKdyCaxqmGtj5QMQl12h3oFxJFJf69OX/56mRKwFBJuD+il9Q7t3I/pgjCA/3VtXvir9+8rh04e0p6EKBVWBgJRwCs8WAF+2LCYxOyILMeF7CuoOaIlesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8/hV0CjDxFc6wzjF4+MNtX/I/fU+FjyLUL0JhUakV8=;
 b=DH6QKe6rONcufA+uFx/OmAm0WfR+/j/OwgOkzyl2+XzaRZ6BRttj6iJ0VF0TpQ2lG/mDgdYrh+SJp3x3ThUkVAgCsG7tnv5ziDCa6+6bWPr/T0/zvTz8xvKQSRknPFNeleEfR9gSdOWUGbiqQvxHcCdmBYOkwCm8JPMLPhyVHREw49Md3pqdzplEXJ2BaOfh3FJG7gY6Omk+foHA4FqASPreq6MjngXkLHe7/o661sWVWUoVnrx21fLz0IKJ+h4n5NhfdtRnlTvd46bmb84ZUjz2MIf4APwpTHD2f/uZpxxmwUHH9EFXsF6vAS1f3r/L3GnKPVfU/kU+TXTSYw48SA==
Received: from BN9PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:fb::27)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 10:43:20 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::3e) by BN9PR03CA0052.outlook.office365.com
 (2603:10b6:408:fb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Fri, 5 Apr 2024 10:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.0 via Frontend Transport; Fri, 5 Apr 2024 10:43:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Apr 2024
 03:43:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 5 Apr
 2024 03:43:11 -0700
Received: from build-spujar-20230918T214410352.internal (10.127.8.9) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1258.12 via
 Frontend Transport; Fri, 5 Apr 2024 03:43:11 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
CC: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lgirdwood@gmail.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<mkumard@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [RESEND PATCH v2] ASoC: tegra: Fix DSPK 16-bit playback
Date: Fri, 5 Apr 2024 10:43:06 +0000
Message-ID: <20240405104306.551036-1-spujar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: feccb9b3-a9e6-499c-424f-08dc555d35a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L8AhV+yoiS6+Z+/+Zm65eJLdN+aM7+Hxc++f90ga3Mx9VqgfOakxSM7vTqJj2k2u/nl/n5ZHW+/Hd8SkChn6oNAfdMKiNeSUgEu12vWTTBD7zqCx+eT4GWtY37wF+LMLBvsLt75qQ5wjkbzsNpZRZYOdn/qLtD80JOVAydzKhWQBd/3QNM76WeCdnVjwPE/lmtmvOBYoivrwWfyK8L1Dz3O8FeJXrmOMVszoVzKi3rousJVmLEA9R09nda6ZA0RWjTGgQj86npfKFdDKWCF/mGPF40Yw+g3gi3P1ZyIOIlAwJHv+j5G24uHoD3hsM0k/6jtJGe4xlEPIEcaaOVrDcHnZUj93Kws2VK/NKeBVlHCvAjgWMKHLk8WdTQihiFMviVgylv/ZM8zDv5KiRqrBK411sulmkugTV64V6dfJFQjESk8fJEoFRpbAHvDb7Ex5rev1yS5P6+p6omVlfeW3ZjLuSsO7RjHXBGZPd5Aw1Nx9sfdBI4oiZn9tqp8mMWs4fyqm5xc4vZonyC1SmD79KEcCgiP8i80igi0KmRAEQ8OclXopy1GEJUqF4VTTJ+5c4i3fjrB8nmDY0Dol3T316R48bO6FhNXX6zatj3aYC+eQgVH/qBHu5nyHJW5yYBBNXsOyZp/SdulUWvmps8+LAFsKMCwSGVZ2RGTUzNXf4hJPObxO0d0T/8450eB6BPNZ1qjqBizfNTSmBK2565xv9XreDNfp+XW0rPv09Y/GSJSftbQuxGg/wabjE/VMFmPz
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 10:43:19.8275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feccb9b3-a9e6-499c-424f-08dc555d35a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198

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


