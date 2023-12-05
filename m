Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA02805DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjLESHt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 13:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjLESHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:07:47 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F1B2;
        Tue,  5 Dec 2023 10:07:54 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28659348677so42503a91.0;
        Tue, 05 Dec 2023 10:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799673; x=1702404473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNlzMFur71ZQLLM8yVbvG7H8ZNU7xWznyiwruW2zco0=;
        b=mmpoplhQu5uU/XSuuWP/AqZ8VpkAKj5UQwW7THhA8AUjNqnjE16Xc1Z13cI5HcQUlS
         JhAkQt7b4jSEUjH8ondLXyM64q6MnYaLfFhFn1f57pww8Guh7wjzt0I27dXkjldJSOIS
         ML53Ydc4wt09wtjhaEgjrTBFymmNmJ7ADTQHVWTTvfdgLqoxHdUlKTexwM9xfzUVY8Vl
         v4UV9moer2GAJzslTjtrB4hMMssifMK1F6Aub0UIh64xbePDukSavbJUXW+78T0eRoiI
         g4vMGjt3drqWBGFxqWRoc1FWLH8YPixAnViCX7vyyeZgf5RBTJYCHHtp10vh4Ys2Aw67
         cYKg==
X-Gm-Message-State: AOJu0YzT5jZn00jLY3thcs/QSy0hE2wCz7g4olUqF8HMWe3DvD5q8a+3
        ULKve4jgBhQv7SS9mrXhSNZEo0N6w6FX/JAOyrQ=
X-Google-Smtp-Source: AGHT+IHGLbi5nmB/0juEOSLMahSlJHYu1FGow8cvsSJNx3cCdYCI6tX17VGnnmPmUgMoA0doL5dZ4OEouXFjdhP676I=
X-Received: by 2002:a17:90b:1c0b:b0:286:bda8:9633 with SMTP id
 oc11-20020a17090b1c0b00b00286bda89633mr1926839pjb.25.1701799673408; Tue, 05
 Dec 2023 10:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-2-khuey@kylehuey.com>
 <CAEf4BzYtSXtgdO9C2w9OOKni68H-7UOExFJRBEij3HG2Qwn1Rg@mail.gmail.com> <ZW8Gi2QI5ceAJfab@krava>
In-Reply-To: <ZW8Gi2QI5ceAJfab@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 5 Dec 2023 10:07:42 -0800
Message-ID: <CAM9d7chztaCfDsxfyJ2q_UmD=y20BFikCUQhs=LR8wsNV6pMjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O signals.
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kyle Huey <me@kylehuey.com>, Kyle Huey <khuey@kylehuey.com>,
        linux-kernel@vger.kernel.org,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Add Marco Elver to CC.

On Tue, Dec 5, 2023 at 3:16 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Dec 04, 2023 at 02:18:49PM -0800, Andrii Nakryiko wrote:
> > On Mon, Dec 4, 2023 at 12:14 PM Kyle Huey <me@kylehuey.com> wrote:
> > >
> > > Returning zero from a bpf program attached to a perf event already
> > > suppresses any data output. This allows it to suppress I/O availability
> > > signals too.
> >
> > make sense, just one question below
> >
> > >
> > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> > > ---
> > >  kernel/events/core.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index b704d83a28b2..34d7b19d45eb 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -10417,8 +10417,10 @@ static void bpf_overflow_handler(struct perf_event *event,
> > >         rcu_read_unlock();
> > >  out:
> > >         __this_cpu_dec(bpf_prog_active);
> > > -       if (!ret)
> > > +       if (!ret) {
> > > +               event->pending_kill = 0;
> > >                 return;
> > > +       }
> >
> > What's the distinction between event->pending_kill and
> > event->pending_wakeup? Should we do something about pending_wakeup?
> > Asking out of complete ignorance of all these perf specifics.
> >
>
> I think zeroing pending_kill is enough.. when it's set the perf code
> sets pending_wakeup to call perf_event_wakeup in irq code that wakes
> up event's ring buffer readers and sends sigio if pending_kill is set

Right, IIUC pending_wakeup is set by the ring buffer code when
a task is waiting for events and it gets enough events (watermark).
So I think it's good for ring buffer to manage the pending_wakeup.

And pending_kill is set when a task wants a signal delivery even
without getting enough events.  Clearing pending_kill looks ok
to suppress normal signals but I'm not sure if it's ok for SIGTRAP.

If we want to handle returning 0 from bpf as if the event didn't
happen, I think SIGTRAP and event_limit logic should be done
after the overflow handler depending on pending_kill or something.

Thanks,
Namhyung
