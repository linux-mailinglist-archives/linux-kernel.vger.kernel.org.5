Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914AE7A553A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjIRVtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRVtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:49:14 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9588E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:49:08 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-414ba610766so129231cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695073747; x=1695678547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zYf5Q5sA5+dYH8oLYRTVYeJXJa7Ls+rcJEO7yIFQy4=;
        b=B+7bG9xW1mtzHgjQCWW/l61NuF2mD03xpg0Fbfx6axS6dy0hQPbmILky0ZFLqASSxN
         vtZmaBFfNss3dSvP1ktvAQp71HUjl4Gm/yOMfql80BXkfADxxoZXBp+yAKclncT/zLD2
         GkH93rqJpzGwd/Ii5uXvcT0+m5nEu9VOFdw/BUiJdvJM1oqR3HntdIEHNZ65C31zWO/a
         uDHN5axvkW2mxzf37aZoL7ynJPB1J58SusPYHhMObib0KgJV2mFgudCwR4B5X5gn1kOF
         KPNv/OKTsEYloZ1BaG2NTN0XdaFayHlzEIq9qzzRdkSRCoyl0klWWVqLX2+iCetIvguW
         0X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695073747; x=1695678547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zYf5Q5sA5+dYH8oLYRTVYeJXJa7Ls+rcJEO7yIFQy4=;
        b=Pzoz+nyE/LUrKyDniBOSIYGcM5arjAlu3gImPYWFjsfAs6vGQgutaEez3s1mfIupBo
         eYpu+vs6SBCa5+l3tF4iqdNPzzD+Z1tP75WnY3m7AIZOatAYxQkmi/9W9WI7UalgwMEG
         2IXx0OtiI6mso/ZRoJeOckMnp9x74nDKhP3yUAPVgtQ7yLxEsEyl8FP/m4imLSujyTQ5
         Xpxi5NpgD1zC+rpoPLZZg/0eXbbRPFe5HyoZJqY2cXuXx2mzy6Du0ticIAVfofCOQVQF
         BbVvhaSEqUNxNC9ykqahc3hAS17A3QBV/1SAOqxK4ZDJPUZ3IHFfiPji1OYizb+lycvT
         kkPA==
X-Gm-Message-State: AOJu0YxciFlu9A+ctURjNQfYJ8CrIq7g6MDkKRLBsfEtYRduHLqo0hP8
        691bUJhOpQPgKueooaDr8zNCuon0o5g/43HghPpN3Q==
X-Google-Smtp-Source: AGHT+IE10rzvOB/ERZdoxlK53woYPSxvB0+KfpOUhwgdi+wRByiaqlDPuDWAwqhIWvuXZK3FoyBUjVrmdJBEg3zPFNo=
X-Received: by 2002:ac8:5bcd:0:b0:410:839d:941d with SMTP id
 b13-20020ac85bcd000000b00410839d941dmr94006qtb.20.1695073747449; Mon, 18 Sep
 2023 14:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <08995efc-d5af-6ba6-831b-1a483daabef4@intel.com>
In-Reply-To: <08995efc-d5af-6ba6-831b-1a483daabef4@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 18 Sep 2023 14:48:55 -0700
Message-ID: <CAP-5=fW783G9fUEHrmzUu7UmvOm65Fp6vAQybCcNz2C0QRz26w@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 1:14=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 16/09/23 07:09, Ian Rogers wrote:
> > Dummy events are created with an attribute where the period and freq
> > are zero. evsel__config will then see the uninitialized values and
> > initialize them in evsel__default_freq_period. As fequency mode is
> > used by default the dummy event would be set to use frequency
> > mode. However, this has no effect on the dummy event but does cause
> > unnecessary timers/interrupts. Avoid this overhead by setting the
> > period to 1 for dummy events.
> >
> > evlist__add_aux_dummy calls evlist__add_dummy then sets freq=3D0 and
> > period=3D1. This isn't necessary after this change and so the setting i=
s
> > removed.
> >
> > From Stephane:
> >
> > The dummy event is not counting anything. It is used to collect mmap
> > records and avoid a race condition during the synthesize mmap phase of
> > perf record. As such, it should not cause any overhead during active
> > profiling. Yet, it did. Because of a bug the dummy event was
> > programmed as a sampling event in frequency mode. Events in that mode
> > incur more kernel overheads because on timer tick, the kernel has to
> > look at the number of samples for each event and potentially adjust
> > the sampling period to achieve the desired frequency. The dummy event
> > was therefore adding a frequency event to task and ctx contexts we may
> > otherwise not have any, e.g., perf record -a -e
> > cpu/event=3D0x3c,period=3D10000000/. On each timer tick the
> > perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
> > non-zero, then the kernel will loop over ALL the events of the context
> > looking for frequency mode ones. In doing, so it locks the context,
> > and enable/disable the PMU of each hw event. If all the events of the
> > context are in period mode, the kernel will have to traverse the list f=
or
> > nothing incurring overhead. The overhead is multiplied by a very large
> > factor when this happens in a guest kernel. There is no need for the
> > dummy event to be in frequency mode, it does not count anything and
> > therefore should not cause extra overhead for no reason.
> >
> > Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy con=
structor")
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evlist.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 25c3ebe2c2f5..e36da58522ef 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evl=
ist *evlist)
> >               .type   =3D PERF_TYPE_SOFTWARE,
> >               .config =3D PERF_COUNT_SW_DUMMY,
> >               .size   =3D sizeof(attr), /* to capture ABI version */
> > +             /* Avoid frequency mode for dummy events to avoid associa=
ted timers. */
> > +             .freq =3D 0,
> > +             .sample_period =3D 1,
> >       };
> >
> >       return evsel__new_idx(&attr, evlist->core.nr_entries);
> > @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *=
evlist, bool system_wide)
> >       evsel->core.attr.exclude_kernel =3D 1;
> >       evsel->core.attr.exclude_guest =3D 1;
> >       evsel->core.attr.exclude_hv =3D 1;
> > -     evsel->core.attr.freq =3D 0;
> > -     evsel->core.attr.sample_period =3D 1;
> >       evsel->core.system_wide =3D system_wide;
> >       evsel->no_aux_samples =3D true;
> >       evsel->name =3D strdup("dummy:u");
>
> Note that evsel__config() will put it back to freq if -F is used.

Right, I was looking for a minimal fix in part for the sake of back
porting. For the -F we could do:

```
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d5363d23f5d3..806185a39e17 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1083,11 +1083,15 @@ void __weak arch__post_evsel_config(struct
evsel *evsel __maybe_unused,
static void evsel__set_default_freq_period(struct record_opts *opts,
                                          struct perf_event_attr *attr)
{
-       if (opts->freq) {
+       bool is_dummy =3D attr->type =3D=3D PERF_TYPE_SOFTWARE &&
+               attr->config =3D=3D PERF_COUNT_SW_DUMMY;
+
+       if (opts->freq && !is_dummy) {
               attr->freq =3D 1;
               attr->sample_freq =3D opts->freq;
       } else {
-               attr->sample_period =3D opts->default_interval;
+               attr->freq =3D 0;
+               attr->sample_period =3D is_dummy ? 1 : opts->default_interv=
al;
       }
}
```

But this felt like it could potentially have other side-effects.
Software events like page faults have a period, but the
dummy/side-band events appear never to check the period - but I could
be wrong. We can add the patch above but perhaps without a fixes tag.

Thanks,
Ian

> Nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
