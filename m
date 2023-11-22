Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4F57F3A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjKVAM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKVAM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:12:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78F89F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:12:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C29CC433C7;
        Wed, 22 Nov 2023 00:12:18 +0000 (UTC)
Date:   Tue, 21 Nov 2023 19:12:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for
 PREEMPT_RCU=n
Message-ID: <20231121191232.630222d3@gandalf.local.home>
In-Reply-To: <0d6a8e80-c89b-4ded-8de1-8c946874f787@paulmck-laptop>
References: <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
        <87lear4wj6.fsf@oracle.com>
        <46a4c47a-ba1c-4776-a6f8-6c2146cbdd0d@paulmck-laptop>
        <31d50051-e42c-4ef2-a1ac-e45370c3752e@paulmck-laptop>
        <d10b6243-41b1-44a0-ba95-0cedc7f6856e@paulmck-laptop>
        <20231121203049.GN8262@noisy.programming.kicks-ass.net>
        <1cdbb0f6-9078-4023-bf37-8d826ca0c711@paulmck-laptop>
        <20231121163834.571abb52@gandalf.local.home>
        <4605b4f4-8a2b-4653-b684-9c696c36ebd0@paulmck-laptop>
        <20231121175209.1d7ec202@gandalf.local.home>
        <0d6a8e80-c89b-4ded-8de1-8c946874f787@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 16:01:24 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> 
> > I stand by that being in the else statement. It looks like that would keep
> > the previous work flow.  
> 
> Ah, because PREEMPT_NEED_RESCHED is zero when we need to reschedule,
> so that when __preempt_count_dec_and_test() returns false, we might
> still be in an RCU quiescent state in the case where there was no need
> to reschedule.  Good point!
> 
> In which case...
> 
> #define preempt_enable() \
> do { \
> 	barrier(); \
> 	if (unlikely(preempt_count_dec_and_test())) \
> 		__preempt_schedule(); \
> 	else if (!sched_feat(FORCE_PREEMPT) && \
> 		 (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK | HARDIRQ_MASK | NMI_MASK) == PREEMPT_OFFSET) && \
> 		 !irqs_disabled()) \
> ) \
> 			rcu_all_qs(); \
> } while (0)
> 
> Keeping rcu_all_qs() pretty much as is.  Or some or all of the "else if"
> condition could be pushed down into rcu_all_qs(), depending on whether
> Peter's objection was call-site object code size, execution path length,
> or both.  ;-)
> 
> If the objection is both call-site object code size and execution path
> length, then maybe all but the preempt_count() check should be pushed
> into rcu_all_qs().
> 
> Was that what you had in mind, or am I missing your point?

Yes, that is what I had in mind.

Should we also keep the !IS_ENABLED(CONFIG_PREEMPT_RCU) check, which makes
the entire thing optimized out when PREEMPT_RCU is enabled?

-- Steve
