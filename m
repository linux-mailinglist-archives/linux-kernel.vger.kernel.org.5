Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CA87E00FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347626AbjKCKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347416AbjKCKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:03:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914CABD;
        Fri,  3 Nov 2023 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699005823; x=1730541823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8E8dn8Xek5yYAahg5pJzt4zURQpPI7tPe+CLjEMKDQg=;
  b=eViAA9dFnhg48ELf/IhLNL3eCwsugIDludUCbKZeOOksUiufDf6XQelB
   W6UZaO5kjCqtmq2wSe23p/Ss7DeacHKS8lqvBSZ2MGfqW1LcpzdijF9rz
   u37b0D3peI1CuMWa4wA25qUsoImXYhhM0rosFU8oqPDA81DqNfzsRgpGM
   55YsRdxLpSlK+hrVIW/Q1XekYd3OZAJUgiSIOe5KO3M3ISUfNskrQ2t+6
   zZlvoHoU9RH16QuJAUXZFmMmVJDOFLKA/O3zBLjeL7E+q1sjIXdBb1r/t
   LM1PnzkEcZBDNTnJKcEw39O1wlN8T2A0I0KWpnKKunlO+vhrhAspSbLGw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="455408298"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="455408298"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 03:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878600848"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="878600848"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.93.12.33]) ([10.93.12.33])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 03:03:16 -0700
Message-ID: <8272bad5-323e-46ae-9244-7b76832393fb@linux.intel.com>
Date:   Fri, 3 Nov 2023 18:03:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 1/2] KVM: x86/pmu: Add Intel CPUID-hinted TopDown slots
 event
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>, Like Xu <likexu@tencent.com>
References: <20231031090613.2872700-1-dapeng1.mi@linux.intel.com>
 <20231031090613.2872700-2-dapeng1.mi@linux.intel.com>
 <CALMp9eR_BFdNNTXhSpbuH66jXcRLVB8VvD8V+kY245NbusN2+g@mail.gmail.com>
 <c3f0e4ac-1790-40c1-a09e-209a09e3d230@linux.intel.com>
 <CALMp9eTDAiJ=Kuh7KkwdAY8x1BL2ZjdgFiPFRHXSSVCpcXp9rw@mail.gmail.com>
 <baa64cf4-11de-4581-89b6-3a86448e3a6e@linux.intel.com>
 <a14147e7-0b35-4fba-b785-ef568474c69b@linux.intel.com>
 <85706bd7-7df0-4d4b-932c-d807ddb14f9e@linux.intel.com>
 <CALMp9eS3NdTUnRrYPB+mMoGKj5NnsYXNUfUJX8Gv=wWCN4dkoQ@mail.gmail.com>
From:   "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eS3NdTUnRrYPB+mMoGKj5NnsYXNUfUJX8Gv=wWCN4dkoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/2023 1:45 AM, Jim Mattson wrote:
> On Wed, Nov 1, 2023 at 7:07 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 11/1/2023 9:33 PM, Liang, Kan wrote:
>>> On 2023-10-31 11:31 p.m., Mi, Dapeng wrote:
>>>> On 11/1/2023 11:04 AM, Jim Mattson wrote:
>>>>> On Tue, Oct 31, 2023 at 6:59 PM Mi, Dapeng
>>>>> <dapeng1.mi@linux.intel.com> wrote:
>>>>>> On 11/1/2023 2:22 AM, Jim Mattson wrote:
>>>>>>> On Tue, Oct 31, 2023 at 1:58 AM Dapeng Mi
>>>>>>> <dapeng1.mi@linux.intel.com> wrote:
>>>>>>>> This patch adds support for the architectural topdown slots event
>>>>>>>> which
>>>>>>>> is hinted by CPUID.0AH.EBX.
>>>>>>> Can't a guest already program an event selector to count event select
>>>>>>> 0xa4, unit mask 1, unless the event is prohibited by
>>>>>>> KVM_SET_PMU_EVENT_FILTER?
>>>>>> Actually defining this new slots arch event is to do the sanity check
>>>>>> for supported arch-events which is enumerated by CPUID.0AH.EBX.
>>>>>> Currently vPMU would check if the arch event from guest is supported by
>>>>>> KVM. If not, it would be rejected just like intel_hw_event_available()
>>>>>> shows.
>>>>>>
>>>>>> If we don't add the slots event in the intel_arch_events[] array, guest
>>>>>> may program the slots event and pass the sanity check of KVM on a
>>>>>> platform which actually doesn't support slots event and program the
>>>>>> event on a real GP counter and got an invalid count. This is not
>>>>>> correct.
>>>>> On physical hardware, it is possible to program a GP counter with the
>>>>> event selector and unit mask of the slots event whether or not the
>>>>> platform supports it. Isn't KVM wrong to disallow something that a
>>>>> physical CPU allows?
>>>> Yeah, I agree. But I'm not sure if this is a flaw on PMU driver. If an
>>>> event is not supported by the hardware,  we can't predict the PMU's
>>>> behavior and a meaningless count may be returned and this could mislead
>>>> the user.
>>> The user can program any events on the GP counter. The perf doesn't
>>> limit it. For the unsupported event, 0 should be returned. Please keep
>>> in mind, the event list keeps updating. If the kernel checks for each
>>> event, it could be a disaster. I don't think it's a flaw.
>>
>> Thanks Kan, it would be ok as long as 0 is always returned for
>> unsupported events. IMO, it's a nice to have feature that KVM does this
>> sanity check for supported arch events, it won't break anything.
> The hardware PMU most assuredly does not return 0 for unsupported events.
>
> For example, if I use host perf to sample event selector 0xa4 unit
> mask 1 on a Broadwell host (406f1), I get...
>
> # perf stat -e r01a4 sleep 10
>
>   Performance counter stats for 'sleep 10':
>
>             386,964      r01a4
>
>        10.000907211 seconds time elapsed
>
> Broadwell does not advertise support for architectural event 7 in
> CPUID.0AH:EBX, so KVM will refuse to measure this event inside a
> guest. That seems broken to me.


Yeah, I also saw similar results on Coffee Lake which doesn't support 
slots events and the return count seems to be a random and meaningless 
value. If so, this meaningless value may mislead the guest perf user. 
 From this point view it looks the sanity check in KVM is useful, but it 
indeed leads to different behavior between guest and host.

I'm neutral on either keeping or removing this check. How's other 
reviewers' opinion on this?


>
>>> Thanks,
>>> Kan
>>>> Add Kan to confirm this.
>>>>
>>>> Hi Kan,
>>>>
>>>> Have you any comments on this? Thanks.
>>>>
>>>>
>>>>>>> AFAICT, this change just enables event filtering based on
>>>>>>> CPUID.0AH:EBX[bit 7] (though it's not clear to me why two independent
>>>>>>> mechanisms are necessary for event filtering).
>>>>>> IMO, these are two different things. this change is just to enable the
>>>>>> supported arch events check for slot events, the event filtering is
>>>>>> another thing.
>>>>> How is clearing CPUID.0AH:EBX[bit 7] any different from putting {event
>>>>> select 0xa4, unit mask 1} in a deny list with the PMU event filter?
>>>> I think there is no difference in the conclusion but with two different
>>>> methods.
>>>>
>>>>
