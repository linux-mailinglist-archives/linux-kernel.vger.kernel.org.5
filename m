Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A5F8074F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379314AbjLFQaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379317AbjLFQ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:29:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58996D72;
        Wed,  6 Dec 2023 08:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeILs+cvCvZZqxqSUja8rli65nhEowzCAQgPWiCFEd8kcCpkQyNDoRO3axmho0drrfugsqdQW858uV36rSdKbgTZQJOSEFbiS9xWVBkZeptA4tJ5uQ+sdv0etxWBDY5c/O76stLHZF7f4LpbbPR/NQPlDRPRsuVlpz4MDeygtKFgs/X5MKdbefIfI1z9oMcKndXnAY6+Pehunny4xm8XHFXJr5YnBM3TRL82C6OPB76hZ+cJGXRtAKOyCVnYA3PU/O1c4ZCZZts5hh9c1iuGKVZMSWR+Fa3YU/1+2as3/sbj9/EBO5MTBwbjqwAg5VvYj2l4Q7/dhwlZz9NXAmiE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHjXajkIcUFtz/jQbN9QGnGTxGjzFqeRhPzbya9dLiM=;
 b=Z1biF1nWWCbp1w9KODMKw8eO+cLTQ2xD7gIm9ZXL86TzcxDER06hMpHSWOPeCtOMqyfRFQY/hmjeA8xONp2YcshkQToVyFWtX8078x11Sa8TQ1izQcQRF6VM42Gqyt5wZQ1wXciqGugGLGRfR54IWtkGi0WaouyowwWGabdz9d/nLp/t+IecYLvzlMIoNkh3PrWl5JrGlk3bYopTv9FKMlbtWSAAWfaV9WO4znrKb7HMCKe+CSrOiwB2OvBMgmDfGIX5HmJxJMeo09hy9Txbg8vV1YJxl0KNqixFRmSruiPuIJ+Zzv6RXRM5zYbedpfRe3NCSh/0gFj+B4H9zxsMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHjXajkIcUFtz/jQbN9QGnGTxGjzFqeRhPzbya9dLiM=;
 b=gI10RE30vATWHLklRwbEqPqE7pvpqCNEgXx3xgF3bUjzzJC4bIugO0cCc+oKxrwud6hXCWitCTxXgUTnUlM+vEoneOGi/WyLfPd+T/ZHq7nnOOo/cbW1AWQh4sX6N9p6mlVsiuZJ0Qvfim9lqjUomjSoYAIf9SoXChMr1ASMdag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 16:29:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 16:29:52 +0000
Message-ID: <90245ee3-8357-4375-b735-66acfe89ff90@amd.com>
Date:   Wed, 6 Dec 2023 10:29:49 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 01/15] x86/resctrl: Remove hard-coded memory bandwidth
 limit
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com
Cc:     x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
        rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
        seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
        ilpo.jarvinen@linux.intel.com, jithu.joseph@intel.com,
        kan.liang@linux.intel.com, nikunj@amd.com,
        daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        peternewman@google.com, dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <20231201005720.235639-2-babu.moger@amd.com>
 <4bca7ca1-d452-4cb7-b721-b2273f9a71b5@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <4bca7ca1-d452-4cb7-b721-b2273f9a71b5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b76063-f91c-4297-945b-08dbf67892db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgIL/VrR7csqObDZvb8mW4fANbF2aKGvlyhWI6TurrXpM3ph8BBfj8kfGFpOv+lrKXz2nL9wt3dd3u12TczWSHnqqka6/B7Qatk0NQhfml6BiWEYFUIMZ0dt/NbTt4k5Wgwl652GVy+ACXGPiIAU8Al2m5+W4TytTZ6bkd1hnixUFdMPKy6SI4OATYBnrCvxh0aw+H1LxUyEgcSDuLb5bSJNqxxUyiHVab7gRAKtjACSjIZuONJuzenzHnxaJ1u8RjjB+1SHBnvNy0c9jAHv7LiU9pLw72L9bpMa3qGlJCIDfcdSCOTBs4YTnr8Pzg1vYX70+AlLEXI3MOmguEtW6uGo5bSSXYGeNF30kpOxwWjzbOIf0xoEGuJZuZI+234eNmeMIn4/5hJpFNYs+WnzFUvFcrXKG48UKupUezPCabmzWFMMoMIruZSpC7e7+IHwiiEw8axqXBv6hd/xijtZwLumikGIfGq/1ryd4yW+bpZlfn2p9m2B/F5+3zb54+u4lpLBTFicA086v3RJdqekC0PzsWwwyhclQry6QRi91uVjiiIB9MhXl7WM2llKGq+jL79l9+gy8wenHtKROHL9XxtiGKTYX3Ek0reoQIHaJLyTf6eRhM7Hglwh8fsa6XdrfFvx4/b0D6NZRKEsgakfaNOD/mw6lBYv7QlodNPN6eFqMvG7MvINXvzMQhQZpp3Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66476007)(66946007)(316002)(66556008)(478600001)(6486002)(966005)(6666004)(7416002)(41300700001)(31696002)(36756003)(2906002)(3450700001)(5660300002)(86362001)(4326008)(8936002)(8676002)(38100700002)(2616005)(83380400001)(26005)(53546011)(6506007)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGhzelFhQ1ZRajVlUGg4cFhsNnlCdUxoTHZNVUxDdVJZL0dnWHVlQW1lRFlE?=
 =?utf-8?B?VVJxNUw4UkovNWJUVkhPRFpoTUk4bnFUNWhJWDdpMERHNkJ6a3ZHdlNEajdQ?=
 =?utf-8?B?VnV5NGgwYzRmR2FVRTJvTUNybXZ5NGVJc05jMjZCUnFvQkFyRytqaWNhckZh?=
 =?utf-8?B?Lys2dml5SzFTYU5kU2JOYkhZcFNEVXRtc3AyZjd0OEVMRE5NL2o0bzgwdzNJ?=
 =?utf-8?B?VklyemZ0U3Qyd09TT3k2UDVOQTc4SUkzQnNFSkxmYW9WUUFXL1A0NWhyUXY5?=
 =?utf-8?B?SVd6OVBvcnk0Y3hDNFFjcHQvdmd3WWFCVGdJMGdjMldTQzYyUHFEcmErSm94?=
 =?utf-8?B?U3FnMmpWdnJ4R0RZZ1MzWmJ5N2x1SzdicElOZytNMW1qTHRWNmkxQmcxWjVv?=
 =?utf-8?B?ZVBzRDIranVaNDVKS1JlS3RTOUhaaDlrSVFqMmNBVW40Y0NJNnpCWEN2bzBx?=
 =?utf-8?B?ZEVKTHltM3BtbHNUNTBZUXovSVVKaXArc2FNYW1XOTJiZkQvODlzZGNEWVJ6?=
 =?utf-8?B?VzUzK0trSGVOeFFDa1hGQUpVWVZTdzZPYmEzdktQZDZPMVhzaG5MRzdIUEVw?=
 =?utf-8?B?RUpaeGorOHRxcVN3ekQ4VnFjakM3Zy9QazZPRG1wSXE2QytPK2hHNTgxMGhF?=
 =?utf-8?B?ZGVTdzdHcWRuRlBxQVZlQS9CN0N2VXovNnlnTndUdGFOMmlVWGFMaENRNFJX?=
 =?utf-8?B?aHdJZXZveXBZcFNZbklSNHJkd1VMUXRKb0krdUdJeGR2OFhMMmp0UzI2dUhM?=
 =?utf-8?B?clhXb1pLMDAxMWFJSjM3dEZWSEt1TmJsaTFDUkZMeG56bXE3VFBUUWFFaFdt?=
 =?utf-8?B?eW1pd3F3WTdkYUFmS3VGK3UvMnBkTy91R1NsbzJtWW1HSmVxWFlUUWJSdHdh?=
 =?utf-8?B?OWh6TTJEaUtERU1FdkVNWUVTdGpIRjNib204MW85UHFmaTNvVlhZaUJjQlB6?=
 =?utf-8?B?Q3MwVFhrd0t0cFlIUUR6UkZRTmdVQ2p6RDJwaVo0R3hNODdhK2w5Z3hGMmlT?=
 =?utf-8?B?SFpIOStLRU5nRFB3dzNEK0ZaS3U4U1hNSmNhWFdzNFFYSkVLWkNlOFRvdTFi?=
 =?utf-8?B?Zy80Y3B3T1BPaEdqOVBWNVJNTUdydUZScjRHbDEweCtvZnVqT29hVmJzZjI4?=
 =?utf-8?B?WFg4UlNzdXRMV1NsVXNqZE9qdGErSTRSRVpPaTVtSGdraDBzK3VITWRVM0I0?=
 =?utf-8?B?WEFDTitPdnl4R1kvcGV0QjhhVU00ODlKZlpUZ2h5N3c3ampzT1NXa2x3MTVN?=
 =?utf-8?B?T2hjUEwybGFBWlZZeW1rcUwxV05iUHJrT1JQcHdkOFBPZis5SnFFNllqalZl?=
 =?utf-8?B?MGFaQkZQTFRWU3NjV3lxaGRwMWlPeG1CWWYwSVVXK3M1WVdtTTNMMDVPQmhR?=
 =?utf-8?B?N2JIWGd0elVkMzM0TEMrQjluVHdoNGJ5aHJiN0FoYmpnUW44RkRvS0pVWE94?=
 =?utf-8?B?NUdNZVE3WlVQZW1XVEtMc3lZMlAzMG5WeDh2Y1JkSHpvb1VTREU2dFlyMFhO?=
 =?utf-8?B?dnQ5b3dseUdZbzBzbHpMYXRLUUdlL3FKcDR1QXcwYXZNM050MnBMSVdNajFH?=
 =?utf-8?B?d2s4cnZycytDWjA3dmJQdkVFditmT0NjamhoaDRjRlppUWFYSzRJOUFrZXA1?=
 =?utf-8?B?eW1mWHBMbXpEVE9XcXJreHBWVlN6QU00bzdrSXNxQVVSelJsNlhNSVAwNFNP?=
 =?utf-8?B?U3FEZDdqQ0hueTJxcnZPYk5yV2pZeE5ld1hYSHZXTEZXUkJ0dnZVaHZWNHZq?=
 =?utf-8?B?bytnSGluT1NHeGRxZnFBWjN4TzM4eHZoeEt0TTBuRFJDVGRpZzVFS0JTVllo?=
 =?utf-8?B?bU04czkybzdJWndER2pVYnhDYmpaTkpXZkhSWlZzNmFLS1MxV1hWeThRQXhV?=
 =?utf-8?B?ZktqcUxMOFozTmc1TE9oVUlZWE0vMG41S2o1RE9OSjNuL0pIbDU4NzZMcEJM?=
 =?utf-8?B?djUrWmJhRitVZ3BNVUpOS2VqbWtVSzcrNnRaeUlKWERBbys1Qmh2cXI0TkNB?=
 =?utf-8?B?dWY4cFJPendkd094WWJET096a3NmcWYzaE52akxIZWxrdjBVcTQxMEFwRjhE?=
 =?utf-8?B?WXRKOGMxSUVaRWFoMmxiV1cxaEpCb1lNNDNLbHFwUVZVK3R5V3VjaFI5ck9U?=
 =?utf-8?Q?s0+M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b76063-f91c-4297-945b-08dbf67892db
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 16:29:52.4854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yxi2wRGqkuG/OTJ+a8wuMsqPPIfZgKl9dKJxw4jzR3xvjiSIpOW2o6uEvfyXIdim
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 12/5/23 17:18, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/30/2023 4:57 PM, Babu Moger wrote:
>> The QOS Memory Bandwidth Enforcement Limit is reported by
>> CPUID_Fn80000020_EAX_x01.
>> Bits Description
>> 31:0 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.
>>
>> Remove the hardcoded bandwidth limit value and detect using CPUID command.
>>
>> The CPUID details are documentation in the PPR listed below [1].
>> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
>> 11h B1 - 55901 Rev 0.25.
>>
>> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
> 
> What makes this change worthy of the "Fixes:" tag. What is the impact
> of this? Does this mean that there is AMD hardware out there that is
> not being used correctly? In this case it should be highlighted and
> the stable folks included?

This was reported during the internal testing on upcoming hardware which
supports higher bandwidth limit. It could be a problem with new hardware
and old kernel.

> 
> This also does not seem like it belongs in this series and should
> be sent separately as a fix.

Agree. Will send as separate patch.

> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>>  arch/x86/kernel/cpu/resctrl/core.c     | 2 +-
>>  arch/x86/kernel/cpu/resctrl/internal.h | 1 -
>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 19e0681f0435..3fbae10b662d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -243,7 +243,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>>  
>>  	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
>>  	hw_res->num_closid = edx.split.cos_max + 1;
>> -	r->default_ctrl = MAX_MBA_BW_AMD;
>> +	r->default_ctrl = 1 << eax.full;
> 
> This does not seem appropriate. You are using eax because it
> it convenient but if you take a look at its definition it does not
> match the AMD CPUID instruction output at all.

Not sure where you see it. Here it is.
https://bugzilla.kernel.org/attachment.cgi?id=303986

Here is the definition.

CPUID_Fn80000020_EAX_x01 [Platform QoS Enforcement for Memory Bandwidth]
(Core::X86::Cpuid::PqeBandwidthEax1)
Read-only. Reset: 0000_000Bh.
_ccd[11:0]_lthree0_core[7:0]_thread[1:0]; CPUID_Fn80000020_EAX_x01
Bits Description
31:0 BW_LEN: QOS Memory Bandwidth Enforcement Limit Size. Read-only.
Reset: 0000_000Bh. Size of the QOS Memory Bandwidth Enforcement Limit.

In this case, limit size is 12 (0BH) bits. Max limit is 1 << 12.



> 
>>  
>>  	/* AMD does not use delay */
>>  	r->membw.delay_linear = false;
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index a4f1aa15f0a2..d2979748fae4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -18,7 +18,6 @@
>>  #define MBM_OVERFLOW_INTERVAL		1000
>>  #define MAX_MBA_BW			100u
>>  #define MBA_IS_LINEAR			0x4
>> -#define MAX_MBA_BW_AMD			0x800
>>  #define MBM_CNTR_WIDTH_OFFSET_AMD	20
>>  
>>  #define RMID_VAL_ERROR			BIT_ULL(63)
> 
> Reinette

-- 
Thanks
Babu Moger
