Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03736784629
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjHVPtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjHVPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D57CDD;
        Tue, 22 Aug 2023 08:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA3E65B4C;
        Tue, 22 Aug 2023 15:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44B9C43391;
        Tue, 22 Aug 2023 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692719314;
        bh=mOG/+66KxTcfBojWPpyVD5pQrjNxBpzS+okyAnYvOhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RMwtPBi+aNn7cp8w/aGFDfqG6NU1afCWq9NeuhxyvuL0YnJ5qmP9hvg3nqpkrwlfv
         MLiKP6+VyTvaE5oUOgm7/6RbIkHs8b8zsIFTwQAkL2yjz/cjp0nyaodlsMjyLd3jTL
         kHnfDBcuRNt/OZF7vgfk8Sv73DOFiOAy+0NyUkSBE1QLgWWsOIbHIObsp94D2TKUXl
         wa+hgUYFb/x4VA/gRNf2/nwNjL+mtfgG6Q9elltn0uqYlsEfS17xt6s41qa9M7MgP5
         lB206F8y9HzRKmAjTxR9glqs7UhAyhx4JhON/6uVBTp2CqwUK4XS14Dq0ef3AS98m9
         VniOQ7+nXhhDQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52a23227567so118405a12.0;
        Tue, 22 Aug 2023 08:48:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw09OTEo+Xk87oAv8QKtueujmMeZg+1ThI8eKzVtRNaxeYJKRWX
        /aQ0RagZZs9uqWeF1hMbpYUVP70hgNjejWzKW4k=
X-Google-Smtp-Source: AGHT+IEb+fyp8wsZhGGi7e2oaZHQNn7ZYOvoNPReQ0KhOJmxYCFwwSXdD2Cd0VugXnk4oA+UyV6UTG/8PUsGA0uMxCk=
X-Received: by 2002:a17:906:32d2:b0:99d:e8ac:e4f3 with SMTP id
 k18-20020a17090632d200b0099de8ace4f3mr7285034ejk.64.1692719312945; Tue, 22
 Aug 2023 08:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230822040248.329442-1-chenhuacai@loongson.cn> <20230822153416.GA72567@google.com>
In-Reply-To: <20230822153416.GA72567@google.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 22 Aug 2023 23:48:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H75vwt5RPeE2uh1eK=0osepStq+j88BM9iEspSC1CvZTg@mail.gmail.com>
Message-ID: <CAAhV-H75vwt5RPeE2uh1eK=0osepStq+j88BM9iEspSC1CvZTg@mail.gmail.com>
Subject: Re: [PATCH V3] rcu: Update jiffies locally in rcu_cpu_stall_reset()
To:     Joel Fernandes <joel@joelfernandes.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Joel,

On Tue, Aug 22, 2023 at 11:34=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> On Tue, Aug 22, 2023 at 12:02:48PM +0800, Huacai Chen wrote:
> > The KGDB initial breakpoint gets an rcu stall warning after commit
> > a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection in
> > rcu_cpu_stall_reset()").
> >
> > [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
> [...]
> >
> > [1] https://lore.kernel.org/rcu/20230814020045.51950-1-chenhuacai@loong=
son.cn/T/#t
> >
> > Cc: stable@vger.kernel.org
> > Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detectio=
n in rcu_cpu_stall_reset()")
> > Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V2: Use NMI safe functions.
> > V3: Add comments to explain why.
> >
> >  kernel/rcu/tree_stall.h | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index b10b8349bb2a..e4e53113d062 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -150,11 +150,26 @@ static void panic_on_rcu_stall(void)
> >   * rcu_cpu_stall_reset - restart stall-warning timeout for current gra=
ce period
> >   *
> >   * The caller must disable hard irqs.
> > + *
> > + * The jiffies updating may be delayed for a very long time due to tic=
kless and
> > + * irq disabled, especially in the KGDB case, so we need to add the de=
layed time
> > + * (delta) to rcu_state.jiffies_stall.
> > + *
> > + * This function may be called in NMI context, so we cannot use ktime_=
get_ns()
> > + * and ktime_get_coarse_ns(). Instead, we use their inaccurate but saf=
e friends
> > + * ktime_get_mono_fast_ns() and ktime_get_seconds() which will cause r=
cu_state.
> > + * jiffies_stall to be a little large than expected (harmless and safe=
r).
> >   */
> >  void rcu_cpu_stall_reset(void)
> >  {
> > +     u64 curr, last, delta;
> > +
> > +     curr =3D ktime_get_mono_fast_ns();
> > +     last =3D ktime_get_seconds() * NSEC_PER_SEC;
> > +     delta =3D nsecs_to_jiffies(curr - last);
> > +
> >       WRITE_ONCE(rcu_state.jiffies_stall,
> > -                jiffies + rcu_jiffies_till_stall_check());
> > +                jiffies + delta + rcu_jiffies_till_stall_check());
> >  }
>
> I prefer the following diff on top of your patch to take advantage of UBS=
AN
> detecting overflows.
>
> If you take my diff, feel free to add:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---8<-----------------------
>
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 5e9e4779bdf1..3398cf2d19c5 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -162,14 +162,15 @@ static void panic_on_rcu_stall(void)
>   */
>  void rcu_cpu_stall_reset(void)
>  {
> -       u64 curr, last, delta;
> +       ktime_t last, delta_ns;
> +       u64 delta_jiff;
>
> -       curr =3D ktime_get_mono_fast_ns();
>         last =3D ktime_get_seconds() * NSEC_PER_SEC;
> -       delta =3D nsecs_to_jiffies(curr - last);
> +       delta_ns =3D ktime_sub(ktime_get_mono_fast_ns(), last);
Though ktime_t is the same as s64/u64 now, but I think we'd better to
not mix them. Then, ktime_get() and ktime_get_coarse() return ktime_t;
ktime_get_ns(), ktime_get_coarse_ns() and ktime_get_mono_fast_ns()
return s64/u64 (means nanoseconds); ktime_get_seconds() returns
seconds but ktime_get_seconds() * NSEC_PER_SEC is also nanoseconds.
So, the type definition in your diff is not suitable,
ktime_sub(ktime_get_mono_fast_ns(), last) is not suitable too.

Huacai

> +       delta_jiff =3D nsecs_to_jiffies(delta_ns);
>
>         WRITE_ONCE(rcu_state.jiffies_stall,
> -                  jiffies + delta + rcu_jiffies_till_stall_check());
> +                  jiffies + delta_jiff + rcu_jiffies_till_stall_check())=
;
>  }
>
>  ////////////////////////////////////////////////////////////////////////=
//////
