Return-Path: <linux-kernel+bounces-139039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012DC89FDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC2F28BB45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648AF17F369;
	Wed, 10 Apr 2024 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HIQl2Kh9"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE67178CC3;
	Wed, 10 Apr 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768731; cv=fail; b=bfJtY6a1L0IJSwl4uPOLRkZBgBP8hjFYNPEQZrCcqK2m+YS1EftGSKH/5N6jZNU0ulf6E2Ie2wTVF8uI6YdSC/G2QJORC4xuNmmUeEQBKqdE1TwgEIJivgOngBF6JFTfeIa0VTSnsPK4MU2YUBxfAoB50Vp6sl0SpzfA+cJvgGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768731; c=relaxed/simple;
	bh=PhT86y2dxGOMQhogoKPupnB7FJ7xsTVmreWnQfdJLvU=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=OLWHp+OWsYCyVz5DvRgnbdqjukXOvUdw4nXwqfL+j7rQiVk0wkCy7S+HavMo4+SxdbZ9tcXjPjWx2vfIybp0/xkAbkazicpuMZ4AyVWHEdTdujglEvPvoUqFIwte3viL4OP88m+GkSFeYZHKS0rKmpwTjcTQWm/ycJjUOm8Jk3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HIQl2Kh9; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8k3YLlq4H8N4b5HE7FjFJ0MUTC3QlY5GVR6vKDXZwARwp0+1MuVBDXLeGCAnBtiO4e/r0MG406B+8nIG3355v1P+wM4e1YdNPu/OfN1XVErmd8KCV+N+C3015QYbeQNz/6R4tc/fd94JU7J4YOYooTS5w/oRMih+1QfMS9x46LndcmCmmNX6k4aZh+eeUFBbV4CTA03i0CyXmojZFL+KKv9X2VjDvs4NsTcVzidDL/rjc74+PBt5BwSEIDDRG6OY4inU7V576fdS01K2DRyf/e7umDxJbbbJF4Fp448qkAELVNC4wss2j2cyEiiaJEifU7Mlscp1S+8se00AngRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/vXweFLUtkXeVY+WeJ8g4jnamMbwfrG8ROrCo5x2M0=;
 b=WS6I1qcO8uzjbOJ9wJXS6mto8rf+v3ywtzb612L89Ra0W+TGTV3hItE9CWVZ/Vu+k3bj3cgWkqr12axjLHhPxD9oh0UqgOp8G8utWhX3g3TiJAP2o4fvAhh6xoY3azCAd0Gw225OGfXcr4YyLng6cwq852JafDv9fMdVKUxfy86hOxh8bLE7HO6ZZ/xmRNUdQqBLAMnTWccYRvIObTJOblUBIE80/gy36susDdOBtG8rZ29j3LPgOnn/hFItzB+uejhzN4vAvCajHNwrA7bX5ftouWhVCxPD9mC3pO+/6phUSHLXPd+lZSpn2A+D67eJwcqVt8pZKy3pq3ThyGAQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/vXweFLUtkXeVY+WeJ8g4jnamMbwfrG8ROrCo5x2M0=;
 b=HIQl2Kh9U9OYUuxIoakj6JLoyxxNDuWo2ESqirVazx9WW3euL9sViI90Y8deUOQH6VTor87e+GvvmTBNBmKta+BXGq+8ELS8S9rlMXdOa2n/57Bo/LpqAgrIdaySxFPgCaIgy5NRehCLMyNu97Faz6+8hagOz/T98WAeFsgQUhiCCrP7uFHoIECPrYTuVGdoCXpN0rBGOLXwHZMaC188iOQOQ9E1ASFKUFFq73tMWWUVHdM8h33pQVOtIzXM9xdCToeHu66es54gzhnbxgZE/BAupyu2xLEj8zit5N5WTjMTSJ/iU9f8DEY4/s0bFHyrWkZX0oYdowTTZXenjskCzg==
Received: from BL1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:208:256::31)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 17:05:23 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::87) by BL1PR13CA0026.outlook.office365.com
 (2603:10b6:208:256::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.7 via Frontend
 Transport; Wed, 10 Apr 2024 17:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 17:05:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 10:04:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 10 Apr
 2024 10:04:52 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 10 Apr 2024 10:04:52 -0700
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
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc3 review
In-Reply-To: <20240409173524.517362803@linuxfoundation.org>
References: <20240409173524.517362803@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <52ece696-9087-4ccd-a703-e741270cd2e8@rnnvmail201.nvidia.com>
Date: Wed, 10 Apr 2024 10:04:52 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: b5bcdc27-fbe1-4d29-de4b-08dc59806923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j6QAvnM/jvpRLGqEA6ZDE0hI4glbyI892CjXNp6mz5Yyn08x64vkDwbTdxEH/uBQ+pCL1vkj+zqOnZ2XtkiKUCSB237KIdwo0DekB0BVDYfk29+XJAAB+T6wrvuOC/uSPHHzqz+FjantC+USChDg3xc4dXaKfgkfEoBb9v8VlrCa3/8gOsMvFO6NN898wUoMeUxv4UYqBtocueh1R+awNoRL8ZU93omZarjbzG2+WQL6REnPA1nbT2KjDaRYiV2/mxex7td9F7x+stbmWzHy+MfSandxj4SSvnH72lZSfS7Ei0w4lRHPWdoBUARUPM0j6X/f6g750Wijzniaumtd7tn8ZaOzoQO1tfCXp5ZUbqH3a6ybKT8WCtzhXL/0UJ0SKEKy9Uj47NYpDlPAWel7pIXLbFJ/KraBB7tMMIe8+kySo4SHM+Fc81RSlUxIvnhSsjCl3M1ocOsNAs4ryJNH08S2XgQ/S5wuAanxKrMw6mYuDOc9TK7Wwo18fw/xpxrfoZseMs0sIkD1E8qNKNBNYxEEWGC8U8KBcmZ20Fuf/eJvEUfodVJkPE27Dh7q/uCgSeJ7cemuzXPe0LIC35eXoGOLthaijqAmTHekfIfgs81PkFK/JuFKldVO8cXI6t8mUsyB0kmofq5SqqTzuCKGe2GwcCkqC9ofs4Hqlgc8p2soylwLJiqT5lSnjibRNfFIUnqkunArdHb+2D3PqFUj+yueiqaVETVCMqwDlxAG9y9nDWlZYmOOzNVMECxBt797
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 17:05:23.2380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bcdc27-fbe1-4d29-de4b-08dc59806923
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150

On Tue, 09 Apr 2024 19:44:28 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc3.gz
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
    102 tests:	102 pass, 0 fail

Linux version:	6.1.85-rc3-g9b31003bbfa7
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

