Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A54811B93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjLMRwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLMRw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:52:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC883
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:52:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D417FC433C9;
        Wed, 13 Dec 2023 17:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702489955;
        bh=G8gvqaJsOovAzWijVF1YdUmeoDhtEd9YvOcb1wcEgyU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HPEGxOVqEPYzu9pJjVZcoo82HDOw/caZfbV9FSxs8AQWqKyPwGyeFgp42e6sQQ238
         4ACpX2Ak+es2Skes9Ioc3/Fwz9FEU+22ab9Gus9b+1ivgcK6BYLXoVob/rZiQXx/1Z
         DZAUpmNvv1FN3z3MWmAMLavrJosUlZAqDAI4niCYKvbl0qAPkiiQ5igFkYNunWer55
         aVIbQz4XZ+xEtYiBV+GVMDPWkObufFFMz0gkvK+06cJNMeY9TB9dHdzqwgREC3PLX6
         525HXKyOhPsU7UQLH8QCes3DBEoGVjfM/tMz/pGBY+QDsPk50IlTTgp8ucH8rMUTcs
         kQ1h7+dNinSUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 690CFCE0C4D; Wed, 13 Dec 2023 09:52:35 -0800 (PST)
Date:   Wed, 13 Dec 2023 09:52:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH rcu 3/3] srcu: Explain why callbacks invocations can't
 run concurrently
Message-ID: <2b2c1573-337d-409b-a8ee-daeff096c7f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231212174750.GA11886@neeraj.linux>
 <20231212174817.11919-3-neeraj.iitr10@gmail.com>
 <CAEXW_YRHjdM+NA3CqNuwaRNXkRWbtypmt5Ov=YXnrpn3Eo-==Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRHjdM+NA3CqNuwaRNXkRWbtypmt5Ov=YXnrpn3Eo-==Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:27:09AM -0500, Joel Fernandes wrote:
> On Tue, Dec 12, 2023 at 12:48 PM Neeraj Upadhyay (AMD)
> <neeraj.iitr10@gmail.com> wrote:
> >
> > From: Frederic Weisbecker <frederic@kernel.org>
> >
> > If an SRCU barrier is queued while callbacks are running and a new
> > callbacks invocator for the same sdp were to run concurrently, the
> > RCU barrier might execute too early. As this requirement is non-obvious,
> > make sure to keep a record.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
> > ---
> >  kernel/rcu/srcutree.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 2bfc8ed1eed2..0351a4e83529 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1715,6 +1715,11 @@ static void srcu_invoke_callbacks(struct work_struct *work)
> >         WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
> >         rcu_segcblist_advance(&sdp->srcu_cblist,
> >                               rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> > +       /*
> > +        * Although this function is theoretically re-entrant, concurrent
> > +        * callbacks invocation is disallowed to avoid executing an SRCU barrier
> > +        * too early.
> > +        */
> 
> Side comment:
> I guess even without the barrier reasoning, it is best not to allow
> concurrent CB execution anyway since it diverges from the behavior of
> straight RCU :)

Good point!

But please do not forget item 12 on the list in checklist.rst.  ;-)
(Which I just updated to include the other call_rcu*() functions.)

							Thanx, Paul
