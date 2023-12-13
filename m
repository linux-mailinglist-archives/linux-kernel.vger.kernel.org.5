Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EA2811D95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjLMSy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjLMSyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:54:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E02B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:55:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B224DC433C7;
        Wed, 13 Dec 2023 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702493701;
        bh=gNwdzPsr9UWjlIeXdMO9ihywHKgw6GU/WIg5VvGTAaw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BLEwHEC9xexsuNcvGDIs8F1R9mitnFG6BFTwBMIo1YZzyJo76DWKF6wPmO4/EaJ5m
         HUu9AoGBBPrbm2BPquvJZWg35Q3qJtb5a7l2Ummy744S+2EwCL0yR+ARXGOmEBorxT
         kzFXM/cNvD20CP1t5fAiIhd8UdZUZAAasA1W+goHjmIzDNH2ao/66M28sMLMRf/D+n
         07LPLi4iT7jkAmeWvgGL+jeyLay3u2/0KNHbwuc6uZeqtjo8S4WKIe6WrP3aiysClf
         CK+b93YBH0HwW0uNT7kAcWvnUKGFKlBth+5Ab3QfYV3W9IwTu2fy4FlcaAPFLkUhFE
         DuVjVYKghL8OA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 50904CE0C4D; Wed, 13 Dec 2023 10:55:01 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:55:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH rcu 3/3] srcu: Explain why callbacks invocations can't
 run concurrently
Message-ID: <9109c700-a353-4b12-a7c5-2f67e9ab4e86@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231212174750.GA11886@neeraj.linux>
 <20231212174817.11919-3-neeraj.iitr10@gmail.com>
 <CAEXW_YRHjdM+NA3CqNuwaRNXkRWbtypmt5Ov=YXnrpn3Eo-==Q@mail.gmail.com>
 <2b2c1573-337d-409b-a8ee-daeff096c7f4@paulmck-laptop>
 <CAEXW_YQnR51F9xnODZd3iE+S5Jpd2NHRBTk6Jt2WHTSdB9H8kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQnR51F9xnODZd3iE+S5Jpd2NHRBTk6Jt2WHTSdB9H8kA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:35:22PM -0500, Joel Fernandes wrote:
> On Wed, Dec 13, 2023 at 12:52 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Dec 13, 2023 at 09:27:09AM -0500, Joel Fernandes wrote:
> > > On Tue, Dec 12, 2023 at 12:48 PM Neeraj Upadhyay (AMD)
> > > <neeraj.iitr10@gmail.com> wrote:
> > > >
> > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > >
> > > > If an SRCU barrier is queued while callbacks are running and a new
> > > > callbacks invocator for the same sdp were to run concurrently, the
> > > > RCU barrier might execute too early. As this requirement is non-obvious,
> > > > make sure to keep a record.
> > > >
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
> > > > ---
> > > >  kernel/rcu/srcutree.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 2bfc8ed1eed2..0351a4e83529 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -1715,6 +1715,11 @@ static void srcu_invoke_callbacks(struct work_struct *work)
> > > >         WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
> > > >         rcu_segcblist_advance(&sdp->srcu_cblist,
> > > >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> > > > +       /*
> > > > +        * Although this function is theoretically re-entrant, concurrent
> > > > +        * callbacks invocation is disallowed to avoid executing an SRCU barrier
> > > > +        * too early.
> > > > +        */
> > >
> > > Side comment:
> > > I guess even without the barrier reasoning, it is best not to allow
> > > concurrent CB execution anyway since it diverges from the behavior of
> > > straight RCU :)
> >
> > Good point!
> >
> > But please do not forget item 12 on the list in checklist.rst.  ;-)
> > (Which I just updated to include the other call_rcu*() functions.)
> 
> I think this is more so now with recent kernels (with the dynamic nocb
> switch) than with older kernels right? I haven't kept up with the
> checklist recently (which is my bad).

You are quite correct!  But even before this, I was saying that
lack of same-CPU callback concurrency was an accident of the current
implementation rather than a guarantee.  For example, there might come
a time when RCU needs to respond to callback flooding with concurrent
execution of the flooded CPU's callbacks.  Or not, but we do need to
keep this option open.

> My understanding comes from the fact that the RCU barrier depends on
> callbacks on the same CPU executing in order with straight RCU
> otherwise it breaks. Hence my comment. But as you pointed out, that's
> outdated knowledge.

That is still one motivation for ordered execution of callbacks.  For the
dynamic nocb switch, we could have chosen to make rcu_barrier() place
a callback on both lists, but we instead chose to exclude rcu_barrier()
calls during the switch.

> I should just shut up and hide in shame now.

No need for that!  After all, one motivation for Requirements.rst was
to help me keep track of all this stuff.

							Thanx, Paul

> :-/
> 
>  - Joel
