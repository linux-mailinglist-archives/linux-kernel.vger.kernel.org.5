Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F457D569E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbjJXPgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjJXPga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:36:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E68BA;
        Tue, 24 Oct 2023 08:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQlVJmDo0EoC8JPyhBIJFjDNyTT2EkR8HSbB9ubyTy3XgR+UrHYrjyo+T64VLKA8ZkBaqBYZpD5Wz6+7m7oULoXdPRBObOM33dnQgUOmr658JZ1NzWokhVOiiGzAG3Ik8VgBjNTKMxq2tRnRxcPaApQLoVI3g5Qz4GRVBGnhj1uK09ZUtBpQ93Li2rhNwuLSVx4GBj35cAl+K028kMrvvUjAvrY233tnNfwGdSCKCo8jldIz4Lk3cRagRh7tCIDc1SgAYYr2wWeWvzxSX8pXuMB+FdHWt9kdxvIt7WCVdFQbZ6VQsN/iyoz59QWmEoVCGMlpxvRWjF+/yATVQnPfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji0yUnoPULjGwGVr61/pw8L16ZAAwL+/bkHT/09o8aA=;
 b=XHjx7su1ZL/KuoGVWseXxRrSbYHHd9xcmZWvUT4cHXorsdcfWth92B6QkoJo230kPxmcUS+C4x4y8Db88TsZM1Q2uJ6as1a3xbHW2SNGT/UzQoea37rNRkF8mQLPtdwrpJdNXrCFJXPWFIartQ48MQtz20RuDiqSEgJ5Bm4xjO4knFWSugCqEZl6VcQsGhh75Zs2eGeztSCxNXeWzxgyO5EAGa0BZWJqQV+FqqxM78dUCYKsiKTfKeE42Ag0csDP0rxth83JkEB9m5Z5irwFoojsznODter6WOoRAA8LqIWmnXx4DfGwsxJP/YM7tHhttZ9AGM9y0egb2qm9AFkSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji0yUnoPULjGwGVr61/pw8L16ZAAwL+/bkHT/09o8aA=;
 b=mW1oZm/tA/R5xupH+icQnEdhfyr1YCakVRICJQ3bvuVfYKo3Xi39XgT6LJ9EH2kxAg26zDBHYxdZrqt1pLmAafUjZkNw1U42ipmRJhCV0Yk4Pxz1vw1OyALC10z0hUdcTSDIbe9lkRqt3W3rPyjgFSQ4Lb1zgFPKO+jf1eL0UYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 15:36:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Tue, 24 Oct 2023
 15:36:23 +0000
Message-ID: <6894bebf-15ed-4bd2-aebc-f4ac0a30a395@amd.com>
Date:   Tue, 24 Oct 2023 10:36:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86: Enable x2apic during resume from suspend if used
 previously
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
        pavel@ucw.cz, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-2-mario.limonciello@amd.com>
 <ZTeB9K4NYu1sRiZ1@gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZTeB9K4NYu1sRiZ1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: a055088c-fd51-4c6a-343e-08dbd4a6fa35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1Z+lkzASPFTXmg3S05ldcmDit7eLIBlZBJSOf83HCy3ANTrR9PHqvrEMbTmgcqWIphJGW/OAi4RfRZHfoV/+jtQ794pCnlZFX09LJ7mULGmpgXmsVeGdkLxiGpZ3NLRtlj34d20GYH1pZQvuahunmQvuBbHoWSr7uO7IHH5DXKqvEquGoln9HMm7WWMChquLpEUF10Tu8xxRGzG59PvD+topm1pC83mbcwgbyC6leup0RlMI7BTRm+mGUri98KJtrcE5jmJzUnSuu20l7Ux8Aq88MRVIgSB94zavlAKpLGooJdANLf4ledoWAAZNxKcz7IjIPKnzr0FdpQm5xhKjgRk7990xUs6BEgHDkvxM1de0nHDmbCEMT+pJK6JFekUnL1wmVnaXwweIHrzIBxek269wXy533bbw6mHwyDpRA95vsC7ZEy9Vh55sxbCD1aLcwFc7R+ZGGqi1XpHKnv62cZFcLu8sCiALyyrA5ZD4PNo38OMMbg5QEPR3/zDeDUmADytxgIvyFHAoKcgKLMpBx8N9hDPDNgQDqwvsBXGhb2tM/HD7YFNIFxKFdc6NSbVY+SUagHIQovrnynChovO4xb5E/GV6y1mtJ9Z9kpBflTCDWcCi79NmKKn3CUvIepygNtqyKQdJBGa1iIOrtKPZW2u/V7TZl9AK/24d0cmwBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(31686004)(38100700002)(2906002)(86362001)(36756003)(31696002)(5660300002)(4326008)(7416002)(15650500001)(41300700001)(8936002)(8676002)(2616005)(478600001)(6666004)(110136005)(6506007)(316002)(66476007)(66946007)(54906003)(6636002)(66556008)(44832011)(83380400001)(6486002)(53546011)(6512007)(87944015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJkK1FtRXE3U1E0bTVXcS83bmV6bzNyaThlLzJ3cnV0dlVxTSt4UnMwMGx1?=
 =?utf-8?B?ekZjREgvTTJUeTkxeGRkVHBNWDVzUXJRWDhuQlgwaXJxZy9peWdPU3ZtNlUv?=
 =?utf-8?B?UnAyTVNabmR1cG5BTHBOcU9JQU85YjFKUE85clo4T0p3Yjc5TmdiZ2hvNk4r?=
 =?utf-8?B?QUhXOFRPVyswNDMxM0M2YWFxMVM3bnlIUk9uL3lwTnh5K0NvZi9kNWpSNS8v?=
 =?utf-8?B?SFhkcnlFeGljNDFaRW01VGdHV1Z4THFwU0xPWFNBWjNkQzlyL3VRRllGMjVF?=
 =?utf-8?B?aGlGWUt0N2E1UHFUM1JKWTNVK1drQ3NQbUxGY2tFRmxtZzRpMlpmQWZSRmhL?=
 =?utf-8?B?SFNvTk5sVWRLcXFtd1NHN3o4UTU2cGRYZGphYnlFVWtiSUFaSk96QnQvMlAr?=
 =?utf-8?B?TGlYSlJVanRaTGYxeXJXbDhRK3FPSmw2SndZRnhFREYySnR5R09vTVdXMzZB?=
 =?utf-8?B?VzRFc21OM3p6ZDB0ekE4T2lSQjdmamJVd3FPd3J1Wkc0MWNoN0xyM0xlL2tz?=
 =?utf-8?B?S2t6TFhIcjNrL1pmdXRqbnZwZFZpckRVbllJTkRZSFpHdEY2bFhLS0NRdTJ0?=
 =?utf-8?B?VEtFdk02TSt6R3k2dGxUalB6TjN2Qk5PTTdGUXFETURoWHpxb2FwanpMNkl0?=
 =?utf-8?B?djNJajEwODEyTWMyMXM4VkpadWFUa09iQ2NEMW9BOWhaYUF5ck5qN0lPK0xW?=
 =?utf-8?B?eVdtaVRjdlZNZTBSVG9CdFZXcHppQkM0UXhtYUJJdDFCR2VLZS92dUx6MlVQ?=
 =?utf-8?B?cFJZYlhYTWsxY29HQ1hCRkd4ZlNTSEFtRW9hcXkxeEtFaGtBaGVkYlZtZlRD?=
 =?utf-8?B?eWNTSUg2eW9RZndPOHp5M0JRMDVUVkpMbjNxWGZzTTI4L20vT3NPRjdJN09Y?=
 =?utf-8?B?YzljSFR2RTE3cEN2cjBDV3BBQTRaOUJzSVU3Ymp3ZG5XT3RYT1FpeVBXSGpL?=
 =?utf-8?B?Sk9kL2VaYndTbWlseUtveW40UEE4K3NaOFkvcks4VlYvMHdUNkdGdzZMb1dN?=
 =?utf-8?B?ZWZIUU5EZEtieldzMmdjak80cHBNS3dsY1RJenNvb2xpWHpjSHBHT3MwaTYw?=
 =?utf-8?B?QUZQZnRjOTV2dXFua1AvbmozS2dkeGE1WjVDVWRnbkx3L0pjZlBNZ3hOUkF6?=
 =?utf-8?B?dDExTVVGby9WVkpBOFlmRG5BZ3lEVmsvdGhvcnNWZHI1aTY2a2hVT1pGb1NK?=
 =?utf-8?B?Smp1ZzhxbEd3TjVCelY2RS9pelVTdmNhMHY2ckJqajlBbktrOWV2L2FWd2wr?=
 =?utf-8?B?OEtFWitYWDJjditzR0wzM2IvYlUyV2Jtcks0cWdTcVg2MlJqVTZwSXM0Sm9X?=
 =?utf-8?B?N29OQm8rWFBWYU5pSXNsUWhtMSt0Rk9Nczc2R1dYcXNVVm1qbUxOTjRselAv?=
 =?utf-8?B?SmZ4b202RXI4aGV0NnFRS1BxTDg3VDJoQ2Y0dUlCSzRIUkdMMW5QUkIzNlUv?=
 =?utf-8?B?dUJhTDJtZ2FldUk4MFVxUy9QanpoR1E3aHkxM2tERnhBQ2Npd1FLcWNFU3g1?=
 =?utf-8?B?VHhBeWFBZFUxNmtrSllwd1BmTkNnOUpkRW5UQmprNzNDUWJqUTUra0g4SWEr?=
 =?utf-8?B?OHZxOWJvVStPZUVoRjNYa0tBay9uVWxRamVKcFBKQ2ZRMmxYMCs2TmF1RVlQ?=
 =?utf-8?B?RlpzaENXMHI4em84Kzdiek51bEZIMmFFaHE0WVlHNmtzaFJVcmRDRHBCcDBi?=
 =?utf-8?B?U1F3Qnk1bThYMlZkcVQ4cm9xWDFoVmhjZCtZTHg4dnVuYkE1S2pvWnhVNGdr?=
 =?utf-8?B?VFdZSzMzOGpLQ0lhVlVZOVk4Zi9xM0RGZ01wOER3ZDdkbVpNaFhGbitEaDZC?=
 =?utf-8?B?VktBSmhhd21JTzhBQUFzSzRZeVdlTWFNYlJUK1hNWGZuck5OOHFwNFlSRmpF?=
 =?utf-8?B?UFlwazVtRDlZRGtFUUV4Wm5XdlF2YzUwUUZpdUR3TzRLSDV4VDQ1ZzNFZ0Y0?=
 =?utf-8?B?WEw0ZkhHTHZ6eWwyMkpjOStJcmZzTDJCZFF4MGhWQ0FkRkxIbDlFZkxZZTBj?=
 =?utf-8?B?U1lMdmVwNmhxbTZjcVlwOEQ3akZPYTB2U1JodEFZa3Q2Sjh6SCswNW9HNTli?=
 =?utf-8?B?dEQzb2NBWUZtdForMUltRk45WFRLNVdYUWxKYVBOZ01sd3hsM3ZocXJLZHkx?=
 =?utf-8?Q?LBLYbt/zkqwVIZL+1qtHCcG8q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a055088c-fd51-4c6a-343e-08dbd4a6fa35
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:36:23.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htI67J5Mi4d1FeLJYuhjdTZpu+stlEgtZjTVMAr7OEJw/uTbxSpFA3kz2ETjbpuOZ1s22Sy/GBdWhKzncNHRvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tom

On 10/24/2023 03:36, Ingo Molnar wrote:
> 
> * Mario Limonciello <mario.limonciello@amd.com> wrote:
> 
>> If x2apic was enabled during boot with parallel startup
>> it will be needed during resume from suspend to ram as well.
>>
>> Store whether to enable into the smpboot_control global variable
>> and during startup re-enable it if necessary.
>>
>> Cc: stable@vger.kernel.org # 6.5+
>> Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/include/asm/smp.h   |  1 +
>>   arch/x86/kernel/acpi/sleep.c | 12 ++++++++----
>>   arch/x86/kernel/head_64.S    | 15 +++++++++++++++
>>   3 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
>> index c31c633419fe..86584ffaebc3 100644
>> --- a/arch/x86/include/asm/smp.h
>> +++ b/arch/x86/include/asm/smp.h
>> @@ -190,6 +190,7 @@ extern unsigned long apic_mmio_base;
>>   #endif /* !__ASSEMBLY__ */
>>   
>>   /* Control bits for startup_64 */
>> +#define STARTUP_ENABLE_X2APIC	0x40000000
>>   #define STARTUP_READ_APICID	0x80000000
>>   
>>   /* Top 8 bits are reserved for control */
>> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
>> index 6dfecb27b846..29734a1299f6 100644
>> --- a/arch/x86/kernel/acpi/sleep.c
>> +++ b/arch/x86/kernel/acpi/sleep.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/dmi.h>
>>   #include <linux/cpumask.h>
>>   #include <linux/pgtable.h>
>> +#include <asm/apic.h>
>>   #include <asm/segment.h>
>>   #include <asm/desc.h>
>>   #include <asm/cacheflush.h>
>> @@ -129,11 +130,14 @@ int x86_acpi_suspend_lowlevel(void)
>>   	 */
>>   	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
>>   	/*
>> -	 * Ensure the CPU knows which one it is when it comes back, if
>> -	 * it isn't in parallel mode and expected to work that out for
>> -	 * itself.
>> +	 * Ensure x2apic is re-enabled if necessary and the CPU knows which
>> +	 * one it is when it comes back, if it isn't in parallel mode and
>> +	 * expected to work that out for itself.
>>   	 */
>> -	if (!(smpboot_control & STARTUP_PARALLEL_MASK))
>> +	if (smpboot_control & STARTUP_PARALLEL_MASK) {
>> +		if (x2apic_enabled())
>> +			smpboot_control |= STARTUP_ENABLE_X2APIC;
>> +	} else
>>   		smpboot_control = smp_processor_id();
> 
> Yeah, so instead of adding further kludges to the 'parallel bringup is
> possible' code path, which is arguably a functional feature that shouldn't
> have hardware-management coupled to it, would it be possible to fix
> parallel bringup to AMD-SEV systems, so that this code path isn't a
> quirk-dependent "parallel boot" codepath, but simply the "x86 SMP boot
> codepath", where all SMP x86 systems do a parallel bootup?
> 
> The original commit by Thomas says:
> 
>    0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
> 
>    | Unfortunately there is no RDMSR GHCB protocol at the moment, so enabling
>    | AMD-SEV guests for parallel startup needs some more thought.
> 
> But that was half a year ago, isn't there RDMSR GHCB access code available now?
> 
> This code would all read a lot more natural if it was the regular x86 SMP
> bootup path - which it is 'almost' today already, modulo quirk.
> 
> Obviously coupling functional features with hardware quirks is fragile, for
> example your patch extending x86 SMP parallel bringup doesn't extend the
> AMD-SEV case, which may or may not matter in practice.
> 
> So, if it's possible, it would be nice to fix AMD-SEV systems as well and
> remove this artificial coupling.

It probably isn't clear since I didn't mention it in the commit message, 
but this is not a system that supports AMD-SEV.  This is a workstation 
that supports x2apic.  I'll clarify that for V2.

I've looped Tom in to comment whether it's possible to improve AMD-SEV 
as well.

> 
> Also, side note #1: curly braces should be balanced.
> 
>>   #endif
>>   	initial_code = (unsigned long)wakeup_long64;
>> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
>> index ea6995920b7a..fcfa79105928 100644
>> --- a/arch/x86/kernel/head_64.S
>> +++ b/arch/x86/kernel/head_64.S
>> @@ -236,10 +236,15 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>>   	 * used to look up the CPU number.  For booting a single CPU, the
>>   	 * CPU number is encoded in smpboot_control.
>>   	 *
>> +	 * Bit 30	STARTUP_ENABLE_X2APIC (Enable X2APIC mode)
>>   	 * Bit 31	STARTUP_READ_APICID (Read APICID from APIC)
>>   	 * Bit 0-23	CPU# if STARTUP_xx flags are not set
> 
> Side note #2: you mixed up the comment ordering here.
> 
> Thanks,
> 
> 	Ingo

Sure, thanks for the feedback.  I'll adjust the style for v2.


