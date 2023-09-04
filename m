Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9B7791442
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbjIDJEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIDJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:03:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02648BD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:03:55 -0700 (PDT)
Date:   Mon, 4 Sep 2023 11:03:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693818234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t/9WiSx1PiuSmLL7AyYYygzZg1OO8ggCrfeO0RXhYPQ=;
        b=t+Us5dhrZW1J9GNOtbRkDFZD3bjDyh91pfIXIEciMzJ1k8rnYbDYpEJ7b7IG8hRLZeFZCr
        5/ZttuWo34R6Ekig1YKuisvPgp8E2OH5Sp18fXPO+vcGvARh4WQsxkEHJFcx5RFyfVByCO
        5UTjjLz1BlWTh3i8uNqkQoffGcHoNuaKBD4+D5vetzJWbeNKrURbpNaCTHkqltRzIB+mpF
        /dRCuQAdSY8tQdfvtNYwvBWzVYiaiVwQasjpIXldu1J0boM2rsUKPTwIYS34AD4/eLoPXg
        9vuDE9Fl18fHtNKTyGnBa8WQWW2F3nyGdEyAAP0QJ/MEv3qfyW2zXfL45BR6zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693818234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t/9WiSx1PiuSmLL7AyYYygzZg1OO8ggCrfeO0RXhYPQ=;
        b=06OGb7npvNK21oiuBdTxSOi+94wErcOTZKbeuFDQQi5hdlPkM33nlSPHYIFmlxfW0uiOrA
        OuLEiDDfpIjSvwDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, jstultz@google.com,
        juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
        mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH v2 5/6] locking/rtmutex: Use rt_mutex specific scheduler
 helpers
Message-ID: <20230904090351.IGC2BcN0@linutronix.de>
References: <20230825181033.504534-1-bigeasy@linutronix.de>
 <20230825181033.504534-6-bigeasy@linutronix.de>
 <ZPTWcThhRyCktBqA@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPTWcThhRyCktBqA@sultan-box.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-03 11:54:41 [-0700], Sultan Alsawaf wrote:
> On Fri, Aug 25, 2023 at 08:10:32PM +0200, Sebastian Andrzej Siewior wrote:
> > --- a/kernel/locking/rwbase_rt.c
> > +++ b/kernel/locking/rwbase_rt.c
> > @@ -71,6 +71,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
> >  	struct rt_mutex_base *rtm = &rwb->rtmutex;
> >  	int ret;
> >  
> > +	rwbase_pre_schedule();
> >  	raw_spin_lock_irq(&rtm->wait_lock);
> >  
> >  	/*
> > @@ -125,6 +126,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
> >  		rwbase_rtmutex_unlock(rtm);
> >  
> >  	trace_contention_end(rwb, ret);
> > +	rwbase_post_schedule();
> >  	return ret;
> >  }
> >  
> > @@ -237,6 +239,8 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> >  	/* Force readers into slow path */
> >  	atomic_sub(READER_BIAS, &rwb->readers);
> >  
> > +	rt_mutex_pre_schedule();
> > +
> >  	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> >  	if (__rwbase_write_trylock(rwb))
> >  		goto out_unlock;
> > @@ -248,6 +252,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> >  		if (rwbase_signal_pending_state(state, current)) {
> >  			rwbase_restore_current_state();
> >  			__rwbase_write_unlock(rwb, 0, flags);
> > +			rt_mutex_post_schedule();
> >  			trace_contention_end(rwb, -EINTR);
> >  			return -EINTR;
> >  		}
> > @@ -266,6 +271,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> >  
> >  out_unlock:
> >  	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> > +	rt_mutex_post_schedule();
> >  	return 0;
> >  }
> 
> Shouldn't rwbase_write_lock() use rwbase_{pre|post}_schedule()?
> 
> With this change as-is, I observe deadlocks due to lock recursion from
> write_lock() specifically, because write_lock() ends up flushing block requests.

You are right, it should have been rwbase_{pre|post}_schedule() because
write_lock() is a spinning lock and should not flush the block requests.
Thanks for spotting this.

> Sultan

Sebastian
