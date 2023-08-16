Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2507477E509
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbjHPPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbjHPPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:22:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3FE1BF8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HjOw2FdgXFmbhO+aMb+cZ+8tSDi/d/ouknBH++Hh0Fw=; b=DhBfBfgKBP2FUewtIp2kTOz9M7
        pBOi/UzXQqBXrtmsLht4U0zxs7zl2n9e6rncttH1h/ykZXF2xNViPsJwFia21YdHFhLRur/wqf5bU
        pFOgcuugk+xxM2+ugay0Fn0oxcMN9gKB0MXLrH3W+nF0DuNbgyVzeqVkRybq7kitceAC+2WGuKwKW
        PDZkTPjmN06z3ht9BI09/P6JEHr7x1lznMRwMfPxvFaVYQMx8XZP5IYbrVRpQPROZ53usnxfnM60A
        mkuKmElH94re7ZUt7MWt/7gAdhv7TseMllMHzAJC7MhpwhUOY/OR7sm5UoDBAatlxJ4TIvA2EM4Sq
        yOtthavA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWILw-00FNuL-6m; Wed, 16 Aug 2023 15:22:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C133300222;
        Wed, 16 Aug 2023 17:22:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CD7521025978; Wed, 16 Aug 2023 17:22:31 +0200 (CEST)
Date:   Wed, 16 Aug 2023 17:22:31 +0200
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
Message-ID: <20230816152231.GD982867@hirez.programming.kicks-ass.net>
References: <20230815110121.117752409@infradead.org>
 <20230815161557.GK214207@hirez.programming.kicks-ass.net>
 <20230816085826.zfXjhNmj@linutronix.de>
 <20230816094257.GE980931@hirez.programming.kicks-ass.net>
 <20230816101902.Pz8wdats@linutronix.de>
 <20230816134630.KO12Djeh@linutronix.de>
 <20230816145818.GA989936@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816145818.GA989936@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 04:58:18PM +0200, Peter Zijlstra wrote:

> I've ended up with the below, but it is quite horrible.. but let me go
> stare at the futex wreckage before trying to clean things up.

OK, I think the below covers the simple case, now lets see if I can make
sense of futex_wait_requeue_pi()... :/

---
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1002,6 +1002,12 @@ int futex_lock_pi(u32 __user *uaddr, uns
 		goto no_block;
 	}
 
+	/*
+	 * Must be done before we enqueue the waiter, here is unfortunately
+	 * under the hb lock, but that *should* work.
+	 */
+	rt_mutex_pre_schedule();
+
 	rt_mutex_init_waiter(&rt_waiter);
 
 	/*
@@ -1052,6 +1058,10 @@ int futex_lock_pi(u32 __user *uaddr, uns
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
 		ret = 0;
 
+	/*
+	 * Waiter is unqueued.
+	 */
+	rt_mutex_post_schedule();
 no_block:
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
