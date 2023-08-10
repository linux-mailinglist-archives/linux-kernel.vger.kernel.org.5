Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29477795C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjHJNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHJNQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:16:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3226A2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:16:26 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM6mQ0ZXFzCrLy;
        Thu, 10 Aug 2023 21:12:54 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.118) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 21:16:22 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
CC:     Lu Jialin <lujialin4@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] psi: update psi irqtime when the irq delta is nozero
Date:   Thu, 10 Aug 2023 13:15:14 +0000
Message-ID: <20230810131514.910401-1-lujialin4@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.118]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If update psi irqtime whether the irq delta is zero or not, the performance
will be degradation when update_rq_clock_task works frequently.
Therefore, just update psi irqtime whether the irq delta is nozero.
performace test of times(libmicro):
1) without psi_account_irqtime in update_rq_clock_task
[root@arm64_perf]# ./times  -E -C 200 -L -S -W -N "times" -I 200
Running: times# ./../bin-arm64/times -E -C 200 -L -S -W -N times -I 200
             prc thr   usecs/call      samples   errors cnt/samp
times          1   1      0.45210          188        0      500

2) psi_account_irqtime in update_rq_clock_task
[root@arm64_perf]# ./times  -E -C 200 -L -S -W -N "times" -I 200
Running: times# ./../bin-arm64/times -E -C 200 -L -S -W -N times -I 200
             prc thr   usecs/call      samples   errors cnt/samp
times          1   1      0.49408          196        0      500

3) psi_account_irqtime in update_rq_clock_task when irq delta is nozero
[root@arm64_perf]# ./times  -E -C 200 -L -S -W -N "times" -I 200
Running: times# ./../bin-arm64/times -E -C 200 -L -S -W -N times -I 200
             prc thr   usecs/call      samples   errors cnt/samp
times          1   1      0.45158          195        0      500

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..69c4f229d6d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -722,7 +722,8 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
-	psi_account_irqtime(rq->curr, irq_delta);
+	if (irq_delta)
+		psi_account_irqtime(rq->curr, irq_delta);
 	delayacct_irq(rq->curr, irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
-- 
2.34.1

