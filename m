Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC97A7B81CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbjJDOHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242733AbjJDOHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:07:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CFAAB;
        Wed,  4 Oct 2023 07:06:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A708C433C8;
        Wed,  4 Oct 2023 14:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696428419;
        bh=0aMNmntwZCcrSGUrwkiAjMgLAOJXkQKHi1pPoXwQ0VY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Obf55Ll+HfLmdSGMfH8g548AIhnPoFDKzbLgvQFM3NaehFhsh+Zuo61L3iEaPCY9w
         ATyBnVTw6RVYNam1c0MeZCPxq/56JjGiJsDLU23z1ISsrfe9lGHTPPyjVUa/EzaSQB
         dMITksDhBlCtE9tbpJBr+lD4eu4qHsEOhB7teQfTvAZwnzaWIl7V3JlfxziFCf/UBE
         RS6rbyv63nfEh2L1fUOwH31sQJO9sO1sbftFBbb/2pUggp/BlvfpRipIH4TrXWufDV
         dxHXrX2qjH4CPFln6KR1oQtzbYawrgotQhip39M/PpB+E8ErPGs0BIQSAb2hgqCFhD
         CKNTbESN8TSoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B485FCE0223; Wed,  4 Oct 2023 07:06:58 -0700 (PDT)
Date:   Wed, 4 Oct 2023 07:06:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/5] srcu fixes
Message-ID: <77322b72-1d95-46c6-9837-1d811b36336c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231003232903.7109-1-frederic@kernel.org>
 <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
 <1d21ceee-56d3-4784-9e6f-0a766c773833@paulmck-laptop>
 <811d08e3-efb8-4398-8fbc-6b5d030afb15@paulmck-laptop>
 <ZR0yMdyoA5biYYxg@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR0yMdyoA5biYYxg@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:36:49AM +0200, Frederic Weisbecker wrote:
> On Tue, Oct 03, 2023 at 08:30:45PM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 03, 2023 at 08:21:42PM -0700, Paul E. McKenney wrote:
> > > On Tue, Oct 03, 2023 at 05:35:31PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Oct 04, 2023 at 01:28:58AM +0200, Frederic Weisbecker wrote:
> > > > > Hi,
> > > > > 
> > > > > This contains a fix for "SRCU: kworker hung in synchronize_srcu":
> > > > > 
> > > > > 	http://lore.kernel.org/CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com
> > > > > 
> > > > > And a few cleanups.
> > > > > 
> > > > > Passed 50 hours of SRCU-P and SRCU-N.
> > > > > 
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > > > 	srcu/fixes
> > > > > 
> > > > > HEAD: 7ea5adc5673b42ef06e811dca75e43d558cc87e0
> > > > > 
> > > > > Thanks,
> > > > > 	Frederic
> > > > 
> > > > Very good, and a big "Thank You!!!" to all of you!
> > > > 
> > > > I queued this series for testing purposes, and have started a bunch of
> > > > SRCU-P and SRCU-N tests on one set of systems, and a single SRCU-P and
> > > > SRCU-N on another system, but with both scenarios resized to 40 CPU each.
> > 
> > The 200*1h of SRCU-N and the 100*1h of SRCU-p passed other than the usual
> > tick-stop errors.  (Is there a patch for that one?)  The 40-CPU SRCU-N
> > run was fine, but the 40-CPU SRCU-P run failed due to the fanouts setting
> > a maximum of 16 CPUs.  So I started a 10-hour 40-CPU SRCU-P and a pair
> > of 10-hour 16-CPU SRCU-N runs on one system, and 200*10h of SRCU-N and
> > 100*10h of SRCU-P.
> > 
> > I will let you know how it goes.
> 
> Very nice! It might be worth testing the first patch alone as
> well if we backport only this one.

The 10-hour 40-CPU SRCU-P run and pair of 10-hour 16-CPU SRCU-N runs
completed without failure.  The others had some failures, but I need
to look and see if any were unexpected.  In the meantime, I started a
two-hour 40-CPU SRCU-P run and a pair of one-hour 16-CPU SRCU-N runs on
just that first commit.  Also servicing SIGSHOWER and SIGFOOD.  ;-)

							Thanx, Paul

> Thanks!
> 
> 
> > 							Thanx, Paul
> > 
> > > > While that is in flight, a few questions:
> > > > 
> > > > o	Please check the Co-developed-by rules.  Last I knew, it was
> > > > 	necessary to have a Signed-off-by after each Co-developed-by.
> > > > 
> > > > o	Is it possible to get a Tested-by from the original reporter?
> > > > 	Or is this not reproducible?
> > > > 
> > > > o	Is it possible to convince rcutorture to find this sort of
> > > > 	bug?  Seems like it should be, but easy to say...
> > > 
> > > And one other thing...
> > > 
> > > o	What other bugs like this one are hiding elsewhere
> > > 	in RCU?
> > > 
> > > > o	Frederic, would you like to include this in your upcoming
> > > > 	pull request?  Or does it need more time?
> > > 
> > > 						Thanx, Paul
> > > 
> > > > > ---
> > > > > 
> > > > > Frederic Weisbecker (5):
> > > > >       srcu: Fix callbacks acceleration mishandling
> > > > >       srcu: Only accelerate on enqueue time
> > > > >       srcu: Remove superfluous callbacks advancing from srcu_start_gp()
> > > > >       srcu: No need to advance/accelerate if no callback enqueued
> > > > >       srcu: Explain why callbacks invocations can't run concurrently
> > > > > 
> > > > > 
> > > > >  kernel/rcu/srcutree.c | 55 ++++++++++++++++++++++++++++++++++++---------------
> > > > >  1 file changed, 39 insertions(+), 16 deletions(-)
