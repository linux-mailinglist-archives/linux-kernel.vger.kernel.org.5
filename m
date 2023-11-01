Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB83A7DE574
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbjKARkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKARkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:40:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9AAED;
        Wed,  1 Nov 2023 10:40:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83300C433C7;
        Wed,  1 Nov 2023 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698860414;
        bh=a6W3IlblsIT8EDDhgTVDxrMWX5YkV60VTCvGI//nKvQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mXkQHR2eAmvKVo+G4Y9+a/+qFEOqK7eJ8jmOMxxQHG+vnVnXP3MQcJYpbiIy7b8Bt
         K4E9v2+qjGJI+L69cXX0oSI6bHMNqygOoWqdh/+sfXbrMaEpqw1G4qe7fV2bi/WlUB
         prC0jDazB2FAptjTu423XE3JqPQbt/XEjaT5UKS7y8thUBBpramPuzov2qZ5YWWn1x
         MtWvAofLN/smhz9DHJLLfT6ooICS5t4W0W2cvAuxpIIEEc7p/+ue3FOW7vCsoLk8hE
         WP+pA3gSH8e0auPrQ4xT+n4OfP+SIR4HUo+XkKSpMfufkrGzXLFJT2vX1cH/q/8XbN
         Y4j9Pt5LHFloQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2052ECE09BE; Wed,  1 Nov 2023 10:40:14 -0700 (PDT)
Date:   Wed, 1 Nov 2023 10:40:14 -0700
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
Message-ID: <c83bea5c-b577-4b6a-bf41-6ac7433f15bc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZTuf+xNrfqGjHFDK@lothringen>
 <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
 <ZUDUlQq6hEEPBiCR@lothringen>
 <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
 <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com>
 <7416f684-37e7-4355-a5a0-2b1b5ef1b4d7@paulmck-laptop>
 <CAHk-=wiZZB_P57xUPqUg5j7Toany0FNaWO3Ht+Sks7J=XkYnfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZZB_P57xUPqUg5j7Toany0FNaWO3Ht+Sks7J=XkYnfA@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 07:11:54AM -1000, Linus Torvalds wrote:
> On Tue, 31 Oct 2023 at 15:08, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Here are the ways forward I can see:
> >
> > 1.      Status quo.  This has all the issues that you call out.
> >         People will hurt themselves with it and consume time and effort.
> >         So let's not do this.
> 
> Well, at a *minimum*, I really want that notifier chain call to be
> done *after* the core printk's.
> 
> That way, if it deadlocks or does something else stupid, at least the
> core printouts make it out.
> 
> IOW, I think the notifier should be done perhaps just before the
> "panic_on_rcu_stall()" call, not at the top before you've even
> reported any stall conditions at all.

Understood.  But my problem is that the core printk()s destroy the state
that the notifier is trying to output.

> And yes, I think the trace_rcu_stall_warning() might be better off
> later too, but at least trace events are things that get regular
> testing in nasty conditions (including NMI etc), so I'm *much* less
> worried about those than about "random developers who think they know
> what they do and add a notifier".

Agreed, this is a special debug facility, not something that anyone
should use in production.  And also not something that should be used
where gdb would do the job.

> And yes, I do think the notifier should be narrowed down a lot, if you
> actually want to keep it.

Understood, thus a new default-disabled Kconfig option that depends on
RCU_EXPERT and DEBUG_KERNEL, along with a default-disabled kernel
boot parameter, both of which have to be selected to make anything
happen.

> I did not actually hear you say that there is a good use-case for it.
> I only saw you say "Those of us who need this", without showing *any*
> kind of indication of why anybody would use it in reality.
> 
> Why the secrecy? There is certainly no current user, nor any
> description of what a user would be and what makes that notifier
> useful.
> 
> The commit message also just says "It is sometimes helpful" and some
> strange reference to "the subsystem causing the stall to dump its
> state". It all sounds very fishy. Why would anybody ever have a known
> subsystem causing RCU stalls? Except, of course, for the rcutorture
> testing.

One use case is dumping out the qspinlock state for an extremely
rare lockup.  If you even look at the system cross-eyed, the lockup
goes away.  And yes, I should have mentioned this in the commit
log, and I apologize for having failed to do so.  I do not expect
that the state-dump code would ever be appropriate for mainline.

> Anyway, that all absolutely SCREAMS to me "this is not something
> useful in any normal kernel", and so yes:

Agreed, definitely not for any normal kernel!

> > 3.      Add a default-n Kconfig option that depends on RCU_EXPERT
> >         and KEBUG_KERNEL, so that these problems can only arise in
> >         specially built kernels.
> >
> > 4.      Same as #3, but use a kernel boot parameter instead of a
> >         Kconfig option.
> 
> let's make it clear that this is *not* something that any upstream
> kernel would ever do, and the *only* possible use for it is some kind
> of external temporary debug patch.
> 
> See why I so hate things like this? Let's head off any crazy use long
> *long* before somebody decides that "Oh, I want to use this".

You are absolutely right, a debug tool with this many sharp edges should
definitely not be default-enabled.  And needs some scary words in the
Kconfig help text.  And a boot-time splat to make people think twice
before using it.

Apologies for not having thought this through!

I will send a fixup patch before the end of today.

							Thanx, Paul
