Return-Path: <linux-kernel+bounces-66735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6F8560DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2EF2844E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068712FF62;
	Thu, 15 Feb 2024 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PF9ufq92"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27812FB00;
	Thu, 15 Feb 2024 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995063; cv=fail; b=gS9rVvFOAtlYDBCXDtPdVnbhUPpwhzRyD8JQ1Vac+Afmwky1MibQWMfpU8GbcJMaVf7Vt7JJrYBbJUy0eRI5aTA8BsgapV91YrqaleE3zWJpmqhoOeRlV3mmxfZbBHxbyq3JTKx3hg091S+7rnQEajQN5AxtwBs4aMZiaL3Fw7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995063; c=relaxed/simple;
	bh=830FRSF+mGVKSA+Q9XTVh1JY37G2fTQN6EaOtJB2Zdg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XfM+DaxT1zRpM8DJDZQYXuV8HFkTXP38Jx+v6HdfYZrsHt3m9/nv1WC+h/6N6MNUkzNtLCKlPC15nnkPUaeN2ckc4udqpg3177ik7Ns8CoyuLHlubaDFC8gM3Z9uCeU2Ctqy0hONguccHv680L70FbAB0bBimXIROuxbHMTk1Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PF9ufq92; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvoO60DR9XyTB9TJeuG5rnLsAAqcNMxtypp4Csxus5CHEvwBgAGluky7dEBzqCH/ry1ISpCp5HxOyS2b1WnRFP2N0TxiAUZYxREMTHerezQhfK3I+OJCQFKqQmmI65AacvH8WvtZKDNINZoXTZ9BqdVgpTKQxau09xyOEpbddRSDKt49EglR6XMX3rE91eDcVqqBbrezt7Jx/oO09yaEKmMRQFYCEo5G0/5Drm5DOyZTfsYrZha8hu2qHml8MIbwz8nMnvb+CY8ij0onutdRU1vwBHGZz3szzrXlHiZnXzW15VSPjxQ53G0fDsvOzup/ZNh5yjpGJC6QS0ZeJualZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMkhEfchKwVV+lJ3aJct2sbNo1X9Hx3c96IXWeb9z9M=;
 b=QeQ/Yyy5v2G1DOnlFf8B/byB2nTZMTSx6l6NKW3hy2TrppMeEV5v19pxnmAZJVW+ismd5mrqtJvWSvB5gtOiH547cuYuNOCTGCShE3g8yItmjmfDAZq5udFuz9xfB7WkRSMO/JIbNQ5wsSDnwTtka4Vv7FRbHJYIWkmWBp4gx8nsQukisqGgKm8JMBRm/2GQJzRdqlxo1s2Uw9dM3C7t145SCx/1bmk1ZdCexGYg8v9MJO+FWJ3WluAFrSP2AI1Iv1i1T9jsK1OaotLMzFMmApHFeNMR2H6j2V3MKe6htWYd6cuoInb/GTc9seoXDtmPVsgHt9IPtvR+nDATx3fWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMkhEfchKwVV+lJ3aJct2sbNo1X9Hx3c96IXWeb9z9M=;
 b=PF9ufq92a8jzKt4A02+Wl+xLaj6hqj9oNLaHKCObFkSRzPjSgyyyvTxEI8T2aT2hmF8YDsueUu/OTePUgeNsJZoKYnuXDBOdEMaebKHb1A/0lGxTypQrXenUPkgVwdsRrGsAcvQhD/WB+/96WG4Ju50kybC99G8Tz1BlTQg+RT+VtFfxm1MgHrCgzLbcTWNxPKWGEszHgYpv25IWtFpy98pPBFEcs+azK1FhhLIkOPH4h+/AQl9+y8btrfoe5SiVOUF4EmWk+P9yJ+pI4sXgBlh9/IJ33/5ECLwqCdrh+5RnKgfU/KzOPAjMbkmPxbE0dRTmXglsZLACWsK/KcfKwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 11:04:18 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 11:04:18 +0000
Message-ID: <6e281665-10d8-4db7-98cf-45829d3abf06@nvidia.com>
Date: Thu, 15 Feb 2024 11:04:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/65] 6.1.78-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240214142941.551330912@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240214142941.551330912@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0135.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: f147b1cc-2dfd-47c2-2d3e-08dc2e15daf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qa6iKN/XtIQRNMlqI2/e/JqpZ7CdrOfuhmTzGuwMvpYEuclao58r43rT51FBt/Cyx6XMEqUk9OFbfFtv50lDZwX2R/vXtp6KWmbp2j11xNvQBGw/3Glj1bONZXEqekMAS4qTHEYSm8kzFJkAI+L1bXcpyUS58Wlu2K6NMWB7ohLPz2cPbE3wDb0dMyDmQ67WwGGTnm84G75nByWTZYZaVwnD8kGgQF3uON6YTNo0wF+X6cFgd5uL+/5zCcloJiRjCHz7bK7zkv2F92yt58Vkx/ucFO6uHbuyI2JR1acTs5n1w84EcIvkCxPDJDyHda63U/k2yTONpDwol70QD1xJczOISIPKyPkmUEVz2IYgsaj5blz8ni3wVHIyYuVTV9L/Q5sipxVlvZrviCVT+Am0TUoPtOtQMAW+rrtAbyvJKzizeWBGmfTs9TqfcQAj0XPU9Mg/WAe2wwW6s8vNVQ8HOilKUqfLZRXP3owiG9hzBZu1DsRWt8yUd0RG+0crBb38+JYQlLJKd0dbCsgVvRZE1+0EKJASKeXPMh7N6IBaYmqPYj4ZVChJoHG0N6xeKiinfGxJJR8VbDEG+HSIkp5x0h24gUjzobUVb4vcOCkaxlU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(36756003)(31696002)(38100700002)(31686004)(86362001)(66476007)(66946007)(8676002)(8936002)(66556008)(83380400001)(26005)(4326008)(2906002)(41300700001)(2616005)(316002)(6666004)(7416002)(5660300002)(6506007)(478600001)(966005)(6486002)(6512007)(53546011)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0ZkS3FqRnZrNkZURmZzUUJ6blVtUFlSVDhNdEVkTzdNbWM5ZmVEaFVWOWhM?=
 =?utf-8?B?bnNpZGl2Q2FpM1dIZXRtR1N1NXMxRjNZOGRqWDNjR2gvZmVWRHNZR3AzYVZJ?=
 =?utf-8?B?VFVob0xISzhWR0ZOcm1IUUVTZS9DOUt5dHcySUZvUWNpTXpYRzZwODQvZlVY?=
 =?utf-8?B?WWwyTU9kM09zNVZMZUJHcHBTcWlvUnVsZEduTzdpWnkwTWx0RGMveGtIYWdZ?=
 =?utf-8?B?ZURFOGk0Q1EzK3FDMmp0QjUwbEdZOGZEYVg2T3RyM3pPZlk0M1d5dndzMCsx?=
 =?utf-8?B?eDQzclJIUzFuUWZUNWQrU3JuRG5nc0h0Nm9mRlVUR1YyOVJ2VXRESG82Y3pG?=
 =?utf-8?B?aEpMYUxKRERoNmlnVnZidWRyUkxhMytEd0VTQ1F2NXdGQWV2QUl6VXlWMDNh?=
 =?utf-8?B?NEF4TkN4aGIxSkQyN2hEOHQvMHd6VFFZNUVjUmticVhXbzliZjljTHV0ZDdi?=
 =?utf-8?B?clUyTGY1YWVQNGozMmZETzRWQ1A4ME9pMndoNzM5OGc2OHBKQktCbjNFK242?=
 =?utf-8?B?cVZqUW1QblJZTnhGU01KdURuM2hLZFNDQjRISWdrdmxlNW9kY21TOVR3MTV2?=
 =?utf-8?B?WWljUXZVcUVYZDZjTmU5cGtnSklLM1IrYzhHRVI3K0dZOTRkOHNHNkhWNDFU?=
 =?utf-8?B?YTZLRVh2QUp2UmJIaDNacC9pd2VHRDJkMitzWEUyQ3hNV1JYUGF4ZXZuekhX?=
 =?utf-8?B?c2pRRmg1L0UzLytjNjM3V241M20vSDM4STgvNFZvalFiblQ1OEptcC82d1VY?=
 =?utf-8?B?eVZ3cmYvbUgxSGQzL0JPUXZ3WXNzaGx6QkZpT1hFOTVRejl6RWtvcnVqVXRq?=
 =?utf-8?B?VE5NTTc1Yk03L0FOMkpMSEVla1djV2xldjlneVY3dXRCdjlrcnBWdGpLODVZ?=
 =?utf-8?B?NnRaR3F0ZktFbTVNWHVPRHovTWFpa0RrbkpqZTl0TVN4RVJBdmJxWkxIZFdM?=
 =?utf-8?B?VjRmdFVLREVFY1VmVm8ybE8rVWhsWVd2OXZDZzJSZWpVMzVVOXc3a2N5ZXlO?=
 =?utf-8?B?eElubGs2Z1BLbVNFdm90N2F6aTdtNXZWRWlnV2pENStSN3lNRzFLMy9oRUg4?=
 =?utf-8?B?STJrOFFlTlVYUFM1aE5HK0lWTVNNS0Y2STF2ckJwUlRMcGsyVmdEN3MyT2pw?=
 =?utf-8?B?RWpQaFdCQnZOUzJ2dE9Uc3drelB0QjluL09ic3hPZXFUZE5YUFB3SXdOb1gz?=
 =?utf-8?B?cTdvWFM4UEpISVFrQWZSUnp2OGk5d3NVU3VKTEplbmNpWU03RjVjMGdaRm03?=
 =?utf-8?B?ZGNSWGRqTUE2UTZoMEx6SDVpK1ExZFF3UlQvWGlYcHFYZEdSYko3VW44QjFk?=
 =?utf-8?B?bzR3QjVzRk5URzlYWVZXcE5SU0gwZ3N0YlNySlM0ZE1JbkZyWmlrVmczQStO?=
 =?utf-8?B?YXh5ME8wUWZBNERHSzMzd2V3UElyRXgxNThydlhjLzVwZ2JOTmlaZFp1MXh1?=
 =?utf-8?B?MnM1WmFqajRXRkJYbFB4YnNjWWpOZFpBMkltdnJJdTJFRnF1QUZkaUgrRXMz?=
 =?utf-8?B?UTlvM2svNktGeFZ2L0p6NVJML1NlOTNzOHlscXIrZTdHUmxzMTRvVTZoQjhu?=
 =?utf-8?B?M0tOMGt1NEZkMkhEN01BN1FUbDgxZmtHVURCU2pwQU0wVC8wdzRIQWNzRGV6?=
 =?utf-8?B?YUVoQXBubDdNUVJSSkRtNjJvZllYYTNCblV0SVdGVUN5NitNVXlaWkxNVFEr?=
 =?utf-8?B?Y1V1a3hoMTJMU1VqbnJoSTc2MnBtYnRsNW1nTFhSa3JJdCtLeFhTM2VuT2Zp?=
 =?utf-8?B?aGE0eWV5UVFPamlVT1FpNGlYUjl3Rk9SR2x6dE8rVXZpY21ob3N3VFVrODhl?=
 =?utf-8?B?bE1qcmQxQktwUkhvTDcyUlIzcURjWk1lc2xQYVYxOWQ4UDdobTdiQnFhaFJk?=
 =?utf-8?B?VmRtZ0JvSFpBU1BpUWR4YTJhdGZXWW1Ldk5TN2Vrc1c5cU80UDQrQzhsUkVQ?=
 =?utf-8?B?NjYvQlRTUzRDNzcxTlRYcWxlL0JSMDg4RStBTDEzNzRUTjRDd1dqNHUvNHhF?=
 =?utf-8?B?VzlneHZKZVdjbVR6QTIvRGxwelV1UDRsNlNvNXRUVHRZWWFnclZUbWd0OTZO?=
 =?utf-8?B?cGtoM2Z1dU83SkxPU3lCOGxrYVJyTHpzcmFMcjZxUkJMUnB2Ukx0QllGUEZn?=
 =?utf-8?B?WlYzYWxVaXNDWUJZSE40blFucHFRNWZsdGJFRlhUN3IyeTAxZUswR2VyZEZX?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f147b1cc-2dfd-47c2-2d3e-08dc2e15daf5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:04:18.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IIx3HqCtHgQtHVa/voJ5FInYv6PHn6POhhi5agnjwbjtsO+tKqEctCWaBViuYtYrbsnTTi0aplZtPFBVoCkzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355


On 14/02/2024 14:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 Feb 2024 14:28:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


No new regressions for Tegra ...

Test results for stable-v6.7:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     116 tests:	115 pass, 1 fail

Linux version:	6.7.5-rc2-gc94a8b48bd4b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: pm-system-suspend.sh

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

