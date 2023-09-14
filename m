Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE0079F639
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjINBRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjINBRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:17:39 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261DA1724
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:17:35 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso6399601fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694654253; x=1695259053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkgb9Op+pDgaqFX4xOb4y+fL23Pd/dAljOZPnrSZa0k=;
        b=lbWMY4Q+oMdBUhLOIGaTPKJ2p94d4IWWIyUHDYwm1FD8Nt07xNJ1XzhGVqMT1mReLe
         tH18TGsWae7UwoI2PEx8fmXqC5auLadHZW6sAxGXMGR7l2a+qOBGBtOn/Fpu4sllsXVT
         +RaCuoCltl5BSclBo6FMlTON3+t6OulAALyuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694654253; x=1695259053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkgb9Op+pDgaqFX4xOb4y+fL23Pd/dAljOZPnrSZa0k=;
        b=MeZJ9nPSAOqeaodjq45TIm6YOqLSfOlxRi0i9uuL+MmVSQqG0JQmEdoiuWwAFXfu7C
         eawIhZucmhMh1Y2bKoJsKa8LdXNHRjSJ3lhw/bfbzJET8rQ0XUUAbxnffqAEbmikokp/
         4OSXRLNESxmNjCw2gnsmfNN1g5okDDS3U0DzC4Q9MQHw2zlhz+mMEwAdEjrOqs6zoG4O
         i1ZDaq07Ng8HtpK/hUECM1h1sLoih1X2ds6ks4XuV+SlHtAWbdw3Yi1MgnWybJ1uweiZ
         EvK2rlSv4Iz2EyCUMMXDgkmWOTIA3g6eqLW5R8gX0jHBHFszJIuqMbg54oK/XLpGlm+p
         gI9Q==
X-Gm-Message-State: AOJu0Yym9SD7fcxs9OfT1k7/uRDzuMWIyuFE+iqFclx8/0PcrXAisNrB
        lZTtbzDKeU9Cl7B3/ZMAmpnE9rzVnLBTn1h1g/izyw==
X-Google-Smtp-Source: AGHT+IG5KG3oP80MoDcl4c6cGhYkzZ5wDMAR2Z9ZGvyq+TpnQE6GcgwfweAI//2Le5uJ112o56lSGQAj7p5eHv4QXU0=
X-Received: by 2002:a2e:3e07:0:b0:2bc:dcdb:b5dc with SMTP id
 l7-20020a2e3e07000000b002bcdcdbb5dcmr3569198lja.39.1694654252454; Wed, 13 Sep
 2023 18:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230912104406.312185-1-frederic@kernel.org> <20230912104406.312185-4-frederic@kernel.org>
In-Reply-To: <20230912104406.312185-4-frederic@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 13 Sep 2023 21:17:21 -0400
Message-ID: <CAEXW_YTwzK9jkUdMUPY0t++yYvwSHx1EZiPX6NiSt7hPhHZbpA@mail.gmail.com>
Subject: Re: [PATCH 3/5] tick/nohz: Don't shutdown the lowres tick from itself
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, vineethrp@gmail.com,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 6:44=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> In lowres dynticks mode, just like in highres dynticks mode, when there
> is no tick to program in the future, the tick eventually gets
> deactivated either:
>
> * From the idle loop if in idle mode.
> * From the IRQ exit if in full dynticks mode.
>
> Therefore there is no need to deactivate it from the tick itself. This
> just just brings more overhead in the idle tick path for no reason.
>
> Fixes: 62c1256d5447 ("timers/nohz: Switch to ONESHOT_STOPPED in the low-r=
es handler when the tick is stopped")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

If on some weird hardware, say  ts->next_tick =3D KTIME_MAX but a
spurious timer interrupt went off and tick_nohz_handler() did get
called (yeah weird hypothetical situation), then in
tick_nohz_stop_tick() we might early return from:

/* Skip reprogram of event if its not changed */
if (ts->tick_stopped && (expires =3D=3D ts->next_tick))

without no "eventual" reprogramming.

Maybe we should also reprogram with KTIME_MAX in such a situation?
Then we can get rid of it from tick_nohz_handler() for the common case
as you are doing.

So for weird hardware, with this patch we are not doing an extra
tick_program_event(KTIME_MAX, 1); like Nick was doing. That makes me a
tad bit nervous.

Otherwise your patch looks correct to me (for hardware that tends not
to misbehave).

thanks,

 - Joel


> ---
>  kernel/time/tick-sched.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 95a8d1d118a2..8e9a9dcf60d5 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1403,18 +1403,16 @@ static void tick_nohz_lowres_handler(struct clock=
_event_device *dev)
>         tick_sched_do_timer(ts, now);
>         tick_sched_handle(ts, regs);
>
> -       if (unlikely(ts->tick_stopped)) {
> -               /*
> -                * The clockevent device is not reprogrammed, so change t=
he
> -                * clock event device to ONESHOT_STOPPED to avoid spuriou=
s
> -                * interrupts on devices which might not be truly one sho=
t.
> -                */
> -               tick_program_event(KTIME_MAX, 1);
> -               return;
> +       /*
> +        * In dynticks mode, tick reprogram is deferred:
> +        * - to the idle task if in dynticks-idle
> +        * - to IRQ exit if in full-dynticks.
> +        */
> +       if (likely(!ts->tick_stopped)) {
> +               hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> +               tick_program_event(hrtimer_get_expires(&ts->sched_timer),=
 1);
>         }
>
> -       hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> -       tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
>  }
>
>  static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
> @@ -1519,7 +1517,11 @@ static enum hrtimer_restart tick_nohz_highres_hand=
ler(struct hrtimer *timer)
>         else
>                 ts->next_tick =3D 0;
>
> -       /* No need to reprogram if we are in idle or full dynticks mode *=
/
> +       /*
> +        * In dynticks mode, tick reprogram is deferred:
> +        * - to the idle task if in dynticks-idle
> +        * - to IRQ exit if in full-dynticks.
> +        */
>         if (unlikely(ts->tick_stopped))
>                 return HRTIMER_NORESTART;
>
> --
> 2.34.1
>
