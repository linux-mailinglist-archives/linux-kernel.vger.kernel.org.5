Return-Path: <linux-kernel+bounces-92199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1F871CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430B7B22915
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F05B685;
	Tue,  5 Mar 2024 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R64dvb0D"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A485B5D2;
	Tue,  5 Mar 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636309; cv=fail; b=BnyeybIt35TbU6IykuobSylv/xQ1qldL8M+3X5ilCxBELqDzM839wVV5M49Ej4YtFhKC02emezTdNWdzoMNYGu5OtjcdNzPuUR0maWuHsNPy0X996l0qRzLJd+4sQbab4j7/NWN9NAJufm7N31x35YpWpi7C7jI+KOi3wBEg0mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636309; c=relaxed/simple;
	bh=Kde0toh2L7iKufV3GOACddHeGKlqNbOAKvMXILg0mDs=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=SPkTUVgGgEP7a2w2TF63lWEvjiCGbeCYpkz1FljXFzW9b+12ytlqHcagDYdvdp8dt8PMjX7qGSSo40hSgYggm+2ED/3warDyFQJFA6HRInB4bkxhXdssSm2faredV43v//iZXONCDmgyvsV3gc0Er8Cvk98od+WFRnooqj+qJkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R64dvb0D; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU9RvDh4IlzHlKFLqatI5afzaqlVB8YubXQovGVb4LEvdVbVRhlm/rBeyoLDjQYoJO2NcnZCwV4P/K0dntwIKv849E9qZwH5FXnt4q+s7aVfFJT0RlmZSHpTg1CM+gHv6H/k/oy0W3sWhkuDkyToTsVETTSBWvzAjyxerRDV6Q+XbPC7muj1EBelkpBc3RoUq3/X8S2hfkx/TI4nfsamml3C6NE4mk0qcitNdOHIXpOcv32M9miwOP9E445L5hmb8fbjHwhUAG60HA+6t4ah5Nhs5m50C/5t6w+wd34uJgl5Gkc/+JnEJbFo23xIERvSPjrx13c+mFfQsyTF0Jmxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QjhNtOyjRbmOOoaXbUKpj/dBhRBuTyLe9/8yVOmX/0=;
 b=ltGQ6mNfVYWiukBORoF8NDbCQDFvw88iaypk+WbSVqKYBFI8P8AlIZa2QVlrFeHVeKEO+1ChzH7pL5M93m0suVe3acoWDj5dndGM+IhKNnmNxujRpNgsMZwkqDM5fcNgdzClZOD6baQYc1Ti+Pw6YJtWK+HsLywLy4LXXXtiJPJt28sXY24PB2p8cMbzKCGnaamduQuwW2qKn1/HizKABzO49UHbK15trUCGT+Orwpr7+VKDx5h76r178oKrXgelTwC/6mZ6ekzWKVgxyARbRUHuuoZ49u29+VnZpT6KyKmJQ3CuOsL5RFbNOxInXxv6BbfHZzdFgaNiKi4Pdv5xRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QjhNtOyjRbmOOoaXbUKpj/dBhRBuTyLe9/8yVOmX/0=;
 b=R64dvb0D4F9iMsYKBf9BdA3Y1ll4tyu1vjhsvCACWfLVwX2SgA6cv1PDikSEX7Q6UfKn+92GHorvSpe8oQbD0u+zw0fddls4ZAtKY8gxGHd/Q87YiLbn03WreJp6IuZvklUDhhE6/71kgLuTmUv/ne5lknID8kD30jJ9+cR+k3pLOVC5/i9IJBezopRGjgTN7TJfrjAGzKO7V9eiZG8D4iobzON9XAZf11XWVZXVVllBmNjRVMCqmKYP6AlTJ5CiLKlAM05mNVKwvXvvfWSfL16c8mO4vnQjx5dOvhBlet3fN5eqnqwlBZpE6fRV7H69tUefC/TaiCnh6kfziQhN/Q==
Received: from BL1PR13CA0390.namprd13.prod.outlook.com (2603:10b6:208:2c0::35)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 10:58:23 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::23) by BL1PR13CA0390.outlook.office365.com
 (2603:10b6:208:2c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 10:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 10:58:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 02:58:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 5 Mar
 2024 02:58:09 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 02:58:09 -0800
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
Subject: Re: [PATCH 4.19 00/16] 4.19.309-rc1 review
In-Reply-To: <20240304211534.328737119@linuxfoundation.org>
References: <20240304211534.328737119@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <bae509b0-f50b-478b-9f10-f9e1f08a8272@rnnvmail205.nvidia.com>
Date: Tue, 5 Mar 2024 02:58:09 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: dd716de3-61bd-4230-f01b-08dc3d032d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lt1I1PqMrOM5sqxs6GCmu804xVC0oxn6nd1Xf6+wfR3WJnv0r50D/XfX9UrdRX6r9IcVFVcspFN3qWLTACN/cj5LVJEBvqYttuXaiKoRP55g4/UtMI/o8qmzgrM13yBdz/YDlQYESYq3Eye98TIOsLnn6hCRa8hy7qRpGyOKNBuQzM6w/TNaTrHKnDWEMlBq/SGYVj8SrNvPfR3831e7Sfdln1/NW+y6BTaUv8PYPKdbhuxGYj/elf5zyLlD0iYgjK2i8iPIogcz66kri4AMjSGRrqeNzNrXqgjoHVZzZuMPZ6sXhWnjNBH04fZv+rv39ElK7+COMf000xsZ6LR9V4y82JL35Jec2FwwXrSFn/2VgYRZAoLXDUvyaLkICCuthm4NVkDJqKcbQvhdCVZCPjzPOm+wgu7gfYE/3Vz+VJxcF0ikpmfIgWzJHSomPOnKiaqaY7mT1vKPXG+jgdIG69Ckl2optPWr09TjABbKw7tQtKcPB97/MIcK05KqMFz2dHo5x91tFhnLUD7hS471D81XP7PWz7Zsa8dlBCP5hoL1T+NDSURJUjcD6ZFOkC1l5ne3Db2fiGKu0m/oaUUbnJ4xikPu0meOw4wQRrp2vvUXGO7sakBE4z5jHddV2pLwPFMrPwQiEGfbHeb4chQgVH61LGqydV3HQWVz5Q1fgc1nMFtUOMk/zTR1hpx9suz9wN1KVWIzAG74A89mnWYiQ9vpKcOKGBuQTZdUTJ8XfK/SP8qVINy7fUPiBf+3UVBK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:58:23.0507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd716de3-61bd-4230-f01b-08dc3d032d36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166

On Mon, 04 Mar 2024 21:23:21 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.309 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.309-rc1.gz
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

Linux version:	4.19.309-rc1-gc854e1c772c4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

