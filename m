Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39E3802D3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjLDIc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjLDIc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:32:56 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D429CB;
        Mon,  4 Dec 2023 00:33:02 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5bdf5a025c1so1315721a12.0;
        Mon, 04 Dec 2023 00:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701678781; x=1702283581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Advb7V7bj8dm13r6lPZP6Jts0Sh9p9KagVsoPO4PQVE=;
        b=CKN8PGBXpMUZ0ytWn9old+DLFDleRgExn7WOiY8NbOsFMEcsH35PPMQ2HSxtqKs9Zl
         BRPjOey/rswDAppIy8KhFib90uv8maLrpdpiXBy++1VW8G/pGG1qs8DRSeP1Rwg5eKJY
         G56kvWZC4wFsCiw0O9xQKJ5jpcrPry3Kdpd+dmiwHVtkZQBma2f8Ftp4/jStt4DMW5ig
         wR0EWSEDhqE5ZnxkCTDWi6i6HWyIZ/fv0SJacqKERO599Bh+OgYNm0+NC0L4cbLIFt2q
         jFuK78WXaR3rFb3ZymCwCKWgRHWcYzx8LzrMqoOUC/2aP53AkNQt+bnqpHd14Yd51Bap
         KDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701678781; x=1702283581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Advb7V7bj8dm13r6lPZP6Jts0Sh9p9KagVsoPO4PQVE=;
        b=KN6db8e/cdIPbz2zhMbCg0PjBQ/FjtB13u3HtGCk/ZkI0F3N+2o3KZpbEATCgSf89p
         HOkzJZaSdJ6L3nkZz7oo6hHHA1KpXnOHAXILOgZ78k28oHz0rj+5VR9cYa2t+ciHIxwy
         qF12FJ9YoKZAlGRHAJoZFah4ya1lJend8k7Jjle1FlQUgkFlwoNkuc14joz56e857uuu
         PhTYqhvWNWMdOvJRn7VrX10HbOGTEcoRV0x1DAv+fnusXLv3IEHjJ1d+PRtPsHf69Rkc
         oaV0BX8P+d7M/rz3iqIN54FPqnBt6SAjsip5TqdGTCSoBDeGHg34VH8LT5tXdzxLImgi
         DllQ==
X-Gm-Message-State: AOJu0YzCwvSBZTHjjxOuUPet077mEC9Ep9rRsbI3tNabJc/EkIy6Q5Ld
        Os5PEuUSVvg3UPAKJhsoTRI=
X-Google-Smtp-Source: AGHT+IHWFOozyvFUgBNvi6yWKfp9T/b7egs+hPp6lsgZX7YZHydYfBNk7Xp+tt6E+q1GhY/aRW8kpA==
X-Received: by 2002:a05:6a20:ce4d:b0:187:96e0:33c with SMTP id id13-20020a056a20ce4d00b0018796e0033cmr1947281pzb.45.1701678781390;
        Mon, 04 Dec 2023 00:33:01 -0800 (PST)
Received: from [192.168.255.10] ([43.132.98.41])
        by smtp.gmail.com with ESMTPSA id j8-20020aa783c8000000b006c320b9897fsm7110104pfn.126.2023.12.04.00.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:33:00 -0800 (PST)
Message-ID: <812822c4-8f24-4fc5-81eb-335abe46baa5@gmail.com>
Date:   Mon, 4 Dec 2023 16:32:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86/pmu: Prevent any host user from enabling PEBS
 for profiling guest
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>
References: <20231129095055.88060-1-likexu@tencent.com>
 <6c4bd247-1f81-4b43-9e21-012f831d26b8@linux.intel.com>
 <fd847e77-0510-48db-ad0b-5946458e2fb3@gmail.com>
 <84903edf-96a7-40da-8bbb-52511b4ec893@linux.intel.com>
 <df0b75de-a984-46fe-80e9-3c19b651883f@gmail.com>
 <444c0244-e377-4b4d-b3f0-a9404f013b87@linux.intel.com>
Content-Language: en-US
From:   Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <444c0244-e377-4b4d-b3f0-a9404f013b87@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2023 10:38 pm, Liang, Kan wrote:
> 
> 
> On 2023-11-30 10:59 p.m., Like Xu wrote:
>> On 30/11/2023 11:49 pm, Liang, Kan wrote:
>>>
>>>
>>> On 2023-11-30 2:29 a.m., Like Xu wrote:
>>>> On 29/11/2023 10:38 pm, Liang, Kan wrote:
>>>>>
>>>>>
>>>>> On 2023-11-29 4:50 a.m., Like Xu wrote:
>>>>>> From: Like Xu <likexu@tencent.com>
>>>>>>
>>>>>> Stop using PEBS counters on host to profiling guest. Limit the
>>>>>> range of
>>>>>> enabled PEBS counters to only those counters enabled from the guest
>>>>>> PEBS
>>>>>> emulation perspective.
>>>>>>
>>>>>> If there is a perf-record agent on host that uses perf-tools events
>>>>>> like
>>>>>> "cpu-cycles:GP" (G for attr.exclude_host, P for max precise event
>>>>>> counter)
>>>>>> to capture guest performance events, then the guest will be hanged.
>>>>>> This is
>>>>>> because Intel DS-based PEBS buffer is addressed using the 64-bit
>>>>>> linear
>>>>>> address of the current {p/v}CPU context based on MSR_IA32_DS_AREA.
>>>>>>
>>>>>> Any perf user using PEBS counters to profile guest on host is, in
>>>>>> perf/core
>>>>>> implementation details, trying to set bits on
>>>>>> cpuc->intel_ctrl_guest_mask
>>>>>> and arr[pebs_enable].guest, much like the guest PEBS emulation
>>>>>> behaviour.
>>>>>> But the subsequent PEBS memory write, regardless of whether guest
>>>>>> PEBS is
>>>>>> enabled, can overshoot guest entry and corrupt guest memory.
>>>>>>
>>>>>> Profiling guest via PEBS-DS buffer on host is not supported at this
>>>>>> time.
>>>>>> Fix this by filtering the real configured value of
>>>>>> arr[pebs_enable].guest
>>>>>> with the emulated state of guest enabled PEBS counters, under the
>>>>>> condition
>>>>>> of none cross-mapped PEBS counters.
>>>>>
>>>>> So the counter will be silently disabled. The user never knows why
>>>>> nothing is sampled.
>>>>> Since we don't support the case, profiling guest via PEBS-DS buffer on
>>>>> host. Maybe we should error out when creating the event. For example
>>>>> (not tested),
>>>>
>>>> Test failed.
>>>>
>>>>>
>>>>> diff --git a/arch/x86/events/intel/core.c
>>>>> b/arch/x86/events/intel/core.c
>>>>> index 3871267d3237..24b90c70737f 100644
>>>>> --- a/arch/x86/events/intel/core.c
>>>>> +++ b/arch/x86/events/intel/core.c
>>>>> @@ -3958,6 +3958,10 @@ static int intel_pmu_hw_config(struct perf_event
>>>>> *event)
>>>>>             if ((event->attr.config & INTEL_ARCH_EVENT_MASK) ==
>>>>> INTEL_FIXED_VLBR_EVENT)
>>>>>                 return -EINVAL;
>>>>>
>>>>> +        /* Profiling guest via PEBS-DS buffer on host is not
>>>>> supported. */
>>>>> +        if (event->attr.exclude_host)
>>>>> +            return -EINVAL;
>>>>> +
>>>>
>>>> Guest PEBS emulation also sets this bit, a typical call stack looks
>>>> like:
>>>>
>>>>       intel_pmu_hw_config+0x441/0x4d0
>>>>       hsw_hw_config+0x12/0xa0
>>>>       x86_pmu_event_init+0x98/0x370
>>>>       perf_try_init_event+0x47/0x130
>>>>       perf_event_alloc+0x446/0xeb0
>>>>       perf_event_create_kernel_counter+0x38/0x190
>>>>       pmc_reprogram_counter.constprop.17+0xd9/0x230 [kvm]
>>>>       kvm_pmu_handle_event+0x1a6/0x310 [kvm]
>>>>       vcpu_enter_guest+0x1388/0x19b0 [kvm]
>>>>       vcpu_run+0x117/0x6c0 [kvm]
>>>>       kvm_arch_vcpu_ioctl_run+0x13d/0x4d0 [kvm]
>>>>       kvm_vcpu_ioctl+0x301/0x6e0 [kvm]
>>>>
>>>
>>> Oh right, the event from the KVM guest is also exclude_host.
>>> So we should only error out with the non-KVM exclude_host PEBS event.
>>>
>>>> Alternatively, this path is taken when using PEBS-via-PT to profile
>>>> guests on host.
>>>
>>> There is a is_pebs_pt(event), so we can skip the PEBS-via-PT.
>>>
>>> Seems we just need to distinguish a KVM event and a normal host event.
>>> I don't have a better way to do it except using
>>> event->overflow_handler_context, which is NULL for a normal host event.
>>
>> The assumption that event->overflow_handler_context == NULL is unsafe,
>> considering .overflow_handler_context hook has its acclaimed generality.
>>
> 
> Yes, I agree it's very hacky.
> 
> What we need here is a way to distinguish the KVM guest request from the
> others. How about the PF_VCPU flag?
> 
>   	if (event->attr.exclude_host &&
>   		!is_pebs_pt(event) &&
>   		(!(event->attach_state & PERF_ATTACH_TASK) || !(current->flags &
> PF_VCPU))
>   			return -EINVAL;

Unfortunately, the tests are not passed w/ the above diff.
But it's good to know that there is PF_VCPU and more things to play around with.

The AMD IBS also takes the precise path, but it puts the recorded values
on group of MSRs instead of the linear address-based memory.

The root cause of this issue is the hardware limitation, just like what we did
in the commit 26a4f3c08de4 ("perf/x86: disable PEBS on a guest entry"),
a similar fix should also belong in the context of directly configuring
VMX-switch related hardware configuration values.

I haven't find a better location than intel_guest_get_msrs().

> 
> 
>> I understand your motivation very well, but this is not the right move
>> (based on my previous history of being sprayed by Peter). For perf/core,
>> in-kernel perf_events should be treated equally, and the semantics of
>> kvm_pmu should only be accounted when a perf/core API is only used for
>> guest-only path. In this case for KVM perf_events, intel_guest_get_msrs()
>> and x86_pmu_handle_guest_pebs() have this context.
>>
>>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index a968708ed1fb..c93a2aaff7c3 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -3958,6 +3958,16 @@ static int intel_pmu_hw_config(struct perf_event
>>> *event)
>>>            if ((event->attr.config & INTEL_ARCH_EVENT_MASK) ==
>>> INTEL_FIXED_VLBR_EVENT)
>>>                return -EINVAL;
>>>
>>> +        /*
>>> +         * Profiling guest via PEBS-DS buffer on host is not supported.
>>> +         * The event->overflow_handler_context is to distinguish a KVM
>>> +         * event and a normal host event.
>>> +         */
>>> +        if (event->attr.exclude_host &&
>>> +            !is_pebs_pt(event) &&
>>> +            !event->overflow_handler_context)
>>> +            return -EINVAL;
>>> +
>>>            if (!(event->attr.freq || (event->attr.wakeup_events &&
>>> !event->attr.watermark))) {
>>>                event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
>>>                if (!(event->attr.sample_type &
>>>
>>>>
>>>> The status of the guest can only be queried in the NMI handler and
>>>> the func
>>>> intel_guest_get_msrs() in the perf/core context, where it's easier
>>>> and more
>>>> centrally to review this part of changes that affects vPMU for corner
>>>> cases.
>>>>
>>>> Maybe adding print info on the perf-tool side would help.
>>>>
>>>> For perf-tool users, it will get 0 number of sample for "cpu-cycles:GP"
>>>> events,
>>>> just like other uncounted perf-tool events.
>>>
>>> perf-tool would never know such details, e.g., whether the platform
>>> supports PEBS-DS or other PEBS method. It's hard to tell if the 0 is
>>> because of an unsupported hardware or nothing sampled in the guest.
>>
>> It kind of looks like this use case to me:
>>
>>      perf record -e cycles -e cpu/event=0xf4,umask=0x10/ ./workload # ICX
>>
>> # Total Lost Samples: 0
>> #
>> # Samples: 0  of event 'cpu/event=0xf4,umask=0x10/'
>> # Event count (approx.): 0
>>
>> A end-user has to check if the event-umask combination is supported or not,
>> or nothing sampled for the workload. Is there any room for improvement in
>> perf-tool to reduce the pain of this part ? If any, the same thing could
>> be applied
>> to cpu-cycles:GP, isn't it ?
> 
> I don't think we can expect the end user knows such details. Most of
> them may even don't know what's PEBS-via-DS.

Maybe the following generic reminder helps:

# Total Lost Samples: 0
# Note: the event is not counted or unsupported.
#
# Samples: 0  of event 'cpu/event=0xf4,umask=0x10/'
# Event count (approx.): 0

> 
> Thanks,
> Kan
> 
>>
>>>
>>> Thanks,
>>> Kan
>>>>
>>>>>             if (!(event->attr.freq || (event->attr.wakeup_events &&
>>>>> !event->attr.watermark))) {
>>>>>                 event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
>>>>>                 if (!(event->attr.sample_type &
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Kan
>>>>>
>>>>>>
>>>>>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>>>> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR
>>>>>> emulation for extended PEBS")
>>>>>> Signed-off-by: Like Xu <likexu@tencent.com>
>>>>>> ---
>>>>>>     arch/x86/events/intel/core.c | 8 +++++++-
>>>>>>     1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/x86/events/intel/core.c
>>>>>> b/arch/x86/events/intel/core.c
>>>>>> index a08f794a0e79..17afd504c35b 100644
>>>>>> --- a/arch/x86/events/intel/core.c
>>>>>> +++ b/arch/x86/events/intel/core.c
>>>>>> @@ -4103,13 +4103,19 @@ static struct perf_guest_switch_msr
>>>>>> *intel_guest_get_msrs(int *nr, void *data)
>>>>>>             .guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
>>>>>>         };
>>>>>>     +    /* In any case, clear guest PEBS bits first. */
>>>>>> +    arr[global_ctrl].guest &= ~arr[pebs_enable].guest;
>>>>>> +
>>>>>>         if (arr[pebs_enable].host) {
>>>>>>             /* Disable guest PEBS if host PEBS is enabled. */
>>>>>>             arr[pebs_enable].guest = 0;
>>>>>>         } else {
>>>>>>             /* Disable guest PEBS thoroughly for cross-mapped PEBS
>>>>>> counters. */
>>>>>>             arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
>>>>>> -        arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
>>>>>> +
>>>>>> +        /* Prevent any host user from enabling PEBS for profiling
>>>>>> guest. */
>>>>>> +        arr[pebs_enable].guest &= (kvm_pmu->pebs_enable &
>>>>>> kvm_pmu->global_ctrl);
>>>>>> +
>>>>>>             /* Set hw GLOBAL_CTRL bits for PEBS counter when it runs
>>>>>> for guest */
>>>>>>             arr[global_ctrl].guest |= arr[pebs_enable].guest;
>>>>>>         }
>>>>>>
>>>>>> base-commit: 6803fb00772cc50cd59a66bd8caaee5c84b13fcf
