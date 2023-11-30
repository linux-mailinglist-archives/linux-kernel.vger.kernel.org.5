Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F87FEC85
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjK3KHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjK3KHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:07:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F01B910DE;
        Thu, 30 Nov 2023 02:07:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B1691042;
        Thu, 30 Nov 2023 02:08:06 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CD043F6C4;
        Thu, 30 Nov 2023 02:07:17 -0800 (PST)
Message-ID: <07c9b3be-676a-f7f8-d1d2-94ce3abcb61b@arm.com>
Date:   Thu, 30 Nov 2023 10:07:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 2/3] perf/x86/intel/pt: Add support for pause_resume()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>
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
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231129122320.GH30650@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/11/2023 12:23, Peter Zijlstra wrote:
> On Wed, Nov 29, 2023 at 01:15:43PM +0200, Adrian Hunter wrote:
>> On 29/11/23 12:58, Peter Zijlstra wrote:
>>> On Wed, Nov 29, 2023 at 09:53:39AM +0000, James Clark wrote:
>>>> On 23/11/2023 12:18, Adrian Hunter wrote:
>>>
>>>>> +static void pt_event_pause_resume(struct perf_event *event)
>>>>> +{
>>>>> +	if (event->aux_paused)
>>>>> +		pt_config_stop(event);
>>>>> +	else if (!event->hw.state)
>>>>> +		pt_config_start(event);
>>>>> +}
>>>>
>>>> It seems like having a single pause/resume callback rather than separate
>>>> pause and resume ones pushes some of the event state management into the
>>>> individual drivers and would be prone to code duplication and divergent
>>>> behavior.
>>>>
>>>> Would it be possible to move the conditions from here into the core code
>>>> and call separate functions instead?
>>>>
>>>>> +
>>>>>  static void pt_event_start(struct perf_event *event, int mode)
>>>>>  {
>>>>>  	struct hw_perf_event *hwc = &event->hw;
>>>>> @@ -1798,6 +1809,7 @@ static __init int pt_init(void)
>>>>>  	pt_pmu.pmu.del			 = pt_event_del;
>>>>>  	pt_pmu.pmu.start		 = pt_event_start;
>>>>>  	pt_pmu.pmu.stop			 = pt_event_stop;
>>>>> +	pt_pmu.pmu.pause_resume		 = pt_event_pause_resume;
>>>>
>>>> The general idea seems ok to me. Is there a reason to not use the
>>>> existing start() stop() callbacks, rather than adding a new one?
>>>>
>>>> I assume it's intended to be something like an optimisation where you
>>>> can turn it on and off without having to do the full setup, teardown and
>>>> emit an AUX record because you know the process being traced never gets
>>>> switched out?
>>>
>>> So the actual scheduling uses ->add() / ->del(), the ->start() /
>>> ->stop() methods are something that can be used after ->add() and before
>>> ->del() to 'temporarily' pause things.
>>>
>>> Pretty much exactly what is required here I think. We currently use this
>>> for PMI throttling and adaptive frequency stuff, but there is no reason
>>> it could not also be used for this.
>>>
>>> As is, we don't track the paused state across ->del() / ->add(), but
>>> perhaps that can be fixed. We can easily add more PERF_EF_ / PERF_HES_
>>> bits to manage things.
>>>
>>>
>>
>> I am not sure stop / start play nice with NMI's from other events e.g.
>>
>> PMC NMI wants to pause or resume AUX but what if AUX event is currently
>> being processed in ->stop() or ->start()?  Or maybe that can't happen?
> 
> I think that can happen, and pt_event_stop() can actually handle some of
> that, while your pause_resume() thing, which uses pt_config_stop() does
> not.
> 
> But yes, I think that if you add pt_event_{stop,start}() calls from
> *other* events their PMI, then you get to deal with more 'fun'.
> 
> Something like:
> 
>   perf_addr_filters_adjust()
>     __perf_addr_filters_adjust()
>       perf_event_stop()
>         __perf_event_stop()
> 	  event->pmu->stop()
> 	  <NMI>
> 	    ...
> 	    perf_event_overflow()
> 	      pt_event->pmu->stop()
> 	  </NMI>
> 	  event->pmu->start() // whoopsie!
> 
> Should now be possible.
> 
> I think what you want to do is rename pt->handle_nmi into pt->stop_count
> and make it a counter, then ->stop() increments it, and ->start()
> decrements it and everybody ensures the thing doesn't get restart while
> !0 etc..
> 
> I suspect you need to guard the generic part of this feature with a new
> PERF_PMU_CAP_ flag and then have the coresight/etc. people opt-in once
> they've audited things.
> 
> James, does that work for you?
> 

Yep I think that would work.

If I understand it with the stop_count counter, to be able to support
the new CAP, every device would basically have to implement a similar
counter?

Would it be possible to do that reference counting on the outside of
start() and stop() in the core code? So that a device only ever sees one
call to start and one call to stop and doesn't need to do any extra
tracking?
