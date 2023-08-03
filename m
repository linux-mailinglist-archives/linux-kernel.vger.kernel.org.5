Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2776E61F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjHCLCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjHCLCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:02:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC644B0;
        Thu,  3 Aug 2023 04:01:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so1356678e87.2;
        Thu, 03 Aug 2023 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691060502; x=1691665302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN8dB1/YPF0AFF/X+RnVri//bBPDTVUZrPbitsMQtMs=;
        b=hSusEMjYK9V01fsAUtzg7Cnm5iNLry2FkJBoY6sadWcZ3EAVMrBpCNqzvz0P33FZY9
         BvwhQmJTtmzVHlk0bgz2OHUiRrnHbbNG6pqWbQI/tNpYgXXMXBbBgrGj4UHqi5/Mc+h3
         a9kuGnL5GMk0U6Du90Y03FUGk2dVzV9cAlqEu+JW5VQWsqAX7MPdnakxzYl7XAiCRmHo
         Yqev/Gu/Jm/FtgmgX0EhkHZl1Xr/ojj/7D7mnB9uiesbr32n22l90vizPlOw2wG0IOud
         Dx+UM6VQ3J1OD5yGWmUDqdBZEeDDsvGRF5mBXwtR2SKTyK6nMGurq+FhNeuv3ZvlDOce
         2rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691060502; x=1691665302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mN8dB1/YPF0AFF/X+RnVri//bBPDTVUZrPbitsMQtMs=;
        b=GnQo8pRB8tC+8G7YDGmnfiH1xROh3j/PCQeSvn6lHzsBdETjdpvXexMBWbjLA1xp0L
         y7hulRRzLYFFwTgzscLVfrk5dtPbh4ZlmTV2UptDnfkQ/0Rq7riyqu9CMnZPwO0++Wdm
         Yi5KwwNMm2NvGrvQwuBDsmKo260e2dFeULoOHIhohgcL4/FwudszPnqg5EDhVi1sy/kZ
         NaoofXdsUYkMuadknfBn4QpNhiqzkpmzPeISt7X9SPa0Hlx6M8eaFO//KScCu6ktwrEB
         91PlQeTJ1krBcY3qooAJNdVTSHW2ghLB/4XazJZbqgBUYqZT4cdPlVywyTkj/JI1dFEn
         XvPg==
X-Gm-Message-State: ABy/qLbKWjbYqKxVI2i9nEQ/NIml34HPBw7qPdtm+av05cavnTyEVl8s
        8bBDrBj6Hize+h5pVtJanmHhrj/gpm5OIsy9Hr8=
X-Google-Smtp-Source: APBJJlGUrbtO3CePqXUPjvj+Y1GEcExse1AuVWvNFDiOYxk7+ti86KgDpJEigNUEFlgejp8vOtVYBoTppbE+NY9LiO0=
X-Received: by 2002:a19:4f14:0:b0:4fe:167e:9f04 with SMTP id
 d20-20020a194f14000000b004fe167e9f04mr6382857lfb.61.1691060502057; Thu, 03
 Aug 2023 04:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-6-zegao@tencent.com>
 <20230803053405.4d91015d@gandalf.local.home>
In-Reply-To: <20230803053405.4d91015d@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 19:01:30 +0800
Message-ID: <CAD8CoPDGFJYP12uRF6U0tDsV8Bv9vq9Dey0pxQnQmjZOndJBdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 5/5] perf sched: prefer to use prev_state_char
 introduced in sched_switch
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 5:34=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu,  3 Aug 2023 04:33:52 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Since the sched_switch tracepoint introduces a new variable to
> > report sched-out task state in symbolic char, we prefer to use
> > it to spare from knowing internal implementations in kernel.
>
> The above needs to be rewritten to be more comprehensive.
> Feel free to reply to this thread with new versions of the change log and
> such. No need to send a new patch series to fix this before you know that
> the new version is acceptable or not.

Copy that! Thank you.

> Replying to a current patch series is fine, but sending out a new one
> causes the spam as it's much easier to ignore a thread than to ignore a n=
ew
> thread with a new series.

Thanks Steven!  Lesson learned.

Regards,
Ze

>
>
> >
> > Also we keep the old parsing logic intact but sync the state char
> > array with the latest kernel.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  tools/perf/builtin-sched.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 5042874ba204..6f99a36206c9 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -837,7 +837,7 @@ replay_wakeup_event(struct perf_sched *sched,
> >
> >  static inline char task_state_char(int state)
> >  {
> > -     static const char state_to_char[] =3D "RSDTtXZPI";
> > +     static const char state_to_char[] =3D "RSDTtXZPIp";
> >       unsigned int bit =3D state ? ffs(state) : 0;
> >
> >       return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?'=
;
> > @@ -846,9 +846,20 @@ static inline char task_state_char(int state)
> >  static inline char get_task_prev_state(struct evsel *evsel,
> >                                      struct perf_sample *sample)
> >  {
> > -     const int prev_state =3D evsel__intval(evsel, sample, "prev_state=
");
> > +     char prev_state_char;
> > +     int prev_state;
> >
> > -     return task_state_char(prev_state);
> > +     /* prefer to use prev_state_char */
> > +     if (evsel__field(evsel, "prev_state_char"))
> > +             prev_state_char =3D (char) evsel__intval(evsel,
> > +                             sample, "prev_state_char");
> > +     else {
> > +             prev_state =3D (int) evsel__intval(evsel,
> > +                             sample, "prev_state");
> > +             prev_state_char =3D task_state_char(prev_state);
> > +     }
> > +
> > +     return prev_state_char;
> >  }
> >
> >  static int replay_switch_event(struct perf_sched *sched,
> > @@ -2145,7 +2156,7 @@ static void timehist_update_runtime_stats(struct =
thread_runtime *r,
> >               else if (r->last_time) {
> >                       u64 dt_wait =3D tprev - r->last_time;
> >
> > -                     if (r->last_state =3D=3D 'R')
> > +                     if (r->last_state =3D=3D 'R' || r->last_state =3D=
=3D 'p')
> >                               r->dt_preempt =3D dt_wait;
> >                       else if (r->last_state =3D=3D 'D')
> >                               r->dt_iowait =3D dt_wait;
>
