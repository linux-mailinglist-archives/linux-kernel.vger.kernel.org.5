Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33B57B26E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjI1UyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjI1UyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:54:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE3B19F;
        Thu, 28 Sep 2023 13:54:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695934452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3j/9wejDQ+NDD78GYTcXX46SNesqLsHCj3tL/KaE0E=;
        b=EYTkJuHdjoZvurePgf/yWXyZ5oPJpCiNFgdwobRZRwPPDC9jJvS4JUEu5GPc/r9WVD6ayB
        j9kps0A221SwDIAw4jQqym2t+toR7V42FeNbUsU275ZGkZiSzR1Ph5LtoX/dH4F8SZHsgn
        mUFkrGjar4DUxJvMaMzQ5ENgWkITP5KJ83C4nSRuiLInP6v0adyn1oI7rX76kSytJm6bw3
        dZZf5c2/+mttVTw1IhGBnJK29WEZhpGOjf2SIhvVdqZF2CNk/+FaDohilJWZY67rcki0VH
        PpODGR1zxEl9iCZ7ao0iZY7xrP6ThQmq3d/a6IL3/xN9Spn3PLJ8+Vta+npwLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695934452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3j/9wejDQ+NDD78GYTcXX46SNesqLsHCj3tL/KaE0E=;
        b=HqXj5SW6T6+YgMfTewJs8NsuI03Yde52sXYrIUGj2g+KaVQIGqZqTQ3R7wVLpOsTdJepHy
        Ge7EkPDHdCvgSwCg==
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?utf-8?Q?An?= =?utf-8?Q?dr=C3=A9?= Almeida 
        <andrealmeid@igalia.com>, libc-alpha@sourceware.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>, longman@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
In-Reply-To: <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
Date:   Thu, 28 Sep 2023 22:54:12 +0200
Message-ID: <87o7hmdnnv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29 2023 at 15:14, Mathieu Desnoyers wrote:
> +/*
> + * rseq_sched_state should be aligned on the cache line size.
> + */
> +struct rseq_sched_state {
> +	/*
> +	 * Version of this structure. Populated by the kernel, read by
> +	 * user-space.
> +	 */
> +	__u32 version;
> +	/*
> +	 * The state is updated by the kernel. Read by user-space with
> +	 * single-copy atomicity semantics. This field can be read by any
> +	 * userspace thread. Aligned on 32-bit. Contains a bitmask of enum
> +	 * rseq_sched_state_flags. This field is provided as a hint by the
> +	 * scheduler, and requires that the page holding this state is
> +	 * faulted-in for the state update to be performed by the scheduler.
> +	 */
> +	__u32 state;
> +	/*
> +	 * Thread ID associated with the thread registering this structure.
> +	 * Initialized by user-space before registration.
> +	 */
> +	__u32 tid;
> +};
> +
>  /*
>   * struct rseq is aligned on 4 * 8 bytes to ensure it is always
>   * contained within a single cache-line.
> @@ -148,6 +180,15 @@ struct rseq {
>  	 */
>  	__u32 mm_cid;
>  
> +	__u32 padding1;
> +
> +	/*
> +	 * Restartable sequences sched_state_ptr field. Initialized by
> +	 * userspace to the address at which the struct rseq_sched_state is
> +	 * located. Read by the kernel on rseq registration.
> +	 */
> +	__u64 sched_state_ptr;
> +

Why is this a separate entity instead of being simply embedded into
struct rseq?

Neither the code comment nor the changelog tells anything about that.

If your intention was to provide a solution for process shared futexes
then you completely failed to understand how process shared futexes
work. If not, then please explain why you need a pointer and the
associated hackery to deal with it.

Thanks,

        tglx


