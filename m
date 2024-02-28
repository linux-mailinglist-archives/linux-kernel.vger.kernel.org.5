Return-Path: <linux-kernel+bounces-85112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE786B090
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DE5B21A29
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AEC157E74;
	Wed, 28 Feb 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WEoozVVW"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40861552F7;
	Wed, 28 Feb 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127586; cv=fail; b=tCOVUVnoDHrl/e6PlDl/pgFdgPTdxhAlu8TKXR76GYGrXr3wH067iDVp8s22g5QSQ8HD490UfzmUaELuVjkSer2Y15YCUJRz3aHcsvUdD/27zYUXIvsFHFDUDhE266xRfpws2OdB/B2yRAEb3S4uddzQCGH82d6g2HPSqQIJ5fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127586; c=relaxed/simple;
	bh=c3YdyMeA10ZL7N1XqGjYODg2lKjATXjGsUTt7rLH+ms=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=aevCiwyfLrD/aCK8ADl9nlHz8OcC0AQzrgWoIAPXoxx+19zrNOgJJKnAZvIJInweNa8jTF/APX1CEFtKBoYBryZprczPbVuzoJD2eO+r3UA4Kz9h8VPyoIDXSn3ayt6ryKU4NzLPWyruZK299zcx5fNKX1/osWpEzzgtjzPasLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WEoozVVW; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoqPfX1cWg/nUkVrSUT508Pwymq+kXvv8Dl5w1l9PQXUfu1oMq3btrXsxWfg9Bo028E889091/RL/ZoEOkvzLmNef6nt52yJzD3Ke/T8cmLpbAQlG9cPcW2RzS5Ejq1rQbyxXlf48fRmj7q4iAXbe1Y3DvEkjCp6lkjDQ9pCc/jGdvjJhfuYGz4RKBC417+sOoZnCB96M3sfqgqZ6MfPLJ/aa0p/5ZsasnDt77rdHvi2T/JOLKNSt6UkKcUeNW/N5kOCB+8BSGkmwBL0wzieTcgWOw9tCI7Wv59b+FUUf2DIcz5eoJ+BVKTLv3jlKp5j87bDQ1qFYZZamWZRGL8eRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMLQgedzQCgeCrSFDKuV6nbnPE7kiHyd/TDKSkUV8z4=;
 b=GTm3MicbNDtoxrZk0nz+BeVp+mpZHNeOkEQDngLp83/xZ1s14g4nfiK0rPpY9sSd41vu0Bcs9uJr/ZwolPraJcq2sWTWAvd/atnMQyknIE0krzEzQc80xlEEQ70Waw1E4Km+Mxjk4DrmuxnHAw2MfcqDUxyjSoEC5KHbVCfIH5REZLdd2lJf5oKPdIUmsDhTx9xDHlejqeeVqhE4E+QxaJR4eo8T/VNyE7pRjejC5royAqaPP2oXys3/iwJwnz/DhxyjMmP34nbDFAbwhqRO+bw0mYCVFzNcczqMGbKul4EOhLHjLsSF6OIZA3FsjMCwgmCfkWKZxcDtiF8BzCI7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMLQgedzQCgeCrSFDKuV6nbnPE7kiHyd/TDKSkUV8z4=;
 b=WEoozVVWepu8mmBDXyK4gQEXyRA78XUkaC31nXJoljAStvHvKB091Obb0gbzBvePooJUr5TSZn1g/1iHiZFdTfSuc32rZMvhxNVQgoSwc7apiV4cS3tUZG1IGFXqz21FxjlGZ3hLGz+184Fula8RVsCCOc2MtKVv5PrbBueomN8ztmy5kacxi+zC8MHaVqoi38WPaxhvnuP9FoZiBSitDaNsTb7yrQB4o8s4scmyqxNC74wgb7agQAOg6XfkMUUeMQqhUI1stKvtm5N0G38eMy4dmp5dzVUTsxtQEKcag34OH3X632D99Yo+zKITlNLAl6DrkOtM8ZpQmMEPchSWqA==
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 13:39:41 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::73) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 13:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 13:39:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 05:39:23 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 05:39:22 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 28 Feb 2024 05:39:22 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
	<linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 4.19 00/52] 4.19.308-rc1 review
In-Reply-To: <20240227131548.514622258@linuxfoundation.org>
References: <20240227131548.514622258@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7150eadd-12a3-40d5-b5e1-80a6f6c6f1bc@rnnvmail205.nvidia.com>
Date: Wed, 28 Feb 2024 05:39:22 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: f244728c-0b67-4a87-2f3d-08dc3862b736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LeUhKnkH5I9KUtydxAb0po6SwihBi4jNLvroW+eSb+pjbHDVsAIwGQBZpihzulUOY2XV7Q2q+kxcbaDKaO7C3KCTfzCSb+FoD/btj17SsK6M1P5+5wiWUnSNhH99P3Pa38TmerVObZ9FMvdTnidllLDiCTOuaKEdp/lvmKsNuKXXxzqfhcNZ+Pjhd1yNmnxRLjhkSPRjTnNzdBauXR4zo5Lt6mr5hvZTKxYpbBK3aPtMc6AlPVNEvgW2i6p4xZc3VlcPXs0yeiS3WH9eE5aNqBDFL9wcqYboecV5MSAqpAMnaCTv0bcLvr5TnwOpV3pCN6Iofwxm68b+WnMdgSYQIMVNj5Fi6jrwAWAoL+Bi/kaFld4Pv0AjU/XJJuacdBN8uaQBhK/P3FLE/FFOszelNos6XJ9vYBPe5SyNF4k5Xa+IpBBgIBpqJNHWxWZiG2NH+vEVkP06ONWvFI0NZj6de/+M+83wqRKtNAJTsFsiQVuNYd4CdOQ8shKCsUa7urDbcDSgZFaaMf0ySto8gUdqms866pWWJjeXJ4DADTtb8NAP6Wy0wysrMR2o+WH1c38oG0uBjLORQIbcfK3I/ENGePWnY1gdWZrZWJaKAPffZXQJMw/H0KEjLvLG4xP6K3+Cnn3gdjcuzIbyJYUzK4RnPnGBapGg8ojQmAjsWkKRmSxe9K3rOQiVkfChXhLHDFW1+hlakCc8kDeCvtnGchoY8WJHF/J0qhN0igBH5Qg/BcszqowaB+hDIPKjphxkjV1bSlwrN3EFkmHV4kZhxcNy5BJI7O9bTzGBpHH6UPHtU5k=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 13:39:40.9781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f244728c-0b67-4a87-2f3d-08dc3862b736
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662

On Tue, 27 Feb 2024 14:25:47 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.308 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.308-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    20 boots:	20 pass, 0 fail
    37 tests:	37 pass, 0 fail

Linux version:	4.19.308-rc1-g6eae721fdc9a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

