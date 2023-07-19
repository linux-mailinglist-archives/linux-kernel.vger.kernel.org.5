Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EAD759FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGSUif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjGSUid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE71FD5;
        Wed, 19 Jul 2023 13:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 655E761807;
        Wed, 19 Jul 2023 20:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5790C433C7;
        Wed, 19 Jul 2023 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689799110;
        bh=MX1OE5fjXcKD7FNhNvGIrSI3FvsSGAQiIhW5RAzciLU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UqeFX6fDaD8ZBU4DrJqo6mibQqK/FIOJYQTZEX0Oo4lnUVX100DG0WoSKqd/vyJfj
         cVzo4ouC7DEMEGXpPCLvrHLXOCLPBy8qNH2KFqv8qlHxQS9EsGauvOTC78VQVyWJjY
         +4O1grFVx5Zk8H41nn8b+MSWNBFNJTzMV4BLyWFJKTLahsP6eAgvDY0hzNaPBUZAc4
         Hl3Q72jryEOXhIUSehz1txWRmloP1awPmEtX6uGXgYb38i9G0AwKAXiTnI1W5k7P8F
         pvsu1Z0DHh2NnIQ+jPkHsikyF+Pfwf4QQEa0sq63wyQAoaGyuYOgVFaXf7UKpD39R/
         p05rmxOz8Q22Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 610E7CE0928; Wed, 19 Jul 2023 13:38:30 -0700 (PDT)
Date:   Wed, 19 Jul 2023 13:38:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH rcu 2/6] rcu: Clarify rcu_is_watching() kernel-doc comment
Message-ID: <bebbfb7d-35c4-4edf-bfa2-5a6224c17966@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-2-paulmck@kernel.org>
 <a11d5ce7-5ee3-fbf7-9adb-4cfc805c6bb7@joelfernandes.org>
 <2e404769-67af-4240-b572-bd0808503486@paulmck-laptop>
 <998db46d-9c76-a3c5-e7c5-b7adf1770352@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998db46d-9c76-a3c5-e7c5-b7adf1770352@joelfernandes.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:56:38PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On 7/18/23 14:12, Paul E. McKenney wrote:
> > On Tue, Jul 18, 2023 at 08:52:30AM -0400, Joel Fernandes wrote:
> > > Hi Paul,
> > > 
> > > On 7/17/23 14:03, Paul E. McKenney wrote:
> > > > Make it clear that this function always returns either true or false
> > > > without other planned failure modes.
> > > > 
> > > > Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >    kernel/rcu/tree.c | 12 ++++++++----
> > > >    1 file changed, 8 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 1449cb69a0e0..fae9b4e29c93 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -679,10 +679,14 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
> > > >    /**
> > > >     * rcu_is_watching - see if RCU thinks that the current CPU is not idle
> > > 
> > > Would it be better to modify the 'not idle' to 'not idle from an RCU
> > > viewpoint'? This matches the comments in ct_nmi_enter() as well.
> > 
> > We have the "if RCU thinks that" earlier.
> > 
> > But maybe something like this?
> > 
> >   * rcu_is_watching - RCU read-side critical sections permitted on current CPU?
> > 
> 
> Yes, that's better.
> 
> > > >     *
> > > > - * Return true if RCU is watching the running CPU, which means that this
> > > > - * CPU can safely enter RCU read-side critical sections.  In other words,
> > > > - * if the current CPU is not in its idle loop or is in an interrupt or
> > > > - * NMI handler, return true.
> > > > + * Return @true if RCU is watching the running CPU and @false otherwise.
> > > > + * An @true return means that this CPU can safely enter RCU read-side
> > > > + * critical sections.
> > > > + *
> > > > + * More specifically, if the current CPU is not deep within its idle
> > > > + * loop, return @true.  Note that rcu_is_watching() will return @true if
> > > > + * invoked from an interrupt or NMI handler, even if that interrupt or
> > > > + * NMI interrupted the CPU while it was deep within its idle loop.
> > > 
> > > But it is more than the idle loop, for ex. NOHZ_FULL CPUs with single task
> > > running could be idle from RCU's viewpoint? Could that be clarified more?
> > 
> > Perhaps something like this?
> > 
> >   * Although calls to rcu_is_watching() from most parts of the kernel
> >   * will return @true, there are important exceptions.  For example, if the
> >   * current CPU is deep within its idle loop, in kernel entry/exit code,
> >   * or offline, rcu_is_watching() will return @false.
> > 
> > (Where nohz_full CPUs are covered by kernel entry/exit code.)
> 
> To me, "kernel exit" does not immediately make the nohz_full CPU case
> obvious. But yes, your suggestion is an improvement so we can go with that.
> :)
> 
> Also because we agree on the changes, for next revision:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Very good, thank you!  The update should appear shortly.  For some
definition of "shortly".  ;-)

							Thanx, Paul
