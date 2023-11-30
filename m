Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057517FE9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbjK3H36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344730AbjK3H35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:29:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399DA12C;
        Wed, 29 Nov 2023 23:30:03 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so590048a91.3;
        Wed, 29 Nov 2023 23:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701329402; x=1701934202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZpURYzVj3ww3XlYzCTphJ4gF4DoWItg5eveQZqQLlk=;
        b=ACVYNT3mn0II4Zj+jkziQcBjlH5dwXCPq1NompnfSYHxsbMdkyvdLrmNYFNc5SNYdE
         X0tUjZcARYZk3P356T3s/I8r0ZeR4edr2Od1kvE5WjK9nQDVagTPwzr/cKw+0TY8Nz62
         tlcjXrq+ac50v3vx6CvzZV+X4t5zvNq53FsRX6JfcmY2j1/yLhtGKHxWjdMkK+up00uV
         5shN/wABCmkTDMKUiS3WPkbqKVuK9IBHkflYbGgalS2M3QnFiZxm3IihZabnZq/QpuZ5
         soaXYq3hwKetAM2z61KfK04XM/VhbyMvAMhNl8DTkjXDvRUIv5GWuw9ujtF7fKZ60/TR
         ypMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701329402; x=1701934202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZpURYzVj3ww3XlYzCTphJ4gF4DoWItg5eveQZqQLlk=;
        b=CPB0J3/Jr4YFwnbRX+1dknXVYScQhF2G7yXpL7zbulZsGeP5N6TWgbBBU2xqZGNj9I
         2yy854w9yjALRQuZtJerbeb0wsJJifzVnwqOe3refDmve1AuauHam7/5lX9oprCUJU/j
         +G0eFyii80swlmIBonkvMLGnjN3QXcRzJnifZOoCJEj4OvXMNsN3ARFvBxfAnORoosP1
         POkDZCCoM12zeTsKoZarZGL9awaugmq0vLoAs8EPeCrTYU95u67r580GhXiHmKKD88Tk
         FLWp+w1vrLUkzkQgH+GzL8+sbdZQkXZyxGKucXmrqn0R5neoven4xA3Yz0uvoxBhNZdd
         y/Ww==
X-Gm-Message-State: AOJu0Yxcfd2uiY/lcI9USLKmJPsL9RYbl/W0u2ceaU7D+KpRoPFtFgCt
        IouCnvXUUCDGHi3qS0GM5ujLsP30LahdyA==
X-Google-Smtp-Source: AGHT+IG4bmYCQZbXEp16+Ucd2ZopZSaw8Prsy37KRXS6uBivHnJqwuO3gRu76VjpEdgRadxrhAB9Sg==
X-Received: by 2002:a17:90b:314b:b0:285:a163:c25b with SMTP id ip11-20020a17090b314b00b00285a163c25bmr16698188pjb.5.1701329402549;
        Wed, 29 Nov 2023 23:30:02 -0800 (PST)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id ep8-20020a17090ae64800b00285cee21489sm621272pjb.1.2023.11.29.23.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 23:30:02 -0800 (PST)
Message-ID: <fd847e77-0510-48db-ad0b-5946458e2fb3@gmail.com>
Date:   Thu, 30 Nov 2023 15:29:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86/pmu: Prevent any host user from enabling PEBS
 for profiling guest
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>
References: <20231129095055.88060-1-likexu@tencent.com>
 <6c4bd247-1f81-4b43-9e21-012f831d26b8@linux.intel.com>
From:   Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <6c4bd247-1f81-4b43-9e21-012f831d26b8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 10:38 pm, Liang, Kan wrote:
> 
> 
> On 2023-11-29 4:50 a.m., Like Xu wrote:
>> From: Like Xu <likexu@tencent.com>
>>
>> Stop using PEBS counters on host to profiling guest. Limit the range of
>> enabled PEBS counters to only those counters enabled from the guest PEBS
>> emulation perspective.
>>
>> If there is a perf-record agent on host that uses perf-tools events like
>> "cpu-cycles:GP" (G for attr.exclude_host, P for max precise event counter)
>> to capture guest performance events, then the guest will be hanged. This is
>> because Intel DS-based PEBS buffer is addressed using the 64-bit linear
>> address of the current {p/v}CPU context based on MSR_IA32_DS_AREA.
>>
>> Any perf user using PEBS counters to profile guest on host is, in perf/core
>> implementation details, trying to set bits on cpuc->intel_ctrl_guest_mask
>> and arr[pebs_enable].guest, much like the guest PEBS emulation behaviour.
>> But the subsequent PEBS memory write, regardless of whether guest PEBS is
>> enabled, can overshoot guest entry and corrupt guest memory.
>>
>> Profiling guest via PEBS-DS buffer on host is not supported at this time.
>> Fix this by filtering the real configured value of arr[pebs_enable].guest
>> with the emulated state of guest enabled PEBS counters, under the condition
>> of none cross-mapped PEBS counters.
> 
> So the counter will be silently disabled. The user never knows why
> nothing is sampled.
> Since we don't support the case, profiling guest via PEBS-DS buffer on
> host. Maybe we should error out when creating the event. For example
> (not tested),

Test failed.

> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 3871267d3237..24b90c70737f 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3958,6 +3958,10 @@ static int intel_pmu_hw_config(struct perf_event
> *event)
>   		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) ==
> INTEL_FIXED_VLBR_EVENT)
>   			return -EINVAL;
> 
> +		/* Profiling guest via PEBS-DS buffer on host is not supported. */
> +		if (event->attr.exclude_host)
> +			return -EINVAL;
> +

Guest PEBS emulation also sets this bit, a typical call stack looks like:

     intel_pmu_hw_config+0x441/0x4d0
     hsw_hw_config+0x12/0xa0
     x86_pmu_event_init+0x98/0x370
     perf_try_init_event+0x47/0x130
     perf_event_alloc+0x446/0xeb0
     perf_event_create_kernel_counter+0x38/0x190
     pmc_reprogram_counter.constprop.17+0xd9/0x230 [kvm]
     kvm_pmu_handle_event+0x1a6/0x310 [kvm]
     vcpu_enter_guest+0x1388/0x19b0 [kvm]
     vcpu_run+0x117/0x6c0 [kvm]
     kvm_arch_vcpu_ioctl_run+0x13d/0x4d0 [kvm]
     kvm_vcpu_ioctl+0x301/0x6e0 [kvm]

Alternatively, this path is taken when using PEBS-via-PT to profile guests on host.

The status of the guest can only be queried in the NMI handler and the func
intel_guest_get_msrs() in the perf/core context, where it's easier and more
centrally to review this part of changes that affects vPMU for corner cases.

Maybe adding print info on the perf-tool side would help.

For perf-tool users, it will get 0 number of sample for "cpu-cycles:GP" events,
just like other uncounted perf-tool events.

>   		if (!(event->attr.freq || (event->attr.wakeup_events &&
> !event->attr.watermark))) {
>   		    event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
>   			if (!(event->attr.sample_type &
> 
> 
> Thanks,
> Kan
> 
>>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
>> Signed-off-by: Like Xu <likexu@tencent.com>
>> ---
>>   arch/x86/events/intel/core.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index a08f794a0e79..17afd504c35b 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4103,13 +4103,19 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>>   		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
>>   	};
>>   
>> +	/* In any case, clear guest PEBS bits first. */
>> +	arr[global_ctrl].guest &= ~arr[pebs_enable].guest;
>> +
>>   	if (arr[pebs_enable].host) {
>>   		/* Disable guest PEBS if host PEBS is enabled. */
>>   		arr[pebs_enable].guest = 0;
>>   	} else {
>>   		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
>>   		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
>> -		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
>> +
>> +		/* Prevent any host user from enabling PEBS for profiling guest. */
>> +		arr[pebs_enable].guest &= (kvm_pmu->pebs_enable & kvm_pmu->global_ctrl);
>> +
>>   		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
>>   		arr[global_ctrl].guest |= arr[pebs_enable].guest;
>>   	}
>>
>> base-commit: 6803fb00772cc50cd59a66bd8caaee5c84b13fcf
