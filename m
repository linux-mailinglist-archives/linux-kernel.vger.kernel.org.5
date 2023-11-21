Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30AF7F31CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjKUPAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjKUPAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:00:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E399D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:00:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78850C433C7;
        Tue, 21 Nov 2023 15:00:44 +0000 (UTC)
Date:   Tue, 21 Nov 2023 10:00:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
Message-ID: <20231121100030.3546b702@gandalf.local.home>
In-Reply-To: <29984609-14e1-4ce4-864b-87932ba3245a@paulmck-laptop>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-48-ankur.a.arora@oracle.com>
        <20231107192703.1c493431@gandalf.local.home>
        <b8c1ae88-5c12-488c-a7af-42119ebd55d2@paulmck-laptop>
        <20231120224356.7e9e5423@gandalf.local.home>
        <29984609-14e1-4ce4-864b-87932ba3245a@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 21:04:28 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> How about like this, where "Y" means allowed and "N" means not allowed:
> 
> 			Non-Preemptible RCU	Preemptible RCU
> 
> NONE:				Y			Y
> 
> VOLUNTARY:			Y			Y
> 
> PREEMPT:			N			Y
> 
> PREEMPT_RT:			N			Y
> 
> 
> We need preemptible RCU for NONE and VOLUNTARY, as you say,
> to allow CONFIG_PREEMPT_DYNAMIC to continue to work.  (OK, OK,
> CONFIG_PREEMPT_DYNAMIC is no longer, but appears to be unconditional.)
> But again, I don't see why anyone would want (much less need)
> non-preemptible RCU in the PREEMPT and PREEMPT_RT cases.  And if it is
> neither wanted nor needed, there is no point in enabling it, much less
> testing it.
> 
> Or am I missing a use case in there somewhere?

As Ankur replied, this is just an RFC, not the main goal. I'm talking about
the end product which will get rid of the PREEMPT_NONE, PREEMPT_VOLUNTARY
and PREEMPT conifgs, and there will *only* be the PREEMPT_DYNAMIC and
PREEMPT_RT.

And yes, this is going to be a slow and long processes, to find and fix all
regressions. I too am concerned about the latency that this may add. I'm
thinking we could have NEED_RESCHED_LAZY preempt when there is no mutex or
other semi critical section held (like migrate_disable()).

Right now, the use of cond_resched() is basically a whack-a-mole game where
we need to whack all the mole loops with the cond_resched() hammer. As
Thomas said, this is backwards. It makes more sense to just not preempt in
areas that can cause pain (like holding a mutex or in an RCU critical
section), but still have the general kernel be fully preemptable.

-- Steve
