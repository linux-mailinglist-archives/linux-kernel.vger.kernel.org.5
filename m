Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF497545E6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjGOBDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjGOBC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:02:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27713A9C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 18:02:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so38734181fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 18:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689382975; x=1691974975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaQZCie538sj4krllk6/qjbG50accgvQVGSms7oqFVs=;
        b=SqqRhesNIM9U2HFUGXehPvzNYVQyZEYtbRbVRh1ZXiYBsNT4lrJZgwupXE+NNbs23N
         zVMKsDNT1QxOwO0gh585ZONx9DbQgh1s7TPH/U3KtA530+XDxC45FA76WyifbabVZmwy
         5jqbm0tuFy3moCN33xVNMXdprmC8RzEDsKPa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689382975; x=1691974975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaQZCie538sj4krllk6/qjbG50accgvQVGSms7oqFVs=;
        b=a2gJYbtXF/8MzGtwRHBZBlCEw2v4+xW6eFQNl3vGuvO/cTlKBb2Rpc4aPpfIpOiz6U
         eENiR0ynxUjgkwFRWFnjrHu8I9RnPzVU7LcnzZq70l32FJ2x6psH2zIpyLmh1iXkNspH
         b98aLIjlAD2YVRo5HApoLa2DRiqoymwfGMVXfLSm985gFxNf5Yha7PdHFTqzDKLpM/cF
         F+a8itFksz3u1nHXvmoUc6ylkxmsy/Vv+gBIFjg7vnLtdI23CjJN11vQuOHwSjTkz+yj
         0ssC/pCv+petf7hiJpuAqgz3XCN7gbJcc11g66zCNxLbxIG8/9eY6F4oYUyGKWOpzxQd
         hzeQ==
X-Gm-Message-State: ABy/qLYR/GRhyW9NP8VKWxHBTnrjr9PSJY2FFY0VorFL+4XUTuybuDXW
        Pof6veg1gbUKA47QsIsimIWP4+SOTdgzWie5g5Y45A==
X-Google-Smtp-Source: APBJJlEpaNw20C2rJJr5qWIgD6GIDGTuQjIjmfDbVmotFEyJqN9C2k3xXcaPHMkPie5yYDJYotx16CWEy3QxglDRzfo=
X-Received: by 2002:a2e:900c:0:b0:2b6:e7b7:a163 with SMTP id
 h12-20020a2e900c000000b002b6e7b7a163mr4858296ljg.27.1689382974779; Fri, 14
 Jul 2023 18:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230714120852.23573-1-frederic@kernel.org> <20230714120852.23573-4-frederic@kernel.org>
 <9347e3d4-e774-f75f-22c4-6c2dba294423@joelfernandes.org> <ZLHh71KIIioR85aa@lothringen>
In-Reply-To: <ZLHh71KIIioR85aa@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 14 Jul 2023 21:02:43 -0400
Message-ID: <CAEXW_YRTtvq0_YZiN=V9DZi2QxrC4hQFeUC9=JrgAKkg8KAnmw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tick/nohz: Don't shutdown the lowres tick from itself
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 8:01=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> On Fri, Jul 14, 2023 at 02:44:49PM -0400, Joel Fernandes wrote:
> > On 7/14/23 08:08, Frederic Weisbecker wrote:
> > One slight concern here though, where in the idle loop is the removed
> > statement "tick_program_event(KTIME_MAX, 1);" happening if the tick was
> > already stopped before? If it is happening in tick_nohz_stop_tick(), do=
n't
> > we early return from there and avoid doing that
> > "tick_program_event(KTIME_MAX, 1);" altogether, if the tick was already
> > stopped and the next event has not changed?
> >
> >         /* Skip reprogram of event if its not changed */
> >         if (ts->tick_stopped && (expires =3D=3D ts->next_tick)) {
> >                 /* Sanity check: make sure clockevent is actually progr=
ammed */
> >                 if (tick =3D=3D KTIME_MAX || ts->next_tick =3D=3D  [...=
]
> >                         return;
> >               [...]
> >       }
>
> Sure, if tick_program_event(KTIME_MAX, 1) was already called in the
> previous idle loop iteration, then there is no need to call that again.
>
> Or am I missing something else?

Just take it with a grain of salt but I think you need to still call
tick_program_event(KTIME_MAX, 1) here for the case where the tick was
previously stopped, and then when the next tick fires (say after a
long time T), but that tick is a one-off and does not result in
restarting the tick -- then there is no one to call
"tick_program_event(KTIME_MAX, 1)".

I think that's the concern Nick was addressing in [1] so that it
resets the tick device correctly?

[1] https://lore.kernel.org/lkml/165089105607.4207.3022534114716811208.tip-=
bot2@tip-bot2/

> >
> > Also just a nit, here you can remove indent by doing:
> >
> > if (unlikely(ts->tick_stopped))
> >     return;
> > hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> > tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
> >
> > Which is pretty much the original code except for the tick_program_even=
t().
>
> Either I remove an indent or I remove a statement. I guess it's a matter =
of
> personal taste. I don't mind either way :-)

Ah true, in defense of the "less indent" way, the original code was
also using that style. ;-) But I am also Ok with either way. :-)

thanks,

 - Joel
