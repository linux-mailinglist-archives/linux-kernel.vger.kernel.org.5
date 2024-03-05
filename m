Return-Path: <linux-kernel+bounces-92204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34449871CB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CDC1C22B80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EFD5CDC4;
	Tue,  5 Mar 2024 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jk4Nkukc"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415F5D8F3;
	Tue,  5 Mar 2024 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636333; cv=fail; b=d+vFdfRd6og2rFVFrpTerunLu8P+OLUtHKumGVqY6kV0hLTHe0GjZWeoFnOTzGsKU7icY7uqIZGTQ7ORY2pS1rY3hgjgTkQb8MNp+lE7nu08yAjrVzblVo0ITrTcg9GtmAv5DKzTnlsk16J+5QQfudWKcl8bUHT8yAxtL7KNNng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636333; c=relaxed/simple;
	bh=oL76asufc8rZ53QOPuvO/pTTdnR5zGrl9LWWsf4QOHE=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=aituN9csYqO0CcxEY1CPw+NdPNbpeB5/1AQ6Y4f2NhNtDmmnQ7csaDwGkKhjBMuz525Y1Ir+42UgkTa2w4hq2RsdBmuu7MG2yVumB49fxn/cPx7e/+VaRFwHYchcQj5/momYgjcFnRUgh8OC66M/VdrTYkBQpWFXRZJKTDEzjMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jk4Nkukc; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnyPe0/VVY8VK/Gry/R9N+8VDvKJOKs3xpI5oLGBjb8bmV5bmwHoSH/MP/KRjNhJMwKpOXkAw3zetiv/8HFEBYffhrr5KhezNA1UbfjuEW+EAgctFBqhibr27UreCmFBb0gm+gNubY/M/AavTdzP3wPMzfMbZWwj8K73uCkCJBUviJv3ziPAffDRUxLVBd4FTDwCEwWl4tIj+WAAPm0ShgaJLni+ja1vdttuoDsMLakKnZgpD9MRDlh1JyhK7k3t2bobZS3e+Dbzo4zzE/4dQVt7z4E6T7HKBz+YFA7++T/iswBSh9/RIplPkqoYyddGf+hLNUj640lObZ9TlouPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3joYr/sPqNmtUXtKpGHJqKDIw7ozyQs0cE49QtkmNQk=;
 b=KcJG4e/SCmb/Y0TSQg9wPqMfUQVCNlpUweVgUHIB9/6YM68d4CNF0FeSuxhI76oqqZVrwghEBXqQ7Bcv6PfbgAlll3cVB7gMLjT2gdQBhgy/kRUk9nqluMCPK3SXeB2xLP0H2ZAZrMUZROSATU9q8rZZGqhggV9P1bEQl0f9yOlqQig7nDdVtEfE91456PXfWmAd5i+cfcWmTSy6TTgbQiEjYJSKktPJLJibSfkxw/svAOXB1k3yTTFIFfU0uCAJRlNzYLnvW3FOIpJYOOc+XCPoHz3yLAlKhbeRn9KPB6y2qoBXcDXwsA4bJkqBtoHj7mbdymIts1O+4MattlwBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3joYr/sPqNmtUXtKpGHJqKDIw7ozyQs0cE49QtkmNQk=;
 b=jk4NkukcSBlUR0WLhiJzrZVb/05D5Fu9zcQKLFI1Tf9CCUAQq85zRq+XaVRyBA2+RMNR4sHBP3EqSWQSAwsbuYGDrkU9fnPvX3HjFutA1NoTYR1voFEcvDh8vVfNVBMIkAAwe2bUANw4Ll4M4wHwrXI+0EL9f39OUVgBeM3SK006qjW25jUoz2vni5ot4ZR1UETStu1fIXO+5egSgbA/yHnuoI1htTpayUSlCZe2jQRLHIO+BwfazOCZ5gdaF7Eui0B/X5r6Cgq9j3q1ZEjGLXZwdt5tjKZCco2W6qADb8WSebxTBMEySazS5bCeflU7pYuu5nuPsxALCgavLYoK4w==
Received: from MN2PR08CA0018.namprd08.prod.outlook.com (2603:10b6:208:239::23)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 10:58:47 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::40) by MN2PR08CA0018.outlook.office365.com
 (2603:10b6:208:239::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 10:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 10:58:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 02:58:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 5 Mar
 2024 02:58:29 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 02:58:29 -0800
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
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <faea3863-e610-45ef-a2c7-9585574c205e@rnnvmail203.nvidia.com>
Date: Tue, 5 Mar 2024 02:58:29 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0e2920-6079-400d-e98a-08dc3d033b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ElqWCxW271S3+U5zAmBnWWq6t4PdunkV6OAPhJsJBG7JfO2kQbEJZhnDdrugbUiq9Gr3GIu3o6Xo6QWWOAoLk+qb3xbe+MzYkb+0d5voUI9FEVwHS59hcX63UebYh089XiKt0HIwZ0LUIIgNUEK0JNPhkgTWkPRlUbKOhodGVmUnViQu9bd43Ggj9s0vZ5sKzln4QZdA+BBP3cdWCLSDGk3nMSrMU2s1GqP5/NrIfBQPWTjRNO2YFHaBbWnWjY+6A9BwFCW1r3jU0OsQFsOOuw7wVEQ8p0oolGs8N1J1TjVz8iehjhsNH/vwbIaCGS1mlYUPzojoUR5rnpNXsmuXjzgtR+NVSiRS3NeGPHY/ue0ukOIMi0dA/uSJUf6wewjBkzOOUTpdl8KzfqbD4EylrGf7BlzpYl3IbR3v/DoqdW2IoDd7cVeDqeTVCvC11jb4nqR6qCntoFuzoUNtNzpBjhY4Ulb8hMM8zN67bhqHJHUAu6oxO+f1v4SRtqb5mjGlnISWU0PbsYXAbLhoGwDlG6BontNwrGwXEEFkU7dl0PTMmj6o+g6WiueOnyUgu2bB5AJMO9pIhE3CNlPoH4/qn8TLbBzlSN+NjHGWvF3eetA3Al8mp+z/L7IG9ThbmC3Ba5PS9RK2B4mqliUC7OSCX6sahjsUzxSlnKKywlrRSbLy9nbAGrzWN7OrTjSTphUouFxjJzP99TvWXvfYFkDoKXcR1WsF5yRGQCL7hBKsJEeqI0jZJA8QfQJeT8Eq89lU
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:58:46.2175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0e2920-6079-400d-e98a-08dc3d033b05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851

On Mon, 04 Mar 2024 21:22:00 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.21 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.21-rc1.gz
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

Linux version:	6.6.21-rc1-g5f9255b6ac45
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

