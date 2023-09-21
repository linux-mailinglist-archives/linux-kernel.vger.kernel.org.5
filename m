Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C61B7A9CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjIUT1O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjIUT1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:27:13 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCDDD3DFB;
        Thu, 21 Sep 2023 12:27:07 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-76c64da0e46so54884539f.0;
        Thu, 21 Sep 2023 12:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324427; x=1695929227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPPYPjUF5mQGqlXc6q8Md0nEeDWGWooPc/xDnj8149k=;
        b=H4Yo/s6cnE5B7ZB3xiLIZZvORMabEYUsMUEcZPQ/wakmHPD37LnwENhIXhzbucYuCF
         kejBZqevY76EuMRSOdDf0oUa9sB7SrQX3VsRNbogiuKWSr3WNWo49x+CdOxU5P7tAp+g
         Khxf/6edyucltkgvJZ+uCysArB2xNwHQik6/Ck6WNNC6+xpodK68Zbb7bKDPhgoUlXU3
         dx5NGmqKzjQutVOu2mdjWBaPBwXxOUiA08/pJCd3DY6UaW4fQQAiq8bHRB9KnhI+PRTN
         onNMYesUj60vAbMgvz6ts6ueTc/HD43wnIB7/QKjmY924h0wP8ZB3OkkEYaYPu7MjXDf
         RKag==
X-Gm-Message-State: AOJu0Yxhvrkj6UwL2r5ZpnH3bxf4KidNQhpGMG2J0LkycVQ4SwroZ7Em
        q/sQaMcaDUl+vU73BxkEjR3mJhDt/KBtwnY3WNk=
X-Google-Smtp-Source: AGHT+IFAPM66YMj2fKA0bB640ji1eK0ubh2EH7DMTFmVoWnrn2FuzSrR5JoZrVyC1b6G8bniYqbSoHH8DWVtNkW7EEA=
X-Received: by 2002:a05:6602:2156:b0:790:f866:d71b with SMTP id
 y22-20020a056602215600b00790f866d71bmr6583946ioy.13.1695324427049; Thu, 21
 Sep 2023 12:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <08995efc-d5af-6ba6-831b-1a483daabef4@intel.com>
 <CAP-5=fW783G9fUEHrmzUu7UmvOm65Fp6vAQybCcNz2C0QRz26w@mail.gmail.com> <8086150e-3c6d-4001-b3cc-bb12ebe15928@intel.com>
In-Reply-To: <8086150e-3c6d-4001-b3cc-bb12ebe15928@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 21 Sep 2023 12:26:55 -0700
Message-ID: <CAM9d7chtVQqySGOGQrA065Fr8M2Y6jg9JJccYtMycQFvaheU+Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 18, 2023 at 11:00 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 19/09/23 00:48, Ian Rogers wrote:
> > On Mon, Sep 18, 2023 at 1:14 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 16/09/23 07:09, Ian Rogers wrote:
> >>> Dummy events are created with an attribute where the period and freq
> >>> are zero. evsel__config will then see the uninitialized values and
> >>> initialize them in evsel__default_freq_period. As fequency mode is
> >>> used by default the dummy event would be set to use frequency
> >>> mode. However, this has no effect on the dummy event but does cause
> >>> unnecessary timers/interrupts. Avoid this overhead by setting the
> >>> period to 1 for dummy events.
> >>>
> >>> evlist__add_aux_dummy calls evlist__add_dummy then sets freq=0 and
> >>> period=1. This isn't necessary after this change and so the setting is
> >>> removed.
> >>>
> >>> From Stephane:
> >>>
> >>> The dummy event is not counting anything. It is used to collect mmap
> >>> records and avoid a race condition during the synthesize mmap phase of
> >>> perf record. As such, it should not cause any overhead during active
> >>> profiling. Yet, it did. Because of a bug the dummy event was
> >>> programmed as a sampling event in frequency mode. Events in that mode
> >>> incur more kernel overheads because on timer tick, the kernel has to
> >>> look at the number of samples for each event and potentially adjust
> >>> the sampling period to achieve the desired frequency. The dummy event
> >>> was therefore adding a frequency event to task and ctx contexts we may
> >>> otherwise not have any, e.g., perf record -a -e
> >>> cpu/event=0x3c,period=10000000/. On each timer tick the
> >>> perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
> >>> non-zero, then the kernel will loop over ALL the events of the context
> >>> looking for frequency mode ones. In doing, so it locks the context,
> >>> and enable/disable the PMU of each hw event. If all the events of the
> >>> context are in period mode, the kernel will have to traverse the list for
> >>> nothing incurring overhead. The overhead is multiplied by a very large
> >>> factor when this happens in a guest kernel. There is no need for the
> >>> dummy event to be in frequency mode, it does not count anything and
> >>> therefore should not cause extra overhead for no reason.
> >>>
> >>> Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy constructor")
> >>> Reported-by: Stephane Eranian <eranian@google.com>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>

I'll take the original patch first.


> >>> ---
> >>>  tools/perf/util/evlist.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >>> index 25c3ebe2c2f5..e36da58522ef 100644
> >>> --- a/tools/perf/util/evlist.c
> >>> +++ b/tools/perf/util/evlist.c
> >>> @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evlist *evlist)
> >>>               .type   = PERF_TYPE_SOFTWARE,
> >>>               .config = PERF_COUNT_SW_DUMMY,
> >>>               .size   = sizeof(attr), /* to capture ABI version */
> >>> +             /* Avoid frequency mode for dummy events to avoid associated timers. */
> >>> +             .freq = 0,
> >>> +             .sample_period = 1,
> >>>       };
> >>>
> >>>       return evsel__new_idx(&attr, evlist->core.nr_entries);
> >>> @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
> >>>       evsel->core.attr.exclude_kernel = 1;
> >>>       evsel->core.attr.exclude_guest = 1;
> >>>       evsel->core.attr.exclude_hv = 1;
> >>> -     evsel->core.attr.freq = 0;
> >>> -     evsel->core.attr.sample_period = 1;
> >>>       evsel->core.system_wide = system_wide;
> >>>       evsel->no_aux_samples = true;
> >>>       evsel->name = strdup("dummy:u");
> >>
> >> Note that evsel__config() will put it back to freq if -F is used.
> >
> > Right, I was looking for a minimal fix in part for the sake of back
> > porting. For the -F we could do:
> >
> > ```
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index d5363d23f5d3..806185a39e17 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1083,11 +1083,15 @@ void __weak arch__post_evsel_config(struct
> > evsel *evsel __maybe_unused,
> > static void evsel__set_default_freq_period(struct record_opts *opts,
> >                                           struct perf_event_attr *attr)
> > {
> > -       if (opts->freq) {
> > +       bool is_dummy = attr->type == PERF_TYPE_SOFTWARE &&
> > +               attr->config == PERF_COUNT_SW_DUMMY;
> > +
> > +       if (opts->freq && !is_dummy) {
> >                attr->freq = 1;
> >                attr->sample_freq = opts->freq;
> >        } else {
> > -               attr->sample_period = opts->default_interval;
> > +               attr->freq = 0;
> > +               attr->sample_period = is_dummy ? 1 : opts->default_interval;
> >        }
> > }
> > ```
> >
> > But this felt like it could potentially have other side-effects.
>
> Perhaps leave it alone, if the period has already been defined:
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d5363d23f5d3..ad3e12f5ec88 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1166,7 +1166,8 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>         if ((evsel->is_libpfm_event && !attr->sample_period) ||
>             (!evsel->is_libpfm_event && (!attr->sample_period ||
>                                          opts->user_freq != UINT_MAX ||
> -                                        opts->user_interval != ULLONG_MAX)))
> +                                        opts->user_interval != ULLONG_MAX) &&
> +            !(is_dummy && attr->sample_period)))
>                 evsel__set_default_freq_period(opts, attr);
>
>         /*

Or simply like this?


diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d5363d23f5d3..6ce832ce62f1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1169,6 +1169,9 @@ void evsel__config(struct evsel *evsel, struct
record_opts *opts,
                                         opts->user_interval != ULLONG_MAX)))
                evsel__set_default_freq_period(opts, attr);

+       if (evsel__is_dummy_event(evsel))
+               attr->freq = 0;
+
        /*
         * If attr->freq was set (here or earlier), ask for period
         * to be sampled.
