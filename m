Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4954176F7CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjHDCXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjHDCXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:23:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB3B4680;
        Thu,  3 Aug 2023 19:22:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so2706532e87.2;
        Thu, 03 Aug 2023 19:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691115729; x=1691720529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0h7iWjuLjZV6ZF1NMpCJ/oaSh2XQCJuifsadDe4GTE=;
        b=s1pX/luML5i2+Fpub3Q04CqfkbB5vuhnkmWYBA/aE2wAwUDhbUdq/5CLybe80t3Adu
         VGEVqdREBinjCMbVSKVWDgQZR+gUCBEVdLO3CStBaV2WUXEV1eZA0NxZBhZ0OamKQAW9
         qOuLe02QeiMNLMcDQj/3r9m3QIkHJ/c4x/18A9IEMxdM8al2AryaphJ+tu/kmqlFpqI1
         bNZaTgF8Th7mu5ORoCP78E4z1vMiKpiCN+r23EW0GuEDNmSs8OQxEGgDLmGrQldZ1WtK
         8PIK2E+DOoibFQ+XRYuBoG7GWjVz8Fowuiso+2yzFWQNGPDQ1t+YUs1XyRgKBS5nFrQz
         9eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115729; x=1691720529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0h7iWjuLjZV6ZF1NMpCJ/oaSh2XQCJuifsadDe4GTE=;
        b=gMpsxkGPnzcb7BPPLjXlaQqBXC7enYLSMmXsb10HlE34cTdxYSSh9On8u5bRA+/Qgy
         w1gFvdM3xvdnKlObPTgLCZHb+Md8DSTCGiyTL5XKMKjEChhyEmCb2i25l0pxI7xlPPzV
         bBcx1E4w06dGrvKENahMhQzC3uVd4RK1hZ2diZwbSYmhI3oflZknPagpkl+RN8mjxJU7
         DZBVLkahohhTfEQHakZGA/TyjiBk0ASHoBkAGUKq9pSgINBO3Xgv7AOh/MhGYKXZgbmn
         nB/d8mRLNieHUjDxxfOudK9PbtF87USWcZv7NRSTL8xoFdBzYO/sKQtkyFiU3Qz5Yx60
         S3jA==
X-Gm-Message-State: AOJu0Yy3Q9FEpKU7fxn+QMbGKqTPxK/TBj9kAEtv6TeCyohArg+5TwL/
        LfyuDtHJPD98o/1pfdLUqbxa/fBXGLKsAKLgB8E=
X-Google-Smtp-Source: AGHT+IHggI/I3xDds3oKJgaqLy7EaSUfpkwlUW31vx6xx2d+AbOUYtn2OHzqqLqV3FSHilHI4bRJF4XL7UgdQzLznI8=
X-Received: by 2002:a05:6512:324d:b0:4f8:6833:b13c with SMTP id
 c13-20020a056512324d00b004f86833b13cmr235780lfr.14.1691115729043; Thu, 03 Aug
 2023 19:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-2-zegao@tencent.com>
 <20230803111031.056b3446@gandalf.local.home>
In-Reply-To: <20230803111031.056b3446@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Fri, 4 Aug 2023 10:21:57 +0800
Message-ID: <CAD8CoPBy4Q1khVyhROMMnS=cfbSZuL0GCuSxMcKLRuTb2qtMjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/5] perf sched: sync state char array with the kernel
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

On Thu, Aug 3, 2023 at 11:10=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu,  3 Aug 2023 04:33:48 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Update state char array and then remove unused and stale
> > macros, which are kernel internal representations and not
> > encouraged to use anymore.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  tools/perf/builtin-sched.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 9ab300b6f131..8dc8f071721c 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -92,23 +92,12 @@ struct sched_atom {
> >       struct task_desc        *wakee;
> >  };
> >
> > -#define TASK_STATE_TO_CHAR_STR "RSDTtZXxKWP"
> > +#define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
>
> Thinking about this more, this will always be wrong. Changing it just wor=
ks
> for the kernel you made the change for, but if it is run on another kerne=
l,
> it's broken again.

Indeed. There is no easy way to maintain backward compatibility unless
we stop using this bizarre 'prev_state' field. Basically all its users suff=
er
from this. That's why I believe this needs a fix to alert people does not
use 'prev_state' anymore.

> I actually wrote code once that basically just did a:
>
>         struct trace_seq s;
>
>         trace_seq_init(&s);
>         tep_print_event(tep, &s, record, "%s", TEP_PRINT_INFO);
>
> then searched s.buffer for "prev_state=3D%s ", to find the state characte=
r.
>
> That's because the kernel should always be up to date (and why I said I
> needed that string in the print_fmt).

Turing to building the state char array from print fmt string dynamically
is a great idea. :)

> As perf has a tep handle, this could be a helper function to extract the
> state if needed, and get rind of relying on the above character array.

I'll figure out how to make it happen.

BTW,  my last concern is that is there any better way to notice userspace t=
o
avoid interpreting task state out of 'prev_state'. Because the awkward thin=
g
happens again.

Thanks,
Ze

> -- Steve
>
>
> >
> >  /* task state bitmask, copied from include/linux/sched.h */
> >  #define TASK_RUNNING         0
> >  #define TASK_INTERRUPTIBLE   1
> >  #define TASK_UNINTERRUPTIBLE 2
> > -#define __TASK_STOPPED               4
> > -#define __TASK_TRACED                8
> > -/* in tsk->exit_state */
> > -#define EXIT_DEAD            16
> > -#define EXIT_ZOMBIE          32
> > -#define EXIT_TRACE           (EXIT_ZOMBIE | EXIT_DEAD)
> > -/* in tsk->state again */
> > -#define TASK_DEAD            64
> > -#define TASK_WAKEKILL                128
> > -#define TASK_WAKING          256
> > -#define TASK_PARKED          512
> >
> >  enum thread_state {
> >       THREAD_SLEEPING =3D 0,
>
