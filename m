Return-Path: <linux-kernel+bounces-136329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9781C89D2BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6B21F22944
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C122177F2D;
	Tue,  9 Apr 2024 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pG72LDRm"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ACC6E5EF;
	Tue,  9 Apr 2024 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645718; cv=fail; b=TWCw2moCOSJ08y3UsMO+Fw2hny6nQENQSQKB6/zcvn764EK8IMD2Dfv6+DmK3w5qGr/FfNs0Vbsjk+msDx2lmd4vPEXNnouUy5mK9xb9Htn+J2lnmOf4AIodKPv3PTBO5WndqQYdYX2d2udO85i7QKZGLfnyQMjcVXQUL92rDtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645718; c=relaxed/simple;
	bh=+/PUrljbQlMHOFqt6m/UymcoKOz73HFzYkV6EsC1Ras=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=nZut5tRg+M7aSvUeKF+e73GsNz+bZQ7ufsrZuEPySrtQrsbZcuHF7nC7HxNul5NizUNOUmaFBzx+k/9oT/CGO2H2gj+A1bbuwQ6NNZPhUuIGQxNycOMyJdSgdws5mf1DqDKdNqG8vEjRobMI2acZDetqxJNoUOHWxAskIeQX81Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pG72LDRm; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddSKFrGFlSbd4diA/cbuqfTzpMwvaiKgvfKaI7Nj1Uchgp4Hh3NMxHuXcEzbGx96z643OjFoT7QsQFB2994DUJf7Wi+KLYIT2Ognl82On9fyWXOTjuPbOO6G/0Q/A1YUUxFW6XsAgZKv3/55L+ES2cgHAO8BGIKaNjNq8Law7Xr3nWfcVwzLuVCmvqRJw+tLScNDcaCPhk0zS8tSUul3NWT9Z+VnMolboOaZe7qit3rysu0DPj+3Cja5yOTCDyYcMg+1L1fzjLNAj6xBkFASHoEpJjxC12KDHbDcJy14yKZfC1yauwdLhRJFevhHBkYkmfOQpd5LzC8kz2B0hAg5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd844v+9ifxS7HVmH7r45I/UDIM2km3zD0udi3C1Z38=;
 b=bewstbqJ3Cu/4WKetANK4b5m1MwjSSdGN7ZWiXPHeDxe+gJEskCwQlAddEDEnR/qwrAL8j5bmw0a3GAxESJPE3BkoO761opCNpANQkDXMeZC0fe0VxiOBkP5tuxAqTUFj13wQ0wJYKc8x2D6bz8PmbIe1u5/cH0FhBpFy55RUP+UB5LBGSfGoBvza60c0RFQ3kT12chIZ7vFA6W0U8sfKDPO4fljviIIYZwpdZyy5XC3CxBWljkX+qTgcScaon6TsklSCwUhwWInOM96rJDGXTqDxegP+eiXViA9x2bhHj59NBt15JKmWs7S50Pra8xGXygLVIHlAJ5uuqsQR/iuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd844v+9ifxS7HVmH7r45I/UDIM2km3zD0udi3C1Z38=;
 b=pG72LDRmb7BCFSoSgyvy8xytxIcQacprvo/V1g18Im4ojkdH+Tm/tUnk2C1VIhfSdfKCfojtNS+QSNsH4YNl++XWC1DhQ06Dcw2bRllL4H/Bn5/uqI7F6QIMMASYvd92nAi1boHsZFCuThQkGrxjP8agi6Pu5yQVMDRVJWJj/RPtlIFfPx73iiHqY1eDblab0wi1POPC3iyr7+pgliZfnFcgKdp1dRG+ZSje8AFrMQpJE9S42+dsAb8P8ESGgQaoqKIKn75sA2dNli1NrQ+4OrgHcm2C7wfabyf41KvSq9bNO5zpOGO2K2nIs7FHl5hPLupi3s1T5ldinoByc5y6Iw==
Received: from DM5PR07CA0062.namprd07.prod.outlook.com (2603:10b6:4:ad::27) by
 DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 9 Apr 2024 06:55:11 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::34) by DM5PR07CA0062.outlook.office365.com
 (2603:10b6:4:ad::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.37 via Frontend
 Transport; Tue, 9 Apr 2024 06:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 06:55:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 23:54:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 8 Apr
 2024 23:54:57 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Mon, 8 Apr 2024 23:54:57 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
	<broonie@kernel.org>, <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a87a3991-cdfc-45cc-885e-637cd839aa06@rnnvmail201.nvidia.com>
Date: Mon, 8 Apr 2024 23:54:57 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb161d7-07af-49c3-f823-08dc58620089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I49+NwyE7M//rkKbVJeuxYfuL2C5ONRkHl0exMdlSq4k2phz6lG5Ei52DC+pQo7+yVpoASeciET9IAISFehgc/D8NOyVLU3/IeB6znXPoSzUbrme45xvRFOH72XGe4OxRG8aM7mIhavyAO7iFqujF9NJ6dTgqbmVPK+MS4T0vPwOvj8E3hmJhKHwAw4Fr8YRwyFMHR7eYEkcr5cT0unC1kpuoxXV7fhfOtFhwuwHIg5scfuUasJIQ5vOSyXehY9wLp9IS9YPkdVM85fTX1G1vmXIba91Vs9R0LFUNMhLu9eZUIGTLegcurnXqc++vgEwKmZ0XI7vavUIkGmmBSaIHs1QKr6eo/NzbLHDaSo6giDu3lQnHSJ+qhZ1QBMhXgqYdh5WL8uSO8ELwwLSVB5FppEr2uJ6YGbAh6g/B70agwJ56rT0P3C69srdlFEX/zKgM2GILFrOjthjmFh5jWo/hUzpxi9w2F3jpAzTyoj2jI8w6PxLAG3co6jhxTsljHVdefa0bb5J6qwQs8yQPbF7J+Oc/Vov61BgZ0mSuw3Z6+GTI/1dmeHtAde959sCQU0KOYExCuh9+dxCd4uHQ2LevJ0/5opFWkPRHh2x3HQT16NYcZt92tD+1eDbLX3i8Y4GUHoUt3CHGdE/OwTZDLAY1uZTjxDenG313xrbBN18D2ve8z7WIcwh9slDxRyXRbnpLdSKmAWHsTOSW/TLiqWSQEv0kkajQ7qUczr1UTkxBMQyv/UjveDA2VhqI0LdC+mN
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 06:55:11.7442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb161d7-07af-49c3-f823-08dc58620089
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

On Mon, 08 Apr 2024 14:56:54 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.1.85-rc1-g76e1877fe563
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

