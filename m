Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643AE7A33D6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjIQF3b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Sep 2023 01:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjIQF3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:29:02 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C961A1;
        Sat, 16 Sep 2023 22:28:57 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-79536bc6697so118412239f.1;
        Sat, 16 Sep 2023 22:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928536; x=1695533336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MHIZkZeAIKnnl1lZGJ/D+rrsmVGORmOG4/glxjZ15E=;
        b=TfoM8lcHe1ADxDB8c9W1HYknxELZ/3auTLDY2k99+u0zHQyj2U76x4W5xP1AzV2Ek2
         w0x0P/L0tUmgW8nqDTq5Lqzqhgt9UlBQRbXJhrhz9wYEI5qYqq8zPV8fleNrgiiTaztG
         /zZsDhQB/Y6Ru1PLQEnDhYVIJXZCoWC/RXd7DHSeys9UKltIHmiLp3epfGT5mMAjCeOi
         7VCULjoiR8ykTGswjoKztKhb8Qfrj5vNDbXpDoS7GxDHWATVOXs4uXizcRxjcb/Eak72
         1uQKy7NdQ5Lt1iObObb5GpldXL1YiOSmqceUiecywRXcO97V0S7PXDUJz5yhjEW5mlZA
         M1bg==
X-Gm-Message-State: AOJu0YwDF+UbAUDhHDJG5AxI4H22RyIeGLHrE0NWyOOjdbrkl4syGyQ6
        AbCah43g9bB5TQNytfmE39I6CeO/f0yIAUtSCeE=
X-Google-Smtp-Source: AGHT+IGhUl97YDoT1dRB7ImhDttCNn1/6JQ4Uu+U9kgLRnGV8tDLdz1mqPJh2iGjnGZsosOTWry9acRtj9qVMGz3mQY=
X-Received: by 2002:a6b:5c18:0:b0:795:16b8:85fc with SMTP id
 z24-20020a6b5c18000000b0079516b885fcmr6619462ioh.0.1694928536589; Sat, 16 Sep
 2023 22:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230908052216.566148-1-namhyung@kernel.org> <CAP-5=fUtEvW9h7N=w3vvYBB3vytnTXJsXrHDD6zLA2DzYFOBHQ@mail.gmail.com>
 <CAM9d7cj1rEjGy0QM2tkJhBn=hac-9Jya+ZJ4SNhBmB29u5KVMg@mail.gmail.com>
 <ad8a8d46151142a883d2d259c884acc0@AcuMS.aculab.com> <CAM9d7ciB-Rmsi4eTOU7n=mcEP2-JjDycL6f_8cKnKGKtqVT3UQ@mail.gmail.com>
 <CAP-5=fU=8RwHsd=nP6evT2oxCeOvXF4dfNF9MhBVk3y2WvH3MQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU=8RwHsd=nP6evT2oxCeOvXF4dfNF9MhBVk3y2WvH3MQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 16 Sep 2023 22:28:44 -0700
Message-ID: <CAM9d7ciJLC_3kaxUeVB5sRn9O=xX1ktWeejagSdihfV4a9SPuA@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Add more x86 mov instruction cases
To:     Ian Rogers <irogers@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 4:24 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Sep 13, 2023 at 2:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Sep 11, 2023 at 1:12 AM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Namhyung Kim
> > > > Sent: 09 September 2023 00:56
> > > >
> > > > Hi Ian,
> > > >
> > > > On Thu, Sep 7, 2023 at 11:24 PM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > On Thu, Sep 7, 2023 at 10:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > Instructions with sign- and zero- extention like movsbl and movzwq were
> > > > > > not handled properly.  As it can check different size suffix (-b, -w, -l
> > > > > > or -q) we can omit that and add the common parts even though some
> > > > > > combinations are not possible.
> > > > > >
> > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > ---
> > > > > >  tools/perf/arch/x86/annotate/instructions.c | 9 ++++++---
> > > > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/perf/arch/x86/annotate/instructions.c
> > > > b/tools/perf/arch/x86/annotate/instructions.c
> > > > > > index 5f4ac4fc7fcf..5cdf457f5cbe 100644
> > > > > > --- a/tools/perf/arch/x86/annotate/instructions.c
> > > > > > +++ b/tools/perf/arch/x86/annotate/instructions.c
> > > > > > @@ -74,12 +74,15 @@ static struct ins x86__instructions[] = {
> > > > > >         { .name = "movdqa",     .ops = &mov_ops,  },
> > > > > >         { .name = "movdqu",     .ops = &mov_ops,  },
> > > > > >         { .name = "movsd",      .ops = &mov_ops,  },
> > > > > > -       { .name = "movslq",     .ops = &mov_ops,  },
> > > > > >         { .name = "movss",      .ops = &mov_ops,  },
> > > > > > +       { .name = "movsb",      .ops = &mov_ops,  },
> > > > > > +       { .name = "movsw",      .ops = &mov_ops,  },
> > > > > > +       { .name = "movsl",      .ops = &mov_ops,  },
> > > > >
> > > > > In Intel's manual some of these names are "Move Data From String to
> > > > > String" operations, movsb and movsw in particular. These instructions
> > > > > can be used to make simple memcpy loops. Could it be the past omission
> > > > > was deliberate due to the different way the addressing works in the
> > > > > instructions?
> > > >
> > > > I don't know but in terms of instruction parsing, they are the same
> > > > "MOVE" with two operands.  I'm not aware of anything in perf with
> > > > the operands of these instructions.  So I guess it'd be fine to add
> > > > these instructions even if they have different underlying behaviors.
> > >
> > > I'm pretty sure that 'rep movs[bwlq]' (aka while (cx--) *di++ = *si++)
> > > is likely to be missing the memory argument parameters.
> > > There is also 'fun and games' with one variant - iirc 'rep movsd'
> > > what has been used for 64bit, but got hijacked by one of the SIMD sets.
> >
> > It seems perf annotate don't process the rep prefix yet.
> > So I think there should be no functional change now.
>
> Reading the code, I also think it should be okay. Doing:
> ```
> $ objdump -d /usr/lib/x86_64-linux-gnu/libc.so.6 |grep rep
>    2650a:       f3 ab                   rep stos %eax,%es:(%rdi)
>    33b76:       f3 48 a5                rep movsq %ds:(%rsi),%es:(%rdi)
> ...
> ```
> The mov parsing logic doesn't appear to care about src and dest, and
> the formatting above matches other mov cases.
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!

Namhyung
