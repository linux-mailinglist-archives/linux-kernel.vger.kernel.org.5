Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66077E51B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjHPPZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344232AbjHPPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:25:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648422D5B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:25:19 -0700 (PDT)
Date:   Wed, 16 Aug 2023 17:25:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692199513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVPM886Qe3x7UJz3Gzy49EbAzA76HOo0JdP62G5H7JY=;
        b=JrwsxYpyF+ZVSMx2ccg38N3b7WUpDzTOx3KGPHZ4CGm37nn7FsXqHTQLJqbMZZtgci9jy5
        PsTJ71dmf4K6w+001BnDd6tI9cDZ+Z1zKMSSGTsDv8YCBd+xze8C5mUjdf7u/6N+ygEOgW
        vHHKQnyFD4RYyZYK1anANigHC4zt4JguafrUH5EH4s4+1zbOr+W9O+bv3OSjJiXs5OWSvP
        PG58iINSQCIXQM4Cpi/O9+aAaArTjjIC0m4QJvjxUF4yw9thhR5uISG0FO/w+zzrgs21mV
        VHXp0lvP66nU6mlbNXr3/PPhceSkQ7YVUAutp6LfElgtoa5C6XJy2Wb5Xi9M6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692199513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVPM886Qe3x7UJz3Gzy49EbAzA76HOo0JdP62G5H7JY=;
        b=Vg1h3nQKhw1dZKkRgmQOgD3F3v/R4bfK4nKhoUGgkLzZjMVtPE/qSBicYI5rKSZEAR+IIS
        73xx9r2RN7+orACQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 0/6] locking/rtmutex: Avoid PI state recursion through
 sched_submit_work()
Message-ID: <20230816152511.J9pAmJzz@linutronix.de>
References: <20230815110121.117752409@infradead.org>
 <20230815161557.GK214207@hirez.programming.kicks-ass.net>
 <20230816085826.zfXjhNmj@linutronix.de>
 <20230816094257.GE980931@hirez.programming.kicks-ass.net>
 <20230816101902.Pz8wdats@linutronix.de>
 <20230816134630.KO12Djeh@linutronix.de>
 <20230816145818.GA989936@hirez.programming.kicks-ass.net>
 <20230816152231.GD982867@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816152231.GD982867@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-16 17:22:31 [+0200], Peter Zijlstra wrote:
> On Wed, Aug 16, 2023 at 04:58:18PM +0200, Peter Zijlstra wrote:
> 
> > I've ended up with the below, but it is quite horrible.. but let me go
> > stare at the futex wreckage before trying to clean things up.
> 
> OK, I think the below covers the simple case, now lets see if I can make
> sense of futex_wait_requeue_pi()... :/
> 
> ---
> --- a/kernel/futex/pi.c
> +++ b/kernel/futex/pi.c
> @@ -1002,6 +1002,12 @@ int futex_lock_pi(u32 __user *uaddr, uns
>  		goto no_block;
>  	}
>  
> +	/*
> +	 * Must be done before we enqueue the waiter, here is unfortunately
> +	 * under the hb lock, but that *should* work.
> +	 */
> +	rt_mutex_pre_schedule();

but this will do sched_submit_work() which you don't need for futex at
all. It should be a nop (as in nothing will happen) but still.

>  	rt_mutex_init_waiter(&rt_waiter);
>  
>  	/*

Sebastian
