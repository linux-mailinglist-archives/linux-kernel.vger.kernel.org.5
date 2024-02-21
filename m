Return-Path: <linux-kernel+bounces-75426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FEF85E88E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD1CB2BAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6F412D77A;
	Wed, 21 Feb 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ufwL7iYu"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479912D778;
	Wed, 21 Feb 2024 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544952; cv=fail; b=UB2Rerqck1lohlhWysRiJuqLny7vUgxQQ7bezW9fwdW+JtegEBOHwtbIsjvTgcoBGywMM7QX1qpCt83kRzut9cGCFAR2ISyYhwgDoLN+CKhK+UU2km33vvlXc8r1bdHfjr7x+TLMnnRjc5e730eGGv6bh+VPr6qvKEaHAeitXlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544952; c=relaxed/simple;
	bh=44BJ9tc4iRwr+YYZxlMWzSf7xgWmS+6Je3yReF0txYQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=SCTtcdIHzxCJhoVL5SfLWG2Q/Vk83AK7QMncFLwHvv+RnBCCmBy8GMttSBB3rVBWEXnhzykgCy8mkL0dADPvzoc5FNCOWrgUjRiksXRy1GqXESNBw3MKF/oxUlbsHj7P5T6xZzcI9gcSXirzo515Vh+mVRGG4H75rIyYFK0Ip/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ufwL7iYu; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrRQgNu0Bq9fe9Fmhi4Ctj2IbvBU6HVX8CKYtjghT7Bzzm85pskBmi1++IPkOls0qG0ZrhL+B6vbPiCWD0kW0PtG4jvDO+GuTlrADiWC4AuQEDk26cs1BhnjL5ZdWfZ7ItgEAdqoXBkNH9brNuJwXlaUL6ojL5NVsve/qXsI7kN/JzbOAb7AmW3XGSws626tWthj9VkKo1xo2vgqeFtmySFbxkRwXqIlj0vk10rV/H3HS3J6ZjjXDmY1WogUmUzPZv3XG62pUwOH35yTF4pjXoAyobVZByXcGURzI/K8A/8hq2dXRRND+VXoubD7mUASiPgX3GgnMMkMT2ltBfkzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv13jGrpKpPPB6eP7zrYlFHk2uQ8lr+Y5Nq2TBN1Msk=;
 b=mmt+h2o5cSuvv5uROTdt4PtPEtTWHG9EwaLaKGKGe6EnsDSoHfH1n9zM69gqnETGygjJPIf7PZuMbkVtt59ugE137XyfGN++fY5WZiAjfaaRGFg0XuGoiv2SHruBd8bhPcG0lx79qDpHBU9I1vCiWBkJ1xgHgLX5W7gnDgLrHEYfidYNV746li0oaF0mseNATRZIiC53OdgnAUPuTdKjmCCx0nNcGIBy+jEV9d/WpX8pLo1xIaEHA4I431VIiColj1p9Eg7PlbBoFC8JlrWX1dElmUP861DfUkbGzcH1stziiKL8jIPQQDyj8u7geCgQ7xPXhU4dkDhcA12Efctk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv13jGrpKpPPB6eP7zrYlFHk2uQ8lr+Y5Nq2TBN1Msk=;
 b=ufwL7iYuqhHvwSp5u84/IYXT9d/RXHISh2RwE7iY5JouszLw+G1vnWoOxlixE7xk7mHlG2c6isVCxB/yegK2e9N7lLg9BJJDL7cJnk1OaVuArIKUORrYpDkmdH0ef9Am4oGuBHch8e5wje1Pkx27/ZX2ZOxiGlGdO4fjQZ+AOOXJipklYwM5XwFSy81JAhyBi6PtKUxGYEowuAFMHthca9Wgd+cV40645ntJXp7sQ7Xq+8TdIfv24pZdVvXWSf2j98yDd25gdhNZ3U2/ONJFJgjgmMhhNsLFdBuSmM7zwjNorqNZbvAXTyA3QOLojSWHWgREJmIi4HEkEdf8FF6gnw==
Received: from SJ0PR13CA0114.namprd13.prod.outlook.com (2603:10b6:a03:2c5::29)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 19:49:06 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6) by SJ0PR13CA0114.outlook.office365.com
 (2603:10b6:a03:2c5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.30 via Frontend
 Transport; Wed, 21 Feb 2024 19:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 19:49:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 21 Feb
 2024 11:48:55 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 21 Feb 2024 11:48:55 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 21 Feb 2024 11:48:55 -0800
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
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <19d41188-ccd7-4918-bb8f-481738d94e24@drhqmail201.nvidia.com>
Date: Wed, 21 Feb 2024 11:48:55 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2df0f1-5b38-43de-0396-08dc33162971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BbK1x0uupzXOwVhEHiRO0z3C615kgOB6i1Tqe/pRRghSR3x2dDB4i1guMMRClz1NtNxfZgFZdjlrbUFREC2n4jyAApKMhP1xlZuL6ZjDeYFDEug0uT2q28WAdeMpuI9Y0qIG+Xbw3uTanhjDOvzOJPv1ul0PwUxGx7p0okQ9e8b3AEs8VRZHwdie4kpNKJEpmJxvn2oT0QTnhrRgRD/uYUHC1O5L00EPtcn42LDMsONwYJuLi91tHnXhhU1pgvxvRZX3snYVAk/OT8Rx0M5RMAvpAIGPRCFqigEc04/ihu2yHoAgfWzDPuGbAMCXGV4FYDOfWWZqxpLwomX8C75LoSPxQjFa9FVLCF51NpCwIfPkOJ5eBD9MKwTSgo8wdlwiuhQCRzOa61TCASJfxzF1Zi7vX7VJD6jntIdai8/o7rV6hELq1O17Rz2HGhEoOcJ4YzybStjJRuaCXsN6C8/oqsIvyc3/80TMc6OHn5xjGZvtr87XEetqJO+KPJc4if1wNpeXx3/TOy0CYFZTyx5igsgy8Cpk80QdUJPDWIsnXXOoAUM/+8LmUlC23OOlddm9ia9/+1x0CHLroMNGAl+HzrC2Cm3xietgo354d9tMynrjzqZ/sV6ZovxyWE+eWIu/q34ntUxBQlOJyOv/rA26XStH3Jo/GMyWvsPuB1mfOTbRr4m3MhEVGDJWVWxjjpfs85xAptDq3ltPav4YkikIJQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:49:05.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2df0f1-5b38-43de-0396-08dc33162971
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

On Wed, 21 Feb 2024 14:00:51 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.149 release.
> There are 476 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
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
    94 tests:	94 pass, 0 fail

Linux version:	5.15.149-rc1-gae70058cf980
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

