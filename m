Return-Path: <linux-kernel+bounces-85118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CFE86B09F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46761C21A77
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2A15A49C;
	Wed, 28 Feb 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iS0SBOYf"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B614F996;
	Wed, 28 Feb 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127612; cv=fail; b=Dp/IupnpU0ORH7OEjZpaMuPuffChZwarpnkfFpm7nIw9rw2QquS9AGEbl/RfnlwnPt6HlX7+uJqSilMzJ3ZuDY/TMoGYsIIj/347LQAWx/hWRoF02TAo9xZUQrVAwVUPYMJb3XeimvrOiddAbc/Hcn/N/hKrT58ydflF9qcVPc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127612; c=relaxed/simple;
	bh=vpPvY3scfBuTC5v/hD2ziDlsZ9FUNNL0bW8dEyilEjo=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=ru5J0x2C9VURdyvElrJ87KJRocqO6mv28T+774cx7HBSXGRDUQK3cdas8tt3Qlx6xqQnu4BsrjjF/AQe7KMqBFq2qemOSHziZL4wnRniQHW6gkB+aTfJznuADwHGNKoA9gVZbqLtYziVOoWymfplTGppqJavpFIQMwokbDpI1W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iS0SBOYf; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM1mFKs/rPKY5Ig+G+qt4DIuh/DW9rYc6zTnfKlLFKPh1rqB6qwmq5ZulkEVfCbpIAha/36X2Qdhu+j43wNKnq2qHFXH83uGv8fv3vOJfmmDltvia9pkGS5NVkXAXKiOnbklXOz/6NaQ78FqQ7qfpHH/QL4MiQjo0gZxjg81Oe6p5w6cW1xdkRldu8l1sAQvUWG4qTJgnRqyXNsIY9lDl10YQn9SdF9Kx9wghf+KihIn5B6x20m43pTo6uPHO0u8c8FP9UWaCjaaic/aGQfANGjTc/Z41BpuqySsaTGX/SrV1C9ZAWo2OHRs7qy13gW1zW3/zBG+YOos5f/YvyT8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVFM6gR4vmGauDiXgX2mEP3C5Z667xhxu/fdAntb5yE=;
 b=L7zwILmhQ9o0y0tXZggkwUppZEusGByaJZ2SvCZcGxAf2QKjDf6H70JTTxVX+gPOgJETxw1zkvMOmvcDkR+e3JYsBw7jGpnyNosuBQc6YK1jAuTkDSwxkrsViucQ6pfMUd374QC+szh/MdGkmdC5hVE96VnxCalTR91nyOFud6auUBJFoi8k//18Q9sgd/iYdKzeBdfPkcGrzd6zQ+xNsj0HvmaaTK1SlVzaME+M+5dYDi+4scgVHqgEVB7vlScOxLTicFnBJSCWFm/BGk2PCjMDP8s4NDg+0thL19w369B/Jogjfo2smozAlgOLn2ZwFwQGGJWVhffn4Sc+NEreSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVFM6gR4vmGauDiXgX2mEP3C5Z667xhxu/fdAntb5yE=;
 b=iS0SBOYfq1UoBjAfTxZEPUbEhO4k3rFR6yoAt/0MvSeMqFh897wFStukW608jfUvEGqTiMoPZlyVCjmFlEYn1zsnfQ2WafxBHubdv53jolcASL7LkbiF1LnHeXPYRxhk3SGr6mE0JDhHuK4OkKt/0tn3T3k9CMuGau2pmm3X7Gn2vbfKLnZ2zyL2OJb3DBx59n90kO5+DnQ/pPcirkoZ8lGiO647UaIGnxz4UntSCpneoiE2F3ONEW85njpsOBJMJBciYvKaYPdbwMVQrYfgPh1y3AdK7UlqcU8UJp22004GSsCI9beJuTc8lOTMyes1IFRsF12xcbulNOIfqMG4Eg==
Received: from DM6PR04CA0002.namprd04.prod.outlook.com (2603:10b6:5:334::7) by
 SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 13:40:04 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::64) by DM6PR04CA0002.outlook.office365.com
 (2603:10b6:5:334::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 13:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 13:40:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 05:39:45 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 05:39:44 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 28 Feb 2024 05:39:44 -0800
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
Subject: Re: [PATCH 6.1 000/195] 6.1.80-rc1 review
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <84f81f29-059c-44a7-a6d4-b2c56edb3089@rnnvmail205.nvidia.com>
Date: Wed, 28 Feb 2024 05:39:44 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 256ea8bd-3c6b-4da9-3252-08dc3862c4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tloGbKcc3baf7ImQB7p57oTT4vWYFyZuGRjhC/ATA7O81vKK1iAq2LkCve24H0PxxBYCkxjRPnwNPPF1v6mvcuDjSggpUxZ4P8YRFRGqWari3jcFOd4+mEO9bZ2ytlcPPmD2u3F3P1/rvxKguKiNvojikkf1cCw2PNWTFpkdX8XUXcwxD/XJcozOpqXwyBobeu3e+4vitz2OEuogkHRFiqIcc0cxuuBmOorfp6OgGbDJoZR8ZmG05cBBix9QsfAOWQjuKcxovF/k64gx4PPh2eOEorC3gM++93KkkmqvEFrSRv3HPYD0VVJf7M9vtLZFiRE/wRWkC/1lqfK3oqKP19yWVGZWAH8BjZbgts2FTBxKRXD3qIMNRTWsz8zljCvpRZvvX7eAieVw4B7IYNpuh04Wn/0YNfKLKRFYPaOOqo4cutoo3+7jKtlm6Yh3nllilZI8VpyKDDdO2yz7TIRryzWkyQ8gDUhY62xIU33neC/Qul2FbPTjqHNP6bcum4jqPspKu5e9Z80jgDMgXNw64kY7qz+828HdMB6FECHdiP2+ZKeefHcnnOS9rY3FdE9AziIGX6JLyO9UUbOeHaioc65YQUyGB25M72WTxWRY0PaQzFDkYn9XOf1s0JG6qUFQPqTCxRAxPV2217iZdfM3u1vtQ1BLJ7zPm7hYeH7GBCuob2tgFlgYMnmswmFNl77/TVmmrwPiW9sIaFUZoJ0r7ORBVjbcoOzOUqSMSZk9wacw5vvidZygYkyyPEL1DT379HC79l7bVA74XLZNgH471tX8T3oqOgEMVqT+RkdIYg0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 13:40:03.9919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256ea8bd-3c6b-4da9-3252-08dc3862c4f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670

On Tue, 27 Feb 2024 14:24:21 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.80 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.80-rc1.gz
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
    106 tests:	106 pass, 0 fail

Linux version:	6.1.80-rc1-g8b73abf80c8e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

