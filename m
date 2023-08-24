Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A2787043
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbjHXN3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbjHXN31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:29:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1909D1BC9;
        Thu, 24 Aug 2023 06:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1D166C60;
        Thu, 24 Aug 2023 13:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEA6C433C8;
        Thu, 24 Aug 2023 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692883763;
        bh=iwcXjSdbGezaOQR1+gpNxwK0d5wA+Qb9bpVfk7qBDBQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=j1tRe8tMsySMG8JSTDKzR9flI36NpVyzZCQrrdX/cCVWZi5C9S3NLxMhbm4AQb5jb
         dawOtFWOgdwgoMhroGlbdnz3Uwnc1OCDjPN/4fCTiSX7y1p2ecwmgxktAJeDi1dG5g
         PKCXDnRbKkaGf+2Moee3zd6haq3pdXFz6PaXAIjmSeMp9MjSavWiW7hWdVDRaR7t+u
         laN/h18iG+/Ns7Nko4Szx6NYwgkrUxzlkHzgj55+6qcaFt0lWBPlBOdHqK5/WPTX7h
         i+XhYqptSwRt+i2LuqrnCW4HawML1yEaV0ILfg2qRzaaVjgjYhZ81wPvqH98d6U7a1
         /ULnUtHMzbj1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AEB93CE035E; Thu, 24 Aug 2023 06:29:22 -0700 (PDT)
Date:   Thu, 24 Aug 2023 06:29:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
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
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <e3e4fa67-17d0-42ac-aab4-a4b83a652ee7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
 <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
 <20230824132155.GB3810470@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824132155.GB3810470@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:21:55PM +0000, Joel Fernandes wrote:
> Hello Thomas,
> 
> On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> > On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > > On Thu, Aug 17, 2023 at 3:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >> > If  do_update_jiffies_64() cannot be used in NMI context,
> > >>
> > >> Can you not make the jiffies update conditional on whether it is
> > >> called within NMI context?
> > 
> > Which solves what? If KGDB has a breakpoint in the jiffies lock held
> > region then you still dead lock.
> 
> Yes, we had already discussed this that jiffies update is not possible from
> here. There are too many threads since different patch revisions were being
> reviewed in different threads.

One of the nice properties of the jiffies counter is its trivially
provable NMI safety  ;-)

							Thanx, Paul

> > >> I dislike that..
> > > Is this acceptable?
> > >
> > > void rcu_cpu_stall_reset(void)
> > > {
> > >         unsigned long delta;
> > >
> > >         delta = nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
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
> Yes, I had already mentioned exactly this issue here of not using an NMI-safe
> interface:
> https://lore.kernel.org/all/CAEXW_YT+uw5JodtrqjY0B2xx0J8ukF=FAB9-p5rxgWobSU2P2A@mail.gmail.com/
> I like your suggestion of using last_jiffies_update though (which as you
> mentioned needs to be explored more).
> 
> There are too many threads which makes the discussion hard to follow. Huacai,
> it would be great if we can keep the discussions in the same thread (Say for
> example by passing options like --in-reply-to to "git send-email" command).
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
> > +	ktime_t delta = ktime_get_mono_fast_ns() - READ_ONCE(last_jiffies_update);
> > +
> > +	return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> > +}
> > +
> >  /*
> >   * Must be called with interrupts disabled !
> >   */
> > 
> > 
