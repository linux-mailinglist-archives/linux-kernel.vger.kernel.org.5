Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC07E7E41
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbjKJRmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjKJRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8579C42C28;
        Fri, 10 Nov 2023 09:02:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A977A106F;
        Fri, 10 Nov 2023 09:02:47 -0800 (PST)
Received: from [10.57.1.85] (unknown [10.57.1.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 957993F6C4;
        Fri, 10 Nov 2023 09:02:01 -0800 (PST)
Message-ID: <1c92865b-a9dd-5dc8-8bc4-383da79ff49b@arm.com>
Date:   Fri, 10 Nov 2023 17:01:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] perf lock report: Restore aggregation by caller by
 default
Content-Language: en-GB
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        stable@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20231031120526.11502-1-nick.forrington@arm.com>
 <20231031120526.11502-2-nick.forrington@arm.com>
 <CAM9d7cgzbjqU4U9tpAkhme-mZPV-LScJietre=3b01kykG_fcg@mail.gmail.com>
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <CAM9d7cgzbjqU4U9tpAkhme-mZPV-LScJietre=3b01kykG_fcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/11/2023 05:55, Namhyung Kim wrote:
> Hello,
>
> On Tue, Oct 31, 2023 at 5:05 AM Nick Forrington <nick.forrington@arm.com> wrote:
>> This change restores the previous default behaviour for "perf lock
>> report", making the current aggregate-by-address behaviour available via
>> the new "--lock-addr" command line parameter.
>>
>> This makes the behaviour consistent with "perf lock contention" (which
>> also aggregates by caller by default, or by address when "--lock-addr"
>> is specified).
> I understand your concern but actually there's a difference.
> "perf lock contention" is a new command which works with new
> contention tracepoints whereas "perf lock report" works with old
> lockdep/lockstat tracepoints which are not available in the default
> configuration.
>
> I made "perf lock contention" compatible to "perf lock report" so
> it mimics the old tracepoints behavior as much as possible using
> new tracepoints.  But the important difference is that new contention
> tracepoints don't have lock names.  The old perf lock report showed
> lock names by default but contention output had to use the caller
> instead.

Thanks for the information.


It looks like "perf lock record" requests both tracepoint types.


However, on the system I used the lockdep tracepoints were not available 
- only lock:contention_begin/end.

>
>> Commit 688d2e8de231 ("perf lock contention: Add -l/--lock-addr option")
>> introduced aggregation modes for "perf lock contention" and (potentially
>> inadvertently) changed the behaviour of "perf lock report" from
>> aggregate-by-caller to aggregate-by-address (making the prior behaviour
>> inaccessible).
> So it doesn't change the behavior of perf lock report.
> You're adding a new (default) feature for perf lock report
> to sort the output by caller.  And please note that caller
> info needs callstacks.  perf lock record adds it by default
> when it finds there are only lock contention tracepoints.
> But if it really has the old tracepoints, caller won't work
> unless you enabled callstack collection manually (-g).

With the caveat that only lock:contention_begin/end were available in my 
test, there does appear to be a difference in output for perf lock report.


I arrived at 688d2e8de231 via git bisect. 688d2e8de231~ (eca949b2b4ad) 
shows the aggregate-by-caller behaviour (seen below, and "restored" by 
this patch).

>
>> Example aggregate-by-address output:
>>
>> $ perf lock report -F acquired
> I guess you need -l option here.

This was the default output before this patch (or output with the patch 
and "-l"), I can clarify this if the patch goes ahead.

>>                  Name   acquired
>>
>>           event_mutex         34
>>                               21
>>                                1
> This is because you used contention tracepoints
> and they don't have lock names.

Yes, the lockdep tracepoints weren't available for my test, although on 
the same machine, versions prior to 688d2e8de231 appear to show the 
below output rather than the above.

>
>> Example aggregate-by-caller output:
>>
>> $ perf lock report -F acquired
>>                  Name   acquired
>>
>>   perf_trace_init+...         34
>>   lock_mm_and_find...         20
>>   inherit_event.co...          1
>>      do_madvise+0x1f8          1
> Maybe it's ok to change the default behavior for contention
> tracepoints.  But when lockdep tracepoints are available
> it should use the existing addr (symbol) mode.
>
>> Cc: stable@kernel.org
>> Fixes: 688d2e8de231 ("perf lock contention: Add -l/--lock-addr option")
> So, I don't think this is a fix.
>
> Thanks,
> Namhyung


Thanks,
Nick

>
>
>> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
>> ---
>>   tools/perf/Documentation/perf-lock.txt |  4 ++++
>>   tools/perf/builtin-lock.c              | 24 +++++++++++++++++++++---
>>   2 files changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
>> index 503abcba1438..349333acbbfc 100644
>> --- a/tools/perf/Documentation/perf-lock.txt
>> +++ b/tools/perf/Documentation/perf-lock.txt
>> @@ -80,6 +80,10 @@ REPORT OPTIONS
>>   --combine-locks::
>>          Merge lock instances in the same class (based on name).
>>
>> +-l::
>> +--lock-addr::
>> +       Show lock contention stat by address
>> +
>>   -t::
>>   --threads::
>>       The -t option is to show per-thread lock stat like below:
>> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
>> index fa7419978353..3aa8ba5ad928 100644
>> --- a/tools/perf/builtin-lock.c
>> +++ b/tools/perf/builtin-lock.c
>> @@ -78,7 +78,7 @@ struct callstack_filter {
>>
>>   static struct lock_filter filters;
>>
>> -static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
>> +static enum lock_aggr_mode aggr_mode = LOCK_AGGR_CALLER;
>>
>>   static bool needs_callstack(void)
>>   {
>> @@ -1983,8 +1983,8 @@ static int __cmd_report(bool display_info)
>>          if (select_key(false))
>>                  goto out_delete;
>>
>> -       if (show_thread_stats)
>> -               aggr_mode = LOCK_AGGR_TASK;
>> +       aggr_mode = show_thread_stats ? LOCK_AGGR_TASK :
>> +               show_lock_addrs ? LOCK_AGGR_ADDR : LOCK_AGGR_CALLER;
>>
>>          err = perf_session__process_events(session);
>>          if (err)
>> @@ -2008,6 +2008,19 @@ static void sighandler(int sig __maybe_unused)
>>   {
>>   }
>>
>> +static int check_lock_report_options(const struct option *options,
>> +                                    const char * const *usage)
>> +{
>> +       if (show_thread_stats && show_lock_addrs) {
>> +               pr_err("Cannot use thread and addr mode together\n");
>> +               parse_options_usage(usage, options, "threads", 0);
>> +               parse_options_usage(NULL, options, "lock-addr", 0);
>> +               return -1;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static int check_lock_contention_options(const struct option *options,
>>                                           const char * const *usage)
>>
>> @@ -2589,6 +2602,7 @@ int cmd_lock(int argc, const char **argv)
>>          /* TODO: type */
>>          OPT_BOOLEAN('c', "combine-locks", &combine_locks,
>>                      "combine locks in the same class"),
>> +       OPT_BOOLEAN('l', "lock-addr", &show_lock_addrs, "show lock stats by address"),
>>          OPT_BOOLEAN('t', "threads", &show_thread_stats,
>>                      "show per-thread lock stats"),
>>          OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
>> @@ -2680,6 +2694,10 @@ int cmd_lock(int argc, const char **argv)
>>                          if (argc)
>>                                  usage_with_options(report_usage, report_options);
>>                  }
>> +
>> +               if (check_lock_report_options(report_options, report_usage) < 0)
>> +                       return -1;
>> +
>>                  rc = __cmd_report(false);
>>          } else if (!strcmp(argv[0], "script")) {
>>                  /* Aliased to 'perf script' */
>> --
>> 2.42.0
>>
