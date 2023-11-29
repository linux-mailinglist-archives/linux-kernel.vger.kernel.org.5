Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37C7FD558
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjK2LRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjK2LQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:16:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047EF272C;
        Wed, 29 Nov 2023 03:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701256554; x=1732792554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Snyvtn6d97iK8ZN3iP+Df433igWMIBGX4EIT1w9z9j4=;
  b=GaDH74bVv0VtUgeiGOmUksgtSgRYeVqWZJ1EbmEgRFW7dWJ9j6mXGf74
   QMPibST3a8UlYSqGFTKhMyYzyNYHWgjBIw0N1iGJl23FlKkitYVMef1jM
   JBZwlXssoFudaKOxIgAwXSeuuhq91P+buYsdZ33/OJlhpWHpadnwl0fun
   koms/we61XAuymQfR9hwv/eos35AUdpXg/iwRsvLeHuk+OAoY7z14K0NF
   ApchvqNpqqaZmTR4W0WuiJOce6m0t1wQPE9YsdsL5wfcb3eI/wl4bjp8u
   xDDYhyWykvfYOxAAf7RY9bqPqcaxxmfA4xJNlIP4gHG4gJ6undZh1511x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6411062"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="6411062"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:15:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1100493916"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="1100493916"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.43.226])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:15:47 -0800
Message-ID: <842ce784-fbd2-4667-a5f7-aaa10a1108dc@intel.com>
Date:   Wed, 29 Nov 2023 13:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] perf/x86/intel/pt: Add support for pause_resume()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        James Clark <james.clark@arm.com>
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231129105836.GF30650@noisy.programming.kicks-ass.net>
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

On 29/11/23 12:58, Peter Zijlstra wrote:
> On Wed, Nov 29, 2023 at 09:53:39AM +0000, James Clark wrote:
>> On 23/11/2023 12:18, Adrian Hunter wrote:
> 
>>> +static void pt_event_pause_resume(struct perf_event *event)
>>> +{
>>> +	if (event->aux_paused)
>>> +		pt_config_stop(event);
>>> +	else if (!event->hw.state)
>>> +		pt_config_start(event);
>>> +}
>>
>> It seems like having a single pause/resume callback rather than separate
>> pause and resume ones pushes some of the event state management into the
>> individual drivers and would be prone to code duplication and divergent
>> behavior.
>>
>> Would it be possible to move the conditions from here into the core code
>> and call separate functions instead?
>>
>>> +
>>>  static void pt_event_start(struct perf_event *event, int mode)
>>>  {
>>>  	struct hw_perf_event *hwc = &event->hw;
>>> @@ -1798,6 +1809,7 @@ static __init int pt_init(void)
>>>  	pt_pmu.pmu.del			 = pt_event_del;
>>>  	pt_pmu.pmu.start		 = pt_event_start;
>>>  	pt_pmu.pmu.stop			 = pt_event_stop;
>>> +	pt_pmu.pmu.pause_resume		 = pt_event_pause_resume;
>>
>> The general idea seems ok to me. Is there a reason to not use the
>> existing start() stop() callbacks, rather than adding a new one?
>>
>> I assume it's intended to be something like an optimisation where you
>> can turn it on and off without having to do the full setup, teardown and
>> emit an AUX record because you know the process being traced never gets
>> switched out?
> 
> So the actual scheduling uses ->add() / ->del(), the ->start() /
> ->stop() methods are something that can be used after ->add() and before
> ->del() to 'temporarily' pause things.
> 
> Pretty much exactly what is required here I think. We currently use this
> for PMI throttling and adaptive frequency stuff, but there is no reason
> it could not also be used for this.
> 
> As is, we don't track the paused state across ->del() / ->add(), but
> perhaps that can be fixed. We can easily add more PERF_EF_ / PERF_HES_
> bits to manage things.
> 
> 

I am not sure stop / start play nice with NMI's from other events e.g.

PMC NMI wants to pause or resume AUX but what if AUX event is currently
being processed in ->stop() or ->start()?  Or maybe that can't happen?

