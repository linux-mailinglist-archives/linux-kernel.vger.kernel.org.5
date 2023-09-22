Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61C77AA69A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjIVBk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIVBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:40:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AA0E8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:40:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c07ca1b44so23280317b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695346849; x=1695951649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IaJ0E6dYO97vx8l4rgkUr4paQrUz4gH2WWfMfHShIIo=;
        b=jllCmc8dO/Zqs5+PsljVyMFXnVHxo3XrXiIurh+he/HCmlBlEBTdLmthuwSUwBmmBh
         H5IkPbszIQbv5PwT0d4OIqpJ8WHo9W6unkDbJ6P/A04/5isMHEA2AnNALvlk2ujV322/
         AgSFifJ+5MS0XDMATw8yE4NVCGpnHfpf78JDPbX67QhGVmQpdrG57pVfzEF3do/JMOjx
         yOKQwa1wJzKLMP+v5VNASYwc/MaLayrb8+7KDqmuRXal9iQejPDwUhDRqsmU33ocn991
         ORW/v48xyAVFiw2PTDb5HrZKIxVTWXYH2Ue7qPWObwXb8ULcHbuXKJCaL/eJeQy2ahmf
         FmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695346849; x=1695951649;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IaJ0E6dYO97vx8l4rgkUr4paQrUz4gH2WWfMfHShIIo=;
        b=OH7YyCz9KOqJdtfe1vV12OSB72MOg5tlBdXVGPpEUXKft0zu3NiZFuX7aIqaeX4RGB
         P4iCw6O70pjEOtq3PVMsMmoMsnIA+sVbldxvXDmGUyhnXyvFAHLH8miANybPCfwPCuRe
         LQ10HrpT9EXNgckGApFRUFKXjx1M/TLNL3wYaG7kI/AFDZhjE5rxuSI76k9nHJWn9TgV
         rRivhC8w3eHHsVLplstExdewxtIxmDnN8Px9Cmu7tmy5yIBcywfNBkNkxk0N9ocOrfIk
         5DyGkkNp5BPWell3EF4Kgc/DhDo7Q46McYJdkoeMCwda2NQNBexF8DcGDQaP6UeKVJrh
         LfSg==
X-Gm-Message-State: AOJu0Yytps5m9TOA0ZQ9Lqo+FvdKUkLW+ohrurlqKWKm/MaQXJDToYYr
        Tw9xJ6M5Vd25KZDvXrDsR/+OX0fvxOCV
X-Google-Smtp-Source: AGHT+IH7VFr1cKctb5cxPoppK93lwdxEHFNvD2AzuIR4XAEnR8hyr+vVBC+lR3XDA02kfA+RNe2I2Tf4kU0k
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2a3:200:fba6:21f7:70ce:4c75])
 (user=joshdon job=sendgmr) by 2002:a81:ae57:0:b0:59b:ee27:bbe9 with SMTP id
 g23-20020a81ae57000000b0059bee27bbe9mr95784ywk.9.1695346849175; Thu, 21 Sep
 2023 18:40:49 -0700 (PDT)
Date:   Thu, 21 Sep 2023 18:37:50 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922013750.874131-1-joshdon@google.com>
Subject: [PATCH v2] sched: fix warning in bandwidth distribution
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've observed the following warning being hit in
distribute_cfs_runtime():
	SCHED_WARN_ON(cfs_rq->runtime_remaining > 0)

We have the following race:

- cpu0: running bandwidth distribution (distribute_cfs_runtime).
  Inspects the local cfs_rq and makes its runtime_remaining positive.
  However, we defer unthrottling the local cfs_rq until after
  considering all remote cfs_rq's.
- cpu1: starts running bandwidth distribution from the slack timer. When
  it finds the cfs_rq for cpu 0 on the throttled list, it observers the
  that the cfs_rq is throttled, yet is not on the CSD list, and has a
  positive runtime_remaining, thus triggering the warning in
  distribute_cfs_runtime.

To fix this, we can rework the local unthrottling logic to put the local
cfs_rq on a local list, so that any future bandwidth distributions will
realize that the cfs_rq is about to be unthrottled.

Signed-off-by: Josh Don <joshdon@google.com>
---
v2: Fix build error on !CONFIG_SMP

 kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 384900bf87eb..3d1886ea18fe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5743,13 +5743,16 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 
 static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 {
-	struct cfs_rq *local_unthrottle = NULL;
 	int this_cpu = smp_processor_id();
 	u64 runtime, remaining = 1;
 	bool throttled = false;
 	struct cfs_rq *cfs_rq;
 	struct rq_flags rf;
 	struct rq *rq;
+#ifdef CONFIG_SMP
+	struct cfs_rq *tmp;
+	LIST_HEAD(local_unthrottle);
+#endif
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
@@ -5786,11 +5789,21 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
 		/* we check whether we're throttled above */
 		if (cfs_rq->runtime_remaining > 0) {
-			if (cpu_of(rq) != this_cpu ||
-			    SCHED_WARN_ON(local_unthrottle))
+#ifdef CONFIG_SMP
+			if (cpu_of(rq) != this_cpu) {
 				unthrottle_cfs_rq_async(cfs_rq);
-			else
-				local_unthrottle = cfs_rq;
+			} else {
+				/*
+				 * We currently only expect to be unthrottling
+				 * a single cfs_rq locally.
+				 */
+				SCHED_WARN_ON(!list_empty(&local_unthrottle));
+				list_add_tail(&cfs_rq->throttled_csd_list,
+					      &local_unthrottle);
+			}
+#else
+			unthrottle_cfs_rq_async(cfs_rq);
+#endif
 		} else {
 			throttled = true;
 		}
@@ -5798,15 +5811,25 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 next:
 		rq_unlock_irqrestore(rq, &rf);
 	}
-	rcu_read_unlock();
 
-	if (local_unthrottle) {
-		rq = cpu_rq(this_cpu);
+#ifdef CONFIG_SMP
+	list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
+				 throttled_csd_list) {
+		struct rq *rq = rq_of(cfs_rq);
+
 		rq_lock_irqsave(rq, &rf);
-		if (cfs_rq_throttled(local_unthrottle))
-			unthrottle_cfs_rq(local_unthrottle);
+
+		list_del_init(&cfs_rq->throttled_csd_list);
+
+		if (cfs_rq_throttled(cfs_rq))
+			unthrottle_cfs_rq(cfs_rq);
+
 		rq_unlock_irqrestore(rq, &rf);
 	}
+	SCHED_WARN_ON(!list_empty(&local_unthrottle));
+#endif
+
+	rcu_read_unlock();
 
 	return throttled;
 }
-- 
2.42.0.515.g380fc7ccd1-goog

