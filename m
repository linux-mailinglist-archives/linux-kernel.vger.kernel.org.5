Return-Path: <linux-kernel+bounces-85107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7BF86B088
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB651F27FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B9914C59D;
	Wed, 28 Feb 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WtBMqoaB"
Received: from outbound.mail.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB914AD07;
	Wed, 28 Feb 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127560; cv=fail; b=kRNMyoQpRI+5hH0tEJ+Y7I9ZGYyj3ORiYtpP1CeM86gXvNuND99Xt7NoZeinJIiygijcjvMNUaOcTLmLfDnUjCGv6S6nEFzG46cJI3P8STM9rbb/WknSfBk9m2zXOUkg6DbigEG+nWj/TvO/2JXQ3x437xyr717md5rxVJCUJEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127560; c=relaxed/simple;
	bh=09UKLdvARK/YzqVVKqMnLGfA00sxkZN4HgNl83Sh0fI=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=tdEmflry0/wooW0m+4F6wGV/gV2WvMb3siCa5onz31jzJiwTc/uYXtf+atXEWQou/xKugpTmbk0PUJcs5OLKOveAQBcTWZVwG6JCvSS0WZqBXAkCAdOAwsf/aLmJ3p0aoN0fucgos+bI0jU8l3oM10yAM6klimr9K3JKFLh0++w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WtBMqoaB; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkPhSX9On/oQKUSrh3tqR7z0Hdkn8NGg2w05g3gwNF8uyGsKoPAYDl5uep0UpU8+0JO+s65M+Sx9+5ecarzbjq24wmplscdzOstxZ3cwgepUkU29Q6rDLqJ6KAn0wteDrftYk9QpngCHKlW1vYhFfJ9d00eL0h+pIttNn6Ely9Y2v0as4EEZJLzGKqnm0xAnK4ge/P5lXGycFTxyE5LSgDfw+KvbM7Vq+psnS31F+nM0wDcYIL+pIUvmd4VL91gkAi3jWsORJR8ITAczAsm966Hjh/w1vfoKnNPTwggrTkMvUa7BY2z0/1QU3l/wIW6UwieqjZn3ieCnwZryiXTNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skjpEOuNNMj07iqyx2GrgtnMDhYwWCHnh/BVf3JzL7I=;
 b=J7wBvZxjHgFNuUM2LP3M5gUmVCHpF/K/omoHyhS3wLEZ/Qav09yYO2YYWSGlbRkVH5wgZ2PtbD3bVMEJIeanV7t0r+9tFyub/iAsMLwwGSHWpNO5KoNwFbbH3LO/N+gNVvlErN73Jxww/MpgKtOsJ72l+mwkwMqonBmAl9dSoUn6pt4ZqaMvokiQ4d6gBRPssuJXG1UQLdQFIJEV9408pdZjrSPTUbrPKmFyUDCpDwDewVN5E3QmrV9F86VAljBwIjIuoFUg+sAnXy19N2gCBVfVsIBknigHREFhXtJbVrqmE+WOPPxyZLzStZGswN65LPBt6ZAroxEDVQvaMwIVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skjpEOuNNMj07iqyx2GrgtnMDhYwWCHnh/BVf3JzL7I=;
 b=WtBMqoaBdGK20uoxYAzpVjUIboaDMRxku5aPAukOs2skZJ2Vp9XoUBbiPZExLx4qC+NPud52y2DtPRTwFvKz5n19BfYD68FQXUMh8TFimFD/yJO31CK4QnD0878y7RjGbAdQKI0872Fri/PIfKKoowj93+ZfHckoGC3J1zeg3x0v4FtK819I5I4QW8LrN0LJOFylbDouDCTjvcSCb73Tfy+P2nMzWEsOu4wEHBLNJ1YwWA/8KpS3M39M5gbRen2iKuzo6TMeYjOEgeSEaZ/6v+yZWA6pP3Hd7BSzLR9sYRShpV8vLlcekdjeNXP+Ic8OmvoeBxhv+2nhVzfrNxQ5FQ==
Received: from CH2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:59::11)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 13:39:16 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::3b) by CH2PR03CA0001.outlook.office365.com
 (2603:10b6:610:59::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 13:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 13:39:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 05:38:59 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 05:38:59 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 28 Feb 2024 05:38:58 -0800
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
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <21efc68f-d115-46e9-8b31-4b2ea6601967@rnnvmail204.nvidia.com>
Date: Wed, 28 Feb 2024 05:38:58 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: e92a1021-3a52-4ea9-0758-08dc3862a856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J84st2xL66CQfYYURYiym2RnPgPGnfa+hNi3t+ON+W3nws96CzuwjXAmb+8RN+KhTxN/DHP37DnJkbSm4ghDH07n2qpmisQ9IbWllmyqXeekF7CJG2u3EuiLtPA1C6TP0kwrPhMgRq4SWf3DP8NxVrYAiNJjfqEzP8DYktChrTiMluyHML2kMqi5cpsMtnGGGyRQ3vvjwFXvkxTwHteFN8BHUJ46YmkwXEzFly/BDP7xWaYdog7k0fg1Ppmj+WSDUM3IAQOcquKW1siHbSKgwNULwLV/FApwNH3cRMq9awwWMFqagAF3Z9FRr4jCsWOdyozzaoLJoxWjfvfy3WCOBMyg5ENIwL8OXoZNAkiUTcP8KuLeixWM8Flbcp6wjqQkxGhPPHkEL8m/pG9OktkZ9Gwk7kcJmAoKZSaJ0bNdV9F6y5s6r2SLg6PlSm8qflMpCoMfbphUwMy+cY5Vc5jV8wgnVhZaTY5rgfZg5Tn8S8/J8TveJkHTgk6y+H75IPHJQTW6ftxxcDMnVW4rS5AsbPjTLoH9Q5R3d9M6oXZJy1idLv90hg2qMrKiM9HXgYu1lBc55Za+cUlYjzhev6PUO4wRHnaTZBkPfXfN6gfp12lfU1c2rSSqc71+gWWR7LcnYRBxVESmold400Bm7oB5Wr4BJfdH6WjuIOOZjwFrqi9UdF4dBum7mTtNN3YH20F/cKx/pDnmbasHMOqOAtE9DqRnEy264FTjwOVhG/fdwivthL4uW52D5MT/VguDC4aEw7bUkwljTup2ICOZGLHLA4t8sVxrvsjb61yE/qNXaJQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 13:39:15.9897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e92a1021-3a52-4ea9-0758-08dc3862a856
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450

On Tue, 27 Feb 2024 14:23:08 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.150 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	5.15.150-rc1-g3ab4d9c9e190
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

