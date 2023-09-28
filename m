Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22FA7B1B56
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjI1Lm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjI1Lm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:42:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254E12A;
        Thu, 28 Sep 2023 04:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WcO5WAWfIvtIzSTbpV7mnsw65K9q7xXITWSXV5ekIVM=; b=aPI+3IIWiUEXyqacWz8LNwQTdU
        jiU0KgpCQUeiv7akl8jtSSWydjexHGvtulP95OwDnIvJfjCjgQ3aH4wUVPElwj+OG9Py2bpITakQN
        A96RCZTiTAml39rM5NmfLOnCNIiV9wQrNY6pVSKID+cRiTJDRdkNBADNmzV++Ufd/hFH/DKGKR+Oc
        IRBGMF5LT23yrXPoVN1SgY2pDyWGfKcdhvhXaXp3Qfhnxyax/qxmCKHkMZbgJHP+N4Sy6ua0jz+kb
        kP3EYJ8W4pI3xgP4zqV2cVEKNO5CH8QS6gFH5j4nwaQRiEDpjzoWt+fy4B2WyfP/uWNlZyW797jsB
        2Bn6Umpw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlpP6-002Gl2-DU; Thu, 28 Sep 2023 11:42:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 197BE3002E3; Thu, 28 Sep 2023 13:42:00 +0200 (CEST)
Date:   Thu, 28 Sep 2023 13:41:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Igor Raits <igor.raits@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] sched/core: Fix wrong warning check in
 rq_clock_start_loop_update()
Message-ID: <20230928114159.GJ9829@noisy.programming.kicks-ass.net>
References: <20230913082424.73252-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913082424.73252-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:24:24PM +0800, Hao Jia wrote:
> Igor Raits and Bagas Sanjaya report a RQCF_ACT_SKIP leak warning.
> Link: https://lore.kernel.org/all/a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com
> 
> Commit ebb83d84e49b54 ("sched/core: Avoid multiple
> calling update_rq_clock() in __cfsb_csd_unthrottle()")
> add RQCF_ACT_SKIP leak warning in rq_clock_start_loop_update().
> But this warning is inaccurate and may be triggered
> incorrectly in the following situations:
> 
>     CPU0                                      CPU1
> 
> __schedule()
>   *rq->clock_update_flags <<= 1;*   unregister_fair_sched_group()
>   pick_next_task_fair+0x4a/0x410      destroy_cfs_bandwidth()
>     newidle_balance+0x115/0x3e0       for_each_possible_cpu(i) *i=0*
>       rq_unpin_lock(this_rq, rf)      __cfsb_csd_unthrottle()
	  if (rq->clock_update_flags > RQCF_ACT_SKIP)
	    rf->clock_update_flags = RQCF_UPDATED;

so that preserves all flags, but only stores UPDATED.

>       raw_spin_rq_unlock(this_rq)
>                                       rq_lock(*CPU0_rq*, &rf)
					  rq_pin_lock()
					    rq->clock_update_flags &= (REQ_SKIP|ACT_SKIP);
					    rf->clock_update_flags = 0;

				IOW, we preserve ACT_SKIP from CPU0

>                                       rq_clock_start_loop_update()
>                                       rq->clock_update_flags & RQCF_ACT_SKIP <--

				And go SPLAT

> 
>       raw_spin_rq_lock(this_rq)
	rq_repin_lock()
	  rq->clock_update_flags |= rf->clock_update_flags;

which restores UPDATED, even though in reality time could have moved on
quite significantly.


Anyway....

the purpose of ACT_SKIP is to skip the update (clue in name etc), but
the update is very early in __schedule(), but we clear *_SKIP very late,
causing it to span that gap above.

Going by the commits that put it there, the thinking was to clear
clock_skip_update before unlock, but AFAICT we can clear SKIP flags
right after the update_rq_clock() we're wanting to skip, no?

That is, would not something like the below make more sense?

---

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d8fd29d66b24..bfd2ab4b95da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5357,8 +5357,6 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	/* switch_mm_cid() requires the memory barriers above. */
 	switch_mm_cid(rq, prev, next);
 
-	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-
 	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
@@ -6596,6 +6594,8 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
+	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
+
 
 	switch_count = &prev->nivcsw;
 
@@ -6675,8 +6675,6 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
-		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-
 		rq_unpin_lock(rq, &rf);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
