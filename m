Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86176D44A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjHBQw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjHBQwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699A03C0D;
        Wed,  2 Aug 2023 09:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFDA261909;
        Wed,  2 Aug 2023 16:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513E4C433C7;
        Wed,  2 Aug 2023 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995073;
        bh=hCZIrShg5wx7M4GzDWHg4uvKcAvNwnhm59vC8hv5k5A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kuI0yh/aIIZuS6R1HnnEW2X2qTWNcthk43+okckWEgMBVPfoO84LDet0eTKXGAiwt
         RPgx6qFz7N+hLt0owNYg1/4ChmfwG2FDfjRzvJIl0rGHu3F+EPPykIEPYA9eOvL3uI
         Kuby6obh3jl+D5GmPGWSpPSa8Yk1vtYAdWo+8xeYCObKbsA8SH/Dy8FqpZa9SakxeM
         mdaDTmrYf4Fb9d1shP+PowZ37pXqDe8Xq6d8GZs3FMiWgcQNlQY25USR5UWAhH0Ew1
         dzf+qLnV+I4SaAEPXhkrY7209t/YAUucNL8jyBTW2swAhoPksVdKvlZwMlcla/g5QE
         juNxGjBmCzh0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E503DCE0594; Wed,  2 Aug 2023 09:51:12 -0700 (PDT)
Date:   Wed, 2 Aug 2023 09:51:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Roy Hopkins <rhopkins@suse.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
Message-ID: <cc03b495-adb2-4c9c-9aba-6281cd04f6df@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
 <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
 <20230731211517.GA51835@hirez.programming.kicks-ass.net>
 <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
 <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
 <4f18d78411a5477690640a168e0e5d9f28d1c015.camel@suse.de>
 <063a2eba-6b5e-40bc-afd4-7d26f12762e4@paulmck-laptop>
 <10f9d5152389e3e76f200f737f11ec721a8e148f.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10f9d5152389e3e76f200f737f11ec721a8e148f.camel@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 04:31:12PM +0100, Roy Hopkins wrote:
> On Wed, 2023-08-02 at 08:05 -0700, Paul E. McKenney wrote:
> > On Wed, Aug 02, 2023 at 02:57:56PM +0100, Roy Hopkins wrote:
> > > On Tue, 2023-08-01 at 12:11 -0700, Paul E. McKenney wrote:
> > > > On Tue, Aug 01, 2023 at 10:32:45AM -0700, Guenter Roeck wrote:
> > > > 
> > > > 
> > > > Please see below for my preferred fix.  Does this work for you guys?
> > > > 
> > > > Back to figuring out why recent kernels occasionally to blow up all
> > > > rcutorture guest OSes...
> > > > 
> > > >                                                         Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > index 7294be62727b..2d5b8385c357 100644
> > > > --- a/kernel/rcu/tasks.h
> > > > +++ b/kernel/rcu/tasks.h
> > > > @@ -570,10 +570,12 @@ static void rcu_tasks_one_gp(struct rcu_tasks *rtp,
> > > > bool midboot)
> > > >         if (unlikely(midboot)) {
> > > >                 needgpcb = 0x2;
> > > >         } else {
> > > > +               mutex_unlock(&rtp->tasks_gp_mutex);
> > > >                 set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
> > > >                 rcuwait_wait_event(&rtp->cbs_wait,
> > > >                                    (needgpcb = rcu_tasks_need_gpcb(rtp)),
> > > >                                    TASK_IDLE);
> > > > +               mutex_lock(&rtp->tasks_gp_mutex);
> > > >         }
> > > >  
> > > >         if (needgpcb & 0x2) {
> > > 
> > > Your preferred fix looks good to me.
> > > 
> > > With the original code I can quite easily reproduce the problem on my 
> > > system every 10 reboots or so. With your fix in place the problem no
> > > longer occurs.
> > 
> > Very good, thank you!  May I add your Tested-by?
> > 
> >                                                         Thanx, Paul
> Yes, please do.

Thank you again, and I will apply this on my next rebase.

							Thanx, Paul
