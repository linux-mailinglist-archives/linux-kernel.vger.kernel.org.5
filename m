Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2C7CE5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbjJRSBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjJRSAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:00:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2C313A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:00:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6858C433C7;
        Wed, 18 Oct 2023 18:00:36 +0000 (UTC)
Date:   Wed, 18 Oct 2023 14:00:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20231018140035.107f5177@gandalf.local.home>
In-Reply-To: <ff85b142-c833-4a79-970d-ff691f9b60b7@paulmck-laptop>
References: <87ttrngmq0.ffs@tglx>
        <87jzshhexi.ffs@tglx>
        <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
        <87pm1c3wbn.ffs@tglx>
        <20231018103146.4856caa8@gandalf.local.home>
        <ff85b142-c833-4a79-970d-ff691f9b60b7@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 10:55:02 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > If everything becomes PREEMPT_RCU, then the above should be able to be
> > turned into just:
> > 
> >                 if (!disable_irq)
> >                         local_irq_disable();
> > 
> >                 rcu_momentary_dyntick_idle();
> > 
> >                 if (!disable_irq)
> >                         local_irq_enable();
> > 
> > And no cond_resched() is needed.  
> 
> Even given that CONFIG_PREEMPT_RCU=n still exists, the fact that
> run_osnoise() is running in kthread context with preemption and everything
> else enabled (am I right?), then the change you suggest should work fine.

There's a user space option that lets you run that loop with preemption and/or
interrupts disabled.

> 
> > > Again. There is no non-preemtible RCU with this model, unless I'm
> > > missing something important here.  
> > 
> > Daniel?  
> 
> But very happy to defer to Daniel.  ;-)

But Daniel could also correct me ;-)

-- Steve
