Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002427B2677
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjI1UWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjI1UWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:22:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79727CC4;
        Thu, 28 Sep 2023 13:21:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695932510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DmX9bKSrcJ3gg7QbnQ5HyzLMjN52R6w5zfPwPk6xm2I=;
        b=YHT9m7xPV8mIUJbLtJqCcLFzUFa4VSLHpjgkGY3cd4OsQhGGJgLg1e37/hA4+6GMM4768U
        J25l2Ijl5q2Dr3EN5sV1sW5qOUs6yOKu0Riai6pRlhAkAIDZJr2/z5n6bLp/vMjHgJ+Gt8
        63LUYOG1iK4A0Zkv/x961yPdotSWh/SOFx/NVCyhNci9dTYBETgAAOOicW6ltIasTVrzML
        PrMeIDKfE7VwKrI5Sn/Ar4iVv2LH2liLUD3belCuqIgfums7+W1d5fGNCGiQjZartkoR+z
        gUfdlE3SjYRXr6yMe/vD0mOpT499Ao6EyQxB6mxpa1onD+YQCdM+hq/cTMS7ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695932510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DmX9bKSrcJ3gg7QbnQ5HyzLMjN52R6w5zfPwPk6xm2I=;
        b=caIsx9kL4G5PovmJ3A6YjoJRCjOZI7Nd/fXke7hfbfjDaR9tlUHt4i1fkUBLXVsyc5lCpC
        yR+HpMzGp3/N7MDA==
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
Date:   Thu, 28 Sep 2023 22:21:49 +0200
Message-ID: <87r0midp5u.ffs@tglx>
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
> +void __rseq_set_sched_state(struct task_struct *t, unsigned int state);
> +
> +static inline void rseq_set_sched_state(struct task_struct *t, unsigned int state)
> +{
> +	if (t->rseq_sched_state)
> +		__rseq_set_sched_state(t, state);

This is invoked on every context switch and writes over that state
unconditionally even in the case that the state was already
cleared. There are enough situations where tasks are scheduled out
several times while being in the kernel.

>  /* rseq_preempt() requires preemption to be disabled. */
>  static inline void rseq_preempt(struct task_struct *t)
>  {
>  	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
>  	rseq_set_notify_resume(t);
> +	rseq_set_sched_state(t, 0);

This code is already stupid to begin with. __set_bit() is cheap, but
rseq_set_notify_resume() is not as it has a conditional and a locked
instruction and now you add two more conditionals into the context
switch path.

Thanks,

        tglx
