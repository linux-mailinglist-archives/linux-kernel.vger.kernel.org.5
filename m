Return-Path: <linux-kernel+bounces-36788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF483A6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99BBB265E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBC318E2E;
	Wed, 24 Jan 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IIOfttgw"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DE18E0C;
	Wed, 24 Jan 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091785; cv=fail; b=VlYtKheLAJ98bsUsSOtgUUKo0X/pKv2XbeZykTBAIxat1UwgdLvrLQi/IT96l5OfWidNMiL4+V12kbumu9oNhMokv/5IJxjwCzwoyhRm0waBMKk8TWteWz80RhJ6AnmqUVXXWlrjGXVHrDaxlAjgjHs9ZNJoj3VVJD9rmtgjAa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091785; c=relaxed/simple;
	bh=tKYh5mzHstW4jgHGT9MSJFmwpHZh0+ZYFB6PAcd+sBs=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=oHtYfmlRcEbJP7rzhenFHH9StmUtXFt5NiOFyQQ1kgAcI3iVFMSczf/plpBtVxzIhPX8zuDFLUwQgoGoUBjEKGFMZGtW5yco0gCPEaOekNUIfepEqf8KWyboZTfHhT1L4nU2FFnmnUNnx+5eKK3L4DmPk/ljJK9gPiaPnHz89Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IIOfttgw; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuAuHISyd5oRLYJlWV697B3r1ULRXVWjoKrm7Z6SS/Gf5uF6RXtoZL+ZQZZdXLVKMp2j2xFHsA9W92y/u6C5sdNJtzsFtOhnCxGwlojLZH90CEUqpJVGDPgMElsp2vEfBNSXO0FTFVZqHU1b9f1QJYFvG6cZ/YfK/KhPyqE0C7nAC8JYDhkK3S8Dm5taGhLstwCGnphP5mpLM/5FtCToKFY3JlK99siY5cbCuPugeiaUbue1As2RohnH3FWU//ZHBnM9hzWh4mLIdcHbLGC53yPOL0EYHZ438RpisH2n37ZzU1+guNHrdK+CYGQeBYLdiDl4VClt31DlD5ugEfp8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIzA+Eq81lmyG3RnoruV1Gbw7zoA0qfFdFKHjHEvg5w=;
 b=e+332BNtR6BvxaTi+PK89yKkDr38CHIboYf5RfjzDBNvGSvjVd3G0a3UAdcHPv/5HHscyCoSNkdP2LTLJejDpxlUPM23+DhCGWJacUhbSL/o6Iv1PF6hD2xwJkAHCk86kFEwBX8iIZk28mfrXW+7ShFcqxxUKuwGIsq3NX/wQnSFX+kkWt5Z4TyoteVVQtaq3282FdXR5Tu6hmh21+zD1lX0jwkCs/BYhWAjUFy/DncqZzRzYysCvvFhL8MV2yglAnM1rAjR4uFjkYgJaYM51ajj7wpBM1Q9rVWevQvBHILEh1COOrgc461rE1hV53dQ86ye4Tomn9jolB1GcXh76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIzA+Eq81lmyG3RnoruV1Gbw7zoA0qfFdFKHjHEvg5w=;
 b=IIOfttgwQy0hgGoZr2Ukiveku1BC09hqpS0KWG+BybUn0KbMy1mL97wm7tFYLSYduDhKY5wwUJjk1O1eUVi74Bvvb7vwaU/N4GNEMEflvAcQVi1bxGC7W5KLi79OylIWqWuODJbHbM319Vxo3T7Ak/yRwoh/6ad9w3sMAugiokuxIlAS4UyIs4EuHoHcXsBsBwXrQg6bhqYSWMz6wLciit2vKDMFcBEK4mJ3A9QploAHNZiTjfUwEavElCVpWYC8iHTTJkutgArUaapmOkztHt3Xv5Pq/mTt4WBSR/OQheUZ8Vqu90XvhVDxQ9cFDRKhPUggvzU6fuGQQorKyE2Big==
Received: from SJ0PR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:332::28)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 10:23:01 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::66) by SJ0PR05CA0083.outlook.office365.com
 (2603:10b6:a03:332::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 10:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 10:23:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 02:22:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 24 Jan 2024 02:22:52 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 02:22:52 -0800
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
Subject: Re: [PATCH 6.1 000/414] 6.1.75-rc2 review
In-Reply-To: <20240123174510.372863442@linuxfoundation.org>
References: <20240123174510.372863442@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <bf49f612-f543-456b-9dbf-c510250abbb9@drhqmail201.nvidia.com>
Date: Wed, 24 Jan 2024 02:22:52 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c7bca9-85d4-46c5-09d4-08dc1cc67157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l5GQBLIVltdc34mMMni3hwlZlKKdgWyIbc2ZtbycQYEX5ptNSSeOMtTQ7XFO5FKaEeUAyrRf2YQsH6aiv2DStpUYjuFxua6Sxy2DQ8Tc9lU4jSLo3fjHkLBnHV4x4t+iVX9/nS8ZPnCXujoDkhKHvhKFL5lQ3afEKN73MfVxDUJ6HSpuQfPEv7q+n1INIZ0fGJ+kvFy3+uVrmbuFMc+2EBoJTqmoX4OmfPst7QXIdn/XrHeG56BLXDzOJGH/R1KrPEx6Abo0xf1n2HKjZmRvQfsFPDiRYQOfB1Z4HHyW/CZPOz6KdRAX+vGGXvYSnrgWvfm9EAeWY/ZNNeZ+0lo2SjFAoxlGHD57TBVSDv2/nb2xc8fQLrDrJVHftn97uMnnVxhYNZy6ogTNOrliKncJEHa3qXKW6FRjMJTAbthcBY0PhcnMO36JzG8MwN/WnaIJcTMcGmdu2SjD7sToiSdfkiblRafUiZuMOphpf5LTPXpBcxS9G5h/uNUqXA7vxheuxEYi1kmEQv43ruDDFogvhZ0jWEO5DmH/PQp7DIY5p6k1v1AJo5GSdljx/+8uhKj3WENIsLxK3yRhRquVYwWwJChgavar423GvfAr++ejkb9jl01rvdbjsYsmXN+fqPCJGwll2gPGYGwGyKi36Rbdk+345wTWopKwWJGB8kJU4aE5wp5Y7UrNnxIgvKqFX8EA+0oJfJjK2Ly5DHWhsHqO7Zpsia948n9UiIL77Pzh690VB7prSBzQG0IPJdAFBy/303Wdpir4XjqsKyLLzQKNzHVutgrQysObRazXzGHfnhM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(7416002)(2906002)(5660300002)(6916009)(86362001)(478600001)(82740400003)(31696002)(356005)(966005)(7636003)(41300700001)(336012)(26005)(316002)(47076005)(36860700001)(426003)(54906003)(4326008)(8676002)(8936002)(70586007)(70206006)(31686004)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:23:00.9930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c7bca9-85d4-46c5-09d4-08dc1cc67157
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246

On Tue, 23 Jan 2024 09:47:46 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.75 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.75-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.1.75-rc2-ga7fd791e5c51
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

