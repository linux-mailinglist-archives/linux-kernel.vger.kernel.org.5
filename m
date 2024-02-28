Return-Path: <linux-kernel+bounces-85119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA43B86B0A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382651F24C61
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84A15442A;
	Wed, 28 Feb 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UAu7vhNS"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300F153516;
	Wed, 28 Feb 2024 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127621; cv=fail; b=kFiMiwkmhe72HNOGYm7BHMK7nARJf9x9gZ+IR/GD/D/PJskfnYZKNAxTx7h8PU+r5SMlPAH1LPU9G5aRC3aaeukuUKpcSg5+2p2b+zxyIr+4JFsEZIvfWO+HW8wsETnZ97jsMbJHVZ5EUMwLQSfnOZS3FVCYlsu0icBjI8K4gn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127621; c=relaxed/simple;
	bh=btBjFgrlX9dF0xQq2YdimBjXddl7uQ2I53BA3C8MbhM=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=f2+ZtRovsNL4HQq2jwkYI+i9VqgQKTKg24VFleFvjCagcNmXgumbqcOi/UH4TAezUgelgDgU/vplDNG4eOIw1geQj2xYjggWvLdfGj1CT4cKLMiK/m60fIHniPchSuOefF8xNeWC/+x9en3zh/g0LrzSYGW0W6T4Tbtw+1FhkFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UAu7vhNS; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OummJh6sYy7Va32C4pZf6qQvJRJ2C76iAg40mcNuhiHMSA1k0YlgDg7KEFRAIc2/A4wWqS1MXidF3N+nU6T/vqvJAy8oiGeMSFsxjwuMNZ/3FX2HysS29smJB2D2H2ozPzDKKWvvSEF0XOX7QC8XkcJJCuT6PUd1CUqmvwWZuDQNDpiGZjapnU5CRMI3zc7g/WzUxWhZulbzq/XAuLXDOFxRRk8V7vCa3PLOTZJtram62AUIFRfVLjx6+rU0I081xUztZeV7y4qE1U1yET43leBq0p/8OFscua5jOoUNgMVo7+bPstv+hMLF+rNm15yBri1VkpF2eBddSIU5kOpVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbUj5gnJ7YsTmEbeT9/DygBiSxMyuErYAZeAN1VtQEw=;
 b=Q2pjwtDVt1ztBq3Ug6yfgJAWdzlxmETNUpwXYeyg8Mm4QHFFaQMcYRYelvG68nouHoscWpTY2RF3HOdUWqtbklyetmD/gyp13ayEg9PjfOCr6Tq4ckrYcwwxbHewUwZyEgXS6jOJuEgOxvEV2GR3ecGgILlh+FunZy9fvpL1poO/1MFbL1MuU4AdwtXr+Im+tOLoLaoKDbSiUFBBXe93vrb8/m3dGAQxE6sz3+foTtuWPXT+H+cSlIv3X5KkZckG70QdcMA9G0aZjplo8xfl9K3ZEdLKPUobVGznhHNYo54/FYo/eRpcA7MXHYbWZVcv9hbDIO2msHgoXLn3vPezng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbUj5gnJ7YsTmEbeT9/DygBiSxMyuErYAZeAN1VtQEw=;
 b=UAu7vhNSyPMltsmaaQgUiYCCVyQ4fCr/GAPnOn+qUCZ8CaG0eyhX8cZ19630P53FESRxoL9TV3h7x+vNrKUYdEr5TuMCC1rkRwB8UsgHh0bpgLaP0okpLbzWkF0kQ2sPhU4cPN+dDv66Yz4uubiZPKykJIsetnfSaeYWEHVyi+WzTdzvxYi87JLW1hM0r/hleWF+F3OuZbolChsg6hvxxuR3vqWv1sVLYyvK87gO3V+F8bT9MljQTvWzmjOFzMMfXa+aqAWvrFe3/l+l/1VT4IB9NS3sQf4QXC209JpxyAEroYFJYirjP2SQTqEuPUjJJUj3PXxP0XvjT9W+S8r0fg==
Received: from BN7PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:20::32)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Wed, 28 Feb
 2024 13:40:11 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:20:cafe::85) by BN7PR02CA0019.outlook.office365.com
 (2603:10b6:408:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 13:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 13:40:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 05:39:57 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 28 Feb 2024 05:39:57 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 28 Feb 2024 05:39:57 -0800
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
Subject: Re: [PATCH 6.6 000/299] 6.6.19-rc1 review
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5d8ec5b2-21be-4ad5-be66-374e5b9c6b2b@drhqmail203.nvidia.com>
Date: Wed, 28 Feb 2024 05:39:57 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c715d8-251d-40d0-ddd4-08dc3862c7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FbE4ciSX6eoVoRuecwCJmaprh6Upq5bohRACe1hHTZ6l36NB4BDtWKNi1C+/CTN/sPTR9CgzT3SVUqJvYDyx6BOWTkZoWLchQX6N0q3OsDcZJL/PhYPKXHf2Ixf58qdVYYp34B5Kgzu7MW6irO6GmQ699OccmFlNAyqG81JQidtoJY8gMoB88c4xuEPXo4ay67hcntWDffm9KBDfVlraQ26u9Nec/ahxGfGRudNTXGrLJGge7j70qjF+HI5EHqFrrQNfhevR8LYV/hnAudIEosGrssaJg3JCvorvi8A77SkHrmu1tOPR29LcidaJbsrF3SKtafKKD5V7NqwkUKP37HEwexDSUAE3tS73yRgAOqoHYenzhX4OpvNfebXTy18GMyWy1aKPnXG69ftXHCAPJu/YWcrUSt3An1lkvUM5Mh0l6FGdq7Z68l3H/VRsgwgT1KCTYq3hwj4Wu18wgPXXpqsIGlh2CtMdN7LcB1N6iVK6TG+dcRa2e7HuqgJz8Y2YBAAWpF4cvniGku24YojcleZyE+T7Ivotwv0dcWxDB9AgSreE4EwIiGsrPSxue2N6r2hvecj5G0dl4A7sPDr5MPL6vQnNYvIIjAr2CY/NOcQBJPR/uE2QfKYOZkoJB7NSqb92yvG6v5GB7lQhTR28EaFIEMqGv8oOkkI5aWl+NIGR2Xd8Dadx4DWFT7QSNgJaOAPmO7hOX528qzSYB6lW28YPOIwPq3e6FQ6ZlDdAxGpEWBT3CqPfzdmOmAOodh/XW2NxTRyas3pbIMmrkGHQ+Ir1yIRqkRjVw9G0hq3zNNU=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 13:40:08.9639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c715d8-251d-40d0-ddd4-08dc3862c7e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473

On Tue, 27 Feb 2024 14:21:51 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.6:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.6.19-rc1-g3c05aa9775af
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

