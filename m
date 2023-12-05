Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B51F804965
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjLEFgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEFgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:36:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D908109;
        Mon,  4 Dec 2023 21:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701754597; x=1733290597;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=s9iJZ4aU/3bJDsghmcJJacZ2miAs6QvIU5XNThfx3Zs=;
  b=HChMDOs8hpkuuZdPwNrajX5hDpciIdF+uP/4yDmkIqNoe7QIsfjKlZXU
   ai09mQpMl3BmUk5jkGp1TpLH+yeZka1IL+gqJggtXdCSHwjnrZ4YbawBr
   NaRD1L1t9GZNVHKoYzu//P9uCWkiA+Xr8+OpPqf3RUrIInXMyLaO/Lo5r
   zvC2W1U2+hjgr2Qsnsi1GfAJGw/mYPo7nB8aCbQSgu5GdB7IAJNK46sQS
   gLHW+9NW8/UXu1CPuvM9d6TpUU+Uek3rdlbCA3Q7JNNdA9DwYrnoGYANG
   jkU+eRGcKHOZTqolHNK/v6aeTrBbGvnNOtOitRYKL3cu7eKcEd8dcny+Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="723361"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="723361"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 21:36:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="805165992"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="805165992"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.77])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 21:36:30 -0800
Message-ID: <d60c3bed-2280-4305-948a-cbb63674060b@intel.com>
Date:   Tue, 5 Dec 2023 07:36:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC 2/3] perf/x86/intel/pt: Add support for pause_resume()
To:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20231123121851.10826-1-adrian.hunter@intel.com>
 <20231123121851.10826-3-adrian.hunter@intel.com>
 <c63808b2-2049-da18-f0af-5dff2bc87cd2@arm.com>
 <20231129105836.GF30650@noisy.programming.kicks-ass.net>
 <842ce784-fbd2-4667-a5f7-aaa10a1108dc@intel.com>
 <20231129122320.GH30650@noisy.programming.kicks-ass.net>
 <07c9b3be-676a-f7f8-d1d2-94ce3abcb61b@arm.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <07c9b3be-676a-f7f8-d1d2-94ce3abcb61b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/23 12:07, James Clark wrote:
> 
> 
> On 29/11/2023 12:23, Peter Zijlstra wrote:
>> On Wed, Nov 29, 2023 at 01:15:43PM +0200, Adrian Hunter wrote:
>>> On 29/11/23 12:58, Peter Zijlstra wrote:
>>>> On Wed, Nov 29, 2023 at 09:53:39AM +0000, James Clark wrote:
>>>>> On 23/11/2023 12:18, Adrian Hunter wrote:
>>>>
>>>>>> +static void pt_event_pause_resume(struct perf_event *event)
>>>>>> +{
>>>>>> +	if (event->aux_paused)
>>>>>> +		pt_config_stop(event);
>>>>>> +	else if (!event->hw.state)
>>>>>> +		pt_config_start(event);
>>>>>> +}
>>>>>
>>>>> It seems like having a single pause/resume callback rather than separate
>>>>> pause and resume ones pushes some of the event state management into the
>>>>> individual drivers and would be prone to code duplication and divergent
>>>>> behavior.
>>>>>
>>>>> Would it be possible to move the conditions from here into the core code
>>>>> and call separate functions instead?
>>>>>
>>>>>> +
>>>>>>  static void pt_event_start(struct perf_event *event, int mode)
>>>>>>  {
>>>>>>  	struct hw_perf_event *hwc = &event->hw;
>>>>>> @@ -1798,6 +1809,7 @@ static __init int pt_init(void)
>>>>>>  	pt_pmu.pmu.del			 = pt_event_del;
>>>>>>  	pt_pmu.pmu.start		 = pt_event_start;
>>>>>>  	pt_pmu.pmu.stop			 = pt_event_stop;
>>>>>> +	pt_pmu.pmu.pause_resume		 = pt_event_pause_resume;
>>>>>
>>>>> The general idea seems ok to me. Is there a reason to not use the
>>>>> existing start() stop() callbacks, rather than adding a new one?
>>>>>
>>>>> I assume it's intended to be something like an optimisation where you
>>>>> can turn it on and off without having to do the full setup, teardown and
>>>>> emit an AUX record because you know the process being traced never gets
>>>>> switched out?
>>>>
>>>> So the actual scheduling uses ->add() / ->del(), the ->start() /
>>>> ->stop() methods are something that can be used after ->add() and before
>>>> ->del() to 'temporarily' pause things.
>>>>
>>>> Pretty much exactly what is required here I think. We currently use this
>>>> for PMI throttling and adaptive frequency stuff, but there is no reason
>>>> it could not also be used for this.
>>>>
>>>> As is, we don't track the paused state across ->del() / ->add(), but
>>>> perhaps that can be fixed. We can easily add more PERF_EF_ / PERF_HES_
>>>> bits to manage things.
>>>>
>>>>
>>>
>>> I am not sure stop / start play nice with NMI's from other events e.g.
>>>
>>> PMC NMI wants to pause or resume AUX but what if AUX event is currently
>>> being processed in ->stop() or ->start()?  Or maybe that can't happen?
>>
>> I think that can happen, and pt_event_stop() can actually handle some of
>> that, while your pause_resume() thing, which uses pt_config_stop() does
>> not.
>>
>> But yes, I think that if you add pt_event_{stop,start}() calls from
>> *other* events their PMI, then you get to deal with more 'fun'.
>>
>> Something like:
>>
>>   perf_addr_filters_adjust()
>>     __perf_addr_filters_adjust()
>>       perf_event_stop()
>>         __perf_event_stop()
>> 	  event->pmu->stop()
>> 	  <NMI>
>> 	    ...
>> 	    perf_event_overflow()
>> 	      pt_event->pmu->stop()
>> 	  </NMI>
>> 	  event->pmu->start() // whoopsie!
>>
>> Should now be possible.
>>
>> I think what you want to do is rename pt->handle_nmi into pt->stop_count
>> and make it a counter, then ->stop() increments it, and ->start()
>> decrements it and everybody ensures the thing doesn't get restart while
>> !0 etc..
>>
>> I suspect you need to guard the generic part of this feature with a new
>> PERF_PMU_CAP_ flag and then have the coresight/etc. people opt-in once
>> they've audited things.
>>
>> James, does that work for you?
>>
> 
> Yep I think that would work.
> 
> If I understand it with the stop_count counter, to be able to support
> the new CAP, every device would basically have to implement a similar
> counter?
> 
> Would it be possible to do that reference counting on the outside of
> start() and stop() in the core code? So that a device only ever sees one
> call to start and one call to stop and doesn't need to do any extra
> tracking?

stop_counter does not seem right for pauses and resumes because they
should not accumulate.  We want:

	pause	stop
	pause
	resume	start
	resume

not:

	pause	stop
	pause
	resume
	resume	start

Also stop_counter has issues like:

	stop_counter 0 -> 1
	<NMI>
		stop_counter 1 -> 0
		start()
	</NMI>
	stop()	<- stop_counter is now out of sync

or:

	stop_counter 1 -> 0
	<NMI>
		stop_counter 0 -> 1
		stop()
	</NMI>
	start()	<- stop_counter is now out of sync

Also Intel PT implementation uses low-level start / stop
for pause / resume, which can be made not to conflict with
regular start / stop because they only toggle TRACEEN bit.
