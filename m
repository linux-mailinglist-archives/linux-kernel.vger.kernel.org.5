Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5E77F20E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348874AbjHQI04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348928AbjHQI0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:26:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF252D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lpifKDNfNsjXFi7rqljZ8oYIHrqoai0CKoqISv9FVD8=; b=eHU9N1162rWS9hQb47I9N3eZfn
        KCkEaxeQFBdjSf7T9U4D7AMMjLJvfQPai0FeREvq7MnUIVd2Q83ZDsoUeigCRCnmPiyih2pRuIxv9
        06z9o07WjY98dYRixbnKnmpvq47ai4wAfeNlp9NcMmBb/X/SvF4oLNXLRNaGJaGvHS6wI6tH3r/g5
        q5mpmyWTCO3qQrEPMb6INQW05+dDpQe+B6AMMn3ienNTqKy1aIW9Hf32KmoYEtB6DbN9fPl945ix1
        ALpXMYS4QhNvcasyumqfsxsaIR9iN2XUG+kN8yB7CWsgO4MTP14TG9JKwsOjmC29AgEdEQXUY8281
        D+GDa3RA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWYKv-002CrR-BK; Thu, 17 Aug 2023 08:26:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63C133001FD;
        Thu, 17 Aug 2023 10:26:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22707207F09A9; Thu, 17 Aug 2023 10:26:32 +0200 (CEST)
Date:   Thu, 17 Aug 2023 10:26:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 0/6] locking/rtmutex: Avoid PI state recursion through
 sched_submit_work()
Message-ID: <20230817082632.GA1006598@hirez.programming.kicks-ass.net>
References: <20230815110121.117752409@infradead.org>
 <20230815161557.GK214207@hirez.programming.kicks-ass.net>
 <20230816085826.zfXjhNmj@linutronix.de>
 <20230816094257.GE980931@hirez.programming.kicks-ass.net>
 <20230816101902.Pz8wdats@linutronix.de>
 <20230816134630.KO12Djeh@linutronix.de>
 <20230816145818.GA989936@hirez.programming.kicks-ass.net>
 <20230817065950.yWBqlw4Y@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817065950.yWBqlw4Y@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 08:59:50AM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-08-16 16:58:18 [+0200], Peter Zijlstra wrote:
> > I've ended up with the below, but it is quite horrible.. but let me go
> > stare at the futex wreckage before trying to clean things up.
> 
> What about

Ah, of course, that's much nicer. I got hung up on that
rwbase_rtmutex_lock_state() thing :/

> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> index f8a194e7ec9e9..b5e881250fec5 100644
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -241,6 +241,8 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  	/* Force readers into slow path */
>  	atomic_sub(READER_BIAS, &rwb->readers);
>  
> +	rt_mutex_pre_schedule();
> +
>  	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
>  	if (__rwbase_write_trylock(rwb))
>  		goto out_unlock;
> @@ -252,6 +254,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  		if (rwbase_signal_pending_state(state, current)) {
>  			rwbase_restore_current_state();
>  			__rwbase_write_unlock(rwb, 0, flags);
> +			rt_mutex_post_schedule();
>  			trace_contention_end(rwb, -EINTR);
>  			return -EINTR;
>  		}
> @@ -270,6 +273,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  
>  out_unlock:
>  	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> +	rt_mutex_post_schedule();
>  	return 0;
>  }
>  
> Sebastian
