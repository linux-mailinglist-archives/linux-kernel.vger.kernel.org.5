Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3977F0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348328AbjHQHAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348333AbjHQG7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:59:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BDB1BE8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 23:59:54 -0700 (PDT)
Date:   Thu, 17 Aug 2023 08:59:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692255592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxW+gDxPMqz0DLwsVHLuGCjK8oTtiezcfKDHXgrXISE=;
        b=BRTuNmzjwHgmFC6/J7c1EpKCZrD/RBtQ42KQysc3tQlIGyH4mu6UGV5XOwdRUR7yEv1sIC
        T47t9kjzONGFuUA914XoxJIIxgyDZwjKCB9jVaxCA7Pn4b43kVHD2up7jJSrfik0xNLkam
        szv0V9tf8RjG4sz1NYUjcH1mZFz0E0YEK0pUVuuczmrXOcqBSs9NNiCIoAGU/D1+27Pw6b
        54aAOEjhgZIkmW1DcqmBPUEvWL2MGRBK9WSHKHFijF5zuf2QQIt+0heBceMoklYr2Oe4Ao
        NSuuipAamO++M621S4BFof/izcbfUQeVustNW8hurPm79KbnrRrw+oB2so7lnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692255592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxW+gDxPMqz0DLwsVHLuGCjK8oTtiezcfKDHXgrXISE=;
        b=DoxYcSN4FwTM1Qws7jsOVSqU74QeKcPdGTk3wKl4GYJgbjmNLDy5RZ5Nbz3Wu4D5qj5s1u
        ICCe8qKic4KjPADw==
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
Message-ID: <20230817065950.yWBqlw4Y@linutronix.de>
References: <20230815110121.117752409@infradead.org>
 <20230815161557.GK214207@hirez.programming.kicks-ass.net>
 <20230816085826.zfXjhNmj@linutronix.de>
 <20230816094257.GE980931@hirez.programming.kicks-ass.net>
 <20230816101902.Pz8wdats@linutronix.de>
 <20230816134630.KO12Djeh@linutronix.de>
 <20230816145818.GA989936@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816145818.GA989936@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-16 16:58:18 [+0200], Peter Zijlstra wrote:
> I've ended up with the below, but it is quite horrible.. but let me go
> stare at the futex wreckage before trying to clean things up.

What about

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index f8a194e7ec9e9..b5e881250fec5 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -241,6 +241,8 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	/* Force readers into slow path */
 	atomic_sub(READER_BIAS, &rwb->readers);
 
+	rt_mutex_pre_schedule();
+
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 	if (__rwbase_write_trylock(rwb))
 		goto out_unlock;
@@ -252,6 +254,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		if (rwbase_signal_pending_state(state, current)) {
 			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
+			rt_mutex_post_schedule();
 			trace_contention_end(rwb, -EINTR);
 			return -EINTR;
 		}
@@ -270,6 +273,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+	rt_mutex_post_schedule();
 	return 0;
 }
 
Sebastian
