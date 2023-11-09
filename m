Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4147E696D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjKILTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjKILTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:19:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7292D5E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:19:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699528775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ARFYRZtJ6JOcPNLZxUHFjYKm8iYuaCTaRJaLSU6X0OU=;
        b=AsQoiKZW+wBQTzPvvHzqHA4iZ6B+zH0uqo/NLzBosq+d6mCkO1lSM9NGw1h9XiHGq3r42h
        1YiE+zIfe5haoE3vXJ6IQfAWob9enS5W2FI+ik0h7AkQlFTkYqs8pPCL+sB7RC6st9y/9J
        uJvqwFhWHUg+YYMG6RPQ+3uwhrj7LH/CFlRlzek6LII1YDP8ACprFyP0L6gqdOK8f0XHla
        dPS8uQ5RUWKiOKSYYVefCqZpA7ZXSNc2PAOa4W5p9H/EPr/RCQSIvWxemXwLiGU682Mjrp
        tmaGBemGjfXZ5geSTkNQ3FDbFNmwvCLan3mVn2UK0h5QK2wAGBtgBujOYEB5Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699528775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ARFYRZtJ6JOcPNLZxUHFjYKm8iYuaCTaRJaLSU6X0OU=;
        b=wcjPJI03vhFC3DvSrk9NFzTiVoVaq5A9h4g1/Pg5f93lbpwGOuqmolJJQ9kVL/PIFYxvV+
        fqz0xFpYFUd7xNAw==
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
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
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [RFC PATCH 54/86] sched: add cond_resched_stall()
In-Reply-To: <20231107215742.363031-55-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-55-ankur.a.arora@oracle.com>
Date:   Thu, 09 Nov 2023 12:19:34 +0100
Message-ID: <87cywjfa2h.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07 2023 at 13:57, Ankur Arora wrote:
> The kernel has a lot of intances of cond_resched() where it is used
> as an alternative to spinning in a tight-loop while waiting to
> retry an operation, or while waiting for a device state to change.
>
> Unfortunately, because the scheduler is unlikely to have an
> interminable supply of runnable tasks on the runqueue, this just
> amounts to spinning in a tight-loop with a cond_resched().
> (When running in a fully preemptible kernel, cond_resched()
> calls are stubbed out so it amounts to even less.)
>
> In sum, cond_resched() in error handling/retry contexts might
> be useful in avoiding softlockup splats, but not very good at
> error handling. Ideally, these should be replaced with some kind
> of timed or event wait.
>
> For now add cond_resched_stall(), which tries to schedule if
> possible, and failing that executes a cpu_relax().

What's the point of this new variant of cond_resched()? We really do not
want it at all. 

> +int __cond_resched_stall(void)
> +{
> +	if (tif_need_resched(RESCHED_eager)) {
> +		__preempt_schedule();

Under the new model TIF_NEED_RESCHED is going to reschedule if the
preemption counter goes to zero.

So the typical

   while (readl(mmio) & BUSY)
   	cpu_relax();

will just be preempted like any other loop, no?

Confused.
