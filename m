Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E68E787504
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbjHXQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242426AbjHXQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:15:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A784519A8;
        Thu, 24 Aug 2023 09:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E0A767334;
        Thu, 24 Aug 2023 16:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CD8C433CA;
        Thu, 24 Aug 2023 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692893723;
        bh=Fg6sjBNuvj9rdfbZjF3J8w70wp+BKLTDx2rtjGBdfkA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jhrL2Dc0nahMPmBZtgGMsliPuHwBZjDFKWBGRyZM83sxyymjiNEpMFTu3An1MAoem
         H+MqERLwrsmb84il0kQWE1UBK3sRO3UIqyUq6RV2OEAl6wiGOXjRvtuawJygjUmrna
         FQDN4huW4KAt+Pz/lmYkhhzwo8J/7/81lhOp5DZpv3LSP5hQECO9J5UN1MXbTv+t1/
         JEPELeDC03o1MHcG62BSJWOvpog9jVg+ILjahMgZ2Ai/QYSR/TC6MsE+Hqk2vLOUAt
         0S79GnzYWovbeSkD9/SPCHP20ijiH6Vp6PkiHCTn140ph8kP2Yuh+GnII/opJwe8FW
         Eam8DQ5/NCoFg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52a23227567so120736a12.0;
        Thu, 24 Aug 2023 09:15:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YwcZMwkNUlehg1RPVP6YZmvFtfNY/8JbsEPl5eUNON8Bc92o8xp
        TL1vmYI+CMuZr2mPPJSTnaR58bL5cpOPKEcu8pQ=
X-Google-Smtp-Source: AGHT+IEDYPlhylAuZtwPCfjjhJrgeCJ8FRSRuxViyUmEpDn1FQwlHvze4Hs0xgsudwwmt/JqtaLDTW5xjSS0wr2CgvA=
X-Received: by 2002:a05:6402:1610:b0:525:469a:fc38 with SMTP id
 f16-20020a056402161000b00525469afc38mr12032549edv.31.1692893721852; Thu, 24
 Aug 2023 09:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org> <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx> <20230824132155.GB3810470@google.com>
In-Reply-To: <20230824132155.GB3810470@google.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 25 Aug 2023 00:15:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7L0gYZv_HgXRfF01y8j+KB7ne=8H0-KxXx4nYUyY-vxQ@mail.gmail.com>
Message-ID: <CAAhV-H7L0gYZv_HgXRfF01y8j+KB7ne=8H0-KxXx4nYUyY-vxQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
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

Hi, Joel,

On Thu, Aug 24, 2023 at 9:22=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hello Thomas,
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
>
> Yes, we had already discussed this that jiffies update is not possible fr=
om
> here. There are too many threads since different patch revisions were bei=
ng
> reviewed in different threads.
>
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
> Yes, I had already mentioned exactly this issue here of not using an NMI-=
safe
> interface:
> https://lore.kernel.org/all/CAEXW_YT+uw5JodtrqjY0B2xx0J8ukF=3DFAB9-p5rxgW=
obSU2P2A@mail.gmail.com/
> I like your suggestion of using last_jiffies_update though (which as you
> mentioned needs to be explored more).
>
> There are too many threads which makes the discussion hard to follow. Hua=
cai,
> it would be great if we can keep the discussions in the same thread (Say =
for
> example by passing options like --in-reply-to to "git send-email" command=
).
I will try my best. In the early time, not all of us were involved.
And when I think we are all ready to accept the new solution, I sent a
new patch. But unfortunately some others suggest different approaches
which make the patch subject change again and again...

Now I tend to use Thomas's method by introducing and using
tick_estimate_stale_jiffies(). But let me wait for some time before
sending patches.

Huacai

>
> thanks,
>
>  - Joel
>
>
> >
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
