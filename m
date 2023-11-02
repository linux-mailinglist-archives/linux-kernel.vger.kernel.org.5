Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5A7DEA86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348227AbjKBCH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBCHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:07:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8049312C;
        Wed,  1 Nov 2023 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698890872; x=1730426872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VboZV0n5iFzkzM/yG4P10JmoHUOg8u7ao1rVDBJk1iI=;
  b=Tvwf2I4j18vj9mW22nDFHTBr5+SYfWcG5fnTLy+d8/e3jxHaFUmVpwfk
   WNodu7Y1OCvjPtpjIkCc5WWhl3H9En9hEph9XspEe3QSGWdagDK8ixK3W
   /FiXLqff0upRL0mCcRbO4OyHtiq7NJhQpCEcDHKV2L4H1Knzdw1ocUa9X
   r8QwNiC/SkmeQRiEjGoRnk9pkTwok/FiVsGphd6pFoyJANqZXbmdBpt56
   qKj77b64sWwLS7ygmKaGLOb/TAmdy5ALRWp9so8lp3eUW7EW2w7EQGbdB
   ENgQsnungqB1rvMGVp3/KrasyXgPLURqK4UOV4vdbRh0RFk8pKo9yi+0B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="373664328"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="373664328"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 19:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="851758843"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="851758843"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.93.12.33]) ([10.93.12.33])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 19:07:48 -0700
Message-ID: <85706bd7-7df0-4d4b-932c-d807ddb14f9e@linux.intel.com>
Date:   Thu, 2 Nov 2023 10:07:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 1/2] KVM: x86/pmu: Add Intel CPUID-hinted TopDown slots
 event
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
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
From:   "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <a14147e7-0b35-4fba-b785-ef568474c69b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/2023 9:33 PM, Liang, Kan wrote:
>
> On 2023-10-31 11:31 p.m., Mi, Dapeng wrote:
>> On 11/1/2023 11:04 AM, Jim Mattson wrote:
>>> On Tue, Oct 31, 2023 at 6:59 PM Mi, Dapeng
>>> <dapeng1.mi@linux.intel.com> wrote:
>>>> On 11/1/2023 2:22 AM, Jim Mattson wrote:
>>>>> On Tue, Oct 31, 2023 at 1:58 AM Dapeng Mi
>>>>> <dapeng1.mi@linux.intel.com> wrote:
>>>>>> This patch adds support for the architectural topdown slots event
>>>>>> which
>>>>>> is hinted by CPUID.0AH.EBX.
>>>>> Can't a guest already program an event selector to count event select
>>>>> 0xa4, unit mask 1, unless the event is prohibited by
>>>>> KVM_SET_PMU_EVENT_FILTER?
>>>> Actually defining this new slots arch event is to do the sanity check
>>>> for supported arch-events which is enumerated by CPUID.0AH.EBX.
>>>> Currently vPMU would check if the arch event from guest is supported by
>>>> KVM. If not, it would be rejected just like intel_hw_event_available()
>>>> shows.
>>>>
>>>> If we don't add the slots event in the intel_arch_events[] array, guest
>>>> may program the slots event and pass the sanity check of KVM on a
>>>> platform which actually doesn't support slots event and program the
>>>> event on a real GP counter and got an invalid count. This is not
>>>> correct.
>>> On physical hardware, it is possible to program a GP counter with the
>>> event selector and unit mask of the slots event whether or not the
>>> platform supports it. Isn't KVM wrong to disallow something that a
>>> physical CPU allows?
>>
>> Yeah, I agree. But I'm not sure if this is a flaw on PMU driver. If an
>> event is not supported by the hardware,  we can't predict the PMU's
>> behavior and a meaningless count may be returned and this could mislead
>> the user.
> The user can program any events on the GP counter. The perf doesn't
> limit it. For the unsupported event, 0 should be returned. Please keep
> in mind, the event list keeps updating. If the kernel checks for each
> event, it could be a disaster. I don't think it's a flaw.


Thanks Kan, it would be ok as long as 0 is always returned for 
unsupported events. IMO, it's a nice to have feature that KVM does this 
sanity check for supported arch events, it won't break anything.


>
> Thanks,
> Kan
>> Add Kan to confirm this.
>>
>> Hi Kan,
>>
>> Have you any comments on this? Thanks.
>>
>>
>>>>> AFAICT, this change just enables event filtering based on
>>>>> CPUID.0AH:EBX[bit 7] (though it's not clear to me why two independent
>>>>> mechanisms are necessary for event filtering).
>>>> IMO, these are two different things. this change is just to enable the
>>>> supported arch events check for slot events, the event filtering is
>>>> another thing.
>>> How is clearing CPUID.0AH:EBX[bit 7] any different from putting {event
>>> select 0xa4, unit mask 1} in a deny list with the PMU event filter?
>> I think there is no difference in the conclusion but with two different
>> methods.
>>
>>
