Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66853810B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjLMHMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjLMHMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:12:00 -0500
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA78AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:12:05 -0800 (PST)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
        by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4SqmmV0zh0zB0xYh;
        Wed, 13 Dec 2023 15:08:42 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 13 Dec
 2023 15:12:02 +0800
Date:   Wed, 13 Dec 2023 15:12:02 +0800
From:   WangJinchao <wangjinchao@xfusion.com>
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
CC:     <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH v2] sched/fair: merge same code in enqueue_task_fair
Message-ID: <202312131510+0800-wangjinchao@xfusion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.82.147.3]
X-ClientProxiedBy: wuxshcsitd00601.xfusion.com (10.32.135.241) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code below is duplicated in two for loops and need to be
   consolidated

Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
---
 kernel/sched/fair.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..e1373bfd4f2e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6681,30 +6681,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
-		if (se->on_rq)
-			break;
 		cfs_rq = cfs_rq_of(se);
-		enqueue_entity(cfs_rq, se, flags);
-
-		cfs_rq->h_nr_running++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
-
-		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
-
-		flags = ENQUEUE_WAKEUP;
-	}
-
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-
-		update_load_avg(cfs_rq, se, UPDATE_TG);
-		se_update_runnable(se);
-		update_cfs_group(se);
+		if (se->on_rq) {
+			update_load_avg(cfs_rq, se, UPDATE_TG);
+			se_update_runnable(se);
+			update_cfs_group(se);
+		} else {
+			enqueue_entity(cfs_rq, se, flags);
+			flags = ENQUEUE_WAKEUP;
+		}
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
-- 
2.40.0

