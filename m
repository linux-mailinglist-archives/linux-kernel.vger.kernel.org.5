Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DB278489F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjHVRqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHVRqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B52127
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD22861465
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7A6C433C9;
        Tue, 22 Aug 2023 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692726384;
        bh=0FEgRhV8yNWhQi1CIj+s7tSaB44ukKDzU3V+uAdWVqA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lwBWBCeLkIz6irJr/u7yeut3YceaWcW4CYLLmUfdrwFHVw51iGSOkeh2euyF0KISX
         N1IR/lJ3+6a3eP+OGQr8tANLOdq0ObuIrFDDeqi+XDI0yAmBQKgtg7CmBCWDTNS5/6
         Fd4pIzf26eavj1qrVPPFPI7oZMFMFgq83JmtZ4/ACIwqpkjnjF4PSZ6ci5gtDsd312
         Ve48I5lZKcECBAygfMoKWdyi2/1zrU36DVI8do1yNWaCwgvrVNnd0hS33mbIAx7M81
         BfzXNGSjnNUUCXj33jYTtTD6vsCQaCkql3ZH1kN2XaCicvrVe2782dxhu4CPqwAdDA
         1DkxhFZm4rfsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C0D8CCE0898; Tue, 22 Aug 2023 10:46:23 -0700 (PDT)
Date:   Tue, 22 Aug 2023 10:46:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Question on __torture_rt_boost() else clause
Message-ID: <df999cba-a090-4461-8db6-7ddd788ddf85@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1393d18f-4928-45da-b504-7e5b6a681e51@paulmck-laptop>
 <20230822161850.GB74437@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822161850.GB74437@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 04:18:50PM +0000, Joel Fernandes wrote:
> Hi Paul,
> 
> On Mon, Aug 21, 2023 at 08:12:50PM -0700, Paul E. McKenney wrote:
> > Hello, Joel!
> > 
> > A quick question for you...
> > 
> > I am doing catch-up additions of locktorture module parameters
> > to kernel-parameters.txt, and came across rt_boost_factor.  The
> > multiplication by cxt.nrealwriters_stress in the !rt_task(current)
> > then-clause makes sense:  No matter how many writers you have, the
> > number of boost operations per unit time remains roughly constant.
> 
> > But I am having some difficulty rationalizing a similar multiplication
> > in the else-clause.  That would seem to leave boosting in effect for
> > longer times the more writers there were.
> 
> But the number of de-boost operations per-unit time should also remain a
> constant? I think you (or the original authors) wanted it to boost at every
> 50k ops at deboost at 500k ops originally.

The else-clause controls the boost duration.  So if I am understanding
the code correctly, the more writers there are, the longer each writer
stays boosted.  Which might be a good thing, but seemed strange.

> > Is that the intent?
> 
> The original change before my patch to make boosting possible for non-rtmutex
> types already had that multiplication, see below for diff from my patch. My
> patch just kept the same thing to make the logic consistent (i.e. deboost
> less often).

Ah, you are right, I should have told "git blame" to dig deeper.

But hey, you did touch the code at one point!  ;-)

> > Also, I am rationalizing the choice of 2 as default for rt_boost by
> > noting that "mutex" and "ww_mutex_lock" don't do boosting and that
> > preemption-disabling makes non-RT spinlocks immune from priority
> > inversion.  Is this what you had in mind, or am I off in the weeds here?
> 
> The 2 was just to make sure that we don't deboost as often as we boost, which
> is also what the old logic was trying to do.

This is a different "2".  The rt_boost=0 says never boost, rt_boost=1
says boost only if the lock in question supports priority boosting, and
rt_boost=2 (the default) says boost unconditionally, aside from lock
types that don't define cur_ops->task_boost.  Except that they all
define cur_ops->task_boost.

I am not seeing failures in my torture.sh testing, so maybe OK, but it
does seem a bit strange.

(And this probably predates your involvement as well, but so it goes!)

> What is the drawback of keeping the boost active for longer than not? It will
> trigger the PI-boosting (and in the future proxy exec) more often.

My concern is someone running this on a 1,000-CPU system.  Though locking
being what it is, there is a non-negligible possibility that something
else breaks first.

> Also by making the factor configurable, I allow it to control how often we
> boost and deboost. IIRC, it was boosting much less often before I did that.

No argument with the frequency of boosting, just curiosity about the
duration increasing with increasing numbers of CPUs.  I can rationalize
it, but then again, I can rationalize pretty much anything.  ;-)

> > I am putting my best guess in the patch, and am including you on CC.
> 
> Ok, thanks,

On the other hand, it looks like I can now reproduce a qspinlock hang
that happens maybe five to ten times a week across the entire fleet
in a few tens of minutes.  On my laptop.  ;-)

Now to start adding debug.  Which will affect the reproduction times,
but life is like that sometimes...

							Thanx, Paul

>  - Joel
> 
> 
> -static void torture_rtmutex_boost(struct torture_random_state *trsp)
> -{
> -       const unsigned int factor = 50000; /* yes, quite arbitrary */
> -
> -       if (!rt_task(current)) {
> -               /*
> -                * Boost priority once every ~50k operations. When the
> -                * task tries to take the lock, the rtmutex it will account
> -                * for the new priority, and do any corresponding pi-dance.
> -                */
> -               if (trsp && !(torture_random(trsp) %
> -                             (cxt.nrealwriters_stress * factor))) {
> -                       sched_set_fifo(current);
> -               } else /* common case, do nothing */
> -                       return;
> -       } else {
> -               /*
> -                * The task will remain boosted for another ~500k operations,
> -                * then restored back to its original prio, and so forth.
> -                *
> -                * When @trsp is nil, we want to force-reset the task for
> -                * stopping the kthread.
> -                */
> -               if (!trsp || !(torture_random(trsp) %
> -                              (cxt.nrealwriters_stress * factor * 2))) {
> -                       sched_set_normal(current, 0);
> -               } else /* common case, do nothing */
> -                       return;
> -       }
> -}
> -
