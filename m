Return-Path: <linux-kernel+bounces-75430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C159185E894
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D04284A12
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752BD1332B7;
	Wed, 21 Feb 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m7BdbTVm"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1512FF6C;
	Wed, 21 Feb 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545034; cv=fail; b=DvJvmuMAsExuWassMl3m0xUsJNfSmhqyJUHmqOzo/SUwltgeoXq4LYRrE9W5Hx89WlIFyf55oCyKbidUAwM2vrmZ+C6cesg1+AXVBLeT/MRpXIgMRZG3sxgtMLIpvV6wH242uavgOnyF1yTHn/no2Akd1MeyL2qvOxURQqXq7LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545034; c=relaxed/simple;
	bh=EWALbtnl17d6Cuklao9rfbdy5QJfdsjbM2bDwzv38Qg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GoSWwBHuIBrROQFftlCqgNWac9Tvc//WAUuB0gZWh3v+UHwJowtdnrP8Qyn7xT+cPh7hOWPJgwtpJg6imgiK0+55nlMqqKJ66XwS8RPQkHuwht/v+xl36/EKJSSo3XoiH4C/sFox3k5y8IZFYKTd7B4eCPNz8lDaLId8KmD++90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m7BdbTVm; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1wAyq2FNoztKrlLW9jkpe8KwO+rOvuwxdZmwxDpZ8m/pXauIB6C2lgCa/rMvwt6LeUMeC41bmxbIUEPg6ba23bIbLGgly8KQMVllStPM4BvhZb5ghAssmSTP4UReABuUZAnC+/n0fjM1DzWB3DLJMsmv+6mrsWaeZUb2ObCcG42ag4ltZchCsyJtzTSvMoAb363s8FseaJu0B5koDdrDJmmcz6DYkINYJZLMovFPUXmNn7kvl9MCbg7jivnki4cj14NeWYI6lp4GBrhsayqNE57QsVSEKk7YAOGl/F+8iuLyFaDcePZP8AqmGLFUmOHK42WPGlomLK8NuIbiHu3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVziyfqV3z/N4ZLcEjeJOM5HMmlC7tNCZB/yZioWkck=;
 b=Rvl0JdODeAJ5Jy2Q6srDPg9t/bmUjVuSBbNDbnsSPjVb62PQOU3A753gA95sCNA3Wax+ixlQjAJfXfbcsc/qUmvl5rYz5Ddp1yONfZoKElFoBf24i3Ti+GC4Kjk4N3fad8OYH3vJAEjTiySRZ4iD9TIrskQhQI/xPF/FhFHzp7lJqjT95vzhK+1PWB6icPeZscw3mSnaAjMgoUxpMmxYBOdLmhHT/Abg2Tmj0DiLZdcZGGI08LDvNBrwUxFELpR7yMIUu7Lx2UJj9LA/VzMV0MveNSbdPeUoU90GrXu1bs6rYHWq9TEARCAwrTf/56gUvcDVPhhlKC6zwneWgDRU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVziyfqV3z/N4ZLcEjeJOM5HMmlC7tNCZB/yZioWkck=;
 b=m7BdbTVm7y0kw/ZB5GLU5hUTN4bODjxH/R2cmg+/9/7daGpSSfCe0FZ2Vl6EmIR0O4hTyVXJGUYAAnpd6sC1WFuKohoDgAuyHtioZoZYf5xTTNJpCcY8AE5D/0mW3UQXq3BY5R9pdtg8VBqT2fQbP5lKSBh52ohvmJeg+X1jYwVthVPpqc6rnVk0LDbSyZy43VXcXrypUP1BXlYpdXWZ9/dYQ/TG1kncQXImsb/kIQ4VLQWQsqiA2CF3+sUt+roLpK1U9eScSUx77BiRErNC7lZkx56nMKE5xyoJgR0LbbvTwduC9U5FOkjKDia+ZogWmHEr29H+Qoe6uQJPa5XO0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.22; Wed, 21 Feb 2024 19:50:28 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a98d:ee51:7f8:7df1%4]) with mapi id 15.20.7316.016; Wed, 21 Feb 2024
 19:50:27 +0000
Message-ID: <51a8d843-6b9a-4d1f-a543-54d735eefbc6@nvidia.com>
Date: Wed, 21 Feb 2024 19:50:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240221125951.434262489@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240221125951.434262489@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 080229c4-b23d-4cb1-3d7b-08dc33165a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	20FWonx+b4zVL0ZU65AmFPPU00krQnax/irqNyBH8hTnvm63XDXeKy2En5rZ+YsKTe2yO2k7QltqzQQzxfdV/rCmpIc/OgsqldHmloNmvVmVlBDhgtGGzlzXAfnAapF6pgJG8VLXDMH1WM1ROPlvxTh3m1YLAHMuhW3DRSOVTRNlDqOLLj+2CYcE5DSfL8ZYgPEK/iadEh+dh16Ft96GS+0dAkrAx4Zg2TgJINkctIycPi2FpjRxMbuvaUFQ1DZkCIVnSutiXLYeGMkL3fh0CSonkNe9W3cF92UsWGLeBf8oLWHrHzElIjJ4cQcnD5RntyniN/rb6R2zPS4a0o2xgf8fgZNejcu099qD2FeZt5ZSRPSIkJFR9gxUbnarN1UaJbHuFNq81DsuFyXlXh2/Lah9s8V39TEC9rOrHwFUptCP+BNZpKT/ev5xqPKgFymtDqFWgbHNqMguev8V7YHMwAQz498SZfNmK+LpN6rQ6gumcQyi8i1+T4lsQG/Bh5p6rcDeae0gwjcPMUP/nJCIgc/uUHCwx7Rj2mfCTuER9BCVi3rf76v774FZW7Q4+Dcl8LiNMnLpoMVqAkSsh6jrHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjdySk1aQXl2WU1sbm1TeWkyS1RITHZzYURQT2tlZG4zRjJaSXgxbFVNRm5p?=
 =?utf-8?B?VldMK21TcDBEQi9lbmhmRU4raTZGR2dySEJxRjVxK2d5SzlNbXFpc2YvV0gr?=
 =?utf-8?B?Z2cxM2Q1cU5KNDU1MlVVWTR4Q29GbzE4a3lNZEN0K1dFYlRDcGp1cVRxTThz?=
 =?utf-8?B?WGhWd0hESXROaVEyU0VGRjRiZGR3Nlh3TU9QS2lZKzhBM0FHR01rdzRKWjdU?=
 =?utf-8?B?dnkyWkNxeW1HdUtib3hLM09jSEIrYmZZU0Y1QlVwcXl3elRRQzFlWXNqaGZ0?=
 =?utf-8?B?SXd1c1I0RzRJT1BISTYvUjJjK01aU3VQRmw3S0pUV0k1MjR2OTRsdGRWdFMw?=
 =?utf-8?B?YWF0VXNKazB0MjVsZWttKzQwYUdHY0VIV3hIVk1wakRxZkVLZ2ErVy8wY1dj?=
 =?utf-8?B?dnNwcmdhVFlsR1ExNzBUT0UxQlhmcXpqQ3FTUHpXWDRKdEFLcHFXRk50UHFW?=
 =?utf-8?B?eHAzei9PQmordUIrR2ZVMWdBVW81NURqTGJiVm5YMXU3djlEUWdiK3pacGNO?=
 =?utf-8?B?SjEwNkdabGFNcC9FWkowYkVoSEIzSU50ZmFCYk4rWkdRL3hGTVBYdlJSK21B?=
 =?utf-8?B?aGUwaEZ0VWpGLzZCckg2ZGE0bGtWRngrbG1MYjhVajZ1SlQ1SGZCNVlxN1cw?=
 =?utf-8?B?NnJ6dmVIODJud1Bmc2RNUXc2YnZ4b0NYNTB4QXUwM1lCZXR1dTJkWGVtVEQ5?=
 =?utf-8?B?NGtra1MySVhWQXg3WGhCUjM3dFIrMkt4c0NOZFJ5SDJVdG8vOEFLQkNmTXE2?=
 =?utf-8?B?TGFNRnI0TDhtSXlkNlNFZUQ1d204Vm8vT2JpRXF0VlJ3TUlnSGhxbHlZKzhE?=
 =?utf-8?B?ejJMckF3OWJGZVkrWHZWTWdLZHJVazlPTk9IbFMvSTZ4NDBrSFhrU2t2NDYz?=
 =?utf-8?B?TGg0SVMybDdGd3gyZFJMVXJrUDN5V1N0RTJwek13Z2J1TWhvb1J4RTNVcXk1?=
 =?utf-8?B?Z2VpNXl0REVhQkdudDRNYlZyaWZkWkF0YWNXMzZsWDRhbzBSZzFLamtrY2JK?=
 =?utf-8?B?SDViQ1IrZ28veDVTdmZLb20xT1VPd002a2oyYU5QT1JKZHlveFJrMUdJeS9I?=
 =?utf-8?B?SGUweHVWbXdwREJCWVYwM1M5UWxvUGtPS1JvMHVRYm1GZG4zbkRiQzZWaXFN?=
 =?utf-8?B?MHJQcExYTy9BZFJvVHhOWHE0blFaTTRWbmdOSDV5S0JmMjhHNFJ4c2txK1Nv?=
 =?utf-8?B?dzhYQjA4U25mbnN4SXBwRFA5RTk1OGxiWXZraWZLWkgzbG1rS0JBdEVDZ2pC?=
 =?utf-8?B?dUNrMHZUTlZ0Y1VGeUhTdXBhZXFUOUVSTXU3UEt3VXhxR2gxZU9MV3JPeWE2?=
 =?utf-8?B?MEFYNkRZb05La2tYUUlQT1ZZalhiYTYrU3VIeFhhQUlmdE14V051MUhaSXR2?=
 =?utf-8?B?R0N3NDF6Ym9wQXducU01NzlxaFE2cWc0RkdSRW41WXQvck1JWkovdVgvSjl0?=
 =?utf-8?B?YWVhbUQ4YTdSczVjaHc4V2V2LzA0WHJ1NVJtQlZUY3kyMmZTTzBkUjV5NElD?=
 =?utf-8?B?SHdEbU9TYmNQK2ZUYW9vWlc0ZStFeis3RitqUHV0emlTTkM1a01nU0prRWQw?=
 =?utf-8?B?MnhaVHNxUlc1Z0hxM1ljb0Q4L1NQTm42MllHODl2ZlVLZGpYYU84RFdidEky?=
 =?utf-8?B?VTdNZ1B4WUl0dnV5MW16dzdkSEwyYk94bXNBOTA0cDVYWlJMZjlyZHNRK0Qy?=
 =?utf-8?B?cXN3SUlFVWFVSk9FQnRDbGVMVXl5VElleGlVTGFIV1R0WGwyc2pRZzJIYUpX?=
 =?utf-8?B?QzY4RGRCNklHbEFzSWdSRzBzaHhGZUl2U0wxYmRObXZHbWNGbkJ0aGFET2Qw?=
 =?utf-8?B?UWdVTDNaMDltbm1nSjNReE1sWmRwa0RBS0h6QXV3SWVTeUpOQ01XbU5jdEJN?=
 =?utf-8?B?Zk9iWVBkMHQxc2x3K2ZvV3JSdUxnNWNFRnZRNmpvU0lxVm5qVVNIeWE0MTFj?=
 =?utf-8?B?bUU2cmpvaE1tNy9DVENJZDZ1OTR4STBvWGUzK1UyRlJCNFNVQUxETld5NG1r?=
 =?utf-8?B?Y0xOOVBZSXRLYjlZZDRIcXR3cC95UWdtOVgyVG1yQU5VVVQrcHZUcHVhWURv?=
 =?utf-8?B?QmFCNkxMbGkyNDZiTDNZOC9XeHljTTBXRUYrMjRJUU8rU040TkxqZUxZbE9w?=
 =?utf-8?Q?Y+5n3HP7mQVSesyHeswvB3TJN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080229c4-b23d-4cb1-3d7b-08dc33165a25
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:50:27.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iwk28UovMiyOWg2idvNpugRS5LDgugeIVcV7ZwygDT3j9shzRiwBD37jD0PMvvdhYJhK22PB2GkZIH+eInVyfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701


On 21/02/2024 13:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


No new regressions for Tegra ...

Test results for stable-v6.7:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     106 tests:	105 pass, 1 fail

Linux version:	6.7.6-rc2-g028924d29f01
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: pm-system-suspend.sh

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

