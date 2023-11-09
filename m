Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35177E731E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjKIUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjKIUwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:52:13 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE36468B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:52:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVRSzY6hGA0BklRogxGWmnN9N+t5LgZrUsEF8Tu97j/GjturHtgUwdXS2e1psRQSw7oXOMcTrTMEtp5QbVWl1RRdjNuCf16z5kTGhlA0lR7Rjw24xX6IEfIFLcRmMj5Uub9hw2tiZhO1mkAOhVvi6DeJa5VjfiW+zU/nEoFVg7RGmHerm7Kz7JCUu7zIZR64hL2he+4lRF09N+7/UEddDiFUHidxhAmYqFyv3frvE+HzIurN2MN8fotarD3OONUFZdmkoGBq/IvJY1PL8qRZPv8zPALnNftc51GJzV1UQO42YyjGeWmn7ynyyq9mQOcb0zbswpMlvWFttXVcIoH92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiWXuDDj0KiOt9XkOhOxWBXe8u5Ax6mgy2SFYqsZ2/Q=;
 b=Xu6Zb0stPQIxhMKNK3oLtoVJxSJb0pKio7BG44Az/B/mBf5rHRBss6yYF//tShtHe5YJo+mF1UV333VyHp6M9PkZF18baAsUay3KUugGb84Bt1O6adc2orthT8V28BQ1cMWlA+gdT6sSoXgV00Y+6KTMIBmpzkNavzPx4TaJtklu9GivpUXL2KOEedKSQKYAOL+dA4Jh73HrEJDcBVdhPjSdwKF+WyD1UO6Kwr0CwzuT+j1Lcup2IfPL7+uy1/yxRUO9m+UhwLIH3SOE0QfckslDWDe8vG38EW2is8OLcqI0tNCqN1wFTHvVvVvcUYF0IC6Rv6JWl2Ubsk8HEQ/Hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiWXuDDj0KiOt9XkOhOxWBXe8u5Ax6mgy2SFYqsZ2/Q=;
 b=b1buD2pvPTNSFVOqBNM6nKO+oEPvNTIle8n8dZGfAwceuaRDtMjoMeJoUQuMdlXzteKhj0iVdd+nmi4CEewN5lmA4GDzhGjYXEdoBM6SkCxJwZ5njNeGC2IXq473Gwk9RkM5/cCQ8iirf9I9g40EgsiXkt7yKYJzzRrcuNj2nms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:52:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:52:08 +0000
Message-ID: <0d70d735-a4ba-4bc0-8f3d-24e31c870566@amd.com>
Date:   Thu, 9 Nov 2023 14:52:06 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 22/24] x86/resctrl: Add CPU offline callback for
 resctrl work
Reply-To: babu.moger@amd.com
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-23-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-23-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0090.namprd12.prod.outlook.com
 (2603:10b6:802:21::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: ec784f85-e4b8-450f-d422-08dbe165bcd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9KyXIeC+X0ruxsRT7mQJ7+g9Eq/c1U7NzRUngGCjyXVkkYxNt5D3I1uXhJpcDLOi7oI1xvKaKDh9fq+5QMrctPuEZTPPqdLyK33Dxdtz133TEh0SK2A1B2JMwGYg97gBBhTQfNYilxYC6kt+nJK+C8iWP1/ryc1fj70aSigKtyVjZeSHWbZFClwN3L/EPsr+QLf7/Ch57QCqwk0owcpEqP498Po1UrGmy4GgJe+CD2ahnlxvi8gY4Q+aQ7o4wgc0GdE/gHJYXn2kj6kIeJOPZqmC286658T8VsopCGd3dW6Y+c7SPnvrIO7MRd2cTeUTaDKULKeenQwmmlM7Cu1LlTEKIgoxXWMOhzZt7Fexyd5Y0PZvEuARwsKgjRCn6kNaEVIrSsJ3FRTjuVftlY5HK3DLLVI5X+GccbxzUOLhb7WraRO393iJEaL4RXkzEyKwy/GL/pL6ZGo6IQvvn9yOEwI6R3h+0LgnjWbfo2F+nmdiYtqAX8B4D9iu2bp9MtkHl8yKymHhVE/5C1VBaiAgfycr0IYiB2vF+8y+vKKfsQzlGtbAhsJjKz6unx6yfbybcAT6faxWj92V2ED1xPfTQ2FX7qs2xDV25FD12Fxl0yhdkxTXYUDPPH5I3wHiZ9lwbflZuu49f1+1nA9qS6YFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66556008)(66476007)(54906003)(66946007)(53546011)(31696002)(26005)(36756003)(2616005)(6512007)(316002)(38100700002)(83380400001)(6506007)(86362001)(6486002)(478600001)(4326008)(2906002)(8676002)(8936002)(41300700001)(5660300002)(7416002)(3450700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZhOHo1K2QxcjBVUTRzOVVCRk55aGszNW9ZNFpMb3IwbkFKbUJqWGVaL1VV?=
 =?utf-8?B?ZW1zRWJEM3FFdXpackNlNWZiTWJmblBaMm9RL2pKU1ZyREF3eENyWXNnSFBY?=
 =?utf-8?B?c0FQRTB5L081NDdqWUR3Q0JnTFlsdUw5eW44MTBmdXFhdzF1WG1XTXJYcFY0?=
 =?utf-8?B?SGRBaFJBdE01T3JYQk1USThuYzlqbDV1YUQyM1p2d1lwdVh1TnU4WVBUckZo?=
 =?utf-8?B?R0djUnpSdHdLcEMraEhVZnc3UndIVHhBekpQMy9HRUhxNklTWVlXcmFQWC8z?=
 =?utf-8?B?K0kxTkkwWDVPeXJXdUYzRVovTUw5WU9xVFBkcG02TUZRU1pVYWlFQmQvcGtY?=
 =?utf-8?B?RmdIS0k5UzQyYXBpMVl6a0I1OHM1S0xNK3hzTGpPV1MyZC85dUx0S3pZRE1J?=
 =?utf-8?B?L1AvUWFua21ZaUdHZGVaU3g1YjhyclpLVmtsOXZGYXlaZnFFSWw0VDhLYjV1?=
 =?utf-8?B?bzFud2pwTDlqSWliV1FvVVhNSHc5VWZkMXRETHc3MktodmtDYkY3ZUR2SDlV?=
 =?utf-8?B?T0JVVjJxSTI4MytWVzFwT0hQbUx5cHNCWXE0M3VyWUYzWTBjMUZEREJESmJr?=
 =?utf-8?B?SjNjWEdHbzltdEtwQW52Sll2ME1laEJhYzdnUTFkd3hFakp2RWJ1K2JoR3dD?=
 =?utf-8?B?Sm11WnRBcXZZbkh0TkJodEkzZ2V1UWQ5S3NDeTdrM2pCbFBRWFNWNDV4RG1S?=
 =?utf-8?B?Z3BGTXc5UkV2UlJoYnZoNk02bjc3QXQzR0oxbFNJcWFtZnp6ZDFJc2VvSlQv?=
 =?utf-8?B?ZC9IS0VJZzZEUFBjYmFLb2JMNjZWajY2OGVPYUJ3M0E0MzdUS290Sjg3USt5?=
 =?utf-8?B?TWRQM0pRVm1NWDZ6bjdwdzFoQStmbXFlZ28rV2sxNHBGMjkyVjZuYktrakha?=
 =?utf-8?B?NkRTU2xUeFlWS2JCVk5WQlQrOE5NbHVuUnJPWEV5OTV1em5ERUpVdGVtMGNo?=
 =?utf-8?B?cXdHWmUzbU5RQVEyZGpVdGtmc3llbEZZWE05NzN3RnoxWWNYVFhkU0FITnln?=
 =?utf-8?B?cW1xNjdoUzFzTEMxSWZuRitZK09wb0NsRG5qK3MyQmdzeG9JSEY4elZ1QzdU?=
 =?utf-8?B?dGRlaHpYYmlHVWUyemllVDNpZ1JPRnlYN01MNEhBREdOK2lVdDNZT21OSFh5?=
 =?utf-8?B?cy9aUzZ5ZnFVZ0RoY3pFMVJNYnU5QU5ydHVWWTB6cWVubHpZdVplaFlLajly?=
 =?utf-8?B?Tjk3R0EwY3dQbGJIa2pvZVV2N1V2WHc4a1gweTFQYUo5Njhsam53ajVtdVNo?=
 =?utf-8?B?WjRXblJoa1huT1h0cytHcHBGQUdJSjV5azRCN0JUVGNiNEs1VGp2WGZuTXVy?=
 =?utf-8?B?Y0VqZHFoZU81ajk1K2k4ck5QblJzRnVhYU93a2lUbUJsUlV1VnA3UHBtKys4?=
 =?utf-8?B?YTdydUsxVjAwSkVpYzQ3a2xwbGlJdmMzeG1xY3VkZEN4aXBUTGZXUWlva0hY?=
 =?utf-8?B?NVBWSU1QQ1VXRGZlUU83ZzRLc0NpYlQ5MElERkJGSFBUR0NiU1JmRlpqclc5?=
 =?utf-8?B?NHJjOFBRNzVEV1JvempNcVFDVXIwVXNJRnhzYzBxY3ArUDhMT3Y5aGgxVUpt?=
 =?utf-8?B?aHFyMWJnTXRiYTllaXVLditzazA4Z1poMjgzNnpEaHFRYk1DUmtQTkhZVzdz?=
 =?utf-8?B?akJYcGRwNnFYRHBkTnVrWHRCTW05d3Q4c1dha2p0dVBvQ1R0YzIrR21NN1hU?=
 =?utf-8?B?K29lcWc3RS9iTVBBck1wcTFvTG1nZjVBVHRleDJETEg2RThlQmZjenVMQ3Rq?=
 =?utf-8?B?czgxU3QwWkFBVlkrangrU1JGRitudXAxUXRYamNPeFNuait0ajJaa3BmSGVE?=
 =?utf-8?B?bzVkM0ZpeEE0WHBtYjlwUVVubUk3SktlQ1g4cXJ2MnJjYU1DTnRpZy90U2hr?=
 =?utf-8?B?QXpFVEJ0eXByLzZ0dDdDaFpseGNIL1czN2ZucTlBWnFXaWFJU0svRmxvTGZE?=
 =?utf-8?B?NmdKWndsenRLeW9FL2djclpQUFVPcGRnTjlKaGlYZ2ZZQWRRTlR3N2J5dEZO?=
 =?utf-8?B?cGRqV253NWViV0p4R0JBbnN4dUtVYWFGblVsYzlveVc4YmRHc3UrNit2bEdh?=
 =?utf-8?B?a3RSZ0lwS2NNb0Y2SFRvTkM1ZCs3Q1pQSDluUW82bWFMQTRBMlZrY2pOdDU4?=
 =?utf-8?Q?KkGA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec784f85-e4b8-450f-d422-08dbe165bcd8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:52:08.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfAdBqX++b0g3mrwRDiaQZ4zn2Gt36FbLp8bqDdA/gdHhohROOTZt3YhqkQYjCKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 13:03, James Morse wrote:
> The resctrl architecture specific code may need to free a domain when
> a CPU goes offline, it also needs to reset the CPUs PQR_ASSOC register.
> Amongst other things, the resctrl filesystem code needs to clear this
> CPU from the cpu_mask of any control and monitor groups.
> 
> Currently this is all done in core.c and called from
> resctrl_offline_cpu(), making the split between architecture and
> filesystem code unclear.
> 
> Move the filesystem work to remove the CPU from the control and monitor
> groups into a filesystem helper called resctrl_offline_cpu(), and rename
> the one in core.c resctrl_arch_offline_cpu().
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> No changes since v6
> 
>  arch/x86/kernel/cpu/resctrl/core.c     | 25 +++++--------------------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 24 ++++++++++++++++++++++++
>  include/linux/resctrl.h                |  1 +
>  3 files changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 7e44f2c40897..7d09b8d7c653 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -627,31 +627,15 @@ static int resctrl_arch_online_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
> +static int resctrl_arch_offline_cpu(unsigned int cpu)
>  {
> -	struct rdtgroup *cr;
> -
> -	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
> -		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask)) {
> -			break;
> -		}
> -	}
> -}
> -
> -static int resctrl_offline_cpu(unsigned int cpu)
> -{
> -	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
>  
>  	mutex_lock(&rdtgroup_mutex);
> +	resctrl_offline_cpu(cpu);
> +
>  	for_each_capable_rdt_resource(r)
>  		domain_remove_cpu(cpu, r);
> -	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> -		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
> -			clear_childcpus(rdtgrp, cpu);
> -			break;
> -		}
> -	}
>  	clear_closid_rmid(cpu);
>  	mutex_unlock(&rdtgroup_mutex);
>  
> @@ -973,7 +957,8 @@ static int __init resctrl_late_init(void)
>  
>  	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  				  "x86/resctrl/cat:online:",
> -				  resctrl_arch_online_cpu, resctrl_offline_cpu);
> +				  resctrl_arch_online_cpu,
> +				  resctrl_arch_offline_cpu);
>  	if (state < 0)
>  		return state;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e22e0f6adeb3..971a8397e243 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4022,6 +4022,30 @@ void resctrl_online_cpu(unsigned int cpu)
>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>  }
>  
> +static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
> +{
> +	struct rdtgroup *cr;
> +
> +	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
> +		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask))
> +			break;
> +	}
> +}
> +
> +void resctrl_offline_cpu(unsigned int cpu)
> +{
> +	struct rdtgroup *rdtgrp;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> +		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
> +			clear_childcpus(rdtgrp, cpu);
> +			break;
> +		}
> +	}
> +}
> +
>  /*
>   * rdtgroup_init - rdtgroup initialization
>   *
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index ccbbbe5d18d3..270ff1d5c051 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -226,6 +226,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
>  void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>  void resctrl_online_cpu(unsigned int cpu);
> +void resctrl_offline_cpu(unsigned int cpu);
>  
>  /**
>   * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid

-- 
Thanks
Babu Moger
