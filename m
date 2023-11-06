Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690637E27CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjKFOzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjKFOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:55:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185D9D6F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qvU8Xyqhs1wH5xyO0C4Nf41uT9frHkMXUO274zeOckc=; b=ufN2Auc+tran6e9TEnYUAgvmAz
        WDCMsHESuR0DOIA41SsM+z5VUlKlYDkfbvtbx3V65z2fD4FONWBCZ00Dys31GuTlFyE6kfZ7F17P4
        FGi4ztCotXrJ7E2m5mglMr7hQP90u0pq6AnXFuJejXx/prjG7ob2Qoz4uRYYvbpFdl5pusGJmlyyx
        Y9xzrm+hFqXOeQ33ZAOirnJeuX3oEQj2LSYLfv6EUe1v3n1eBGlOJY9gUF4fTupXbdds+2xCNZIlK
        rhqpaTPCFL+oM9PjXeYENxH5LdjG2bUhVs6qPCJL2f25aNTrrDWtF0cKZGUsI0e/Xjp2rmIWgXAm0
        sYUet1XQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r010Z-006ZR2-5J; Mon, 06 Nov 2023 14:55:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6926B300592; Mon,  6 Nov 2023 15:55:19 +0100 (CET)
Date:   Mon, 6 Nov 2023 15:55:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20231106145519.GG3818@noisy.programming.kicks-ass.net>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 11:59:23AM +0100, Daniel Bristot de Oliveira wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b15f7f376a67..399237cd9f59 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1201,6 +1201,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  		account_group_exec_runtime(curtask, delta_exec);
>  		if (curtask->server)
>  			dl_server_update(curtask->server, delta_exec);
> +		else
> +			dl_server_update(&rq_of(cfs_rq)->fair_server, delta_exec);
>  	}
>  
>  	account_cfs_rq_runtime(cfs_rq, delta_exec);

I've rewritten that something like so..

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1182,12 +1182,13 @@ s64 update_curr_common(struct rq *rq)
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
+	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
 
 	if (unlikely(!curr))
 		return;
 
-	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
+	delta_exec = update_curr_se(rq, curr);
 	if (unlikely(delta_exec <= 0))
 		return;
 
@@ -1195,8 +1196,17 @@ static void update_curr(struct cfs_rq *c
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
-	if (entity_is_task(curr))
-		update_curr_task(task_of(curr), delta_exec);
+	if (entity_is_task(curr)) {
+		struct task_struct *p = task_of(curr);
+		update_curr_task(p, delta_exec);
+		/*
+		 * Any fair task that runs outside of fair_server should
+		 * account against fair_server such that it can account for
+		 * this time and possible avoid running this period.
+		 */
+		if (p->dl_server != &rq->fair_server)
+			dl_server_update(&rq->fair_server, delta_exec);
+	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
