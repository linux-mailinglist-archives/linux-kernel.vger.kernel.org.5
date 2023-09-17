Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E67A3383
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 02:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjIQAqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 20:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjIQAq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 20:46:26 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE4F1AB
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 17:46:21 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6563e4defedso7819426d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 17:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694911580; x=1695516380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aEmj8XWPxbuE/jyhPT5yboCcWyurniEilj0tCFF0PI=;
        b=DMp7dGH4GGfWNou7gCP45SjRrWWBALgSzZThsA0xkwryQH/wrpmG2p7/8BagKe272g
         7/gJL9eDA3vWV/R0dzGs55asGC+rzBBx6ilXgHg+LDwg/irY10VisVvppKO3TpV5RSN5
         ul2E8hui/0akRfGMO4YfyMRk7E+3QOA2l6O1Mln7rLPvnjwCUGSVib5dJt4oQC4JemcA
         4HRlabfQ09elEYYZkeN0jLZSZ6NAOhQwwR3KOKucM3Okb+xUCl8T3knqtUlvxSPfyMpg
         HP035POcAIGAxh5qZ8kegiC8dEq9DBqs5kltQ/gkpgCJN6/WwFe4DVREoF3LPBNMjcq3
         lAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694911580; x=1695516380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aEmj8XWPxbuE/jyhPT5yboCcWyurniEilj0tCFF0PI=;
        b=h/RwvENBNbVRFahLzHcV9J0yGMaL7jMT0vkaRQLdSKCG0VUhD2eahbuB6vI/41UIyI
         6jIuMe3lrOvmEnpfDV0gSWHsUqHlCVt22Y1z8ZEneSzlBWw6lvgjeWL6PTasv1TrzDSl
         P4hH3ep7qWK41A5Omd9AxtEW3gh0En+kfaj9P0+2EMcR0zA04rUlLzeRls0OZp6nmr7f
         kC5+eAeX0j5JZb9nD/UdmTqhuZULUURPrNxMekLV9PiX3vmnbkxR97CsB6Tojt3PdcC1
         Cllt37qiEFhfGawzOM8b3Nyjrkype4E3Dst82XU4wWtJRZHjxNYzDYx29Etq7HorViJo
         VGrw==
X-Gm-Message-State: AOJu0YzYmem0WmTnAced9Tmq8ev6XLHK5fsHJT5jLcU5952ISuZvPNrp
        cqCzp0/hpIunZIhmV2sYNuhUvlbT3TV8/zmh2mO0Yg==
X-Google-Smtp-Source: AGHT+IFsZYGuexoTW0OQeG2A8TdgpZEVd1UokZV9+/98bP6+pbBPkbQg5dNIdOX17qidz7/cHW6YvPiw7z6T/+ogfjQ=
X-Received: by 2002:a0c:e34c:0:b0:656:3f9f:349d with SMTP id
 a12-20020a0ce34c000000b006563f9f349dmr3963490qvm.52.1694911580338; Sat, 16
 Sep 2023 17:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com>
In-Reply-To: <20230916040915.1075620-1-irogers@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Sat, 16 Sep 2023 17:45:44 -0700
Message-ID: <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 9:10=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Dummy events are created with an attribute where the period and freq
> are zero. evsel__config will then see the uninitialized values and
> initialize them in evsel__default_freq_period. As fequency mode is
> used by default the dummy event would be set to use frequency
> mode. However, this has no effect on the dummy event but does cause
> unnecessary timers/interrupts. Avoid this overhead by setting the
> period to 1 for dummy events.
>
> evlist__add_aux_dummy calls evlist__add_dummy then sets freq=3D0 and
> period=3D1. This isn't necessary after this change and so the setting is
> removed.
>
> From Stephane:
>
> The dummy event is not counting anything. It is used to collect mmap
> records and avoid a race condition during the synthesize mmap phase of
> perf record. As such, it should not cause any overhead during active
> profiling. Yet, it did. Because of a bug the dummy event was
> programmed as a sampling event in frequency mode. Events in that mode
> incur more kernel overheads because on timer tick, the kernel has to
> look at the number of samples for each event and potentially adjust
> the sampling period to achieve the desired frequency. The dummy event
> was therefore adding a frequency event to task and ctx contexts we may
> otherwise not have any, e.g., perf record -a -e
> cpu/event=3D0x3c,period=3D10000000/. On each timer tick the
> perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
> non-zero, then the kernel will loop over ALL the events of the context
> looking for frequency mode ones. In doing, so it locks the context,
> and enable/disable the PMU of each hw event. If all the events of the
> context are in period mode, the kernel will have to traverse the list for
> nothing incurring overhead. The overhead is multiplied by a very large
> factor when this happens in a guest kernel. There is no need for the
> dummy event to be in frequency mode, it does not count anything and
> therefore should not cause extra overhead for no reason.
>
> Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy const=
ructor")
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evlist.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 25c3ebe2c2f5..e36da58522ef 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evlis=
t *evlist)
>                 .type   =3D PERF_TYPE_SOFTWARE,
>                 .config =3D PERF_COUNT_SW_DUMMY,
>                 .size   =3D sizeof(attr), /* to capture ABI version */
> +               /* Avoid frequency mode for dummy events to avoid associa=
ted timers. */
> +               .freq =3D 0,
> +               .sample_period =3D 1,
>         };
>
>         return evsel__new_idx(&attr, evlist->core.nr_entries);
> @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *ev=
list, bool system_wide)
>         evsel->core.attr.exclude_kernel =3D 1;
>         evsel->core.attr.exclude_guest =3D 1;
>         evsel->core.attr.exclude_hv =3D 1;
> -       evsel->core.attr.freq =3D 0;
> -       evsel->core.attr.sample_period =3D 1;
>         evsel->core.system_wide =3D system_wide;
>         evsel->no_aux_samples =3D true;
>         evsel->name =3D strdup("dummy:u");
> --
> 2.42.0.459.ge4e396fd5e-goog
>

Thank you very much for the change. I have one quick question about
the PMU unthrottling logic. When I am looking into the function
perf_adjust_freq_unthr_context(), I see the loop with PMU stop and
start in each iteration. Is there a good way to avoid this PMU reset
operation while quickly figuring out the event in frequency mode?

Thanks.
-Mingwei
