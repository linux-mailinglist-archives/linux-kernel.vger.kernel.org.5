Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4130F778187
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjHJT1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbjHJT1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:27:30 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FFA270E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:27:27 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4036bd4fff1so711cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691695646; x=1692300446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNnltR97BeMOnmf/YZYMujSXMH2ommF1rsHE9Oftg0w=;
        b=m5swtl2RPkKGhH31c5dbSWWJzoE9Tb+6vSVU6lNJv/hCgc2tL5fjN/8xF3te1zxsz6
         G+u5ltz59IfYdr/d1QWpN5VPjXVfRvNLzYsouwyNpVM2g3p6z0qam9cGkr3sO9ZqBqLG
         2eJoNiqD6fbJfFYNl0pm/vkr4lMaFO+zhB8JnTEZcjfqa2kmsCMgO6xHGK7bHDwjgKGT
         7NPrfmxSxNpf2CwJVFmW1PxppfQBppgY49YNTcjHAaiZbwqMPoIruJIyjdJG1zjF1SPc
         eu3/hMX30UQaBEA6xZ0NDFGVq9AbTafsK0QJYzNAMRUUoq/Sv0H58lE8pE6z4ugBDaAM
         c2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695646; x=1692300446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNnltR97BeMOnmf/YZYMujSXMH2ommF1rsHE9Oftg0w=;
        b=fyGX19A9AqulJFlsVh7amTNlCGLuyF4CsUZ+qqu2C3Avp6eFLjwlzh992gkAnvQ0GA
         Ldq9zVBxNWD9UJSrNNxh7gf39Gc95CQcR+YMmXSHkzoXHpPdKtuKh85/cl6RwmTV9HuL
         tuP+hjtMhNqq4mPunNvBjrdqQ2rHw2J7i/y49AD7gaqc6N2wI+NYIzo2a0lh4Yt69Ky8
         7jjM/t1JJTTYI6BKKtOcBawMboM49vu3uj1CA6khYyMQLoUEy0i+ZAN0ul0OrNX9xqu1
         iuu3TFJIeifNJ3HD3mms64TORNmn0CNuBQ6fLGqOSV0AksLX42nfm+/PcJ0x12fLIKyb
         7LLA==
X-Gm-Message-State: AOJu0Yxfsq/1f54QY9JLUo1/saD230yHO9G/dl1pwAlpGs4GvxvpsqfA
        LBx5wLgX7nO+5rPfZsev57Zz8i7lrRhBesAOhPMXDg==
X-Google-Smtp-Source: AGHT+IGVCtCr21eEdt4tIfAgdEow8iRngkIScUU7nCQAlw9xC6j2AxFQLwF17ebcJCOX84KXLOlsJW8OyMKgkV5yZVk=
X-Received: by 2002:ac8:7f8e:0:b0:40f:dc70:fde2 with SMTP id
 z14-20020ac87f8e000000b0040fdc70fde2mr61719qtj.26.1691695646021; Thu, 10 Aug
 2023 12:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230807111631.3033102-1-john.g.garry@oracle.com> <373e8253-656c-84dc-c05-b578e3725d@os.amperecomputing.com>
In-Reply-To: <373e8253-656c-84dc-c05-b578e3725d@os.amperecomputing.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Aug 2023 12:27:14 -0700
Message-ID: <CAP-5=fVsePTVU2qeeUzVFkWA7Oxj6bgSq+yWzO=t3y283vOgOw@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Raise exception for no definition of a arch
 std event
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     John Garry <john.g.garry@oracle.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 9, 2023 at 10:11=E2=80=AFPM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
>
> Hi John,
>
> On Mon, 7 Aug 2023, John Garry wrote:
> > Recently Ilkka reported that the JSONs for the AmpereOne arm64-based
> > platform included a dud event which referenced a non-existent arch std
> > event [0].
>
> I wish I had found the bug in my patch a long time ago but, in fact, it
> was Dave Kleikamp who initially pointed it out to me and figured out the
> difference between jevents.c and jevents.py when porting the patch to 5.1=
5
> kernel.
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2023-June/844874.ht=
ml
>
> >
> > Previously in the times of jevents.c, we would raise an exception for t=
his.
> >
> > This is still invalid, even though the current code just ignores such a=
n
> > event.
> >
> > Re-introduce code to raise an exception for when no definition exists t=
o
> > help catch as many invalid JSONs as possible.
> >
> > [0] https://lore.kernel.org/linux-perf-users/9e851e2a-26c7-ba78-cb20-be=
4337b2916a@oracle.com/
> >
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
>
> Thanks for the patch! I quickly tested it and it worked as expected. Just
> in case this is needed:
>
> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Cheers, Ilkka
>
> > ---
> > Please do not apply before [0], above.
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index 8cd561aa606a..98cccc3fcbbd 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -347,12 +347,15 @@ class JsonEvent:
> >       if self.desc and not self.desc.endswith('. '):
> >         self.desc +=3D '. '
> >       self.desc =3D (self.desc if self.desc else '') + ('Unit: ' + self=
.pmu + ' ')
> > -    if arch_std and arch_std.lower() in _arch_std_events:
> > -      event =3D _arch_std_events[arch_std.lower()].event
> > -      # Copy from the architecture standard event to self for undefine=
d fields.
> > -      for attr, value in _arch_std_events[arch_std.lower()].__dict__.i=
tems():
> > -        if hasattr(self, attr) and not getattr(self, attr):
> > -          setattr(self, attr, value)
> > +    if arch_std:
> > +      if arch_std.lower() in _arch_std_events:
> > +        event =3D _arch_std_events[arch_std.lower()].event
> > +        # Copy from the architecture standard event to self for undefi=
ned fields.
> > +        for attr, value in _arch_std_events[arch_std.lower()].__dict__=
.items():
> > +          if hasattr(self, attr) and not getattr(self, attr):
> > +            setattr(self, attr, value)
> > +      else:
> > +        raise argparse.ArgumentTypeError('Cannot find arch std event:'=
, arch_std)
> >
> >     self.event =3D real_event(self.name, event)
> >
> > --
> > 2.35.3
> >
> >
