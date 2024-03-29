Return-Path: <linux-kernel+bounces-124347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0059089160A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614B31F21CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174384AEFE;
	Fri, 29 Mar 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GM4jxjMv"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2092.outbound.protection.outlook.com [40.107.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D9E40874;
	Fri, 29 Mar 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704573; cv=fail; b=tR6rVHcYZSy5qatzHqjHNAQHXSO0eHzaMx1zMN2QmZWE5AZ1Ql2xFQmI8wgdppkeP0/hXgmWnmDrmi3yYSYNXM2gaoo7OuU7YD7So7s4vR5zr5Ppfp/APiN5c9BLuNjQ7/zIg7I5TXoDImp7JWDzDX2lQSa3pgFXydrkZu5u4Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704573; c=relaxed/simple;
	bh=+iUfu+/XlkXzA6SNZX+i2WxSUua/GDIVV168XPdzsU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TyYjRDUDpPIajjG4lq1SeTufSA0G7kkLUnk3O0bBxNhUem4DRBEYwAV++UypZC7ygCf7mxWAq2a32CWiYWEJZcjwJeLbUXFnfpPzhTDOd8C05tEbHyhzPh8kpTb195FwRdz1zfwbGnHnlvHis8hpfP3sCIoyx0RMKx7E6V6qkoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GM4jxjMv; arc=fail smtp.client-ip=40.107.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgQFhU3vD9s8qvViH0+0Xkia9INkov3q6fmCfh0nE7VfpHB3nOEDWg5ihrm9+9HctdVZWYAIYSUZcPdmwzG25hPZ2EeSy0psbubf4YEAONDO9E5URh25f8OquC8sv1U8msIrMXgbScYSNMqhqqGFyroerHy25MZMQoddxbWgV0MRqIi97m+O6JNQDe4Z+UhxQ75svPH7cV1LYWytBQEF8PEwN8JDFLo4rJfCPWCyuLNl3DBMOe1x3zFK86NvDLYSqoVnD1Xdou26fEZ2vXoRLuevZLJqDhJq2Phw1MiFXsQ76g7QuQLCUAJeVODcJ+xk7gQFv+uj7kf1FRvfK11xUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYe12/vj6AlXhFAxV2ndsQUrdHqySXc1sA4DYtyOE6E=;
 b=dQwkB/iwuJJSgENv/fm1EjayVGKG2kA6PFCLqE2v6mE8dfmreGZs/QkGXs606enSJNwQJoptDaS7JEyT375RSI3OxSNDfrqtmd9FKzSwbLtXF13rw7nV2rCKmU2ZERNsxrnDoTWbiu2sOrJ/UavWZ1Djud2W7UCfxLEL9c4gWX4MDtl4J2quG2Adl8wcVw0O4vEY3lByc2yqbe167pfKf46d0LdnU01FpKYAzBl4Kx1ERiq4N3ggmONncUr/Iy4q4ROPJQ166brUfw9UkLhWfDupiyD8/OJz6tFVg7yl7ontIZ9WGVaeTf6GWy81S8KIv1Aduk6HqorSv7+JA7QbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYe12/vj6AlXhFAxV2ndsQUrdHqySXc1sA4DYtyOE6E=;
 b=GM4jxjMvSTS2VwkmWp92s7jFEIWUiQniM8rwFE4xkhcgwA+iCknU+WRsD9Vyd7SdyuPxs2vWvfOD157XdzJSw+ElKqZYjQpjJFXdJO4P04s7qigFfGZkS8YI9XV+7+kTgfsaOSLgJMNafKsjM4QBeaA7IwOTk8/tx049fxJnjmY=
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 09:29:29 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2716:d557:4236:8f0f]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2716:d557:4236:8f0f%6]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 09:29:29 +0000
Message-ID: <e6a59310-a3de-4ba8-96b2-dd123069d0ad@amd.com>
Date: Fri, 29 Mar 2024 14:59:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/x86/amd: support capturing LBR from software
 events
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
 song@kernel.org, kernel-team@meta.com, x86@kernel.org, peterz@infradead.org,
 mingo@redhat.com, tglx@linutronix.de
References: <20240328133359.731818-1-andrii@kernel.org>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20240328133359.731818-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH0PR12MB7838:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y7t3RDfWrYlyX9BySVbo8Y5aLXxTXBOO9Mv5F/0WX1X9Ptt2KMbhniTgn+6Cfd48BpGXvG4avBmPaZuCZsvSHuRWIrmOUST05oL60XgTBKkoKq153IAwYHByxoJYUTVRCrBts5Az1U0UTZ9oQGuNQeJS/soWwswqXpPlbLIsVm/Z85CISjP1YwNPNUAKBvzyRz3+AVwHyGvCey1NKvQbP8P6rgoiuxNj+vwXK65Er2eONCNpQZxY8cblRk9PqSk8mSfDDcRvyV8U91SmTa4ubmHqZ9CpO0ZNS4rBUbYiNMleXOGmu/TApDJ7rCSqcs9Fv/jYZTZHO04s7r8kgBW1Yr76MR1xtrvee/sC0WUm/8dQj4+Y5cYmkteT1mOezG25h/4nH+i05RCiEfzKPuuoOdBXxdIXPS+bA7YphFB/OtRazqD7HtrZvrYeLx2k+4UBiUKIT7Eswq5L5snjrjCC7NJ/bGj5Yt1j8OGtyoj0Ed5qI/ExGzGD8uEA671wbI+XU8ZD7QsLZ3TD/+AAqaYzVguGzOpr/nxubVOjpUrDWg0N9xN3Fu/6ndWSSS4OKZFicItsN5kmDi7rx3g1qtkpbD1reS5nr+8q33omhwoOBImJXkiOxYINOSCFOaHggeSA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHZZai9kc0h4eUZBTDI4RE03YXpldEIrblJ0TUxjOUhNWWNuT1pNWXduR1Vk?=
 =?utf-8?B?c2lsL3RaVjRDL0NlZlpKTnhKRkxUM3JvY3RqblZYV3RtdVlDSTdDbGMrZ0hH?=
 =?utf-8?B?Qm9DLytqRTFLYUhJRXNOc1crMXNRVEVadUpRV3daejFjNitaY1o0MXhQSCt0?=
 =?utf-8?B?Ylk5SGdQa2N3V1l0V0xxK1Z4Ulh0VmhMa2p6T2JpVlhHVXRGeGRwaTdlUjNC?=
 =?utf-8?B?R1I4dWg5YjdrRGxnYVVGc2VIZytlSmR0VlZTUnlGVXlrZnBqUVAzSFFWSjlE?=
 =?utf-8?B?emZrcWJnQXBzTExGc25xa1dSVDUxZFRtTHo1NlBxUU9aMWNIcXUxc2lkMVZp?=
 =?utf-8?B?SWIwd2ZzYmw4bmF2N0hJcTRybksydUI2V1JXTEZJYVZzRElYYkdNdXlUVmd4?=
 =?utf-8?B?dUxFaHdsTHhEQ3Zhd0xqd1Jhbjk5NWdJd3o0NmsrMVREM2dDaENZaEVleTF0?=
 =?utf-8?B?Tlc4cWQ1WG1UUDB2eG1qZWkxaCtRQmtxamRkQlpHZnF2dlRmMDAxbkJxeG1o?=
 =?utf-8?B?aWg3TkNBa3pROVV3Rzl0QWtiVEhFQUxjRS9pZGdwTmFwcFpiOTZoQ3hicWNm?=
 =?utf-8?B?azlpOWxKVnJhdWNZSmdsYi9QY2hpZjJ6QVN3Z2YrT2RvUExtUjNENEFWVFZa?=
 =?utf-8?B?d0V6SlhZbzQ4K2oxb05TbjVjcmlta0ZMUytqUXZzNzMyYWU2RXNnRTRwb2Vs?=
 =?utf-8?B?T3FlMXZGYm40Q1dLWFZPOGRHL1Iwdm1FMnBOMVkxQWxaZnpybEtOL1QwVHp1?=
 =?utf-8?B?dDkrYXlTM3hYWmtvL2Jtc3BwUU80blIza0VoR2hodmhGdE1uT1p3V1R0Z00z?=
 =?utf-8?B?eXBXNlltZitPVzhaMi9QdEt2R2dpNFMzV3BKamVDR09mN2pQeDVmNytVNnNj?=
 =?utf-8?B?aVBLUGFleEZERVBuU2E1cTNtS3hEUTRCN3FuZ1BhT2ZhZFN3Vk9md1htdVg0?=
 =?utf-8?B?eFRFdEw0NEJaUGRhcUpYREx4QVJ5SktTSnc5VFYxT0NVUEhBTDlMS2ZXdUEr?=
 =?utf-8?B?dEllKzQyU0t2YlJVSzZiQTlhb0FUSC9jOE9kQ1Qzd2NOUHdoQ29Ca2kyRWwz?=
 =?utf-8?B?S2I4dnE2Q2RyRHczVTFodUlMb0FsOVFiYTY0NVpwRlcwWXFIdW1KWVg1akN3?=
 =?utf-8?B?RDIwUWpYMUFLb0FuRUhCQWRNRVpDSzJFS3JMVHBDei8zQmphS0JYdGxHZHpm?=
 =?utf-8?B?N3BEY3h0OFZsY1BNZHZBWlVYQThIemd2NXpMT1VlVGNVT1VWNG9NWGFvU3BI?=
 =?utf-8?B?Wml4TUs0cHVrS2xxTHBwOHEvLzFqdGNyWmgzRGkwN1I2dENrRVNvQU80VGlq?=
 =?utf-8?B?TEJENENoSnN2NldVc1FxeDVUN05Bb3k3MEd2WWVPQW9jMDkzMXllKzQxNkJn?=
 =?utf-8?B?TENLUkZYMmx4eUtSbFJQMFJKTkE2N3pYL1NiUVQ3MkRya041dGJicG5Hc1hY?=
 =?utf-8?B?ZDhNZGlkVkZpYnYxSVVwemJhSTZsZy9WbllSaldZNEg3SEhwZ3E2bEZsZE9L?=
 =?utf-8?B?OERMaWRLajFxNCtaa1lCR1NNaUxnYzRFQXZsNk5kSFdiY1pHalRHTTB3ZEZk?=
 =?utf-8?B?MXVXd3R2SC9vaVRUSG5iY3RnaWNTYTBBNWJnTWhvV1ZKSEtPSWdoOEY1ZnVD?=
 =?utf-8?B?dFBVL1YzaDE4THVJcFpqdEszVy8zVk9UakRZYWRlQVpxSStMclV2Q3Qvb1dk?=
 =?utf-8?B?STMrOENPUkYwb0FXbEd0eEhBVEQ2T3hjTkVqT2xWbDlPaGlETFVJa3pHWXRY?=
 =?utf-8?B?OHM2U2xiY05saDRhV0thOFpTZFREQVR4bGI2OWV5cVdjcVpNVnJmNWhBOFFj?=
 =?utf-8?B?N3paTGt0ejFhcWdlRTBqVUlKYVJqZVZiYWYzdUI1R1U5YkllZ3k0cnRERDY0?=
 =?utf-8?B?aWRFKzJjU1d0Ti9EM3lFbnVyM29tT0FJY3ZFdDJtY2JmR2ZsRFVIUFN2dkpu?=
 =?utf-8?B?V0NkcVhJL0pXaThaTHFUaUpscE1TTmJ0dzdsdHJEMWRnRitvdEh4YWxJQStt?=
 =?utf-8?B?ZFlCT2p6K1dHVWt4RzdEQ3RsSjYvZ0J6TGtmUDJTZ0FaK0NUUDdqdEptTHhp?=
 =?utf-8?B?UXluUVNFZDJiMnZWai9iYTNLckRVT0NQTFhJWElwUDV3b0oxZ3dEOXV3djM0?=
 =?utf-8?Q?/nYVt8ANm2sosZ+BJawdMQP5R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b41cc03-89eb-443c-6086-08dc4fd2bbd5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 09:29:29.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IHh9Q2wdkp4r8XgDjlnqA9+6nk02S+rBtYppBJQ2m171hJSX9CVFDU6vi0UpZzLS1VQEHeqaRI9ZBGemhoXoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838

On 3/28/2024 7:03 PM, Andrii Nakryiko wrote:
> [0] added ability to capture LBR (Last Branch Records) on Intel CPUs
> from inside BPF program at pretty much any arbitrary point. This is
> extremely useful capability that allows to figure out otherwise
> hard-to-debug problems, because LBR is now available based on some
> application-defined conditions, not just hardware-supported events.
> 
> retsnoop ([1]) is one such tool that takes a huge advantage of this
> functionality and has proved to be an extremely useful tool in
> practice.
> 
> Now, AMD Zen4 CPUs got support for similar LBR functionality, but
> necessary wiring inside the kernel is not yet setup. This patch seeks to
> rectify this and follows a similar approach to the original patch [0]
> for Intel CPUs.
> 
> Given LBR can be set up to capture any indirect jumps, it's critical to
> minimize indirect jumps on the way to requesting LBR from BPF program,
> so we split amd_pmu_lbr_disable_all() into a wrapper with some generic
> conditions vs always-inlined __amd_pmu_lbr_disable() called directly
> from BPF subsystem (through perf_snapshot_branch_stack static call).
> 
> Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
> point, there is no reason to artificially limit this feature to sampling
> events. So corresponding check is removed. AFAIU, there is no
> correctness implications of doing this (and it was possible to bypass
> this check by just setting perf_event's sample_period to 1 anyways, so
> it doesn't guard all that much).
> 
> This was tested on AMD Bergamo CPU and worked well when utilized from
> the aforementioned retsnoop tool.
> 
>   [0] https://lore.kernel.org/bpf/20210910183352.3151445-2-songliubraving@fb.com/
>   [1] https://github.com/anakryiko/retsnoop
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Changes look good to me.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

> ---
>  arch/x86/events/amd/core.c   | 29 ++++++++++++++++++++++++++++-
>  arch/x86/events/amd/lbr.c    | 11 +----------
>  arch/x86/events/perf_event.h | 11 +++++++++++
>  3 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index aec16e581f5b..88f6d0701342 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -618,7 +618,7 @@ static void amd_pmu_cpu_dead(int cpu)
>  	}
>  }
>  
> -static inline void amd_pmu_set_global_ctl(u64 ctl)
> +static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
>  {
>  	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
>  }
> @@ -878,6 +878,29 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
>  	return amd_pmu_adjust_nmi_window(handled);
>  }
>  
> +static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> +{
> +	struct cpu_hw_events *cpuc;
> +	unsigned long flags;
> +
> +	/* must not have branches... */
> +	local_irq_save(flags);
> +	amd_pmu_core_disable_all();
> +	__amd_pmu_lbr_disable();
> +	/*            ... until here */
> +
> +	cpuc = this_cpu_ptr(&cpu_hw_events);
> +
> +	amd_pmu_lbr_read();
> +	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> +	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
> +
> +	amd_pmu_v2_enable_all(0);
> +	local_irq_restore(flags);
> +
> +	return cnt;
> +}
> +
>  static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> @@ -1414,6 +1437,10 @@ static int __init amd_core_pmu_init(void)
>  		static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_reset);
>  		static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
>  		static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
> +
> +		/* only support branch_stack snapshot on perfmon v2 */
> +		if (x86_pmu.handle_irq == amd_pmu_v2_handle_irq)
> +			static_call_update(perf_snapshot_branch_stack, amd_pmu_v2_snapshot_branch_stack);
>  	} else if (!amd_brs_init()) {
>  		/*
>  		 * BRS requires special event constraints and flushing on ctxsw.
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index 4a1e600314d5..75920f895d67 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -310,10 +310,6 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
>  {
>  	int ret = 0;
>  
> -	/* LBR is not recommended in counting mode */
> -	if (!is_sampling_event(event))
> -		return -EINVAL;
> -
>  	ret = amd_pmu_lbr_setup_filter(event);
>  	if (!ret)
>  		event->attach_state |= PERF_ATTACH_SCHED_CB;
> @@ -412,16 +408,11 @@ void amd_pmu_lbr_enable_all(void)
>  void amd_pmu_lbr_disable_all(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	u64 dbg_ctl, dbg_extn_cfg;
>  
>  	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
>  		return;
>  
> -	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> -	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> -
> -	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
> -	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
> +	__amd_pmu_lbr_disable();
>  }
>  
>  __init int amd_pmu_lbr_init(void)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fb56518356ec..4dddf0a7e81e 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1329,6 +1329,17 @@ void amd_pmu_lbr_enable_all(void);
>  void amd_pmu_lbr_disable_all(void);
>  int amd_pmu_lbr_hw_config(struct perf_event *event);
>  
> +static __always_inline void __amd_pmu_lbr_disable(void)
> +{
> +	u64 dbg_ctl, dbg_extn_cfg;
> +
> +	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> +	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> +
> +	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
> +	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
> +}
> +
>  #ifdef CONFIG_PERF_EVENTS_AMD_BRS
>  
>  #define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */


