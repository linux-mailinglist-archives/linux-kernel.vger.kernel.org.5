Return-Path: <linux-kernel+bounces-145884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DDE8A5C52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC211C221E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF8156672;
	Mon, 15 Apr 2024 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UQBU465h"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E921DFEB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213820; cv=fail; b=Tv1/LR0l4muzkoGFdEYL2BwEHQ9fesQsHC7hxWs60ybHIahpp2tSbIotIJLLQaKQ3bThjKoXbqPFXzfy+AJ8z+IalJx/JqGp/cP17wNSvqU+871gODjrFpiJ3C2iPW2cjC/zi+6mxN6NIqPbZVzS+q+As8FHNIGoZjz9sk9Bbms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213820; c=relaxed/simple;
	bh=W5vp0HZNQQGX9xl6A9lZvV947PaDUJUoBEMGf89Y3aM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bjLSjosGBIOdpn+sG6iRnixSr5udj+nbEvc5Dq9nRTtn4gptvnzaI6hNrrHibg4LVjCMOmRpkxJZggQjwdE3dUzvVfamFyZ05EHEvSJzs+ipAiydgSHN190RCZPYKq5B+TvUugFh0GLoWkAv8jYx/WsA4JwIe8GKU1EwPqvIFH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UQBU465h; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7ksY9zR4yUarz770pYMS6nPjEDFrtQmzjoQVWwXZLpX/aEhRo5i4Q0NDrPHHXVKBAf91zUOosOkLrOdlLFn3eCoABymhQCxyzdswEeRJGH5IEXevNXDT1pwoVE8JYtVTLxLAdwMPquMfsDqf+K1Kijm40dlhkAWh2IUamHmT28tinoQABYtAv+Clkcq3YETQ0zQda7MTGfqQb3wMCZbhq7SOUsU3XaS2SOA6sJDP7NpP1ceLI6kpevUGn5yyTx4Ps64QpLbuuE2tD33jporHhbVpBbgC7WMQUO5HKvfZ8NIxXqp7sMPEWKWNE/Mo22oczZCLMPnAdioqol22rODDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ64f46rfaoXb9dU1+ziN5NLjKpZ0QmtaLC7BahR49o=;
 b=HfJ58UPPnqfsvTCBYshxPkeaifiUjeVsWH/g1AwbvGyTYAcp5PcBqqJHyGa3OjUH+VFwDpoVvQPKomI9oQtYVk6xfb1otDaSyzKSxkvMDXwJEKjz9EWW1jTR0b3qaZfei3eL102xBKJxbRMCXKvzoda6notK3gX30LCWTD9AQ6zxTG3Y1rQlCQVvwAFzKImdLp2wup5jveVxRkzl1FhoJ6ZiZVugOwfVL1U/qgAnvQtL5dAAExnnb2TogMWp87fh+vQc/SFN+cCSym5ReYOprdxZ2evQ4gqLjAUwFH+L9eZqtO3jGXkeyyxUBZ/xwjorPo0yYe4vSTyP00S1krFNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ64f46rfaoXb9dU1+ziN5NLjKpZ0QmtaLC7BahR49o=;
 b=UQBU465hssbChbDkAFXwfyrwmeZWENRFGPJQMnFsxBV2iCboNRfd9+h0KgxRh9H/vmeN6y2hiRk6CxIHNHmavVle6rDqTBoShqW1ywHV922Dby7RLYnTe+J3htz0GtcYD2btJmu/a8fDPIS9AZLb63RnQxC8hwZWS9CIfXqtY50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 20:43:29 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 20:43:29 +0000
Message-ID: <ffe13eb0-e7b8-4006-a7fd-7cdb4511cb9b@amd.com>
Date: Mon, 15 Apr 2024 15:43:25 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v1 27/31] x86/resctrl: Rename resctrl_sched_in() to begin
 resctrl_arch_
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-28-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20240321165106.31602-28-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:8:2f::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: b74cf72d-86cd-4c87-5074-08dc5d8cb507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RNZtOe9LKDVJ0qqbrysFN4Vgv5vpdPe6Zy8c71j9x0mPo0XSO++i2PtFYbrCZ7/FPwBE22OqN0VjFf8pfAjxuOi901yoiqV5Yd4wBIcFUXSN/eoKFJbJaM0b3esQ+QeZJ78Z2GSkWXO8gFDNMXN7EKn7ND4vzsffvRA/urEBEAudxoEdlsk7v8aWyMlkyHJrNqKUguKYc8rnVL8IWIX2SN1p7OsjTwvzGyz0GLYw13+wEUHgLpnRQ8XCJUv0Hhi+drAjAbeUXSpkheKetlgSAh7FJMxe8kk3CAe4MKE1NTcyd3wQT0maoNNOifUXvtat3ept2X+qqlzqFM7jg/vANfHRTyIcLDC0Iln4pKvaxQ7EESjqvGo3S3hMJXxAempl4kcNcz2deq12lG835f3l5e8x+CUH6RBdu09miNfjpdmuRn6HAG6krrcvMx1tstn8hnMU7HsB/AgofRP7f5EDhCC4V1wSfimHiy5uB+/DfRBivhh/RP/PW7AlWteKyKdnXwYEoNysn4OmGornNOwSgyGnUDwhan/GifmcUS0bFFIBMwbL20UU7+0cZcyInb21Pew2+wTvb7eWk3+58xLD56mpEskjAQURPYaN727DEjSJGNuW+pT/MlPYRc2PaTwa75SILVX7qrnG9zdQdsWjbFyqRAf/KoYOxQ8M+j33uXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGJOdWdZaHAxNDJTeGpGT2c4YkVlTUhpUjA2T0Vvd0lsdTFxTGd4ZlZUNi9k?=
 =?utf-8?B?RkZoa3VYWFplRFJYaGlVSXdWUXpWKytaZzZTZFY4RHJxUkNlL3dKQjFrNDRq?=
 =?utf-8?B?c3dvWCtsMmVrcWp3RXdydW5NREdIdjlCYStiaUtuWSt5Nit5ZmpjWFEzQkhr?=
 =?utf-8?B?ZGZnUmRvUnYwTlN2VkRrMGxiNEZXSEp0dDZlaGxTakZtMWFNNnYvNjRuQXAz?=
 =?utf-8?B?SEZvTHFXYnlvQnYyUFFzajlUanpyQnQ5Qi90cEdXbU5aS21QWklEbXlYaVRo?=
 =?utf-8?B?K0RrdnlMeGI3eGZwNkFtaEdycHZGYS91K0c1TUhML2JSd2s5Q01TREhNVTFH?=
 =?utf-8?B?ckpxdTlYM3hOa2hNZ05WQlF0REF0elAwVi9yS21tZTN3UVRmaGRCaldnbk5E?=
 =?utf-8?B?RHJ4Lzc5NE0zNm45VElGanpPa3RlbDY0QmxRajd1MTFkSmdBYzNxWmZ6c05E?=
 =?utf-8?B?OWUwbEsyc3d1bHc3cU1CZEVjbVhZakhaZUgxbFJBakZhREVROFgwdTdtbHY3?=
 =?utf-8?B?L0RmekJwUlRrb0t0enNJcHBoRGRSL2dIOW13ZkpWNkxxOGx3M20xakVuQzh0?=
 =?utf-8?B?amE0Z2UwRlM1aS9MTXI2OCtVYWJlQkZDWWtXOWdReUJWbkljcTd0eEV4T2FU?=
 =?utf-8?B?MUVGTmI1K2pzdlVUb1MzQitEQkhXMW9TaVpMSEpOSVJBNFlabE1BUzdpZ2Zp?=
 =?utf-8?B?QlVGazFmU1hvc1FET1F4dVVtaUNGZ2ExRFNCdjA1TVkyWW9vWVBVVjhRSHl2?=
 =?utf-8?B?OFNPcWFxZWx6SG1Rc0QxSXZMT2NDaDFXeG9abTltdTd4SFRjemJlMnY0a2NO?=
 =?utf-8?B?Mjhmc3p6YU5kYmRIdWJQS0NBNFMydzNDcC80MjlDZG4rTTQ0QW5zZjBudXFp?=
 =?utf-8?B?bEdaU25Xem10a0tXaDI5MG9JdjhiN1VMQjZ4NnlBTnIvNG5DamNUMllzWjhT?=
 =?utf-8?B?NStKYVBDcVpvazUrQUN2VHozcDladytOeFdmdHE2aEo4bU9RNGo1R2QvaG5S?=
 =?utf-8?B?eVBFTEJjWEYxUS9ZS0dBaXBCeldIblRzUVh0MTZNbmdZSkY2Lzd3ZXVCMW90?=
 =?utf-8?B?VHFxYVZscXdtZ0tZV3pNR1Q5QmxmYmxzL0Z5ZWcxTjROQkRmN3VhK0Z4VFF6?=
 =?utf-8?B?UmNRNGVPdVdWSHlsY0Y5VytMYkFMMTlGaWExRFhJazJiMkQvdFhNUGJpOUVG?=
 =?utf-8?B?RXQ4R0tVSlg5djFtdEZOU2U4WjloYzdtaUhhcllrLy9lRTFoQmNoWjVGeXVL?=
 =?utf-8?B?VG50UjJrZ3lvd0ZUSmJ3MWlKdmdpYkVHaCtXL3BaSnErNnpmR016ZmNhejZi?=
 =?utf-8?B?b3hNSHE4VEhLS0dpSGVPU3lRaUpOU3FhMVlXeUZkOXFEZ0FNZWhyWk1kNlBU?=
 =?utf-8?B?RC95Y2xZWnA5NnRweStnQzU1c1RTd0ZxLzhNdThIMHJaN0IyK2xuNDZKbWpi?=
 =?utf-8?B?R3RiWnFGeG9LQ0RoNGljdHdabWpZcjY2ZDYwdVlQL2pvVFI4cWxKYW1FRXhZ?=
 =?utf-8?B?QVI5dnI0bVdXMzVnQjc2U1d4NHpLQWR5ZXR0Mk5rZXFTWmhIcmRjLzVyY1N1?=
 =?utf-8?B?amNFUnVlUHJBTVNYZ1ViVE16NE5MaVBQRXhRcVNPbDAxbHNybzlpTUU1UmJu?=
 =?utf-8?B?cnZqQS9NUjI0ZTllckI4Ykl3NnR2WndMdi9TcTdndXVoa0Y1Rk5STXlUMzdn?=
 =?utf-8?B?ZDhYa1VMc3pocXJIazdKTWd6Y2NQaFZ2blFaYWxmWEQxcG5YZFhhQnVndnNW?=
 =?utf-8?B?TFhHeGlzM29zVzBRUjJ3SnVGQnh6M0tscVZGdml0eXdXK3NlZjh1WGc5TmJJ?=
 =?utf-8?B?eDVkajFqd1h5c0dDN1pyZ2k5ZjlzU1EwdXFhQnNiLzV3cCt0UjNXYU5ad3k5?=
 =?utf-8?B?NGRMaW1XTFlrR25qSEg4ZVlkZGFIUi84N2UrQXJiZU5CUUFHTXpXMmtDZE40?=
 =?utf-8?B?WGxwZEdidkdTNEJhYyt2N3FQcC9JM1ZhUlhFa3k5OXdkMmJEQlc0OUF4MWll?=
 =?utf-8?B?aWJRUGw5WGdZd1YySUkzbnVKMTJhNU1Ib2VaV3hmWjA4aUR3eHNseXlIVVlX?=
 =?utf-8?B?cFRuRG1LMnQ1TmJEVThJeWJCNDdFN1JibmdvQlJDb2VFYm5uMUo0a1VxMkJm?=
 =?utf-8?Q?s9OY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74cf72d-86cd-4c87-5074-08dc5d8cb507
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 20:43:29.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCrsXTx+bi5M1czjxZ5AYtGY7FEVoFXjp+mhH8p+vBUhCuqyERbRJA8I/IfWENal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356



On 3/21/24 11:51, James Morse wrote:
> resctrl_sched_in() loads the architecture specific CPU MSRs with the
> CLOSID and RMID values. This function was named before resctrl was
> split to have architecture specific code, and generic filesystem code.
> 
> This function is obviously architecture specific, but does not begin
> with 'resctrl_arch_', making it the odd one out in the functions an
> architecture needs to support to enable resctrl.
> 
> Rename it for concistency. This is purely cosmetic.

s/concistency/consistency

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/include/asm/resctrl.h         |  4 ++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 ++++++------
>  arch/x86/kernel/process_32.c           |  2 +-
>  arch/x86/kernel/process_64.c           |  2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 9940398e367e..491342f56811 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -177,7 +177,7 @@ static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 ignored,
>  	return READ_ONCE(tsk->rmid) == rmid;
>  }
>  
> -static inline void resctrl_sched_in(struct task_struct *tsk)
> +static inline void resctrl_arch_sched_in(struct task_struct *tsk)
>  {
>  	if (static_branch_likely(&rdt_enable_key))
>  		__resctrl_sched_in(tsk);
> @@ -220,7 +220,7 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>  
>  #else
>  
> -static inline void resctrl_sched_in(struct task_struct *tsk) {}
> +static inline void resctrl_arch_sched_in(struct task_struct *tsk) {}
>  static inline void resctrl_cpu_detect(struct cpuinfo_x86 *c) {}
>  
>  #endif /* CONFIG_X86_CPU_RESCTRL */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 085fb9c2333a..218aebd6387f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -359,7 +359,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>  }
>  
>  /*
> - * This is safe against resctrl_sched_in() called from __switch_to()
> + * This is safe against resctrl_arch_sched_in() called from __switch_to()
>   * because __switch_to() is executed with interrupts disabled. A local call
>   * from update_closid_rmid() is protected against __switch_to() because
>   * preemption is disabled.
> @@ -378,7 +378,7 @@ void resctrl_arch_sync_cpu_defaults(void *info)
>  	 * executing task might have its own closid selected. Just reuse
>  	 * the context switch code.
>  	 */
> -	resctrl_sched_in(current);
> +	resctrl_arch_sched_in(current);
>  }
>  
>  /*
> @@ -605,7 +605,7 @@ static void _update_task_closid_rmid(void *task)
>  	 * Otherwise, the MSR is updated when the task is scheduled in.
>  	 */
>  	if (task == current)
> -		resctrl_sched_in(task);
> +		resctrl_arch_sched_in(task);
>  }
>  
>  static void update_task_closid_rmid(struct task_struct *t)
> @@ -663,7 +663,7 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>  	 * Ensure the task's closid and rmid are written before determining if
>  	 * the task is current that will decide if it will be interrupted.
>  	 * This pairs with the full barrier between the rq->curr update and
> -	 * resctrl_sched_in() during context switch.
> +	 * resctrl_arch_sched_in() during context switch.
>  	 */
>  	smp_mb();
>  
> @@ -2946,8 +2946,8 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
>  			/*
>  			 * Order the closid/rmid stores above before the loads
>  			 * in task_curr(). This pairs with the full barrier
> -			 * between the rq->curr update and resctrl_sched_in()
> -			 * during context switch.
> +			 * between the rq->curr update and
> +			 * resctrl_arch_sched_in() during context switch.
>  			 */
>  			smp_mb();
>  
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 0917c7f25720..8697b02dabf1 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -211,7 +211,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	switch_fpu_finish(next_p);
>  
>  	/* Load the Intel cache allocation PQR MSR. */
> -	resctrl_sched_in(next_p);
> +	resctrl_arch_sched_in(next_p);
>  
>  	return prev_p;
>  }
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 7062b84dd467..d1cf885e8930 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -707,7 +707,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	}
>  
>  	/* Load the Intel cache allocation PQR MSR. */
> -	resctrl_sched_in(next_p);
> +	resctrl_arch_sched_in(next_p);
>  
>  	return prev_p;
>  }

-- 
Thanks
Babu Moger

