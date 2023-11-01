Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081AD7DDA85
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376989AbjKABIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345068AbjKABIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:08:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6FA10A;
        Tue, 31 Oct 2023 18:07:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5307BC433C7;
        Wed,  1 Nov 2023 01:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698800878;
        bh=fpTEmkkF4yZhyMprjFhI57WfkYZd8fsZre7kHOFJmZs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KF6Idb0NZxDfq7CM5a1oAAhtupxfy9QC2ADZ8ONZDg1EuAMd0IhLDPjPVh9ojCHz/
         MqPtIDZaD4zuHpmM+zHwQ7ElbTCJN/arfzZ3mGOxewmorU/ZUvsSSZSh71hXGlsC5d
         p0BmmyiXY/i1HvfcDReyqpJwSEadxmPjbLNXbnU0x1A8ZYbKfulzHMBGo2lQi2BiOq
         56O1ipaZWJzBsSOg2b87JDg/E445DdeFKu3VUPrHvwfS86FirSvr0Oj76ngNKwJ9tE
         XOu0Cod0V79t2T6whQ6s0WJuVkRXakWqZAdqmu+qZ50GzUZMkSEnfGaESza4ouXL9d
         vXV7oNdlEShWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D2845CE0B77; Tue, 31 Oct 2023 18:07:57 -0700 (PDT)
Date:   Tue, 31 Oct 2023 18:07:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
Message-ID: <7416f684-37e7-4355-a5a0-2b1b5ef1b4d7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZTuf+xNrfqGjHFDK@lothringen>
 <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
 <ZUDUlQq6hEEPBiCR@lothringen>
 <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
 <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 01:06:44PM -1000, Linus Torvalds wrote:
> On Tue, 31 Oct 2023 at 03:57, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Would it help if we make rcu_stall_chain_notifier_register() print a
> > suitably obnoxious message saying that future RCU CPU stall warnings
> > might be unreliable?
> 
> It's not the future stall warnings I worry about.
> 
> It's literally things like somebody thinking they are being clever,
> registering a rcu stall notifier that prints out extra information in
> order to be helpful, and in the process takes a spinlock or something
> without thinking about it.
> 
> And that spinlock might be the *reason* for the RCU stall in the first place.
> 
> So now the RCU stall code prints out NOTHING AT ALL, because now the
> stall notifier itself has deadlocked.
> 
> This is *exactly* what has happened before with these kinds of
> "helpful" exception case notifiers. Because they never trigger in
> normal loads, they get basically zero testing - and then when bad
> things happen, it turns out that the "helpful" debug code actually
> just makes things worse.
> 
> Or, if they get testing, they get tested in artificial bad cases (eg
> "let's just write a busy loop that hangs for 30 seconds to trigger a
> RCU stall"), which doesn't show any of the issues, because they aren't
> real bugs with real existing deadlocks.
> 
> See what I'm saying? Having notifiers for "sh*t happened" is
> fundmanetally questionable to begin with, because they get no testing.
> 
> And then calling said notifiers *before* you even have the core
> printout for "Look, things are going down hill quickly", now you've
> turned a bad situation even worse.
> 
> I really think that we should *never* have any kind of notifiers for
> kernel bugs. They cause problems. The *one* exception is an actual
> honest-to-goodness kernel debugger, and then it should literally
> *only* be the debugger that can register a notifier, so that you are
> *never* in the situation that a kernel without a debugger will just
> hang because of some bogus debug notifier.

All fair points.

Here are the ways forward I can see:

1.	Status quo.  This has all the issues that you call out.
	People will hurt themselves with it and consume time and effort.
	So let's not do this.

2.	I send you a pure revert.  Those of us who need this keep the
	patches around and apply them when we need them.  This avoids
	the problems you point out, but makes it harder to use this
	where it is needed and useful.

3.	Add a default-n Kconfig option that depends on RCU_EXPERT
	and KEBUG_KERNEL, so that these problems can only arise in
	specially built kernels.

4.	Same as #3, but use a kernel boot parameter instead of a
	Kconfig option.

5.	One of the above other than #2, but complaining (maybe a WARN_ON()
	or maybe just a printk() at rcu_stall_chain_notifier_register()
	time, but before the call to atomic_notifier_chain_register().
	This would mean that the complaint ("hey, you are asking for
	something that might be dangerous") appears before any RCU CPU
	stall warning that could possibly trigger a notifier.

Are there any other ways forward?  Either way, which would you prefer?

							Thanx, Paul
