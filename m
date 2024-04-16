Return-Path: <linux-kernel+bounces-146634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DFA8A6892
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA09283862
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00D5127E32;
	Tue, 16 Apr 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/jddl5I"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D28127B70;
	Tue, 16 Apr 2024 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263845; cv=fail; b=pL/z96YImXNpb03HYAdEFY2A8H0v94lKELHL1G3IKUQqFis3lab9SiuN6osEMJEPAJt6Z8xtakvfzhpiLgBftG5NICsPaIHORfD42LCewdnlEhbZK4dDkbPH3o+hBBh8a2epKxJiVv+Zt7fLtYdclQBSBVpLu4Sr1ILHFEk47lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263845; c=relaxed/simple;
	bh=Af75r0BCQ02k5wirmQMlr4dq/lyHaiyE1xc1mBSeTQw=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=J+NJHz2STFtRV13lbG5uh6VuolDRfuJjSknqQGFekSFkZaS8J9+0trZlvsZY+gzAbGkJwtF6fDzADY7x3JFaydHgUVGx0jBThYIauJZXEnPkEasCLafjw9l7lwIZ46IJAT+p6aeByPrTaZN4vuPRTAZz7f5ji2s+OZgjTbnrKgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W/jddl5I; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9kCRbX+vuMeWM4/vncVsiYoRXQMShOoCUBrdXLuDQgein+u3gu0/tjson0wvgLqvTIu6uu43MBNbzYxbcyXUSp9h6ujpG6fhYm4m+jRy9gxqqKDaMSre+kG1bJbOaG22CasfwC5PnGHfSLxEMqKazycWlSoHnE4G8OlX4AFpWHlUQ3mLivWWDyaukzeeiwm1ErNuJGD+5jraiIi8rAO2RJFkJ3duOWw9OTdePzm60FceUCATdvIf6SIEG+kD5+vf8wiFbOip/PtUbYjJtp/xd/8rf2so51o8EPO8y3bmmztlF3h81TRGzP658/YaZNt4ju9djW7wXh+E/3gwu/ZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8sE8HP20xEQ7yjlTOK0IGPnLQKE5C9y6MnOyECmAIE=;
 b=h06Ez2HhBeyNSbXXcWEAHHw6HENO8wCa+fTISEjf302sWz8e8V/HXHaYwkZpjIglhF34UmcYkZtF/xfcw9TCAJ2Pw1+FlEhgH140X6FOHBtdNLgMQuGUcD9sJmmm1h6Pc049vtFa+dP646MXmA8SPCbWSElDHo+10by/P3Btba6yVGRt4jm3DbN5F0/C0OAT6P0qoOTvWzk2kvmRsccjQac3Mxj7eFGnf7VP65bC0vYlNnggZmctC/KYTTwmuvDLEW/KeWyA1AcHTT3ONk1vC1ARzDII/2i0JWRV4hfIEwHY42PjtB0hZvvoXPzjRxK1DSNKxqWhMTUh4F/mUMauCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8sE8HP20xEQ7yjlTOK0IGPnLQKE5C9y6MnOyECmAIE=;
 b=W/jddl5IlefzLVGowltMA/DlXceui/qlw/eJUTkNG6lf2xomyszQoTpj8Uh2mR2ybT+JGcwRLQjm3snWYpmNlh+A1qyLzFpXO+PxdvcEMWPujdkv7aKZiOa72WVSBFYL1QTqZJkInNckNusyOtco1ZFKwg6be9rUXSUdlNtDH3Qskiu532o3yHI5YSFIfAv8aQbmkhLJ8LDSZJoIGj3vhWGPzA2NuQTZPh1Crdbx9PeBkckeBQi06nCgDle04LvMXuvmmN0i0/XwrOYLXLz3SxONWaRYr+ITWo/B4ob3+pslTBhoUkiQthX3hj1KlqrvhLne2OQDMsF8NC0ewmBdrQ==
Received: from PH2PEPF00003848.namprd17.prod.outlook.com (2603:10b6:518:1::65)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:37:18 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH2PEPF00003848.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 10:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 10:37:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Apr
 2024 03:37:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 03:37:04 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 16 Apr 2024 03:37:04 -0700
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
Subject: Re: [PATCH 5.15 00/45] 5.15.156-rc1 review
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
References: <20240415141942.235939111@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5057351b-f282-4c0a-afc8-0030158c1ec2@rnnvmail205.nvidia.com>
Date: Tue, 16 Apr 2024 03:37:04 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8fc91e-1d5e-4bc3-52cd-08dc5e0130b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6HrJRGasSvCuxGQ8dZN7FmhUJ/6wE61x0rN0/cb8pZfx7SKLJKXiQwm6GXM/wmL6sG+Nn/txlSDxBmNqq/G38Lo3Of6NTnQ/KKhsTOAVmJ8Ma5dS60PEJIgdjMbEuIbFtCHwI8kaM2Z3BIRoZcxkPHFV/76dXCGgr4nTaXIBW18LadIS/jXvZpL5DhwTHvKCh1YPbrMHZ2Mijc+scHxz3D/waPeIcZ47bWuieQTqeXldEmpjJvrnx73ewWpVWRKdSjelxDVNsob4H4c+pkiZnLbwTTc9kewgUvI4EHSLCEPXH+BLSp8jA4FU1nRP1QzRvUVvQRuaYrVJNwB8rrJHVRu+rujrbs5Nw6qLdWL5UxjojcnMzIi5ROAuylIOo8cpslqVT1iyKu6YrSFgp4R3v+QLzvi8lqojkTL76e2X8wAQ3ywMSWX2V86H1yVO8hC0U6Sv62j///9nfUctLJYaNqTBAK5Ns3S87PtGRA7jGvqq62fMF+XMId7xXDs0Anygd7GsndpidjDK1c5qrnqlOGKLPWp06+NmkxgsZX3NqkIEgTbRgR1EAejn5vMaFCujphdk/O1FACkswJHKaauRnx4O2cokE1ZiBU61m6irlIVG2A4p54WSpawnkrBBJ/CSb8zPguO2ZZVQaXbWRjlnof5pWDacxCkCYxSc4ufn8aDL3ZfJ7Oln0arvOJvizfA3SxNUqvwa4uXEBJcDWb+9j5P1lvLm91TSFl0/Dx1MnlyVsZdau78AZ6FO3E5EnMyw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:37:18.3685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8fc91e-1d5e-4bc3-52cd-08dc5e0130b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844

On Mon, 15 Apr 2024 16:21:07 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.156 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.156-rc1.gz
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

Linux version:	5.15.156-rc1-g8d83652ef6bf
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

