Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008AD77B2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjHNHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjHNHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:40:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1408DE73;
        Mon, 14 Aug 2023 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691998821; x=1723534821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6EgNyeRC8oeSntQ+uFXQ98rQjYsSKgASYESs/c5A3pQ=;
  b=duWm9oTFt04+VXsEmViewkyplAlVzBoPldmtClLq2go7wscyhlg2Rx3J
   nHUMo+dEDCRF4YIec4rGzEgVCPZYdEBOev0orFkLlN/+Gjn0xK96aIRcE
   IlalH53WiKyA2/RuOt+xzAP+KiwcQh2W0pk/jhl4JBcQvzF18TeqoRh5X
   5CFEpTfl6tvZsSffus2LvIGW1IKobV+ArdRC9qgw2Q+AB0G+G97gSvtAZ
   2TMuRD1RjpfDPKWelSjzpbwT6mjyjdPAb1uH1pBcjTzSKnHSWx4Jpljhw
   tJtqmMRrqYp6s2RweOEovk0XogEC6hDWm6/umYCOmgVo/9CLm3vZbN++O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="369455997"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="369455997"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="768355718"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="768355718"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.71])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:40:15 -0700
Message-ID: <8198296c-7772-1252-16a6-ffa68e86a3f5@intel.com>
Date:   Mon, 14 Aug 2023 10:40:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/7] perf evlist: Add evlist__findnew_tracking_event()
 helper
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-3-yangjihong1@huawei.com>
 <CAP-5=fVysKhUn1YsUr0NBU2kVBDgkoczO861XwK5VCtkeYSRJA@mail.gmail.com>
 <085942cc-f6e7-a81b-243f-a739c91ecd72@intel.com>
 <CAP-5=fVmKmgsABpnsngT9L1QeaWaUxakHc1078LahGFqK4-riA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fVmKmgsABpnsngT9L1QeaWaUxakHc1078LahGFqK4-riA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/23 20:12, Ian Rogers wrote:
> On Wed, Jul 19, 2023 at 9:59 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 19/07/23 19:44, Ian Rogers wrote:
>>> On Fri, Jul 14, 2023 at 8:31 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>>>
>>>> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
>>>> tracking to the evlist. We may need to search for the dummy event for
>>>> some settings. Therefore, add evlist__findnew_tracking_event() helper.
>>>>
>>>> evlist__findnew_tracking_event() also deal with system_wide maps if
>>>> system_wide is true.
>>>
>>> I'm wondering if we can simplify the naming in the API, we have "dummy
>>> event" which makes sense as we literally call the event "dummy",
>>> "sideband" which refers to the kind of samples/events the dummy event
>>> will record but "tracking" I think tends to get used as a verb rather
>>> than a noun. So I think evlist__findnew_tracking_event should be
>>> evlist__findnew_dummy_event.
>>
>> Except the tracking event has "tracking" set but there can be other dummy
>> events that do not.
> 
> Thanks! I'm wondering what a dummy event without tracking would be
> used for - do you have a reference?

For example, text_poke events need to be recorded on all CPUs
because changes to the kernel affect every CPU.  Another example.
it can be interesting to capture switch events CPU-wide even if
only some processes are being traced.

>                                     I don't see anything in
> perf_event.h calling things like mmap2/comm in perf_event_attr
> tracking. I'm not a fan of dummy due to it not being intention
> revealing. Perhaps if we could go back in time  we could call the
> event "sideband",

Auxiliary events are inband with respect to the perf buffer.  Only
when the "main" tracing could be considered to be the AUX area
buffer, can the events in the perf buffer be considered sideband.

>                   maybe we should migrate to this. We have other
> non-obvious uses of the term dummy like in cpumap:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/include/perf/cpumap.h?h=perf-tools-next#n24
> If tracking can be on any event then does that make the functions
> behavior more ambiguous if it means dummy+tracking not <any
> event>+tracking?
> 
> Thanks,
> Ian
> 
>>>
>>> Thanks,
>>> Ian
>>>
>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>>> ---
>>>>  tools/perf/builtin-record.c | 11 +++--------
>>>>  tools/perf/util/evlist.c    | 18 ++++++++++++++++++
>>>>  tools/perf/util/evlist.h    |  1 +
>>>>  3 files changed, 22 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>> index aec18db7ff23..ca83599cc50c 100644
>>>> --- a/tools/perf/builtin-record.c
>>>> +++ b/tools/perf/builtin-record.c
>>>> @@ -1295,14 +1295,9 @@ static int record__open(struct record *rec)
>>>>          */
>>>>         if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>>>>             perf_pmus__num_core_pmus() > 1) {
>>>> -               pos = evlist__get_tracking_event(evlist);
>>>> -               if (!evsel__is_dummy_event(pos)) {
>>>> -                       /* Set up dummy event. */
>>>> -                       if (evlist__add_dummy(evlist))
>>>> -                               return -ENOMEM;
>>>> -                       pos = evlist__last(evlist);
>>>> -                       evlist__set_tracking_event(evlist, pos);
>>>> -               }
>>>> +               pos = evlist__findnew_tracking_event(evlist, false);
>>>> +               if (!pos)
>>>> +                       return -ENOMEM;
>>>>
>>>>                 /*
>>>>                  * Enable the dummy event when the process is forked for
>>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>>> index 7ef43f72098e..25c3ebe2c2f5 100644
>>>> --- a/tools/perf/util/evlist.c
>>>> +++ b/tools/perf/util/evlist.c
>>>> @@ -1694,6 +1694,24 @@ void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_ev
>>>>         tracking_evsel->tracking = true;
>>>>  }
>>>>
>>>> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool system_wide)
>>>> +{
>>>> +       struct evsel *evsel;
>>>> +
>>>> +       evsel = evlist__get_tracking_event(evlist);
>>>> +       if (!evsel__is_dummy_event(evsel)) {
>>>> +               evsel = evlist__add_aux_dummy(evlist, system_wide);
>>>> +               if (!evsel)
>>>> +                       return NULL;
>>>> +
>>>> +               evlist__set_tracking_event(evlist, evsel);
>>>> +       } else if (system_wide) {
>>>> +               perf_evlist__go_system_wide(&evlist->core, &evsel->core);
>>>> +       }
>>>> +
>>>> +       return evsel;
>>>> +}
>>>> +
>>>>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str)
>>>>  {
>>>>         struct evsel *evsel;
>>>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>>>> index 664c6bf7b3e0..98e7ddb2bd30 100644
>>>> --- a/tools/perf/util/evlist.h
>>>> +++ b/tools/perf/util/evlist.h
>>>> @@ -387,6 +387,7 @@ bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr);
>>>>
>>>>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
>>>>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
>>>> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool system_wide);
>>>>
>>>>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
>>>>
>>>> --
>>>> 2.30.GIT
>>>>
>>

