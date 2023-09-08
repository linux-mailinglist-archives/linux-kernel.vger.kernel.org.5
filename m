Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC7798309
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbjIHHDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIHHDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:03:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40F19AE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OBdRHJoBOdRBmpkz3CHE5Xr6dbxZh4HXbEKIfYchIfM=; b=Kz8rV8SKEx06y+xokcoYvZ5mIB
        TQsI6pDuUzgtTPSCrKwFzstFgm7u6wZMtj/ZfWF4o1mb8v5cva3Co3CajSwjZwWwA3v77CrZDJq6K
        mmqfkAcY0FAd1OyNR/LbYGjsRBFaCDTblv8tpEtm7a2Fta/cbhc1HWCPAEV8YTpIhdoYjKtzFJQYW
        p1IMhRNZY7MQFr1i12uZh+/+eLs+eo5lus7T40U8gigcC2ws8RqPnCsbjh+Y4dLLfUALWqsNDLdGg
        OlIyxMkXzpvt0s+SfZHEe0oWUwV7jWaLfOBinBx2+X/LQxwCHwvNBwHOZlX7+02I5hQ4VG5ANZzRm
        SlRvsfgQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeVW6-00GFvS-UW; Fri, 08 Sep 2023 07:02:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 978B9300472; Fri,  8 Sep 2023 09:02:58 +0200 (CEST)
Date:   Fri, 8 Sep 2023 09:02:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230908070258.GA19320@noisy.programming.kicks-ass.net>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:49:56AM -0700, Ankur Arora wrote:

> +#ifdef TIF_RESCHED_ALLOW
> +/*
> + * allow_resched() .. disallow_resched() demarcate a preemptible section.
> + *
> + * Used around primitives where it might not be convenient to periodically
> + * call cond_resched().
> + */
> +static inline void allow_resched(void)
> +{
> +	might_sleep();
> +	set_tsk_thread_flag(current, TIF_RESCHED_ALLOW);

So the might_sleep() ensures we're not currently having preemption
disabled; but there's nothing that ensures we don't do stupid things
like:

	allow_resched();
	spin_lock();
	...
	spin_unlock();
	disallow_resched();

Which on a PREEMPT_COUNT=n build will cause preemption while holding the
spinlock. I think something like the below will cause sufficient
warnings to avoid growing patterns like that.


Index: linux-2.6/kernel/sched/core.c
===================================================================
--- linux-2.6.orig/kernel/sched/core.c
+++ linux-2.6/kernel/sched/core.c
@@ -5834,6 +5834,13 @@ void preempt_count_add(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
+	 * Disabling preemption under TIF_RESCHED_ALLOW doesn't
+	 * work for PREEMPT_COUNT=n builds.
+	 */
+	if (WARN_ON(resched_allowed()))
+		return;
+
+	/*
 	 * Underflow?
 	 */
 	if (DEBUG_LOCKS_WARN_ON((preempt_count() < 0)))

