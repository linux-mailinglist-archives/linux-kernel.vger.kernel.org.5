Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8077E472
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjHPO7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343924AbjHPO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:58:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321072716
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EWugTsjgiX+Y82aPlA51CFpT0ib2UHYKASCr2LcVtFU=; b=gZ2o4CyqOmDeLUUSWg77OsngBz
        68w1AigYW/U8UYJOBlYH0xRBpaZo6WDdkwALPw8Dj+OjcoRZRAFdO8BmwR8R4edpo+5bC02pvwM/F
        2Dkb3kxSDUa154D3nXqzphloz1hAX9YSnVOFl0D9xu+c0KnvuCxalEWNUNYR+75ZcyOvLdXY/rF1D
        RvYi4/jg3Fbm35LXJpgdUfLV2AJMcutZFjDFDatjVhnSgm4wSZk+tT1fuLMeios0ZmnbWW/NscJ0+
        pCP1uvGJqYzclYW18PnqflnU3bNbqIIqr20nbkAPN2DMzbrmDx9yoPIUuDzzYa32cMWzQIatoB5BM
        LZoxTM7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWHyV-00FIFI-QO; Wed, 16 Aug 2023 14:58:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2C9930020C;
        Wed, 16 Aug 2023 16:58:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98C032C99E0D7; Wed, 16 Aug 2023 16:58:18 +0200 (CEST)
Date:   Wed, 16 Aug 2023 16:58:18 +0200
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
Message-ID: <20230816145818.GA989936@hirez.programming.kicks-ass.net>
References: <20230815110121.117752409@infradead.org>
 <20230815161557.GK214207@hirez.programming.kicks-ass.net>
 <20230816085826.zfXjhNmj@linutronix.de>
 <20230816094257.GE980931@hirez.programming.kicks-ass.net>
 <20230816101902.Pz8wdats@linutronix.de>
 <20230816134630.KO12Djeh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816134630.KO12Djeh@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 03:46:30PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-08-16 12:19:04 [+0200], To Peter Zijlstra wrote:
> > On 2023-08-16 11:42:57 [+0200], Peter Zijlstra wrote:
> > > Not the same -- this is namespace_lock(), right? That's a regular rwsem
> > > afaict and that *should* be good. Clearly I messed something up.
> > 
> > Most likely. I do see it also fom inode_lock() which does down_write().
> > I see it only to originate from rwbase_write_lock().
> 
> I've been looking at what you did and what we had.
> I'm not sure if your additional debug/assert code figured it out or me
> looking at it, but in rwbase_write_lock() for down_write(), we had this
> beauty with a comment that you made go away:
> 
> |        * Take the rtmutex as a first step. For rwsem this will also
> |        * invoke sched_submit_work() to flush IO and workers.
> |	 */
> |         if (rwbase_rtmutex_lock_state(rtm, state))
> 

Yeah, I can't quite remember why I killed that comment, I think because
it was either 'obvious' or confusing at the time. Or perhaps I was too
lazy to type, ... :-)

> for rw_semaphore we don't have any explicit rwbase_sched_submit_work()
> but relied on this one. Now that I look at it again,
> rwbase_rtmutex_lock_state() can succeed in the fast path so we don't
> flush/ invoke rwbase_pre_schedule().
> So you rightfully removed the comment as it was misleading but we do
> need that rwbase_pre_schedule() thingy before
> raw_spin_lock_irqsave(&rtm->wait_lock).

Right, it's both the fast-path and the fact that rt_mutex_slowlock()
will also do post_schedule() and reset the flag.

I've ended up with the below, but it is quite horrible.. but let me go
stare at the futex wreckage before trying to clean things up.

--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -270,6 +270,7 @@ static int __sched rwbase_write_lock(str
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+	rt_mutex_post_schedule();
 	return 0;
 }
 
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1412,8 +1412,30 @@ static inline void __downgrade_write(str
 #define rwbase_restore_current_state()			\
 	__set_current_state(TASK_RUNNING)
 
-#define rwbase_rtmutex_lock_state(rtm, state)		\
-	__rt_mutex_lock(rtm, state)
+/*
+ * Variant of __rt_mutex_lock() that unconditionally does
+ * rt_mutex_pre_schedule() and keeps it on success.
+ */
+static __always_inline int
+rwbase_rtmutex_lock_state(struct rt_mutex_base *lock, unsigned int state)
+{
+	unsigned long flags;
+	int ret;
+
+	rt_mutex_pre_schedule();
+
+	if (likely(rt_mutex_try_acquire(lock)))
+		return 0;
+
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	ret = __rt_mutex_slowlock_locked(lock, NULL, state);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	if (ret)
+		rt_mutex_post_schedule();
+
+	return ret;
+}
 
 #define rwbase_rtmutex_slowlock_locked(rtm, state)	\
 	__rt_mutex_slowlock_locked(rtm, NULL, state)
