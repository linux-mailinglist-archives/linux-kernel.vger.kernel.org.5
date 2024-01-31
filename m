Return-Path: <linux-kernel+bounces-47195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC80844A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE31C22D68
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7CB39AF0;
	Wed, 31 Jan 2024 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b2OFInSb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC239ACC;
	Wed, 31 Jan 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737763; cv=fail; b=U77EhvuKWXkOTc643U4RM7lSvJyEB6KLRDqgqZz3g0MQEwaxNawi2CqNzZOmDbnBVx7clwY6ZYwWLfkbFr0s6Erx1LTPA6taIGzuv9VOz+HJcDUs1M9NVmiGF8+6O7WaoEHcCAuN9eMTVxDBfSlXhfW9KbbtFqdgR49IfYEgr4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737763; c=relaxed/simple;
	bh=ubQ+p6Q8+X0KmSzqoO2G9lw8RDCLf1zERqmnYkU5Gi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WbhbVsexo+f5Xaijr0ce6epk6IpwMruZOW09j6rVzJRji8msdtUnVwAX4eEQrwEZRwYfGN5kM72n9a4Hjl1pNFfTHDk46I8KroT+WaiEJb7oW4xzbWXyH4pPbFU1DQafdhF9wDFOxmTIKjVH6HYqIfl952at64Y3kWCnXPEtsJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b2OFInSb; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmxLMKQ9UQB7GJibuXkdSjfco0ew1FL0slF4gDmR6wBN08A0vtmg5Uzqa7OHaaZ1ig4i56+FjHOVM2zqcUeNQa+PVm1YbG/H3Qd7TpCeaMJCpWNoTKSpwjVSUZTPlg67ocw6jvTSUG1AJ/wULszwN536aglDwOdLDNp1GFLD4xAhl/m/lwKhDm04ND0qjWu+fQ8Zv5p/fVRkfZSj84e855YLqpg91iz8tE/m09XOMLilFautB2E74rq68hkpTtt9Qs37rWozWeLYNtqItT4RJQ3faoG+GUp7JfroqdD7q6xTSHgF1N+Lt9R3SI/mKfU4Lyi+rblYx+Fir1zfbp4QwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTv2/qRXAIjk6WzO6JeOgg2oQ2XVHoc07sCvalY8D2I=;
 b=nq/lN9P41a7/anKa3Z1FIKHMRZ1cxzE77HFvNX29so8oeSCY4UBHUjGfm4PV571SQQFomj5pFwMCASj8sjr3KslPivKYWVEAC1xajo8QIFu7yhiOViTYd1ktcGwNW2ruGvxgmLLb8zTDbUaxUfCoW/HzTdIAe4c06vBIw2GQfEGD8sG6eA1BXVoiTbyZefqu5WqlgzwS/NI5LtaQuYrg+mx0L9LBTtRMbinrRb5sq7US8gomp4ub3Ryq9IyXz4wlNN8CoOzHmeN9VXFxZkAiDRVkEbUtcbFB5SmTMdWqGCJnuQMkpF7Ft6+0nKVFMNIYL+CXF2zjRrrTh0F4QNCjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTv2/qRXAIjk6WzO6JeOgg2oQ2XVHoc07sCvalY8D2I=;
 b=b2OFInSb7tfmWmyTchygTIUVd2Bb1AxmXbJMbj2RXMsrgSrQnN71+S5DQ2P42UWLYoDPL4BGGFbvBfG7EvneTjN/6eVfqIUzn/D720/vVtdarPonmXfegoXnwsTRS8YZmvEw5wHtZVCWboRW0eSnvpKaGyePrSdHmlfMtEp7XDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 21:49:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 21:49:17 +0000
Message-ID: <a0580854-b5d5-4bac-a35e-cc2613ccab2f@amd.com>
Date: Wed, 31 Jan 2024 15:49:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] cpufreq:amd-pstate: get pstate transition delay and
 latency value from ACPI tables
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706690577.git.perry.yuan@amd.com>
 <872b172c350021ab3c55f80460c33473486e4241.1706690577.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <872b172c350021ab3c55f80460c33473486e4241.1706690577.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b74ed8-f985-4c1d-b1c8-08dc22a678e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jednba2oLzSjAun6Es1i9oiEEJZiLqgVMV7Kjz4R1fF6gzVjLWlt75rphaK6ecxH7wvMO1hi0oPrDFZPEfzc60PVpdtT28IBxQbwTW6jCmJjpUXVm4l/zOUEh3cWTLEtL6/bo5/jrPs92gfrePXEdjOdH1STo9z+Cu6z7xRtbN2En50+FVqinKAX/bkJ7exCgPVMejrSb1D+BKsOFO339UTqytyG2m7jegIcB+VZHETNcHK2CBbuqFsmnSPTd5id/l/HaheLWd5ahZokZAXmtin+IhZuFunyxyH7GKMl+34L0ZVsuUHs2VbeRizkvC0yo9tp9UBLQBhEe6qw90YR3TEYsf10/xwPVPadwu3OJzJD6lRA3Y0CsK9WQUPdvxxbUVZIvAxwWD0klqujWlbLMX0PEbCzueiAXziNVtZm6N0jWaka9y7PW3Xav2WgqEYMWBBCEepLoFXiZ4D38848DkuHgDRRyHMwcPRdOCExopxhSaYwA+If+MU59GEaF46Q8VYsc7YRvB5G8SGsdlG2VMwCzJ2Am1OFvwVbU7Yaz88mxZF4B2zBvV3SCvnT5GRvHkdWo3HGiw/aZAssQi64mQitTBcwEYDPfR1ZvidgcyF+9pnNKmnCHzuKH3mn7Zy1AfEUT7/7iXijj0fwQkfFHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(44832011)(2906002)(5660300002)(31696002)(86362001)(6486002)(36756003)(38100700002)(26005)(478600001)(6506007)(2616005)(53546011)(83380400001)(41300700001)(6512007)(6666004)(8936002)(316002)(66946007)(8676002)(4326008)(6636002)(66556008)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGlXT2RHUS95cWZxYzl5cVJ4d0ZjeWFmd2ZoY3lFSGtPS3ZUV29PbXJWRnBP?=
 =?utf-8?B?ZUcvS1lzVEpyNWJwS3FJUHJ0Q2t1RFE5UUZ2UHA3cjhrSFVmVDFJYmZQTzdR?=
 =?utf-8?B?N3h0aXh6L2l6aCtDd0FsMWFlRlRuaDUweml1Sm11blkzdTU0cC9jTW00eVBl?=
 =?utf-8?B?RDRna0x1SjV2ZWNQNmQ3dXR1Ny9KaGo5QzhSUEJDZEM4NnU2V3Q3QVl0azVF?=
 =?utf-8?B?UVhWZkJ6N0hWY2NzYzRCR2E3anpRSmh3R1hCeGNsZ3JsTWhkRnpRZDUxNTdj?=
 =?utf-8?B?VVVYYmNWNjIxT3BHc1VueTZ3U2NlZjBKNVBQQVRQdCtmUkZORUowRmJQQWVo?=
 =?utf-8?B?N2tSUGx6MFNnZlBWRVoxa2RyZFdYM3VCMXY0b2JRUkZVbkprYWtHbHROODJu?=
 =?utf-8?B?UWMwWEZCSGUxZVozY0FtbWordHdoSkZhWnNTeXhFRWhpMWN1Z2ovNjdaKzdI?=
 =?utf-8?B?NHZuQjczbGVuczFGbnp3aDVIbGt3YjhCQ0VOQVJFbUQzSXREd3JoeVhBQ3g4?=
 =?utf-8?B?Y3pjbEgycHl6TDFpaFY4WC85SUJJaHZTR0FsZkxWWmVBZHFMRUNNYkRtMjBR?=
 =?utf-8?B?N2huRElPNkMvallOSmwrSW1qeFVBSEFJcHl6dENWZ2hBZEwrMHkxZWhVQTkw?=
 =?utf-8?B?eEoySDQrV1VNWUpjQ3g0UzNzelc5TjVhS3VVY1luNDBZbXN1eG14VkxLR1NO?=
 =?utf-8?B?eVNFZEJwMkZKMThSMnVmUWtvSitKeVVydS9naUtwdDByMStQc2Z4aXdqQllP?=
 =?utf-8?B?bUFyTG1zamxmb2FpVnh6TDc2ek1iSUtqUVZGa0creFdKRmdjWWZwQTdzcUVu?=
 =?utf-8?B?eExUSFVJVnBqR1NUc1ZndklMRG4xRGkydzh6bEZtSngwRDZRRFpaSFRTMFE0?=
 =?utf-8?B?cmc0clY3UEdTWjd2dTQ0R3pCV01HOEYwY3M0SVQ5L1oremJ0VTBrcGV1cU1B?=
 =?utf-8?B?OTVtVXJidEJlcHZvc2lORU9aUTJoaTlEVlc5cEhrcmN5Nk5ZcS9xSnhYUEl5?=
 =?utf-8?B?TTBoV0FlSW52U1BROGUvRThvTlFPRVI2bjNCaWhoZHBRYVZKb0w3cW1YS0JU?=
 =?utf-8?B?YWVReEV1RVpHcjBENkJqUW1SNFZ4V25vR0lybHlIaXdLdlRLeGNNTkxLZWw0?=
 =?utf-8?B?RWY0TTBYdzVERzdYWkNnY000TGUwU3laVEpOOW03ZEY1eW94RnNIZThobVUr?=
 =?utf-8?B?UUxFQmtqVW04aXJHektha2FxVXJkTFFQVjIzekU5SjFxNHFzV1pJczJYVlZr?=
 =?utf-8?B?QTVLVXoyanREYWNWdGR4VmlzWVhUWHF4THNtM2FUUktpZGY3SERnS1hqZm9D?=
 =?utf-8?B?Qk9GNDA1ak9JWk1NdU5EY0IxU3Nya3Y4YUl6RDkzM0lYRUMzdERzaHd2OVZ0?=
 =?utf-8?B?MTY4dzJIZERnc1RSY0dhVmZYZTFIU3FmSVdVR1Z6eGVaS21vMjNNMEp4MzJp?=
 =?utf-8?B?KzZsSjcwdnVvM0k2RFZIa0xNcHdtbVFhb21EVlY5em9jOHhkQjlYVjh4QUNo?=
 =?utf-8?B?VjM2eHlaV2J3Q0RKVmp2dFozUUdhR0dRZlJnWFd1OXBtQVoxM04yZ1FiY09w?=
 =?utf-8?B?S3NjSGFBRGlvY2RYS1E5d2lDMGN0dHFKQ0RYWmlpMy9IckQ0c0xKTmtyTlZ6?=
 =?utf-8?B?eVUxa0grUkcrSWFDN0gvK1lpRzdCUm92TXlpVEpWYjFlUHZiRm5IRXBMMTlz?=
 =?utf-8?B?bkFtRFZCQ3RFSERiZDhpd3BxUlRTUG4yT3ZwT29MQTU1WDJiNmRXWi8wS1Bv?=
 =?utf-8?B?ajR4d3dvdmZla2t2OGhvMzA0TjdyeGhQOXJ4RzViNHFDaTc3cnhQSjdzbUwr?=
 =?utf-8?B?NXBxSWNYRlFEcDZkbkRlcFNIb2F2TTZFZ0pKMXBNZ2RBOHJZVENEdm56QzBO?=
 =?utf-8?B?ZTQ1YzdZeG9WdXM0eE95TUlBc2gyZHIzSjFCSnlQR2dvY2MzWTk2MEQ3Y1Zn?=
 =?utf-8?B?bml4RWdKeDJNYmJsZjFPMVZLd0hXUVJzcVVSV1J2Wi9SS2NQWHpKWUtLUXdh?=
 =?utf-8?B?ZS9pbm1wbUlldk9MZE9pdXduR1loekNJa1VHS3pUUVI1TVdzV2RNTWkzR1pM?=
 =?utf-8?B?NHFYZHlmSVAvV2lxK1dxZStncUF1QVFqTVVxc1NMbS84ZzFDUjRVRzZ6dTVG?=
 =?utf-8?Q?0U+c2ys56cKjYb13SXzI3nwMe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b74ed8-f985-4c1d-b1c8-08dc22a678e2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:49:16.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWIzsPGJ80W2w7UK7EA68EMDS7fAyULecg/roPhhy59gzVC5UzsEhmAWdytTKMSr9nPDikV5IDrYhf/6nys0Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630

On 1/31/2024 02:50, Perry Yuan wrote:
> make pstate driver initially retrieve the P-state transition delay and latency
> values from the BIOS ACPI tables which has more reasonable delay and latency
> values according to the platform design and requirements.
> 
> Previously there values were hardcoded at specific value which may
> have conflicted with platform and it might not reflect the most accurate or
> optimized setting for the processor.
> 
> [054h 0084   8]                Preserve Mask : FFFFFFFF00000000
> [05Ch 0092   8]                   Write Mask : 0000000000000001
> [064h 0100   4]              Command Latency : 00000FA0
> [068h 0104   4]          Maximum Access Rate : 0000EA60
> [06Ch 0108   2]      Minimum Turnaround Time : 0000
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

One comment below.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
>   1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index db7b36afdce2..eea2e192d748 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -683,6 +683,36 @@ static void amd_perf_ctl_reset(unsigned int cpu)
>   	wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
>   }
>   
> +/**
> + * Get pstate transition delay time from ACPI tables that firmware set
> + * instead of using hardcode value directly.
> + */
> +static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
> +{
> +	u32 transition_delay_ns;
> +
> +	transition_delay_ns= cppc_get_transition_latency(cpu);

space before the =

> +	if (transition_delay_ns == CPUFREQ_ETERNAL)
> +		return AMD_PSTATE_TRANSITION_DELAY;
> +
> +	return transition_delay_ns / NSEC_PER_USEC;
> +}
> +
> +/**
> + * Get pstate transition latency value from ACPI tables that firmware set
> + * instead of using hardcode value directly.
> + */
> +static u32 amd_pstate_get_transition_latency(unsigned int cpu)
> +{
> +	u32 transition_latency;
> +
> +	transition_latency = cppc_get_transition_latency(cpu);
> +	if (transition_latency  == CPUFREQ_ETERNAL)
> +		return AMD_PSTATE_TRANSITION_LATENCY;
> +
> +	return transition_latency;
> +}
> +
>   static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   {
>   	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -725,8 +755,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   		goto free_cpudata1;
>   	}
>   
> -	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
> -	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
> +	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
> +	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>   
>   	policy->min = min_freq;
>   	policy->max = max_freq;


