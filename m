Return-Path: <linux-kernel+bounces-40304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BDF83DE16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D9AB23AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D32B1D546;
	Fri, 26 Jan 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2NxgSaHf"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC61D524;
	Fri, 26 Jan 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284617; cv=fail; b=skr+dmoYYQDu7HnRSOIntjyHPEKsPQePMh1YghAWUzwdMOxuH1b7NPHSNbFCESyAAfx7+4+RcFpMSII1hbLPlNn74j6vvaspPOnk0+thf8Z5ACjCkLA7RX7u1yJCbYncSShdyAySqnDh8m/2OO7ZAvpsTyiCTUkQ18pGXUAmAFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284617; c=relaxed/simple;
	bh=qfKhSiIxzYhx8M+0OMjUajvKdbWE/p3hqr7mqzD5F9A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FDA2tQAIEbohTkBbS+1pYwxqnD0b7A9CcUyMOj08MhvQzWycqv1r7nOPVskGiiWIAherWJkb/l1bcEWFJHg9fEIw8o+FeHzALd/tBTQrkiq9yAWFwNXUJCIHDt2tr/z3Mx4iwneex02WTSh5hLSJ+5WbyW8MBnyx3HKjzxIG8h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2NxgSaHf; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fymfrcrLSX8HTop7+CDnX2QoTC9pTPNWyuPppWNpBM0YT3sJz98aqAjOJKFL9XqEgsPL78qKmY/gQfDbr9JTdUhINWDcLw8cMYenihkHcMDo6ZSW8I+qzAvjUfC4ZlMEIDrrBaM7RRFHJPnaeKyU23lzLoyLFTytkukPgnYNLUGkgDwMiSmsX2M7LNHtb7RpJ/2dyZNr3mS/9KGzfR824gRjc8uU0FcUQHTHt1ZZAR+BuCLR+sXQkyVbVNjxQvZ2LB6u2Y8tuVv9L8VbDvn4aJU+Xo66X/GNtGFrBcMJeeIIW3q9sCvlnclol6Usxbc3OmgcA4FWV7N8M3Ulp/4C6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9q4Dt8Sv+gQ01lLoC4vrfBk9g8H2GfrFMhI9GvD0z+8=;
 b=APdi7JAc8AlmHPBWnJnGZUJ038VEPRppfwwylAN0sk/iE1mm3lLooc9nz7vWbhzPSEsJE4a/0uGSefA+rpvSrPgC6HgimODsyACO7d94JWGhTiSexjU2J1x7IWv8JPHKkiX4xnZ34MBv/WnodgfNuoo/3ueOGYbx0e76jV+QTse1sEZsGd4Ya4WJpRL6U1hYE/jKAsJQDuP9olW5jcdMgX7K/tqmjS4ykJPijCs4hQzLhpO0fPe3oONAfuu0HV2Co+9hH2/pfAwNq+l1fFCCwgMILcurmpOVJT+OfMRNpwevenBBlYGmWHrI6MX/OFJYmW/ZTwAEk81T0PB0ck8dcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9q4Dt8Sv+gQ01lLoC4vrfBk9g8H2GfrFMhI9GvD0z+8=;
 b=2NxgSaHf+KjERwuAa/FpV8bHX/kKZBjm69a0o9sgMhcrLWoaxHdjYTXtGWWrSvIdIHPM+sN3gh51Uft9VzCHq/lZQTWROofWkH65QecDxikp1MUQykBlHz9k910PH4BdlAum686aHxJC6q2UA8wJ4eUl8SuyLclfA0/aySIkdi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Fri, 26 Jan
 2024 15:56:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 15:56:51 +0000
Message-ID: <233100b4-e765-48e4-a1c0-88d01c621bd0@amd.com>
Date: Fri, 26 Jan 2024 09:56:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] cpufreq: amd-pstate: implement cpb_boost sysfs entry
 for boost control
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706255676.git.perry.yuan@amd.com>
 <f94bfc67e95fca54a153e24d828ef27e26ee5c47.1706255676.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f94bfc67e95fca54a153e24d828ef27e26ee5c47.1706255676.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:510:174::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 05828a7e-0eb4-4acf-8505-08dc1e876920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d4NCVd9YYCyi+0Fk0LSpWeKIhjuBjcv5ephexMBUmC06A13SKjQO5UWC4EfYCPZslMtqms8UZF7JYs9IzD7mDa/JSfIT62xk9YFj9oryIEGkNQjFrLZnQuDPTIo1LrWI4wAARqB4Kd851lAlItJ3C7TmQqQGGPb2ooT+FmEGoQyjDieogUhAgV8+BGPrntUcuEuAFs0vwZSYFK/tsORJnywZBi0Yxv+mSQJ7LGfKzcXWIM/n/wtItdfFNIHFDQgIp83yBjBvOPctHxL53V8DMVN4xIXE+D3ftA5GFgz7IA1ELzAUFzX/q1LFKtGibEnPaisYmgzq8SxO8IWltKf6ZKvnlwwhTFGP0s02ZY9uOuDl5vUfNzWVQqf0qOCOsR25O5nmluYQgT7NOTrlKF7ZhGoAIQQcHZPtHU76Iwu0S1q0WKQT+H4qdrFMVQVASk17fPb7jt5vPsWW0H12Y5kmTCu76+R1pfZbKlHYhVR8lCYXA/2n0sI4FsC/KWY14nsMrsCG5RjinZAF9VVvqhtKwcCh4+btIpL0ZiO7nz0f5CxBWnxpHxsmH8gRX0VykREOMqJRhHE+MhH9m7KCbN6zy112BkKEAoHIg4ue+dVL1o1hRVDl4mHBvGt3urxeG/H3q9B+sGnLh/9ADbrSZ8/GtnwLoQhqxrA5VGuJ/kLT6XU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(26005)(53546011)(6512007)(966005)(6636002)(316002)(4326008)(2906002)(6486002)(5660300002)(66556008)(8936002)(478600001)(41300700001)(44832011)(66476007)(31696002)(83380400001)(86362001)(8676002)(66946007)(6666004)(38100700002)(2616005)(6506007)(31686004)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THI4S0pmS2ludDV0ZksyMUpzSmpSZ3dOeWtiOHd2am0rZ3NURThZNVFybjhV?=
 =?utf-8?B?S0czYlRiT2Q3OEpJem81cDZ3b2ZKbEU4NXVOa0E1YXZPVjlOU09NQitFdzlY?=
 =?utf-8?B?T2ZmQ2kwamhEdlU3aUF0eWpVWGFxTmJhUWF1ODNUZUcyemVKWStHZ3gwc24y?=
 =?utf-8?B?YVc4K1BJM0YwVlhNQ2xQNytxUGRidG1ZZnhLbFVWU3RJeDhjWjF6c2xKNkFG?=
 =?utf-8?B?bVQwajhwMSszdm1YZDZyeThYRGp0KytBazB5VXNQOEgyU3FuRSs2bzgxQTd3?=
 =?utf-8?B?SFZjMWdMRDVMQ2thRzRXK01yYzhKOVE1c2VLTEliQjhDVFEwZFFJd3NBcUUr?=
 =?utf-8?B?bWcxWUs0d2h1TndtbHljM08yUXh3NHZYZzhGbVhBSUdmZlR1T0EyaDIyblo2?=
 =?utf-8?B?enhPV214YWo0L1RsdFVyVDg1cC9CVEtaNjNETWl0VWVsUmxtcENKSkZMNm1S?=
 =?utf-8?B?VVJvQUR1Vjd5R2xjY2tnSlhvcVY1Q3hpa01HaCtrOXZOMHdmdjBtMlUrOGZC?=
 =?utf-8?B?UWRTV1REMDhoN3loK3BxUzBUOEwxQWJHSVkzZzg2aVN1K3ZRdGQvTU9Mdmhw?=
 =?utf-8?B?eFRtc2h1MGFsYmx5a1J6K28rS1JVSER3N3kzS0c3WkxWY0s5eWgzemdCSUJE?=
 =?utf-8?B?eVJyeFdJT2RncXFJWko4VkZmL1FlWUp0VmpraXZEWXBUeTZPL3lEM3RYSVJv?=
 =?utf-8?B?emhqVDNKM0RjZUtMdGRzNlFEcnF6NTl1MjdnVkFOdWJOREpTSmJ1Z2kwcVhh?=
 =?utf-8?B?U1pHcnhkL3JQZTRaanZOMlJ4QXV5U1BFbi9jZXNheUEwdDVxbXp4U1B1NERR?=
 =?utf-8?B?VGJkWHU3ejBUSER0ZEhDOFJKZFRWY1l4QThDb2NZZTJGVjY0UXFjM2wybkxx?=
 =?utf-8?B?a2RiU01wZEVEU1MyWWRKcDRXRU4xSU91Y1FpN1R0bURBdTVIei9NYTZvYkhW?=
 =?utf-8?B?ZURLVVJCUWppY2NvSEYzU051clpTc09kM1F2MmZUeVg1eGlWSy91T1YwK3BG?=
 =?utf-8?B?K2dQcmplK1B0cU8vdnV5Z20yaVN1OUUwSnQzRVo1c1dTRW1VcFl4azJPNFF6?=
 =?utf-8?B?eTRnSXdFV3daVFJoa3FheUF3OW1qQk1tQW9lOTN5MThqZzh4L2ZRY0dPQUJU?=
 =?utf-8?B?OUFxcFFIdDBXaUxoWnRSQmN2US9tV2poOHA4aTBGOWRYY1dKMk5pNXdYTGxC?=
 =?utf-8?B?Z08rV3JPemF0NFBYbktBcjlzUGlWcFJUZjVBcGtyWW04dGwxbFBKOTkvRVlJ?=
 =?utf-8?B?K3B0ellGNkVmTDY0aUtLZDFQUUUzckRzQ3lTVlNndmY0YktIS0lKMzdsaDBD?=
 =?utf-8?B?YzBpVS9ZWVR1ZEpkZjR1cjV1eTRLN2FzZ000TTBxUEMyV0xVczhFM05CMVZE?=
 =?utf-8?B?L0lqNThkVHljSUU1QkVRTUwreDJ3bHBUL0t6eFlrOENCalAzcHhpQ0RiYmFO?=
 =?utf-8?B?bVdTd1VpSGJIdjliMnRkRlJhaTY2WURnWXZUWHBPQUpTaWJHZmt5Q09rOERL?=
 =?utf-8?B?VmU1SlR1VmRpdW4yZXR5ektmQUdRWGdCWk1LL3FHdUtGUHp4cnhWNkt6Q0FF?=
 =?utf-8?B?My9KVDB5RnFmQnEyMFpjcXoyZ09DbTdNOTN3MVZzMGVKcWRUdllPejJiVWdx?=
 =?utf-8?B?Y3h6d0VhOTV0TkdjRkxsazc0VTZjNXJ0QldUOFVCY1k4R2VNQk5kVjdPUWhj?=
 =?utf-8?B?SmQ5aDNXanBPcXZHanpITGE0Q1NFUkZxVW4xZUFzckN6RjBvK3lNV3hBVmtl?=
 =?utf-8?B?OHVFV1BXdWNZTWNwVlkzNDdHT0JvUVJBWHkyMnNaNTBDeXRjQUVmMW9RTlRn?=
 =?utf-8?B?YzFSRUdZSWZNd0tJbzVGNjExS25GT1JTMTZNTzhqOTRpMXI0bEUyTVVQT2JN?=
 =?utf-8?B?TWRiSWxTcGRYUWxsc1MrTUxBMStCQUZlNEx2U0k2TnVaejhZQnUxb2F6Qis1?=
 =?utf-8?B?aGZ3OVVmUDllZitVc1ZKNzdpN1pDVkdNQk1BNkFncDM5RjFxb1F4cEh3c3FT?=
 =?utf-8?B?ZmlWNDg1OVQ4a29hSUFPQTh5Zjk1OXpuTitCUDVwb2JjQkV0c0Y5R0dQTEUx?=
 =?utf-8?B?ZEZva2V6ZFQ5U25oUTFRQ2REOC8rRGFRQlpqaS9wMWZNMnZKTXZSZ0NmU3Z0?=
 =?utf-8?Q?q9e5fFHFyF5XMvQEqAnGtFDDK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05828a7e-0eb4-4acf-8505-08dc1e876920
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:56:51.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYmx7igqOwLxbq0UxViygqwwNcfwi90w1Rg4k8ZRJQX9agaHAD0plfQcp+zmvUpnhB3aTamxxrLA3QyyfhV/mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127

On 1/26/2024 02:08, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> With this new sysfs entry `cpb_boost`created, user can change CPU boost
> state dynamically under `active` and `passive` modes.

What about guided mode?

> And the highest perf and frequency will also be updated as the boost
> state changing.
> 
> 0: check current boost state
> cat /sys/devices/system/cpu/amd_pstate/cpb_boost
> 
> 1: disable CPU boost
> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> 2: enable CPU boost
> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 97 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 0dc9124140d4..b37bea7440b9 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1036,6 +1036,101 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>   	return ret < 0 ? ret : count;
>   }
>   
> +static int amd_cpu_boost_update(struct amd_cpudata *cpudata, u32 on)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpudata->cpu);
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u32 highest_perf, nominal_perf;
> +	int ret;
> +
> +	if (!policy)
> +		return -ENODATA;
> +
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(7, 0);

I think it's better to use the macro AMD_CPPC_MAX_PERF in this case.
The less magic masks in the code, the easier it is to follow.

> +		value |= on ? highest_perf : nominal_perf;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +
> +	} else {
> +		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (on)
> +		policy->cpuinfo.max_freq = cpudata->max_freq;
> +	else
> +		policy->cpuinfo.max_freq = cpudata->nominal_freq;
> +
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	if (cppc_state == AMD_PSTATE_PASSIVE) {
> +		ret = freq_qos_update_request(&cpudata->req[1],
> +				      policy->cpuinfo.max_freq);
> +	}
> +
> +	cpufreq_cpu_release(policy);
> +
> +	return ret;
> +}
> +
> +static ssize_t cpb_boost_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", global.cpb_boost);
> +}
> +
> +static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	bool new_state;
> +	ssize_t ret;
> +	int cpu;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	if (!global.cpb_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)
> +		return -EINVAL;
> +
> +	global.cpb_boost = !!new_state;
> +
> +	for_each_possible_cpu(cpu) {
> +
> +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +		struct amd_cpudata *cpudata = policy->driver_data;
> +
> +		if (!cpudata) {
> +			pr_err("cpudata is NULL\n");
> +			ret = -ENODATA;
> +			cpufreq_cpu_put(policy);
> +			goto err_exit;
> +		}
> +
> +		amd_cpu_boost_update(cpudata, global.cpb_boost);
> +		refresh_frequency_limits(policy);
> +		cpufreq_cpu_put(policy);
> +	}
> +
> +err_exit:
> +	mutex_unlock(&amd_pstate_driver_lock);
> +	return ret < 0 ? ret : count;
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1043,6 +1138,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
> +static DEVICE_ATTR_RW(cpb_boost);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -1062,6 +1158,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
> +	&dev_attr_cpb_boost.attr,
>   	NULL
>   };
>   


