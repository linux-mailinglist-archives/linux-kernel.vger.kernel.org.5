Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773D57DC611
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjJaFsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJaFsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:48:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60F891;
        Mon, 30 Oct 2023 22:48:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0188C433CA;
        Tue, 31 Oct 2023 05:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698731280;
        bh=p+P/xP9EbaQml5yZke5QeF30o+WUdV6v112azu7rFLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kL5jWchSNYYCG3LQ6IBTiLQvi1Kwr5DwhYV0HdB1dWKwXD3e56mQGPbDbCzpDlean
         8/nQgpmdN69VoOZrKLQsKx9X2W+iBuR8+4kFbdY4y+Vb71arz8+ob9ncW5o4NuRSzS
         4mdEiGZjKXHZgqNnm3TWqq5rawamhXR1evc9SsVI=
Date:   Tue, 31 Oct 2023 06:47:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     stable@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
Message-ID: <2023103145-ruse-statue-9b8f@gregkh>
References: <20230916040915.1075620-1-irogers@google.com>
 <CAL715WLq+wMGC26ESviAwSFGCpCYbf8knRFo=6Lbwgk8qwB8xA@mail.gmail.com>
 <CAL715W+gnsi8NiRfwBHAGLhGo5hpS1c=+v8EGbz8iX_ygUxm1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL715W+gnsi8NiRfwBHAGLhGo5hpS1c=+v8EGbz8iX_ygUxm1w@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 01:01:45PM -0700, Mingwei Zhang wrote:
> On Mon, Oct 30, 2023 at 12:04 PM Mingwei Zhang <mizhang@google.com> wrote:
> >
> > On Fri, Sep 15, 2023 at 9:10 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Dummy events are created with an attribute where the period and freq
> > > are zero. evsel__config will then see the uninitialized values and
> > > initialize them in evsel__default_freq_period. As fequency mode is
> > > used by default the dummy event would be set to use frequency
> > > mode. However, this has no effect on the dummy event but does cause
> > > unnecessary timers/interrupts. Avoid this overhead by setting the
> > > period to 1 for dummy events.
> > >
> > > evlist__add_aux_dummy calls evlist__add_dummy then sets freq=0 and
> > > period=1. This isn't necessary after this change and so the setting is
> > > removed.
> > >
> > > From Stephane:
> > >
> > > The dummy event is not counting anything. It is used to collect mmap
> > > records and avoid a race condition during the synthesize mmap phase of
> > > perf record. As such, it should not cause any overhead during active
> > > profiling. Yet, it did. Because of a bug the dummy event was
> > > programmed as a sampling event in frequency mode. Events in that mode
> > > incur more kernel overheads because on timer tick, the kernel has to
> > > look at the number of samples for each event and potentially adjust
> > > the sampling period to achieve the desired frequency. The dummy event
> > > was therefore adding a frequency event to task and ctx contexts we may
> > > otherwise not have any, e.g., perf record -a -e
> > > cpu/event=0x3c,period=10000000/. On each timer tick the
> > > perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
> > > non-zero, then the kernel will loop over ALL the events of the context
> > > looking for frequency mode ones. In doing, so it locks the context,
> > > and enable/disable the PMU of each hw event. If all the events of the
> > > context are in period mode, the kernel will have to traverse the list for
> > > nothing incurring overhead. The overhead is multiplied by a very large
> > > factor when this happens in a guest kernel. There is no need for the
> > > dummy event to be in frequency mode, it does not count anything and
> > > therefore should not cause extra overhead for no reason.
> > >
> > > Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy constructor")
> > > Reported-by: Stephane Eranian <eranian@google.com>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/evlist.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index 25c3ebe2c2f5..e36da58522ef 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evlist *evlist)
> > >                 .type   = PERF_TYPE_SOFTWARE,
> > >                 .config = PERF_COUNT_SW_DUMMY,
> > >                 .size   = sizeof(attr), /* to capture ABI version */
> > > +               /* Avoid frequency mode for dummy events to avoid associated timers. */
> > > +               .freq = 0,
> > > +               .sample_period = 1,
> > >         };
> > >
> > >         return evsel__new_idx(&attr, evlist->core.nr_entries);
> > > @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
> > >         evsel->core.attr.exclude_kernel = 1;
> > >         evsel->core.attr.exclude_guest = 1;
> > >         evsel->core.attr.exclude_hv = 1;
> > > -       evsel->core.attr.freq = 0;
> > > -       evsel->core.attr.sample_period = 1;
> > >         evsel->core.system_wide = system_wide;
> > >         evsel->no_aux_samples = true;
> > >         evsel->name = strdup("dummy:u");
> > > --
> > > 2.42.0.459.ge4e396fd5e-goog
> > >
> >
> > Hi Greg,
> >
> > This patch is a critical performance fix for perf and vPMU. Can you
> > help us dispatch the commit to all stable kernel versions?
> >
> > Appreciate your help. Thanks.
> > -Mingwei
> 
> Oops... Update target email to: stable@vger.kernel.org

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
