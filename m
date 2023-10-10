Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C6A7BFE84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjJJNyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjJJNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:54:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F39D;
        Tue, 10 Oct 2023 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Q2326nbgNVkzW/VEHSwQCD8IL326flLiX2/oxCqN0g=; b=vwbk4OYTkj+i5hVlzwFJfLP7V8
        4Wca/Me2pvYsVPi5UmFxhBkFS2Rli0Hl4cs3XiY/gVPYh2aix9MnSTDlNIJ1ZNSSubRiUeGiKI4Fd
        2uCUvvOpNsOvFMl5ogtHz4C5x1aZ6HSBk5DICSeyAwynTDnoBUftyKtkB6W5p0mFppUxUnSzIN/1N
        +pgD6/DpPlv1Y08Yrn8y+1qnByWbjf0VmLnW6qiy82RHDXOmZg9dgpk7g6xYtBRVi87Hlz0lzSSye
        8BZOoxEinlmAC2yhdWhncDkg+yQ+sAAalCckfYRhlMdHLmcSgsGAdJ0NETgV1px/iZcwY7oOnzzUQ
        wnfhJOkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqDB6-004xnI-KK; Tue, 10 Oct 2023 13:53:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E225300392; Tue, 10 Oct 2023 15:53:40 +0200 (CEST)
Date:   Tue, 10 Oct 2023 15:53:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Igor Raits <igor.raits@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [External] Re: [PATCH] sched/core: Fix wrong warning check in
 rq_clock_start_loop_update()
Message-ID: <20231010135340.GK377@noisy.programming.kicks-ass.net>
References: <20230913082424.73252-1-jiahao.os@bytedance.com>
 <20230928114159.GJ9829@noisy.programming.kicks-ass.net>
 <979f948c-7611-b137-a06a-ca09ff63f919@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979f948c-7611-b137-a06a-ca09ff63f919@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 04:44:46PM +0800, Hao Jia wrote:

> > That is, would not something like the below make more sense?
> 
> If we understand correctly, this may not work.
> 
> After applying this patch, the following situation will trigger the
> rq->clock_update_flags < RQCF_ACT_SKIP warning.
> 
> If rq_clock_skip_update() is called before __schedule(), so RQCF_REQ_SKIP of
> rq->clock_update_flags is set.
> 
> 
> 
> 
> __schedule() {
> 	rq_lock(rq, &rf); [rq->clock_update_flags is RQCF_REQ_SKIP]
> 	rq->clock_update_flags <<= 1;
> 	update_rq_clock(rq); [rq->clock_update_flags is RQCF_ACT_SKIP]
> + 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
> 	* At this time, rq->clock_update_flags = 0; *

Fixed easily enough, just change to:

	rq->clock_updated_flags = RQCF_UPDATED;

> 
>          pick_next_task_fair
>          set_next_entity
>          update_load_avg
>          	assert_clock_updated() <---
> }

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a0a582c8cf8c..cf9eb1a26c22 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5357,8 +5357,6 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	/* switch_mm_cid() requires the memory barriers above. */
 	switch_mm_cid(rq, prev, next);
 
-	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-
 	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
@@ -6596,6 +6594,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
+	rq->clock_update_flags = RQCF_UPDATED;
 
 	switch_count = &prev->nivcsw;
 
@@ -6675,8 +6674,6 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
-		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
