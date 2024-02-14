Return-Path: <linux-kernel+bounces-64916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF91085449E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D628132F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AE9BE5B;
	Wed, 14 Feb 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BHdrcXzj"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C8125A2;
	Wed, 14 Feb 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901683; cv=fail; b=SiD+PpZAYzusk13eiesOFukxqc+ntOxq9LH20FpkWsCl00PJSPCr9I2dlDdMCLscoc1ovY22NKYfMOnVak9cVaGirCyI0qpxeMQoUe2avMyejhM28sGW7Sib6IpkzTnk8ukGRlpEV+XUlQDfXh4maEbMdanbACBImaK70AvMcro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901683; c=relaxed/simple;
	bh=8B0AaKSxGe3FchPHOVP27gM4HFs5oCLqKH8M1F8Cxhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJRzU+kGm7hZ1gBSlSPR4L5n7YcUerkE0oXlp70c/u/Vj3c41ZVrm6//EEffM1tAwVyuBXwR+cU+A6dNJgxkAv9AaAeXW7BW1EHLyRh+UIyhQQ+c7k5AbLt5d+s3Ug3rwUnM+g5QVlLV5RPtxN3hiBOCpLGtucNk9h8/DFFOznA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BHdrcXzj; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAr6DbMk8ntMPvQTLMSUoF8V1Br5770w49IsV5ZCCA+kFJiQ2ZTpcfod67G9SKSoreqDttKGo46yljJjaHv/XBOx5RDL6UXAaGSifCllGG3kBthBDIZJAtlkSnRDFz7/Ozi1EOALkMKdFsmK1zvJg4bJRDcvkF3EW9TS3DUQZRRMQR6cYbWtNuBHuNgetJ1og/XGMmfqMA8ANVN2LET/LmsBhgmoXPrltgOLpvpWDTy4ZycNNQAHuSB65bLcl/pNOlwCwqG+TtGUyeCsus/HHeqdg1/bN6ywSE4yV9nKfuIQKPCGkNPBgpcFxLUFlq4mLqxrcHlrpYzDJLIadbMUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8VKpI9fU9QQIEjo1jauvgIOz3r09ty8Xn+NqR7wUgI=;
 b=J6hM1Jpz0eVfz8wu+H9EMsbQZfMXfizq+ch9BLF6oQkZDExdNRAIFNS+wuqzT9FZiKf8qdaW7Ltq9ZtHdRzvdKQ+k9sSedy5HwslLrH3fwH7/Vn90nEpXmbmuknvwppdYF4S1MfJKiLAbyAVr0/Dn1qsyhbfUIHfr/pvUrOx2+KRwudCs7EC54Jg7RTS2sL+e3pbAdn9jKUMtbf0wd4Wky96VHoKQT17YCyS3MlUGSHCFjVv7MPLjG7pyC8e12TlyEltzfp2gJVTpm/i0QAsn2Y44iHEJn2ir0cLKOMHPk1d1cU99V22rFgSvPh9rMuEMShlvIM6/sU0PKrz9P3SMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8VKpI9fU9QQIEjo1jauvgIOz3r09ty8Xn+NqR7wUgI=;
 b=BHdrcXzjIi2S+weifpvCNns9+thZzMIVuO1ELu6g9lkLQ3+Kxua4ZckHtJHAVXOvHeLfJnCd+E07RDidFQxHcVz/8aTL11NjW/QDV8HCBHsOd60dmy7eXjSy3+Yh/BE85aumxF7EYCNegjP/mTnmoXd5Kvwo7315ni4Jrn5hNJ0c8/gxqEJw7Xf0u11Osimig0Vozz5g7gM6fn+qc5llqe4lgSlV7rTTpVfEysdteTjSflMsRZawO65/0pnGLFzyRQe4IJgbWvqDwggPB6h+STsExBF+Yesji0pkzUA0zDd8M2Wg2LJ6D0QDRe9+sgCLvFMJYklnJtUjAVBAYVYFBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.11; Wed, 14 Feb 2024 09:07:58 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 09:07:58 +0000
Message-ID: <7c88aaee-6018-4fcb-aa21-c3e2f556981b@nvidia.com>
Date: Wed, 14 Feb 2024 09:07:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.17-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240213171852.948844634@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
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
X-MS-Office365-Filtering-Correlation-Id: 5d9c6a76-d064-44a0-f368-08dc2d3c7013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MLl/B9x2a++zXisj02jGsHa7DcrVtqfcfekMMxd/zfQ4MvgEuqrQJkqICktb6ySV1P0DRYVTSVbEEIPZa8o1VG5+3zABgjBd2gpBNer//q0AGYgqKJT1idKC4OdtE/LiJxcxalWvGRZ5r/lg9IPfBeYAGPjXiQyWozYpYqx4BpWSfASwmO4vP4uMqs22QFHxUPTL3T+trJcaxrSdhFnVLyO5PAq/k+RH3oCkgSBeK2d/xZ3WksCsD5QzbJoQ25qbSgXySqabO6OgjVsde9MWIcY18eO+lW3WiMZ9h9ZSPzGhzYSFrjZASFJodDtIK4SY6TEwAEpMvUKjZSP2I2zeuz5j8iZ2/uLmNeTkJKk5IDXn5hX+Bv+6kpdEiqPC8OvabV/c3C8UMi0HiWQUn3Sudt6K8g/2Y2Hhqvrcp1pMfb0vzfFdsfVe9+ckqilICsANRsLIHrI3jm+hHcPhITlgLVnQnUrpnfFMGA18+tl2W5uAAMr9fz5M9U5ZWM45pe7p4dYKKkDHXL6XHWWm4dXLg9Ox03Qqg+xgoRhd/2NcRIcpdc0sQ7DM6P9T9z8w9AWnktYroHjcWqDrFRzLuYOovQqMr8geL/5Q9czTjSm1JvU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(5660300002)(2906002)(6512007)(478600001)(53546011)(55236004)(31696002)(86362001)(6506007)(36756003)(2616005)(966005)(26005)(41300700001)(6486002)(66946007)(66556008)(4326008)(8676002)(66476007)(8936002)(38100700002)(316002)(6666004)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTIrd0JoRVcyVHIvNkx6TUd3cVNMODEzbVVkRmQzYUo2Ky85VTBCYWNIQ1ZS?=
 =?utf-8?B?dHVNR2o5M1FIWWgvR0xCcW14eVlZZTRyY3ptVVVUemowMUZFV1NMZkEvSkx3?=
 =?utf-8?B?d3Y3MTRjaUowOVJXTlA4NHdVRmZrMHpjblJ0MTZkTUFWSFUwOEU3OE9DTHdU?=
 =?utf-8?B?UzZkMGVGVzh6WDZvY09zcUROSCtDb3U1Z2dhbnFIbFBkQytCSUs1cVViUllz?=
 =?utf-8?B?MmFBV2pKYnpZV0tDcU1rbFZGV3ZlVTdndkRybmhBWDZRKzVGMXhTVHllM25C?=
 =?utf-8?B?WTA5NDJRenhGWDlZT2JUMUNVV0w4ZlZPTnhMb1VKUkl5US9ueG96TnV5czNE?=
 =?utf-8?B?NmlOMUMxWWs0aG5vVTdUc0xnSnlvT0NOdTBxVS9ycXF2QkY0dTVLYlYyeTJ1?=
 =?utf-8?B?Q3BET0d1OTZPNkFmbUtkUUJKSW1jT3VjWk5UcVo4Q1h0RnE1WTJIck9CMG5P?=
 =?utf-8?B?UkE4S29JTzM4OXNGVDBLaXRwaENqamV0L2YwV3VneDBIcHk5ajF3MDNQR0t1?=
 =?utf-8?B?QllLVGlCZFp1T3VGc1k2dDlCbFNBaDM2NXdVQ2NUSk5xVnF4YUxNemYxd2tN?=
 =?utf-8?B?K0V5dmRnd0RvV29CVTVCOTVsWWp2R1dVQjZCM0lnd1htWktWSWxXUTd3S3BT?=
 =?utf-8?B?SVZyZWh5clBxSExOMWMycXVkc3JOUjVERi9iU0x4MzJ3bzhxRkVCbkJRNFdl?=
 =?utf-8?B?c3c1ekw1MVNKamhHRzZEUlVsalE1ZW1wbUY0NmxLbzVOaU5RdW1JYitFUnlR?=
 =?utf-8?B?NzBjSlN0dW9YWklvMDRKUWo2NVZSYWxCdWlVdldOQUk4T05GQ1JWajd2VTZR?=
 =?utf-8?B?UGZaSnRyY1hFcWtlMUZsS1I0ZlJRT1licVB5a3hBVXhGYVZMSGplZW9LY204?=
 =?utf-8?B?TTNjWmc0UVhhdGg5RkxnNXFreGpUckwrL1J2aU5nWHVrVnBreVJtYUN3NHhI?=
 =?utf-8?B?WHIrZ0pxMlIwMU9tRTNoTTJNQ215U2Nrci9OelNPQVhXanp1MkxvOUxGUHhX?=
 =?utf-8?B?M2lNeGxjbjk4a21XQ1VEemlEZ2xKQlczZzNQazdhbU16MU9WQVAwVk81ODBJ?=
 =?utf-8?B?b2pWM1ZSNXVIVndwNCtTSEtLdTdZOUhNMEs3Y3hMZUJ6STd4RHgzWkMwNE8x?=
 =?utf-8?B?T05WUFRES3kzVnYzT3RBZEFMWWdkN3FybVk5V0lEci9aWExjdVRqbmpOSmtR?=
 =?utf-8?B?OHB0VWNxVlpsMHRkYWlkV1VkV0M1ellhT0FaSWdEaTh5SHFJS1BQaDdOMlR2?=
 =?utf-8?B?U3pMb1UxQW0vK0c2OUZCNElaRHZHcHZiNUxYMWZIZ2l6MlVUNjRHZ2w3L1VM?=
 =?utf-8?B?WVFkaUloZnNmODJQdXlrdDZJMHhTN2s4d1AyTlgwVWlia0RpQTRmNCt4NEN3?=
 =?utf-8?B?bEhySlM2RDFyTk1FZ004UVh6ek5YN0ZpSmNCR3VqUGVzQzJNS1Q4dnRqaFVX?=
 =?utf-8?B?WmRzY3BMNWdKMmdiQzRMd1lvazdFMkpCSVBFMDhpT053dit1eXduMmh6UDVP?=
 =?utf-8?B?TmhRMjUzZi9WL3RqREF6Q3lMK2FpS3hBaWQ5ZUtIVFR2ZkpkM2lBMGtFK1RK?=
 =?utf-8?B?c0xpaDBaM1l1ZFpoZDNyOGg3OWVqYXlXckI0L0FvR2FDVy9pYUJPN1BwQnFH?=
 =?utf-8?B?VytHdmdHaGFvM1lZem0xcW1MVHhoOEVHL3FkdWcvVUd5OUoraEdyVWVIeklB?=
 =?utf-8?B?Smo4SjZPa0pJeFV4RmdLbUVEZWVRa0F3MVY3OXlGTWxpTkduTVVvVEYyWDBO?=
 =?utf-8?B?NXM0enRYTmFlTHNubnJaVDdtV29kcDdMa0ZSYVB5bFllcURrL01mYS9VWHlI?=
 =?utf-8?B?MmQ1U2ozTFRQcDdxdEdYMEhMc1VyZVJBQmFWb1BCVDA0aTZIUTVRdnhaK0R1?=
 =?utf-8?B?QmdnL0tJQnY5K1BsRzN5N3NMZDU2UWtGd29EREFTZGUyaGVhYXJ6OEtWOC9G?=
 =?utf-8?B?WmlNVzJnMHpEdWpGak9JT2RTY3BTOFFWMzVsNjZwbDllZnB6dkpML0FrREE4?=
 =?utf-8?B?T29mdlJxcnN2UVNlM29jdlJCS1NNV3hUSkRUWHRYTDVnYS9wS0hiMklQK3Fo?=
 =?utf-8?B?RXp0RHg5UGdTUzFZTnNQWGdqWUlYSmZ1NlIxcmZRMGNBNU5iTW1HWnpBWk1D?=
 =?utf-8?B?T3BvdTFHMkpsZURvTFM3M0NNRi9DQ0kzNzg5N3hhTlFqdnh2VEtDQ1Z3bUdD?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9c6a76-d064-44a0-f368-08dc2d3c7013
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:07:58.3546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0/n5O2pi3ffqfFUJIB4RaYUy7KqHlBH8HLWCgQP5ZRsKIV+kJ6l6bBORl3AJBPFkUtXHubx6lbaEHkjiAHycw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945


On 13/02/2024 17:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


Builds are failing for Tegra ...

Test results for stable-v6.6:
     10 builds:	3 pass, 7 fail
     6 boots:	6 pass, 0 fail
     18 tests:	18 pass, 0 fail

Linux version:	6.6.17-rc1-gbea54b0cb986
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                 tegra30-cardhu-a04

Builds failed:	aarch64+defconfig+jetson, arm+multi_v7

Same cause as reported here [0].

Jon

[0] https://lore.kernel.org/linux-tegra/83771838-c346-4a90-92c1-6ba592a620ac@nvidia.com/T/#u
  
-- 
nvpublic

