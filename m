Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB76A76DE59
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjHCCjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjHCCjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:39:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31A1713;
        Wed,  2 Aug 2023 19:38:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so488531a12.0;
        Wed, 02 Aug 2023 19:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691030335; x=1691635135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EecucEpTbRj2GJZv+DMCHZrsVlsYJQ4FsHycdTutpDs=;
        b=lPmF+jU2LgznkDHkXkayXi69tSumH9HaA2MThdZ6EJHhBKvdu2qhANzGAV419vfrZG
         KlsPmzDvyx6Bo57VzKrFryyNXskwe1elulW3hiEiujvZB8VPL7QpFq93q61jeGV2QCtp
         H5RFmq8lXaSXSh/SlydEhp8/xvylhoNGb9UUHl9FEG/UeMgtWKb58p2BH17Dez1OauEX
         BU/F6cglQbNej8AfqFnWFdh2yPrgYwmQhuYkx2l/mYd5N8h0FA3H9/GJvMvcFkHG3Ayh
         v9rteHxfuwJ098myD10NlOeygr3xWUrl5wcZbaLIZvLiBfYcg2R1si+Lh+017k+YqPqD
         nzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691030335; x=1691635135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EecucEpTbRj2GJZv+DMCHZrsVlsYJQ4FsHycdTutpDs=;
        b=TZSbf8s1IE6onSdeKocjElQlbn41/8W9oC2c7V1K+5E8GmhSUCxXV7AuUleAq1Jd1k
         qly7MTS9uwISeHUnHt9lSs/UIdKYR5NX1gxhhwdgAwVEO5OV0v2ZcLbObxdetWb8dKup
         LpRqfRivMW7NVPhmReN6Tyi4DMb3PXt9/yRfWtGG2iW84iYTr8uyP5pd0va+d5HpTzQ5
         sM/7vlZCVIVfJ9x5cFzdTuvTh6RS8wuVFvCx0d6HBtMfN+L7ax2/O9ff4v8m1onpgF86
         x/DDdrzOX3F6/B4dlLNaLZp/aqDfALImeN5a40mRqBwLcyeiggAApF0ypxbozed66v8O
         ndxA==
X-Gm-Message-State: ABy/qLYw9GX6l4yzPmZfGRvtmguIs+r6Xa51sflP6UxT8QoL0NTRTk0e
        qlWaCdOW1k6ltAIeFYvX/AFR3fnMfuAekmEa5tM=
X-Google-Smtp-Source: APBJJlGHykNDgCqFY0E8UFyXx2st0pfkHt8Tqx/qGIeSwSSSRU4AELCHg947g2Tq32CzpyxEiJOq7yVuOEw41yK0f1Y=
X-Received: by 2002:a05:6402:8:b0:51d:87c6:bf28 with SMTP id
 d8-20020a056402000800b0051d87c6bf28mr6368292edu.3.1691030335039; Wed, 02 Aug
 2023 19:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230802121116.324604-1-zegao@tencent.com> <20230802121116.324604-6-zegao@tencent.com>
 <20230802110701.5227346d@gandalf.local.home>
In-Reply-To: <20230802110701.5227346d@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 10:38:43 +0800
Message-ID: <CAD8CoPDUkUOc8_p8Ygnoy6xfQZtPhiDDPgnhTMfoEtmrQFRwMw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/7] sched, tracing: add to report task state in
 symbolic chars
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
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
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

On Wed, Aug 2, 2023 at 11:07=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed,  2 Aug 2023 08:10:00 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > From: Ze Gao <zegao2021@gmail.com>
> >
> > Internal representations of task state are likely to be changed
> > or ordered, and reporting them to userspace without exporting
> > them as part of API is basically wrong, which can easily break
> > a userspace observability tool as kernel evolves. For example,
> > perf suffers from this and still reports wrong states as of this
> > writing.
> >
> > OTOH, some masqueraded states like TASK_REPORT_IDLE and
> > TASK_REPORT_MAX are also reported inadvertently, which confuses
> > things even more and most userspace tools do not even take them
> > into consideration.
> >
> > So add a new variable in company with the old raw value to
> > report task state in symbolic chars, which are self-explaining
> > and no further translation is needed. Of course this does not
> > break any userspace tool.
> >
> > Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use
> > the old conventions for the rest.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/trace/events/sched.h | 44 ++++++++++++++++++++++--------------
> >  1 file changed, 27 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.=
h
> > index 7d34db20b2c6..1c7b94793495 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -6,6 +6,7 @@
> >  #define _TRACE_SCHED_H
> >
> >  #include <linux/kthread.h>
> > +#include <linux/sched.h>
> >  #include <linux/sched/numa_balancing.h>
> >  #include <linux/tracepoint.h>
> >  #include <linux/binfmts.h>
> > @@ -214,6 +215,27 @@ static inline int __trace_sched_switch_state(bool =
preempt,
> >
> >       return state ? (1 << (state - 1)) : state;
> >  }
> > +
> > +static inline char __trace_sched_switch_state_char(bool preempt,
> > +                                                unsigned int prev_stat=
e,
> > +                                                struct task_struct *p)
> > +{
> > +     long state;
> > +
> > +#ifdef CONFIG_SCHED_DEBUG
> > +     BUG_ON(p !=3D current);
>
> BUG? Why not WARN_ON()?

I directly copied it from __trace_sched_switch_state since they
are very similar. I had doubt on this too but decided to keep it in
case people want to be 100% sure that the current task is exactly
the one that is being switched, otherwise it's a fatal problem for
scheduler at the point where trace_sched_switch is called.

If you think WARN_ON_ONCE is more appropriate, I can fix both
in v6.

Thoughts?

Regards,
Ze
