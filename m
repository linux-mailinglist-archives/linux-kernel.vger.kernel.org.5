Return-Path: <linux-kernel+bounces-47194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01AD844A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D211F22CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8096A39AED;
	Wed, 31 Jan 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WSr1rCer"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74239ACD;
	Wed, 31 Jan 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737654; cv=fail; b=MM1w1avbEDdqa2n/YWaWd8YbDYLXMx+xxurSC4N1urG1YQAja9mUVuYbHHGVVRcXECdEDVj29adBd9kFqbYsAzzE4ertZ1vP74yfZXP4xGLTQ5sGhFFi/zrxYo4OfAAlUeoE9gSfUtRJfouhy166F6nDsolbmIEW/p4n+6Ynjsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737654; c=relaxed/simple;
	bh=tED+utdKysLf+HfTFr3XKLbG3vXkJjLrchDJF9JlwIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hGYTEgp10BgcjcyTmsAcYbcU7hoFpDjxMNpWu2/j1EiQf3h92imdlnX+KOseFgOW4YAGgT2FqaNfgyx7zTW/xW/Sr9hilZqBiBNQTEZD8s2n2U38d7j9EWG3OFVSEQEdWJFyJMGW2sSqOWvsV7HmbeJ690q63rVX9SkDTUcG4tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WSr1rCer; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0UoRoUyTRSKvNtiSbha9BgUHjE8p6PnTzqilv04LU3Lq61i6BkpRZIs9IiVHah7aObkI9PCzFvIK2gp7xR/MVVSEpl5nys9G7ARyEguTja47RY7YchCOt8ReAIIEzeVyq2rmnJ/6LAvD1tFtx76W8spAJz/ILim5Kir2YOxdnwHW3vtCWOyskZDZznLOhDAIWf6NVjPc//kd8FztBtkbTOGR8OYwKZUJf1VDTlKIcjKN/xY0sEDe6vM0HtnBB46+QCNe7l7UTo+nC9npMcA1xhl4jqc8fdcmwBflYZlBbWZqr2/CUBMsToddSLZ4RV0hQggNopbRtl486fLEZeBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UemFg4kuPA0xvk4lax6mx9FY4COs+o6qlL0a3jps81A=;
 b=Yo6BNpPi6ylcBaw6kbKL0P/bbHdc8l401JDbksN8mgbOND8PHG9ggh0zt4uMeofCGvACem7hvUQd/MomQGtnGKRL/Tgbz481uwbZmpEoibxmFnGITBOQ+0+0/nyD0tngl4027fqE0DEf1uNlS49Iyc74bKGLSLgKjtDPGqkm6WGYXyGKtr6Bw6iR0FiESOkT8oE/u6VICZyEkg0MTonfloncK73MZ67f9UlbcITSstYnlMpJAhdZrKFLKbvUMJW97fhc/mKp5WLpxQOJn+lpbHlCFzymwyq0x19rITndgtRqsy6YpIXr14o4fDFvPsKO9CM6r8nBqUinIabWykjW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UemFg4kuPA0xvk4lax6mx9FY4COs+o6qlL0a3jps81A=;
 b=WSr1rCerIyFMps80AREDfthUq2818B4HsONo/Ypl4kACgit8PM3ifVHiTigAZHzvS/2ZHBB8p+u6+Fj0p129PGpnyYR2dH32GdodOTpmoG2XjnSjO13sINaP/10QIwSgnFXtgQ/q7R7X0M0ujRS19+nglhgd1y5teI3jQ3xVTrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 21:47:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 21:47:30 +0000
Message-ID: <67d61b66-4e3b-4b59-af3e-151c2af937bc@amd.com>
Date: Wed, 31 Jan 2024 15:47:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] cpufreq:amd-pstate: initialize nominal_freq of each
 cpudata
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706690577.git.perry.yuan@amd.com>
 <5d5822a829045c02a37d6dac81756be1312a1ac5.1706690577.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5d5822a829045c02a37d6dac81756be1312a1ac5.1706690577.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0071.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: c04febd6-53be-4f87-0ba8-08dc22a6392c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8KqSR0AFBrVu232spCSyyaw+o0LhfPJhoP6wVjA2hXzly2suLakkkYyneT37WAUc52nfjnaqvaGg3hTFkI0h5B0fgG1GBF88NUQK2Djwele+7d87FGfH946tsQZDPaLmKihM2aCRVcbsSHeAK83XxCkj9GxKUgyd3KasKWIy1xrCqsqy9HDZ44ZaUWd/N1qMPBBf00u6vbbCRI3lgLoXYDoSdrP8zKsBsGo5/nIYC0uiqH5qOZChFtcdwCy/L//9pwT9yTQ92UsbShqWRvw/Tf1uKc5omNpW29DFwggenkag1vxv4VIJvBjQ4MsAedH+qtKz4B4Ygzm28RC85xcJCOzB5XBieb8T5MvZJyf6E2iEOhDyFc//Dj0ITI6P/oaH5TRVD6OzexHsMYtW7mOcMUAYwUkrWrrNlcZu+XmhwKwIwApRqnNntXGznJLlG4qePrxLNdpv3QviMZfjm3GxxAdUYnb+0IZbP/KPQlnpPR1ESA+4kVQmWfr0GspaVz/DdXdjYQdoIsLec1Z61j47CadjY+fm/X1yugZ5BCu7Ezj7fIFi2A9BUjCInSVNXRizm8cyEOQXlC83Aexuxomb8fPlIG/Y+cntjVpONxiz6sqcfGpX6O0iKXDfRQvfyzqRoGkDDlLMUEmcugSB/XduQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(83380400001)(41300700001)(86362001)(31696002)(36756003)(26005)(2616005)(38100700002)(6512007)(6486002)(53546011)(316002)(2906002)(6506007)(478600001)(6636002)(66476007)(66946007)(66556008)(4326008)(44832011)(8676002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk5ULzVER3AzcHdpWDRJUjl6TG1jUHNXUnIzWE8rS3dKd011dy90Um1kL2xq?=
 =?utf-8?B?aENxZmF3czhNaGU1OUdqVFkvUWFETC84VVpZT3lFR3NBR2RYSERTNmxvc3JZ?=
 =?utf-8?B?WDNDTDloZi8rZ2twdVo4SHVHWmRETS91NjNnVldEYnBYclFxMElsRytKTGcr?=
 =?utf-8?B?c0M5V0xrblZtSGNBUHFwc0NobzF0SGRKRnp1S2xqUEJkMmQ2ZGhVWG5SQ3Mx?=
 =?utf-8?B?TWdlQ21qSHZCTDNaSUM3T2hUb3Q0cXdZZ3hwdkhUcW9jWllLdkVaUi9lV0I4?=
 =?utf-8?B?NGJRVlB6cVpjTEtPZ1Z3T1M5YTdWVG5VeGZLcmFrRy9ZY2ZTT0wrblVnb0Fs?=
 =?utf-8?B?N1QvREFOWmg0ZVhnUUFVRHA2SC9VOTg3KzNKTjJuZnlTdnBiSjhUMEZYcW1k?=
 =?utf-8?B?Q0FLdzlXMWJDalpibGViQkFEZGdySy9QUVB3M0NaRWVjU3Y2dmUrcjBId0Vl?=
 =?utf-8?B?TmMwMys5THAzaExoOVU1UEJpZFlRcFFmVHZIZmFwVnRQeWMxZXRYTXg3a2lO?=
 =?utf-8?B?MjYxa0VjMkc0UkZ3VW1sWG9NMjhjY284WjdMc1ZSQnRscXFVWDNlRjhQMzhm?=
 =?utf-8?B?eWxiR0hUMXFxZkx6aWdGcHZpSVp4QmNPOGtxUHZaRW4vTHpJbENjeTQwbkdK?=
 =?utf-8?B?ajhkNE1PR0lQaVBKQ0x2RmIxbUI5dVpYSmRpNUJmS3UxUVc3Rk5yQnJyQ2pV?=
 =?utf-8?B?S00xR3M0TkxBeHBlUlB0VXZCUG9lTFc2WTVrY1NFd04xeFltWExMMk9GUzg2?=
 =?utf-8?B?TWJhVXRmODBOazh0SXpjUEZsZ0RRc0RjdUt2WXNTUTNnbmg3K1BVckR0ZmRv?=
 =?utf-8?B?VkpkcjhFYVlRMDRwMUw5ZDhUMlh0cm4xZmFZVjhXeDNSSlNQTHNjb21KN2NI?=
 =?utf-8?B?a1dVd3h6VkRCV3JkRmQvOWtQeGt1YTUxZWtFTFZkelNSaEkzMnVidStIMEc2?=
 =?utf-8?B?L2gzTjlzTkhXaytuQUlWbnBFUEZOY1dXMlVNMnl6bGZsR2F5dXN4elhxd0Zt?=
 =?utf-8?B?aXpIUVVQa3lYV1RHZU04S0Njc1JZK0hybTJZVmNwbUJ1N2lDM3hlcWgxMDht?=
 =?utf-8?B?TG1ScTg3MUloNEZtMHJSR0NqZWJ3YWNhRk80VTNyMVRZUVpZaHNFMTVieENJ?=
 =?utf-8?B?SnVuUXBURnpiWWxMU0JubVo3K3dOVlFBaCtuZEVtdDFYUXN2elJKeFZMdkVL?=
 =?utf-8?B?aGNYZTJSOFFoY2hsR0syblpmbE5qR3ZyeEtBckF2N212cWZVQVZaQ1FJbWRZ?=
 =?utf-8?B?SEhkeHhCaGFQSmRQejFGN2VlUHRETkF3QnNoN3JSK1BmWmFJQm5pUmhEeFVs?=
 =?utf-8?B?SUYxaml5V2VsMzZQQmRxTDlSK09XQm9VZ3VQbzFTKzYzQkh6UTR3NFJZTUZt?=
 =?utf-8?B?c0UrVTZUTlREbEc3aE12ZTBCOGJMc2dKYTdwSk1Yams3bGdMc25WVVRIdDlF?=
 =?utf-8?B?SE9GVDRkRmsvTzcwdWJFaUM4d0VwTzlLRmxXb0RNcUR3V095Rm9jT2g3MDBO?=
 =?utf-8?B?T0t1ZnI5ZW1pOUVIVG1vdjVUSHozNTFVcFJQNzl1Rm1vajJIZEhhM204RStF?=
 =?utf-8?B?OUNLbHVNaGpSejdpWGFtdXFZR0xkUmxuQnh5bUFVTHFRaGQ0L2Jrdm8rMVBj?=
 =?utf-8?B?MTBlNjZqYjh5R2pUL2pGd3l0MVExeFBBMnZzam9MaFd6a2wwNmF2cGlXbXRU?=
 =?utf-8?B?YVZSaHpQcEMzN0JwT3A1UzdKWllDREN5c1lNWW1vU3QvVitDK0czNk1ZR3ZD?=
 =?utf-8?B?SDRxVXRTQll3ZGkwL0VBU0laZlZQcVpGS1QvOXphTWFBRlBFSnVJTnJzRG9D?=
 =?utf-8?B?VE9ROW5YTWs2cUpDSGdCWHhIOFVQTkNIdnl4cU1qOUphY0hHUDgyZm9hbXps?=
 =?utf-8?B?R0o0K2RkZ2lzdnFjdlE1bmE4M0syZVBOQXZ6aEdaY296TzlqWjU2cjVzV0lK?=
 =?utf-8?B?RmtyT3RxLytGUUh0aENoVWpGQzkzNFJsTXdCK3RpVDg0b1BRSEZsRUtpTURP?=
 =?utf-8?B?Q1JrZk4vemxPdEFvaG9ZNFdDWEEvMXY3TEFieWVzdmIzRVlzNmZWYlllRmg5?=
 =?utf-8?B?YkxBTFJjS0MyN01hZ2laenFuQURJV1ZpbGt4MGhlUThybGJ5MENlQUdGZzlW?=
 =?utf-8?Q?7pv9wLsCSJ4gBefJGzaf4keqm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04febd6-53be-4f87-0ba8-08dc22a6392c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:47:30.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7us52TOv3R+xwznI9wfXuADgJWBv1rxNhsGPr11zKoLDKda4KPTe3ImwRS3ywgOK4cmc4OFQp38/RR6eJ7cjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538

On 1/31/2024 02:50, Perry Yuan wrote:
> Optimizes the process of retrieving the nominal frequency by utilizing
> 'cpudata->nominal_freq' instead of repeatedly accessing the cppc_acpi interface.
> 
> To enhance efficiency and reduce the CPU load, shifted to using
> 'cpudata->nominal_freq'. It allows for the nominal frequency to be accessed
> directly from the cached data in 'cpudata' of each CPU.
> It will also slightly reduce the frequency change latency while using pstate
> driver passive mode.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9291a22bd3cc..db7b36afdce2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -600,7 +600,7 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> -	nominal_freq = cppc_perf.nominal_freq;
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>   	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>   	max_perf = READ_ONCE(cpudata->highest_perf);
>   
> @@ -639,7 +639,7 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> -	nominal_freq = cppc_perf.nominal_freq;
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>   	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>   
>   	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> @@ -712,13 +712,15 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	amd_pstate_boost_init(cpudata);
>   
>   	min_freq = amd_get_min_freq(cpudata);
> -	max_freq = amd_get_max_freq(cpudata);
>   	nominal_freq = amd_get_nominal_freq(cpudata);
> +	cpudata->nominal_freq = nominal_freq;
> +	max_freq = amd_get_max_freq(cpudata);
>   	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
>   
> -	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> -		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> -			min_freq, max_freq);
> +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {
> +		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d)	\
> +			value is incorrect\n",	\
> +			min_freq, max_freq, nominal_freq);
>   		ret = -EINVAL;
>   		goto free_cpudata1;
>   	}
> @@ -755,7 +757,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	/* Initial processor data capability frequencies */
>   	cpudata->max_freq = max_freq;
>   	cpudata->min_freq = min_freq;
> -	cpudata->nominal_freq = nominal_freq;
>   	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
>   
>   	policy->driver_data = cpudata;
> @@ -1266,12 +1267,14 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	amd_pstate_boost_init(cpudata);
>   
>   	min_freq = amd_get_min_freq(cpudata);
> -	max_freq = amd_get_max_freq(cpudata);
>   	nominal_freq = amd_get_nominal_freq(cpudata);
> +	cpudata->nominal_freq = nominal_freq;
> +	max_freq = amd_get_max_freq(cpudata);
>   	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> -	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> -		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> -				min_freq, max_freq);
> +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {
> +		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d)	\
> +				value is incorrect\n",	\
> +				min_freq, max_freq, nominal_freq);
>   		ret = -EINVAL;
>   		goto free_cpudata1;
>   	}
> @@ -1284,7 +1287,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	/* Initial processor data capability frequencies */
>   	cpudata->max_freq = max_freq;
>   	cpudata->min_freq = min_freq;
> -	cpudata->nominal_freq = nominal_freq;
>   	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
>   
>   	policy->driver_data = cpudata;


