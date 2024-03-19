Return-Path: <linux-kernel+bounces-107230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9764587F9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B064C1C21B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB907548EB;
	Tue, 19 Mar 2024 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LFt5q67l"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561505465C;
	Tue, 19 Mar 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836762; cv=fail; b=e0O3oPWqA9YuBflIegr7+Ap2QmUDoMk72KXnAdHkRRGmkvuqYdz7uNoHVUKMRhO1vBeU0Ywq7260WXPG1aWaIbfSEjEz3atKuVQ2EW12fgifVCcIdokVHg6felXN/9uAGNcwr2YtFYnEJb+aWSkGPDaUur8Wk5Vgeid4b8pLMRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836762; c=relaxed/simple;
	bh=s6SqtFi1cGuKtPybAN2eWauDm6GALwOl8Nmlp/yqjaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQ1QIi88Fqul7sT+DmtqYWPMizSifabG0wOJ4q5Fanl/GNihDJ96eurLI0Be3Lm50lspQH+N/1oFhhRLpXUioVDtbvTXzAELlUeW6bQN2/DotG0yG1D4E7ivE/V7GI8paukuKCZu1iqLQRbOjXmhSN8CeXNtgYxAjmuUFaLlu14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LFt5q67l; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx242JHP8pfXmHr+NEVUCGN4IJg+ekWl1m3+EEoKawM4Gkx3dh8k2QSRLrLTx/Hh7JJHoa9oNtT9dagYsf4mPd+LCt0quu1gvcHS6a1bP9iU7qvAcThXNlafwfRLwidTpDsMSk+UBv4g0hSzC9zB/ndIoHSCQtE1DJwB6dtnavwHtLDWbhr4QVdiIqeVn1WOzxph8YB2E0/+cwcsvBt86kQ50pMsxTw22b+f/MSBiCP2JOw7sKyofCyRq/3cncXNXfCfoArZ/fDKcOccrVbHH+GO03tijEU9UDnU0TKg3pX369sSvg/bu+JOboQdhIRoZN67j9gqlLT+o5Lz7+5IFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhBThdEUzaYhLfI6TzrpLZ2gFmkhzZ0eCX/hbtui6NY=;
 b=dFk+aA6sl1jsVuJE+EviG2nY4eNP7UokBt4nEmwLAHYb43SLQhSf7RCS0uEm7y/d/goIEr02E2rFJukG2jty5mgMg7xnKwAaglCDb5ak+ED/3OxBF3QnJXCN0IWc2Jg9adtuJB4VX7arpUlZTP+iPyCUqEEVeKl9yIBYv/nu2jIvmRxyTNmvVCoBNjMeNjo3IKiFQj+RWKgQcWnMLVJ5eb0DguZTgjC/aLItAJ/2dPGCbiLqSTfoasAFxQRJJiOYu7orvFcuXuaP6GRVLbH7VGB/RY6TATw2aLvXkGclVVPPUNGE+Qt2c9JDU9ylJQ5V9md5Ws8O8u7AgIqIOO0OsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhBThdEUzaYhLfI6TzrpLZ2gFmkhzZ0eCX/hbtui6NY=;
 b=LFt5q67lduVV1D/cANVSxvoQysuH8y6CaX9XyHRjU/CT0wkS0BhYx9UAEH79CcbL+bun68+duCGv3N7agyJuV7fpGxT/eLU/cwuTneptLJwTHaAH0PkUfT3SvJNekQDTCTGktPugMLrCVnBX1Mp469yDlC14h98CyPTPIXionGbrk3UVn9WejHBpNjXnqx/TLZQtj/J6lOjko3K3nzCzdlJsiLBQ3FRTfvCsYWdJbD7EeU9pRJj5mGXdzZP19k1Di2EsmM/xWuy6sqJv0fKCvPdefwTdyjqzu4MrlzWPpXe72lemhPjvU9wAcdIDIlzmXP+pzHKoxam0lA1sOBQY5A==
Received: from PR0P264CA0189.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::33)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 08:25:57 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10a6:100:1c:cafe::70) by PR0P264CA0189.outlook.office365.com
 (2603:10a6:100:1c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Tue, 19 Mar 2024 08:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:25:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Mar
 2024 01:25:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 19 Mar
 2024 01:25:35 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 19 Mar 2024 01:25:30 -0700
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
Subject: [PATCH v6 4/5] arm64: defconfig: Enable Tegra Security Engine
Date: Tue, 19 Mar 2024 13:53:05 +0530
Message-ID: <20240319082306.34716-5-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319082306.34716-1-akhilrajeev@nvidia.com>
References: <20240319082306.34716-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 36780cbd-8f03-4bc7-382d-08dc47ee321f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Em5EaWZ2GvhhS9WBtF5RmQnZ/oAefjKQ6X7Lk3BFBFjbh7q/iiZOi/UYu8uSRnPEJX3TEoJqni6bVmZBzLquu9ADeakLejzgkvZb01K8/4F1EoWjWmeLLCyRoMY05JI3L8MvmmRAaZjGt+Lb5ifMlNO8N9cnMQAtImhSxcjEObDoqoeVoGogcjnM7LFIPhjjO2VP9b/rQeCcV8INh/yBqLnhIuYMmsw18XuKRktzZQG31IdSANjyr+l76P0DIY/CfCMqDK7g0mYIH6Nb3UrQzqySVlwGdKiT01IXHa83mSlCkyMnyBNxaQB27ExaFHOdQLJ8avpnZ8m/oU9dZwQZSs7+GUt/WmV2WqKb88RJEK5SLQ6/mmisv0hEeajCxtfCzUyWXL0R6/ZkgD9uUyjBbu7mkI88NIR1E3V3vZ1uMKjX+owyFnD80NTIBIvsvtaJssuDiejODX31ZbDXdmZytRLUk3E744D+IQ0DvoIaTRWUHeGtc7QtUPW75DUzpIX9dYmDU9aMFh9xSJ8crOsWXOH12iA9imRy7P7TsC+eeKX/jRgS3djbiEDpAlcvKwB7VvbVtV1AOUIEMmAGUyTSKw5frj4UbROf/Z+TrPb1KX4YxxP4OvutbUCHs+6l953v++MEcWm/uRkfxOyE6tZxhFP3EgY3tO292xmM03opkUi9fmBYIaqHrhuTi92EkqtzjeBiMXA6wee1EMUcC3e4pVggFTumVVcYEuDfUaVeb70ynMqVntzKQYkRc8rqSvTL3gRXjXE/s2cDn3Wc2sWDA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:25:54.6900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36780cbd-8f03-4bc7-382d-08dc47ee321f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537

Enable Tegra Security Engine which can accelerate various
AES and HASH algorithms on supported hardware.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..af6f247c497c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1647,6 +1647,7 @@ CONFIG_CRYPTO_DEV_FSL_CAAM=m
 CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
 CONFIG_CRYPTO_DEV_QCE=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
+CONFIG_CRYPTO_DEV_TEGRA=m
 CONFIG_CRYPTO_DEV_CCREE=m
 CONFIG_CRYPTO_DEV_HISI_SEC2=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
-- 
2.43.2


