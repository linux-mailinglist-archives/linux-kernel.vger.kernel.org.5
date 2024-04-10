Return-Path: <linux-kernel+bounces-139037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA789FDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2D51C22DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E617F38C;
	Wed, 10 Apr 2024 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H6eTMy1j"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7A17BB18;
	Wed, 10 Apr 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768707; cv=fail; b=uNtZpgT4CbKF3utZGBm/APsQ+lxvRC9GPPL6y3F9Xdhl99RiJBQcRj0tR6pPTbWAC3VWYD/lK8+uqDb1r5lV8eYIMXx8dwj57+lj4a8cipsDPnw+ETqO33zAgfIAh5EYa4Uvx7V6QRzw+OrXCJy2Zx40qOTO5Ef1U4wTaARqIeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768707; c=relaxed/simple;
	bh=SMHcywZWbLa0QWRNPrP+5b4KsIcXgV7l57iARk/OlLU=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=MZ6y1qk3cKp4ptL048JdVb2eXCkyIootFZJEao8xCYW6WytW0GUc6Yweo5Y8elXQ7zWMQEyISaIsqSzy16X42lCvq27tGpoCq+caZeB6uOFUYTHsHA8EviZsyc5N3nPOObDLEyYA8HusGdHgcR2QgOE8wOuBwoZxuTZgTKQnunA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H6eTMy1j; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNA/JdwdlF6aWbeaUjCSprginaxn9vucYRi7lypOG8aODJLL4SVw5AzIjvoyaZB0GiGhp7h+L84cGYVtNRAhqbb6BJDsjxRGXGtDz32/+vkpfpTbT1iZUlv+NBx59SFcqdk7DdqcH2eMkNFGW9zqMsroQ0icfbw6XRL2nUE185DqS+kh4CJc9KbaGY7jgUEVKgyK5POVtnD9f39wy9DjK9pDZRxfoJgmkh2XB+ehd0yUQuC+VlCWeTn0JL3RIP3MuLEQEAgQb1iA+c29fI1vIHBtxPNAVYUAKjKU3A8P/MyGIoUXiAZ7tNKtjOQNYBFd1MjYaEMvenHXVVrvwTQmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoanp4RSQUoaBB3VpoOa/QKTE/Kof9N8pAL8rysPGTo=;
 b=FIAK4rYF9Z/3BvBzjIjZe7a3/t/IpKNhfK2b6nWnd9TvDa30WKG1mrj/bYGE3VTQXBoVjtSqfuNXypHr/3/FCtPwYpokv8DWwox4XpP7oMASmdf/nBw+yNkPlL4/GPWlp5MWdoTRC5LjedapwcsEXj6JK8p2FsSRZLTjaxMzq/MhvCa9u+37rA8Hv+CwVkUJORuJSZ4CgmVnkyZ6pmuxSKIEe+HBPKPW/nm08rg+V/FP8QUlyYJokRGsNbrr3mBJiTZaSVNHloJdQiAhOV9UY1iHi5+3G1q/5eysLFK9ZGmkreB0ZGzaztqx9Zqalgw/xKW+40EwmEPLBbogRHYRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoanp4RSQUoaBB3VpoOa/QKTE/Kof9N8pAL8rysPGTo=;
 b=H6eTMy1jQH0CC8CCG+njkxiJFSJ4bwDaeb0CRRiOnUWemd+9jSRPzACc1oIwsAdbspY+PZBdoTuem5GEvwP6syKIRRVt1M7X+xCoXlLm+3JcWpyur64Xwmv9d5ClUvfz01/zJqQVzm9LV8J9xw+y/5SoqghU0gMMJdM1zhiFUCKrrMpZipTMIj9Mo6NmheWEVJnORQo/JlJJYwgNNQm96DHcPHt6PxUU0rriW714bcQvyQLx1dHnFrFlNz41qJ3A8r3CEtcb7Z99+w40FydXGcsXa0RkVpjQK2Eo5+cyRMP2Oo7LkIIubXXmDzszzLdU2oOFG3tBydD7BpWtN+jrAA==
Received: from BN7PR06CA0038.namprd06.prod.outlook.com (2603:10b6:408:34::15)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 17:05:02 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::58) by BN7PR06CA0038.outlook.office365.com
 (2603:10b6:408:34::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 17:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 17:05:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 10:04:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 10 Apr
 2024 10:04:34 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 10 Apr 2024 10:04:34 -0700
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
Subject: Re: [PATCH 5.15 000/697] 5.15.154-rc3 review
In-Reply-To: <20240409173628.028890390@linuxfoundation.org>
References: <20240409173628.028890390@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e3706e81-2201-4321-82c2-97a6d5bc6b30@rnnvmail204.nvidia.com>
Date: Wed, 10 Apr 2024 10:04:34 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a7a266-6c10-42f7-13fc-08dc59805c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3VSrlrZWCIx6tsLd2SW06U2tYZvuh0Ou9UG40acnQFWB5FNm7bZIW9KI+2/K+mwWuFejsYGKR3AC5329bWkgYTq0SXkiXYFpmqtIITDIraLbKZkOGWpehoDgr46gy800GapjNOOpVDQgvVXnFnUqHPlSC9HzT3THkcUJOWfiFO8s58arRRzFOF5GZdY8uaKYo/8KbX/j7SzEVhPoF1t/SHQkGjsH4hCaK82bavMbvG3kWhPThbQfjGW0Wb54cxBC//warVcEJg00kUlHOztts3ts8JFpAhE2Z5XxQD2CXDfbZXSZsWkTs7nTi8G3NzOVs0F3bfEmpD9KF4bd9MZROdtl5lJUcCd3RXVSNnDgI/alhTtcyQhdrQwkmqn1IVP8xPlZg1mLg4IDHdouR+iiI/r4ABcpyshGJO2Hf6y8ADeqFD4y+KUCy4mAhGhJAatySAUQOCU7vCVtwbuoUX1Masir271zL0hcufivht01Epg1PL+VgPQfPJn5h9HF36/oP+1lsNrHTMl4x+jDvhUWUjV/zKQelMeuMUlYy1KBlLO8cnsaQx1USoFe3zVWBgRVizldFe152eetN5VOl+enSS1ZlW88RQkFzhJe4pf/uUEufuBafzbx7qRCuKiuhYrs3tgKEyRMipRNLp1sYUVxp36nf4T7W9I9IVlTsWvH9W+sKDGnpbllX4Xvis4f191e8Y3PNybxh79qhjiiZjTlMHf+jzhu7DScS5XwOtJhmi4p6v86H3PC+QWLtqUgLRH8
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 17:05:01.8550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a7a266-6c10-42f7-13fc-08dc59805c65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836

On Tue, 09 Apr 2024 19:45:07 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.154 release.
> There are 697 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc3.gz
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
    82 tests:	82 pass, 0 fail

Linux version:	5.15.154-rc3-g8bdd6a2f1b3b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

