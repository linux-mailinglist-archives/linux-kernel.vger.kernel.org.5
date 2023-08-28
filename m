Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9778B3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjH1PEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjH1PD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230C2FC;
        Mon, 28 Aug 2023 08:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5AC764AD5;
        Mon, 28 Aug 2023 15:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CD4C433C7;
        Mon, 28 Aug 2023 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693235035;
        bh=zlGV7q8lIZGCPYpweCS9ZHeeiC9aNhHub2r8nbihtrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPHqyNivyfLAght7enMoTcks+gjoOQBYGAK9QIPCA+qAjOygwztnqBQ1p6euAmKkk
         IZgkXsHqQsw1hrSdN8OVq5pyp4ocqGNccnDD2y3tfMUY/GONr8SR1Wk9GsWbKQqXP+
         m0b/y94nxU7NXGdFYRlTOCL4odSiDAAQTSw0w55aIbTtZ7MDsj02bWLEg2JESqyrfe
         0yKxUmnNAqhdmwNnQuB8k8MHkyjchZgYqEMKAFqGUywlIFoRJcKAHQK/CcPPb+GDFw
         LOTPIKjgV3El6unHV4juORBTovIQ/YumcT/YJUe3P/f2R2cySLy9pCCWBSEM5abnqQ
         DrDESb/vfO/9w==
Date:   Mon, 28 Aug 2023 17:03:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>, paul.gortmaker@windriver.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tick/rcu: fix false positive "softirq work is pending"
 messages on RT
Message-ID: <ZOy3S8ajaV8YWtE-@2a01cb09806c67d6fe4a366cc09da8f8.ipv6.abo.wanadoo.fr>
References: <20230818200757.1808398-1-paul.gortmaker@windriver.com>
 <tencent_C80D3EE7563151B306E94C2AA7BF3023F80A@qq.com>
 <ff5263ec-96a8-4e8e-96af-de6ab8a17750@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff5263ec-96a8-4e8e-96af-de6ab8a17750@paulmck-laptop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Aug 21, 2023 at 03:03:10PM -0700, Paul E. McKenney a écrit :
> On Mon, Aug 21, 2023 at 01:23:15AM +0800, Wen Yang wrote:
> > 
> > On 2023/8/19 04:07, paul.gortmaker@windriver.com wrote:
> > > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > 
> > > In commit 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
> > > the new function report_idle_softirq() was created by breaking code out
> > > of the existing can_stop_idle_tick() for kernels v5.18 and newer.
> > > 
> > > In doing so, the code essentially went from a one conditional:
> > > 
> > > 	if (a && b && c)
> > > 		warn();
> > > 
> > > to a three conditional:
> > > 
> > > 	if (!a)
> > > 		return;
> > > 	if (!b)
> > > 		return;
> > > 	if (!c)
> > > 		return;
> > > 	warn();
> > > 
> > > However, it seems one of the conditionals didn't get a "!" removed.
> > > Compare the instance of local_bh_blocked() in the old code:
> > > 
> > > -               if (ratelimit < 10 && !local_bh_blocked() &&
> > > -                   (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
> > > -                       pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
> > > -                               (unsigned int) local_softirq_pending());
> > > -                       ratelimit++;
> > > -               }
> > > 
> > > ...to the usage in the new (5.18+) code:
> > > 
> > > +       /* On RT, softirqs handling may be waiting on some lock */
> > > +       if (!local_bh_blocked())
> > > +               return false;
> > > 
> > > It seems apparent that the "!" should be removed from the new code.
> > > 
> > > This issue lay dormant until another fixup for the same commit was added
> > > in commit a7e282c77785 ("tick/rcu: Fix bogus ratelimit condition").
> > > This commit realized the ratelimit was essentially set to zero instead
> > > of ten, and hence *no* softirq pending messages would ever be issued.
> > > 
> > > Once this commit was backported via linux-stable, both the v6.1 and v6.4
> > > preempt-rt kernels started printing out 10 instances of this at boot:
> > > 
> > >    NOHZ tick-stop error: local softirq work is pending, handler #80!!!
> > > 
> > > Just to double check my understanding of things, I confirmed that the
> > > v5.18-rt did print the pending-80 messages with a cherry pick of the
> > > ratelimit fix, and then confirmed no pending softirq messages were
> > > printed with a revert of mainline's 034569 on a v5.18-rt baseline.
> > > 
> > > Finally I confirmed it fixed the issue on v6.1-rt and v6.4-rt, and
> > > also didn't break anything on a defconfig of mainline master of today.
> > > 
> > > Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
> > > Cc: Wen Yang <wenyang.linux@foxmail.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > 
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index 2b865cb77feb..b52e1861b913 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -1050,7 +1050,7 @@ static bool report_idle_softirq(void)
> > >   		return false;
> > >   	/* On RT, softirqs handling may be waiting on some lock */
> > > -	if (!local_bh_blocked())
> > > +	if (local_bh_blocked())
> > >   		return false;
> > >   	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",
> > 
> > Good catch!
> > 
> > Reviewed-by: Wen Yang <wenyang.linux@foxmail.com>
> 
> Frederic would normally take this, but he appears to be out.  So I am
> (probably only temporarily) queueing this in -rcu for more testing
> coverage.

I'm back, I should relay this to Thomas to avoid conflicts with
timers changes.

Thanks all of you, clearly I wasn't thinking much the day I wrote this
patch.
