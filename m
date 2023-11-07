Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8060F7E3597
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjKGHO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjKGHOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:14:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC49A126;
        Mon,  6 Nov 2023 23:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699341262; x=1730877262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rHg6ajGXoS1Qs9ap7LF+acWJjzz5Vz2IA6kFhHY2hAE=;
  b=ISuViZFVQ9WC3hOeCF9qSo7lO+3rZjP0AkveyOD4jw7mv3WAIMsXX6UO
   Uols207O/4Mk1WNVNCQmhyfoeJXu6O4ZdxL7TZNRQPC5bvEWd6BJhlJ9k
   yxruo5ROL7qT6RYBfEjRiYrtBoSIMYrzW1YVtTCXtc67WIDOklpZYk6+z
   3wtKPf0p7B2+9fzUS/lsHyJ7VAS/1Ng0VCPMqJQM0Bxt8W89kFlPAQT9b
   y1GrCLdkwQYswq7vNU0tTCqw1D94nfOyNpW9DnH4Qbn4BhgXwCte4HXr1
   kiPPrHnjBMP30l0kQdlrdmLJYe0CT64DYMsmcojCn2nDJUsfEQof/MdVY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="379838513"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="379838513"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:14:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="906326673"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="906326673"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.238.1.248]) ([10.238.1.248])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:14:18 -0800
Message-ID: <2c804098-af2b-4f1d-a39f-eb42f58635d7@linux.intel.com>
Date:   Tue, 7 Nov 2023 15:14:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/20] KVM: x86/pmu: Don't enumerate arch events KVM
 doesn't support
To:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>
References: <20231104000239.367005-1-seanjc@google.com>
 <20231104000239.367005-4-seanjc@google.com>
 <CALMp9eTvR1mNw7PEms7840t13dD_VGhEWpaz9w6prSiyDR9GtA@mail.gmail.com>
Content-Language: en-US
From:   "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eTvR1mNw7PEms7840t13dD_VGhEWpaz9w6prSiyDR9GtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/4/2023 8:41 PM, Jim Mattson wrote:
> On Fri, Nov 3, 2023 at 5:02 PM Sean Christopherson <seanjc@google.com> wrote:
>> Don't advertise support to userspace for architectural events that KVM
>> doesn't support, i.e. for "real" events that aren't listed in
>> intel_pmu_architectural_events.  On current hardware, this effectively
>> means "don't advertise support for Top Down Slots".
> NR_REAL_INTEL_ARCH_EVENTS is only used in intel_hw_event_available().
> As discussed (https://lore.kernel.org/kvm/ZUU12-TUR_1cj47u@google.com/),
> intel_hw_event_available() should go away.
>
> Aside from mapping fixed counters to event selector and unit mask
> (fixed_pmc_events[]), KVM has no reason to know when a new
> architectural event is defined.


Since intel_hw_event_available() would be removed, it looks the enum 
intel_pmu_architectural_events and intel_arch_events[] array become 
useless. We can directly simply modify current fixed_pmc_events[] array 
and use it to store fixed counter events code and umask.


>
> The variable that this change "fixes" is only used to feed
> CPUID.0AH:EBX in KVM_GET_SUPPORTED_CPUID, and kvm_pmu_cap.events_mask
> is already constructed from what host perf advertises support for.
>
>> Mask off the associated "unavailable" bits, as said bits for undefined
>> events are reserved to zero.  Arguably the events _are_ defined, but from
>> a KVM perspective they might as well not exist, and there's absolutely no
>> reason to leave useless unavailable bits set.
>>
>> Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>   arch/x86/kvm/vmx/pmu_intel.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 3316fdea212a..8d545f84dc4a 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -73,6 +73,15 @@ static void intel_init_pmu_capability(void)
>>          int i;
>>
>>          /*
>> +        * Do not enumerate support for architectural events that KVM doesn't
>> +        * support.  Clear unsupported events "unavailable" bit as well, as
>> +        * architecturally such bits are reserved to zero.
>> +        */
>> +       kvm_pmu_cap.events_mask_len = min(kvm_pmu_cap.events_mask_len,
>> +                                         NR_REAL_INTEL_ARCH_EVENTS);
>> +       kvm_pmu_cap.events_mask &= GENMASK(kvm_pmu_cap.events_mask_len - 1, 0);
>> +
>> +        /*
>>           * Perf may (sadly) back a guest fixed counter with a general purpose
>>           * counter, and so KVM must hide fixed counters whose associated
>>           * architectural event are unsupported.  On real hardware, this should
>> --
>> 2.42.0.869.gea05f2083d-goog
>>
