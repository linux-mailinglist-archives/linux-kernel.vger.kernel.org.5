Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C6679F388
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjIMVPA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjIMVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:14:59 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A52D1739;
        Wed, 13 Sep 2023 14:14:55 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-79275d86bc3so10566639f.0;
        Wed, 13 Sep 2023 14:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694639694; x=1695244494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXBax8RnwSuSMRj84NUSnytgzb/GY+/2s76swkIeU5w=;
        b=KaP+7t/nOXenQIqOBNABpCeNsEogpzdtx5f0H2u31mYsiDVeNz2R8IiDmHDKQTKaOj
         5iIqU6Jx+wuYUMGRX67Gt5XHmHY2cyYn7K3tuI+ft6tXCLIhtuZ2touDrLf0itH7SCwX
         uz2FVeQa2boIsvhyUJJKz50V5SNdOFHTyXibrCaRoPkfGMpczAoiv9aLK88rWTCXxhpQ
         wbNaVwdyae1FZLXdHynKvUmJfVAVfnF3eFeQy953XIOypvSvTsTELRm/rrg0LvQwnecZ
         a14SGEIipo6UXE2cl6o6ngCPgPQFBckteJ6zUzIXe70Bg4XCHXLyddrRqzg8iwrD5YOD
         d/sw==
X-Gm-Message-State: AOJu0Yxnh4O8nMXeVpaO7hayod6xIvifMk6otEqPw49+KIvna+lth3H3
        jha2NPNbpDkhMhaBTWalYfWX6VRHGX8SC2Vj2p4=
X-Google-Smtp-Source: AGHT+IFBiR6pU6JCDrnRDjhwd9KIw9vcF2bAXyn44p8sl0RpZrA/AFwIxc+Javnj+Lj6ImqmhP3oq7kAMUgwTNscgf8=
X-Received: by 2002:a6b:6d15:0:b0:795:196c:a074 with SMTP id
 a21-20020a6b6d15000000b00795196ca074mr4507574iod.3.1694639694271; Wed, 13 Sep
 2023 14:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230908052216.566148-1-namhyung@kernel.org> <CAP-5=fUtEvW9h7N=w3vvYBB3vytnTXJsXrHDD6zLA2DzYFOBHQ@mail.gmail.com>
 <CAM9d7cj1rEjGy0QM2tkJhBn=hac-9Jya+ZJ4SNhBmB29u5KVMg@mail.gmail.com> <ad8a8d46151142a883d2d259c884acc0@AcuMS.aculab.com>
In-Reply-To: <ad8a8d46151142a883d2d259c884acc0@AcuMS.aculab.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 13 Sep 2023 14:14:42 -0700
Message-ID: <CAM9d7ciB-Rmsi4eTOU7n=mcEP2-JjDycL6f_8cKnKGKtqVT3UQ@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Add more x86 mov instruction cases
To:     David Laight <David.Laight@aculab.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 1:12 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Namhyung Kim
> > Sent: 09 September 2023 00:56
> >
> > Hi Ian,
> >
> > On Thu, Sep 7, 2023 at 11:24 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Thu, Sep 7, 2023 at 10:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Instructions with sign- and zero- extention like movsbl and movzwq were
> > > > not handled properly.  As it can check different size suffix (-b, -w, -l
> > > > or -q) we can omit that and add the common parts even though some
> > > > combinations are not possible.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/arch/x86/annotate/instructions.c | 9 ++++++---
> > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/perf/arch/x86/annotate/instructions.c
> > b/tools/perf/arch/x86/annotate/instructions.c
> > > > index 5f4ac4fc7fcf..5cdf457f5cbe 100644
> > > > --- a/tools/perf/arch/x86/annotate/instructions.c
> > > > +++ b/tools/perf/arch/x86/annotate/instructions.c
> > > > @@ -74,12 +74,15 @@ static struct ins x86__instructions[] = {
> > > >         { .name = "movdqa",     .ops = &mov_ops,  },
> > > >         { .name = "movdqu",     .ops = &mov_ops,  },
> > > >         { .name = "movsd",      .ops = &mov_ops,  },
> > > > -       { .name = "movslq",     .ops = &mov_ops,  },
> > > >         { .name = "movss",      .ops = &mov_ops,  },
> > > > +       { .name = "movsb",      .ops = &mov_ops,  },
> > > > +       { .name = "movsw",      .ops = &mov_ops,  },
> > > > +       { .name = "movsl",      .ops = &mov_ops,  },
> > >
> > > In Intel's manual some of these names are "Move Data From String to
> > > String" operations, movsb and movsw in particular. These instructions
> > > can be used to make simple memcpy loops. Could it be the past omission
> > > was deliberate due to the different way the addressing works in the
> > > instructions?
> >
> > I don't know but in terms of instruction parsing, they are the same
> > "MOVE" with two operands.  I'm not aware of anything in perf with
> > the operands of these instructions.  So I guess it'd be fine to add
> > these instructions even if they have different underlying behaviors.
>
> I'm pretty sure that 'rep movs[bwlq]' (aka while (cx--) *di++ = *si++)
> is likely to be missing the memory argument parameters.
> There is also 'fun and games' with one variant - iirc 'rep movsd'
> what has been used for 64bit, but got hijacked by one of the SIMD sets.

It seems perf annotate don't process the rep prefix yet.
So I think there should be no functional change now.

Thanks,
Namhyung
