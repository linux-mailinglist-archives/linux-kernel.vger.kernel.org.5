Return-Path: <linux-kernel+bounces-75422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F110785E87F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5727AB2B028
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F786ADC;
	Wed, 21 Feb 2024 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mGGFsSIS"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AF86636;
	Wed, 21 Feb 2024 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544928; cv=fail; b=YGemfRFqZXKCaFUuZHMjCLCmfRD9yB6/in6u3l1RrOhRVLX4T2gD2EbK3gI0nwaTGVoo6M11emXy6gafjbRhQGnzmhwKCsa4+uiSnXXRltVfhkW82+nBB8G6rw7INmqCYMPgnW01c21415PhWTuAlJDBdxButxC74d/E9JWP+xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544928; c=relaxed/simple;
	bh=CQ7B6G4t46N/dRHDxpoLKVzZJIiv4KPm3NufW9A9Xwo=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=npeIkwoWxI7p0C7Q8dnHz2pISogjd0Yp0Wg8OpK2RlfVyBSjK4NZu4OdGVuQJCHFwv/VO7J73NytmbtiBb4bB/rt0RAVjAYrcXDYMKiF61yNUrBPGZeZbnXlIue16quvxjaWTXJnhfaerTM67vLyOytm4HBsM6H+DXPh7IWjhCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mGGFsSIS; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8lOWDbycV/3g3CdtYnEf4HG7i57ZXGnbcusLB6zD1eE9fV2gKNxqEVNfkM3haQBuwzqd8HeLz/iMKSQFwK8swzUSNgwdNsFT3z50x+/fvHgkSIwmRRTRHvcgEnXjMdGophKrWYdJoQAjQmwAoRunochgXJRpU7X8NqekiwksgJn9miZ1sKiu4Z6F165Jga/ZLi9FAlBH6v2S09hO67ROIyR4Ivb9vjT9ZG48I8uKV9DVbXalLZb3A9I6aHkA7tIvaEAW+o0zMXNppTKkeVkOBqkbEJr4IAU36kAD5eHZyJqVqXwPsu+byuvfVk8BqkRJTYW/ZY3S9VoHLLkNF5WpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpYPswdgGEsRKr7S26m/Pak6I9E2+g6ENj48qLW96F0=;
 b=Aj+0N2u662qx3b95DkvSPuh0Q77wHMB01SDksv/Rp8mxD4yc2ENWwkUONP1Z22l+MmgqtDoVjcpgP9p7Ovsk9YcNIgFtQMxQrK70V3UPysgdpkKm6L54FhJe2F7FvRyHxCEQclmI6Zm4u0oZAelY27X5J/nz2C2yJQMU/uAwyXiDJ7eWyMsmKIbbFD2w4m2zZ3aXB/pQlT2t2hgFD+hK1JesLb4Hj/F9bQxg+fE4TbGGcBZzGjsv6Cc78Jx9vS/2BIRuq+BmnWcaytIygbmOEcaqBoqwizMV5fBJtEp+t/zkTgSv3rKtsJCASZSLr8ie4AeCSNqNVq9bfcx5JHx2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpYPswdgGEsRKr7S26m/Pak6I9E2+g6ENj48qLW96F0=;
 b=mGGFsSIShszJpJ1jwOZ3uJfP/uIRhbffLuCbhzDs2PNSsAksHfm3mLkwvV7O/MLeacsTboesmls0nftMLM8d+ep8hI2NYCXN5DOk1deDL1IIYcDpN6DnOn3F2tlF7FIjJjmByj+PHjAhZzab0n+A3V/Eg6clSvnqPziHR7W/mToAQIQRZM1Baohe8+aFBHcNYrbyRZvkoHkxyuLB6oxyESMHI82o4jQe3Vao9Rq6ENTiT1nlqsOeQmVn5Y6e4KpjqTXlXcnhfPwri8QHvJFHZsUm5FzXOwq6j0J8D8xsMxGimkT8L6QZfIDSjZuF7Qj4oRj6AF6sdYve4qOA4J1SBw==
Received: from SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 19:48:44 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a9) by SJ0PR13CA0103.outlook.office365.com
 (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14 via Frontend
 Transport; Wed, 21 Feb 2024 19:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 19:48:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 21 Feb
 2024 11:48:37 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 21 Feb 2024 11:48:37 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 21 Feb 2024 11:48:36 -0800
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
Subject: Re: [PATCH 5.4 000/267] 5.4.269-rc1 review
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <f54c8bfd-a7fd-41ef-a317-ff20061344ec@drhqmail201.nvidia.com>
Date: Wed, 21 Feb 2024 11:48:36 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: e87c905d-e145-43b7-86d3-08dc33161c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oX6xpsKwKhc63KllJan0FlpFqdV5VYr++VNvBwDNZkD78x+O62RErqt2tPWC6X0hb6Z9tnJlKnODx2GTs/c+GDtPjQrhAYLa9YcaU9IXp4+tRunBu0MnER3T6AqStjG8KXjMzTOI3IK3FKR4VFpJ7u7TxbhDW2brA6fif2zLX4J/lo1+mB7auViZUM1nyhFui673f/ZvJmJj09JzDTw1aV9XHGaSrqoG+DdHz6hgcRto2bsZgaX/eWKHlJwUmVIj8GUWsragMIUSMWzh5x1ikh7tEh9qunYNCLayLgi/1qE1/4NoaJOc4vZvHsLTUq8Y/V61mDZVQSEphEM3n/xt8e2m9Es0oRGvyZjLLAtYJ7mHEmvtrWgoc5cfr+GvUAmMREzmIQgXJlILRuqnjigvRLeHSxgtJQMULBHLr8QCWgtzMq6VasSMKrlvcxO47wAGwG76c5rlQCS+xahL/DsMOtj9AiPvGlMlMroW+maSs5vCFY0QdqPhwMu/hthSIHSGWN9MM0E3ajF3IArgFX1zLhf8kOjLq+8uThSGe5qao2ilov3DWprUs6XrF7DqHqIjR/T+wv3DCs5xePYueHquigvTCfOJt4zH7L/zK94AIacFqjz1/gAa9s1ypvTA4/R+S6pA+hFfdDprMG5sV312P73wT4eFrs1/PaawukJLr5EvGfVd1w8pfTug0AO41RQxUACMnYoC+qjbNb3BhkgTSA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:48:44.0461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87c905d-e145-43b7-86d3-08dc33161c88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668

On Wed, 21 Feb 2024 14:05:41 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.269 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.269-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.269-rc1-g5e1f150bbbb6
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

