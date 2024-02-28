Return-Path: <linux-kernel+bounces-85106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B28786B085
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0761C245BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AFD14DFC4;
	Wed, 28 Feb 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NQYnhJXZ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4B14D452;
	Wed, 28 Feb 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127535; cv=fail; b=aLl+t8QAu/Ma6yCm0dQjSy7XHi7fIjGZ4Pm89r3PEiWAaqQKicszAyIBr5GDkyF85sQDUFYevyXSVj4Mnn8X26A/dwnJfvczqODUDO/bs0ynp3XF+WbaPfSHc/A8creaB6WbfmeZBmKMU4cQhtZ7mFq4/J0TCxDIPdyH5zHAeIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127535; c=relaxed/simple;
	bh=KvTFSRC+DIXmWo/EzHFEe4f1FYqQrFqAPtA86BYIOWI=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=VJNOLbTcx78aWf4vtJNr9/iJdou7NiOr73/Zsuk6KVdQ3I8rwBOVIHbKY+1ZPW5EXm46iUpxD+gfkeyEmnPipvz5lo0UviyJGchWU69LQczVjiDgqBFbPMjejrlFSahLj6s2/9GW+R6/VUFW9Hr00wKnQN5Ay5yGNZylXLqnGRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NQYnhJXZ; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ1LvsZC+3eWMwNJ5++TYtES2d1U6tISkPgYpY7nuSXay+Nmnn8NOcHqrQT54TvLLWkK3X6eS3M7ECdOU8M1kQdZc3utQRD0XPPvJ5xo2Dmn8ieeymRseEugB9Z+SY7AAhoWaEVrGiEt+odWbECwJmhqQ7ijXNKzm7Do/8J6SYXPzpGVC8ULad2dmARLWFAJCodv4s3wXfEpDSu9PXBAp1rlNdEKaw7P0mmfdnbQN6uJN7Mr1bKJH/fdxVJPAivZV2/x3iItZHane0AT3OFvDfaO9kw2cZJxJA8wqAn0W5FM6OUffN2oWoFeYWNsHzNJVsXuOjo+gGHg4prso48Lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS/nCNaa/+cslLswHT0ya19BZF8M6qIAJRKr4FLdidE=;
 b=ob5yYbR0OaMpAJadraZVfiaPjUyqb35GauduOFkJN6hQiaRUXka6f3jRF6ScwR4U/NzvveYb0gfQntIdHQRyTMR/UTUvlJBmJzpTJncFiTCTnjc4mrTcuTuz9Fq8/7I5GEqDS30DcC+VNZNbIvJaHCl4Z1exfZ5gxiIuwYmshwS6aFxp0NKuqgpWp/7lBTUeb2YG/G3CZ+AGhCTPmEeAL7VjaFk+Z6gqH1LRfoAY0HH14UQPywdynS0NJ9ER5hf9mxHlvTN3KUdiB2IIndn0V/L2b+4P1CFhBA/Wny9oDNQRfV1OiVfLXK2aAAU4+XLQgEPQo8DcCTxUoRqhqW7trQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS/nCNaa/+cslLswHT0ya19BZF8M6qIAJRKr4FLdidE=;
 b=NQYnhJXZeQ7dVk3rFNSAfuFLGIpSQQa0cUGxZIgUwWmSnDDir9F4O1NGvspLG1fUbtnbIctwNifPDlVwgqCvgwgY0ssVVV09dgHGyWvhXynsVM3H2Fr1MspHPCYeXRz/hJheRO5uS7imxZsuvECkD9s2uE+KdEdzd++XGLyz/0zWdxEGi8e+dR4BdDwlogGolfYQHomLAGOT310xMYhsoq+5BgYPfPjh3Wm9R/8xp3tdNkDGBik2H4WDuBDbjg6MDmCTDDtoqMoaQ1dzjqSGAsB76B5mxswF/aDmOAfKOggcRBtfKNk3xHAFq14KzA+eQ+2iskLvSjGc7qiwsNEtHQ==
Received: from DM6PR02CA0078.namprd02.prod.outlook.com (2603:10b6:5:1f4::19)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 13:38:51 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::b2) by DM6PR02CA0078.outlook.office365.com
 (2603:10b6:5:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 13:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 13:38:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 05:38:37 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 05:38:37 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 28 Feb 2024 05:38:37 -0800
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
Subject: Re: [PATCH 5.4 00/84] 5.4.270-rc1 review
In-Reply-To: <20240227131552.864701583@linuxfoundation.org>
References: <20240227131552.864701583@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <f4a5fe3d-1f17-43f5-887a-f76a3909ad81@rnnvmail204.nvidia.com>
Date: Wed, 28 Feb 2024 05:38:37 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd6e43e-5cd5-43be-71c5-08dc38629982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4xc7s99RO5ViFfshQYuWp86Ao0rzYPlhEZnGaf8Ug7lmY1AkCDpj6364nQmPbztAGAkbSCT+FKB0Ns0Lk19F8vuJzEhWg3fIKpKYINemW3s4kpVegPIGWaeaUcxCpT8N+QO+QIIyRQTMdlTDsKHkKQVxYzt1VIDFBPU7UIeAEk34ZR0adK23p3/EeZkgPzap1Fp9FEXQpyCQJ82Tn6zXkFXC50UNpQb6rrbNnHF54NezPK7GWoHFKjQGUMY1CrXZhJgcE/6+2SyBq3CwyFCN/XAnkjzUwlIovE3HQynFa6NxcnNzrpLNKGC2YxN4782R0KtM7HRZSaIF3kPqNJhy/PTI30M+NQ8piq2ljYfJ2wS3gQDbwAaZW5wuquSRlk+6vLgJ9iEEuSmCTUh8rJ1yFfluX/uhPL3Bx3GwzyBqa7o0lxHXZLWBJG8MAiV+yVsOBYz9406s3xjd0YlxCpHsPWhRzvZf8zw7Nng1pkULbKBlF3Z61s231Zkn2Am8wjdSb5SqfhuluJWF4Oz163gXDTZG0jRMfWecIy25lPz6g0UuH1E1DcdHnybAjOoDynf2eKSYUPd+RCKBkJl7mA0pmqW/JG+6QzQQazGpZ82LAxMKHQLR70fWfJhBMbefxgdP+5x6em3Wc2db2y1RHiNqIcwwAzQ45phchtnYc/Fodxb/9LpoMuPN1IM8RVWG7JAC7ZDzq1ik+w/3TfKpKYX8sTdvxVtf71Mk+mm2WVjtESc/D9mhDIF9UoKMbpwfhX01AOGqCg/zAQPif2G0MsBd3O+ZsKPAw7d8JMHcEMOH7V8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 13:38:51.1618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd6e43e-5cd5-43be-71c5-08dc38629982
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070

On Tue, 27 Feb 2024 14:26:27 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.270 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.270-rc1.gz
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

Linux version:	5.4.270-rc1-g331c26fedbd3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

