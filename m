Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA12C78466A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbjHVP6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbjHVP6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:58:03 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2716C185
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:58:01 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bb734a9081so64913851fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692719879; x=1693324679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtMS2qZ053vosx7bv0u9n/UHZ6ydIsAbk9FsHZhbXiI=;
        b=D5uE5WbXrVn1LX9P9N5AjWi/+kHTV7f0Imkhlmh/RaaUVfGbIxYeyO3/QuQQkm1KX/
         a1HXJH1j6DJC1ArZul6QROQgoxCTdNXLPvrVrrgyIfPWTxk81CoHmYFpqrok+6hXW8lH
         0+nYkc42A2v1v4xEdZU/4M3/FF9gSlNXaRc4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692719879; x=1693324679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtMS2qZ053vosx7bv0u9n/UHZ6ydIsAbk9FsHZhbXiI=;
        b=PRUjSaooMcTic4Vb1vTpZnQApgI52lE7FjQgZG1iqDyeoAtfoi+RpHK6/b64y3+Q54
         NWMd1tvBU3Ligj/VRsHBF+t1qXQcKYLaK7/xliyVhJncbaNGik6431iXG5Hr9CnKxrT2
         ow+FQYjy0CfJ6+FOaV2hGRUuHRi7fsRJaXw2MPX9SCD/zZ/cJF4xe8acOy4vrj6HlY0h
         CHtNSyND3EBzHBHilIRdloAL41VoVZhSZctOems/lwQIjcZrsjJNZG/oyoCRbhkxH6FN
         yQwC1X6yspAODbkaeNEJzOBE9Z7PFfSZn2s62JRRixdJjagnC2EV5gLw48uKjziCSp3s
         bs1Q==
X-Gm-Message-State: AOJu0YyPtdOeok+S/hqVhhWAkjqdMvQc2nE8SjqFOWAJsWbypb6qHlEP
        g8G9bOEzE9UPlT/Ywr/QVSESBEBwbGkOZZO1/G8m6Q==
X-Google-Smtp-Source: AGHT+IFn//2QSGqnl/QhFfJfnyVd3D/1RDdkwf8iN9sT6CYdW0X0AaEd9fuWzktm5OHJR/TPXsz6Lw9QhlcWLMKIrRI=
X-Received: by 2002:a2e:8e75:0:b0:2bc:d3b1:d6c1 with SMTP id
 t21-20020a2e8e75000000b002bcd3b1d6c1mr644017ljk.9.1692719879084; Tue, 22 Aug
 2023 08:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230822040248.329442-1-chenhuacai@loongson.cn>
 <20230822153416.GA72567@google.com> <CAAhV-H75vwt5RPeE2uh1eK=0osepStq+j88BM9iEspSC1CvZTg@mail.gmail.com>
In-Reply-To: <CAAhV-H75vwt5RPeE2uh1eK=0osepStq+j88BM9iEspSC1CvZTg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 22 Aug 2023 11:57:48 -0400
Message-ID: <CAEXW_YS8YQkTqJQ_DJzPLGcExOUU18esYXWPb9j81gS02uRLgw@mail.gmail.com>
Subject: Re: [PATCH V3] rcu: Update jiffies locally in rcu_cpu_stall_reset()
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:48=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Joel,
>
> On Tue, Aug 22, 2023 at 11:34=E2=80=AFPM Joel Fernandes <joel@joelfernand=
es.org> wrote:
> >
> > On Tue, Aug 22, 2023 at 12:02:48PM +0800, Huacai Chen wrote:
> > > The KGDB initial breakpoint gets an rcu stall warning after commit
> > > a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection in
> > > rcu_cpu_stall_reset()").
> > >
> > > [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [...]
> > >
> > > [1] https://lore.kernel.org/rcu/20230814020045.51950-1-chenhuacai@loo=
ngson.cn/T/#t
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detect=
ion in rcu_cpu_stall_reset()")
> > > Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > > V2: Use NMI safe functions.
> > > V3: Add comments to explain why.
> > >
> > >  kernel/rcu/tree_stall.h | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > index b10b8349bb2a..e4e53113d062 100644
> > > --- a/kernel/rcu/tree_stall.h
> > > +++ b/kernel/rcu/tree_stall.h
> > > @@ -150,11 +150,26 @@ static void panic_on_rcu_stall(void)
> > >   * rcu_cpu_stall_reset - restart stall-warning timeout for current g=
race period
> > >   *
> > >   * The caller must disable hard irqs.
> > > + *
> > > + * The jiffies updating may be delayed for a very long time due to t=
ickless and
> > > + * irq disabled, especially in the KGDB case, so we need to add the =
delayed time
> > > + * (delta) to rcu_state.jiffies_stall.
> > > + *
> > > + * This function may be called in NMI context, so we cannot use ktim=
e_get_ns()
> > > + * and ktime_get_coarse_ns(). Instead, we use their inaccurate but s=
afe friends
> > > + * ktime_get_mono_fast_ns() and ktime_get_seconds() which will cause=
 rcu_state.
> > > + * jiffies_stall to be a little large than expected (harmless and sa=
fer).
> > >   */
> > >  void rcu_cpu_stall_reset(void)
> > >  {
> > > +     u64 curr, last, delta;
> > > +
> > > +     curr =3D ktime_get_mono_fast_ns();
> > > +     last =3D ktime_get_seconds() * NSEC_PER_SEC;
> > > +     delta =3D nsecs_to_jiffies(curr - last);
> > > +
> > >       WRITE_ONCE(rcu_state.jiffies_stall,
> > > -                jiffies + rcu_jiffies_till_stall_check());
> > > +                jiffies + delta + rcu_jiffies_till_stall_check());
> > >  }
> >
> > I prefer the following diff on top of your patch to take advantage of U=
BSAN
> > detecting overflows.
> >
> > If you take my diff, feel free to add:
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > ---8<-----------------------
> >
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 5e9e4779bdf1..3398cf2d19c5 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -162,14 +162,15 @@ static void panic_on_rcu_stall(void)
> >   */
> >  void rcu_cpu_stall_reset(void)
> >  {
> > -       u64 curr, last, delta;
> > +       ktime_t last, delta_ns;
> > +       u64 delta_jiff;
> >
> > -       curr =3D ktime_get_mono_fast_ns();
> >         last =3D ktime_get_seconds() * NSEC_PER_SEC;
> > -       delta =3D nsecs_to_jiffies(curr - last);
> > +       delta_ns =3D ktime_sub(ktime_get_mono_fast_ns(), last);
> Though ktime_t is the same as s64/u64 now,

No, you are incorrect.  ktime_t is a signed int not u64. I prefer to
use types designed for a specific purpose where possible. It makes the
code safer.

> but I think we'd better to
> not mix them. Then, ktime_get() and ktime_get_coarse() return ktime_t;
> ktime_get_ns(), ktime_get_coarse_ns() and ktime_get_mono_fast_ns()
> return s64/u64 (means nanoseconds); ktime_get_seconds() returns
> seconds but ktime_get_seconds() * NSEC_PER_SEC is also nanoseconds.
> So, the type definition in your diff is not suitable,
> ktime_sub(ktime_get_mono_fast_ns(), last) is not suitable too.
>

Is there a technical reason for your concern? ktime_get_mono_fast_ns()
is assigned to ktime_t in other places. I am not seeing what the
problem is.

Thanks.
