Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3FA7F377B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjKUUcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjKUUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:32:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406C51AA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mPcvVUr8HyRnp1aSDsAdvlimBvK+3BhX+aM2Alx5mqo=; b=mIrgR5qRdk0w3cvo6OGhGx+ybS
        ryPeZ+PXcYXTJUMdDd/bThNofQWboBYTG35XeXgxcoX08VW9Y9LgXs63MCtsCGudARZThuf+Hj1u5
        ppZwOEc1du3571f7wiXafXNASbPLpf2QbZujF7DZ/3QjXwTcbBawhMW3DYDjkeJhxBkhaJ3CeNpKx
        tgDBWcScPDaxolJgzIpoeMZS6rJos5gjndFbrMrMsnFQ2tnR5/cXrJMl3g1fRSI2WNBtr4yRBCQmQ
        jHYZKGwZitUA6jlmR89mKmUfU4DJ4hLPRn8dqQnX3OyTSAv9G63vxXH1XVcf4s7BbGTpH9Mf5Si/2
        LN2ub+Bg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r5XOV-00BYNi-0M;
        Tue, 21 Nov 2023 20:30:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D95D0300338; Tue, 21 Nov 2023 21:30:49 +0100 (CET)
Date:   Tue, 21 Nov 2023 21:30:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20231121203049.GN8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87lear4wj6.fsf@oracle.com>
 <46a4c47a-ba1c-4776-a6f8-6c2146cbdd0d@paulmck-laptop>
 <31d50051-e42c-4ef2-a1ac-e45370c3752e@paulmck-laptop>
 <d10b6243-41b1-44a0-ba95-0cedc7f6856e@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10b6243-41b1-44a0-ba95-0cedc7f6856e@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:25:18AM -0800, Paul E. McKenney wrote:
> #define preempt_enable() \
> do { \
> 	barrier(); \
> 	if (!IS_ENABLED(CONFIG_PREEMPT_RCU) && raw_cpu_read(rcu_data.rcu_urgent_qs) && \
> 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK | HARDIRQ_MASK | NMI_MASK) == PREEMPT_OFFSET) &&
> 	    !irqs_disabled()) \
> 		rcu_all_qs(); \
> 	if (unlikely(preempt_count_dec_and_test())) { \
> 		__preempt_schedule(); \
> 	} \
> } while (0)

Aaaaahhh, please no. We spend so much time reducing preempt_enable() to
the minimal thing it is today, this will make it blow up into something
giant again.
