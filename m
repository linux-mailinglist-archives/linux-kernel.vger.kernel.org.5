Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9724E7E0874
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjKCSsj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Nov 2023 14:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCSsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:48:37 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A9ED45;
        Fri,  3 Nov 2023 11:48:35 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28019b66ad5so2157688a91.3;
        Fri, 03 Nov 2023 11:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699037315; x=1699642115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HYAQpuZLbZa219M3eCpKYKVGNMx7y39abDg1zJkZtI=;
        b=ihz7h5xnOTAFlXa+bbB6ESstP+NJpGiZL1+/cE/sM6vRXugNdNOVKbZSmZpiPI2UBA
         9Z6AvFhNK1eEshPc7gryj6YxNKinapLNqG/h0C/RgNlBPqLrlj6oChCTeeHD/YNi9zpi
         4IBr1fQITF9u9T7NtcuK03vI2fxLY1HaxUrIsS0ZQgf9EeNMPqyW0amqgXZfSLgpKlKv
         8rM+rxQTPofnYxMR/QaOlsmB3UfxUaxuTi4ib0IyEilUGOWlJFFV37bpEEjpfHk+0/VD
         WC6OZAmsOvIYSyjlt6QqpUCyyavzEw/xsqieAPL3cXDS42lHP/UFVlZCFoTCmV0LafoG
         C1Nw==
X-Gm-Message-State: AOJu0Yzw1P9Eu5HYhxH3XlUBx9orTBsL4WhBo1E2WFLlWOpbcHgsc/vx
        aUCgN8sKNBo6rNWk8ykx+3iuaVoFvZyUa+2tLnM=
X-Google-Smtp-Source: AGHT+IGU8rAUkw2AaLIR4Nvk+RD/8wl5G4j2haVEz9flfwcdK89oxEEJA8qbHe55QexfKLVKjEPvtphbwJ+Emi7UqzY=
X-Received: by 2002:a17:90b:4f91:b0:27d:3f0c:f087 with SMTP id
 qe17-20020a17090b4f9100b0027d3f0cf087mr21908587pjb.25.1699037314556; Fri, 03
 Nov 2023 11:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231102222653.4165959-1-namhyung@kernel.org> <20231102222653.4165959-2-namhyung@kernel.org>
 <CAP-5=fV=huOH7_8ba_xRT5V4RZUZ0O54OkHcRRHzuSPH_SemCA@mail.gmail.com>
In-Reply-To: <CAP-5=fV=huOH7_8ba_xRT5V4RZUZ0O54OkHcRRHzuSPH_SemCA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Nov 2023 11:48:23 -0700
Message-ID: <CAM9d7cim4ETcSUUdSL2d_gLXe+4LJo4KUw7iTUJ=35sZNOkcqQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf annotate: Split struct cycles_info
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
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

Hi Ian,

On Thu, Nov 2, 2023 at 3:53 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Nov 2, 2023 at 3:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The cycles info is used only when branch stack is provided.  Split them
> > into a separate struct and lazy allocate them to save some memory.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/ui/browsers/annotate.c |  2 +-
> >  tools/perf/util/annotate.c        | 34 ++++++++++++++++++-------------
> >  tools/perf/util/annotate.h        | 14 ++++++++-----
> >  3 files changed, 30 insertions(+), 20 deletions(-)
> >
> > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > index ccdb2cd11fbf..d2470f87344d 100644
> > --- a/tools/perf/ui/browsers/annotate.c
> > +++ b/tools/perf/ui/browsers/annotate.c
> > @@ -337,7 +337,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
> >                                 max_percent = percent;
> >                 }
> >
> > -               if (max_percent < 0.01 && pos->al.ipc == 0) {
> > +               if (max_percent < 0.01 && (!pos->al.cycles || pos->al.cycles->ipc == 0)) {
> >                         RB_CLEAR_NODE(&pos->al.rb_node);
> >                         continue;
> >                 }
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 82956adf9963..3e7f75827270 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1100,8 +1100,8 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
> >                 for (offset = start; offset <= end; offset++) {
> >                         struct annotation_line *al = notes->offsets[offset];
> >
> > -                       if (al && al->ipc == 0.0) {
> > -                               al->ipc = ipc;
> > +                       if (al && al->cycles && al->cycles->ipc == 0.0) {
> > +                               al->cycles->ipc = ipc;
> >                                 cover_insn++;
> >                         }
> >                 }
> > @@ -1134,13 +1134,18 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
> >                 if (ch && ch->cycles) {
> >                         struct annotation_line *al;
> >
> > +                       al = notes->offsets[offset];
> > +                       if (al && al->cycles == NULL) {
> > +                               al->cycles = zalloc(sizeof(*al->cycles));
> > +                               if (al->cycles == NULL)
> > +                                       continue;
> > +                       }
> >                         if (ch->have_start)
> >                                 annotation__count_and_fill(notes, ch->start, offset, ch);
> > -                       al = notes->offsets[offset];
> >                         if (al && ch->num_aggr) {
> > -                               al->cycles = ch->cycles_aggr / ch->num_aggr;
> > -                               al->cycles_max = ch->cycles_max;
> > -                               al->cycles_min = ch->cycles_min;
>
> Thanks for doing this! Would it make sense to do the zalloc here to be
> lazier about allocation?

annotation__count_and_fill() also needs it.

Thanks,
Namhyung

>
> Ian
>
> > +                               al->cycles->avg = ch->cycles_aggr / ch->num_aggr;
> > +                               al->cycles->max = ch->cycles_max;
> > +                               al->cycles->min = ch->cycles_min;
> >                         }
> >                         notes->have_cycles = true;
