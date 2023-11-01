Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9A7DDBB9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjKAD50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjKAD5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:57:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07609A4;
        Tue, 31 Oct 2023 20:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698811039; x=1730347039;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l7SaA6WrF/yfhZTXdnFu0cvBBoAB6oKdoOqzhveg098=;
  b=NA3FrSDn5sN0P/ucW1bqQ/w3Au7YBS0HKFMUglUwx+kUE5/mCYUT3Z42
   jNmPt2+X+0s9ltJ7BlUX/ZK/pSo9yL3hbh6z5b+b6A4sqP2k2PGQByJXZ
   TcaPUSfCNt/pNl2ihbcFuNEBgAck90EfS7D+RIeqPYT68PkGV3TjRI06t
   mYbjeJSF264+hQ6l7bEBiGLPNHE+GRU+41JfrV4gu4Xp3TZrDCaUSakpJ
   UqHx+r3qpmeACh1Bsasc99sLiEMg/7+XbszSknbrdptqrnuVmCyRRNwbL
   S7ZTElWd6mwMJ1TVp1KyjhNUOLRO5MTo5Nqv6LFuYnJr/wwqsSX0Wm5T5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="452716256"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="452716256"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 20:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1092219060"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1092219060"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.93.12.33]) ([10.93.12.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 20:57:15 -0700
Message-ID: <df8f7461-3d4e-4b49-9380-d7d74af844d4@linux.intel.com>
Date:   Wed, 1 Nov 2023 11:57:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests Patch v2 4/5] x86: pmu: Support validation for
 Intel PMU fixed counter 3
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20231031092921.2885109-1-dapeng1.mi@linux.intel.com>
 <20231031092921.2885109-5-dapeng1.mi@linux.intel.com>
 <CALMp9eQ4Xj5D-kgqVMKUNmdF37rLcMRXyDYdQU339sRCKZ7d9A@mail.gmail.com>
 <28796dd3-ac4e-4a38-b9e1-f79533b2a798@linux.intel.com>
 <CALMp9eRH5pttOA5BApdVeSbbkOU-kWcOWAoGMfK-9f=cy2Jf0g@mail.gmail.com>
 <fbad1983-5cde-4c7b-aaed-412110fe737f@linux.intel.com>
 <CALMp9eQhUaATf=-7zGDCb_WMNwWx2edXH5Piy+D8QybEL0tyNg@mail.gmail.com>
From:   "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eQhUaATf=-7zGDCb_WMNwWx2edXH5Piy+D8QybEL0tyNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/2023 11:24 AM, Jim Mattson wrote:
> On Tue, Oct 31, 2023 at 8:16 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 11/1/2023 10:47 AM, Jim Mattson wrote:
>>> On Tue, Oct 31, 2023 at 7:33 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>> On 11/1/2023 2:47 AM, Jim Mattson wrote:
>>>>> On Tue, Oct 31, 2023 at 2:22 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>>>>>> Intel CPUs, like Sapphire Rapids, introduces a new fixed counter
>>>>>> (fixed counter 3) to counter/sample topdown.slots event, but current
>>>>>> code still doesn't cover this new fixed counter.
>>>>>>
>>>>>> So this patch adds code to validate this new fixed counter can count
>>>>>> slots event correctly.
>>>>> I'm not convinced that this actually validates anything.
>>>>>
>>>>> Suppose, for example, that KVM used fixed counter 1 when the guest
>>>>> asked for fixed counter 3. Wouldn't this test still pass?
>>>> Per my understanding, as long as the KVM returns a valid count in the
>>>> reasonable count range, we can think KVM works correctly. We don't need
>>>> to entangle on how KVM really uses the HW, it could be impossible and
>>>> unnecessary.
>>> Now, I see how the Pentium FDIV bug escaped notice. Hey, the numbers
>>> are in a reasonable range. What's everyone upset about?
>>>
>>>> Yeah, currently the predefined valid count range may be some kind of
>>>> loose since I want to cover as much as hardwares and avoid to cause
>>>> regression. Especially after introducing the random jump and clflush
>>>> instructions, the cycles and slots become much more hard to predict.
>>>> Maybe we can have a comparable restricted count range in the initial
>>>> change, and we can loosen the restriction then if we encounter a failure
>>>> on some specific hardware. do you think it's better? Thanks.
>>> I think the test is essentially useless, and should probably just be
>>> deleted, so that it doesn't give a false sense of confidence.
>> IMO, I can't say the tests are totally useless. Yes,  passing the tests
>> doesn't mean the KVM vPMU must work correctly, but we can say there is
>> something probably wrong if it fails to pass these tests. Considering
>> the hardware differences, it's impossible to set an exact value for
>> these events in advance and it seems there is no better method to verify
>> the PMC count as well. I still prefer to keep these tests until we have
>> a better method to verify the accuracy of the PMC count.
> If it's impossible to set an exact value for these events in advance,
> how does Intel validate the hardware PMU?


I have no much idea how HW team validates the PMU functionality. But per 
my gotten information, they could have some very tiny benchmarks with a 
fixed pattern and run them on a certain scenario, so they can expect an 
very accurate count value. But this is different with our case, a real 
program is executed on a real system (probably shared with other 
programs), the events count is impacted by too much hardware/software 
factors, such as cache contention, it's hard to predict a single 
accurate count in advance.

Anyway, it's only my guess about the ways of hardware validation, still 
add Kan to get more information.

Hi Kan,

Do you have more information about how HW team to validate the PMC count 
accuracy? Thanks.


