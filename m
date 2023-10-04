Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F807B7C09
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbjJDJZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbjJDJZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:25:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05026AB;
        Wed,  4 Oct 2023 02:25:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC61C433C8;
        Wed,  4 Oct 2023 09:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696411536;
        bh=ZzTWSABeD4wFE2m9mjmYRRB/7+UvIZBGEIN6sgQ0kb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvXVBh51nCLP8HhQ7mLu03TGsMQLe1lTiMyPIJXL2ED7e7tHUGkGWCZn4B2RRkEcj
         mfjs8Y+5HnQ79cWOddLLyDLVw/I0YpoYiqkvaoMVDrS4O8eIvlbeM+iOJvPL/fj2fV
         Ay2+TGteENtSmTN3aduCBaE3yQBT8H+2yKs0+UZZYByBcIfkDpZ9jNtop3lEb0Dkck
         yxFVlQBqJxdS5vBKpMITUE3zFCpHVyzDAZS6IJYFrc7bcXKFRSNAODn3fDi1TxoNF/
         s9DEBErlkSZ4HmDSXRAPPVb/VMRv1nsFYROjvqgvOX4mCKbxpdtDk/gJiXcdPz/RK7
         rxdDmcMli831A==
Date:   Wed, 4 Oct 2023 11:25:33 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/5] srcu fixes
Message-ID: <ZR0vjdp+BNiFm46+@lothringen>
References: <20231003232903.7109-1-frederic@kernel.org>
 <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 05:35:31PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 04, 2023 at 01:28:58AM +0200, Frederic Weisbecker wrote:
> > Hi,
> > 
> > This contains a fix for "SRCU: kworker hung in synchronize_srcu":
> > 
> > 	http://lore.kernel.org/CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com
> > 
> > And a few cleanups.
> > 
> > Passed 50 hours of SRCU-P and SRCU-N.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	srcu/fixes
> > 
> > HEAD: 7ea5adc5673b42ef06e811dca75e43d558cc87e0
> > 
> > Thanks,
> > 	Frederic
> 
> Very good, and a big "Thank You!!!" to all of you!
> 
> I queued this series for testing purposes, and have started a bunch of
> SRCU-P and SRCU-N tests on one set of systems, and a single SRCU-P and
> SRCU-N on another system, but with both scenarios resized to 40 CPU each.
> 
> While that is in flight, a few questions:
> 
> o	Please check the Co-developed-by rules.  Last I knew, it was
> 	necessary to have a Signed-off-by after each Co-developed-by.

Indeed! I'll try to collect the three of them within a few days. If some
are missing, I'll put a Reported-by instead.

> 
> o	Is it possible to get a Tested-by from the original reporter?
> 	Or is this not reproducible?

It seems that the issue would trigger rarely. But I hope we can get one.

> 
> o	Is it possible to convince rcutorture to find this sort of
> 	bug?  Seems like it should be, but easy to say...

So at least the part where advance/accelerate fail is observed from time
to time. But then we must meet two more rare events:

1) The CPU failing to ACC/ADV must also fail to start the grace period because
  another CPU was faster.

2) The callbacks invocation must not run until that grace period has ended (even
  though we had a previous one completed with callbacks ready).

  Or it can run after all but at least the acceleration part of it has to
  happen after the end of the new grace period.

Perhaps all these conditions can me met more often if we overcommit the number
of vCPU. For example run 10 SRCU-P instances within 3 real CPUs. This could
introduce random breaks within the torture writers...

Just an idea...

> 
> o	Frederic, would you like to include this in your upcoming
> 	pull request?  Or does it need more time?

At least the first patch yes. It should be easily backported and
it should be enough to solve the race. I'll just wait a bit to collect
more tags.

Thanks!

> 
> 						Thanx, Paul
> 
> > ---
> > 
> > Frederic Weisbecker (5):
> >       srcu: Fix callbacks acceleration mishandling
> >       srcu: Only accelerate on enqueue time
> >       srcu: Remove superfluous callbacks advancing from srcu_start_gp()
> >       srcu: No need to advance/accelerate if no callback enqueued
> >       srcu: Explain why callbacks invocations can't run concurrently
> > 
> > 
> >  kernel/rcu/srcutree.c | 55 ++++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 39 insertions(+), 16 deletions(-)
