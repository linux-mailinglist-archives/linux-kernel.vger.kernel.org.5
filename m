Return-Path: <linux-kernel+bounces-142199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FD68A28CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C7F5B2607C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DB053818;
	Fri, 12 Apr 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bSSYMZX2"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26FC5029E;
	Fri, 12 Apr 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909018; cv=fail; b=cZ4weLC/0pAaLsAPxFxLntUapInloX42Mb6Q7G+ZeKaTtHfomJbqaucGlOkxSazym1cWtusbrew2GFTwc9hkF6+01V2x5dKNU85LN33stxuW5FN6gSLwyICxgKdKSfLXEYhfr9PAz6IXGYJ2666X64xjGkAWiGhMN3MJmgSKwEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909018; c=relaxed/simple;
	bh=kvd1Sz/XVC8bLP94XunZCx92e7jy1Jxn9pENKMnEI08=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=GS3qNAb99mKQ9GyaHr/W2cu5jr3oBOs+39Go/O9tqdfQ5W9IT1zCRxrw8Xzol4bKV3chh+Trd/YZZMtM4ff5vavVNvkx0Lf2QItLS3E3Lc/qxiOe4q+CkhQTyI0HXDXl7vPLmreikX9REbSJETBxOoIuee0tvE9l8WwQHuceAg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bSSYMZX2; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2ZcqONkzXowLyoIVfCdnL+jg0OTvgXhJHiTaTUe80ff8Ey+UIcPgnKdwykWXqjMLDnkR2kJIt0/TFAJGEH2dffarHw9SfOoNE0zFTsfei3TEO4m6QHagTrVyIi8RhXkquCiBXTlx9Avy0pjADJX+MuPAbsKWiZE1wo6RefMNekdwUQp22vkqDXMhG1HAMEvRC7B5KS3+L9TQMbwLF8n5LNMtZt343iTq5ow/htDz77rWGRhe62Dz5dFKaUvhDwI4lWuQ8uMAMbv4fYtUFhElApZu1H4KDU11v3qzKgO5S+XAc/TjzppKdEtCoLmJF98ynjpWmJux6tNrPzY47rsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHcgbh2k+HiBAPrMg+OziuK9CkmLSqBrjH1RiWTa3OY=;
 b=RgRnknmMaNwiJQBaTc/yfIPfJEs5iKhC9d2D7h45nmVE6RrjWtetDUTLQC7B53aTsZq7k06F/D4DvdEreDWbWnpzZ7PB2oxUAkqVPQMn9as42FkjpxR1G4tDg3SVM0MJo4REETWZ/RqA3QuK8xCoeGYHp4hVlkE0BRpOEpktWW0GbF/A4Ql8kdtYGRBKV7wISWEMQ7KxaDlhKMGixwKX7llyyk4LKCS3+eDCnru+V0jKhTnxjtiv6wdyFdNtgQk9Zf/pHY5qdTaVObjttO/xNgane95hDYiQHdLK/pUQif8l+1KVCRMTQJZdc8kUYj4RBSQPwdlIsqYAJBDTCtehsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHcgbh2k+HiBAPrMg+OziuK9CkmLSqBrjH1RiWTa3OY=;
 b=bSSYMZX2tSho5J9N6YV7O5bDEIj3OOcy8uLyZMeHOlwe0+05+YlGODk2q4Zrn6iZPHE1zDh7KsZQ9B9iG8gKcVg/X3sUVEOYjS4USD6Jd6EpNimwRiZcKhB69uFA6+WJLpYuZ71qLoJxS4enBusrnA06nzpYdgIDZQXwiaaRCFa12/GqyIEpUm9EpX+pFVeZ82ibKALRY43pBHvZ+WpOYjhQiW09YJevrxX8thAp+kioT+0wEhjDm3N1YHj5V9I2Sz/kfC/gWacrxJcmsju97N51VlBF9X/zkPayclbvE+1zbXHR+wUVQ1/xBLIisU7+tVQaN2erqf73L4mORPQQPA==
Received: from SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::16)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:03:30 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::b9) by SA9P223CA0011.outlook.office365.com
 (2603:10b6:806:26::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 08:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 08:03:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 01:03:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 01:03:16 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 12 Apr 2024 01:03:15 -0700
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
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
In-Reply-To: <20240411095407.982258070@linuxfoundation.org>
References: <20240411095407.982258070@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f877e27-c680-42ea-9fc8-ee5e484ed95e@rnnvmail203.nvidia.com>
Date: Fri, 12 Apr 2024 01:03:15 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 327a9a2c-3fb6-40f6-4e14-08dc5ac70abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dtgXZN6I8hckPR9jQIurchHtmO8lEWh5cQnBdgGCg+59myxGyISqgHAp383SFYOKvTShVDxSql5c+cX4YmrH7uVyHITxFK4cLDFm/bQW/TILH9oHWfdNkdzt5ZAq88Mwy/Hdjg5CfZ3noYTlu9DJxxkKN7lml5XnnohxN4KxLSmwpRMDvfXksNuNKTWRsA5Z623DA662PyI0+1yAaQuTUI5CflOmmSNXqFWQRbuGtGAuwRyKcPvGiKVM08UQ+MUT+xPjJ3JSbr98RBsKr2AyscogNnlVhusDpdIFbMI7sZZv4UERZa51HylXsYUWQEFGByiVDVUudo4eM9+AEf0lxzJ8zQI7eHo9elWOphQZzY6HwEv4zmndWIsZUp+Z9vUPVWyixgzDsQ0/EPMKbrHgkXLl4EJL8vBDMx+V45qHTp57n6YcRcvtBjq2sSjDcqCDAZZOZo1FGH42XZEbzaZxYdJyuELp2ExmvSiscT0pJmSR4mAFzuT7ah9QR6VEyw1NZIgqdCw+u0J9/XuAU9mSlQwt14lI5PRQABDOkqgBU47q6WqnGRiwiuKQwBEkfaunzLUaGanvPyEyx9vrVYPkw4uaT6hX7tLoRLKnVvOxzuHW4VU9ghLM53t67X5BsZkbxvLmC5Crwu6UxPT1AHZIeMzxwlTJfkjVbOElyrLOgCUi1Zeywi+PpoLuGBfYdbIkOiy9jAxSMKVZIJt0NvbfCzGQ9AkBHCBOZbYMZ/7CzoNLi+2Qk54CkmN2oGl6YYqI
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:03:30.3309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327a9a2c-3fb6-40f6-4e14-08dc5ac70abc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

On Thu, 11 Apr 2024 11:57:08 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.155 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
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
    90 tests:	90 pass, 0 fail

Linux version:	5.15.155-rc1-g857e7024b96f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

