Return-Path: <linux-kernel+bounces-75425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C30285E897
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C870BB2B813
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5FC12D746;
	Wed, 21 Feb 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FsE61pNp"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250512BEBE;
	Wed, 21 Feb 2024 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544944; cv=fail; b=tgX50hiNm/VhqE3RxxfI2RtiXtWjJxB6DcEIRCdxDmSMNt/DCuE3t+AtWkOfKIXYKklrSXxZ5nL7tnFL9uTSl5mo/ogh+V2lDMqGn7R05I4LyaS54BE5rT5TKsKcYMjsFkr/LkSjaZogkTR2DTYny96kk80HmPCXE4I0bk6y78Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544944; c=relaxed/simple;
	bh=h3H2yq3eu/EBXLqeKkIrT7jh+iV9e5P4F3Yjfb4uZFk=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=co1Gu5jErwz3lWHlLQ8SXWiYUw8ZHfBfg2BfiZGA/ET991DPRyG55qLbnSJ8sW9dVMowa2l6cKLCQSO4W43i2dqOWMBzKlZrqJF6P2uiqkIArVL6NyX6Gmp2vBme9oU5yJ2A3LOEA9qDOjLm4S8suOV/GFj1ZkxR89wNpbiH41M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FsE61pNp; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZDbqaSCBCS8pW5nK878/qQWSqykz6iA5zpXN6mc9SX64/Em6WhjE7KogE2P4bAAenTxHJ0JfVLcC9QVKWpSD40zNMvoDBiUrJwhZ6k4d8T/hWY+UuWsnYBcj1eI43nFQOevpotuz//27trEin5HWTh9Rpul9Z2WlrLkidH9sdm+ul9A0ff1XhFYzOSY65lLQVNhqedt/Xv4k72Dzdl7HFuDKRzlTlB7QcNFIGBmS4XnN7sNVc8bYy7YG4e885fP/kLoAO3hhPdKes7wHKV5IJd93oOuybKjUS7IaNA/x7aNtn0CdGBd4p0q7XikmR3NZDxZwTr8CFvMC1iosVe5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGRcwXYB1FOjTzINoR63UtZ/tb1KgX2CGeLYkfLawDQ=;
 b=ImDWBOwrQZdjxOfCBT4KgU49U3MeojXIMHcoUb2hXxPpqdi0lv59/6etBdvP9bHY9C1k+8L+0q/8XZvjdqwIP95k5euJOlRRSHxkV7QpTyJ/wEQ5DYxDY6WpIDnq1VJxy6ejB2efxSRXSMW/N5GahYUgCUEUb07JjDpp9gMd+vXk+c4zrAgdJuZXhcO1rIjSNXyqrs51Xy6gemB6O53PkfLQp3iAmmY6R3Sc/5/DETNIeZ7DjmnT724HtquS+HDr8MWc/5R1osuBzu27IarTGfYdxGNGAWyDnSa86U/lyuHSfFIabIkuLbzBjiIv2mb/i+q7wd/ZYeETRtn9TFjlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGRcwXYB1FOjTzINoR63UtZ/tb1KgX2CGeLYkfLawDQ=;
 b=FsE61pNpWiuQQ3UDdge1wuzqryb9PADccRWPCcaOoD9ZXDDcVy4d+CADJcFH3DRiu8BOC5n0VjC5/hVmzTqX8KDu27YlgJ8K/Gs8Ny7Sb+jWt7B/kMYws/+LS178MGPgcZsygSbMwWgd33S53EMF8Dt+lFs4teLzoxHz0LXhCaIFEbg/Y9E7s2Gbw+eIcpDnLn81qA1UtPDQZfwD2v4Qzh8jZj8FYZloEr+clQRmLvmwDDBpAtUL5xeTS7UpjMJ5yruqwJroS/b4GdFZfZvTaDZS7KEND2Xy3J0m4MF2JbfTirXoNIZjKd1HCYZGfY4imDDE5MQ1doxsl3onikYxnw==
Received: from BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::25)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 19:48:58 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::26) by BL1P221CA0029.outlook.office365.com
 (2603:10b6:208:2c5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Wed, 21 Feb 2024 19:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 19:48:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 21 Feb
 2024 11:48:36 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 21 Feb
 2024 11:48:35 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 21 Feb 2024 11:48:35 -0800
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
Subject: Re: [PATCH 6.6 000/338] 6.6.18-rc2 review
In-Reply-To: <20240221125953.770767246@linuxfoundation.org>
References: <20240221125953.770767246@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a3e79130-27b9-47a4-ace0-6ad6d5ebe767@rnnvmail205.nvidia.com>
Date: Wed, 21 Feb 2024 11:48:35 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4a623b-602a-4bb1-c89d-08dc331624b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/hLKr12ZH9WWFyOWLZ+Mk/KgsOxaPC1lOU8nNHj941fyWznyOGXVqeAjrhNxquS3dOWEN1iHvPD/+8y+7nEM79Ef+e5lcUECTkDJMg3rwE4bBObgmlnNboxuqn2r+zF21pxPVwlX0jyUF4WuVvfCOJVQu/6tBktW60dYy1JRUoMU+ZfLjTURNB6piC4fGoqOaURDOMhV45Fin1yVPKK4WFWWmtQo5jSWuaCRUxOu/1qWTTpR74oNOnMQKMS1E3KdnmiHSuVsLg24uVc8zsWZhvbCkEHKPQPxnEjcz9biOY0UVAF9t/LpeLIJ0+uipcy1OEqsOl54XLCtWKuzISQkBH2hdiEjeSmdn0B4vA9/FI+8hqY9Lgz2f2A4Ta+UfRXEqBe+6aHjGaTQ/vSbE0IyZjA5706J5X8EFGFiRAZ/YzFlfG7WajBycR6wydBIMlNwapa3FWpbUu2GY6J9jX91Wq0cj/Cn+5UJeIahT7a3FKhFdlKyLbTMGhK7iAnn5U9z/DanjKSNdJSHx96ysLbu+birXDHpnObfPGX13ZYKJAj+OHJHjdnUvXkVCnLhejJXZvLECcdNg3UWirmEiL1+cFged9jyJu1Vdpribt8FdzzgO8FL5JL3L2fEUX+0GiaeD3hhwN60vnhiuj0wi/XXfnMo+ltTZ/+bNCv44mqG0b7H3G4N+fawpOfu9nEhoF0Wrw1oBoj31lj/N52/lDeAFw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:48:57.5130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4a623b-602a-4bb1-c89d-08dc331624b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830

On Wed, 21 Feb 2024 14:01:21 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.18-rc2.gz
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

Linux version:	6.6.18-rc2-g6f4f386cf24e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

