Return-Path: <linux-kernel+bounces-142202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAAA8A28CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BE11C212A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BBA502BA;
	Fri, 12 Apr 2024 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m6mXS/9d"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A954BFC;
	Fri, 12 Apr 2024 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909027; cv=fail; b=AzkEyYNXfk0zh/LkfIrBabfBXuOtGLapjkgKLXCFkJK7JoOaU1/dcz2Csi/SZ7tlN/Dic14ZlgA1fiZd8B5Nf7T1X8jpaCijMV0tKhJw497HPduzJSOrLpiT84m1nEiaemMRx2MmNbQtSsnMA5X9Civz7OmHV+tVOR0zByX8GBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909027; c=relaxed/simple;
	bh=GE+H2xTyO5U4sATZCSCzJ4N/ueZiGQsFjWl7/117+5M=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=Af7no5nOfIZzX3PiZSnQVyqCUlft28kreGdKUwws8BDJayFdXnHHnnog2+LyEKvkhYUUSiIsvyw0DRMBxhbhuFpkM7OdDwNuq8X43OAbTlkUbrMInP0j0OYQMCGIr4q7Y6k6T6UTTBjwdhT1e1BtW6Vvn8dccdzYPZ4tkujX1gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m6mXS/9d; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+h4ZCBLAjEjfJiVigVQSShHU5IRmg8J6ztFEBbJHGKq0tpRDFtagA5KthPaxJQYWYnLh11WWVrZtJSghHmsfUDznR0LH3Artd3oYHH0JvtWoebaGl+8VlAlN7/Yr5AFAQc7e3l+8YV3ajYUqjYHoCHeSwRn1GG2p3AmrSfW3gdxvp4m721dFSkkQYum8IBOdb3R3DX/j1PyH/cELpvXhTvE2gDdt2w8UkWJwfZw7lcwQwNE1m5xd2NsRsHZksxsoR+G+QTRdkgZfXJzAMoAjPB8fjsWxUJdDTUiKqeP5Hdd9Lxwu5kF7YUMBkcYD+fSOXbm+aonr+79gn/Ad2FumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfbRnxc/+bailxtUee3uvo7CgTvenmuOBujQbay9uRA=;
 b=nzYpWirLa+AVLRNsBN36LEKl1Rpt3i3HAk5rEva08Vc4XYwM8cbQVg1apXwjFvvxUx2nN2poFrUgNMcC+4RRQ0yLPRBsVGpMJhlce9AVUD02H3XaicibNg3ydNfBSXi6+t6gBhlXKa41HMdWm3hygA3jZb5C/71hBm/z7GHRTVfEWSYe5UkyFTGbiztjFjlPpvFz63AmTIkO0VZOiDAOQXALJKqDkZQu2th4fq8hKuGTiGAwtuPxMxnCDTe4LdnXEMYuIRDnRC9W9qPFHzyguNq34OvAboyulI4VBRqC54iey1BfUsQKqINtqR0j9uBJ+PXsQxfBToXkURYjBgYoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfbRnxc/+bailxtUee3uvo7CgTvenmuOBujQbay9uRA=;
 b=m6mXS/9dtJXP78Qn/k9ClvZVZGwMIVwUa3gOj0NXyu9XfQyZPYJkOOoCmumKIuOWFZAeWi7qY3xwosImRYhJsgflvTQMtp0xLYraWpkjFAJ+l56hfJq8xIRcRNg0vkxXaqWScACsSETtwChBTUgAYBSam7iqESxZ/hxf8jzBFu730dvQJgm9SJfTq6al2TbBsAofOPfaHAfOG3n6hiT8Ke7KqvOfBWbUiNRpe8QlrPakGlNQb/GMI+5L0RkoIgPT/e770NqrGo2vI2feQa3aRSXPtZWEh60TmWVx/7Jmg6vh1Es6jT7qvryjpGCNiJxkg8ilX2tiDTAZzikkhYjecQ==
Received: from BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::25)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 12 Apr 2024 08:03:43 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::c5) by BL1P223CA0020.outlook.office365.com
 (2603:10b6:208:2c4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Fri, 12 Apr 2024 08:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 08:03:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 01:03:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 01:03:17 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 01:03:17 -0700
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
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <fb1357e9-a585-44e5-ab7a-56eb92b53751@drhqmail201.nvidia.com>
Date: Fri, 12 Apr 2024 01:03:17 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d29dcad-5a00-41e7-5bf7-08dc5ac71262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xZ0VCT0j1I24xcOBpOIMmrhurQx9JJ8WbAT0g4um9/15pdzNxmT4NtIlZuC0Fue1/ls6H6fq6kMQcJ5ogWbLtKEH0dsxBwUieV2AA7JkMN79l2cmBpGRqy9si6Axn3p+mRYPJE/B7Thfo8aEx9OR9kOlhr7AqDMaybfe+BaVvYXT0mK3lXxFGgDnRvva/qRYvZVjo0pwSETYoTXMHXPF68i7+KMzowsbK57KerMGpqPMoSKenOYigNqVK0dLrMsjTSXUUOycoWiSFwmJLRoPHE3GljtywvWdpISjxlIL9Q8YeOEtJUmEyUdAX0nVqFHb5AOM37ICF0GzEdU9JLVEQ4q5JN3iGfkd8nSJLXqxqD4gRMaDnJACYL+ssaX25QwnvPaExj8LfVmPZs56+ZySgSxEViw5BcZ5PytsnbrE6jgIitTzpHyUwsxr+PONXLW3lkDD4N9uE2lVzACh6qWz3R2noiss2LZk7xheKzRyjyA6lJrA2p+ANiBeH9oR8LdJ7iIQ5P2xRdlKLuOllhYMGXorn4Q+mB/cP6EJsU8Kn4ZOy6vTT2/XSuXIM32Mv+UCHLHvStgLrN1JGaTSIvu7ygtVMV3fwSkXq/pUzbjcYxBCXKyabPCCR3beyaR0CUlRxP0nuinQGYS8NQ10Ie4bZMQeyvUDBiKVYAsRjTnxvEcAtW4on5DM1j+Vvy30qUWwWtG+rn6oAPkd3FxyM7ihwQYyyCbPSAZSH9CwYEyj9UXhn6NmG5GOX5Lmkl9KdJrc
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:03:43.1320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d29dcad-5a00-41e7-5bf7-08dc5ac71262
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118

On Thu, 11 Apr 2024 11:53:29 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.274 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.274-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.274-rc1-g82d3ef764065
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

