Return-Path: <linux-kernel+bounces-36789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5688283A6AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB191C230CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4887418E37;
	Wed, 24 Jan 2024 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WqocPnUR"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CB18E0E;
	Wed, 24 Jan 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091804; cv=fail; b=lCsrDvH2OiPiPRfaQa/6e5zT68MQl6DjC99aZaWC6+shyyFPz1isYBvqWeP55VYw17/vd5fYMzfCp9wZr+0UnZ+57H8a+K1D399kmA8QaS2cXmh9i1zU2nk7zDEpYVmrhF4VCtVDYeLnz2rArULcVDJ7RR83qiGWmGM9HcmqaII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091804; c=relaxed/simple;
	bh=BrRMY8r7ZQG3aQewPcFOCelnoKhrPWAmC6DQYef8KNw=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=AxuqI1Ex5RoAycPSt4uhRL4BWwFPd9o2pxjbGw6k+Ce6rNLJGnW0E2qqm02nG1Be6+3156x4QMZn96o0eG+BRcBTd9q1+kKgokrnJA/ovTDRMV4nM+/cg7BQAm/wVpNbFejvd8J0STGV6WMJE29lfJsEepSyFSF+AjpTwdi+P1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WqocPnUR; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ3U2oFnpWgj6JAzfYBuLEgSKZKVEz7g81M91p6iD/kiTLnXFcBYTV+/mc7DwdMzFLPxJsQPROh0tkcBgAExDinAhypnROp07PcEIotS4rKk4dEpW4R0PIjTAVR192UjBV6XYnKap31jGDtULpk388E2BUqkqKLuKGfpWoGkQMbFwdnsBQTdVi8C1m0LEDtlXefgXM1lcBJaM9gBVB1W5jiD3U0bAv4QWLIqRFNtkLSDUPJLipTb9XHjVnWYhCVKH8jEYB3EUWc2eE3gIcCQLEUXgaOYzqXwoajTJ7ZepCQwScqeJMfgtP9AYglRAOdnNTjHQeDbOjTdIKvzLh9qHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcYjDwqfVhv7USI+1GIwsWeXjchDWRBAmXoOSF5jCe0=;
 b=hU40IW0FAGfKzNoIoyEXAhO5r45/2/12ZWLqCYzAwB3pa/PVKMExHyZXDZ1RcokJOVxzFu4bkX1n88xHcqE84FrVnNBM4Z5hHDARoWEL0FghIzdLpXUK8oPynRY9qybT3DlLEqu96YKlH2FhB7CFI0f4zOgxqvrhe+wbuodH2AT9jZC8V92Ax6QH9WkA6w9nyoiez6l87ZcymybNVfimzEOkJpMSHgIkfj3VgBYCq2xsYmxGLCe7BpNkodo6EpoGbgPzdxG3rFHADxb4Wf6XNNIVuFpk5Zwe7j8aQ3dnDLhYP8aMjB0VAQpT2vbmoP6kHgVK5KBCczfQ9xjYtRWjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcYjDwqfVhv7USI+1GIwsWeXjchDWRBAmXoOSF5jCe0=;
 b=WqocPnURAYv0nxo+8bnz3jbogQPTmn79FleT2lr5flfm9qG1Kawo5X4x+cuvW69uanyIlsfWgGyhpAcKM4qLfrerAtNT4bdOELAeHm1BCFmWCrstgDYxMiAbSt00ahO3lz5zqK/8uUBNOQEve+NfPEMPiMh9Qev44eMIP+LursMIA4TmunpnQc7HLnuBdYYwpYsD1G9Qy5d6WMsKM8mPCoWH4501HQ4L5iDYP84CvYAriNkyz2MxAwZKX+Ce/Wj/oPCxnBnEq9TgNDK1VbEJSJwlJ+vRtpSeb3IBQ3sCKolUZeRY4opTAbilIJ4erI39tlgA8bvoTlXmUtbZOGTZUw==
Received: from BL1PR13CA0341.namprd13.prod.outlook.com (2603:10b6:208:2c6::16)
 by SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 10:23:20 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::92) by BL1PR13CA0341.outlook.office365.com
 (2603:10b6:208:2c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.10 via Frontend
 Transport; Wed, 24 Jan 2024 10:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 10:23:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 02:23:09 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 24 Jan 2024 02:23:09 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 02:23:09 -0800
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
Subject: Re: [PATCH 5.15 000/371] 5.15.148-rc2 review
In-Reply-To: <20240123174500.819179356@linuxfoundation.org>
References: <20240123174500.819179356@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7a6083e2-0170-4a9b-8434-44109f838d1a@drhqmail201.nvidia.com>
Date: Wed, 24 Jan 2024 02:23:09 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: ad47bed1-3d64-4cdb-fe07-08dc1cc67c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d2erVDsMA45cGJ1GiZI+vx2EY9Q6+giDcrMfn7ppi+4qcf8HBK8eWt5CQ+7Plosi3VHdYKcvMQK4H0/3l25SU/ccbjUOgEYRsc5+fClfV5Q2/Ztvw0mvIO+leGX+MGoVDHLuqpWIbSn0YIs/OcU25mEODA1Jx1UpbSbCeBWvHJ5PCu45Nbiq0T+PqCM/Aq/SDoleg0g4rPmt/cAZTsv+fFMhf5nvj2r0+CBYzyEkg0pvSpPybB3EO4d528gjazTn9jOwZxekXwdN7KrlRJD2Axcuk3a3DhdJQWTMwKa1vNBm3VZAey5ZFQv/UdwMG2zW4oYZtUrwaFLzROiWnhJ63WcjGb3qzSAgrG7wWYRCSgcQr1NbdoL7EivMsokop9MdSL3u5oM1ixOiPFNsAvjNzWpzUudC49vgnnliZvkkJXom1CVDddyItQ9jQUGGBH9JWN83gpStZ09wlEQJt6ulGnJhrumJct83HnhN0NWE1nnOYT7nEK+K6nw5qNv/Dewx1VEJoEMklpzQvBxY+yR79LI1aj2rFn2XN0C0RJ+YGFVKAD57tFxVwLKrQl6li7fiMbrsQld4+sl5zQgMp5QjBRqAEDVrbUWFuiqeGCLQgWEz60ka4x9D8jlBXTEORkAQxxQsUJrugNG1kXWbn5TcEuHMm84I8hCq4rVHD8P7170xvFvf6Z+2Y1a5Iazxz/Ch1M+F/XkJV+OfmkB3/64gs/jFjY4H8wAgL+fItfozadLp81iFvXVV4LctHAoNb/VlDJBj3dZ278kOxT19lz184zupc4TgGTFZDWJIOsx1Wr4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(316002)(70586007)(54906003)(6916009)(70206006)(47076005)(86362001)(40460700003)(40480700001)(7636003)(5660300002)(36860700001)(4326008)(8676002)(31686004)(8936002)(336012)(478600001)(966005)(31696002)(26005)(426003)(82740400003)(356005)(2906002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:23:19.4447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad47bed1-3d64-4cdb-fe07-08dc1cc67c6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909

On Tue, 23 Jan 2024 09:46:45 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.148 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc2.gz
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
    102 tests:	102 pass, 0 fail

Linux version:	5.15.148-rc2-g6de5fbff4f2e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

