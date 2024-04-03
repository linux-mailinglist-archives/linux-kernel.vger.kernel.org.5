Return-Path: <linux-kernel+bounces-129470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1581896B47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C4F1F29812
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9C135A5D;
	Wed,  3 Apr 2024 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vs3rG+aK"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C147135405;
	Wed,  3 Apr 2024 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138483; cv=fail; b=Ztd61le9FG4hbeLUbqlgBm7CUF7gPw7ntan/dvc2nHHN8KjZcAFzUvO7sSOTPrKHd6n31xKx+7IaM+Pfame1yfcxG1exbeDRng8mUfHw5avmRKjm11vSwOWk53CxIiCFjsDnGIIsZAreT4dG+ULtVEGFS0M0l8fXLf5RbvZy17Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138483; c=relaxed/simple;
	bh=qRcEjrdWwqkGGVZloK+maEf/zhvVuXqoZvTMBjVHlUE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lre5lDk4yrvLE/9eGj+9x6SbSB5W/j1qrsi5PSBMEldiq0xiunrm5ZdsaQKJhkDbqZ3YdskQzcE2Rx/yZ1fxv2JEoU/ZZroGcFVUUrG1WG5uxiQ0kc1KuvRpbnoqcE4hZuVZ2USaqaeVry5CvIbWm5IRS87K1bskmhapklW42H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vs3rG+aK; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVNQ9s6g/DX/cXLxhC3EdZURk2Drlr1DwEavso2y+q+EXqagpJQ/vlKKcEA4rzFTDm8J/DsNolALtUYAng/HDwfZi1WjFdYCvviXIIwRIdbJ/7bHw/HalHzKv6Az58+z0JPkgjDf9xJOpEwsjJfsDegFxU92nyHNz7aJYIbSThClavQse3LxNhch/5MoLh4Hl1LKHO/8txuttwxJUXHFjfNyNLYx1hHDKBXbbeMIJP+i2ywTMfHPDAQcOLXQqdo/3uE26yc0MdkYiUMSCgOI1pf6ypKbBjWt58H0WIR1+MS0bmhmeHaJGrtJWRauQ1duYnfGJrmZbvzr9Qe1v70hrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egAVd7N1brwmQ6m13nvCT5Ot41J04KNSDuLqKvaNUdo=;
 b=gS/XaehyCU7ofzuWh0C3wkzwnXWVZETXzrq0Al0fq/8BiHMJKzOMSJrTh7L8eujWhplV6x83FkhWFqOMmZ5VuWWaHrvHteg59941UMCwbFtR5PEzGpLzy4IZTbQrmHh3SGAQN/VtRQOftteRC3k1xihEzBCiFPLdJGqIQFws5a0ZuXW7Es2zpzCnnj4JYjx3ug2er1mlv5jW5GMXzO+ty9OxmZ5ehM63R6f9uMOHMbAW/7TWwGqyr/2i9dKJPZM6vKBmsr+7yXnQJ89Rvcf3rZY3Th/pi0luRLacnuN2qs4c7tgCtIumdKP9Ud6RxgunpcHvC0VnEfo34p9Y25Bt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egAVd7N1brwmQ6m13nvCT5Ot41J04KNSDuLqKvaNUdo=;
 b=Vs3rG+aKahTN0rwic2zPRuHkFoeo4bKL+NHJq6hipahdBY2y3DBvuN+sQq2mX7pm/PzhG/93e2S4FgSIxTIqA4hRWKQaVn4mbQbkxI/RfsT9zaJVxy5RgiwjJak/WvHPoKfGuHwMG2zLSTnd0klofbl/dPi8AD6GkRBr4AFkSYN28H+ErjOrXWkl3kMDL2nD7KWj6NreiMxPoNwjxJtNJvYWgbw1iJOnA8AtI1BGWI6GtxxC6/ntE6ANlEIT3C+G5yLMVGQw+I08fQz+P60Ic6PArPPLoXfOE8fKjyfhwoneOr5kowaf70pxCJ4/DTS/zq2V0+5MY7W4hH2K6Kp4qg==
Received: from BL6PEPF00013DFC.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:21) by DS0PR12MB9324.namprd12.prod.outlook.com
 (2603:10b6:8:1b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:01:17 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2a01:111:f403:f903::) by BL6PEPF00013DFC.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 10:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 10:01:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Apr 2024
 03:00:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 3 Apr 2024 03:00:58 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 3 Apr 2024 03:00:53 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<airlied@gmail.com>, <daniel@ffwll.ch>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<dri-devel@lists.freedesktop.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v7 0/5] Add Tegra Security Engine driver
Date: Wed, 3 Apr 2024 15:30:34 +0530
Message-ID: <20240403100039.33146-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cfa25b-9f7f-4f7f-b32c-08dc53c5011f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yvfagaMqM9mF8xvya+XBkmROp9r7ZRUw5gaHiOFyerrfTu6avQtwA7h+v7ZPTvBDgMk7XBE95gM8sI1wWbQo9hfM+18hQF2TQSX/LcEklP7n+XJITKgTYvbaUO4/t1LziLbxg2+6Nbpt52CYCLTTt4/TQ2SP47YC5rZFoPoKYKBk5uFAM/RO0W+woA3/wWQZxEY+xIdQxKvfUTTWB6pr0vM5BUrpSlXTnb9G9yMGvdRX2XvlEBYFrD4xNpNTmWkSLK3Zc8rcIKBoXp4KSUXbZjQyj+OqVyXcIJm9zn4cwM67UfUWk0vsIWpAIifR4PpJPcxKlHCRLiRxk8c+m10hwdyWsQE/aznL1tMY9VTsK8v/7t10TxWx7W0eEYwCp1cUFweITP0MRAzGe8kVHwVwCWlUAXw/wE+md/3dYl6ixi89wmsBj14iVohiRZXWgK7ciK8gN8r6/iVxl6rl/c4iZEMtMVNcSVzLwjjum2B7/EUHdx6b0nzjjOENHu+V7NiK8WmX9x5XPVjYFKsb8YzAEfm7V6xj7/X25cCqvBp/aU8MAH1oc3FcRfYA9cN87gPDXxq6nboMFeQhgEloynJ4VY12qI8ADxG7yLOa5ZVnnnP8M/LtovM6FVHGYFlVCfzJhtcbBq+6tbC5hTYRp0Gba24pemeslMsoCXZQVIdlIcTfhfoPrAlXaqT0hRHpSgRDJQjUrJY0Xf0XvV9wr+mSPAk10+JBwMR+0/HfyOExPuc23KGjD6rqGhQBcx38uO7T9bFWjXzPlAE8AKLcAVUHwg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(82310400014)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:01:17.0254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cfa25b-9f7f-4f7f-b32c-08dc53c5011f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324

Add support for Tegra Security Engine which can accelerates various
crypto algorithms. The Engine has two separate instances within for
AES and HASH algorithms respectively.

The driver registers two crypto engines - one for AES and another for
HASH algorithms and these operate independently and both uses the host1x
bus. Additionally, it provides  hardware-assisted key protection for up to
15 symmetric keys which it can use for the cipher operations.

v6->v7:
* Move fallback_tfm and fallback_req to end of struct
* Set reqsize and statesize based on fallback_tfm
* Remove ofb(aes)
v5->v6:
* Move copy/pase of intermediate results in export()/import() to
  'update()' callback for CMAC as well.
* Check for rctx size when using fallback alg.
* Updated blocksizes to align with generic implementation
* Combined GCM and CCM init into aead_cra_init
* Updates to handle invalid cases better
* Reduce log levels for invalid cases to dev_dbg
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
 drivers/crypto/tegra/tegra-se-aes.c           | 1933 +++++++++++++++++
 drivers/crypto/tegra/tegra-se-hash.c          | 1060 +++++++++
 drivers/crypto/tegra/tegra-se-key.c           |  156 ++
 drivers/crypto/tegra/tegra-se-main.c          |  439 ++++
 drivers/crypto/tegra/tegra-se.h               |  560 +++++
 drivers/gpu/host1x/dev.c                      |   24 +
 14 files changed, 4316 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
 create mode 100644 drivers/crypto/tegra/Makefile
 create mode 100644 drivers/crypto/tegra/tegra-se-aes.c
 create mode 100644 drivers/crypto/tegra/tegra-se-hash.c
 create mode 100644 drivers/crypto/tegra/tegra-se-key.c
 create mode 100644 drivers/crypto/tegra/tegra-se-main.c
 create mode 100644 drivers/crypto/tegra/tegra-se.h

-- 
2.43.2


