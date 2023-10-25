Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777467D73DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbjJYTEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343608AbjJYTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:04:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC4E116;
        Wed, 25 Oct 2023 12:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiXi7U4dK7dIWHI4l+NNrNp4Epgki05gfHnvsXWEhMVYfYl1RYYyRL8ko1aufM+usiWz/srpDDUH+C4FRG3SSGa/iddtsw2MX+/NDMTHlK2mdyYqPMZSHW+fgsv3Ks4Zxy6fAJMcwyjwsqIQ4uZ4VtLLrdcjGYR0QDYY0XhznTfan0SAXnYHrCPGF1Clv0/FXsJeF9Duo2eipYvjycqNUjtGsIehd/HwpiTfbtbJ1KL+46ZHAiDWnaON0S77ebiqSVFMOb7GSbCsdU8gh0Yj+uwB4sk+HHA3cz0im13HHDZCLnPGaGhK75a9/B/n4fcXBWD0VlS5De929gqEaCIDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn9EzjsFJ0jADclNo6yo7632VgFY0GneNd0IvJ7ddrg=;
 b=D0b6V4Ma4tWM7+09xQEXPLPP+e20Qr+QYLyhQztseGEC6a9gyzJIPkbj9HV+uD297jppTzim7bsu4Ie4FeKUBbMhPGJ7rlzfyTThQ0to8pQTuIoj5aX+wk7PGRTsletfsilUstYN/uYj8/dMpPEO/yP4AcraDn1XQJ/vz0WChs0VaOV2vSRrmBYS9E2baB7Yf33aTZTpDuc5Bdwkl/HFNeR4G+ct2gCJzdhKoenREyTAJucfuid5mWPwHfLSBRkC1lGKCGdCFJyktk9oMyoGY/1z9/1cPzjQADxb8KLxzVhRcOfcZ2B49OSae2J7+/54CYCAH7Za97n7vh1idlScCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn9EzjsFJ0jADclNo6yo7632VgFY0GneNd0IvJ7ddrg=;
 b=PiS9Yb9xPLj9CzJEE4Stx0gjLr/nyx4G/NZemOWjz9qmfgPqBy9m9tQgMcbc183AAnyeMcuRSYa9q0l2WY60m2LQzHM9Dn+QHzEFC2BxHLkI6GGs42VvjLclbuXKtva6sfFdt3Hp58B72aZE/ei5RQ0AhE2sljgCLG8FVcyG0OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 19:04:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Wed, 25 Oct 2023
 19:04:30 +0000
Message-ID: <02a80f45-496e-41dd-b17e-819ca82f27c5@amd.com>
Date:   Wed, 25 Oct 2023 14:04:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86: Enable x2apic during resume from suspend if used
 previously
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <ZTeB9K4NYu1sRiZ1@gmail.com> <6894bebf-15ed-4bd2-aebc-f4ac0a30a395@amd.com>
 <ZTf4dtWBTjiKIntj@gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZTf4dtWBTjiKIntj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:806:22::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bd239d-8ccf-41da-e6c2-08dbd58d3776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxU6qemcTBTvOLopekUg8F7KwWZWtEU7fmnJdADhRaGA6Fq68tVCF5C3gF8P+wxhHXCratjlfXPcBsq/uQKkc99v9ksLVJvJ6qj3Yh+ozZeis+kL0OfDa/rHC+oj4Lx6jG47xI0gT3qNI9ehHAzRyUe1VjuembMeHnDcrIBNJ8hG2cAVFAkV8nYr1ISBEulHTHZx/xx/q4Uo1rVPN8Ynfr+84v/OlSimd+o5L60Vir+xA7mzDCkst5WA7++UHPilBaZhhbvrMNJiwxypOOLKDm8vgjnOkmwVlQqAubuALrDGugja9TcdFelawP3Hp9OVgU2zPw2VTX2g2DPC/SoDAEQz8BK6s8ozjek2f9e34KZLNz7Glvnw6yU8uEQh+0L2wITFfSI0bXC4dMsz7ysbtTJHaW13Qqm2c3JADkAY7WTu5RPqw/jECpFte5NYbRFpUfbUKZDcXytwgQIPWOgx0ZQw37gmcpDbEhMITfSuCtvH8WP7hoSRId4ilwlsRAlYk0GUwRrQD8pauXoWT4lSRG9iGVNFF6s0shGppXyc7mD/PuQWbYpwhCjb/s+ZsvqUqxvOA9hIKbYK7CjzaLd2ND56o2THma7lsP54vysrdPrlDiR6agyVUqsDFt1KIUtuD9EcGzRsQKage7JOXWJA5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(31686004)(38100700002)(2906002)(41300700001)(44832011)(7416002)(4326008)(5660300002)(36756003)(8936002)(8676002)(15650500001)(31696002)(66476007)(6506007)(86362001)(6916009)(66556008)(66946007)(54906003)(2616005)(316002)(83380400001)(478600001)(53546011)(6486002)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3VXMTZyTWdoR3VJdFRlTGVpdXpwanNjTDVLbTdKaXVnNVJwR1hUNy9Md3M1?=
 =?utf-8?B?cGVHaHMyYmpwcGpZa1NOWlNxN1Nlb2RCWGVWK243cG5ZcXNQTHFKRFVxNnRq?=
 =?utf-8?B?L0h5OVA5RnVORkdVV0dDSEJvMEQwcEIvbzJiQzVFcEx2MkpJUkZ3NlhERXox?=
 =?utf-8?B?Mm0zNHhUZlBRMSt1QVh0N2d3a2xnakR2MUYxc1htc24xZGtRbVgvd3YyUGhO?=
 =?utf-8?B?WFFEVlk5LzBpS1NYMUVWRFp5QldWeXN3akV1eWlUWnBreFhHMjZmREE3YVhn?=
 =?utf-8?B?U3lGMGs2cWZObzd2Sldsc2lyRlRIYmpubDU4N29QZmRaeExWQm54UVNNZWJO?=
 =?utf-8?B?MjBJcWVRekpuNlZBUEtQVitVbG1pVS9HZldndy9XQ200dUwycWdXT05oSktL?=
 =?utf-8?B?MUtXTnJra3RuRVJLckVmQ1JPdmhiZVNtWml1TUoyVno1Q0x5R0RyTG9zZWlY?=
 =?utf-8?B?UGNqcXlxY0xhQ0lMSWlDZDk2YWJvNWlIZ2VoUDhxa0dIa2VVbDFSSzlWa25q?=
 =?utf-8?B?WlNicHNvR2RXVXZVWXRLeDRTWUsra0h2S3A1eUxZd2wyUWZkYnRIbDJsS1Yx?=
 =?utf-8?B?VW1WZWZtVzMyM0VTSEVjRWtwODRheHZLUlJvQmg0UTh4L0lUMGttTG40ZXVx?=
 =?utf-8?B?NGQveGZrQjBoYWNUcWRtZ0t6MEgrYnBnQ0ZKTlBTd2VpMlNlemN3cXg2Y0Q0?=
 =?utf-8?B?S3hYanphNjZVTU9nVzlPZ2poaG5XQXR1OVFMVUpiS0s4a2lqOUxMK09EMlJn?=
 =?utf-8?B?cXZoYlp6VEFwTDcrc0N4MmxjbmxSSlo4VmZiekVXRS9qcERhWHZZZW9KU0VN?=
 =?utf-8?B?bnFnRjZmbEkwNVFjcUFZTXV0SnpGc1ZZSThMQVJReTU5YUpmOWxRUkE5bS9C?=
 =?utf-8?B?aG9mcFBsN1BBVjhuU1h6R1k2VmdjeG5IbFZuRHd5Z3d2dlMxT0Q1WWNpcWU3?=
 =?utf-8?B?MjR3VVl3T1dGclNvMWhhaVBCcXA5VEdVQ29wcHBaQ0pab2VoMXp5TEFRTWNw?=
 =?utf-8?B?MmlWeTZJZEE1bFYzTUdOTGo4RlB4alV1cndMT2tGekxRcXpFeEY4cGFvYzgw?=
 =?utf-8?B?QThFaExKczVWalFMRXZZUHZ0NlBWMWY3T1VWZDFsTVBLemFRWkdlWDZBNWox?=
 =?utf-8?B?RTRpdElqbUFlOUh1UFBiNi8rN0pLeVVjZ0IrcmxSYXg3VzM1NHVEQ1JBdkZO?=
 =?utf-8?B?Y0pzR1puSndPaFZBeGNlNDJoOXFnOGpEczVFQUN3K2Vld0xtUHR0YzFGU2d3?=
 =?utf-8?B?WVFhVG9yV0dxUXIzbDNkdUFxK3VYN2dYbUI0RlBiU1VuRGl2N05IbHhicnpp?=
 =?utf-8?B?NHkvOW5yOGlXUllmZzNFTHcxeWN2M1ZKZ09yOFNTdUhnZHJyZGpUSEwvWlcv?=
 =?utf-8?B?cEFlZkFZK3N0Q2ZoQUdYbVdhdnl1Yis1UnRScnZ6NzZVUDlZT0xnVlg0VkhL?=
 =?utf-8?B?RTNNVjJjMlpGYmRNZVFmcEZDMHVEYmVWR3RjOHF3ZTRLY3pWUXVhZTBqc3ZU?=
 =?utf-8?B?N0Y3cm1sN2NWbGFRbm5VZXFkazM2aFFXR25HcDBZRE85STFFRkVXYm56UkxL?=
 =?utf-8?B?RStyNC9JQkdmcytoNEx4dmJLc3NVWTVLb1M3WG1mOGJtR1VFSGNxVncwdUlr?=
 =?utf-8?B?UmdCL3YvNGlrc01zV3BrWjUwWDlZWmpnNGtqOXpqSUt3TlR4OFJpRStBR0I1?=
 =?utf-8?B?R0ZPV2doSEppWjE3UnlLU1BBQUlDeU5JeCt5MFFOM0dzY3lMWDlHdXErZWFM?=
 =?utf-8?B?QUgxak5VT0FGTlhjOG14MU12UzN0UjlQOTRZQ2lScktPSkZDRm44WDk0VG82?=
 =?utf-8?B?N3FBdi84QzZZTkhzL1hlbGdaMHdteC9yYk8xZDZDZU1kMERVVHRDN3hkdkVx?=
 =?utf-8?B?L0dhbGszMHpzeWRJeGNGaUZDSWd4RGhpSEpoRkVlSnV2WGQ5SzEvMHF0K1hl?=
 =?utf-8?B?Z3RyWHM3REZRVE5lY2pmK1E2dWhNNXpUOWsvZE96ZWk4YnE0Y3R3TyttazEw?=
 =?utf-8?B?aXNnODZERCs1N2dwWEY1SFMyQUV4L3JXT2E1ejBuU2RFa2dlOWRJSklzeFlC?=
 =?utf-8?B?MDA5dURjMlNwc3pkOGdWUll0a0x3UTFGVEVzaFJPZEYra1NHM3FUOHlBeXFm?=
 =?utf-8?Q?MbeAJHtGN5ywR3Uvg66Drk/MA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bd239d-8ccf-41da-e6c2-08dbd58d3776
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 19:04:30.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wST7KqJZ8mqgBlXdbs0tZKRvnWiixcUSOoJCeIxALkxbp+pZBI/0cAycC+1+3U3PyjQ6ao39XY95wHuedSLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2023 12:01, Ingo Molnar wrote:
> 
> * Mario Limonciello <mario.limonciello@amd.com> wrote:
> 
>> +Tom
>>
>> On 10/24/2023 03:36, Ingo Molnar wrote:
>>>
>>> * Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>
>>>> If x2apic was enabled during boot with parallel startup
>>>> it will be needed during resume from suspend to ram as well.
>>>>
>>>> Store whether to enable into the smpboot_control global variable
>>>> and during startup re-enable it if necessary.
>>>>
>>>> Cc: stable@vger.kernel.org # 6.5+
>>>> Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    arch/x86/include/asm/smp.h   |  1 +
>>>>    arch/x86/kernel/acpi/sleep.c | 12 ++++++++----
>>>>    arch/x86/kernel/head_64.S    | 15 +++++++++++++++
>>>>    3 files changed, 24 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
>>>> index c31c633419fe..86584ffaebc3 100644
>>>> --- a/arch/x86/include/asm/smp.h
>>>> +++ b/arch/x86/include/asm/smp.h
>>>> @@ -190,6 +190,7 @@ extern unsigned long apic_mmio_base;
>>>>    #endif /* !__ASSEMBLY__ */
>>>>    /* Control bits for startup_64 */
>>>> +#define STARTUP_ENABLE_X2APIC	0x40000000
>>>>    #define STARTUP_READ_APICID	0x80000000
>>>>    /* Top 8 bits are reserved for control */
>>>> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
>>>> index 6dfecb27b846..29734a1299f6 100644
>>>> --- a/arch/x86/kernel/acpi/sleep.c
>>>> +++ b/arch/x86/kernel/acpi/sleep.c
>>>> @@ -11,6 +11,7 @@
>>>>    #include <linux/dmi.h>
>>>>    #include <linux/cpumask.h>
>>>>    #include <linux/pgtable.h>
>>>> +#include <asm/apic.h>
>>>>    #include <asm/segment.h>
>>>>    #include <asm/desc.h>
>>>>    #include <asm/cacheflush.h>
>>>> @@ -129,11 +130,14 @@ int x86_acpi_suspend_lowlevel(void)
>>>>    	 */
>>>>    	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
>>>>    	/*
>>>> -	 * Ensure the CPU knows which one it is when it comes back, if
>>>> -	 * it isn't in parallel mode and expected to work that out for
>>>> -	 * itself.
>>>> +	 * Ensure x2apic is re-enabled if necessary and the CPU knows which
>>>> +	 * one it is when it comes back, if it isn't in parallel mode and
>>>> +	 * expected to work that out for itself.
>>>>    	 */
>>>> -	if (!(smpboot_control & STARTUP_PARALLEL_MASK))
>>>> +	if (smpboot_control & STARTUP_PARALLEL_MASK) {
>>>> +		if (x2apic_enabled())
>>>> +			smpboot_control |= STARTUP_ENABLE_X2APIC;
>>>> +	} else
>>>>    		smpboot_control = smp_processor_id();
>>>
>>> Yeah, so instead of adding further kludges to the 'parallel bringup is
>>> possible' code path, which is arguably a functional feature that shouldn't
>>> have hardware-management coupled to it, would it be possible to fix
>>> parallel bringup to AMD-SEV systems, so that this code path isn't a
>>> quirk-dependent "parallel boot" codepath, but simply the "x86 SMP boot
>>> codepath", where all SMP x86 systems do a parallel bootup?
>>>
>>> The original commit by Thomas says:
>>>
>>>     0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
>>>
>>>     | Unfortunately there is no RDMSR GHCB protocol at the moment, so enabling
>>>     | AMD-SEV guests for parallel startup needs some more thought.
>>>
>>> But that was half a year ago, isn't there RDMSR GHCB access code available now?
>>>
>>> This code would all read a lot more natural if it was the regular x86 SMP
>>> bootup path - which it is 'almost' today already, modulo quirk.
>>>
>>> Obviously coupling functional features with hardware quirks is fragile, for
>>> example your patch extending x86 SMP parallel bringup doesn't extend the
>>> AMD-SEV case, which may or may not matter in practice.
>>>
>>> So, if it's possible, it would be nice to fix AMD-SEV systems as well and
>>> remove this artificial coupling.
>>
>> It probably isn't clear since I didn't mention it in the commit message, but
>> this is not a system that supports AMD-SEV.  This is a workstation that
>> supports x2apic.  I'll clarify that for V2.
> 
> Yes, I suspected as much, but that's irrelevant to the arguments I
> outlined, that extending upon this quirk that makes SMP parallel bringup HW
> environment dependent, and then coupling s2ram x2apic re-enablement to that
> functional feature is inviting trouble in the long run.
> 

I spent some more time looking at ways to decouple this, and AFAICT 
thaw_secondary_cpus() doesn't actually bring CPUs back after resume in 
parallel mode.

To be symmetrical with that, another way to solve this that removes the 
"HW environment" aspect is to disable parallel boot for resume from 
sleep entirely.

Like this:

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 6dfecb27b846..9265d97f497b 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -128,13 +128,12 @@ int x86_acpi_suspend_lowlevel(void)
          * value is in the actual %rsp register.
          */
         current->thread.sp = (unsigned long)temp_stack + 
sizeof(temp_stack);
-       /*
-        * Ensure the CPU knows which one it is when it comes back, if
-        * it isn't in parallel mode and expected to work that out for
-        * itself.
+       /*
+        * Don't use parallel startup for resume from sleep. This avoids
+        * hangs that may occur if x2apic was in use but platform
+        * has not enabled x2apic on it's own after resume.
          */
-       if (!(smpboot_control & STARTUP_PARALLEL_MASK))
-               smpboot_control = smp_processor_id();
+       smpboot_control = smp_processor_id();
  #endif
         initial_code = (unsigned long)wakeup_long64;
         saved_magic = 0x123456789abcdef0L;


> For example, what guarantees that the x2apic will be turned back on after
> suspend if a system is booted with maxcpus=1?

lapic_resume() will do this after the boot CPU makes it up.

> 
> Obviously something very close to your fix is needed.
> 

Given lapic_resume() handles this, I'd think with the style fixups you 
suggested my patch is appropriate.

>> I've looped Tom in to comment whether it's possible to improve AMD-SEV as
>> well.
> 
> Thanks!
> 
> 	Ingo

