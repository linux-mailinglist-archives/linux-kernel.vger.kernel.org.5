Return-Path: <linux-kernel+bounces-64909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DED85448E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0243C1F2A8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC724DDB1;
	Wed, 14 Feb 2024 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="en43cS5U"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3332E12B6A;
	Wed, 14 Feb 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901453; cv=fail; b=JvHdf9l6tFcuHNqQfagT+KcUVEFDS8ee+CGGoB2LTIErdWeklazbGtO3PjZJsQddrVrswP7kvh7YMYeT95LH7f84XP+kcVYiqa7uxa5t2CE/jxhrulL/gKVeWAfxBjnZewnHzb3D4uIquYG8uaIofui3FhzFmcECB58FxoSzDN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901453; c=relaxed/simple;
	bh=RAP5XF4B8iighzngbjs8/c2imvGKuNMK0aQGHv1OmwY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcxhjOs5ZIOBQHvM2parrpfU2UzDJM5QMYty0EzbW0SyX+s75c3CKlACTeK0NkvX8PMF2uzL17GZDAyLiBpSa861sA7vkaFoNDgC8RYzJpzpzFlvfagHaSPrPmphhkilZs7cxml5G2cqfjb1d4PMjFixBhxAdMr7ghVC+6040ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=en43cS5U; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHAUCKquxXrp3LYNhZbN7I3i3UUjNbo0qdf3BFnD1dSKa/MAdxABaYk4lGkkTmenKymI8puy9r+0mhl06E2nv2WjV7Myl2bvlkhMNgcmCWw/eYMlUT2N1ODJx/v/+gKsgj2NphWAd7E/wVcx2U9RMod5UCAW/+J754MSOk9is3EIVkZ8FVksfw9EloCbozHtqBxbJ3JlR47wLJwKfSLOjj6BUU/qEC2PPAsu5vO8glfHE8jLrQrqR1A8eycLhF0gGV9WMaZbEp7yTfiFMpH88mg8fBlUvvCyfRfr6uleI3brtQehi4qPtx3GILs2DYz34UvZOi0hMLCq73jqPIuKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9fEetD3Fx1wumFSblDwUFbVaqoz8UoaTAsvDTJu/IE=;
 b=lxyfyR2fSmOeXz3ISsWzxpi5S3YPKxJ5L1botU3smXJHuy8YQ4nGWZ3qkIR+c6Sn9EGk9TsX+BaA4lckspZmgGA8mMX6KKpu6RiBuZL+bMCnH79rBZmWZIEekiITra/2jfB9unpBGMIFDW6/1MrGZ2X4FaSR0+DCs0fhHtwVaAswyGslvtMha3EoKLoLeAfTHVOiBbAkEO6/LIzXrwo2puWI1RZUd4sWcV60LQzaddhg+KlABEnvAwRI/UBzyAgF5Vvqr4jSx6LttWv+kU5JJ+yfezP3382UTqVKqAAGAJ3xtHm9tKWfsuFLplr/kexViT+90DgdRpJ+fT4J8DtGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9fEetD3Fx1wumFSblDwUFbVaqoz8UoaTAsvDTJu/IE=;
 b=en43cS5URLUr3KV+fh9Q2joDLjHLeLSz94mnuvquIoFudYm2CdhyHZovjIlTt3iXYNg+Et9udVtP35KiQi4tG02zEJbR7lzJ4J8wBmHMwlhn7MPiDm0i5kQGAW4L5SpzJxintCDcNGmMR57yhWjA2pp19e7dH+fGRPZTlJ0AYjugW13hvsimEJ86iGgg3n1/3qZX1DfFwx67zFEkEOgqc2xW+0uvBpkH08i/sv6ud99zPcr2W7FZU9vEGmcxMYHYCuFKkq2rgtyH4jwi/wiQIOkIbpy4wKHiryfrp4BwK74g32uRTtmkS89bC2dTbB3Mu8fRaZ8IAVXTwmE5Fz2gfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.11; Wed, 14 Feb 2024 09:04:06 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 09:04:06 +0000
Message-ID: <83771838-c346-4a90-92c1-6ba592a620ac@nvidia.com>
Date: Wed, 14 Feb 2024 09:03:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240213171844.702064831@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0562.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a08daf4-70ff-4116-18b2-08dc2d3be5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CwGM627H2PvvyhPObU1D+pftssgWxKW/KB/vAEhMRJnhEB/cftSSTml4uW1un0kfoh/vJwQeGCBRW0tkP5my/8g1ANOLYjTaf6GOya97H3L/thhNiYVg09EO19eHLXT9gFjvfS8ZCo9Epyxsyjam0VKTvpfgkmP2rBAFjV0hzFPet+05C1zIRoiNey7yEjdSr09G4NQAOs+FIcIjj3vbacj8udQcNLXiskgg2vQNzXWDGnCe0/8z7AGYujYMNJkiD5EbWVyTEbSaasDcVhLAz6AJd0pI6/zBt8yIYjiDA/nnl3uy8q6AQoKyMQ4RWEzzJrTRvVliz4QpSBoMHInfrAUH+Gs7va2ixytX+ZF0Jro1eE7m18+H81aLoJQtVUCskjgFrCJOioaveG0zpsVOF6yrwxrB7ULLKWWpNfDku0N4lViIqiaTQud6PYhpdrdUuGS1dhj7Sx5GYysMCVJF7OX5u2Vj2Y0VZ+kLPNuuHgWEGiO8Xw6GHMwWfuBcWUD2HNGD/m6q1awOyeVmLB1JWRyeG1+bIb9VexTGZEUGco//w1tFy4IX3rDgyMAck+zECdOvwe7M9nokPLlH0SPJOzASYHmuQAqXYxofyBZ65jw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(5660300002)(2906002)(6512007)(478600001)(53546011)(55236004)(31696002)(86362001)(6506007)(36756003)(2616005)(966005)(26005)(41300700001)(6486002)(66946007)(66556008)(4326008)(8676002)(66476007)(8936002)(38100700002)(316002)(6666004)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVlPQ01pU1JFZU81T21LbzhYYW1wdThKa0duMFl3S2RsZmhqWDk3YncyS2RZ?=
 =?utf-8?B?amhLQjZ1aytZSVduM2NmY0Nab203M0xTTlpFdEZNRmk2eUVGQ1BadHVkOW5O?=
 =?utf-8?B?YUNqekxtS1dQYnYzUUlUYWRVNWIyRVhua1pQaEc1Z1N0U1VlNG5mMmpySnhK?=
 =?utf-8?B?Y3lyZnB6L0NEWkZQRHdUWXdVejNSaHRMUlgvMVNCTTR1Y3oxVlNkRmhubnZP?=
 =?utf-8?B?alEvcXFpMkV2a2ROV01DbG9CZFc4ZmFjQ3dURk8xS2F3OWdrYmRia0tocUd2?=
 =?utf-8?B?aGdrZ1Ira1hzWXcxeDRMdDc4TTNRR1RUSk5zQXFzbGE3Y2pLQjMwS1gzem54?=
 =?utf-8?B?SlZnVFA1RUtjNlAwbmFaQ0JXUWdncjRFNEY3RUJ6WjNGQ3BKMm9VVHhLYzdE?=
 =?utf-8?B?OEs0VCtwV1dYZWtUU2grMXROWStVTWtlYlV4TW03aUJnc09ndTFSTkxIWm9i?=
 =?utf-8?B?Nk9mQzhCYkxaTnBNVkJRNzZNbUVGT0JVbzBHazNSSCtkdzFkUGMvcURhc3VF?=
 =?utf-8?B?WlFaMGNxYjN2cTZGVXp3cUI1TG9tRkQ4aysxNXl4anZpQ2hPL2tOL1Iyd1Ri?=
 =?utf-8?B?YkZXc0pWdW5NRkUyT2szVEhKMkhMLzR1cjk0SjdGM0QvTmw0QUFHcGR1VjRT?=
 =?utf-8?B?akF2ZXVwYThQRm9JSTErM3g3UHllakp2N3pMa21NYmMrSk43UFp0YStkdjVU?=
 =?utf-8?B?aXlBdWxpb1hxTUkvZlpLUWNrTEdrZDM0WWR6UEdRZ2Q2VTRtcmU4Y3ptMWlx?=
 =?utf-8?B?MDdnK0k4akFIQWNtRnVEY2xvakJvbXd3a3QzOE0zRlJ2eDhVck5VWE5WM05P?=
 =?utf-8?B?QkJUNWxkWmNHSEF5ajJwOU9KQzcwZllHT0FnREZVRm1IK2JMMVVXaTdpWUtK?=
 =?utf-8?B?ZlNzRnQ0R2NvTVBQaitZZnVFbTQ3eFN0MlhUdUhLeUdjZmZHRDlxV3dQN2cz?=
 =?utf-8?B?ODROeGw0Y0plOHhvam55NzhpVG5GM2EzUzVlU2o5K1l1VG1uWkNqN3hYd1pQ?=
 =?utf-8?B?V2lBKytrRmdGSU8wNko4b3VnS09MOC9tdnM4bkp6QzFqZmVDMnhZYnR1VGdr?=
 =?utf-8?B?aVNoc1Y2STZPVGJXVzBSdWNzWjlXZzRJclFhaGxDV0MvSDA0b2prdzhBRlFr?=
 =?utf-8?B?UUE0YmRpM2JvRmFIYndoenRldjZIbEVHT2s1OXZkRTF0Nmd0QVhNQTgxVnlY?=
 =?utf-8?B?eWdCbFF4Mkp2MjJ5azdzVng0azVoZGpmeDZqVzI3ZTNpbUZjN0dTTXZTK2RR?=
 =?utf-8?B?NW04ZHVJTDRDbDFScEJxMWQ0YXgwMm5PTmtKdUZmZ25GdEhJajhveENmcXY0?=
 =?utf-8?B?V2JTblc4NjdoYmRPMzZuUy80eWxSL0o4ejM0dkpDdzdzN3owTVV3N2lCUkYv?=
 =?utf-8?B?dUJWRUREYzFSbGFCSUJnaWZEdjlwamZmVmhjMkFCYnJpUXZRaWdVQlVTUlJi?=
 =?utf-8?B?dXk0YmlDM1FkUWdsUG5iL0NQc3BrbFdxQlNhdFN0eFFkWTVJVExtVFpKd2t5?=
 =?utf-8?B?OHR4THJMZUN5SUI5VXFiNVRRaHNCSUtTRVZ6L3dWZ2t3Vmg0YjlTTXZWaUwx?=
 =?utf-8?B?OW8zejZESGZ1QXl3WWIyRUovM1kwbTV0SmNLSHlHVjJwZ296L2tOa21XREUw?=
 =?utf-8?B?UWhBbnFaYjkwTU1xdVNGcFdyNzh1YmhQeVZzLzVSOUQzbThzRGxoYjFxZmxZ?=
 =?utf-8?B?TmlRWU1HZlBhZkpSN0pxWmNwbDNYbjltWmd5NTMwWG1Jd0dPU3NmaVhzWTZr?=
 =?utf-8?B?VDV6VHFoQUM4cHAwSEgxRDd6OW1DK01BNHNOMXJvczg1NGdlV3BzTXlOSnYx?=
 =?utf-8?B?WkhFV2N4SlByU3M0UEZkZDlZTDJpUE05R3lrQ0EwQXRTWSszU1pTZkkvbllL?=
 =?utf-8?B?MjdXMVB3YlcyaGxtRDA2MzhSckp3amlRb05HUnBBWklwejlqekQzbDc3UGFL?=
 =?utf-8?B?VE9QTTV2MFE1QXpzSjJ5Y3pmVHMrYTRYUk9xZnJhUUMvWGhwV2E5TE9BQ1lQ?=
 =?utf-8?B?Z0pyNzVhOGZYcnREb2FTZUZqcnk4cStMeGp0ekNJRWcyTXBCYnpWbDRla3FL?=
 =?utf-8?B?NS8zbE5WbjNOQWRtdTZPbXZJaitWQ3N0eC9DNjhibXd5N0llVzdiZ2ZTQnBQ?=
 =?utf-8?B?QkI2djMvdmRFbWdVUlQyc1dKc0dsSXI0UWZtTElQVU0vZm5SSGV0WGlRM05x?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a08daf4-70ff-4116-18b2-08dc2d3be5a1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:04:05.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8f6K+E6aKmDNL7nJrIORjM9b4bipAVnpsH/iRHa7K2PJ2bSzWnexZ4NNonXJ1YK041jmYbax9KTI4Iwgw0rGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945

Hi Greg,

On 13/02/2024 17:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


Builds are failing for Tegra ...

Test results for stable-v6.1:
     10 builds:	3 pass, 7 fail
     6 boots:	6 pass, 0 fail
     18 tests:	18 pass, 0 fail

Linux version:	6.1.78-rc1-gb29c5b14893f
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                 tegra30-cardhu-a04

Builds failed:	aarch64+defconfig+jetson, arm+multi_v7


> Furong Xu <0x1207@gmail.com>
>      net: stmmac: xgmac: fix handling of DPP safety error for DMA channels

The above commit is causing a build regression for older toolchains and
I have reported this [0]. This is also seen on the mainline and -next and
there is a fix in the works [1].

Note this is breaking the build for linux-6.6.y and linux-6.7.y too.

Jon

[0] https://lore.kernel.org/linux-tegra/c25eb595-8d91-40ea-9f52-efa15ebafdbc@nvidia.com/
[1] https://lore.kernel.org/netdev/20240208-xgmac-const-v1-1-e69a1eeabfc8@kernel.org/

-- 
nvpublic

