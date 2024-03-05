Return-Path: <linux-kernel+bounces-92202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7A4871CAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49DC2845D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124935C905;
	Tue,  5 Mar 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uq1GMiTE"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA465B5B0;
	Tue,  5 Mar 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636326; cv=fail; b=ghCLYz4CHvR56MR7HuqDI8C/KUT9j0Pr0TNKhWgBlBpup3GSytm3lzYJ6rraRM7xDZyjq0OjMPlr8y9fHBg6PHmcsAIsXU2RPwpWWJ2ZUi7qos4ZDYY2u0TlHPu6YvjAlKjNqI7THcIysOzNq3icJ5T8E1Kmn/e+aqg9ZMQ+WhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636326; c=relaxed/simple;
	bh=1RUcovKd1zODM0S7NzGTbgP7OSSUOHKgMvItdEnj4VQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=CVV6eSpSl6DZY7qgsG86PWpqmLefCciZbtrc3p383MptYmN3miPXRywAsVRv8Or+PxxZLxvB+98FwEew40lS5S3LOSD3wqLWY/TnkES4ToYXhGspwJPcG3EomwEPlnn0UX/6h3mckZbIouB5/QJoRxFJCS5I5GP3KJSQ/PLtS0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uq1GMiTE; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSoNbNmetw9ELMAI3tbiw93IxNwm9khkncjtdPdIfrmox4UlwJxy3zDGrkxFw8iFk10d5hcGhI0BpPYS/YOWKiSmhr383hCd1/RiIm7LZJmO2w3dshNor5xS8GKlGMSC5P1AmgS0pKw/elaU7IKVMI2Xs+oPpLjpFtqbTAkK4Wiq55ET5DGB+VmYbR3lwEnvFMeTUZ/LAhIGtB1Mh4KyR/OdPFYrEXfAu3fkVjdE9xOh7cYcmM/5uMzg8hoXhhI48HQ9+OrI6WYqlT8HVV0zomypTxfM/0XkhFr3sCdlFbOkwFDywwStrxtF8EdW9TTvq42w8P4E1BD/h4qyStWV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPGxNwGfcMlFY65QhWr/VG4Vz5PVLR76IZ6P2Xyvpdc=;
 b=P8GW8XZf4ae4nH3wwt5Mj0FHy7Cm11PnBXECr6TYWoDLfagXTKt2z5hLar50xps/B8fM1ETq0kAEu1z27xXx5LlkUjRmxtwbfiFqT7J1RYMhlc32ooTlY9qkwh2LUhujYUf3FFtDctYmMzo0z9+9n32JxC47kz2zcoXXelTeeKxLxUhpAEr39HN+PTaG4Zaxo7xeEDKWVjV/MfXpHYyIJAV2ipNGasWMO+macs4AdukJQUKdAhKT6kIDQ1RJu2aNjME32iqgGtGmF4yqo1hQea6MoLtegvLjWrMhOwzXF7xCqxkoisnbfMkOrvCbPc9fqayzrJXS0RyNiTf3DkT5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPGxNwGfcMlFY65QhWr/VG4Vz5PVLR76IZ6P2Xyvpdc=;
 b=uq1GMiTEgOEBUutBEgsH3N924FTqdvyCSjH1Ov73j7Xt9xjxtET+UwO2i/Bx2X2JWEzkfcFnLEWIcC9l1DEMX1zXY4OyEIuHMYdWG4i/B4v9XQJvBkM7L0bjE8dkISnPvnuTuhIGm/37XoSaFhaG66MRPOZ52C8tQAtT52bUgCeQZrkbJ8OtvY/A4P/G0Bcc4zMXNsVgO9vXBdO9DkoowYth7+lCw5HIyPe/QpN77v5sX/rTfZmcSu1PwMSOxqi4tkmgbkgOxMg6x03hpNaQ6iJ8tP9G5oDvbRI5UTUINJOSWxCcoAcXGanIcQCG0F4UtAucHOfNKxABhYCPR+QkaA==
Received: from MN2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:208:120::32)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 10:58:42 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::ed) by MN2PR10CA0019.outlook.office365.com
 (2603:10b6:208:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 10:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 10:58:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 02:58:28 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 5 Mar
 2024 02:58:28 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 02:58:27 -0800
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
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <17b8cbfc-2aad-4f17-a6b4-f489a8b4f8a4@rnnvmail203.nvidia.com>
Date: Tue, 5 Mar 2024 02:58:27 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: a4270530-c2d5-4c75-fa9e-08dc3d033860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E1+2SkonfXmRJdIwbWK3QndjyK9k4le8FpkC9QxNSko8+CZvR5eBUOjfNgkHLySu+jSbg9a0QvDnPjQGcHowlSEjQd5L7P4tk2+bhy0UP2lb/xLU3B2BlDHJ+2c/wlQQ0c7rt9FM94/mPdCGvvtUixy2IbrCBLt0+2gXip7yF+/2MCsZjQYKbAhTg62RRB8iOgbLdapv23SwM324g6A1Ua/ArqpWevuMjQNLpnpelW6GwdEPrj1ti3RAv1fWW4DASA0AaBoNhzA1XGsKijsC4+4SXnUkAxtz5FeKX2wA7w2qK4D05ycaHy7K2fnI3TSviBWtuOoLAl0+J38TBP6IX6DxViM42ZzrW+fGheTp8ZfbQ7HjQdVSACN5dzooW2Dgxsdfs0avyfsWUMZFDxuFjiZ+tLHywmR8Q4cpe2UDVu0kLsS48dB0GAMuRoZ1PXiLjbkI5578HLcn7iJoRbzkQB0+gKTNuUIoIT0fv48+WwU9z4mBKxLlDH2Kl5nqPUN1sO/kEnM5cOSlRSPwuwumGTInLHJNsizxsZKlXun90xu/GLiNPjV7zml1JrHe/+fiGwltnenIABAVx+ydV1hwVknRO62YplB7NGq4EF6h0hdDnpDQ/5INoWSI7/V06cNLpGdTAmmaV4eU+r0IH0YCBJ9QJAVIWcr17viF4OHy1LWGZoKVqrvJMTzZa57K4JKIVedu99NO6ts7YxtK2DkvCCaQB/YbbSpBvSOB6GI3cdZZ8uxGIqXk3O3ZHWKbS1wl
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:58:41.7656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4270530-c2d5-4c75-fa9e-08dc3d033860
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885

On Mon, 04 Mar 2024 21:21:03 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.81-rc1.gz
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

Linux version:	6.1.81-rc1-gcf578ac947cb
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

