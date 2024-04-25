Return-Path: <linux-kernel+bounces-158228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632478B1D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86ECA1C210CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560684D0D;
	Thu, 25 Apr 2024 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oqNUMA85"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CAB7F486;
	Thu, 25 Apr 2024 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035602; cv=fail; b=k9QvpYuw0rGkyS+9S5y/pvLMj4+eQoN13bhkPPnitMMDjiTFyJJiiMOWFn/CQ2/eLaVfGveSWzRhUk+4ABnncXqpBW1DMBDWJlCnCdd3/qRRDyQytvLOxQIWpG1S27xd2CyL+8Vx04M2MDCsdPe7yGYoV3bo6PGE3hXWNVsXy48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035602; c=relaxed/simple;
	bh=L3VstbW5ISF1YmbCUPBqvsPz9rzyNZItzLv/X195XFw=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=KNKMhfLb5V1+1rGKAfMVojFvRRE5k6HRHp7phoKLnggLEUziV2Y5PT0Id8DXEroC5zoEKaGElc3cCZVFi1GylMyeznUjckqiJpOOZqLxRzxelmo65t5bEHQNwLNPpkCBLt/rsbMlWb8A/9gYX1o4uJuM7jgR4Ow3XK/9qp9zxAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oqNUMA85; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZEdF25HOckafGBJV4Ilr9BXZvwNxC0eOXUVbgI0vUI1F5H52UrAHVRbxMzUvA/Jpzn14UKntAW0NJ4t1X5uNo5L4g7T+BLdtn2vAmYshDBZtTA5h4wAsibXRYbEKi/GeVMJnv6y066ENjp+bd8SO0sTIYPi4oMX5PyrNt0apkldhhc5o30Fh+1yq9BoeMWr8c+6gfRdyvfnl94RO3sCDXTRW6BafTquwbOWkc5QGN2Z4ZuLvuaKOBWLbMaVwdHc6WqCMKnzWHwd3zLfibjUUhJuKGK++h6tIZn7sLSSj+nTKPvoBe/aAPmpUARDTyo+B1Glw1UTOp+xWVxj5+ERlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpHSxF9JAzTW+PapEARsPv0RC26WyGRpoYoLirnFyAE=;
 b=IsPB11GVUUz1d1dGBwoPlI+VankyAcHT3D+cMEmqBtNAvkMYOSMMl+TyF0Xq55a5ne6dacW/Srv7e/DsDNHd64kYMNCVTz11t3yNUsDpLqr1pnsllopBQ11IsqCghKT//1lw3oYpKGuGfnCo34a9lDX7k9C3uGSJzgAPk7MkxTds3DIKsFrVskD38OoZfXXBKhgtyzDBlUBVfgVdd9Vp7hO5kSHuZJssJ/q2jhzwOLmOfE4LFuqoUo9LekTKhONV5BpCsDLI5YWLNEzvp9KbJ+zQA9rz3IZhmubKBXEWNfnXYv2+xE427hm+g3yt3d7xhekvDR/CmjpZ+aAfEfS/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpHSxF9JAzTW+PapEARsPv0RC26WyGRpoYoLirnFyAE=;
 b=oqNUMA85J4IIfxWwGOZX9V0FJRZTeDhbtTmqRICEaTfCwmjICZEiFJgwD8FN+vVtmUv8mix0Tn8WmBAJ5VpN4mfHAwWDclCEaw1lmoiCg9FEsW7nLX/aThpQoCnf05DmRFomInU/HZ0fUWb0Tf6+/iauMbc9qdTiGdRt+gp7drbcKRzgUR5YB4xYyzxUoeCPPtMed6F2rA865Waqrp3CxNenDsevUX6AvXYso//gArJBvnReUL8lm0bdi+BvEAjsU2msdp2wOuSShznx1hVb46F61ZUKVQqDdmEY/TzwTyscYA2mosZG02Q8wSUbb13qWLqBYr5G/skVvDsXin7qeA==
Received: from CH0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:610:b1::32)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 08:59:56 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::90) by CH0PR13CA0027.outlook.office365.com
 (2603:10b6:610:b1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.13 via Frontend
 Transport; Thu, 25 Apr 2024 08:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 08:59:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 25 Apr
 2024 01:59:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 25 Apr
 2024 01:59:44 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 25 Apr 2024 01:59:44 -0700
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
Subject: Re: [PATCH 6.6 000/158] 6.6.29-rc1 review
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
References: <20240423213855.696477232@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b1a7f38a-c16c-46b5-8ef4-0b47de99a26d@rnnvmail201.nvidia.com>
Date: Thu, 25 Apr 2024 01:59:44 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 489ce819-9a3f-4d08-eca8-08dc6506144c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|82310400014|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUdxQTJCRDgwNlR2N1BsZVpKbjFxcXFRYy9pZUdqWnNobFdBVXdGSVArYlA2?=
 =?utf-8?B?T2JHY2RoUkVDVlZKWThmakZZMlc5d0swemZMR0NEeDlpeDh1Q3kzSEVWdld2?=
 =?utf-8?B?bUtOdkF2NXltbFo4ZGtKV01iNG5ubmpyYnFVYWRBOWVMYUJFSU1PcGlmbDAz?=
 =?utf-8?B?TzFtbVhqYllGdzRsQkU2c1lycmcvcjdERGRkT0pmZFZRd3c0b0hmN0V6TXYy?=
 =?utf-8?B?TFV0VHlGRkNKTmpDWWRKVEFLRGRtNkJpdERydFdDSksvZ0piNVY2bmtiMG80?=
 =?utf-8?B?dHNEM3JNUVdTQ1cyeWVnL0VaV2FLK1UzM255YXJQbnlnVEFEemdjYWthR05M?=
 =?utf-8?B?cGN3OWlCUWkxcVNyR3dEc1REWkJYdm9lMWhXR0VIU2RlTVR5UU1YdGVEZWZS?=
 =?utf-8?B?Qi81T1YyRUxWbUZ3TEZKV09mQ2tQd0M5UjhaZDR4WEhhRGZSZGUyL3VOVWw2?=
 =?utf-8?B?Nys4K0xic3UzN3BCb0lwS1RtT1FBWm9sejJPcVY2UnVHVVBLeFNVaTdUZ0F0?=
 =?utf-8?B?UGQwWDdKRTBrdkU4UmJzc2hKKysybHp2QjhvaEs1RGRMV2NibTNwaENxc3dz?=
 =?utf-8?B?L3hqc1FZbDJ6S1VwS0tCaWFhK0RQZ2R0c3RqT291aThkRFluY2I2bnBZNXRh?=
 =?utf-8?B?M3AwZWRNd0I5OGhrckhpbDNBUGVveGtZOVVWL3c3d2VyUnBLY3h3NnNvaVEz?=
 =?utf-8?B?ZTN0aG5lOVYxNVRGYWJlS2Fhd203cTlmMU5LQVREYlJlcitLVlQySXVTL1lG?=
 =?utf-8?B?ZThJWWFob2FodHN4UDAxNEExQVFxVjBVb2dBVFlhTWpSd3d2NG9uSm9lNXYv?=
 =?utf-8?B?Sy9ZZG9TQ1J3dEhxMVJ2S2RjU2xEUzhOVURPNDBXc1ovNmlHYlNuUHMvaHk1?=
 =?utf-8?B?eVlkcVEvSlNzQjFNZDZTOWNmUWxrWE1DV3BBUEx1TDQ2ZmtIV3d6bWxHNytT?=
 =?utf-8?B?ZGZuYWxHMkovUWZHNXFoNmYvUDBndlFWakorRWhFQnBGMW5QVEVkeVdOZ3ln?=
 =?utf-8?B?cUQvVjVlaGVqbzVWUWhPTCttdVgvSDJXak9sWXBzR3F6SlAxbUp2QmZWb1NM?=
 =?utf-8?B?aTZFNXhJNDFqRzVQaXdaYk5McXFYRW5NcHMzS0lZZ004L1NZdVE0UVJ0TlYw?=
 =?utf-8?B?RWJ6RndsaURNdGxNOWhRaDYzRHVtdU9IVzBsQlFPRUJZdTkzbS9qSTc3T2Fq?=
 =?utf-8?B?T3I2TDROdGZlY1FHZlZnZ3ZPd0VrbTBXbHV1MTdBeUR4aCtDMmdYeUltQ01i?=
 =?utf-8?B?Zll2YjZFd05IOXFzRjZid2ZMMGRrTUZrVU1ZcVBrNXIwZjJ5WFBiUTAvemtj?=
 =?utf-8?B?K0hiSWxlZVBBUWNSZFJtRHdDQkRDMG0yMEVGN2ZaUHcwZWlSWlhkcEJoR2tt?=
 =?utf-8?B?TlNzUTFYTnJIY0J5Q0V0K1VEaU9JRGdZYjhTTGhpbVhlOTIyTjJvTGowYmVT?=
 =?utf-8?B?aW1EUVQzSlRRTWY0R09qblJId211S2h6R3hNcWJtQmJUUGRwWHloMW12V3Fy?=
 =?utf-8?B?RXZjZ01yV0p5VW14NWhnVGc4cGx2TWdsVmhhRlgyQ2FkVm5TWHVDQmI1Zk1y?=
 =?utf-8?B?ZWU5T0dCUDF1ejdBWm9QZnNkeFFQWDRnNm9iUC9GQ3dseWk3VitxYU90TGhv?=
 =?utf-8?B?WFpXemYxSjQ2TFQvREJFdGZTT3pIUFNGeFZkVWVBWHB5eU11YmNQN2ZJcDVk?=
 =?utf-8?B?KzJ1ZlFuUFpHUmJWbjk3MnRsNSt2Z2dOUzVDWWZ2VWlzTDljaDlIc1grKzcw?=
 =?utf-8?B?a3hFSThzeUsyNHkxWCtiS25NYXRrS2Zjd0RrNkcyMlEvYy9HSnJmeDhGNXFy?=
 =?utf-8?B?RmtsZlhVS05sa3dlazgwWGVJUHYzcVZKRXRUZGpwWnN5R0sxUEN1dFYzWHl5?=
 =?utf-8?Q?TvE1QUygtp+9+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:59:56.2843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 489ce819-9a3f-4d08-eca8-08dc6506144c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111

On Tue, 23 Apr 2024 14:37:17 -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.29 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.29-rc1.gz
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

Linux version:	6.6.29-rc1-g73d4a5d15a31
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

