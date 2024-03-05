Return-Path: <linux-kernel+bounces-92203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A5871CAD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF21BB26497
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD175C907;
	Tue,  5 Mar 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YD8Xp26M"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30115B666;
	Tue,  5 Mar 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636326; cv=fail; b=Bn2rAXmmOgJCuwjRt55GH14goDeFlm5qrtV+5a7PwUGUmQ/i7dUiO6tEzrt69Dn056NnxDSjoMTj3SU3yZKwj4Mf7lpAjiJ8d3tDBttPAWB6I/IaN/xjWkhCCDWcYWrEKjbGR5c5uCkhOCZH9/m9Gtb3G2TgF5EzGbbR0PheFHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636326; c=relaxed/simple;
	bh=WF2FlAgyxfzxrX+HmlDQf5S6wwXW3bSje6pou8fuLdE=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=IV6hGoEC//cxFsHz4qaKK8y0r9hkpd2a/BbIP2NeVfS6XvA2ZRmDFVQ6RsQ04hBka1fpDn4ZNKfDl7W9qJ7Ox+0oMTjvOaac7RqdCmYteSh92K0gP7AuxYmto4/WC8IYwQbPxhZ22tzPPiy4OWzuqIZTJY+JRgdHjyBxvmpTTrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YD8Xp26M; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ4SpMwguEUFbBFWx86wCPY2aAH4hFZ+3D44LPykmuC9w1UOy5tHL5vL0GhW4sUhihQYmBqKGdQU169t+3yb+Mrlr8I2rWilVPrPHVpltjU7zESA7HlSwzcVjN7KOIYiEL4uwdC75P6uFxIyg7PHzplTs/CEPoht75EQcHE6+A+pJmKWsf3Havvbi30k+otme1sNyLnsMnso4LA7FYJHqrBDpytRqaMQG5zy8Xc6N1UQLMcKCXqMQlM/2JRqrGvE9D8y3gccvy3hCo3ESM1EWU5i2iKSHEnkPCIFQp9vIte3sWeavGXf0gCSu/g0gVSxcVirYWOBbgaH0hn1wxf7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNcUdJwOZCqj0Ft1SX5V1nVjBuW0NUrF/EYqOccpiZ4=;
 b=EbFVrwtMBuOVhX2CgcEwPaTdSK0AiKvILQCXOLhteLj2zYLLg4pDX0gQk9LLggwmKX2EO1h5HERXTw4OupLGDBK9rrvpXCL1cSTYJld+aKw12YnTROSorBtZ1DuQA3lh3dnS+MQ5OET/nZls4Wn/OS/RzqDJsJp3gXOrJ7h79PMoszKtydlc1HXFHGjRALRLnHogxNeQH5rVOEyZNBXJrRx0tcfnroicfR/I0BsXolmyPbzAjg+MrOOplIotYUTydkYhFM18dULXEMOYAnRAae/NS1tL2OcPSN2nQdb2bVu9N3rl+Q+sRBO1B+bQT5gThtzsA41y+RCo0u/OgYgbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNcUdJwOZCqj0Ft1SX5V1nVjBuW0NUrF/EYqOccpiZ4=;
 b=YD8Xp26MRXAr/zxjGFsKWGlDKyInYqhFpWfzur81v21ui+NAuYP6AhZBsA+kDD4EOrXG67uvUKhtUvVkU0tU8ZTDS4RK6twidj7J5BSEl41fSkwio5Kg1dvLF7tAqC52gGkWE6w8gwStXgvNSe2zvdrh7bMxoNZxEcHKagZKVo1jzBX1YSkemHxNsH/j1rlFrm5384w4FMxYbwwVOAijyYh+ACndfaDhYqg/76FzWgn3IXn38WTUtVpwOuuKaeO0yd+8o4LH6esO9wnTOg3EaW18cQBfZRiHeQyIEkajBCwQAnqxtcaIMkU0teNoFZAZb3o/JbFSoZ+1ITwojZyqlg==
Received: from CH2PR14CA0030.namprd14.prod.outlook.com (2603:10b6:610:60::40)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Tue, 5 Mar 2024 10:58:41 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::b7) by CH2PR14CA0030.outlook.office365.com
 (2603:10b6:610:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Tue, 5 Mar 2024 10:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 10:58:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 02:58:40 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 5 Mar 2024 02:58:40 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 02:58:40 -0800
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
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
In-Reply-To: <20240305074649.580820283@linuxfoundation.org>
References: <20240305074649.580820283@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5215b475-f8e2-44b6-b6e1-9968348e28f2@drhqmail201.nvidia.com>
Date: Tue, 5 Mar 2024 02:58:40 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bec8ca8-bda7-44e1-9648-08dc3d033820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rtRlzV/tHX1r+c5QUDbtSeIUIZcN6T9AMKXC5fA/kV5zuvY89/M+aIz45C2VrbVgb9xBKt4FOPggjzb/14mR9duZeYkoogxhxpC2vDzxOc5dCXbfBCpiwrsn0iwjhaj4+qvX7O5rvMHnU5n1OEGziljS2UMLLcJ4VghMIJWvjVL+JIqgDrdYu8I86wi411b4oqh6oSGCpQaTblUoKCfZRjdMMVz+xk9IQOc9gfAyLfUQE9spkXZlTTXl5mYhLPY/oRBehL6YWlHZNyS0z5TogscgAo86CNJ5xXdfAmVk+RW0a7Re8qV2q8PExH06EZF25c6ngpfQuh48DCAGEarVPlmOxFiNtw2dlwWDQLRa2K1Tz6TVCxE8dkH2++JYdkTEJRUXKsI/VB7GL4YyO6zw8StDVKGXXf8LOXW6Le6yZkuM0HAYPwIhcR5yG39ykUbfS6nE6+NvZf6MX6SAocG2a9FKktc0p33Gle4cS1duJ5P6yqQ5w3F7pKt+o6srwSRii7N5DZS3vcdxL2s43rszyxyTX3hgu1GccVKIXEnkHHRHgr/+AVLRTMqXkNXGb97LCa2PxmJ3nURJvOlNQAWD1U2ms7c60O7AOdDqDEvzS1NIwPHTCscWboziPurD5HAGlrgXZxglechdPG6ZpxF1Xk6nPvNUuNVxyP6dg/3W9WgqTsI4/XQGDwcexvzlBnCLBvvJ64EjnRPnfRiFuavJIPSj0BEJLlKaWu3T2MAbVkFJpkDnAgs+CG5vGCqCeJW3
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:58:41.4061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bec8ca8-bda7-44e1-9648-08dc3d033820
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

On Tue, 05 Mar 2024 07:58:57 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.9-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.7:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.7.9-rc2-g94875ec14699
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

