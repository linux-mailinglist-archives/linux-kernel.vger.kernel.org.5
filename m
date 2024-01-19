Return-Path: <linux-kernel+bounces-31242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48F832B03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB7C2871D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9053153818;
	Fri, 19 Jan 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MiPmHmXE"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146053802;
	Fri, 19 Jan 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673483; cv=fail; b=OvKTCA3ozrOS+EuBOrqMt58xPQT4shOVFy3d7RE/FyBzcIcsovWKs9o6pvB21p0x3qWeQJMwGp60JttiEnp1940lyFRumRTIX1U+DoqztubgzxbdAmLn/UtRUDfl8m+351N6Xq1hirpi4TYGPehdNkGdVscGWZ1DQFBlHRyQAMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673483; c=relaxed/simple;
	bh=9D3mRXtISyb6wvtty9jPOSTw1CfbgcbLZupUgq0TKGc=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=WyYcb21Ik00LwBp3036C0VSDiJDWq1eTSgtMVOsvv+iIh8MRsitvRmFPMxkWkSRXNIUeIDq4zFXtPEyMD0yFCSUJJ0yeBJafOWb+SkwSCnVn1ORgoPpNMomFyngnc+MQclatMoKzWQ8tNnXSG0Ov9ehcVUqcE3vbIhvt/YQ6B+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MiPmHmXE; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdod+vxajNgWVagu4iPh3fd8Irwslu7W70Rd7H5ana2nKcGSsBE+2vBtazkJCze55bApBg5o9v5GpVyYAL+HJ5NYFRUDlf+493MHCGFXkcXWNcutK7GTBlBT27sFBsjAhOBPaZ/QnaVAa2YH0T6tr99YqNRTEpcbr8yHxHdEdbvC1ubd1eOLaDBsNtLYDAhIdGUI1yisdzfFZ5KKyEb8XcGrCV/AA/IfBDORnqrTsWFLy0NYUgBc8vvxkADir2Rp7BXnGE8fpD2YDrczVHo1colhvRIPPYYxgkg4CsjrH00oMpY/dcYym+RJm54kKkJ4xJ2QMcJPKtxGyNT9WbISTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN5O/hu2SL2EhJxW0+xlRZtj3WWsU6ikfnXlvVnzHdg=;
 b=V1n1YM4S6ymtJwhmZ5utCRx0wGQEb7oq7cI4RzRC9YQwB4ZGsv0HXi1L/4S4nTT2+sq9Zh7S2aGpL1Ih9k3rptrkgRpQrvr1aDlv0ytjJMdl7kuWp2i6SWM8Dwivd9rZD39AEgbiKPLdg9uyxMHEwL2ZoFXjsgQohmaosUxNEewkZJKwOEsLBY1qxgcQ1SJxb9ZPvqgwGFXmrX1nH0u08RDP8wzuU7QO35wEha94rcByZgwjkLpRk0LB9MQrKXe51f3A3o6MpCrH1MYLr0rZN2f4VEnhkFthKErmQBF1e+oNYH46iHiC+4bwhfgSxQ9OGHsLyJR02yFexC7VhAzrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN5O/hu2SL2EhJxW0+xlRZtj3WWsU6ikfnXlvVnzHdg=;
 b=MiPmHmXElq61AZfHQCLYu1cGKVYlBxH8aYJf85bibLpbprzrb675xnF7qutOKMWFMncY01CgVTTU5yOt8RxfkoPjCqZz976XHleuWa0oK2hSHfUt67FO/svtvRcn3/0Z19iJHIWTfYP9h1rKoN+A0YPYaTUZIGmH+2iO+yJwCGyZ5mB1JhvWYgV48m/0MvRdRmHiSmSpS+yGHuMMwCWp/02lsXDZ6Vme2jYJhNgl6icKIhEpGhBycqkuJcUvKPL1Yeqw1DBxXElQ6JU6Dc1+e6LjHsepziqTAtN5X7+aobXBqIdri70N+bHHZ/1bmu6Aq4u4OjdMlwlaJ1jXx5g8gg==
Received: from SJ0PR05CA0149.namprd05.prod.outlook.com (2603:10b6:a03:33d::34)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 14:11:18 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::3a) by SJ0PR05CA0149.outlook.office365.com
 (2603:10b6:a03:33d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Fri, 19 Jan 2024 14:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 14:11:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 19 Jan
 2024 06:11:07 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 19 Jan 2024 06:11:07 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 19 Jan 2024 06:11:07 -0800
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
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
References: <20240118104320.029537060@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <79f6a662-1b96-4c19-a22b-9744b7c638f1@drhqmail203.nvidia.com>
Date: Fri, 19 Jan 2024 06:11:07 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: a4546445-928d-4759-92be-08dc18f88127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C2Lk9SLO2OEyBhYPq/kD0T4iTIHiFrsc32FnU1YjwENWwDnJb5FiwYJyVNJjO1/o0G49hg6RnblMcG+v4YnAnkn80R2lKmZBEyQzS4Ge6he+cvG6lGzfzCqYyqbNrDEIw4mcWveIMxrYTAvy00ON89hWgQcANb/mKl+Cg8/akWKmYZSwaLOq/BRHDAGxx2GIpMz4gx5L9VsAb6ZxSNY0a15gyQoJXHIYsDxDrwg7B5c0Gep2RxTLUamWy+LPH+QJVBSWCfOSF4La0WyrZDcQ1J79KxYWXWOrWXaaNRF+PIYZB7ZmfFSd5LKfgubNNkPBE6dfQ7aCP0CNxCpinLkehRJe0F18vqAcG+4DWX1wfQ3kePyxRVgKVV509NmTxrNYmCUm2KIXl0FQwlc6f8rx7KaqvCpm5jVGeDhu0VkapBxHHbZe98W9lLFjHksO36GUXu8xvfiSq/7QDssIZ+JJIokrP64hxw7andMAITiMaIgimoTg9VLo+FYieMdAApO+lNFVRtSq75KKK37GSjt+ZxNd55Grt2PDHySrSZbl37OtBz8F4y0O0zYyZ8OaccNXgn5QYo4XeCykcZ7yk3KLpcLa63r81hJQvrvdvuoVdC3kyXWpWZeg3IWclbMTryxbiPP4qRtNxBsXmThHcFkbmqZqnjowor38fmxaS8/d/M+dNAvIILkpRcCX+ZoteCgGHksotGw0UKP8G6tS1hOxGyKQIT4Ah7XOmhVJpCz6FjrXOsRNjUNfbCIExTA9NamnKcEE8i2hXoK9HSU4GRbKmbPKCkPJgINitD/fwC/xntk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(31696002)(36860700001)(82740400003)(426003)(47076005)(356005)(7636003)(336012)(70586007)(6916009)(54906003)(70206006)(2906002)(8936002)(5660300002)(7416002)(4326008)(41300700001)(316002)(8676002)(966005)(478600001)(26005)(40460700003)(40480700001)(86362001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 14:11:17.7265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4546445-928d-4759-92be-08dc18f88127
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019

On Thu, 18 Jan 2024 11:47:02 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.13 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
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

Linux version:	6.6.13-rc1-g61450019c62b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

