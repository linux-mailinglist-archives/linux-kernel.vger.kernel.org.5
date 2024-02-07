Return-Path: <linux-kernel+bounces-56457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E6F84CA66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9080B1F2C1FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B405A11B;
	Wed,  7 Feb 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p3tCUbwc"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D135A0EC;
	Wed,  7 Feb 2024 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307557; cv=fail; b=C9QuApKzgBTudJTLV8oGV/Jcyz7MqAbufMu4CZkRHwYKBlNmfdfLye9zTrqehvehOn7ryC+XOJ1LmW7kFzpSXSt+lrwRGQ5TyXbpr7w8pdXi4R+U57F2K9Nv60amAtJrp37cipzS3zNoTepyr7cjIF8qYyZCyjDG662jE10JBqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307557; c=relaxed/simple;
	bh=T9Ma2tpxRBJJAZuQG25xYPTbuHhzGotsHQUQCAkJI3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QEur9HKWRMFjI5djx0Kr2tAEiYG5fklARKbvK9ilxqP9WAbYH0TCBnsDnkWKzeMHz2dmjGENgdCa7pYJOJpEPNiD62YBnoRfvWjhu4xgpnI4JsDDardDDh2WE7IeNPLwYShdzFkH5uYgprgYp3tGacGPGF+YvpDJgAZSBgUAUG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p3tCUbwc; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEsknCsqmvMvX4c8yEu9QmYN6EZZOFnURf08qDyFRdaBnjn4/LkxIWQN+sIRntzTaiZ6y2ftIr4OFyEzRjp964SgUPYBEEMLwyubZUxOYByTMeNUanxzXXaBL6Mh2kiPhPzpEq01kZPYfkaH2PaKBOLp8JqkFxXtfYiehQfUomkGPqWwJT7pAbFc2s7RzuYKfJ/dybTeDFyxb1lz9vRiXVwxcafD2hTuVGyoKwDDnfjNuzMsOMiQ7hNWepMQH0kAjl24FEqXXTuHgQPPFWB3WXvsgX8mS2niaod/E2L4N1wemyQwkD/l4TEcQbDXmSILdLcrVVvXjGAxIJgFdx8rFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzDb7Puwb8vi0MihX6szLUyZvDCmy2dSfeKNEV6E720=;
 b=UkLSvnibHEk7A9CpE7tsFm1cwCQIcRiAwKJdK7lDjt1jqIg8Xx7X6RLBBkvPmbhcM4OgyLwS2XNJoiu3maiGfaEEJ6N/yRLrcLfwKRySEHYifoxPUEnh7Txjw2+ruudNyYSZu8KFqK1EhpAOizdUlhZj17LpRTNZeDpw75+GWnL/vm3TLeDclIz1i8ufsBXxRoI3QsCHVSC0VY7VxkCwIEgGvrKfSKX+U5AZjBgW3Udk892ktf6HLavF/6zyDI796eQuhy/Yw5oZ1M5agFvg0jvG+Ms1sAmTyZAR5zO9MmdqjKlGw/g0WxvnYf5Ujz0bXo/1fTglPALcOwGKPDmlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzDb7Puwb8vi0MihX6szLUyZvDCmy2dSfeKNEV6E720=;
 b=p3tCUbwccSKetiXcEXL7r+YfO3lbsEUsPzKYOPI7YJaYrCrj8OZVXCtxXz4b6szlNunOz+qXIcABxkjcHvSBThmmJx6srliiAKLNVZQYV8/85VxiT6PgOde3tn64czMEkdtTbgGz4+IDnnR/I9z6oYyDCsR9oTBqoQ9FVQNHdGr2wvKyirIuunEiXlX+6ZTLoHSuwJ709uFQZVn1IRT59bYJ5oXxi/dOJD+oHhG1holUYzvbmA3clWptfsMrsnmmW5paO0rnvGpv2QAxG3MF4zO4PYr1OrJLh83II4Mv3W2x+/Q+MQDRCiEFmmRJ22wKBtcyNYQVs++0Z1CxL3Fgpw==
Received: from CYXPR02CA0034.namprd02.prod.outlook.com (2603:10b6:930:cc::22)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 12:05:53 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:cc:cafe::c6) by CYXPR02CA0034.outlook.office365.com
 (2603:10b6:930:cc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 12:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 12:05:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 04:05:38 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 7 Feb 2024
 04:05:37 -0800
Received: from sheetal.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 7 Feb 2024 04:05:35 -0800
From: "Sheetal ." <sheetal@nvidia.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
	<spujar@nvidia.com>, <jonathanh@nvidia.com>, <mkumard@nvidia.com>, sheetal
	<sheetal@nvidia.com>
Subject: [PATCH 0/4] Add audio support for Jetson Orin NX and Jetson
Date: Wed, 7 Feb 2024 17:35:14 +0530
Message-ID: <20240207120518.697926-1-sheetal@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BN9PR12MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc9c6dd-a1cf-4800-2426-08dc27d52200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nNf++wGK96Rqg5FGl46wQ8rf6fUr5a+FcuL+XsKeVjPzEtN8iDgSDjGl1iYCIWwt0IqshI1UgltyXZQL2YSaTQ820uqWjzRYTebva1G9MI0rIXVrR7HGAYDHu8uiHVA364WWwVZ+Wf4DD1tFwI5FH9pxqqESV/tgq+B59TJJXoQBS39mzZplIYg0Izz4Y0eMnog4SxX6WXYbr/25BJLCfDYuSMyM8faEeZY4msPc3UpbWydRW41IpzhwlYQdzGESiQQkGWmXuv+XSAE1b2Wd9nVtJA5IdNyICWY2kYCVmXY7mLdSgdR3O6Ed/W9j/hHRxmmp7myMOycvRO8ohRfQNIP1W3sEF2ABPf2ojwPHanj49MXgbZTEMRzLlHh6vm2VaCE9q8VsTA4Z69P5WZ6wsKgb/8viYi+mp48JJmJs3Aw6SZprMrsMVq6lp3FFFHMF55iz8mkFrAKDqYyvXy/pSxA+YNQQRdxW1jUHyIw/H9dnPohAd/sPNZUuH+UAG9ih3Cuy/oMwWx9STYJMj5zcTjlJnUF8OBxUBgMuha1UHiHXsnWh1zDQGTKy9EeSHKNQEO2zSEkV0R7YZ3bBGApm2H+vru4s0SOnprG5daU9gR+jfUDiVMp3GpcZ72WszVMW2osnKt1qXbwkYxxEgXNVP+NZigyvvzxWL67gBM8uJ/ax2pDnadnTM6OTc+XYNgKnHX1NB/viDDbzV7Rp6Geam5ZPpKcKwwYGtosiD0VIC0CGPoRjP/tjlCVW9ZXkBavi
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(47076005)(7636003)(82740400003)(356005)(36860700001)(83380400001)(40460700003)(40480700001)(2616005)(426003)(336012)(107886003)(26005)(86362001)(1076003)(7696005)(6666004)(478600001)(36756003)(110136005)(54906003)(70586007)(70206006)(41300700001)(316002)(8936002)(8676002)(4326008)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:05:53.0313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc9c6dd-a1cf-4800-2426-08dc27d52200
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099

From: sheetal <sheetal@nvidia.com>

- Move ports from platform DTS to SoC DTSI.
- Define missing IO ports in SoC DTSI.
- Add audio support for Jetson Orin NX (p3767 SKU0) module and Jetson
  Orin Nano (p3767 SKU5) module with p3768 carrier board.
- Remove the module specific DTSI files as it is already taken
  care in base DTS file.

sheetal (4):
  arm64: tegra: Move AHUB ports to SoC DTSI
  arm64: tegra: Define missing IO ports
  arm64: tegra: Add audio support for Jetson Orin NX and Jetson Orin
    Nano
  arm64: tegra: Remove Jetson Orin NX and Jetson Orin Nano DTSI

 .../arm64/boot/dts/nvidia/tegra234-p3701.dtsi | 1948 ---------------
 .../boot/dts/nvidia/tegra234-p3767-0000.dtsi  |   14 -
 .../boot/dts/nvidia/tegra234-p3767-0005.dtsi  |   14 -
 .../arm64/boot/dts/nvidia/tegra234-p3767.dtsi |   82 +
 .../nvidia/tegra234-p3768-0000+p3767-0000.dts |    7 +-
 .../nvidia/tegra234-p3768-0000+p3767-0005.dts |   12 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 2122 ++++++++++++++++-
 7 files changed, 2198 insertions(+), 2001 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3767-0000.dtsi
 delete mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3767-0005.dtsi

-- 
2.34.1


