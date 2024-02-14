Return-Path: <linux-kernel+bounces-65626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA6F854F93
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649041C28E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38CF60EC4;
	Wed, 14 Feb 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="msdv9nRy"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19E60ED1;
	Wed, 14 Feb 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930746; cv=fail; b=YXI/thHZQNICJrow9wIg5bFGDFaM4wUPtyDlRbK6e3U5Sfmvj4nfzwDX48pGyA6psLlaEzhL3n6lgNx5Zd+46rbAPL/wh8/zbfqPJ7UKPd+iY+cGUo4EYFvOF0/S8Swuk37St9Z3S9zYU7M3VwLoFNYLV2Ul4wNay3fo/OFbMWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930746; c=relaxed/simple;
	bh=Jz0+mMgj+cVU+iI6p0wJXQRZARwlcvXEu3zPrbPVj78=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ixt2ochP06QZfamTYJqG1PDvJWxkdS2iM9SvpmlPfPhPvviU18Mj+3ZD5xqTn6SiKmx8Q+iWIoLlCuVqxjoYuI7vx0s1eQlGiPW6SbcFfeMdqzfQOHRHe5uTZf4gkDtwpxYtPXC1c3WVo2hgmpiXYKCM+Yzz+tUcHjSmkYiYzdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=msdv9nRy; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3grpO6+BvAOIXfyc54YaKrlOOpf7LmZq0Vq9kTWqdDDIWV5gyrp2P8bLx06TqSJgKuKo8JROCtssBVc6OdI0m2wb/3CWMner0E3jvnUd+B/6Jr1s0z6ogkCReXEeswAaL8myClV91NhyXW0nzFPsk+qX4dlCDud3YarBkXoWRGS30yO3bXOCRmr7UgUlJwraSUpk8fhOexDQFBEFnMfMWej/cUBJmdUMpEpLjU8zkg/XTbrB95+epcmz3K1xQ6Nw8zuVE4KjJLHdnyw4At0H4ebv7w8ALGRJsniv/Deuam97eR8LFwHH/cMtkpRP9rNhBD2mBRTYTbETntYTXn4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXQIcC7TyO9z6BfCFr+Zm0iD/LImDhEYWZQR/Git7yg=;
 b=MWyDNMb7l9Vwr/KWhH6bgLA8DOWkaZWZCuiaJa0FqG19vt5InACPys5sXA0s6jxUrgJwMJNdNkHrRt/D3/wmtY5rz25vYKVat6+LZA1jOi0xIH11fLv8rTtiXHIjddJqtXM/VeKMO+7FK/R6ZFU2JBWX7totSsQt7ac5s5kufGS1GQNWNuxR8u9viDWmUdJfms7TdHpUleOWP88XfCQmuAJPJ99kIPUqLEZvhtMD9jQCXVN5vXm332G/gHnIiFYmx3lFuLQYiR/3OICNCE77awBH439dA+55IRDJukxA9zuBjZ0i/AFCiiGHbR/gbM92wyoB9URXIhgDTwZmsGjw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXQIcC7TyO9z6BfCFr+Zm0iD/LImDhEYWZQR/Git7yg=;
 b=msdv9nRyMQrLVmYdyk7rAYO2KR/sgn5gYRTWuXVbkIMYSvVGqDPYSulZh0vI0oQuEvg97LZZlB9eCJUVhLvPX5Vlxvkz0ZNnJ58iXRJlC8Rl4zVGIDS0a5qvtl24Lp5rjzXUzdMyfr1N+BwPh7TPFx4sVY+bfjPup0Q1G17QpnkDz9qcZgUmPYiEU1XIONM7l4XsoOVTIXTj0g57gmw08Hz7c2TaXmxo5wvv839yXVGY8blRZfg7LPEDepVyLrK1zzgNTS8KFegdsJG+3bp+8A1CWdQNm0tFgdNWm5QnaHPgZMk/Qi/nR8iXXT4/Tje6fni3EPXRWmAwg2Zc2CCC5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Wed, 14 Feb 2024 17:12:21 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 17:12:21 +0000
Message-ID: <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com>
Date: Wed, 14 Feb 2024 17:12:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant
 case
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, wkarny@gmail.com,
 torvalds@linux-foundation.org, qyousef@layalina.io, tglx@linutronix.de,
 rafael@kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Thierry Reding <treding@nvidia.com>, Sasha Levin <sashal@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Shardar Mohammed <smohammed@nvidia.com>
References: <20240114183600.135316-1-vincent.guittot@linaro.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240114183600.135316-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5844aa-823d-4b34-fe11-08dc2d801aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0kMwslyBgPTe+lNEJdX2Z/wWvlRBvGGD5Yp2Qx1wXQkxMbbFxSrADMxWAelQD5dFQBAFt62qcQuFMcDPuToZGhNOkPyeteJUZQixehzF1yArc1wyc9Wa0ClTAdEJMBU/RKhfd2GAS23pdwRSnpXh9Wxfqgcc40vfYqmEqoqNSqxyaitVLgJDPT6yqHd1YNAXMWkC7vX5N/YObf5oRT/B4Jp86EibePpjUDsgt/rzzet+Ruf2ilmVjS9wFglz15WdAfiKDmGoai3novpUCd26P1FZZHop3dDi+Gge3kA67VqO0+Ku6jy6GuNf8mSWNeeuH0ugE2zOzrKNFl/7d8pu/CVT1+2PZOHxWLhQ9juqBd90dLyvX6wJF//tJN+StG2OlE4/vpihjQ3Tx9qYqOTSiMqA3v7KWJIIe7Y1exPsX38Bm5Zj2HPMbQx0xPLrz9ysIgQpwhMKx0dHabhlHXx0RnasbUENZUt9aEhEUJgfigvsCVN3Ufwjgvtk272KeOT2TBBQMC52G+Dhfp74pbHb7QSlD83MPmLocm9KnpY7CNvunub3fywoVz1QV+peWBi6/L8tivWj1plZ8mN2IoANlEuDbr0d3XADN+UOizMzR4MsiB3yV7C878WM8YX6x+atZ8ZcKsaRYIc2w9e/lXf9jQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(2906002)(41300700001)(478600001)(66556008)(8676002)(7416002)(5660300002)(55236004)(110136005)(53546011)(6636002)(66476007)(83380400001)(8936002)(66946007)(36756003)(921011)(316002)(2616005)(26005)(86362001)(31696002)(6506007)(6486002)(6512007)(6666004)(38100700002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVpvQ2dmeEI1dlBibjlzT21ZNExCZFRaSy85TmFxZVBuVHYxSGJuaksxbVkv?=
 =?utf-8?B?WTUvVFdTSXFxSWQxQkVCZ00xendybHdPRnlwSTREdUl0TjhhemxtR2RBZG1L?=
 =?utf-8?B?UUFKTW00UHFuOHdGTmIzZW12YVl5U2pXRDE0QUZzcW95TTV3NlRrcFBlZ2VN?=
 =?utf-8?B?RkpjdUg0cHZoRm05TldvQ2xNdStsTEV3b295d3RKc2RpTVFqdlZDcDdHTzNG?=
 =?utf-8?B?TmhwcXRSNStRSTlwd2ZwMVNFMzJjSCtXSWNGN2I5MU11VWhTMEVWaDBCYk1m?=
 =?utf-8?B?Z3VrRVk3Z3FHTkRTTFpvaGs5b3JtaDhjNGRFV1l0aFgwV1ZEOFpIaDRtZ1R5?=
 =?utf-8?B?Q1N3NU9USVE0WGRRakxIcTBkODhoald2bm9CdmpIR3dxcjg1WXEwZVF5Smor?=
 =?utf-8?B?R0NGK1VtTkNneUxVckFDUXBZT2xVMzNzV3Z6MXBuZVJyZjIvZFRaZTdnZkFF?=
 =?utf-8?B?alZTTXhwSWN5dnAyWGFsaFRiWUhxWitsdmhNSXpzc0s0Q0R4Z3RyVVpoVG1Y?=
 =?utf-8?B?dXJiZjEvQ3l4Z20rTHhnSXNhRldhdkE5VWl2cmh4RlBwaEJzajdweHZQSEww?=
 =?utf-8?B?Z0N3RE9rcFJlRjcvODNkQnpnUURHVWxlT2UrbGpBcW81eEc3WDhhVmRyMm91?=
 =?utf-8?B?dFFuQjlWZGZUamhIcVJwUU9YVmlDV3U3SHdSVTZBcjJ3TXk5cEZ3TmZaSkw5?=
 =?utf-8?B?Ukp3V3JJQ3ZzRklvWU54Yld4SWIramxHUzVmZ3lhYWJhQkJpaCt1dktxMnpX?=
 =?utf-8?B?ZmNpbmJrYng0WmhPSzYyRXNCb3B0NVBPWEZEMktyaEJPdWRLRkJLc3diNmhV?=
 =?utf-8?B?RnV1N0pkbkFOMzg3S0FhNStnYlpieUllUmRLbk5oYU0rSGtRcWZnTEVLd3R4?=
 =?utf-8?B?L0Q5aVp5aHhJN2lXQVRqcFhPR1ZBYW5nSGNlVHUyM0E2UmNHZmI0S0plNjk4?=
 =?utf-8?B?d0xRQjdEU0EzSjYyNlpmSklvQmloUU92UlV5ckFOQnVhd0NDa3FHU09OQlRL?=
 =?utf-8?B?RUZzYzNqdGNtZmcrd3RDT2M2WDRERGFEUVN2bE1WVnk4S3N1YlRDYTBnN2ZZ?=
 =?utf-8?B?MUdxaFRySU11d2NsbThPVUVrN1Y5bzVXclh3R0ZFbG9hc1BoZEV2OERScS95?=
 =?utf-8?B?d1FXS2w5UklxL3JjbWpFN24xMUhQR0FleG1Pb1VnajBzZHVGM0hZSm14OVF5?=
 =?utf-8?B?aHhVaUQ5OEUwZkw1M1luM1hHSHNQTUFib0JrRG1lNUc4VWx2emp0UFFWOGZz?=
 =?utf-8?B?bzdNa0tRWFgxbFpCWEdLVTkyM3A2MWRiTWdHQXdFTkxLUndIRVJqSFpTU0hB?=
 =?utf-8?B?MUpzOHNlaDdUNWZTZHNRM2t6bzE3aStqdnZXeVgwQlk1RDdKMGJCMkZRd3FB?=
 =?utf-8?B?M0MyeCt1VGdIRk9RQm5NcGpWK0RoV2Q1bzdxdHRjYlBYMHg2bzBJbGg2Rmtt?=
 =?utf-8?B?WTFCeGRLTDE3cUxwUmlEUXhBRnY2VDgydFNsNGxlV3FEQnFlSG5Dc2ZhRGZI?=
 =?utf-8?B?TVd5c2plbGdIZEhjd3RFMEFQQm03WWdRUUNZeTJKK0hXeWR2MFdhYXRNcjUy?=
 =?utf-8?B?MWdTOG5aSHRVM2NpUHozbWg4TE15WjFDeXdTbVRjYmRGdFpHWlg1YlBFZ1Zr?=
 =?utf-8?B?Z0p3MDhaNFJEVEVERkZ5cnB0QnY3WUx3RnJUTyt3UHdUNi9OdGgrcGVDWURT?=
 =?utf-8?B?NWJpeGZSVzBkZTRoWjRZSi9kcUtxMC9PVm52Y3ExWEl2RmxpeWs2VmFXTFNP?=
 =?utf-8?B?V0dJTjh2bUlBUW5EbWxPamk4VVlBVmxmNCtNemMxNVQyMHhlZVBDampLTWhV?=
 =?utf-8?B?UzlrMjZJMUIwMzhqK1JjZVZXdG9RcmVtUXJQT2RvK2wrWnp4WVdzVFltY3pK?=
 =?utf-8?B?LzVpMXpqM1VFKzdBZElUZFZUTnFxa3hvbzU4MVlyTjg3cmlMNFNCdEoweXZP?=
 =?utf-8?B?RnpUcmhqMHZWdjloQ0Zrei9UT1J3NjBFUmZhM0lPUUVPT1lKS3phSithNlZR?=
 =?utf-8?B?OWFPWCsreXMwMW5EcExiSzFwSHhtU3pFQW1waExIdU1RWkV6eFI2VlhHSHRT?=
 =?utf-8?B?SDVGNjNid3hieC82b2dmd3p6ME0xQzF2bFN0VmluNElObFppblU4K0ZocTBU?=
 =?utf-8?B?Nk9kVjR2VEc0QWFIaGVtaEt5Rmtia1hwRzYyV1ZVUjI0M3RxUTZaWFR1YzdR?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5844aa-823d-4b34-fe11-08dc2d801aee
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:12:21.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEfDYPelhhNCsS7gH2F/fSvZydqjFSI/SziWKWeH26d8sNVCqjeZfsDKRsz4B3kvlaLjdt1/hedBY77BzwrZCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299

Hi Vincent,

On 14/01/2024 18:36, Vincent Guittot wrote:
> When frequency invariance is not enabled, get_capacity_ref_freq(policy)
> returns the current frequency and the performance margin applied by
> map_util_perf(), enabled the utilization to go above the maximum compute
> capacity and to select a higher frequency than the current one.
> 
> The performance margin is now applied earlier in the path to take into
> account some utilization clampings and we can't get an utilization higher
> than the maximum compute capacity.
> 
> We must use a frequency above the current frequency to get a chance to
> select a higher OPP when the current one becomes fully used. Apply
> the same margin and returns a frequency 25% higher than the current one in
> order to switch to the next OPP before we fully use the cpu at the current
> one.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/lkml/CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com/
> Reported-by: Wyes Karny <wkarny@gmail.com>
> Closes: https://lore.kernel.org/lkml/20240114091240.xzdvqk75ifgfj5yx@wyes-pc/
> Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Wyes Karny <wkarny@gmail.com>
> ---
>   kernel/sched/cpufreq_schedutil.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..d12e95d30e2e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -133,7 +133,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
>   	if (arch_scale_freq_invariant())
>   		return policy->cpuinfo.max_freq;
>   
> -	return policy->cur;
> +	/*
> +	 * Apply a 25% margin so that we select a higher frequency than
> +	 * the current one before the CPU is full busy
> +	 */
> +	return policy->cur + (policy->cur >> 2);
>   }
>   
>   /**


We have also observed a performance degradation on our Tegra platforms 
with v6.8-rc1. Unfortunately, the above change does not fix the problem 
for us and we are still seeing a performance issue with v6.8-rc4. For 
example, running Dhrystone on Tegra234 I am seeing the following ...

Linux v6.7:
[ 2216.301949] CPU0: Dhrystones per Second: 31976326 (18199 DMIPS)
[ 2220.993877] CPU1: Dhrystones per Second: 49568123 (28211 DMIPS)
[ 2225.685280] CPU2: Dhrystones per Second: 49568123 (28211 DMIPS)
[ 2230.364423] CPU3: Dhrystones per Second: 49632220 (28248 DMIPS)

Linux v6.8-rc4:
[   44.661686] CPU0: Dhrystones per Second: 16068483 (9145 DMIPS)
[   51.895107] CPU1: Dhrystones per Second: 16077457 (9150 DMIPS)
[   59.105410] CPU2: Dhrystones per Second: 16095436 (9160 DMIPS)
[   66.333297] CPU3: Dhrystones per Second: 16064000 (9142 DMIPS)

If I revert this change and the following ...

  b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
  f12560779f9d ("sched/cpufreq: Rework iowait boost")
  9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor

.. then the perf is similar to where it was ...

Linux v6.8-rc4 plus reverts:
[   31.768189] CPU0: Dhrystones per Second: 48421678 (27559 DMIPS)
[   36.556838] CPU1: Dhrystones per Second: 48401324 (27547 DMIPS)
[   41.343343] CPU2: Dhrystones per Second: 48421678 (27559 DMIPS)
[   46.163347] CPU3: Dhrystones per Second: 47679814 (27137 DMIPS)

All CPUs are running with the schedutil CPUFREQ governor. We have not 
looked any further but wanted to report this in case you have any more 
thoughts or suggestions for us to try.

Thanks
Jon

-- 
nvpublic

