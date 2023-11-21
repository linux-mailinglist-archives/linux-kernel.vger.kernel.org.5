Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEED57F37E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjKUVOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKUVOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:14:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A8C19E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:14:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB56CC433C8;
        Tue, 21 Nov 2023 21:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700601257;
        bh=PEMlU7zldHLo1aKXjpxLqC8BQBT/nGnYIxViFracvZk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AMZkwADevVl74bFK0AXYkZpOmb+sxMA3c8gT7X7KerDoGNGc44afw8t+CFxXeQiO7
         gUSj2x7+vgo5TX/VBK+hCprsYHY9O0E68Y1q1OJtO1nluP8SSNfD7KtfbHIDvA57DE
         6mIj2E4hxGRnaY/zNzxnB/aioQ5oUCBUbw++bex55m2OriLsNcAGGy6d+uRDefvYRf
         IhPxTtS8OMPy5Sahjxc0W5w107NtwsIO77CCbAc4Ie2ysuijRiscRM5kuKEW5EWuw0
         NSocnZq6aUKBoMcXt+uOg5p6IGSoT0cJydPOczCuSZXH/TcpXkkie8pvULGUIvuslR
         vzuVJg9iRET6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8212DCE078E; Tue, 21 Nov 2023 13:14:16 -0800 (PST)
Date:   Tue, 21 Nov 2023 13:14:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
Message-ID: <1cdbb0f6-9078-4023-bf37-8d826ca0c711@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87lear4wj6.fsf@oracle.com>
 <46a4c47a-ba1c-4776-a6f8-6c2146cbdd0d@paulmck-laptop>
 <31d50051-e42c-4ef2-a1ac-e45370c3752e@paulmck-laptop>
 <d10b6243-41b1-44a0-ba95-0cedc7f6856e@paulmck-laptop>
 <20231121203049.GN8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121203049.GN8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 09:30:49PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 21, 2023 at 11:25:18AM -0800, Paul E. McKenney wrote:
> > #define preempt_enable() \
> > do { \
> > 	barrier(); \
> > 	if (!IS_ENABLED(CONFIG_PREEMPT_RCU) && raw_cpu_read(rcu_data.rcu_urgent_qs) && \
> > 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK | HARDIRQ_MASK | NMI_MASK) == PREEMPT_OFFSET) &&
> > 	    !irqs_disabled()) \
> > 		rcu_all_qs(); \
> > 	if (unlikely(preempt_count_dec_and_test())) { \
> > 		__preempt_schedule(); \
> > 	} \
> > } while (0)
> 
> Aaaaahhh, please no. We spend so much time reducing preempt_enable() to
> the minimal thing it is today, this will make it blow up into something
> giant again.

IPIs, then.  Or retaining some cond_resched() calls, as needed.

Or is there another way?

							Thanx, Paul
