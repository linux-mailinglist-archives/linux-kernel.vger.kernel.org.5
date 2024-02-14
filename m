Return-Path: <linux-kernel+bounces-64917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A3A8544A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08741F2B8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79623125C2;
	Wed, 14 Feb 2024 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s35cIUD0"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084121171E;
	Wed, 14 Feb 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901688; cv=fail; b=hmwzg9Af8a67VrI1sN6sy8yjLgs/tk0f3E3TUjFkeU1QiwMi+hSWJtKlIAjIpGaP9a08ZCw4Y7LH7DPTgSIlw3wDlbsulyG9hXFzQDDduKhqABD8GFuoZ6eHtisRTLVb7k1BhEFfSR9J7b6fih1g4pisRI808EURoNMVp5KJyFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901688; c=relaxed/simple;
	bh=kUckool7csl5cWfCTRnbWuEl+79ayAaSsIxxKbVEZK0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=obKCml0Bs2OnE7zbn/Sdo7npd8U5fE+FvrqkHOJke8etp8D/7IwN21LohFHBFLc9+AXV5vT0arPD3iJNVSnQyx8lVURUv0ObGcSbUpCnmd5VH4nc0lCH0KBD0qsm3UlNrx2OX2qGk6KAMuuY0KSb9h7Eyskl2p96VLlNf0E7zOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s35cIUD0; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSCImJvnaAARCf3xhI7Aj9n4H6MNNaypUtzSBSuc2D8RgfOxc5RMyT0ukDJFyZR4UdnQTnr15M4UAMeW+FDtKhiiZ3hhRpJipfGjdafCeYDRMPwVLrdKWGCTskWOmwOIZu6cHDvqON+K5AkZibylTwZ0rdPrZ6f9Lhxncwglc5lJ+Y98+BaTVTp3dV8qgrCEnyx1SMB1pNDA4aP2k6P89Nu6rUtRwEpLTDjcJzCEqihnjlATcSTnBp2rVbEwJJL3kjGv6bsnCqICYocNv9DlQWdfoGBIlDHjFKkJZiAq6vZmJAhYx6F1Re16c0VRCGs7kOyKDjoGEy+2K+UDcPpf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c1m8qiWpHvCUOXDoe/fmQjwWL+4lJYB3FeoFW9hoao=;
 b=QF09UlA8yTU70O25RV9t1U6maLUlX9hWRRxvhtWYIj3Q7OAm6zZZ3K6ICaY264+VpNC7Or50BrnULOWJLlzmUKRs+54L8SOAmQoNjy5UApHeBYPbPZPI0pxmJ8i7OJr9F/YEcnMn/V/zcdro4ws3R/FvcGvwDWg0BEOssZDuIjmuJfJIdizCcaMN/RsLI9A8MiZhCwvl+gv+w+zLxQEu/HQ523am4SwVHpJftuHC2pfitPx1OEchDXBqs7VCxIijeWCr78G2DCR9wFoKAF+sWddNO7avZa9ytr2gTKSKRHuIfzAKvo/bd202RsOxNueVdPEX6li8yxeLi0BbNIDPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c1m8qiWpHvCUOXDoe/fmQjwWL+4lJYB3FeoFW9hoao=;
 b=s35cIUD0hoaK4Lk2bcOCIJhmidZq4azPC2J1XFiDQOjPoYXMGF+I3Bm9VtLs3gjqTA/i5DU2mRXKmvSrOU3tR9fUtOmQZ5mjZCU0rDBh9QtNnBUjIWRkBwyMcW4QmLigbLboQVBHaj445FGqUqfWyiYXEQKiSMujDbyC9Ktkz4UG6P+TqDIIWhfNBg1nawFIMOvAsZiAEgip/YPFe01qDuNWdRztyq6V737VsR7Nsol7Hr+ABdDBvqbcQYRmkbVO2ziQ3D8Ld/jPlom1/IL69MlL7m6QWn80E/nW9LF6ukSjhGmVHadjGVibiNnl8FeWbji44lpNjoQPg/+yBab6xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.11; Wed, 14 Feb 2024 09:08:04 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 09:08:04 +0000
Message-ID: <616551d3-7230-48bc-818c-d8051c81606a@nvidia.com>
Date: Wed, 14 Feb 2024 09:08:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/124] 6.7.5-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240213171853.722912593@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240213171853.722912593@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fedc466-3a53-411d-f9d8-08dc2d3c73d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EB1/Fou9UzR/JdMpXjJkyFs+0PcLKGZwAxdHhDIUpwDqA4qywwKPBULVO5ssFiw7pmvxviSJAdKHTm8H467xwYmWewLNlIJIENtQkSxgeQD7t8XtvRuuTMIiAcEqzPneexLzGleeV7Bi1LuUORoq5LZq2OTAEQa9eYMJLvOvLPuFJdQtqCmyknItFeT8Aq/UKkc5rE+lXRy8gWzGvwbI1BbpmJV5CtZqLGLCuC2VUDv6yYP1Eka00NCqHagJJ5wHznhSKOB8GMe0K2wo+zCXYJz0KSZU01nxxk6WzF+0qFvjw2C2R2zvoZJbIIdHeX5SersNoQNhrd76dyUdYqwnwLEf4fX6z/7feFCV+uR+UUwWa6Shtj0RuVeUCoUguNqnSBUFdGFeWaQ2c6FU75eFbhu5aGA1Iab16tJl+KvX0fI1CojmI+OZI7oLiLkc+sxrJMZOVYVXFe5+V3WGbiMG4grV1a4fboB4nF+ViyZSkNhlcVVX9FDtNx991yrObyQMmErKFnJJpJiiAo2yB8/RRDzvVelZ1Ixo7prRMvDkoKnL/kKsKWu66Kl4Cxj1Q8F+Jfy2SckKgnXAk3JC22LdOXrlGIvwzldJIKjfvRsmu4s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(5660300002)(2906002)(6512007)(478600001)(53546011)(55236004)(31696002)(86362001)(6506007)(36756003)(2616005)(966005)(26005)(41300700001)(6486002)(66946007)(66556008)(4326008)(8676002)(66476007)(8936002)(38100700002)(316002)(6666004)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajJMdzI5WTl0eHNCRlptQ0JOY09xRWM2U25vL1lvWXBrbWYrZ0JuWXhtby9Z?=
 =?utf-8?B?ODZzZVliT0cxZ3VEQTVZcmhCOVdxQTZJSmdDanorUnM3WGwwNUxiTkhWNjE5?=
 =?utf-8?B?VjZwMUkvdG1vLytlajNjM2t6OW9WeTFMdWtDckxZYW9UcG0vaWtlaG04dDJo?=
 =?utf-8?B?YWNkQ3B1dUw2T1lZYVRjdGxYYm0zRUZXcnRxVzZTSHducTRDMUFnOTJZZWpm?=
 =?utf-8?B?L1NJVUluSk02L3MwK1RJeXZkZVJwcUJOMHU0NHg3RGxBeEk4bGZZQUpBU3Nw?=
 =?utf-8?B?dVBXeXpKUzdRbnZNL2xMTEhWUVdFZTJjTjFuREhQS01DcHRrM3RQNndBcWFy?=
 =?utf-8?B?UjFUUDM3ekM3WlNZbGtSeTJNWndwMGhSY3pKVHZHN3RBaWladitrL3Rmc3ov?=
 =?utf-8?B?Q2pDS1lRMnhtVHZHa3dPVHNVbE5QV3VDQWp0elllZzBBdEI4REZqN3M3bVE4?=
 =?utf-8?B?UXlyK2FFMll5TGhJQXFza2YzSVNUb0drRVU4NTFkRWkwa003Q29kQ0Q3anNk?=
 =?utf-8?B?djM3RjhtU1RBZkNPNlJKUFBlaVhlSmQxdDRkbytaWlN4My9Sb0VwZVp5a1Ix?=
 =?utf-8?B?WGoxWFpCYzErT0VIQzBVa3hvK1cvR0VRdlRub2NIN1lBMS9FNjVxMjliRUVs?=
 =?utf-8?B?dzVnY1FvVFBvWS9kYVlKVXJoM1ZIN0JueG50dnhVeko0N04xZXhvUkxaRFU5?=
 =?utf-8?B?Mkdla1BVdE5FYndveTYvblQxaXZGQTQzT2w1TUJRU09KbEw1RVJlTkNIRjNw?=
 =?utf-8?B?UmNVTTFCN2R2R0l4SXlONlRvazUxYWI2T1hIbjBnZDdUNm5hMU8rUjFzRmRQ?=
 =?utf-8?B?L005K01XeW42T0EvK1g0VUxYMllsVFd0cWVUQlFZTWJCb0pXZ3g4UTdWbnNS?=
 =?utf-8?B?Nkd6REpTVkNVSXlqVmZUUHUxeDJIRE9tRW95bzhYWVc4bnNKUE5aeXNIcEFY?=
 =?utf-8?B?SUZjeGRqVi9mYUYreHR2ZkNjbGxJSnkwRmpVY21KcDhZVnJUVlZyL2dFaFls?=
 =?utf-8?B?ZTVBUDVtV1l6VUZwb28vVlY1U1BoUXFzemhwRjFrQ0ZnOCs0TDd6ZVpBK2Fo?=
 =?utf-8?B?T0ZubFJjbUN0VWJ3d05EVVlZZ2tnejZUN3U3dGNBOThsbzk4YTUrY3I1Y2o4?=
 =?utf-8?B?QzdreDdhNW1NWld0V2hib3pDNGpwUHNIUTUxU1l4NjZBdTdzYjJMM3Y4UXVv?=
 =?utf-8?B?ZVpHQ20wNHVHRlhzdHNxZENWUnU3TGUzZ1g5Y1NJem5tempIcVE3cVd2czRs?=
 =?utf-8?B?ZmN0d2pnS1QrdDVUTUtoSTgzTERrNjR0WXpHNW1LUmVSclVUcnZENkgyYmND?=
 =?utf-8?B?MTRUN2s1bUVwbFV2MjRWMlJ3Mjh0ZHJ2U2EybkhsREI4WkdEN05CeUh2eHZL?=
 =?utf-8?B?K1RibHZJU1NCc2hwNHNHeWsyMjNPWHNJWlBzdXNoZmdTRHNNUkkrQmNUM0Rm?=
 =?utf-8?B?WCthNWgvNDFRRjBpUUZHbGcwWkFOcmxTYUx2SW9rdTZrK2c3U3lxYm4wRTVt?=
 =?utf-8?B?VzNwVGIyQ0lSVXU4RWh3blRWUjYyQnRHcDJ2OC9CTzBVSENmMVBtdjRZQXNK?=
 =?utf-8?B?d1FObzRBL2Frcm9vbUFtS21FTUx0QWJ3WmFEV20wa0p1QlNWazg5cW1JeVpu?=
 =?utf-8?B?WGVQSDY2cEVCd1BGTGZieW1WTExoWkVOOU4rTm8xOXZxcDdxakRGUzlLMFpw?=
 =?utf-8?B?bjk5eWthTkR5ejdPNks4K3pvMGhvS2pHcjdmOXZlTnJPZmZxRTlFQ3dkaVUw?=
 =?utf-8?B?ZmFXNHBFcDR0OVVJMXZFVVNqUGxKRzkwampnQmJubmtRWEpUR1hzTFJQdUtN?=
 =?utf-8?B?STJWS1JWU0E3M0hjVGtYbXk3R2dHWnVwbDZiWGVSTUpIYVd2ZVFMV0Z2cjVK?=
 =?utf-8?B?MElQTU4xMGN0Sno5ZGVzTTVsRzlGZlVLaDV4ZklHRkQ0ekEzdzQvSmhrTTJC?=
 =?utf-8?B?TWZ4czJIMGlKbmxrYmxybWV3Y2VoTHdVbHN0NkVqaWk4VkxjSGQ5Q2lrYng3?=
 =?utf-8?B?TmpYYTIrVTdEdXNyMjNvTytyRXp1K2R6UWJTRUJnbUZYbU42QjMyR1lZUTFp?=
 =?utf-8?B?QTVOa1U1V081SlBTQ1BidkFqUUw0VnpVRGJYZG5meDJSZGtiY2R2SXFENGxE?=
 =?utf-8?B?MmFxMWZ6ZXZ1clMwSFViY1lNUVR3T0RsQmdDZXhtbERRVVNOVzVxQjZXWUxR?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fedc466-3a53-411d-f9d8-08dc2d3c73d9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:08:04.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61hhJB/wiBxlZyzMxlqmvYthzJuxoXn2JDxtKkDluiR252pct4eEFWMEaQC7dsUCKbXGtiwtDTSt4L0/Vcpt2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945


On 13/02/2024 17:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.5 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


Builds are failing for Tegra ...

Test results for stable-v6.7:
     10 builds:	3 pass, 7 fail
     6 boots:	6 pass, 0 fail
     18 tests:	18 pass, 0 fail

Linux version:	6.7.5-rc1-g93a4df567f73
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                 tegra30-cardhu-a04

Builds failed:	aarch64+defconfig+jetson, arm+multi_v7

Same cause as reported here [0].

Jon

[0] https://lore.kernel.org/linux-tegra/83771838-c346-4a90-92c1-6ba592a620ac@nvidia.com/T/#u

-- 
nvpublic

