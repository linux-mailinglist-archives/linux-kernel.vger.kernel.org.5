Return-Path: <linux-kernel+bounces-36960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67DD83A988
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F20281865
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D896310E;
	Wed, 24 Jan 2024 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CgWvxt/m"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF691A726;
	Wed, 24 Jan 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098870; cv=fail; b=LDhdgy0XOGdSkM990DrBOJ+z/Qw9zGKCHc+n49X5GNe0lBOHBKlOX/siqLEAPtt9HSQVB8O7ST2BWBsWiYT9shLbIYstRNDJy9AgZdMPPJcN5H4iRcr92X3SHBlUCyqy1WqJZqL4NJTpc6mlxP7VNMWs6BDhdmB8LHcFiqvcT2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098870; c=relaxed/simple;
	bh=OOz9tYhb7bRZAp/1Hm+e/oECh4ZK5MZ17QA9cP9e7wQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=DFO76vyREzTvY386mxARfwAI82spO7k2cxabvhogFBcVCRjAweUUf1Sy0ho0M07v9pEoI2WgLGdpDl/X0KMTA6w+H1dRbkI/ezuP5Rk+6AM1PQSjj7U+pRMXZBzFX9/1vFl1AkjnRWA/hOWf4rPcbB2NlkZVliWBBhwIF9gUCVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CgWvxt/m; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asOrOIItKSfPWFqyeEKiN+Jh9ktR4m0Ju7GrBV9XT0ep1lv+ws6PfH4LV/YcCXiAhmP0Ls35UkFigMoXM1ElLGTai8ylGbCbXh9OLrQCFqOMKLbB4/4XHTGXUCvAKKXa4nXz7HS6ljP/MpujTf1GSnkH4yn12qlO+/ttjkC+dHUHu9cZj8tIhbjk26LVAoPm8p7LgB45uTnrBEKWQQuv45Xv4TeWYr+MGLxkn3+9luktdkApFaoRFYRSGpGmiR0KJmM2o9ybSIV8dKj5DVEHlQ1L8i74dfOU4lhF5YcWCRqxMB22orfWtbjY8glHAkoLuqDZZlvZ0rUcPY24Dp95oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPYxk2MMuqkyVwO7D92XgM1xY+LS4F+S2503ougdZgA=;
 b=ZD+RI/Rdq2V7WODMZOd9Ckq31/JXKWM5EOUdjJmaj+T1WqCWunU5S9R+6IJTaKfs3Q000PDpv5gYY6qd/ygrPm4vlaX3piZ7Yn73tVJXEsFAfTHSRESLIgpFea7CEGOAJ3QRQEaCW10lPM9z5XFHum+vedyVGuRjBOZ1mdIGcWgNPEa9FbsO13zxPR7tt/6fRyw3DtZxbddcQsAkTYnHoQSE/Y32PZl91BNw5DWh8r1E16rGV+RePBreBZJQta7+gXm/38wjZWMaR7VbNKLTm9wBzVHMwpEW3SEyGiuBuKE0JTxI3wSHYnh8IFaKeBHgpuA/aZg9iLpEojMsw9kq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPYxk2MMuqkyVwO7D92XgM1xY+LS4F+S2503ougdZgA=;
 b=CgWvxt/mekrHCgwpGbChRKDfjjm9hLfIIEQnTwGiK+mJJz0g+ktzeT5ttYUssHNdMYHOsLFSjgwnR+T6Am5/xdvOIzifNfs5TOv8LWdRfQLM1+TnnWD9Rb1gby2IAy53c8n5/gmvgSIJB6hw24gU1aQj2R2urgDyktBhWmazKYhbs/zYb2J98CJLMfGSx1H+0yccxcj1RGPo9nfCbCr+oByLw5D9yFziQGXdqoRRrtPpIbjN4epo0xVYXOUoengfs6BntMgvqVJr4idvLaNANzAZdJRmnGYwqGQmhDnb/gnyXA/0sk0obw+y0FyDL7p7hd6ZfWl0ZSbnc3JTXAu2+Q==
Received: from MN2PR15CA0003.namprd15.prod.outlook.com (2603:10b6:208:1b4::16)
 by BY5PR12MB4949.namprd12.prod.outlook.com (2603:10b6:a03:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 12:21:05 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::fe) by MN2PR15CA0003.outlook.office365.com
 (2603:10b6:208:1b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 12:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 12:21:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 04:20:48 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 04:20:48 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 04:20:48 -0800
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
Subject: Re: [PATCH 5.4 000/193] 5.4.268-rc2 review
In-Reply-To: <20240123174434.819712739@linuxfoundation.org>
References: <20240123174434.819712739@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <802878ca-cc70-440c-b0e8-b28beb8b60c5@rnnvmail205.nvidia.com>
Date: Wed, 24 Jan 2024 04:20:48 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|BY5PR12MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9b3a9e-2b7d-42a7-64be-08dc1cd6efaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YS2475cCgoQUtog9L3kxcvgebPyRAC+ajcP5yJ4RUZVhg7rwHKTTFO5vNVt5glqfg90bwhmc2zTvaj4N1jo/EGgfMgXPQbIWqw5716YXHMAL1wKTbOmaXHoizAmI9stdelUhfB0NT0im6YFOdYyJKdMcsC0C4+xbG5c0RszQq3MyV2SAAcSJKDPviSYQuUyt56OlcDNCk0uDMqtKOxuXft/Gm5GMt0QiJCYxJ+OfJljJAHp8HvbawuCpH/MXO20GcWPH6ID+iytMsqk3T0M8fNwLXTHUq5CxBIrwipQmfEezRB5rrAMs9NUHMDGVIDL+tZy9fUFv3U/9ggFWkI6D+NpCOPU0c1nuhkSHoXCwEA8ZuvOn9JsKaxUK6Ccc6VHa2I5t2ylHn407B8NqMV283Md2/FJX4uZjPDR4Z6N3+CPb5xq3FB6UzWgO3nRmkN7Cral/SNnJolW0P7bkpm13wf7DS746ZEpNZumDhxz8icvVOpA92huzMDfYyUj57IGkAKoyPYIpr8/ptZGb+kT3wiLF5j83iAr0r87lugYp8QxjcOnCX05LwBRMQEiYIAbF2VVkXnX/g8IbjTcJmGbJ8EVXqLOMw4UQx3zKH5YVtJ5KtQm6ZIF23PtrXyfWnxV9GJnKOWbZtz5hrwN5sdm/PikmyyBBLZ2h7+Asdh9oqUtMa6XBY63tSuHYgtpODzvENNfBoG7ZtfXfhpCm8Jj8pUY7SnXiKHfdI/01I+/MRAnVEQDkL+cCOFYHChKqAB7agdeBIzfvOolCokghZrFb6nVIHWos8LZ5ziEHidXYlgE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(47076005)(82740400003)(31686004)(41300700001)(6916009)(316002)(70586007)(70206006)(40480700001)(40460700003)(966005)(5660300002)(356005)(7416002)(54906003)(2906002)(336012)(426003)(7636003)(8936002)(8676002)(478600001)(4326008)(36860700001)(31696002)(26005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 12:21:04.7393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9b3a9e-2b7d-42a7-64be-08dc1cd6efaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4949

On Tue, 23 Jan 2024 09:46:22 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.268 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.268-rc2.gz
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

Linux version:	5.4.268-rc2-g6207e0931754
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

