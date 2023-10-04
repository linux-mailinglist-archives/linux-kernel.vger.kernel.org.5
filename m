Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382C07B7C34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbjJDJfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjJDJfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:35:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5379DAF;
        Wed,  4 Oct 2023 02:35:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD13C433C7;
        Wed,  4 Oct 2023 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696412139;
        bh=1R9YOdaJktjKuIY0sIzrtibQpIhkJLVi71eZB9MeRoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kriT3b7GrQIO2kqlaSBdwUndtbVFlihm8jcYQZ4ZxHHDbCH6zPwJsQ4yam0Zgj4bo
         R1XxoBoawvue2kagsNOIwWrobqkfj7VCsaRqXmZR+LaMV0RTqqtAEt67HS4XVMUsQF
         um0z42AgZgxrAeEHdQ/JNmrmy4fQ+ICBBpyH4KIlkB+nHwElLhhW/9RFLKamlZX4So
         lZMEZC+iEZqszL6yaejOw6AbtB4dhCT8F1wJtTy8fLhwKqAy0tCSPMP8gRrE1EPeuF
         DAf1wFGFUhVgbXiOmToF5Xqc25t5C7libtA6t1sAvRy2tYkIJgmtdNOJVNYUjsULUT
         /U+hBYGHehYDw==
Date:   Wed, 4 Oct 2023 11:35:36 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/5] srcu fixes
Message-ID: <ZR0x6NK03A5F1yNW@lothringen>
References: <20231003232903.7109-1-frederic@kernel.org>
 <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
 <1d21ceee-56d3-4784-9e6f-0a766c773833@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d21ceee-56d3-4784-9e6f-0a766c773833@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 08:21:42PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 03, 2023 at 05:35:31PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 04, 2023 at 01:28:58AM +0200, Frederic Weisbecker wrote:
> > > Hi,
> > > 
> > > This contains a fix for "SRCU: kworker hung in synchronize_srcu":
> > > 
> > > 	http://lore.kernel.org/CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com
> > > 
> > > And a few cleanups.
> > > 
> > > Passed 50 hours of SRCU-P and SRCU-N.
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > 	srcu/fixes
> > > 
> > > HEAD: 7ea5adc5673b42ef06e811dca75e43d558cc87e0
> > > 
> > > Thanks,
> > > 	Frederic
> > 
> > Very good, and a big "Thank You!!!" to all of you!
> > 
> > I queued this series for testing purposes, and have started a bunch of
> > SRCU-P and SRCU-N tests on one set of systems, and a single SRCU-P and
> > SRCU-N on another system, but with both scenarios resized to 40 CPU each.
> > 
> > While that is in flight, a few questions:
> > 
> > o	Please check the Co-developed-by rules.  Last I knew, it was
> > 	necessary to have a Signed-off-by after each Co-developed-by.
> > 
> > o	Is it possible to get a Tested-by from the original reporter?
> > 	Or is this not reproducible?
> > 
> > o	Is it possible to convince rcutorture to find this sort of
> > 	bug?  Seems like it should be, but easy to say...
> 
> And one other thing...
> 
> o	What other bugs like this one are hiding elsewhere
> 	in RCU?

Hmm, yesterday I thought RCU would be fine because it has a tick polling
on callbacks anyway. But I'm not so sure, I'll check for real...

Thanks.

> 
> > o	Frederic, would you like to include this in your upcoming
> > 	pull request?  Or does it need more time?
> 
> 						Thanx, Paul
> 
> > > ---
> > > 
> > > Frederic Weisbecker (5):
> > >       srcu: Fix callbacks acceleration mishandling
> > >       srcu: Only accelerate on enqueue time
> > >       srcu: Remove superfluous callbacks advancing from srcu_start_gp()
> > >       srcu: No need to advance/accelerate if no callback enqueued
> > >       srcu: Explain why callbacks invocations can't run concurrently
> > > 
> > > 
> > >  kernel/rcu/srcutree.c | 55 ++++++++++++++++++++++++++++++++++++---------------
> > >  1 file changed, 39 insertions(+), 16 deletions(-)
