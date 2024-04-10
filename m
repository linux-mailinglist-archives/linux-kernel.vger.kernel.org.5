Return-Path: <linux-kernel+bounces-139038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A74B89FDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D84B1C21E37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C2317BB11;
	Wed, 10 Apr 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9//ENRW"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411B17BB10;
	Wed, 10 Apr 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768718; cv=fail; b=TlZdTAo5Wy4+FTDNgeVdFSXM5mK7P/EM7DlJ0zCdkUpfNuqg7Iz11Be+9CA6TV9ZE1/5trpJ5Lai9ZLihdfm+eUEAkRsTHDoe08qBW1mRRkClevrpImOzY3SS2X64BJHHg+Gbi3unHELCP25DXB5cgvQLOnx2nxo8vOCrZOe5H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768718; c=relaxed/simple;
	bh=KqU8bJGJg/vArWI3UnHDoDE/8qu+fOUZYtA4ZN6Tog0=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=lTZeXjf1ycu7pt1Rg/WcKfvJURlRgHtp8UNGTqtv8+imxn4felQ1lzhIaXQ1xWuCLRoYyXxj4SYpeJSCO5FxO4rEajd3YT2Yc6CAK2MnHVWeg/QdpEZbRNql4yY9TRdL0KGsnoy7uEFLHT/4K89cx3uhw1S62j56W02oUUvkWnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9//ENRW; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8K5HXinir1rX3x4UwUvKduPfVkORd+CPeXpWRvoKf1gzW3iYEbZldKnHW+wcIiDXexiWCv8UK4UdnN0GtiZv7rkgvVVFcYu7rZ9vz28e5udjP6yJjRKS77EjLCJflLKR2YhKGzJAiNyrCGFN6GQvWQ5pqDHrZSs+zUb3/PgGzMCwrZ1NWXMtycihaZOmCCZAfEcdWJBkp5MiXi7bomgccDMBDJD1NJXeuGfo8RkKgL41RfiZqIVjaOz9WVdUcXtLLhGYRBLePcyRxFBIN4RWBTFiTc2Rag0Ix8AYS1HQPD7YNeij3CNv7dLTbH6efA5tGDWz+BHjyygdJom/GTiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06JWjkjTZ8dUTQ1OrFUaSe4wXnCWVkhBjor6vJ2UsuM=;
 b=C5rc/skVrS0xfTQhZemvS6NOTwV+ea0irQ3hWyJQcyeMw9M+Eg2PJkyh7s4DRAcQSs7LETMPwvpEX9fhyAOS+pHP7Uro1ir49XxzSRr5OuyBn1LT6EcBgLLyMQGLi4sUEcyHN7gBYRFVZJx8GMTuPITTvaOZIsaifa40Pv4L5JbSgWAgDZoRK3izNFms6rfwoE93KN9sQVOGRr8+DAm7wgLOa3ZkjsusOkqUYbR/U1MvD/5Rwgs5Z1J35giAYi/RUBRtgfbZ4JDYIsgVTQjReAPujzEBROUQrUNIvcT8McpVj528E5yHhp2RvHou7iuDcjJARXyWQxrZhRt9nZPXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06JWjkjTZ8dUTQ1OrFUaSe4wXnCWVkhBjor6vJ2UsuM=;
 b=i9//ENRWUiVgvZM+/CIxTl4frdFz7p4jt10FgZCuFUmWksvsP3FNUpOeBm9MJw/AmDSH92+i60wFQVBq4M1bhoZSDqqKi9FXkt4kh9QN5/12QYtgsiknYpVqvyMlIIxNooP9H38a4yCd5e7QRI7GJuEaT2fh4eJeGer0boJZF4ZCGCKWvVnsVzP89XCnebIeco0cKHlMSMARFz/QoSwb+Jj1hUQkJbHWH8GCWLChuUp1uzPLSmKy4PyqjM0VVuXu0/C4Fm0I2qGbq0LEh3VrDuyEu22dfyna3hip5sFppx84HhGdpODh/0JnUdsptb6pDvXGlnbkNDTkm2Mc4HibfQ==
Received: from BL0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:2d::33)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 17:05:13 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::e1) by BL0PR03CA0020.outlook.office365.com
 (2603:10b6:208:2d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 17:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 17:05:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 10:04:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 10 Apr
 2024 10:04:39 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 10 Apr 2024 10:04:39 -0700
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
Subject: Re: [PATCH 6.6 000/255] 6.6.26-rc3 review
In-Reply-To: <20240409173540.185904475@linuxfoundation.org>
References: <20240409173540.185904475@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5920ba35-ed4a-4f74-980e-9eaea7583e9d@rnnvmail201.nvidia.com>
Date: Wed, 10 Apr 2024 10:04:39 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8fbfec-9438-440a-e04a-08dc59806315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YCjrG8kFVkgrgOMRST/t16nKfz65Y9d6aMustF+FJw2QRy1rWPN7WkHYxq0gbbPj8rSExtNRFojvSi4EZ5cPeI+MdFwMGVKM45T3eeFzWPqLHcy2L/ouSH755l8Z/3jXd4xwqjPoAPoFTHqwl8QO4138LeqoZGAIf1PYoktuZHzexFZmBiKBOWN8LwVk1MFL2itSNiCH2T0pE5dHgJhS44rSPniw2Q/15cSGulctm9edTXv7YD31O8NeqIkp+DUclsD/6d6ininamTiPOesoOGvvnYDVpfKbt5zFF8LEOdaMIksBhPqyj/HFszGIy5bKTKiNqh/mv2REmyXTvUyBzIv5Vf8+pABm/06coie2d87jAy80+4Twf9EaePuTk3yoNOPsXP9xZarvF66ws8dh1UZuDldj29vRwH8tpMdw/1E/jA1P4PZDHnpwuZvpRB82Ngzb2QNS8ChF0S1hbiE1DVwCuZOItF8dnqaSGXZLcr2dBTxWZbfD3baGcMkz8a5+DJ0m4C2tm3r6rIkakjVGNiEsJF0ef632ffBbinrn/VuAdFvwOEBau0WsqJPqXbDne6OdiMheBZSlSLScoF8pQ/xkJpk8wtGBvlOYpXrLq9JhAQy6GtidYJlghQ13OD4a69NI82Red0vBrFqAuYJw0v1obTF9T6uOiclFcq0FcXvyaCjKadZt2NBJahXuZ55JCF0kBqrjiwCgGA07lG79EPjdqdiWi7rkIm/AE4C74yo1k2dpn0yNW1A19uDm6cNq
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 17:05:13.0488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8fbfec-9438-440a-e04a-08dc59806315
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661

On Tue, 09 Apr 2024 19:44:39 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc3.gz
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

Linux version:	6.6.26-rc3-g63547075e080
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

