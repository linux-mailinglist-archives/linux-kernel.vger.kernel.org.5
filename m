Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047D37DD654
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjJaSxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjJaSxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:53:44 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48458F;
        Tue, 31 Oct 2023 11:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npbnEiy2JhMhW9LEKONeQ9tC5DBR88bhr/pzoj/uzP5jEBwf4Nla0Xrc00uv8NmZ5+1TBBToFKDcwW8n0R9HiXXqAL5kp79RpeidrIIvyHqcwOX4DYuxpWFzSWd2MLwpxwN6EdHQM6ZaDsCQk/nJcOp2a396j5q1MNCd7fO3GPOBmsGTNx7A+bKoH3OA8BXHs1G8SpTBLoZ+sAIKXsOJZqO/EI6WEDhasNH2+PGPnmZU5L8xgwOf3PCtuU8aWNQB5iVq6fWEZ2EiR7vv6tlNxRProwizpLD6vVm8mkgLx2Fx+2vAcZHyGlIMhBULuI8ENM+To3a34Aw1JLJtGvpnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyvNgwkWfFoErPJ0vheMT8iA/1DTLJwbarl0SEiidH8=;
 b=LjDz6tFq9Tf3zHylpvIlHUswbAv8twsH3TxbYOD0iQP6cLgrURgnCsakY59w23Gd4uY6aWJDjjrtwsIoulVJ7QSmCBtkCQ+nABRyOcS4eI9IOsvl75gZqKVH5IYklQvCvz7K3K9huc1fCkZOYQyMB3gH1z+NkiIsS2qewqTeAAfPzUnrvq4mABoWSMXLzWDmnjm7n0DRhZAQX+m3cTOB/+ZvPbR2No4vx+vRgpmiR/saRV23PvKVYoOKiQ+jaQAM8vJniNl1OtNW7hWPg7QCQEtsCM4tE5+L/WDG5bFCaUts70/vTBK+mii4mOXxghrqnWRgCNhdjyjvIqftQkG0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyvNgwkWfFoErPJ0vheMT8iA/1DTLJwbarl0SEiidH8=;
 b=0Op1xpMtx+F0K/JKg/3/t5pnrzCMzbyCiHBeZSDg0wjCuCQzrxHDaDOq1hnqL/CvK/j+ks5vOo4O6Go8X+8gFhRHwX6HKdjmywE5eKM12cF20s39k9hsL+TE9O6IJndBBbBuw/y9JA28KYDTopKoTg0KuGQpz+Lboxz3OffTkkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 18:53:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 18:53:38 +0000
Message-ID: <d7c3a03e-6f52-4bcf-aaae-668f6601ceb8@amd.com>
Date:   Tue, 31 Oct 2023 13:53:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86: Enable x2apic during resume from suspend if
 used previously
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sandipan Das <sandipan.das@amd.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
 <20231026170330.4657-2-mario.limonciello@amd.com> <87wmv721nm.ffs@tglx>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87wmv721nm.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 575b6d22-b5b0-41b0-48cc-08dbda42b118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXDUYoVren6HgFgxkn4WLHIcNRpMUOdlKKscYhs9/v8vlWOyRI1uwChz3qDbVz5EuFx5lVLE9MsiY1Z5xfFjqTifd4JPRmOMT2+7RKX8MAAOIXaNAY2k8OJFms4ht8wRTq+UKEotXkq2ow57i94xLaybeULIDEhnBqhY16RAE1dK7XImV2TBdB0YQqCjCiqNs4ZQ4MOVPl8AvK90HiPEhvRhCEwvQFslp5KaYHxi1CYN4905jkTZZMZQNWbsuYzk7Q05houvvia9kQuFzrEAKVb+1fcGCvCV5egjkvbidPpzzT9gVw5hfYZhG1GhFbVmh9LmaOC211BHIVpqHnSZtTjiw0dnGp1q/U3uuZ5WtuFhj+BrdsWjuodDL7TtDSDGn7Y5J2MuTPFvB0K+2YDBYBLvuA7iPTp7X+WG16DPLJehPFzzRoADHYcCh0eY0AySR5TQwKvRKIpnVMFlawuCJPdyx+XF34kG6qmqBwmsb+LjttXeDGmt5lbYYUItG6abqqDZmQ/Lv1CoMTiiPrl7G4ZT2WNH4YWV7F2jWuk5xsnTLWAgI4YAo0G16mePtQ/bI0f266NEdWmzXWP5SCv/L4SI0zTQ3vxaYD+LUQDP9LPuod80vQnhJ1V/yeu+5Ixmou5FD03KWH6el8Wt1WIx2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6506007)(6512007)(53546011)(2616005)(38100700002)(36756003)(86362001)(31696002)(83380400001)(5660300002)(15650500001)(7416002)(8676002)(66946007)(66476007)(316002)(110136005)(66556008)(54906003)(2906002)(8936002)(44832011)(31686004)(6666004)(4326008)(6486002)(478600001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWYyNHhEaWNZa1ZETUppVEo0SFZ5RGRHaVhtbko1Q09nczArQlQ0cW5GU09t?=
 =?utf-8?B?TUpQa2N5ZEhyU09KbmRtTXNpdmlVdHJzbm1RQWJ3V3B0UElDVm5mb3YyOUV1?=
 =?utf-8?B?aWN2THhsdDhMeUplbWQySk9Uc29CSGY4NHFVQ25sQ0tLdEczYTA2dGlHNE5j?=
 =?utf-8?B?bkJhSVVCbnU5aWR1Mjc1KzllMXpUR0RyYnVPc2JCb3hZbFVZL1RhSU9sM0Fz?=
 =?utf-8?B?Z1BNaFFJVlVLalRMV1NCbjJtZzhzZzFwUS96dVpXa1JsRk05Q2ZwTjd0Yndw?=
 =?utf-8?B?MlZLTVRWdE1wMUlwNmJQcERidUpPcnFNcW45VWt3c1o0N2h1Q3V1bVdWaTFO?=
 =?utf-8?B?SitPVVFhTXhTblE2Rk94K0wvWVNWbW5YcWRRbVQ0MEtDK3hVRmQwdmw3RjNJ?=
 =?utf-8?B?bVZid3VpYldrSFZkdnpJa3M1NlVxWEsrcGhSR05oODZVblVLN2NSL2VEc1RK?=
 =?utf-8?B?TlBzaGxyR1lITVJUQTNZUmFxZzJKU3BCU3E2MUY0cEtMOStuSisvVHlpcjI1?=
 =?utf-8?B?Skhjc1lRaFJ4d1oxSmJVeWJnalBXL29mekxsUDZHcGRIQXVTbDgxeUtlcTZO?=
 =?utf-8?B?ZlcrVjJ0dGkyVHR4QXY5ejVxTWtUd2JEdTRGUUxtUUtuV0lBOUhBa1I0ZVVv?=
 =?utf-8?B?eEhQYTU5YmhSS3hxS0ZocmVSQXZNWWtLQ2lYRnFwaFFCS2REcjY0QzJRS0Fo?=
 =?utf-8?B?SEJHNFM3bFBVdzVUbFErMy94dTJYQ25vRk1LN3hqbk9yS1dwazBBL3draFBF?=
 =?utf-8?B?cHVsZVIxNXEwbGkvOEZub2x1OVJsYVdUaVd3elNHQ1RqdEFqaHV5L1Ixdk5N?=
 =?utf-8?B?aW9HanFyUXpETnU3Zlgra0ErWk5aWEk1TUZPQTZqSllCSUZudll0bGlpZVlM?=
 =?utf-8?B?d0VodzFDa2JIMlBEWHBid3NPbEVzcmJEdnNrM0V1Y3lHSXcvYkVQVXBPTU16?=
 =?utf-8?B?dHhSU0hKYzFRSU8rV2tUcjFPNmJUeXZncG53QXQ1TnErQnJENXZ6VldCZkVG?=
 =?utf-8?B?cktDSXpvMHd6cnNVc002UlJpWUZiTWRrRlh5dkhZaG1welZoTzAzYXFyblBT?=
 =?utf-8?B?NlFuVThpdTh1VEk0SE9xQmlIVWNwYkY5M0taVW1yLzZKU2wwMklmVkhJdWpx?=
 =?utf-8?B?aGI2ZnltTXFLQ3M4VG1McDN4eUlPQmhZSnFrNkpJVXZscFA3cFlndUNQM3dl?=
 =?utf-8?B?WnVkaXo2Q3ZRSkJBZGsyWEg2ekI4S0hvOVFKa3doNXZIVFBpVlhodmlsQ1Fi?=
 =?utf-8?B?YjVHSmIwdlF0c3YvZExlZjREUTI0TWZtclhpQ1BJVjNKME1UcGY4UDRoTVBh?=
 =?utf-8?B?TnBoK0Q2Q281OHk0eEdZWTRHcHVTZ3JDbERZRSt5WFhSNTdyT1JxcXJ5T1RQ?=
 =?utf-8?B?VHVJVmlIZWJVRnN2bWk3UmN2TzVhKytzZ1BsamZvbmxWZlVIVU80aCtRVkti?=
 =?utf-8?B?QnJzM2dLa1NKMTdPUmtJWkRQaENJNlFGMmw2QmthZytNTFlJNnFhUGZnaGhq?=
 =?utf-8?B?M2wwSEtLRDhYWnVjK29qZTk2cE02a3pPTTZ3UklSNDlVT1FLNERSTHBCd2xH?=
 =?utf-8?B?Zm5XT2RkamdmclVkV1lxb1BCSVNQRlBHci9VdEJFNStqWkx5WTljVjBaVFha?=
 =?utf-8?B?WCtkU1pZbXY5bjJsejVMaHRmL1JzNGRXSGgxa2RWNDNDVjYybFNMR3RHZmhU?=
 =?utf-8?B?cW1Qbk5sMExqd3FaZ1h3S2xwazlTeW1JeEtqbkRJUmFzYTdvUzFlK281MklS?=
 =?utf-8?B?L1dSWXhEZnBPTWo3d0k5SnNZNnZyWVhrdExhZ0pscHVnUFRQRFpMT2JQTGgw?=
 =?utf-8?B?WHd2L0MyYVErdCtSN0ZxMUlCTTRYUFI1b2V5ME4xVFhrSlVkQ1RpeW5tMjNa?=
 =?utf-8?B?cFgvOHAxbjdGdFVVRUtnV0x0VnNxVlhmdUpGc1hRKzFsZldlakJWdzByd2ZO?=
 =?utf-8?B?NnYrR3kwQWhDNmJIdVpjYUl1NFlxZFJ5SU05NlRpRk1wUjZjcTVlbE5lRlBK?=
 =?utf-8?B?ckNteVBDZ21TZEk4SGpBOEJrY3pndmdlVDQvd1BYT3hlb3FLUHhoRlFwcGxX?=
 =?utf-8?B?WWhXRHlNS2RnR2NyMzArNzFXUkEwd1MzcVA3bnNNelQ4S3FFN1dZeHlVVEww?=
 =?utf-8?Q?5f2ucoggleA6waXPrHOjFmn2G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575b6d22-b5b0-41b0-48cc-08dbda42b118
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 18:53:37.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /O6FEORcVdo/cqlqErXw2cA/vBbinV2Z5jgR+npqk/c1ybhDDyRMgSwi60xQl3bcworYGfHitZ5C+FaxLk0gRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2023 16:31, Thomas Gleixner wrote:
> Mario!
> 
> On Thu, Oct 26 2023 at 12:03, Mario Limonciello wrote:
> 
>> If x2apic was enabled during boot with parallel startup
>> it will be needed during resume from suspend to ram as well.
> 
> Lacks an explanation why it is needed.
> 
>> Store whether to enable into the smpboot_control global variable
>> and during startup re-enable it if necessary.
>>
>> This fixes resume from suspend on workstation CPUs with x2apic
>> enabled.
> 
> You completely fail to describe the failure mode.
> 
>> It will also work on systems with one maxcpus=1 but still using
>> x2apic since x2apic is also re-enabled in lapic_resume().
> 
> This sentence makes no sense. What's so special about maxcpus=1?
> 
> Absolutely nothing.
> 
> lapic_resume() is a syscore op and is always invoked on the CPU which
> handles suspend/resume. The point is that __x2apic_enable() which is
> invoked from there becomes a NOOP because X2APIC is already enabled.
> 
> So what are you trying to tell me?
> 
> I really appreciate your enthusiasm of chasing and fixing bugs, but your
> change logs and explanations are really making it hard to keep that
> appreciation up.
> 
>>   	/*
>> -	 * Ensure the CPU knows which one it is when it comes back, if
>> -	 * it isn't in parallel mode and expected to work that out for
>> -	 * itself.
>> +	 * Ensure x2apic is re-enabled if necessary and the CPU knows which
>> +	 * one it is when it comes back, if it isn't in parallel mode and
>> +	 * expected to work that out for itself.
> 
> The x2apic comment is misplaced. It should be above the x2apic
> conditional as it has nothing to do with the initial condition because
> even if X2APIC is enabled then the parallel startup might be disabled.
> 
> Go and read this comment 3 month from now and try to make sense of it.
> 
>>   	 */
>> -	if (!(smpboot_control & STARTUP_PARALLEL_MASK))
>> +	if (smpboot_control & STARTUP_PARALLEL_MASK) {
>> +		if (x2apic_enabled())
>> +			smpboot_control |= STARTUP_ENABLE_X2APIC;
> 
> This bit is sticky after resume, so any subsequent CPU hotplug operation
> will see it as well.
> 
> This lacks an explanation why this is correct and why this flag is not
> set early during boot before the APs are brought up.
> 
>> +	} else {
>>   		smpboot_control = smp_processor_id();
>> +	}
>>   #endif
>>   	initial_code = (unsigned long)wakeup_long64;
>>   	saved_magic = 0x123456789abcdef0L;
>> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
>> index ea6995920b7a..300901af9fa3 100644
>> --- a/arch/x86/kernel/head_64.S
>> +++ b/arch/x86/kernel/head_64.S
>> @@ -237,9 +237,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>>   	 * CPU number is encoded in smpboot_control.
>>   	 *
>>   	 * Bit 31	STARTUP_READ_APICID (Read APICID from APIC)
>> +	 * Bit 30	STARTUP_ENABLE_X2APIC (Enable X2APIC mode)
>>   	 * Bit 0-23	CPU# if STARTUP_xx flags are not set
>>   	 */
>>   	movl	smpboot_control(%rip), %ecx
>> +
>> +	testl	$STARTUP_ENABLE_X2APIC, %ecx
>> +	jnz	.Lenable_x2apic
> 
> Why is this tested here? The test clearly belongs into .Lread_apicid
> 
>> +
>>   	testl	$STARTUP_READ_APICID, %ecx
>>   	jnz	.Lread_apicid
>>   	/*
>> @@ -249,6 +254,16 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>>   	andl	$(~STARTUP_PARALLEL_MASK), %ecx
>>   	jmp	.Lsetup_cpu
>>   
>> +.Lenable_x2apic:
>> +	/* Enable X2APIC if disabled */
>> +	mov	$MSR_IA32_APICBASE, %ecx
>> +	rdmsr
>> +	testl	$X2APIC_ENABLE, %eax
>> +	jnz	.Lread_apicid_msr
>> +	orl	$X2APIC_ENABLE, %eax
>> +	wrmsr
>> +	jmp	.Lread_apicid_msr
> 
> And this part just moves in front of .Lread_apicid_msr and spares
> the jump at the end.
> 
>>   .Lread_apicid:
>>   	/* Check whether X2APIC mode is already enabled */
>>   	mov	$MSR_IA32_APICBASE, %ecx
> 
> That aside, I'm still failing to see the actual failure scenario due to
> the utter void in the change log.
> 
> The kernel has two mechanisms which end up with X2APIC enabled:
> 
>      1) BIOS has it enabled already, which is required for any machine
>         which has more than 255 CPUs, but BIOS can decide to enable
>         X2APIC even with less than 256 CPUs.
> 
>      2) BIOS has not enabled it, but the kernel enables it because the
>         CPU supports it.
> 
> The major difference is:
> 
>      #1 prevents the MMIO fixmap for the APIC to be installed
> 
>      #2 installs the fixmap but does not use it. It's never torn down.
> 
> Let's look at these two cases in the light of resume:
> 
>      #1 If the BIOS enabled X2APIC mode then the only way how this can
>         fail on resume is that the BIOS did not enable X2APIC mode in the
>         resume path before going back into the kernel and due to the
>         non-existent MMIO mapping there is no way to read the APIC ID.
> 
>      #2 It does not matter whether the BIOS enabled X2APIC mode during
>         resume because the MMIO mapping exists and the APIC ID read via
>         MMIO should be identical to the APIC ID read via the X2APIC MSR.
> 
>         If not, then there is something fundamentally wrong.
> 
> How is this working during the initial bringup of the APs?
> 
>      #1 If the APs do not have X2APIC enabled by the BIOS then they will
>         crash and burn during bringup due to non-existent MMIO mapping.
> 
>      #2 The APs can read their APIC ID just fine via MMIO and it
>         obviously is the same as the APIC ID after the bringup enabled
>         X2APIC mode. Otherwise the kernel would not work at all.
> 
> So the only reasonable explanation for the failure is that the BIOS
> fails to reenable X2APIC mode on resume either on the CPU which handles
> suspend/resume or on the subsequent AP bringups, which is not clear at
> all due to the bit being sticky and the changelog being full of void in
> that aspect.
> 
> That said the sticky bit is wrong for the following case with older CPUs
> where X2APIC requires up to date microcode loaded to work correctly:
> 
>      boot maxcpus=4
>        load microcode    // Same sequence applies for AP (CPU1-3)
>        enable x2apic
>      suspend
>         set X2APIC enable bit in smpboot_control
>      resume
>      bringup CPU4
>         enable X2APIC early --> fail due to lack of microcode fix
> 
> Whether this affects the APIC ID readout or not, which we don't know and
> even if we consider this case to be academic, it's still fundamentally
> wrong from a correctness point of view.
> 
> So without proper information about the failure scenario this "fix" is
> simply going nowhere.
> 
> Please provide the following information:
> 
>    - dmesg of the initial boot up to 'smp: Bringing up secondary CPUs ...'
> 
>    - A proper description of the failure case:
> 
>      - Is the CPU which handles suspend/resume failing?
> 
>      - Is a subsequent AP bringup failing?
> 
>      - Is the failure due to the lack of MMIO mapping ?
> 
>      - Is the failure due to a bogus APIC ID retrieved via MMIO ?
> 
> Thanks for making me do your homework (again),
> 
>          tglx

Hi Thomas,

Thank you for looking this over.  I've reviewed it with the internal 
team and confirmed there was a BIOS bug where the MSR wasn't restored 
after the S3 cycle completed.  The BIOS team has fixed it.

Thanks,

#regzbot invalid: BIOS bug
