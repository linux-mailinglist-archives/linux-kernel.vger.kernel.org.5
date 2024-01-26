Return-Path: <linux-kernel+bounces-40310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D445483DE37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C951F2561F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7851DDEE;
	Fri, 26 Jan 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uqGXvfjR"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A871DA21;
	Fri, 26 Jan 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284871; cv=fail; b=OAyaa3Wg7eG8RN2SuX4Wmf6nyV0sRQc6S4PV5IeGRPHbfz0ggbFbE1lM1HMB+e+SHCH+oTrHwmlB8lQ8n8f0XcWGoKBO3k4LWYyS6F0QRRsU7IT0TaWnXYECPE04HpLmJO3TVAT5KOpQnc1Xb7TK0vh4LGL1/edeMUOX8z5cjw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284871; c=relaxed/simple;
	bh=FjflAonV7JueKwSsq99i5uihUbGK+LHJLF/5p3vu9Ks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=faQ1v4UHHO/+/FVpsY5d6q7qqHTFXBAYj9RBfdnn5R+9KAPfuIHR48k7HYeNA/cfNkr31Dek/srmA1hF0t5a2PsKHvh/yQ2rgbfNGPRcftCYNicTOtXmhOAc+MVJH3Kqt9zMK2ozCQmE/qFVtapF4MGCjhY3tyY7UkD7KmOtmZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uqGXvfjR; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMQGxD9dOIbcPdo/KphvZMsIjb8+Od7n4yyvfQxBB1INeUM8Uf7zskKvS67mIs2qGKQeMibjWPWULSXCl5QwzZqCY6OZfLUMOwXt4U/cF87+tInZ6h0XGMKhsr4A2fQL+CxCJmidU61rD5Y05caULR3oEjcJ9r3BJGILBhZo/gT/iAmvnPCQH9JDYlR+NdeiLG38JnTen2+yHsrKejI+KfRuocH7To0sH3RKOJ3ni6UUvdVc9jThatnSvF1aXbbA1uflt6BVucJTSHq/CNUZd57Zu9vue/qZ5Cvyq+ZLBPwzAXo7Q45HuDfVDE14Z88mKHQZWIyY1XQ/zTfh0Pxyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV7P5A69PeyFWu88KbTIxEha5VSIiQyr8Cgy3/C8i9I=;
 b=XlHXjzIWBTAqF/2iTcresiVEha3q7sAKSSAU6yEBcbH1bH/N3CMOEIpuCJ6KS5haqKZV9/P9ZWAVuJAiB2OH2cnUxKRY318v2rzVd+juGiX8G7HTBh8RdkpONLeEtgnlnAnTMhPrKzTElQrdWsB05C3plgARM4X/OadV8d+fXBBaW8g5yFh45YMuYGUL6VctVzSRrI04NMrywYbHyj4OQRjWwtvgTbnd4mMx77YHQ4R6MnjrDIxAhGafOIdh3fVmsz0Sj+2sBjL8PHhZATKLIEP5opV1SRGm7nERh9B34z7hsGYOC/d0ajfvaLJseMwxcAt6lELBKg4DFKyNqDadHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV7P5A69PeyFWu88KbTIxEha5VSIiQyr8Cgy3/C8i9I=;
 b=uqGXvfjRPRqQn1H5wH8gb+1vEacRBeaJY0Tob+MTCGT2bqhJ8Yh1zofYp/Kpo8isPKUww6ThhQH0WLePWAiNDpV9KIzIrMcpy+kTV/DriU4izbw5ldP5eOnzu2Gb1Ptj7tIzg4Wbb1Rff/7bi3s1oPCbHB79L8s8wQHENDhY21o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 16:01:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 16:01:05 +0000
Message-ID: <a673c90b-40c2-4b62-9239-530ced5a9140@amd.com>
Date: Fri, 26 Jan 2024 10:01:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] cpufreq: amd-pstate: initialize new core precision
 boost state
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706255676.git.perry.yuan@amd.com>
 <0409d40c500eeb8d4d84ecb028b73f2eee147822.1706255676.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0409d40c500eeb8d4d84ecb028b73f2eee147822.1706255676.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM8PR12MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: 45795423-8e43-43fe-d3a0-08dc1e8800b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z262HGwKEDtMuNm/yTRUFF43A9d5kt4f449y3L76r0iom2KARqYfyUIXL5SA74NPjV8fB8xn1dMCJ4OOrFbkpronYEroJpnADldX+Gry54OQOq0zcCUX1b7RsDaaXHhBO++pJNmaKbAuQspr0GwZYqZ0HPYEEhtLLeyAKONlN75qdX2BclzCOQscjqPHP+CgVepaCu7OLposb39e2PEueb1ZgPnb6Sbr845J4eFTwV6EEmWwGn08HWc6RZXwGQ5ud2Xl746xrU8xtkMzHyA4QnxtIGDG0r8DGXdTi/p1Ze8iiRYB9MWN5UTWomeba7soD8kDg/mLcvlxHWYqHjM6cOCKrBDtjabrY5HwM/GthBWvqrcj8B+CU6IQe4X64MMfUoFQEndzfQZjxzkQ6orteeSnrQFTXYypu4ChIncpQP7+4RqgRDPXB1U+yN5iqpAIxw92umhC4QieKxPMo04MI7fZOkOyxWcW+6yzk1m53Wd7eE+zawHOk6dKRdO2WQQZavWkqmnFKWnB7vrRU1LE3OIpqr5j21fpgdXu7tHPyIhf8QAb75Yq/ORI/PBr3/T2pnKS5xE3RWOWdtPn1dUYasBnewE/l9S3im+9sP2X+W9KfmFdJv3Zual+SFcYgvGslWpMi9P5uQ2G3xctrlTXESnIuXhvFh6/YeZmUTQhcPE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(83380400001)(36756003)(31696002)(86362001)(44832011)(8936002)(8676002)(4326008)(5660300002)(26005)(2616005)(38100700002)(66556008)(6636002)(66946007)(66476007)(316002)(53546011)(41300700001)(6506007)(6486002)(2906002)(6666004)(6512007)(966005)(478600001)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2RUQmxOQWI0OGh3bjR5Z3NNNG5qUUxpWmQxbUtwMkpRSkhpU1J6K1FodmFw?=
 =?utf-8?B?UEV5RTBzWkxHY0JnRmRlQ3lRMFhVVnh2bERjcjBYdUFXK1VvQy91VjlpdkFm?=
 =?utf-8?B?cjFibU5rT2t4cisvejNRc0RseVpoWDJtZm9Cb3MwRklZUDZIR2dGQTdYYjBN?=
 =?utf-8?B?OXBuUmgzaDgwcGNxK21zOTlEK0RRZE9ubENlYXlBYzhLVWhRSFJNd2ZxVVRH?=
 =?utf-8?B?b0I4Zml6cGhBbDlYR3F3NHZIMzdPUGJYTDd6YWIvdy9pRGZzajBZMTU4VEg3?=
 =?utf-8?B?NzNlL3h3TmFxaG5yUTQvT0IwdUZHenlqWEg3MEhmMWg4cFVtNUN3dDdRK1FP?=
 =?utf-8?B?dmVWNExxRHQ1dVpzalYwYVk5U0U4am90cFA4WVRUVStuQXh2N0RFOVdIcTZV?=
 =?utf-8?B?Ri8xN1dxMzZuWnNWckFJLzdudGJ2a09PU2dRY3BFOXRPL1RJSGF3TWNnaVhI?=
 =?utf-8?B?eGQwZjhwNmNOZ3VTYWJIalN4WE1ZL2dhYkN4N1lSaXBuUmwzUGtVZTMrOXQ0?=
 =?utf-8?B?Nnltc3FGRHJXUTd2cWgzN1AzeE5SVG04Y0ZFS0hXaWRBRU5hanVlMWJaWWFr?=
 =?utf-8?B?eDRYY0g2ek4vNHJoYzBwMWtsd1gycEFhV3N1Sm5ObGRZbHptYjBpMlBoLy9i?=
 =?utf-8?B?dUNpaURYYVRRYTRodG1qR1JaMkNnd3BTNHNjV3FpckZFRS9zSzg1alpLQU9r?=
 =?utf-8?B?N2djK29nai9qOWczN1pOdG5zWVJQb25id1IxTTZIamhqaGV0MFNBRjhHQnE5?=
 =?utf-8?B?a04rVW1XaXhPY1BmSVMvc2UzcW5wT0puYTBYNjRDbU91c2hYS0lZZUl4eHpT?=
 =?utf-8?B?czVwcGdZK3pPZmI0a1RNaW5PS1JtNFQycy9FK2g4dVFReDlySkZvcEx1WUM4?=
 =?utf-8?B?K1ZxMkwra1ZIOU5BdDhoNTBvemtyeXl6cWpxcEtsNDR2TkJvWGo2L0IwVE5z?=
 =?utf-8?B?dG9hLy9lenk4bzdJVWV4WFY4cjRmNFQ1NUNkVFh3Z1lycHl1bHM4NEtEU1pR?=
 =?utf-8?B?M1QrSzhzeEpuTGRqeWZMZkxZZEprc3E2SmMxemFMYWV4OG1zbk4wRllZRWEx?=
 =?utf-8?B?MDA4dXliRkpZcDNWcjR4ajAvWVZkUXlPVWJZb0dRRVNuMjVuQVFJbzIwZzJn?=
 =?utf-8?B?K3FEU0kzUmtVNStSU3QySkk3OVl2R3F1RTJnR0c5YUZzMXZZZkx3ZlhGd3VK?=
 =?utf-8?B?YlpvcTZpdzl4ZXl0RjNHR2xEMXJwZEdHVUl1L3pOMlJlWjg1WHJITUIwbVlt?=
 =?utf-8?B?c0J6YTVxbHhtVlBRWW9OVzBoczdqRHpwWjhOcmVNdzVaa3N4OHhHUTZsSmtJ?=
 =?utf-8?B?b0lyYmU1d0crSG5Cald2cFVjcjl6K1hWNzNBdjNQWlRBVW1veDBhQWY1a0Yv?=
 =?utf-8?B?Z3pWTnhYcTM5TW95b1B3Z3ZsM3NISXZlTkx3RHdrc1RmVFJDVlBQY1hmZ3I0?=
 =?utf-8?B?WkFYY3R5bjJIdnhVUFRPNW1NcEZRVURmRDNpZWY3SE43aDdXdGZDV2pwejd5?=
 =?utf-8?B?TUErOUNPTnN1QTB3VGVEVkc1K1lZLzZ5UFdLZzVnQktCbno3TUlxTXdSUVhP?=
 =?utf-8?B?eUxYWlVPWE1YektsWEdlamJBZWlpZHhHRGxlU3d0NEljMDg5Uld2clZDVC95?=
 =?utf-8?B?ZkUxUVUvalVHejV0VHBFY3lWOUE1YS9qRVNDYmZjVHBBK0k1dWN3akVmeFRC?=
 =?utf-8?B?aG1GZ0ttL2VtSDZTbDBGWEhjL21sTDgyQmdKNHJ0eW1pM2VVUndyQkJkNEVr?=
 =?utf-8?B?S1hMa1RVOHdXNDFVQXJ3QUpZV0taTkgrdVpJOExLTUE5YVdrUHVUWm11WlA4?=
 =?utf-8?B?N1N6OXNDUFd3ZjFPMUI4NFB4bm5MZnVodG1SZDFGVXFMNlpBSWN0UC9OVk5H?=
 =?utf-8?B?Q1N2L3dmZkRGTWxWOHBpTCthRDBiVmNiR1hqS003QzBuTFlyQm9HR003TnZQ?=
 =?utf-8?B?SEp3ZHJzQTRKbFZRbTh0a3l2cDJCMExNQzBpbStDaVliSTJRUHlrM25HY1l5?=
 =?utf-8?B?M3poeTV6UWROdXVGckFmMFFpVHBsYWZRQUxhS1ZzQmNCcXdON1p1R3ZCa1dU?=
 =?utf-8?B?TXd5RWFIM0JJZ2VVSFBYak5EZTk0QXVIQzMwdnF4WjJOV3Q4SXJ5aTg2VFpz?=
 =?utf-8?Q?7q7OraP9xt6IjPhe/YhiXv9J2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45795423-8e43-43fe-d3a0-08dc1e8800b4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 16:01:05.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4E0UTlviwTvyb1ZKOrDiUOZ6++RHUS0DIbtpr87rkzEfyu29w/ykr6q5LSxKAJcJeMGnlLayUNtiZw2vk7jtiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429

On 1/26/2024 02:08, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add gloal global_params to represent current CPU Performance Boost(cpb)
> state for cpu frequency scaling, both active and passive modes all can
> support CPU cores frequency boosting control which is based on the BIOS
> setting, while BIOS turn on the "Core Performance Boost", it will
> allow OS control each core highest perf limitation from OS side.
> 
> If core performance boost is disabled while a core is in a boosted P-state,
> the core transitions to the highest performance non-boosted P-state,
> that is the same as the nominal frequency limit.
> 
> Issue: https://bugzilla.kernel.org/show_bug.cgi?id=217931

Rather than "Issue" this should be "Closes:", and the tag should come 
right after the Reported-by tag.

> Reported-by: Artem S. Tashkinov" <aros@gmx.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 46 ++++++++++++++++++++++++++++--------
>   include/linux/amd-pstate.h   |  1 -
>   2 files changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8f308f56ade6..0dc9124140d4 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -65,6 +65,19 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool cppc_enabled;
>   
> +/**
> + * struct global_params - Global parameters, mostly tunable via sysfs.
> + * @cpb_boost:		Whether or not to use boost CPU P-states.
> + * @cpb_supported:	Whether or not CPU boost P-states are available
> + *			based on the MSR_K7_HWCR bit[25] state
> + */
> +struct global_params {
> +	bool cpb_boost;
> +	bool cpb_supported;
> +};
> +
> +static struct global_params global;
> +
>   /*
>    * AMD Energy Preference Performance (EPP)
>    * The EPP is used in the CCLK DPM controller to drive
> @@ -632,18 +645,27 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
>   	return lowest_nonlinear_freq * 1000;
>   }
>   
> -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> +static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
>   {
> -	u32 highest_perf, nominal_perf;
> +	u64 boost_state, boost_val;
> +	int ret;
>   
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
> +	if (ret) {
> +		pr_err_once("failed to read initial CPU boost state!\n");
> +		return ret;
> +	}
>   
> -	if (highest_perf <= nominal_perf)
> -		return;
> +	boost_state = (boost_val >> 25) & 0x1;
> +	if (!boost_state) {
> +		global.cpb_supported = true;
> +		global.cpb_boost = true;
> +	} else {
> +		global.cpb_supported = false;
> +		global.cpb_boost = false;
> +	}

Seems like a lot of lines and an extra variable that could be simplified 
down to just:

global.cpb_supported = (boost_val >> 25) & 0x1;
global.cpb_boost = global.cpb_supported;

>   
> -	cpudata->boost_supported = true;
> -	current_pstate_driver->boost_enabled = true;
> +	return ret;
>   }
>   
>   static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -676,6 +698,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	if (ret)
>   		goto free_cpudata1;
>   
> +	/* initialize cpu cores boot state */
> +	amd_pstate_boost_init(cpudata);
> +
>   	min_freq = amd_get_min_freq(cpudata);
>   	max_freq = amd_get_max_freq(cpudata);
>   	nominal_freq = amd_get_nominal_freq(cpudata);
> @@ -725,7 +750,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   
>   	policy->driver_data = cpudata;
>   
> -	amd_pstate_boost_init(cpudata);
>   	if (!current_pstate_driver->adjust_perf)
>   		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   
> @@ -1093,6 +1117,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	if (ret)
>   		goto free_cpudata1;
>   
> +	/* initialize cpu cores boot state */
> +	amd_pstate_boost_init(cpudata);
> +
>   	min_freq = amd_get_min_freq(cpudata);
>   	max_freq = amd_get_max_freq(cpudata);
>   	nominal_freq = amd_get_nominal_freq(cpudata);
> @@ -1143,7 +1170,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   			return ret;
>   		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>   	}
> -	amd_pstate_boost_init(cpudata);
>   
>   	return 0;
>   
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 446394f84606..66d939a344b1 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -80,7 +80,6 @@ struct amd_cpudata {
>   	struct amd_aperf_mperf prev;
>   
>   	u64	freq;
> -	bool	boost_supported;
>   
>   	/* EPP feature related attributes*/
>   	s16	epp_policy;


