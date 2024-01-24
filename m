Return-Path: <linux-kernel+bounces-36791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A883A6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B41B2751C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BBB18E1F;
	Wed, 24 Jan 2024 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rF6usM/V"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCE18E28;
	Wed, 24 Jan 2024 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091820; cv=fail; b=cFWSNu6eOUuv0x/lZWDCzY1h9BIM1H6UrK+hCEu8yaMqi14laY0CNFbatWqYho3z2lI4lt4doS6vPDbte6DgBhXxWIhVcikYaQ6BwclCj0AG8D3+SXw9EgC7reSMPgPndbFwEF/TheuX9UtaoZJofYxH9lcgNfOc9lvpoGU1o6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091820; c=relaxed/simple;
	bh=GOY3wTA2HDnrrMHppCxXBTzn1QnUf/Hwq5kqtGp7EhM=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=sEHoZsJUMTEXXYxKbY9yZYa+J74/h/40M/Q4Fnr2+ahmdBXr9WR0O7ZVTn+igU0PL96V1NhCPvfG02DM1HaPVYQqtzAgi2gZJVlGbhyVHUyi/Rdzdf4Ud/Pek8yV2dMJ4oYvnpo9EYILz9qcKZqNJUR2IFs9TAwlggPgkq5O8b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rF6usM/V; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgDLnxchhas9FxhqVavwkTUq79wjJlzC4MSztTZx5ex7Hqbtifc9zUff8iqqiu38wlfoJcvVaS2D9jd05xvWuMlVDKD3VzWkaFxiAbrSBOOeY8CEmPoj+RktsxHCf4YWKkZhUjAJAkj1tMLeq6u+yODrSKpbdsunF5UmLPDCJ154PZeGELFHa0IoasLEdAUulNbXFNl/3xzO55o+FOrbhatv8LQDqv3tK4PgHWbSHJx7nogclANVNwY7xAJuaSd4vjAGUswgt/EeCH4YLpEw5AkZ3fjd7w6nIyAsgpyaCyePRZjdr8wrJ8rIWQcPwgts+e2vvcUDIZyioF2FkfA+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+wOooAoqjDdCw5PpK+Fjn/w8u3IP58BkYOTWhE5JdY=;
 b=De0I1LyqkHWVupZwIypE+uz/D54iDzBvEt6YGKIc+Cs5s3fO6tVNIwV2t5FyEbwfegUWJx9aV6z6XrPzd8M+RyQu82yp5GMguVbwM7hwBFhUJYbmR8BOzCY055pdnK0SEw+L0u6tYv8Fu75YKr5PdCkBQMeh7+9W4kTjvEywlQvNl1g4puMxIQOtWzJ0/XX5pimY5Yv3FPMTkTFdf2WUHI6q2lDfOY8EtfIIOdMNvGAWvH3VGUANXe/fIXAVMaPg2+dW/L6TnBzSMx2jbXS/7ertteY9/qCzr2quifWFDw5RZXwvknE1ywAicZWBmRt2uU9QboNnquSVDVBD00nomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+wOooAoqjDdCw5PpK+Fjn/w8u3IP58BkYOTWhE5JdY=;
 b=rF6usM/VRkvbXq2oJn7m+UKID1GFz7vGFVaSX8yvIFBFGfW53b3UvenhpRQG/+Bo7Sg3TvfGWQhMTPVxvzwJx1uYdFdcLbOEs4CBedZvCy0MlYku0CfP7uDOG67ZnH3jYWbaT6H8AbErpN+Bj5eigvGicHQnT6vRIUxR1vmwXBUBxEiMXYwgAZbjd85HtMBZUPz4vTY+sNCO2t/P9FV8jzARtx3MgGBCNtv/2ciRxyypAH80ipianiQzTwRha4OC871o/Us7kQmuXMVqJd2fAvTR+Pbb+GlvqLzUFJkADy8IO6uSMOdKO/VOIYRfVuDXuh7E4c12JzVC9079lhiqwQ==
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 10:23:36 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::8b) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 10:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 10:23:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 02:23:26 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 24 Jan 2024 02:23:26 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 02:23:26 -0800
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
Subject: Re: [PATCH 6.6 000/580] 6.6.14-rc2 review
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>
References: <20240123174533.427864181@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <8a728685-451d-4335-9d63-68d9813e8a31@drhqmail202.nvidia.com>
Date: Wed, 24 Jan 2024 02:23:26 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ab3dc3-48f2-4614-e2d5-08dc1cc68665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1tZ2Jp6nmA+F1nepxk5kCfSpzhn6u42OAnUavYY/EZx6SKGUWL9FdZx3b9fwcXbl8Q9zNd22pPQ+ckpirx0cSKuPfrZT5B0lgvaxFlgEfkkulMTD4vChnKhQkIXjQxxlHGWhvOrlHazaM9Gwbfc/2Aty4usWH2GVzfMCAQDdhUpVE6IkPHOwpc/6Vg5Talgu85Omkngp+ZWFR8TihWafe0vHmROxCdvgjsXU9MHsgQ6aZ7rgUA4m4+KnJMYyV8b8VvuB+3MXLudIy2z7AHMjtWYhNelHPZYY4imbzkVDa1OxxzF3PwVMh71OOYmzUiPVXV9fhUabMWvZX+IPbNl1MeWPMGLRQAc5HzQeJhlz+r/VyobXYOvIqvVG4B1/wLJ86MgxairmCzRbiXR5NFICgXzTa6o80hSnBZmVqEOBP2ND67rs9HLMMiEqL6n1bpAnJyQmi4J/X/4FLBlUvsMMhwaqllWAj6BcUGCYRDV1bGi7UN4VbOjv4VJIORXgo88z9qS7YOmOBaWZqWFuYuOC1wmlsN7aul945g/+VHXE4KIBGqxfcn9ZXEg+ADsOmne1Shj56iW5wJfm/pYtHa4iEhQQloYTLSLsOb9b1g0kY/Oi7V8KvsMnMwlTWJsMHPYZekLDFFJ0LS7A0CQzGGi6Vh4VHygMm3m1IpeiZrjRX+hvxpdyHjS7ZLoLo9AZgueeV+bjow1Ak/QjZzQ98UHeqZIB+yZ3O3OldtH+zQci3ZgQMoPItkuv3Zeuy6y3ZSe+R9krAzrlu0DL1zAZT9e5g0EQaMFTXa2qPogd5MEf2S8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(8936002)(7636003)(356005)(70206006)(316002)(6916009)(54906003)(70586007)(2906002)(31696002)(5660300002)(41300700001)(86362001)(7416002)(31686004)(40480700001)(40460700003)(47076005)(966005)(26005)(478600001)(336012)(36860700001)(426003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:23:34.3694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ab3dc3-48f2-4614-e2d5-08dc1cc68665
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212

On Tue, 23 Jan 2024 09:47:11 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.14-rc2.gz
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

Linux version:	6.6.14-rc2-g86b2b02ae53b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

