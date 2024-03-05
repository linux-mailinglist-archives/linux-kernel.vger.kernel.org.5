Return-Path: <linux-kernel+bounces-92672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF18723FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268EA28202F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC201128803;
	Tue,  5 Mar 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JtbsR1b2"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A638128382;
	Tue,  5 Mar 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655728; cv=fail; b=hKkrK7l6zNy9GtuCTRirvp9XhfCH9HT2MF01ff1ShOC3PJUidd99YJGtPhP++5B1WjdB/YkrfYjOoyAGq+pWwwD0oC3hpgFH95xSvOVClUQifibkS7ksv+G5idjV+FDA7tVrKzkSyTBMx1wBYuguO0oVwVcIRurR8zwdhI4xzAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655728; c=relaxed/simple;
	bh=/no6WNwyDYwEXi0rN0O+NSAUr/rwwjWWkBDaO6V41JY=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=PBtU57tnvED2p1z4aVslAhjb0rK7vxsxL5GBU+geuGEWgq3ryn8pQY6ylWlePY4djSf2CxJYPViO8z+miYHISADW68VcPsN+EtL0/sLocN/ozz7DIjWIGNj4P5GxW4C9keajkGqyNAWE1C+Q8rGTRganRExnNUiziNYy/qVoqqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JtbsR1b2; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aucPPA2muGHvPk5qMgRg+lQ40Erhzt3sIY73Ghk7zointR1ThUQRbtMBZlbaPX3AxeiOQtsSrUg8RjWDHnG8ZNJaRLH1/Ol6bFV4l5/j6IYmhnBGdcdqAQ8tsT0y6xJgYWx9FOGosxNIHzuXDNEnUaDSs/jxPC6q5mEV8qjTnFVQJ6wk/ANF81QDNlcIGyAKxcPx22+XQoTO08TNiF4Ze+94pya0nzQgeJ2+CMSz9oF5pdIzZwI3qspoMkqpgbcuqqpCs8jeBeXfaEfqSkswnc+nUn9wp1vyhi0rcF47A1OdVUS454oQH1tHuGzl2qf3X3y+PK/t8YFWdHr0C3BP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BolYlRzdFhq9ajziCe4mCK2CHgQkUG2OuogVkr0DvqM=;
 b=BhwEmsjUf2FqsO1DINIxF7fkMvrU4Zfj3x0knT9D1WBNsZYRRvnhqSlPuVhBN0dSZoAws7zwkpG3P/qvmYn8ofTQSGnTH+7rxf0LVbT85aqdVHHBycvtOtWaqRZuOOd5Qv8LXD437MjQ7TmAg14Ki2ej4pIlWKjdvIT9jl0Kg6GwyCYQ2IuUaEtUIzLuPbElXFQqaaxTdj7ZnuLHx0kczQnt9p3OydMZSkTbUEs2jvRzqUhh/Lw4jCIiA7AwPJRNQD7EFzsRwBf15HaO6gNdinKj7yHAvTI/e+ZXCFmyM7u714UT6PjxKUk1/XKODMaDnWwop35GAkC69hPyn4t/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BolYlRzdFhq9ajziCe4mCK2CHgQkUG2OuogVkr0DvqM=;
 b=JtbsR1b2w5ENYcV6uiMl5ITfr2UvCx6zNlB3xTk/6E3rMatMXhe4k7ilTLkPsbJa3pIDC1vdRvZLMka7dpS/VVqGKsa/n4uiKzdgZiQ4HJUM+tEbmu0vRkmnzazabPjL/K04YlS5ptrQ/K3pvenBuIhL5IUzaMiKCqdebLhzCOrJvIpfhjgFosSM0SMOohtO9rzB550CrPq6TvHcxdTnkfQdphUthp3wGfsHFbXGLiDcEGWeAFIS0TD2qNj3yv8IodRhxiK1nag64ETT65Bc7AukxiPXpP5RGsOBa1bKXXWwafAIIbOlOmeU68yxsk/dKQ11QpRRm13cPVts6zt75g==
Received: from SA1PR02CA0020.namprd02.prod.outlook.com (2603:10b6:806:2cf::27)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 16:22:00 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::f3) by SA1PR02CA0020.outlook.office365.com
 (2603:10b6:806:2cf::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 16:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 16:22:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 08:21:41 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 5 Mar
 2024 08:21:41 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 08:21:41 -0800
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
Subject: Re: [PATCH 5.15 00/83] 5.15.151-rc2 review
In-Reply-To: <20240305113135.403426564@linuxfoundation.org>
References: <20240305113135.403426564@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <15fc5469-746c-40c6-a646-4e21a871a96b@rnnvmail205.nvidia.com>
Date: Tue, 5 Mar 2024 08:21:41 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 034340b5-a0f6-42e7-9521-08dc3d3062c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZAv+HB5fapO/CfxbN5nuARhecH+/umXPs7n4ABb5WzI+5M5crIqo5kg/CNRc2H0ib7gITDXDZAwBO0iCRcPmoVsNNeaesq+8oJHQOdbL/a7EYGa+aDrSW+0vZ4KZoGsREw8JVToT5lTiCAe1jIBIH5RmJ5ylxDSfjnaFjttjaXr8P9cq8Mp1xLaty0rPQ+pgxLK8wmNVlWzFs93qz9kYweBRAKgB+pe52xXpkg5flZhvOEVxscVBGTGfOUit2bkLCTJtkvvBU4Qpe5mb2alXaGBgI2WcWnEv1gdZHRBP5UZfbhR6BUfjfMN2wCDjjLUdgDH87EVXV0YsfV1Dc3OCfkPF7rIrtgtqsogC5uVpVsKrvMBiBfMcqLXPtatKJvoCEOB71Nm86eJGu6HMARBlTtsVJXDffS3U3WqVx4ozzK9KRwiX1WWjNvxhjwjve4H5ihv/w6IuavIUoTMdAs2jcRCQ2IlKcs031SI2UQq/Cd3MNTcSpulzeGb9bH2CC2PNcdNa+yOZUqzABbijVuTCmAzlXdNma9zuYMLc24XVgJz8s0YkKZhfQ/6V7vjAOvw+bPjsoe6gjkOT0WecJboJAni/KwuHDCphAuWY0CwYqGWS6jlisJaOLZMdIVe8DLgdb2djjRV3EWVvxVLedEd5F6g1mlxByJ00um3ghIGvs4JLVKigGAM2ycRiPhYf1SMmTGcOxrnGAUxGxFj57i84U+mTVn8BlgOZHL7QWAuXz2P2ZGwZo01TVjR357Fp1TcP
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:22:00.2939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034340b5-a0f6-42e7-9521-08dc3d3062c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

On Tue, 05 Mar 2024 11:31:56 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.151 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Mar 2024 11:31:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc2.gz
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

Linux version:	5.15.151-rc2-g7466986e020d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

