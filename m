Return-Path: <linux-kernel+bounces-36643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C783A447
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1351C2362C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E58417988;
	Wed, 24 Jan 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V4lbacfo"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311717981;
	Wed, 24 Jan 2024 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085557; cv=fail; b=FS4RHG6AnzkSOQAw0F1T71fgQ7xewnduxNfloStABEz/Y9ShgkM8niWudSXk2LudNE1m0WP4Qxm9Og6DNJdwOYsFXFgJWU17PD2pwKd5IX/s3/FvcgAz4TpQec37vy8/ANjvUylXMC9w7H65MlXM6zjuh92nJxwvflXlpqrgcU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085557; c=relaxed/simple;
	bh=XaI0/OXa2EAUQ1t7yvvTTiipr5ZXAk+YmROclLAJU6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVYVuFg9wkch/vccwGQuDzjIGpY8L3K9aGAa4VZpTtmpSsVN47iTtDhPtt0+R534lQrCWu99mSgf1B26OkIJjYcUFwYBlYB4uy16fVaqAoeEZ0bTT2PwpcoPGsEeVEgZyUMro/jWI+gH6Po8oqFxof+M4Qz67fyI6R15HYSqj+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V4lbacfo; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdVIMZlf4LhHkaERXKm6qu1k23MgaUsL24YNj+ti6hdR/1boHjB2SNEuLa5Udouh9+2Bra5QdE2YjkCzQjeuEtTaeDxC/sACqkcaOSH7qZXHMRLbEn2JmSGdLbWCzvVhxdSxd6Dl1kEesgETBSg5z7bBsu3WMNlaj7f2bM1GkEpzOUC4sZgSiVaAOnEOC/RiQM99Iw677Eq9wb3FMP2oAP83m7uCXSVuw/7BLf/G5QzdIHTeVnVHp5bIKc9ZpjByCQqz6qSmxMhClmY2JLRqPe9TUWu/c7ZssZuRwYpd/6lcxoYKE2pEfywNT+I8hrw8VQ9UT4SvgfnUuOn6WOycAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7wIeYfCKFcrxkPc8UZVuR8mX4E8LW5ZhqM0uUMVMFY=;
 b=bpwKYJbpe7obyQsvk18myg62KeZFw78xsIp+eD+tetbnvbZLTtjOrL07Vv8Ox8QHA7IR9EB1VdF9Ax5REesditl0BKnGGMn5/ZjB4auHZ2iBiWLFTVGudRn+DQbXJtal2UtRlQCfI5EV5dhNcug5IKBszy3QIqHCMaCZoJq/GyOTTn4Xo746qbxA8msA6EM4npodvkTkB/lZVscuzmiMNOXG9/AqWZ0i7p9aY4c9c6veYRQJEIU/8McYSDHmso7/YNvQd0clJXs7bZ6JXSgVk0XnTDxyq8Sfwo0RmfGlI+6MJNdM6n5AKwK/50iJWFU9YY/jViJfIGo61TQrldrTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7wIeYfCKFcrxkPc8UZVuR8mX4E8LW5ZhqM0uUMVMFY=;
 b=V4lbacfoJlnxMZIdiFuA5JavgHkKYH65mnzsRpynBN4np4a1FSds77f/zJoOx5rtVePJy1SJMn6t5rF+DiT8/WmEs7G4gsiav+CKj7OC4pivyJjiCptcYyou6UefLMcEL3ivkR/7lxqbnuPdimDqnzC8/d3+5DObRQqBnKh6mDtPNWIuYsNIV+lrckINwoTrrsNDhTqMsVZVuZ++0NOCc/UJZz53U27eoAe3wzanw5UrRXSdTsCgrgzEOCj5315Nd6kgP0423P4yaGXAFRw4TL270TRrdE24UDaQOZuqQoyTVsejY0XeZt8HfQR6wfBoy/5vyDZQTKqf8CJBkvSiqQ==
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 08:39:12 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:8:56:cafe::d2) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 08:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 08:39:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 00:39:02 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 00:39:01 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 00:38:57 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 0/5] Add Tegra Security Engine driver 
Date: Wed, 24 Jan 2024 14:08:41 +0530
Message-ID: <20240124083846.46487-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7d37f9-0a16-45e7-b88b-08dc1cb7eff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ehKANKzOjNcj8t+A5ZTP6bydX1azFNkAbX2Z9ym0m7KeitWG4V20gUfUQRw+smfRSqsN1UkyzreYj+vhc5+7n15izaYa7FCACPnot2HP2HKCup+xR6TiN6Wbl7PGiLu25Nf7bqNtdJJfjylSX0hHTsRRUx6eix5myx8si3tuwAS9eDIEI2U4w/Xgl+q4ThRot9lFBo5uxsrqj4WyCBBLnjWU8Y6wdmUe3LZZEg8nYsAmXJwAasd7Nq0SpURILQdqF53TRKqRfLx9DD1Kgl9Qq/tCXcjkIT31cIKgLfdNL1jK7/MDtUfBPHzUbyxdsGUG8vc5/v9qEibXZ74HaK+kbOnC+Sj0dvRhVQj1aePOGa2xHPmCj98p26OEVYfAoyjSzxsE13Lb9Z5oSR6XiG2/3NKX5LUDXp7+/VqYW3p0T1hmhb4EqycZdyJ8zPUsmcpyTnTZR+WX3u36CRbKcN5bO0I0m9A38W4ETnn5RjaXGIG6J+MTF0MkYYJje4b61VUTPXqsJZsF8eIRxc6HPWDE0jHt1mDadylHTwK+1Gmv3E53atjyw0d8sETb//RoAhgONFVF7JJb/1+g2Asixzgux4+/AzA0d9z8xiYtGRG7cgAzRrruereLYggkaXckvH+6h96qOwxCt57DtJ8mHMSPjr3Giu+VsYehP3If0DzOtN/P3vd4YEgcOh4XiI+E3gr+oLsjjaoihDAeHI2RQHCVJAj+sOhXKtaVGq7uwD5+hitvC4NJvKzH3YxuQnp3IACUmhzO8zB1Ti3vD6InK87fmUPbLBXQre9yl9jI2w1grmC6BB//VUb6zresiIxVymzr8avcdI45J5fnLAasRI43dg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(41300700001)(83380400001)(921011)(86362001)(36756003)(356005)(82740400003)(7636003)(36860700001)(47076005)(1076003)(26005)(107886003)(2616005)(426003)(4743002)(336012)(7696005)(478600001)(2906002)(110136005)(316002)(70586007)(70206006)(6666004)(8936002)(4326008)(8676002)(15650500001)(7416002)(5660300002)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:39:10.8747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7d37f9-0a16-45e7-b88b-08dc1cb7eff4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471

Add support for Tegra Security Engine which can accelerates various
crypto algorithms. The Engine has two separate instances within for
AES and HASH algorithms respectively.

The driver registers two crypto engines - one for AES and another for
HASH algorithms and these operate independently and both uses the host1x
bus. Additionally, it provides  hardware-assisted key protection for up to
15 symmetric keys which it can use for the cipher operations.

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
 drivers/crypto/tegra/tegra-se-hash.c          | 1022 +++++++++
 drivers/crypto/tegra/tegra-se-key.c           |  156 ++
 drivers/crypto/tegra/tegra-se-main.c          |  439 ++++
 drivers/crypto/tegra/tegra-se.h               |  569 +++++
 drivers/gpu/host1x/dev.c                      |   24 +
 14 files changed, 4286 insertions(+)
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


