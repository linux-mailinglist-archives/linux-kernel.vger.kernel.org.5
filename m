Return-Path: <linux-kernel+bounces-36649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD44583A45E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4847D1F285E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CBB179B8;
	Wed, 24 Jan 2024 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X9XqF4Fz"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC21799B;
	Wed, 24 Jan 2024 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085656; cv=fail; b=JQ2Yq3TgT3iQAvuzMEVMqFrOkvdIZxyYWyJpNk3fi9wgTNhvoNNmydkZUtERXdR3pnLlsmhN9tKZpypwiruO8rgUFb/fQD8RvoxI/+3lkwzfO9FvKJUe5ITKg21W063s5gy2ZowneOkjh62fYkadTUrab5wcYkY8wmhVT/Vs0nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085656; c=relaxed/simple;
	bh=LyqI1i1Dhe5CnpArNnoAQgDswm+WNhk/u7abBacZAOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ir1HtVHfEkDv/ug+zy3ZmlL2Th4pA1gIRznTTsEuRm+DXL5dwmsV+93AR3G3SDs7P42hPOnFQYGyt5e8pFKJXI8yyZHFlnumgvdEJNC87guvqbfeIG0WrLWKkwDHzX4sF3tC6lFHMgHjYasxrFIi+bNf5Th6PpjnWwFHOOtPB+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X9XqF4Fz; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyqimRrmfSYGrKlXBGFc9u7sGSvAOiYpp6jt/MWZuMc0/TO1MBkh5kTk3KD2OkDze1xJPJf0pEKHQm5fcQu84amMjl0LpRTaY3o5VYVa8E83Q39mfQ/8BvBCZkzzcAEcmSA8z/ak8LLjl+QRw2cDikVDV5hzvjbmrnvVf/NIhaY0ntxlL+nJB5tzj8ACVujcRJTVNxr1geUm9yjnGv1TKNgW3LepG03tWbkCpPrRtrc+69sYMifQG70mNwkMV1pln8oiZIfFajpNa3KkJorZITw8iKXwodpO4CHFb92+C9jqJid1ytMPjoDqVUeoeLkzFNhSfE5TC+7Zm9sivyrwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6pRStI4WXQmaoaemj41poelpm530T3JjqRn9zS7st0=;
 b=ZmzbM8ty0W3A5rujJ0/kZmODpHLtz9ClIELxBp6niQ5DKItbB8fUTxYyHDkDhpG1rvWNNCd2gwpgPV94Lvta8Hs4UGpdRMwsSK51cIuNXB//2jSTVR160rpRRlUUtXq3abPfc98gJEpucvvbZWScS4/Tf+TsDf3BIoyZ5SxDbp1b8PwDukjQeBuPS0NxurOpsFm8Dy+XS/lwhDUXCXO65tJ+JL0EdLbuIZzVvDrShUXy9U27ybrm61+ZDmgyt6Og4CLPN2B1G87mkp3d1iD44ywC9RPVyvJING9vDe/1g08A59es3KD1KKQKHSjKQYPVGyL+ORbehY3j0UMIpt7IXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6pRStI4WXQmaoaemj41poelpm530T3JjqRn9zS7st0=;
 b=X9XqF4FzQYmLqm6iL+lIBqFposDECNmEWmWEoosF+6MU/Z+5yvdFUOQxmAYVVo37iL03+4pwft3+wpqN0wo1CIu7kwm/wn7ASbOAAB2RJplLPq+Q/r4z06VnOP5A47XXiN6wd2PCx/s58R5RzY/VgqaK6yjjBpqthInM47eYVfKoOTInKrBXhEqplOWi2+BSVjxRlR7GRyDSwHKfEjgEV2/0MWPKUHBQAgWSsQJ87vCn6eTxCHusRE6fWUE4jayAFsz2swqfN4EP/FkRv0B6paOcraNstBjbtU9jUrXqq5kP+uP7DWhTqpLqUQlzAhWTYCkPufCAX+E+rzSOchHx9Q==
Received: from SA9PR13CA0009.namprd13.prod.outlook.com (2603:10b6:806:21::14)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 08:40:52 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::40) by SA9PR13CA0009.outlook.office365.com
 (2603:10b6:806:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Wed, 24 Jan 2024 08:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 08:40:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 00:40:31 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 00:40:30 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 00:40:26 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mperttunen@nvidia.com>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 4/5] arm64: defconfig: Enable Tegra Security Engine
Date: Wed, 24 Jan 2024 14:08:45 +0530
Message-ID: <20240124083846.46487-5-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124083846.46487-1-akhilrajeev@nvidia.com>
References: <20240124083846.46487-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 21582dbb-4bad-46f9-d6a7-08dc1cb82bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h7/6+p8JSYVakUdjodsCo9du/JPPfsTMiu6xvfNLkzvqSQpn+9V5HCDF8/FLMfL4J4ePHFN5SIOuW5nH/esdTPDJD1wp8DNTQRy6QcB12cGCMOMkw4MhmdNqsFG5LSjJcnxdYKFrWvkKuP78dEpVK3T6BEv0aK94mm1P4ifaHpwzbZRB5S8iEe2TiH3hef+bkciSQSlfAm7LSNFjIgvipT8Gidt8bX4WBRWZ3h1cnkUYUvFLGrRkWTltaJQJjdOQezhGwseJrAYCHiBnsQrGon61gRKrW9Ab4el/V3KurGM1pMLRmlQ9GdN2uQN7cuFdE+5dsttaBEAlHE7LmZ3ErsJr/GaiaPqYQ6PU5Xh8h/qZyfBMfoptL0UnPvlJXc4cJQwpuWalnLN+d4QpEww9vpt/44jmPKnZYpSqw58ceGQsrClXy9/sPyiXeXFaSlEJaLF9zc7G5e3H84aKBwrB4Ha9lP9tUXlb9ZFIzRLlhipdeWr3vKSSPnN0pv5MoTFlF7eiQx5kmy4PlZSZsEigtJH4OLuIAdKwnnp0ysVAFbwRCRny0jzznNXOUIr6UY8bafHgr9auXIMBU98gz6A2bb8xefXEXBYPJtKlb17A5coMW8wkeuowfnt1kIXZUpTkDS4/6bNox3hqU2u63PtAtM1qY9YjH8ndOIn2x75yVQyxgSWS9e84BdaNre9k6EcM8iUmkAlI3AJY3oRG4jlbDojnW2bJtU9gmHGL51t+I7yKQbbG7abKq7khASo8JPUyaealsfFLbG5LOikajsM3OA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(426003)(26005)(107886003)(1076003)(2616005)(336012)(7696005)(6666004)(47076005)(4744005)(2906002)(110136005)(41300700001)(15650500001)(5660300002)(4326008)(83380400001)(7416002)(316002)(36860700001)(70586007)(478600001)(70206006)(8676002)(921011)(36756003)(82740400003)(86362001)(356005)(8936002)(7636003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:40:51.2504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21582dbb-4bad-46f9-d6a7-08dc1cb82bc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069

Enable Tegra Security Engine which can accelerate various
AES and HASH algorithms on supported hardware.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e67a4849b91..4f5b01cc3b1a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1602,6 +1602,7 @@ CONFIG_CRYPTO_DEV_FSL_CAAM=m
 CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
 CONFIG_CRYPTO_DEV_QCE=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
+CONFIG_CRYPTO_DEV_TEGRA=m
 CONFIG_CRYPTO_DEV_CCREE=m
 CONFIG_CRYPTO_DEV_HISI_SEC2=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
-- 
2.17.1


