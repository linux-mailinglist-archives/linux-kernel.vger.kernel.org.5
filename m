Return-Path: <linux-kernel+bounces-128549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04A5895C49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5DA1F21ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F7915B578;
	Tue,  2 Apr 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tOp8ItS9"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD315B117;
	Tue,  2 Apr 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085262; cv=fail; b=DxiRHBO1Yx5Fdr7Ibyzr5bSid4etPw5HiDQ3mAe6QyqPVTf1lyUpVYTtAe/F/7b1sHcBqtp95kSDE9DAqM0o4lqv3lzkSPXda8QeM5Kko3CqXpW1SeV1US1rq3t0L+nXkz06JuKuR6aMIQJ3lbQcwSSFkyc6Q1oqqGROwX2rpSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085262; c=relaxed/simple;
	bh=GwG5fyfG23tbDV4qzX4CGMaOWRcRmmwR8e4zDQdAU3Y=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=sddtQcA5qziYDkDjFP3r5HM9SSA4kImqDSvD4jV9+qt5TtOkJUScWvZUVD3Ep2eV/xLY8YW6wn4Md9yCxSTL3ocolSTJAmNaEsImqtCptvuAIdUdFiv8v6lpz/s5ymODyEB3+96al8lKMEIAMszRWsqeqxSW5cU5mqyANIWLjJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tOp8ItS9; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4fmhPoJF5G8anEe8vu16ao4YdT2/O15v1PL31o1vvmuvAOnAGvzF1Tm0eT8aJbso2yr93E7tyiATaQAEEMSCVsxuTYo2BK5Yphz60kWvqVPizHtAzmoltswYvXRvRZTo+Qhy04X8jDsURJuAXfk10ZLGVdUWpsXhg/159ic6VqVtdBvKfhacFAcjLlG1ks1Y4P5tdFZtLL5GN0AVJ2Uu6QoOZ2dGd8xOwj28ofvWFtvHpoDAabjKCP8BustDeHu9lzt24/nlu0xttCQRk5AzL09eh5e1ERD6/KRmCExY1yLr8huRW66tDu/L1GWhm+8hn/IanETkGL3F2iubcYW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8Jw5mZXoAgYcnOo5H8KcbMTZiN8cSpMl7MseyZWCwg=;
 b=hPW7kuw+BlP90+lLQodfgZKb7m+YC9pwOtDAKh3KoobyQeRcYvayn5h/nY/Fxkx9s4SUMJgJSAMPXzXNMIQJHO97KfGncbuw/qF6Ehkz1giIuwrrbKkjecL+2Iie0VVFkUMXAT8fhg1uOF4mJj2gcxM+xJsexQO9mgZuWUbyklPD/GUFEuzO3S+PA0vi3W9mWFpw1R11HclgMHpEK0uetP3PWicbc/ypg1iyhSjpiFJUJ44NixuXhmZukP27xCci2js7VkvSeAxH2x9yR9S+iOHtENMwaeMbzz+7e0ZgU+IlgkjNVSlBKFcrslWttUCUbY7MWKJnCZfQmfsgnQtCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8Jw5mZXoAgYcnOo5H8KcbMTZiN8cSpMl7MseyZWCwg=;
 b=tOp8ItS9xolQAEZElhsUvSncl4sd/q7dwdp3FQcJsg5kWRTMLcPbxVlR5mS5ko5mcyIDSDLhmuKgLh4eNr6Ro9FMY66oipK8mfVhLgnccq3ZMSylMBuXiSo5lZQbsX8g7dQs2m+4GUoolcD4EralgKFP0Uhpx+yUap31XSGu3YOuYaqMb+xSYAh48YpYrrZxTDVSZ1wm1nnEBz38utkfGGXpUH7WwzGNum4qruNhcwi5155klEbex0nqbbGo1wawFJJwbgwLimbwuSkLuUAxs87ANUjfTntUKnpQRDnMtmxOCEtayCLedGt6kAi4s4U0b3aSrYB3RVyFWZ3CmmzF+g==
Received: from SJ0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:33b::19)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 19:14:10 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::44) by SJ0PR05CA0014.outlook.office365.com
 (2603:10b6:a03:33b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Tue, 2 Apr 2024 19:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 19:14:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 12:13:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 12:13:55 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 2 Apr 2024 12:13:55 -0700
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
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <781e0512-0dba-4e96-ba03-618d57ff79b6@rnnvmail204.nvidia.com>
Date: Tue, 2 Apr 2024 12:13:55 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6b5951-bab2-4090-c53b-08dc53491383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ekNUVy+7rnB9QI5cRNjL5n10MjOmlcTmLB9ErBajWiilq8BG7yudbXoThNTC54Esx4bAP0xQ3xHAiUkz55ao+k14D4IZHnWK4E46APZdiB80UP3U9zytBipcfqqJcF1EjHVCNyPv+l4SmGAb85o67EVLCoalHxlANM8F2jjAshY0EQ/odDRvIUGxXcE25vjnm1tc3x+cewnsx/R2EQx4PeFz/tkGK4jcvIo1418la5znIsiPYHLTaCJH46/r/fG3JVSEdDctideHVrRNppUJ72nI4C7i7tJUtBPMrl+vX8VIUWmrDIr4PVb2IUMRIIUtvjHLrhVxGAK/OAUj59ZynfJ+jET3G5UsDteTrJ5SnFHSqQ89Fdl1NoPn153eO8zsRhmhIDQltPw/c49qn9q+amnyBSn7a7kjP0mbvYBohScOIlKb17uoaVi21ZlT1fR/J0dkW1jBBR+euufQGpMe4L8jwcsJuIU9pXtlWtxuoVaMv08JIYuumgL+ZhI8pCq0brYj8klMFQPtglmhg820eeLs7orl8juCZveYX4PRuMqGWeQnLSZmdMrPl9A1yiWh/Z5D4eaybf08EDtkVDHg9oU5jG4UiA5NBYSVf4QxcTkufax4EOGkkl+Jx/iNdomLKVU+OVltRD2BGGqq2mGeetjUzuD+Dzplwomf3/0DOo8CuSl5XO6LeLq9kX7nKNogW464WyY4/45yfePVWncLV6hFcPMohagy93nUTxfA/NzKLiTcFd+1hFr5Gp1pIlNs
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 19:14:10.3482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6b5951-bab2-4090-c53b-08dc53491383
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670

On Mon, 01 Apr 2024 17:40:49 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.24-rc1.gz
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

Linux version:	6.6.24-rc1-g75a2533b74d0
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

