Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF71E800255
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377269AbjLAD7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAD72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:59:28 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5BC10C2;
        Thu, 30 Nov 2023 19:59:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf7a8ab047so1145305ad.1;
        Thu, 30 Nov 2023 19:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403174; x=1702007974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81XrNiZQgZf36KufRwONMta3Rb1RBjCzBii/wwluQWA=;
        b=dUenjQkK6Zgadpr4VXA9MRQuNlK8ebTw9Y7pG4MvEwNEON5v18rqrEz2jWtYxKaTnI
         AwNBx07c/OGDa5MmNwSs+a9dB7sUE6SUzr+h7CoedIWHNfEEw+khCOSSLDIXdJnJcRlk
         5zAIQpmUMxVXxLq2LV/UAjU4za6V9IOawU5LXxjf9M+MJIMYI6KClUWl5kodV8iuzQyd
         CQv2wD/jwGHfCFQ4asF19ad1DKzoHWLn4oGVF+AniAujuM0+VbOdeYP1ar+ikvcF/wCS
         Jx8sPtzuUE7nLQYAqwimlhM4hH3yCSyS5MoBFpPTilnhSDyXjT8KZwf/Veicuqhlu/SV
         RrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403174; x=1702007974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81XrNiZQgZf36KufRwONMta3Rb1RBjCzBii/wwluQWA=;
        b=MbIq7S7n/bMEzvVLm/hnXuM9E/B6j/WLR6x6yv0KU+8yolyk4XWgyNMaoZikCMya54
         6LM/aql9Qd0ySBEO3Jgf7bLW7fsvXplLneMttbHgbOFNsk7GijG8oD4ObOU6Qt/XTd4f
         uV6F6a0qSLbQj4QAD6xQ0ivfy2yWsNAuOzvgV9aT9yDccgFW3zQ764FjhSn/fySOPrFj
         ZpzTVHWb0eG6L+dEjICU0o4YAUoyntdYLxtdCyWXnXtgQTeGYwnX9/t9IDjUMrnItzG1
         +N0fAvc0UllRW/fMRBAHy6+gaTvzbFnXQzMjCKsJLXmEU1MVaRtrcA9AfxO+ywu4A8iF
         mrMw==
X-Gm-Message-State: AOJu0YyH5xH27kjtpV16jXdS6CLtzBQQwqeZlCKaG8VIWnLWeHQTxFuZ
        LJU1SbBmHDrxhP9vdHCYNMo=
X-Google-Smtp-Source: AGHT+IGhuRW+0mhDu4LFeos6SOAYx6h4eM2Ew5u1HKtDCuknbmuvPm+pTMLfqhjy1+EDGBMqgqeUjg==
X-Received: by 2002:a17:902:ab14:b0:1d0:4741:f983 with SMTP id ik20-20020a170902ab1400b001d04741f983mr2605107plb.47.1701403173963;
        Thu, 30 Nov 2023 19:59:33 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.111])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b001c74df14e6esm2208954plh.51.2023.11.30.19.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 19:59:33 -0800 (PST)
Message-ID: <df0b75de-a984-46fe-80e9-3c19b651883f@gmail.com>
Date:   Fri, 1 Dec 2023 11:59:29 +0800
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
Content-Language: en-US
From:   Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <84903edf-96a7-40da-8bbb-52511b4ec893@linux.intel.com>
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

On 30/11/2023 11:49 pm, Liang, Kan wrote:
> 
> 
> On 2023-11-30 2:29 a.m., Like Xu wrote:
>> On 29/11/2023 10:38 pm, Liang, Kan wrote:
>>>
>>>
>>> On 2023-11-29 4:50 a.m., Like Xu wrote:
>>>> From: Like Xu <likexu@tencent.com>
>>>>
>>>> Stop using PEBS counters on host to profiling guest. Limit the range of
>>>> enabled PEBS counters to only those counters enabled from the guest PEBS
>>>> emulation perspective.
>>>>
>>>> If there is a perf-record agent on host that uses perf-tools events like
>>>> "cpu-cycles:GP" (G for attr.exclude_host, P for max precise event
>>>> counter)
>>>> to capture guest performance events, then the guest will be hanged.
>>>> This is
>>>> because Intel DS-based PEBS buffer is addressed using the 64-bit linear
>>>> address of the current {p/v}CPU context based on MSR_IA32_DS_AREA.
>>>>
>>>> Any perf user using PEBS counters to profile guest on host is, in
>>>> perf/core
>>>> implementation details, trying to set bits on
>>>> cpuc->intel_ctrl_guest_mask
>>>> and arr[pebs_enable].guest, much like the guest PEBS emulation
>>>> behaviour.
>>>> But the subsequent PEBS memory write, regardless of whether guest
>>>> PEBS is
>>>> enabled, can overshoot guest entry and corrupt guest memory.
>>>>
>>>> Profiling guest via PEBS-DS buffer on host is not supported at this
>>>> time.
>>>> Fix this by filtering the real configured value of
>>>> arr[pebs_enable].guest
>>>> with the emulated state of guest enabled PEBS counters, under the
>>>> condition
>>>> of none cross-mapped PEBS counters.
>>>
>>> So the counter will be silently disabled. The user never knows why
>>> nothing is sampled.
>>> Since we don't support the case, profiling guest via PEBS-DS buffer on
>>> host. Maybe we should error out when creating the event. For example
>>> (not tested),
>>
>> Test failed.
>>
>>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 3871267d3237..24b90c70737f 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -3958,6 +3958,10 @@ static int intel_pmu_hw_config(struct perf_event
>>> *event)
>>>            if ((event->attr.config & INTEL_ARCH_EVENT_MASK) ==
>>> INTEL_FIXED_VLBR_EVENT)
>>>                return -EINVAL;
>>>
>>> +        /* Profiling guest via PEBS-DS buffer on host is not
>>> supported. */
>>> +        if (event->attr.exclude_host)
>>> +            return -EINVAL;
>>> +
>>
>> Guest PEBS emulation also sets this bit, a typical call stack looks like:
>>
>>      intel_pmu_hw_config+0x441/0x4d0
>>      hsw_hw_config+0x12/0xa0
>>      x86_pmu_event_init+0x98/0x370
>>      perf_try_init_event+0x47/0x130
>>      perf_event_alloc+0x446/0xeb0
>>      perf_event_create_kernel_counter+0x38/0x190
>>      pmc_reprogram_counter.constprop.17+0xd9/0x230 [kvm]
>>      kvm_pmu_handle_event+0x1a6/0x310 [kvm]
>>      vcpu_enter_guest+0x1388/0x19b0 [kvm]
>>      vcpu_run+0x117/0x6c0 [kvm]
>>      kvm_arch_vcpu_ioctl_run+0x13d/0x4d0 [kvm]
>>      kvm_vcpu_ioctl+0x301/0x6e0 [kvm]
>>
> 
> Oh right, the event from the KVM guest is also exclude_host.
> So we should only error out with the non-KVM exclude_host PEBS event.
> 
>> Alternatively, this path is taken when using PEBS-via-PT to profile
>> guests on host.
> 
> There is a is_pebs_pt(event), so we can skip the PEBS-via-PT.
> 
> Seems we just need to distinguish a KVM event and a normal host event.
> I don't have a better way to do it except using
> event->overflow_handler_context, which is NULL for a normal host event.

The assumption that event->overflow_handler_context == NULL is unsafe,
considering .overflow_handler_context hook has its acclaimed generality.

I understand your motivation very well, but this is not the right move
(based on my previous history of being sprayed by Peter). For perf/core,
in-kernel perf_events should be treated equally, and the semantics of
kvm_pmu should only be accounted when a perf/core API is only used for
guest-only path. In this case for KVM perf_events, intel_guest_get_msrs()
and x86_pmu_handle_guest_pebs() have this context.

> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index a968708ed1fb..c93a2aaff7c3 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3958,6 +3958,16 @@ static int intel_pmu_hw_config(struct perf_event
> *event)
>   		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) ==
> INTEL_FIXED_VLBR_EVENT)
>   			return -EINVAL;
> 
> +		/*
> +		 * Profiling guest via PEBS-DS buffer on host is not supported.
> +		 * The event->overflow_handler_context is to distinguish a KVM
> +		 * event and a normal host event.
> +		 */
> +		if (event->attr.exclude_host &&
> +		    !is_pebs_pt(event) &&
> +		    !event->overflow_handler_context)
> +			return -EINVAL;
> +
>   		if (!(event->attr.freq || (event->attr.wakeup_events &&
> !event->attr.watermark))) {
>   			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
>   			if (!(event->attr.sample_type &
> 
>>
>> The status of the guest can only be queried in the NMI handler and the func
>> intel_guest_get_msrs() in the perf/core context, where it's easier and more
>> centrally to review this part of changes that affects vPMU for corner
>> cases.
>>
>> Maybe adding print info on the perf-tool side would help.
>>
>> For perf-tool users, it will get 0 number of sample for "cpu-cycles:GP"
>> events,
>> just like other uncounted perf-tool events.
> 
> perf-tool would never know such details, e.g., whether the platform
> supports PEBS-DS or other PEBS method. It's hard to tell if the 0 is
> because of an unsupported hardware or nothing sampled in the guest.

It kind of looks like this use case to me:

	perf record -e cycles -e cpu/event=0xf4,umask=0x10/ ./workload # ICX

# Total Lost Samples: 0
#
# Samples: 0  of event 'cpu/event=0xf4,umask=0x10/'
# Event count (approx.): 0

A end-user has to check if the event-umask combination is supported or not,
or nothing sampled for the workload. Is there any room for improvement in
perf-tool to reduce the pain of this part ? If any, the same thing could be applied
to cpu-cycles:GP, isn't it ?

> 
> Thanks,
> Kan
>>
>>>            if (!(event->attr.freq || (event->attr.wakeup_events &&
>>> !event->attr.watermark))) {
>>>                event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
>>>                if (!(event->attr.sample_type &
>>>
>>>
>>> Thanks,
>>> Kan
>>>
>>>>
>>>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR
>>>> emulation for extended PEBS")
>>>> Signed-off-by: Like Xu <likexu@tencent.com>
>>>> ---
>>>>    arch/x86/events/intel/core.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index a08f794a0e79..17afd504c35b 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -4103,13 +4103,19 @@ static struct perf_guest_switch_msr
>>>> *intel_guest_get_msrs(int *nr, void *data)
>>>>            .guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
>>>>        };
>>>>    +    /* In any case, clear guest PEBS bits first. */
>>>> +    arr[global_ctrl].guest &= ~arr[pebs_enable].guest;
>>>> +
>>>>        if (arr[pebs_enable].host) {
>>>>            /* Disable guest PEBS if host PEBS is enabled. */
>>>>            arr[pebs_enable].guest = 0;
>>>>        } else {
>>>>            /* Disable guest PEBS thoroughly for cross-mapped PEBS
>>>> counters. */
>>>>            arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
>>>> -        arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
>>>> +
>>>> +        /* Prevent any host user from enabling PEBS for profiling
>>>> guest. */
>>>> +        arr[pebs_enable].guest &= (kvm_pmu->pebs_enable &
>>>> kvm_pmu->global_ctrl);
>>>> +
>>>>            /* Set hw GLOBAL_CTRL bits for PEBS counter when it runs
>>>> for guest */
>>>>            arr[global_ctrl].guest |= arr[pebs_enable].guest;
>>>>        }
>>>>
>>>> base-commit: 6803fb00772cc50cd59a66bd8caaee5c84b13fcf
