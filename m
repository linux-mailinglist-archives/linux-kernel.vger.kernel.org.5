Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97C7784684
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbjHVQFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbjHVQFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857BFCDA;
        Tue, 22 Aug 2023 09:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21968624EB;
        Tue, 22 Aug 2023 16:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BEFC433D9;
        Tue, 22 Aug 2023 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692720329;
        bh=tWhfy2EssZhtWzUA5VH3oPmSbd0MeOMSxZ0xIoZ/uKU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jhwZTOuAvipIIqxz1Dvcg7dWvxwD2wDNfwuh2M4nQVwIk0O8eQEtCrVejRxzMaWCK
         8COPm4hhFIKUHQHaxqfC2DAx6q2imHZE/JbzPiHAq0kqgh4YIjqc8h6YIsT5OdpLiN
         4wkyp+aQ2xqSalEdHsejN6IWnIKdUtY89lprCPFv89MPEqpllgc73CfCFNRjHoG9qM
         O1TnmOTgo4jkbH40hn/5kpnQtuDXY7bk6gPhfFPZa3Zx6n5TNWZaxm4t/mGk5wGdSi
         R3A5onagobFj89zM8NdK/tQk2pwx444pIUWEhwtxMps8caLCFt20xPA+wQCXqtOkOi
         Lb9v2Rfj1gYDQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99df11828c6so1193866966b.1;
        Tue, 22 Aug 2023 09:05:29 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw6irgeu5gYEl8s8B5DcvMQaNx5N4/QT25H8MPBG8eVZa3DlZGp
        K3xkGGfOl6HgKeJdKq5zIZEVHluNrfdANWsdKkA=
X-Google-Smtp-Source: AGHT+IHcKeKtTZ+DuvQVitnpGF0Biz896SO1ObjTjaIEuf6oWTVVHiWuAWb9/IPTJbtxHdBNcZREuZF4DLKKDH4sMpk=
X-Received: by 2002:a17:907:7804:b0:9a1:914e:491a with SMTP id
 la4-20020a170907780400b009a1914e491amr8243342ejc.3.1692720327658; Tue, 22 Aug
 2023 09:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230822040248.329442-1-chenhuacai@loongson.cn>
 <20230822153416.GA72567@google.com> <CAAhV-H75vwt5RPeE2uh1eK=0osepStq+j88BM9iEspSC1CvZTg@mail.gmail.com>
 <CAEXW_YS8YQkTqJQ_DJzPLGcExOUU18esYXWPb9j81gS02uRLgw@mail.gmail.com>
In-Reply-To: <CAEXW_YS8YQkTqJQ_DJzPLGcExOUU18esYXWPb9j81gS02uRLgw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 23 Aug 2023 00:05:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5mePbbF8Y3t-JfV+PNP8BEcjKtX4UokzL_vDzyw+2BRg@mail.gmail.com>
Message-ID: <CAAhV-H5mePbbF8Y3t-JfV+PNP8BEcjKtX4UokzL_vDzyw+2BRg@mail.gmail.com>
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

On Tue, Aug 22, 2023 at 11:58=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> On Tue, Aug 22, 2023 at 11:48=E2=80=AFAM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> >
> > Hi, Joel,
> >
> > On Tue, Aug 22, 2023 at 11:34=E2=80=AFPM Joel Fernandes <joel@joelferna=
ndes.org> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 12:02:48PM +0800, Huacai Chen wrote:
> > > > The KGDB initial breakpoint gets an rcu stall warning after commit
> > > > a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection i=
n
> > > > rcu_cpu_stall_reset()").
> > > >
> > > > [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
> > > [...]
> > > >
> > > > [1] https://lore.kernel.org/rcu/20230814020045.51950-1-chenhuacai@l=
oongson.cn/T/#t
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall dete=
ction in rcu_cpu_stall_reset()")
> > > > Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > > V2: Use NMI safe functions.
> > > > V3: Add comments to explain why.
> > > >
> > > >  kernel/rcu/tree_stall.h | 17 ++++++++++++++++-
> > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > > index b10b8349bb2a..e4e53113d062 100644
> > > > --- a/kernel/rcu/tree_stall.h
> > > > +++ b/kernel/rcu/tree_stall.h
> > > > @@ -150,11 +150,26 @@ static void panic_on_rcu_stall(void)
> > > >   * rcu_cpu_stall_reset - restart stall-warning timeout for current=
 grace period
> > > >   *
> > > >   * The caller must disable hard irqs.
> > > > + *
> > > > + * The jiffies updating may be delayed for a very long time due to=
 tickless and
> > > > + * irq disabled, especially in the KGDB case, so we need to add th=
e delayed time
> > > > + * (delta) to rcu_state.jiffies_stall.
> > > > + *
> > > > + * This function may be called in NMI context, so we cannot use kt=
ime_get_ns()
> > > > + * and ktime_get_coarse_ns(). Instead, we use their inaccurate but=
 safe friends
> > > > + * ktime_get_mono_fast_ns() and ktime_get_seconds() which will cau=
se rcu_state.
> > > > + * jiffies_stall to be a little large than expected (harmless and =
safer).
> > > >   */
> > > >  void rcu_cpu_stall_reset(void)
> > > >  {
> > > > +     u64 curr, last, delta;
> > > > +
> > > > +     curr =3D ktime_get_mono_fast_ns();
> > > > +     last =3D ktime_get_seconds() * NSEC_PER_SEC;
> > > > +     delta =3D nsecs_to_jiffies(curr - last);
> > > > +
> > > >       WRITE_ONCE(rcu_state.jiffies_stall,
> > > > -                jiffies + rcu_jiffies_till_stall_check());
> > > > +                jiffies + delta + rcu_jiffies_till_stall_check());
> > > >  }
> > >
> > > I prefer the following diff on top of your patch to take advantage of=
 UBSAN
> > > detecting overflows.
> > >
> > > If you take my diff, feel free to add:
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > ---8<-----------------------
> > >
> > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > index 5e9e4779bdf1..3398cf2d19c5 100644
> > > --- a/kernel/rcu/tree_stall.h
> > > +++ b/kernel/rcu/tree_stall.h
> > > @@ -162,14 +162,15 @@ static void panic_on_rcu_stall(void)
> > >   */
> > >  void rcu_cpu_stall_reset(void)
> > >  {
> > > -       u64 curr, last, delta;
> > > +       ktime_t last, delta_ns;
> > > +       u64 delta_jiff;
> > >
> > > -       curr =3D ktime_get_mono_fast_ns();
> > >         last =3D ktime_get_seconds() * NSEC_PER_SEC;
> > > -       delta =3D nsecs_to_jiffies(curr - last);
> > > +       delta_ns =3D ktime_sub(ktime_get_mono_fast_ns(), last);
> > Though ktime_t is the same as s64/u64 now,
>
> No, you are incorrect.  ktime_t is a signed int not u64. I prefer to
> use types designed for a specific purpose where possible. It makes the
> code safer.
Yes ktime_t is s64 now, I said s64/u64 because there is some existing
code to mix them (of course not very good).

>
> > but I think we'd better to
> > not mix them. Then, ktime_get() and ktime_get_coarse() return ktime_t;
> > ktime_get_ns(), ktime_get_coarse_ns() and ktime_get_mono_fast_ns()
> > return s64/u64 (means nanoseconds); ktime_get_seconds() returns
> > seconds but ktime_get_seconds() * NSEC_PER_SEC is also nanoseconds.
> > So, the type definition in your diff is not suitable,
> > ktime_sub(ktime_get_mono_fast_ns(), last) is not suitable too.
> >
>
> Is there a technical reason for your concern? ktime_get_mono_fast_ns()
> is assigned to ktime_t in other places. I am not seeing what the
> problem is.
My concern is ktime_t may not always be s64 in future, so there are
ktime_to_ns() and some other similar APIs to convert from one to
another.

Huacai
>
> Thanks.
