Return-Path: <linux-kernel+bounces-126929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A789448F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0481F224B1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518B74D5B0;
	Mon,  1 Apr 2024 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pT/xX9fP"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2139.outbound.protection.outlook.com [40.107.243.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64933BA3F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994232; cv=fail; b=jJbVVew2O+IOBmRA2lOxRfUWt8pzGHjHm8pMuVQ7PIf2XxITVoHB4/YaWrDZsiDdQECnmyBRm4MH/g1EaJ7YNiIo3lpo44jxJ66cO9nmLtSMj824QZkmXfPn7PV6nv8ye7EkxiAFwWZ1q7VUcgJDo6WOoVK+Xgc28h90l2oOu+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994232; c=relaxed/simple;
	bh=YP4xVeeGutgIYvY76Gy5l3SMmSq+U/ctd3vJI9frGw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=akxZxq+rrTQUxI5AmO3f/jjbnm3q0ARUMWSXJ0V6Te0c9TeiqrPIREIHsrzW+3V0xeco+blZmRQIhn0PNQ6mc6BdJIsww4UAnjoe04DCLmZW/3M7c6wixYOZKXkrdYAu/W0wTGSAHURdfeCZgGzcxpxpiiknSdTCFs31JvUgvRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pT/xX9fP; arc=fail smtp.client-ip=40.107.243.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqngGmbkw1aPBaKRiexZN5fwXXGrLANNabEzIZTij0B8vx6sU/SGvnTBi8EcXuTqQY37raSogC5XKzlXwIl65IP+6UrCgyOnP+oB8aY6J/l1u/NucLj6N+BBpXbqMGJcBXds6ClsIgAGNCqij5s7AGtJuzVRg8midn79JqM4TAsXKcskjU6sZJXzJBs15mdNLtk/WzRje4aAsLCowxSQROkopMRuMHYim/vXUuddFRi0J/044vZ7lYHjCcDmG751PFc2Ow0xp4GxQCfhhC+8EZ36moZjAsf7dw46K2/sBfjkLqagCSLO8FjFxFPJfM/KiGSZQB3A+6ibAUO/PQv7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlI/14u6HChwZFIs+SB8kNrqSc6iKOiESfTjlAAzL8o=;
 b=MSSCXTMb2N7yhA1g0ON/1KCQ/+UydBZAR4y12GpeMoY0PpVb7y5aSgb8AIoHfwam9SXmwJs3y3bT9feQrCbV0aCQESq3MTuRv9TYZEsYE5BNT3bhukGJuyvAzKFLsutYIyT/9eMUhyCiDMMKb5cITjAvoP3tUO4tZ29CgwpwuUywdXIWfMSMkmUFFO5r00viPazvHgYtsQqb3jAVWXkBySWGreIb//wVcfHD594nL9qGytr737UafhoRGPSe//lPJpSA93JxKUQPQ33Nxo9MPpM+w/mjERC+ko4EElRTYf8XqohWhHi1LMzo7eoFEkV7CiFgAbGE+XdtOw8iEM7KRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlI/14u6HChwZFIs+SB8kNrqSc6iKOiESfTjlAAzL8o=;
 b=pT/xX9fPNlGudqRswneuCif+ZlYa6jKw4R4HwFYoswsWaCtKnRhk+6m/RccmTXod9kzB+g7F2GY8PaIJvX8ySkRdgF1V8RIlqA/sqCKFceUwyeFg4/1Pf5qgalcF56/QCtpt5/sXIF7oJcuPgoezEix5yeR2hV3aUf2XCflcGJQ=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 17:57:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 17:57:06 +0000
Message-ID: <133312c4-6ddb-4752-a7fa-3e7e526e9335@amd.com>
Date: Mon, 1 Apr 2024 12:57:03 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: Fix uninitialized memory read when last CPU
 of domain goes offline
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
 peternewman@google.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: hpa@zytor.com, james.greenhalgh@arm.com, linux-kernel@vger.kernel.org
References: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:5:18f::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL3PR12MB6377:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k9SyBeD32eBG2r0ym08eyWWLct3+tn43iaOfYiOXB4rpN3RmmkZBxAk+N4Vlb0Zs+0obSxxQ1IKaahs+qbkb0aRJJbhrn4Wp4xy41l77Qpyft39ousNxPEiYGccfLwZxkSTn6mp74PaLCVqb3b09k0DgWOrV8hTvQzEk+GaFO/qh+PNn30rPwPchx7tYG6KdKaqydc8Gw0yVr0R2R/b+GZVAjltCwJ6p3l1sp4gLpYWb/aTWjT642j8vrAsbgMrlLKcLNdUBVZtyoBI8IZG9trng+7FPGbj7YEOtzKoq5Qm591411DxmB1PornQ7XKL78X5CrO0rtrhdlnr/TNUuSXW2rF+hu0V7O8FS3InJHxq/MaiuwN65PCbmrkr8iSSfX7vxoMtoXWg5W0cekPkxAwp7N0Fumn63uFd9I+7VsIKcfZKrnOCGmo9VhpJ+7QWckGyu8Q2EnHTwjxbQcW+YodOYGDp6LUfkDZ+bFwYXEjLw6LVz3R88ulHcVjH9OLxSmcj6U+AtExv0PUW3/+M5jvJgZKXyf7i8Kjewixc3w5T/gk3TwVokZ1hNyTzwR64N3LN39TKRywgU0Y4B7WhZqzCalsYCXbktP0M7aTqqODgj5pawJsIwxa7bxKKkdUPu0bDgju080qd0Rd6SCJurcA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1FtY3kvRlJLNlRvR1dnNU5GSUdFUm42R3NoU0NRZFhyWWdjaXR5WGp1UFdt?=
 =?utf-8?B?Nk1iMFFrOUN4UWpULzhvWTJPY21hUjMwVHFxUnYwVzU4RGNlaFB4MG04bkVw?=
 =?utf-8?B?UTNVWnNYdU9nT0tBREpNUmRCUU5RYTRweGRWdjhhUzlwYU5mYVNuUE1SaStR?=
 =?utf-8?B?Y3VXbGNjZWZxbXcyYUxJMG5QdnNiUFBSdjJJM1RCMkVOZ1R4VzFiM0hSMXlE?=
 =?utf-8?B?TFBJTWYrNUl0ZFhiVHh1eklEUE43djV6VlQ3NitRRDFYR04zZWl2VEd0NHo0?=
 =?utf-8?B?SWtLcERPNVZGVThCYkx0ZHZTYmVsa3d4VzJWOVVhVDNHVDNQMTZZeHlZZ3hr?=
 =?utf-8?B?bEpNclZzbysxdlk4NHk4RElub3ZNSHpjMkFUSWt3MTIyY1F4NDNtTXRHeEFN?=
 =?utf-8?B?ZEFndWNneFFNUXZVNDdUUEhwTEJzOU9Dd1h5bm1Nelg5Yk5oUXAxVk9ud0E2?=
 =?utf-8?B?QjA3UjdZNXpDTllUc0twL3o3Qjd6VjlBUy9YQkdaaHBJSFNjVldGOEhROWh6?=
 =?utf-8?B?akc2alNpTnNJRmxRQWg2QkhtZmFUSUhOQjZoMlJFRXNlUDhhNDRIQUlpK2Zr?=
 =?utf-8?B?eE0vTG5tUXkyWGd3ZW9wL2syZEJzQnN0U25aeDFlWVdHNVVoMWZ1NDFJSUV0?=
 =?utf-8?B?VU9RaUlHV2FCUk1ydnYzSmF5SWY1L295UndXS2EraHlWNThaRHpzMGlLSzBF?=
 =?utf-8?B?QUFHWVJBQXg5V3RNdi90Vld4eTJqeWd6V2lqbFRHZ2ZtcCtLYU1ad0xNaklO?=
 =?utf-8?B?Zk5rNzh5SDhPb0FBVjNZNVBpczZXM05jTjVMemVrQnlIYS9PbzdJZlc4WWU3?=
 =?utf-8?B?dmNWTGsvU0lObGZMcjBTdFVQc2pMNTlBaWNrT0lFdzluR0NoamQ3WWdESzBm?=
 =?utf-8?B?M1pOU1I0eE1ha2cxc3llZTI5d29OV2dGZ2ZDRWZZVE1GUnR3eHN5dlh1RHla?=
 =?utf-8?B?cS9QNWY1UlU5YnlteVUxT3ZvS1d2dEZ6dUZhSW04UFcxOVVpZ0lMMUNoYjlt?=
 =?utf-8?B?NmNpZmJETDN3QmtrYktyd2FvRGJOVjZSc3FvVmNNWk9CU1VYelI4SHVLWEhW?=
 =?utf-8?B?R0JGU2hqU0p1QTk3S1RiZXlDZzhBSSt5REVEVkxzc2hHcDNyQXNYNWNLd1lj?=
 =?utf-8?B?OUNIUFF1eVpqcnJPam4xMHJOSzhRTmIxdCtvcmxmSW1LT0dFbU51aS9MeHpK?=
 =?utf-8?B?SmNWTTNCMzRzbzhaZ2J2MGhsbTdsUVk5NjdScGhLWUUxZEh1UTc2MDlTNmdS?=
 =?utf-8?B?TFZXM2IzdFRNUmJNd0Z1c1lhazRqOW5ubGNoWGFIYVU2K0JsRUNuZGVWemU4?=
 =?utf-8?B?MUNVUndIQXFBZEc2b081Z3lKZXZGZUdQYTdwT0owWFZxR0Qvb2N6Vk54OUNU?=
 =?utf-8?B?N3dkbHpMWXBLM3M4UjNDaVYvQ1VINzNCNHFyWGVuSmN3NGVwVmVHUG8yTmoy?=
 =?utf-8?B?aEQ3aHNEbWxCTVpYNTl2QWVSSUQxSzh5VmRTdGprSWZJRlBzUnZMMFRvYTRn?=
 =?utf-8?B?YWJzVm9rbFV1bU41MmQ2ZTJ0cElhWWxlVThMbS84V0ZraXUwbGxWdHVzRHRx?=
 =?utf-8?B?cEUvdC9XbWMvZjFsWTROem9zek5KaEdLd3BpNnJPcXh1ZlI1Wmt3ZGF4cm1j?=
 =?utf-8?B?azJnd3MxVzlrT2NHQzF5eXVRb1ErWUJrNTJsMWxlWjJXQUVWZUlpaTV3MmI4?=
 =?utf-8?B?eVRxdkRjNlVSVlM2ZkZkY1AwTkRvc3NNaG5nYXdLRXlrb1c5L2lPRzRUYnhr?=
 =?utf-8?B?VzFwb0pjRzREL0dqeVVXcCtBZlc0aktsN1AvQzhnenNhSm83cCtpbUFtbXlj?=
 =?utf-8?B?NkR3dWNGa0o3ay9jUVcvbzhVdHVleU1YdENMNnppajZkVzBBdzBqNTg2bENR?=
 =?utf-8?B?YUNYdWpaT1U0L2ZOcjFoeENYZDZhVnYvSjVvK2huM1lRc242YWtvS3JKaTlo?=
 =?utf-8?B?bmNXcHI0blJGdnpVMGIwMnd6ck1YRitrTnp2a3F1cjk0UkN2L3BMY3NZSFRh?=
 =?utf-8?B?RXBuWWtKVEExczlyVlBsakZzbzdaSVRMWEtqU1RtSFRoalMxUk10RWk4Rm1K?=
 =?utf-8?B?YXRmYXN3c3pyS05hZ0dzSnQ3cldISUZMUVNRWVlqZzN5YnhvN1c1dURCRktz?=
 =?utf-8?Q?QQcI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb794cdb-2a37-4eff-85d7-08dc527524a8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 17:57:06.0709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BruQ1HANRuAVsnAvUA9b2EG5KMdqhQSup2B0neStOyL1qmQN9Z2AzV1EmHuYmHMH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

Hi Reinette,

On 3/28/24 16:12, Reinette Chatre wrote:
> Tony encountered the OOPS below when the last CPU of a domain goes
> offline while running a kernel built with CONFIG_NO_HZ_FULL:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 0
>     Oops: 0000 [#1] PREEMPT SMP NOPTI
>     ...
>     RIP: 0010:__find_nth_andnot_bit+0x66/0x110
>     ...
>     Call Trace:
>      <TASK>
>      ? __die+0x1f/0x60
>      ? page_fault_oops+0x176/0x5a0
>      ? exc_page_fault+0x7f/0x260
>      ? asm_exc_page_fault+0x22/0x30
>      ? __pfx_resctrl_arch_offline_cpu+0x10/0x10
>      ? __find_nth_andnot_bit+0x66/0x110
>      ? __cancel_work+0x7d/0xc0
>      cpumask_any_housekeeping+0x55/0x110
>      mbm_setup_overflow_handler+0x40/0x70
>      resctrl_offline_cpu+0x101/0x110
>      resctrl_arch_offline_cpu+0x19/0x260
>      cpuhp_invoke_callback+0x156/0x6b0
>      ? cpuhp_thread_fun+0x5f/0x250
>      cpuhp_thread_fun+0x1ca/0x250
>      ? __pfx_smpboot_thread_fn+0x10/0x10
>      smpboot_thread_fn+0x184/0x220
>      kthread+0xe0/0x110
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x2d/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
> 
> The NULL pointer dereference is encountered while searching for another
> online CPU in the domain (of which there are none) that can be used to
> run the MBM overflow handler.
> 
> Because the kernel is configured with CONFIG_NO_HZ_FULL the search for
> another CPU (in its effort to prefer those CPUs that aren't marked
> nohz_full) consults the mask representing the nohz_full CPUs,
> tick_nohz_full_mask. On a kernel with CONFIG_CPUMASK_OFFSTACK=y
> tick_nohz_full_mask is not allocated unless the kernel is booted with
> the "nohz_full=" parameter and because of that any access to
> tick_nohz_full_mask needs to be guarded with tick_nohz_full_enabled().
> 
> Add a tick_nohz_full_enabled() check to ensure that tick_nohz_full_mask
> has been initialized and can thus be accessed safely.
> 
> Fixes: a4846aaf3945 ("x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow")
> Reported-by: Tony Luck <tony.luck@intel.com>
> Closes: https://lore.kernel.org/lkml/ZgIFT5gZgIQ9A9G7@agluck-desk3/
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c99f26ebe7a6..4f9ef35626a7 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -85,6 +85,10 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>  	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>  		return cpu;
>  
> +	/* Only continue if tick_nohz_full_mask has been initialized. */
> +	if (!tick_nohz_full_enabled())
> +		return cpu;
> +

I am curious why this below check didn't fail?

if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
  		return cpu;

The tick_nohz_full_cpu() already checks tick_nohz_full_enabled().

It should returned 'false' and  returned cpu already.

Did i miss something?

-- 
Thanks
Babu Moger

