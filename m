Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137CE781DDC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 14:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjHTMxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 08:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjHTMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 08:53:28 -0400
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E55D4EF8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 05:53:24 -0700 (PDT)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4RTFqZ20qyz9v7ck;
        Sun, 20 Aug 2023 20:51:54 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 20 Aug
 2023 20:53:18 +0800
Date:   Sun, 20 Aug 2023 20:53:17 +0800
From:   Wang Jinchao <wangjinchao@xfusion.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <stone.xulei@xfusion.com>
Subject: [PATCH] sched/core: Refactor task_flags check for worker sleeping
Message-ID: <ZOIMvURE99ZRAYEj@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00601.xfusion.com (10.32.135.241) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the conditional logic for checking worker flags
by splitting the original compound `if` statement into
separate `if` and `else if` clauses. This modification not
only retains the previous functionality but also reduces a
single `if` check, improving code clarity and potentially
enhancing performance.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 kernel/sched/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..9621ee979b0b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6745,12 +6745,10 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * If a worker goes to sleep, notify and ask workqueue whether it
 	 * wants to wake up a task to maintain concurrency.
 	 */
-	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
-		if (task_flags & PF_WQ_WORKER)
-			wq_worker_sleeping(tsk);
-		else
-			io_wq_worker_sleeping(tsk);
-	}
+	if (task_flags & PF_WQ_WORKER)
+		wq_worker_sleeping(tsk);
+	else if (task_flags & PF_IO_WORKER)
+		io_wq_worker_sleeping(tsk);
 
 	/*
 	 * spinlock and rwlock must not flush block requests.  This will
-- 
2.40.0

