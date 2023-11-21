Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8701C7F36CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjKUT0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKUT0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:26:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E92113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 11:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700594795; x=1732130795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ELOGQh+gKb6rAh4FmmnoQq+3Zh4xpb0Mf9OpFew1qB0=;
  b=DrHhnQioeznN7WZI/csLx+amGVTVnDyN3vG1zupFE1JReL/+ePn+6gRW
   mG8gq1+bpVhVkUEAI3uW8XqKFLSeAJCZLksJPgoLcd2AsIBrDoRVcz/oU
   kE1Zy8+zuukhnSmiLs+TV+WoxyUvGFgBIKbrVnIV/hy4qdMNjOncUOeCe
   kRmK7MFjNEXjlSrX8zdka/prgV5cixTtiNSarslr/1PB5RJpUcDElmTI8
   SGdeQICn+qwosstNLBKcgUA04/rujuPYVcWe1FfWgkFXxsiT4ZXfzEAOQ
   cmxEz9D/Bi1Ui/SxWp8HoRujFbzAIo5p9LYxth02AqNTppjnu5mZit24z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10579081"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="10579081"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 11:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716614095"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="716614095"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 11:26:35 -0800
Received: from [10.209.157.143] (unknown [10.209.157.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0EABD580BB9;
        Tue, 21 Nov 2023 11:26:33 -0800 (PST)
Message-ID: <25e006f6-43a2-4046-a14e-a856285f5eed@linux.intel.com>
Date:   Tue, 21 Nov 2023 14:26:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf/x86: Add CAP_NO_INTERRUPT for uncore PMUs
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Mingwei Zhang <mizhang@google.com>
References: <20231120221932.213710-1-namhyung@kernel.org>
 <20231120221932.213710-3-namhyung@kernel.org>
 <66f74af2-21b6-477b-ada1-a8816ee115dc@linux.intel.com>
 <CAM9d7chDB0nPcu7_Ks4kp2R=+iVNU8SyEFKHVEsd3d0S=mYRnw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7chDB0nPcu7_Ks4kp2R=+iVNU8SyEFKHVEsd3d0S=mYRnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-21 1:30 p.m., Namhyung Kim wrote:
> Hi Kan,
> 
> On Tue, Nov 21, 2023 at 7:59 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-11-20 5:19 p.m., Namhyung Kim wrote:
>>> It doesn't support sampling in uncore PMU events.  While it's
>>> technically possible to generate interrupts, let's treat it as if it
>>> has no interrupt in order to skip the freq adjust/unthrottling logic
>>> in the timer handler which is only meaningful to sampling events.
>>>
>>> Also remove the sampling event check because it'd be done in the general
>>> code in the perf_event_open syscall.
>>>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>  arch/x86/events/intel/uncore.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>>> index 69043e02e8a7..f7e6228bd1b1 100644
>>> --- a/arch/x86/events/intel/uncore.c
>>> +++ b/arch/x86/events/intel/uncore.c
>>> @@ -744,10 +744,6 @@ static int uncore_pmu_event_init(struct perf_event *event)
>>>       if (pmu->func_id < 0)
>>>               return -ENOENT;
>>>
>>> -     /* Sampling not supported yet */
>>> -     if (hwc->sample_period)
>>> -             return -EINVAL;
>>> -
>>>       /*
>>>        * Place all uncore events for a particular physical package
>>>        * onto a single cpu
>>> @@ -919,7 +915,12 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
>>>                       .stop           = uncore_pmu_event_stop,
>>>                       .read           = uncore_pmu_event_read,
>>>                       .module         = THIS_MODULE,
>>> -                     .capabilities   = PERF_PMU_CAP_NO_EXCLUDE,
>>> +                     /*
>>> +                      * It doesn't allow sampling for uncore events, let's
>>> +                      * treat the PMU has no interrupts to skip them in the
>>> +                      * perf_adjust_freq_unthr_context().
>>> +                      */
>>> +                     .capabilities   = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
>>>                       .attr_update    = pmu->type->attr_update,
>>>               };
>>
>>
>> There is a special customized uncore PMU which needs the flag as well.
> 
> Ok, I will add that too.
> 
> Btw, during the work I noticed many PMU drivers didn't set the
> CAP_NO_INTERRUPT flag even if they didn't support sampling and
> rejected the sampling events manually in the ->event_init() callback.
> 
> I guess it's because the name of the flag is somewhat misleading.
> As the PMU drivers handle IRQ (for overflows), they thought they had
> interrupts and didn't set the flag.  I think it'd be better to rename it to
> CAP_NO_SAMPLING to reveal the intention.  And then we could just set
> the flag in the pmu.capabilities and remove the manual checks.
> 
> The benefit is it can skip the PMUs in the timer tick handler even if
> it needs to unthrottle some events.  What do you think?
> 

I agree. The current name is kind of misleading.

The patch, which introduced the flag (commit id 53b25335dd60 ("perf:
Disable sampled events if no PMU interrupt")), also tried to disable the
sampled events on a no-sampling supported platform.

The renaming sounds good to me.

Thanks,
Kan
