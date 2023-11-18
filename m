Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D82A7EFDC3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 05:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjKREi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 23:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKREiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 23:38:55 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD6D6D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 20:38:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VwbPiW6_1700282322;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VwbPiW6_1700282322)
          by smtp.aliyun-inc.com;
          Sat, 18 Nov 2023 12:38:49 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/core: fix incorrect cpustat[CPUTIME_FORCEIDLE] update
Date:   Sat, 18 Nov 2023 12:38:42 +0800
Message-Id: <20231118043842.45047-1-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function __account_forceidle_time(), task_group_account_field()
is called to update kernel_cpustat.cpustat[CPUTIME_FORCEIDLE].
However, p may be not running on current cpu, so update cpustat with
this_cpu_add() is incorrect.

To fix this problem, we get the cpu of p first, and then add delta
to kcpustat_cpu(cpu).cpustat[CPUTIME_FORCEIDLE].

Fixes: 1fcf54deb767 ("sched/core: add forced idle accounting for cgroups")
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/cputime.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..843d6cabae59 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -239,9 +239,12 @@ void account_idle_time(u64 cputime)
  */
 void __account_forceidle_time(struct task_struct *p, u64 delta)
 {
+	unsigned int cpu = task_cpu(p);
+
 	__schedstat_add(p->stats.core_forceidle_sum, delta);
 
-	task_group_account_field(p, CPUTIME_FORCEIDLE, delta);
+	kcpustat_cpu(cpu).cpustat[CPUTIME_FORCEIDLE] += delta;
+	cgroup_account_cputime_field(p, CPUTIME_FORCEIDLE, tmp);
 }
 #endif
 
-- 
2.39.3

