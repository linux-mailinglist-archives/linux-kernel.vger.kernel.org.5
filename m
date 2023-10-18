Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43B7CDFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbjJROdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbjJROdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:33:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DEC19A8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:30:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7317BC433C7;
        Wed, 18 Oct 2023 14:30:07 +0000 (UTC)
Date:   Wed, 18 Oct 2023 10:31:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     paulmck@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20231018103146.4856caa8@gandalf.local.home>
In-Reply-To: <87pm1c3wbn.ffs@tglx>
References: <87ttrngmq0.ffs@tglx>
        <87jzshhexi.ffs@tglx>
        <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
        <87pm1c3wbn.ffs@tglx>
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

On Wed, 18 Oct 2023 15:16:12 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> > 14.	The kernel/trace/trace_osnoise.c file's run_osnoise() function
> > 	might need to do something for non-preemptible RCU to make
> > 	up for the lack of cond_resched() calls.  Maybe just drop the
> > 	"IS_ENABLED()" and execute the body of the current "if" statement
> > 	unconditionally.  

Right.

I'm guessing you are talking about this code:

                /*
                 * In some cases, notably when running on a nohz_full CPU with
                 * a stopped tick PREEMPT_RCU has no way to account for QSs.
                 * This will eventually cause unwarranted noise as PREEMPT_RCU
                 * will force preemption as the means of ending the current
                 * grace period. We avoid this problem by calling
                 * rcu_momentary_dyntick_idle(), which performs a zero duration
                 * EQS allowing PREEMPT_RCU to end the current grace period.
                 * This call shouldn't be wrapped inside an RCU critical
                 * section.
                 *
                 * Note that in non PREEMPT_RCU kernels QSs are handled through
                 * cond_resched()
                 */
                if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
                        if (!disable_irq)
                                local_irq_disable();

                        rcu_momentary_dyntick_idle();

                        if (!disable_irq)
                                local_irq_enable();
                }

                /*
                 * For the non-preemptive kernel config: let threads runs, if
                 * they so wish, unless set not do to so.
                 */
                if (!disable_irq && !disable_preemption)
                        cond_resched();



If everything becomes PREEMPT_RCU, then the above should be able to be
turned into just:

                if (!disable_irq)
                        local_irq_disable();

                rcu_momentary_dyntick_idle();

                if (!disable_irq)
                        local_irq_enable();

And no cond_resched() is needed.

> 
> Again. There is no non-preemtible RCU with this model, unless I'm
> missing something important here.

Daniel?

-- Steve
