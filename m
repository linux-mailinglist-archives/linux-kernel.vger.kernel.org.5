Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4137CE5FD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbjJRSNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjJRSNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:13:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1B98
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:13:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD34C433C8;
        Wed, 18 Oct 2023 18:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697652798;
        bh=/5tzr5CWv4KijS8Ooc9na1PJM05K7T5Kk3SSmP4w6vY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IIOasrIMBAbX4CLhg3deTsjXR8yFA57r50gAu3R5/kvkGPRzlzn9DMwSDj3iURR+a
         vSqOFSSSTvFpRTpXV3EONc3rdGtS34LCP+vrBnl9hm2AD0m2QKVhAZoGryetUK36No
         esin8l5jYx5nmlCUeqRRN09SgVcmDuUOc5qEseq1oNUDFW8Y5SXE3vyA1qaJcd5GWB
         Fnjrhho+zTPWt/9BoO2d1dUe0oQ8VLx1iGOGHYRwuqHa9/OpeeJK6QBACIvWPb4pFe
         1TbFfbMmPjhlk7aA0pAi6sZRVtNM8nZSkQZIUwRPEgg11QkRz/FbHT9zit1FiWxaOM
         B17p3keRBw8GQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A3B86CE0DE3; Wed, 18 Oct 2023 11:13:17 -0700 (PDT)
Date:   Wed, 18 Oct 2023 11:13:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Frederic Weisbecker <fweisbec@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <98f9ff35-5d71-4706-afe1-7e039afbcaaf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87ttrngmq0.ffs@tglx>
 <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <20231018103146.4856caa8@gandalf.local.home>
 <ff85b142-c833-4a79-970d-ff691f9b60b7@paulmck-laptop>
 <20231018140035.107f5177@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018140035.107f5177@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 02:00:35PM -0400, Steven Rostedt wrote:
> On Wed, 18 Oct 2023 10:55:02 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > If everything becomes PREEMPT_RCU, then the above should be able to be
> > > turned into just:
> > > 
> > >                 if (!disable_irq)
> > >                         local_irq_disable();
> > > 
> > >                 rcu_momentary_dyntick_idle();
> > > 
> > >                 if (!disable_irq)
> > >                         local_irq_enable();
> > > 
> > > And no cond_resched() is needed.  
> > 
> > Even given that CONFIG_PREEMPT_RCU=n still exists, the fact that
> > run_osnoise() is running in kthread context with preemption and everything
> > else enabled (am I right?), then the change you suggest should work fine.
> 
> There's a user space option that lets you run that loop with preemption and/or
> interrupts disabled.

Ah, thank you.  Then as long as this function is not expecting an RCU
reader to span that call to rcu_momentary_dyntick_idle(), all is well.
This is a kthread, so there cannot be something else expecting an RCU
reader to span that call.

> > > > Again. There is no non-preemtible RCU with this model, unless I'm
> > > > missing something important here.  
> > > 
> > > Daniel?  
> > 
> > But very happy to defer to Daniel.  ;-)
> 
> But Daniel could also correct me ;-)

If he figures out a way that it is broken, he gets to fix it.  ;-)

						Thanx, Paul
