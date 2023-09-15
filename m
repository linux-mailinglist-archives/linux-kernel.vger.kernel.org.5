Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0A87A1F98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjIONPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjIONPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:15:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235CD211E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:15:18 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694783716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ws037AXqflD0ML393QGbwfyMtfZkuly5mYeYMdFEVF0=;
        b=NRUuLfHwu/D/tBLkHJI++tgzjLUVOOM/qAkY0pwYxvkBrfHPUmVBptU5W0wn/UmAFc9bEf
        EN0jofwJgfZedqVQhRIbAXX17Iqqtl+fK+YDvGCA5tMaNIhnXfrhhrfuxfZCGpCU2hPIV1
        rrCi7sB3Id8tRi5odvTqaeIkGKZdxDRfgZcxRCMA18RGfEin+GC8w3SQPeqF2EW+rUmrG2
        aeVtS3PT6qN59dfX/Z68zeMOZ57D9nGcYa1zd+VXrUCbJea+XzKBsjF/tbajhasWvwpDQI
        TK7+FUbNgcX58co/NRcck3Zx4x8YsQeRjs9D3Lg/Y6hw/67Ww36OMIkXIr6tsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694783716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ws037AXqflD0ML393QGbwfyMtfZkuly5mYeYMdFEVF0=;
        b=47d1MMpri+DnXt2pawAZ4ltkpoyWUwmCanL5D5/hb4FLf9E2srVKT15aTHC1Tq2XhYY8dT
        nh4iRKg7E9TgwlAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20230915131511.mLtx-ZMT@linutronix.de>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <87fs3f1tl0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fs3f1tl0.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-15 14:58:35 [+0200], Thomas Gleixner wrote:
> > +		 * is leaving and the uncontended path is safe to take.
> > +		 */
> > +		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
> > +		if (!rt_waiter)
> > +			goto do_uncontended;
> 
> Leaks pi_mutex.wait_lock

and pi_state. 

> Plus you need:
> 
> diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
> index cba8b1a6a4cc..af1427689414 100644
> --- a/kernel/futex/requeue.c
> +++ b/kernel/futex/requeue.c
> @@ -850,11 +850,11 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
>  		pi_mutex = &q.pi_state->pi_mutex;
>  		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
>  
> -		/* Current is not longer pi_blocked_on */
> -		spin_lock(q.lock_ptr);
> +		/* Add a proper comment */
>  		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
>  			ret = 0;
>  
> +		spin_lock(q.lock_ptr);
>  		debug_rt_mutex_free_waiter(&rt_waiter);
>  		/*
>  		 * Fixup the pi_state owner and possibly acquire the lock if we

Yes, if we do this.

> 
> I spent quite some time to convince myself that this is correct. I was
> not able to poke a hole into it. So that really should be safe to
> do. Famous last words ...

Okay. Then let me collect the pieces and post a new round then.

> Thanks,
> 
>         tglx

Sebastian
