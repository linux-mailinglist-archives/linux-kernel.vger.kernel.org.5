Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF67D805B82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjLEQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346293AbjLEPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:25:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C229B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:25:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9896EC433C9;
        Tue,  5 Dec 2023 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701789954;
        bh=jGbR98Oq7+B1xcOqIwhdrfRm9TOrFrBuvflXUQyUyQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipFqaA62uI4kOw0gXHgoFGKMBznOLI1pIAxiYjWqNP6oK5LvRB2V1o/kVsVGoy2M2
         Mog3RVBn40qGnjn+/8PsCuqetBQvplxvn4AWU34QgMifHHgMp8V7N9/MypAHDj9A+H
         1PgTycir+nZf7ju4ys7jMPjlwwT9ZR7DFRzsToN6E5Roczywtgcqw+awrY8wJmfp1w
         Eg6QFRzwEp93ONJtuxIGy4pv0W9kKwHdccN4Hgs6F4XIA7yWxjfn0PQjKraGeHHanK
         iqSwwW6tukzW6uQyEvBkUNXvYWD3MaqSmp52M9YU0O0kz2OigZ5LKZAvSUt+FA+nBS
         npiWRxXmDLqow==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1D4840094; Tue,  5 Dec 2023 12:25:50 -0300 (-03)
Date:   Tue, 5 Dec 2023 12:25:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Subject: Re: [RFC PATCH v2] perf evsel: Fallback to task-clock when not
 system wide
Message-ID: <ZW9A/jpVNdeNZYnh@kernel.org>
References: <20231121000420.368075-1-irogers@google.com>
 <CFCEDA00-D3CB-450A-B9E5-AA5D7CEEA1CE@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CFCEDA00-D3CB-450A-B9E5-AA5D7CEEA1CE@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 05, 2023 at 04:51:01PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 21-Nov-2023, at 5:34 AM, Ian Rogers <irogers@google.com> wrote:
> > 
> > When the cycles event isn't available evsel will fallback to the
> > cpu-clock software event. task-clock is similar to cpu-clock but only
> > runs when the process is running. Falling back to cpu-clock when not
> > system wide leads to confusion, by falling back to task-clock it is
> > hoped the confusion is less.
> > 
> > Pass the target to determine if task-clock is more appropriate. Update
> > a nearby comment and debug string for the change.
> > 
> > ---
> > v2. Use target__has_cpu as suggested by Namhyung.
> > https://lpc.events/event/17/contributions/1556/
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > tools/perf/builtin-record.c |  2 +-
> > tools/perf/builtin-stat.c   |  2 +-
> > tools/perf/builtin-top.c    |  2 +-
> > tools/perf/util/evsel.c     | 18 ++++++++++--------
> > tools/perf/util/evsel.h     |  3 ++-
> > 5 files changed, 15 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 8ec818568662..d8bb59511fdd 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1350,7 +1350,7 @@ static int record__open(struct record *rec)
> > evlist__for_each_entry(evlist, pos) {
> > try_again:
> > if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
> > - if (evsel__fallback(pos, errno, msg, sizeof(msg))) {
> > + if (evsel__fallback(pos, &opts->target, errno, msg, sizeof(msg))) {
> 
> Hi Ian
> 
> Tested this with perf record and I could find the code fallback to using task-clock
> 
> ./perf record -v ls
> Warning:
> The cycles event is not supported, trying to fall back to task-clock

Ok, so I'll take that as a Tested-by: you, ok?

The "perf stat" part can be addressed in a follow up patch, when that
error handling is researched to remember why we have that ->supported,
->errored thing.

- Arnaldo
 
> But in case of “perf stat”, in my environment, found that the code path won't invoke “evsel__fallback”.
> 
> Snippet for builtin-stat.c
>             if (errno == EINVAL || errno == ENOSYS ||
>             errno == ENOENT || errno == EOPNOTSUPP ||
>             errno == ENXIO) {
>                 if (verbose > 0)
>                         ui__warning("%s event is not supported by the kernel.\n",
>                                     evsel__name(counter));
>                 counter->supported = false;
>                 /*
>                  * errored is a sticky flag that means one of the counter's
>                  * cpu event had a problem and needs to be reexamined.
>                  */
>                 counter->errored = true;
> 
>                 if ((evsel__leader(counter) != counter) ||
>                     !(counter->core.leader->nr_members > 1))
>                         return COUNTER_SKIP;
>         } else if (evsel__fallback(counter, &target, errno, msg, sizeof(msg))) {
>                 if (verbose > 0)
>                         ui__warning("%s\n", msg);
>                 return COUNTER_RETRY;
> 
> So if the perf_event_open returns ENOENT, we won’t do a fallback in builtin-stat.c
> Should we address cycles differently here ? Any comments ?
> 
> Thanks
> Athira
> >   
> > if (verbose > 0)
> > ui__warning("%s\n", msg);
> > goto try_again;
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index a3af805a1d57..d8e5d6f7a87a 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -653,7 +653,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
> > if ((evsel__leader(counter) != counter) ||
> >    !(counter->core.leader->nr_members > 1))
> > return COUNTER_SKIP;
> > - } else if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
> > + } else if (evsel__fallback(counter, &target, errno, msg, sizeof(msg))) {
> > if (verbose > 0)
> > ui__warning("%s\n", msg);
> > return COUNTER_RETRY;
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index ea8c7eca5eee..1e42bd1c7d5a 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1044,7 +1044,7 @@ static int perf_top__start_counters(struct perf_top *top)
> >    perf_top_overwrite_fallback(top, counter))
> > goto try_again;
> > 
> > - if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
> > + if (evsel__fallback(counter, &opts->target, errno, msg, sizeof(msg))) {
> > if (verbose > 0)
> > ui__warning("%s\n", msg);
> > goto try_again;
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index a5da74e3a517..532f34d9fcb5 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2853,7 +2853,8 @@ u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const
> > 
> > #endif
> > 
> > -bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
> > +bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
> > +     char *msg, size_t msgsize)
> > {
> > int paranoid;
> > 
> > @@ -2861,18 +2862,19 @@ bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
> >    evsel->core.attr.type   == PERF_TYPE_HARDWARE &&
> >    evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES) {
> > /*
> > - * If it's cycles then fall back to hrtimer based
> > - * cpu-clock-tick sw counter, which is always available even if
> > - * no PMU support.
> > + * If it's cycles then fall back to hrtimer based cpu-clock sw
> > + * counter, which is always available even if no PMU support.
> > *
> > * PPC returns ENXIO until 2.6.37 (behavior changed with commit
> > * b0a873e).
> > */
> > - scnprintf(msg, msgsize, "%s",
> > -"The cycles event is not supported, trying to fall back to cpu-clock-ticks");
> > -
> > evsel->core.attr.type   = PERF_TYPE_SOFTWARE;
> > - evsel->core.attr.config = PERF_COUNT_SW_CPU_CLOCK;
> > + evsel->core.attr.config = target__has_cpu(target)
> > + ? PERF_COUNT_SW_CPU_CLOCK
> > + : PERF_COUNT_SW_TASK_CLOCK;
> > + scnprintf(msg, msgsize,
> > + "The cycles event is not supported, trying to fall back to %s",
> > + target__has_cpu(target) ? "cpu-clock" : "task-clock");
> > 
> > zfree(&evsel->name);
> > return true;
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index f19ac9f027ef..efbb6e848287 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -460,7 +460,8 @@ static inline bool evsel__is_clock(const struct evsel *evsel)
> >       evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
> > }
> > 
> > -bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize);
> > +bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
> > +     char *msg, size_t msgsize);
> > int evsel__open_strerror(struct evsel *evsel, struct target *target,
> > int err, char *msg, size_t size);
> > 
> > -- 
> > 2.43.0.rc1.413.gea7ed67945-goog
> > 
> 

-- 

- Arnaldo
