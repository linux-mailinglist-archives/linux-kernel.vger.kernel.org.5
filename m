Return-Path: <linux-kernel+bounces-71753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC1A85A9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB71B26600
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BEB446C4;
	Mon, 19 Feb 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0MveooC"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FAD482C0;
	Mon, 19 Feb 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363568; cv=fail; b=CcAKBk75J5793THMnnd+MizHH7T3CuGCwLiih/iagtRG8g4k1WAQdYMPwvHDRR8HakFFWNZeMGzu3otkSFhFdXDfOZmKXGrPkRGvzQtD2OU7ZeF6Kp26mE0mcoM13zj3FoCODBoakHvBYTru8qic9LXikoJXJ0QkawZNoQpaBgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363568; c=relaxed/simple;
	bh=6eqcNqMIN3hhMhS9nrdbSBMfZW/xBNN9fKEBNaaApjc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S8x8tXbASN8eF9j/+8+wXelmLOD24GK2spG0i+hnwWOC46hk0ruNuZ3MiX9dQxJkGUL5UTnA3bIBvmUdm9kdGccjxdbGOUdCr+feUmB5VXjIkc2Hne6U5MVz91O/fSSjOlE1FCHlbGxfubHWGGj9VEtSLC3lRUCVYpMXprEVCSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0MveooC; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y//XYKgf2FfIDhDcbXBkT33NZuSXWKtaghmUtJ512ZcjI0ryIOe+83GgdvNBAcRAWmUr8ve+5cpR3wYl+nL4FaVCf6Bm5XlQ6jKoW9wikdc6wnEWVYt33v4ZeN9F52xZISNtKB+M083n9bzzHNYOKHLulRaONTv/VsFL8HQogNfnO61zICwfrNC40w++n6A1Esai0FaXxYcayCbI8FCUwXLenMXiSZKQjyLGUv0lXSffNUqCDMAZA3LmsZw+rJ7GiAfoOm/xPGCxrIl7G9bWafTQZFG1emk0Ba8QHk28oO2oc2U1QstwwrjEouiMWxOZ97f4TWp168mUUbDOMNSF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irmUWWBwz5LD6tafzqLlC1pSCXCF6FsXn1OzaSGMaQk=;
 b=h8HWozvGr6zn3v8n2yD6p1gXtE1U3r0JPvW9eF1NHnqeHldkIrp1BAqTr/XpzbV0d0aHahRGi+TpgxpBlUi1XxoCXVukgbdwTiLjz1wXfr8IAYK8UGULfQgRxG8AmUXV5E3J7BNVfBr8Kvby6Wz3jLWj+NO2DsATpVSp1vS6FP7WPAVaDTl/goOVJbRH80Q39bO3mah5qAehmkrw4YRlpnVAb7oFfhhzgIoLaNiUpjbXMuy5mCk8fmjWI1ymwJ25xda/sDc94RCtCWJ4DiDssglE3N/F3hRoU8GvIOI9suYf1YigdjY/XiMvVPtdCPlvUj72CFlfhptIGQsObjsSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irmUWWBwz5LD6tafzqLlC1pSCXCF6FsXn1OzaSGMaQk=;
 b=c0MveooCarkvU6iU1r+bvmfV2dLz3AYoOgYmo/PWI/k/w57y9e7v+K+La1an5gQwSlGCIAxRqqWO1zb0g92N+ShzfFkXEyCwvl0qqD2zXzrlby0qbQuGqhji5tDozAVGq8eggVqOjfD1+eYbeKpu9vDVRm4WkDcQI8tIx3Xru8QRBR2vxFExqKSHtXFlnnIDzCRobCVu5Eq6RYrGUv0tQmsZUStTDqoWaeKEyo+iawY+SWF4uqJxqJ6GiY3N87lI5ZMGgraAIA4+tV6GA7j+T0bYnJsZ+txxCzk5w3D7Vk8ZyfT4KSqRpUNn+2BMEcGkiD9MPcf7EItNn3yVHZMplg==
Received: from SJ0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:a03:333::26)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 17:26:04 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::b7) by SJ0PR03CA0111.outlook.office365.com
 (2603:10b6:a03:333::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37 via Frontend
 Transport; Mon, 19 Feb 2024 17:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 17:26:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 19 Feb
 2024 09:25:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 19 Feb
 2024 09:25:44 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 19 Feb 2024 09:25:40 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 0/5] Add Tegra Security Engine driver
Date: Mon, 19 Feb 2024 22:55:25 +0530
Message-ID: <20240219172530.20517-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4c12ac-1780-4b8b-c01c-08dc316fd96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kvfTDLc3RRyMU/stZxQuR8ulc8zXEAp7UDHVWGlgmtWXxKjnpnnc3UkjF6jeMNQNzHWe65OzdFyM9s04PfMaBb9GZ6uwjow0oQBEbiLzGw/Q5OvHY9NyRCA2x3zFxK/9Bo7JzRuFVHO3bopwOdfcoBGBuqlQj52pBttp/5r37GpLvG8xighU8Pw/dB2h8X1Fgeyv1It1xfwMZ+1AQ0kVAEGq7JymbGrmO6e9v4WaiNPLER+yMXe8xTLBfQ9+65WorXzNg+W25SZW5vqGT7qFBsa9PUriOSJSP/697J6POyU7IR0TZp4zzfSIp6kBu6x4z0pgTXtymIt9a95QyrpGJQsabwXI/TgLJzabef24QnfUYwISSkAoYrxFmIdsAzcZdrmDodqCG9F5tUmbGHXSRiA1evVqPG35emjx0oEqcT0Jl4ugyeV5RHIuFeQ9g6WsDN81ESof+4ZfBZhUZelhqjYoOK6v/dMBxancrnk/V5ZSXRvtp03eIzreRAR7rHR1HFoW6TuQPSZe3UHk/68OYlIAH2evm1rmo7PMTGzIKjU6QLs4PEPaQ+bI589nUnuTM7ffkI1tiP1CPBoTW9BFcu5tvOgvOglpPf5W5lmais0A6hl/gmxM9T6RtwYOvH/cnz9gMrrqgcADLBfWj8ey8vfAJAlt9XwTSnn6nVX34quNv4dp1EZxuDwWe+nGEddC
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:26:03.5894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4c12ac-1780-4b8b-c01c-08dc316fd96a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461

Add support for Tegra Security Engine which can accelerates various
crypto algorithms. The Engine has two separate instances within for
AES and HASH algorithms respectively.

The driver registers two crypto engines - one for AES and another for
HASH algorithms and these operate independently and both uses the host1x
bus. Additionally, it provides  hardware-assisted key protection for up to
15 symmetric keys which it can use for the cipher operations.

v4->v5:
* Move copy/paste of intermediate results in export()/import() to
  'update()' callback
v3->v4:
* Remove unused header in bindings doc.
* Update commit message in host1x change.
* Fix test bot warning.
v2->v3:
* Update compatible in driver and device trees.
* Remove extra new lines and symbols in binding doc.
v1->v2:
* Update probe errors with 'dev_err_probe'.
* Clean up function prototypes and redundant prints.
* Remove readl/writel wrappers.
* Fix test bot warnings.

Akhil R (5):
  dt-bindings: crypto: Add Tegra Security Engine
  gpu: host1x: Add Tegra SE to SID table
  crypto: tegra: Add Tegra Security Engine driver
  arm64: defconfig: Enable Tegra Security Engine
  arm64: tegra: Add Tegra Security Engine DT nodes

 .../crypto/nvidia,tegra234-se-aes.yaml        |   52 +
 .../crypto/nvidia,tegra234-se-hash.yaml       |   52 +
 MAINTAINERS                                   |    5 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |   16 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/crypto/Kconfig                        |    8 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/tegra/Makefile                 |    9 +
 drivers/crypto/tegra/tegra-se-aes.c           | 1932 +++++++++++++++++
 drivers/crypto/tegra/tegra-se-hash.c          | 1048 +++++++++
 drivers/crypto/tegra/tegra-se-key.c           |  156 ++
 drivers/crypto/tegra/tegra-se-main.c          |  439 ++++
 drivers/crypto/tegra/tegra-se.h               |  569 +++++
 drivers/gpu/host1x/dev.c                      |   24 +
 14 files changed, 4312 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
 create mode 100644 drivers/crypto/tegra/Makefile
 create mode 100644 drivers/crypto/tegra/tegra-se-aes.c
 create mode 100644 drivers/crypto/tegra/tegra-se-hash.c
 create mode 100644 drivers/crypto/tegra/tegra-se-key.c
 create mode 100644 drivers/crypto/tegra/tegra-se-main.c
 create mode 100644 drivers/crypto/tegra/tegra-se.h

-- 
2.17.1


