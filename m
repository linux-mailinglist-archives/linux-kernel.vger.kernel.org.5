Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62957786592
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbjHXCv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjHXCu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC841198;
        Wed, 23 Aug 2023 19:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB25614AC;
        Thu, 24 Aug 2023 02:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC6CC433CD;
        Thu, 24 Aug 2023 02:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692845455;
        bh=FBVROIY3T0LPqE0Yehq9z3S9IR6oyeROYOJKahC5BwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GrZ+jz76BK/FKydLtTKBa/2pRoj8lrN0ZhE8cm0OLfSflLsnE+EyK/3nChEmd3PNY
         mIFXusZKQXkOZ3b9yO3DNYsKxIJ+b7uHMlPYxCjqArfH4Dc0ZftVm7viWVsU6DqlCR
         4QivCfu8ifC+PdQSiVCJm/lstus+XGNbqniQ/acrEs0wLuiqpMq1OOS1T6Ybv0j4p/
         Gs5uX/EVmpSa7IcJaw/f1bSQrG1f6BGl2NB4XVD4Y696IHhSOg7bfEbEDs0kQ+ZiPV
         uxRsEKMi6wdwvA8Oj3KB7jIogLSH89uCGQDKJwtT/45xhfKD5dl9VnfZGaYwANTq6V
         oeUfD4BnQW9vQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-52557cc5e7bso7963855a12.0;
        Wed, 23 Aug 2023 19:50:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx6s6pj7ZsROxkiiHpSOyOfwvX50715Dsxd+jKbBgacituLxBSo
        aG5fa+qPn3/4RTLpgqeTLuV+WVzCQP2XNbNFkZo=
X-Google-Smtp-Source: AGHT+IHuAT/HHaO7PbS/Lnv8anDjI1svcaYN3BAi+vFAImYXE2KPZWi2P92E6Z3aZUUIZ3I+NjCawhawUb4xAgzbLeI=
X-Received: by 2002:aa7:d058:0:b0:523:d1ab:b2ed with SMTP id
 n24-20020aa7d058000000b00523d1abb2edmr11344547edo.29.1692845453993; Wed, 23
 Aug 2023 19:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org> <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx> <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
In-Reply-To: <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 24 Aug 2023 10:50:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
Message-ID: <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
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

Hi, Paul,

On Thu, Aug 24, 2023 at 6:41=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> > On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > > On Thu, Aug 17, 2023 at 3:27=E2=80=AFAM Joel Fernandes <joel@joelfern=
andes.org> wrote:
> > >> > If  do_update_jiffies_64() cannot be used in NMI context,
> > >>
> > >> Can you not make the jiffies update conditional on whether it is
> > >> called within NMI context?
> >
> > Which solves what? If KGDB has a breakpoint in the jiffies lock held
> > region then you still dead lock.
> >
> > >> I dislike that..
> > > Is this acceptable?
> > >
> > > void rcu_cpu_stall_reset(void)
> > > {
> > >         unsigned long delta;
> > >
> > >         delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_=
ns());
> > >
> > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > > }
> > >
> > > This can update jiffies_stall without updating jiffies (but has the
> > > same effect).
> >
> > Now you traded the potential dead lock on jiffies lock for a potential
> > live lock vs. tk_core.seq. Not really an improvement, right?
> >
> > The only way you can do the above is something like the incomplete and
> > uncompiled below. NMI safe and therefore livelock proof time interfaces
> > exist for a reason.
>
> Just for completeness, another approach, with its own advantages
> and disadvantage, is to add something like ULONG_MAX/4 to
> rcu_state.jiffies_stall, but also set a counter indicating that this
> has been done.  Then RCU's force-quiescent processing could decrement
> that counter (if non-zero) and reset rcu_state.jiffies_stall when it
> does reach zero.
>
> Setting the counter to three should cover most cases, but "live by the
> heuristic, die by the heuristic".  ;-)
>
> It would be good to have some indication when gdb exited, but things
> like the gdb "next" command can make that "interesting" when applied to
> a long-running function.
The original code is adding ULONG_MAX/2, so adding ULONG_MAX/4 may
make no much difference? The simplest way is adding 300*HZ, but Joel
dislikes that.

Huacai

>
>                                                         Thanx, Paul
>
> > Thanks,
> >
> >         tglx
> > ---
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
> >   */
> >  static ktime_t last_jiffies_update;
> >
> > +unsigned long tick_estimate_stale_jiffies(void)
> > +{
> > +     ktime_t delta =3D ktime_get_mono_fast_ns() - READ_ONCE(last_jiffi=
es_update);
> > +
> > +     return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> > +}
> > +
> >  /*
> >   * Must be called with interrupts disabled !
> >   */
> >
> >
