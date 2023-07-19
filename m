Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA50759BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGSQ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSQ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:59:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C704B6;
        Wed, 19 Jul 2023 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689785971; x=1721321971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RPaGjKlGwxdShpweO5RJ0J/GpYXeaPosH1orxZVdr5U=;
  b=WWCteQpzyfqUWPGTjL+m+M4WIhlHJCFHedyPxP01KXVbKe6aNhjAEwe9
   iBdlmAsbA1fG21u+DnqXCmHZLJOpCRZ5jYXWjARr7Ko/YWFj7QHkF8/So
   8joeHQ4unzrvHpzFV+lq/SxzKalePRuy0WBTcNcJ24EIEViInxVPeX4C0
   b8vqQ8sf0YwQWJTgI/Ub7nwRH+d9tEZ9T0kQkZ0cOhX6DPHemvK+A/M+i
   An/fwgQnh85O45tUVkj5ccsptkoo/M7H3viFcVre4ES+tjoh8pBd3vE3p
   VWt56yhmePVIZGEqhnIhuKVhQtpc0R3awHVenB7mPu8+WC2XCfqgzhsYR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370083357"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="370083357"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 09:59:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="753770253"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="753770253"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 09:59:25 -0700
Message-ID: <085942cc-f6e7-a81b-243f-a739c91ecd72@intel.com>
Date:   Wed, 19 Jul 2023 19:59:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/7] perf evlist: Add evlist__findnew_tracking_event()
 helper
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-3-yangjihong1@huawei.com>
 <CAP-5=fVysKhUn1YsUr0NBU2kVBDgkoczO861XwK5VCtkeYSRJA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fVysKhUn1YsUr0NBU2kVBDgkoczO861XwK5VCtkeYSRJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/23 19:44, Ian Rogers wrote:
> On Fri, Jul 14, 2023 at 8:31 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
>> tracking to the evlist. We may need to search for the dummy event for
>> some settings. Therefore, add evlist__findnew_tracking_event() helper.
>>
>> evlist__findnew_tracking_event() also deal with system_wide maps if
>> system_wide is true.
> 
> I'm wondering if we can simplify the naming in the API, we have "dummy
> event" which makes sense as we literally call the event "dummy",
> "sideband" which refers to the kind of samples/events the dummy event
> will record but "tracking" I think tends to get used as a verb rather
> than a noun. So I think evlist__findnew_tracking_event should be
> evlist__findnew_dummy_event.

Except the tracking event has "tracking" set but there can be other dummy
events that do not.

> 
> Thanks,
> Ian
> 
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>  tools/perf/builtin-record.c | 11 +++--------
>>  tools/perf/util/evlist.c    | 18 ++++++++++++++++++
>>  tools/perf/util/evlist.h    |  1 +
>>  3 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index aec18db7ff23..ca83599cc50c 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -1295,14 +1295,9 @@ static int record__open(struct record *rec)
>>          */
>>         if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>>             perf_pmus__num_core_pmus() > 1) {
>> -               pos = evlist__get_tracking_event(evlist);
>> -               if (!evsel__is_dummy_event(pos)) {
>> -                       /* Set up dummy event. */
>> -                       if (evlist__add_dummy(evlist))
>> -                               return -ENOMEM;
>> -                       pos = evlist__last(evlist);
>> -                       evlist__set_tracking_event(evlist, pos);
>> -               }
>> +               pos = evlist__findnew_tracking_event(evlist, false);
>> +               if (!pos)
>> +                       return -ENOMEM;
>>
>>                 /*
>>                  * Enable the dummy event when the process is forked for
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 7ef43f72098e..25c3ebe2c2f5 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -1694,6 +1694,24 @@ void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_ev
>>         tracking_evsel->tracking = true;
>>  }
>>
>> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool system_wide)
>> +{
>> +       struct evsel *evsel;
>> +
>> +       evsel = evlist__get_tracking_event(evlist);
>> +       if (!evsel__is_dummy_event(evsel)) {
>> +               evsel = evlist__add_aux_dummy(evlist, system_wide);
>> +               if (!evsel)
>> +                       return NULL;
>> +
>> +               evlist__set_tracking_event(evlist, evsel);
>> +       } else if (system_wide) {
>> +               perf_evlist__go_system_wide(&evlist->core, &evsel->core);
>> +       }
>> +
>> +       return evsel;
>> +}
>> +
>>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str)
>>  {
>>         struct evsel *evsel;
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index 664c6bf7b3e0..98e7ddb2bd30 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -387,6 +387,7 @@ bool evlist_cpu_iterator__end(const struct evlist_cpu_iterator *evlist_cpu_itr);
>>
>>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
>>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
>> +struct evsel *evlist__findnew_tracking_event(struct evlist *evlist, bool system_wide);
>>
>>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
>>
>> --
>> 2.30.GIT
>>

