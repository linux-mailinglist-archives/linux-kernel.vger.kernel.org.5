Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A9C7D0036
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbjJSRIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjJSRIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:08:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0D1130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:08:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26875C433C9;
        Thu, 19 Oct 2023 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697735293;
        bh=kEzdmpSgsxge4iZIBXYMW8Gp5G9qVQ9vuxRAIEUfpFM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pLjfFdKCKN12svlbXRJA6ki21TrS1ROSPHqtfafi41SnggTJHm1p2huPJK2mAYm7W
         qfSPlsyw2QbJFBDpSQB7wSxJwI4AJxo25UMQFmpQIDX+FO39EsOBhKmCsyF3/4M13J
         i001iXULoot0xzcFy32pMpLm0Wofjw96lT5izSCBJ0JWLkHuW+KPPrLrRzlPDSI6An
         zaYGvWKKSZIlZlv+Upp5cMnQoculcTZFscjUyUAXCFYXdWgvYG2BveJzn35suhiWK7
         hDnGlt5VnSStQwl5eeK4LqawH9Nqm4zjvTctRkN6OSTtdpHL2q+tBhYjvxGoxVy3Bu
         f0v0AvGqZPi+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A9EA6CE0CF9; Thu, 19 Oct 2023 10:08:12 -0700 (PDT)
Date:   Thu, 19 Oct 2023 10:08:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <cdec2fb1-f5f4-48ab-a941-8cc963daa102@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87ttrngmq0.ffs@tglx>
 <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <20231018103146.4856caa8@gandalf.local.home>
 <ff85b142-c833-4a79-970d-ff691f9b60b7@paulmck-laptop>
 <20231018140035.107f5177@gandalf.local.home>
 <98f9ff35-5d71-4706-afe1-7e039afbcaaf@paulmck-laptop>
 <05066f9d-b8c9-4a22-b573-928df4263e49@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05066f9d-b8c9-4a22-b573-928df4263e49@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:37:23PM +0200, Daniel Bristot de Oliveira wrote:
> On 10/18/23 20:13, Paul E. McKenney wrote:
> > On Wed, Oct 18, 2023 at 02:00:35PM -0400, Steven Rostedt wrote:
> >> On Wed, 18 Oct 2023 10:55:02 -0700
> >> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >>
> >>>> If everything becomes PREEMPT_RCU, then the above should be able to be
> >>>> turned into just:
> >>>>
> >>>>                 if (!disable_irq)
> >>>>                         local_irq_disable();
> >>>>
> >>>>                 rcu_momentary_dyntick_idle();
> >>>>
> >>>>                 if (!disable_irq)
> >>>>                         local_irq_enable();
> >>>>
> >>>> And no cond_resched() is needed.  
> >>>
> >>> Even given that CONFIG_PREEMPT_RCU=n still exists, the fact that
> >>> run_osnoise() is running in kthread context with preemption and everything
> >>> else enabled (am I right?), then the change you suggest should work fine.
> >>
> >> There's a user space option that lets you run that loop with preemption and/or
> >> interrupts disabled.
> > 
> > Ah, thank you.  Then as long as this function is not expecting an RCU
> > reader to span that call to rcu_momentary_dyntick_idle(), all is well.
> > This is a kthread, so there cannot be something else expecting an RCU
> > reader to span that call.
> 
> Sorry for the delay, this thread is quite long (and I admit I should be paying
> attention to it).
> 
> It seems that you both figure it out without me anyways. This piece of
> code is preemptive unless a config is set to disable irq or preemption (as
> steven mentioned). That call is just a ping to RCU to say that things
> are fine.
> 
> So Steven's suggestion should work.

Very good!

> >>>>> Again. There is no non-preemtible RCU with this model, unless I'm
> >>>>> missing something important here.  
> >>>>
> >>>> Daniel?  
> >>>
> >>> But very happy to defer to Daniel.  ;-)
> >>
> >> But Daniel could also correct me ;-)
> > 
> > If he figures out a way that it is broken, he gets to fix it.  ;-)
> 
> It works for me, keep in the loop for the patches and I can test and
> adjust osnoise accordingly. osnoise should not be a reason to block more
> important things like this patch set, and we can find a way out in
> the osnoise tracer side. (I might need an assistance from rcu
> people, but I know I can count on them :-).

For good or for bad, we will be here.  ;-)

							Thanx, Paul
