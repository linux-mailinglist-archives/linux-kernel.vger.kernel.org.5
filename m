Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30162776A7A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjHIUoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjHIUnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:43:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEAC10C0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=y0wgwpukS8T7O340+NKvU9chnTVlAmLcht1jdurq5Ss=; b=G1CW/e9Wi6y62GmD26ak0BAhVB
        TtuEpfLi5R8hXAcY3CZagxTz0yIt1MUOBr80dPH19ehINa5ipQ00Txct/aQcAyI+A9NRmfgR1nTc8
        BgHMzqnRRJ7sLZH5mZeDpLZqchmttLUaevRvg4BHp7UlaMGeHoSlLTICEX5lrvQlun7gew63Tle+I
        ue/w3zHNNPe3jRe6bBn9zbA0vQjH38cwUzmfIgCqj4HrKY0nSGkWei0Otfjt+wEzOZw4l2r/+b7zl
        iADvYWSGBP4ROH3sR3Y4dv7GvUOHN8tgGeiQJ3GojxvIMpnWfoxmKslvt3XUOe4eTHAzvdZJgdyCW
        p+UGkKlw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTq1n-008LNA-He; Wed, 09 Aug 2023 20:43:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1420E300703;
        Wed,  9 Aug 2023 22:43:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6568B206EC338; Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Message-ID: <20230809204200.445269001@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 22:24:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] sched: Simplify sched_move_task()
References: <20230809202440.012625269@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10361,17 +10361,18 @@ void sched_move_task(struct task_struct
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct task_group *group;
-	struct rq_flags rf;
 	struct rq *rq;
 
-	rq = task_rq_lock(tsk, &rf);
+	CLASS(task_rq_lock, rq_guard)(tsk);
+	rq = rq_guard.rq;
+
 	/*
 	 * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
 	 * group changes.
 	 */
 	group = sched_get_task_group(tsk);
 	if (group == tsk->sched_task_group)
-		goto unlock;
+		return;
 
 	update_rq_clock(rq);
 
@@ -10396,9 +10397,6 @@ void sched_move_task(struct task_struct
 		 */
 		resched_curr(rq);
 	}
-
-unlock:
-	task_rq_unlock(rq, tsk, &rf);
 }
 
 static inline struct task_group *css_tg(struct cgroup_subsys_state *css)


