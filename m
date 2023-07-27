Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF427644BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjG0EBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjG0EBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:01:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32CF2706;
        Wed, 26 Jul 2023 21:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 711BE61D1A;
        Thu, 27 Jul 2023 04:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7DAC433C7;
        Thu, 27 Jul 2023 04:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690430493;
        bh=7P9bctip4x/Ces3Bz7dso9KXmS3btigLpvzlMCULfH0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=D565kj6upZRrf38Bp6minq/mj7J9MWuvrW9OuKL0+A9Yi/8T+TcoP3cX18fBB7mH2
         tKzKUlKNTpRNsgfCFRA51D44mpCD6+YVqviiFD8mHHbpFT2g4CAiZSJkDFGoLaCoeO
         2yh/FoPRHR/KjZDgKjQEUE6bogq8LA04NKN8Y/uIMQabHWyPP2WWcyglhraQ7kYbH0
         SIuaG4HNaBp5Sb1YIMcwbG61Xibsdk5KGrDEIr5/GkYAs5xfwUMFfHAMheVLcLRChp
         slC9P9jTTHeKvK/9pB/8OfpGhYtRH1LF6UgsyXzjaOnZused8zwf6Ol8DdMVsdUevM
         DJR5JltYJfo3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 66812CE0BDA; Wed, 26 Jul 2023 21:01:33 -0700 (PDT)
Date:   Wed, 26 Jul 2023 21:01:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 1/5] rcutorture: Fix stuttering races and other issues
Message-ID: <9482525e-fddf-449c-b448-8261cff3395f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230725232913.2981357-1-joel@joelfernandes.org>
 <20230725232913.2981357-2-joel@joelfernandes.org>
 <f6ef4762-6d37-40a4-8272-13b248c46f5b@paulmck-laptop>
 <CAEXW_YTfo8MDcAQk23cw=vxzReZntSXgkUefD+=4yZ+Gb+ZAww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTfo8MDcAQk23cw=vxzReZntSXgkUefD+=4yZ+Gb+ZAww@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:01:40PM -0400, Joel Fernandes wrote:
> On Wed, Jul 26, 2023 at 4:59 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Jul 25, 2023 at 11:29:06PM +0000, Joel Fernandes (Google) wrote:
> > > The stuttering code isn't functioning as expected. Ideally, it should
> > > pause the torture threads for a designated period before resuming. Yet,
> > > it fails to halt the test for the correct duration. Additionally, a race
> > > condition exists, potentially causing the stuttering code to pause for
> > > an extended period if the 'spt' variable is non-zero due to the stutter
> > > orchestration thread's inadequate CPU time.
> > >
> > > Moreover, over-stuttering can hinder RCU's progress on TREE07 kernels.
> > > This happens as the stuttering code may run within a softirq due to RCU
> > > callbacks. Consequently, ksoftirqd keeps a CPU busy for several seconds,
> > > thus obstructing RCU's progress. This situation triggers a warning
> > > message in the logs:
> > >
> > > [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> > >
> > > This warning suggests that an RCU torture object, although invisible to
> > > RCU readers, couldn't make it past the pipe array and be freed -- a
> > > strong indication that there weren't enough grace periods during the
> > > stutter interval.
> > >
> > > To address these issues, this patch sets the "stutter end" time to an
> > > absolute point in the future set by the main stutter thread. This is
> > > then used for waiting in stutter_wait(). While the stutter thread still
> > > defines this absolute time, the waiters' waiting logic doesn't rely on
> > > the stutter thread receiving sufficient CPU time to halt the stuttering
> > > as the halting is now self-controlled.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/torture.c | 46 +++++++++++++---------------------------------
> > >  1 file changed, 13 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/kernel/torture.c b/kernel/torture.c
> > > index 68dba4ecab5c..63f8f2a7d960 100644
> > > --- a/kernel/torture.c
> > > +++ b/kernel/torture.c
> > > @@ -719,7 +719,7 @@ static void torture_shutdown_cleanup(void)
> > >   * suddenly applied to or removed from the system.
> > >   */
> > >  static struct task_struct *stutter_task;
> > > -static int stutter_pause_test;
> > > +static ktime_t stutter_till_abs_time;
> > >  static int stutter;
> > >  static int stutter_gap;
> > >
> > > @@ -729,30 +729,17 @@ static int stutter_gap;
> > >   */
> > >  bool stutter_wait(const char *title)
> > >  {
> > > -     unsigned int i = 0;
> > >       bool ret = false;
> > > -     int spt;
> > > +     ktime_t now_ns, till_ns;
> > >
> > >       cond_resched_tasks_rcu_qs();
> > > -     spt = READ_ONCE(stutter_pause_test);
> > > -     for (; spt; spt = READ_ONCE(stutter_pause_test)) {
> > > -             if (!ret && !rt_task(current)) {
> > > -                     sched_set_normal(current, MAX_NICE);
> > > -                     ret = true;
> > > -             }
> > > -             if (spt == 1) {
> > > -                     torture_hrtimeout_jiffies(1, NULL);
> > > -             } else if (spt == 2) {
> > > -                     while (READ_ONCE(stutter_pause_test)) {
> > > -                             if (!(i++ & 0xffff))
> > > -                                     torture_hrtimeout_us(10, 0, NULL);
> > > -                             cond_resched();
> > > -                     }
> > > -             } else {
> > > -                     torture_hrtimeout_jiffies(round_jiffies_relative(HZ), NULL);
> > > -             }
> > > -             torture_shutdown_absorb(title);
> > > +     now_ns = ktime_get();
> > > +     till_ns = READ_ONCE(stutter_till_abs_time);
> > > +     if (till_ns && ktime_before(now_ns, till_ns)) {
> > > +             torture_hrtimeout_ns(ktime_sub(till_ns, now_ns), 0, NULL);
> >
> > This ktime_sub() is roughly cancelled out by a ktime_add_safe() in
> > __hrtimer_start_range_ns().
> 
> Yes, functionally it is the same but your suggestion is more robust I think.
> 
> > Perhaps torture_hrtimeout_ns() needs to
> > take a mode argument as in the patch at the end of this email, allowing
> > you to ditch that ktime_sub() in favor of HRTIMER_MODE_ABS.
> 
> Sure, or we can add a new API and keep the default as relative?
> 
> Or have 2 APIs:
> torture_hrtimeout_relative_ns();
> 
> and:
> torture_hrtimeout_absolute_ns();
> 
> That makes it more readable IMHO.
> 
> Also, do you want me to make both changes (API and usage) in the same
> patch? Or were you planning to have a separate patch yourself in -dev
> which I can use? Let me know either way, and then I'll refresh the
> patch.

I queued the patch on the -rcu tree's "dev" branch.  It turns out that
torture_hrtimeout_ns() isn't called very many times, so adding the
parameter was straightforward.  Plus the compiler might well optimize
it away anyway.

							Thanx, Paul
