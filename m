Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE23B7ABC27
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 01:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjIVXGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 19:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjIVXGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 19:06:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95552198
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:06:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85fc6261ffso3182753276.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695423968; x=1696028768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmlqYz9WKUrhwswwMcsvKjyR0oZwkHXZs3sw/VMeqy4=;
        b=XC40TihlJLHaKjpTuUsz/63rJMIPQUORV/d7F0v7hvpNxUJAFi+3G5SfOk/xcVrgDk
         ZZ1yp8PIk5fotfkSFY1G/z1fbYzDCiLbqz/4x9xUznBqe5lqTl9WSxj+K0B0Nzy1In9b
         al5BSPVJ8CpoiQn5V8iwKp8K7cOrqO4ByrIoEbTTIFRdvRM+1s7ZMY8ceix03JbQLsZC
         OBRX25t3gBhtGv3G0Z8V6VpBhQLSqfXhb4xwISaSb/Q6A1jY2uSDcVjHR8y92OL3x/5E
         zJArcVMmqw6aZd9r0bSe7X2YDAkl5tKItRXho9zJmN45NVc86QIq7POwiAEMbV+fvzYe
         Uoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695423968; x=1696028768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmlqYz9WKUrhwswwMcsvKjyR0oZwkHXZs3sw/VMeqy4=;
        b=gEqrvApKYU7NKhZrQ526q08WCt5oRu7qlGgxXc+WUkVER3b7h7jFsMNvO6hyZaLXBY
         g/ANo9RZvwP7MzIH+mvSMzPcSxMm7yLtHAbNuAwrop79dlCTVeU9NfYz9WlzokWIqEU4
         FY9b7aXbSKqhEvSOPvXuCnsAGa8MLvh0u05t9OuAChrBl/gt88poPi4Dwz8pCHPn3jHr
         wbLWlnO/zX19716htHVe8SJigcFRL6QrvIuOOI4fzWjj+uC4lQ75cnmSe4snw/H1j9vq
         HZBJDmRQ4YSVsX9vqBr+t7wDI2CpqHSZCCOsdBNUrnoGxeW/oVT8s7Uul6Qo7knYCMS6
         Q70w==
X-Gm-Message-State: AOJu0YwsF1JavMJfxWKARkpWD1mJMv6jhg/JONGXwELKXRsk+y+l4sc/
        RWsOZ/+T8+goQneMKCmZ1cyt1ykUPT0N
X-Google-Smtp-Source: AGHT+IEbuxQandSaLuAH4BcQotcozInY4S/lXqvm6E8xmQ1LJ0oQENJNdAkrDnex2ImquBychV8KdwRzDwQB
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2a3:200:7ebc:6ddc:e08c:7b19])
 (user=joshdon job=sendgmr) by 2002:a05:6902:160c:b0:d85:aa2f:5715 with SMTP
 id bw12-20020a056902160c00b00d85aa2f5715mr7438ybb.10.1695423967818; Fri, 22
 Sep 2023 16:06:07 -0700 (PDT)
Date:   Fri, 22 Sep 2023 16:05:35 -0700
In-Reply-To: <20230922230535.296350-1-joshdon@google.com>
Mime-Version: 1.0
References: <20230922230535.296350-1-joshdon@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922230535.296350-2-joshdon@google.com>
Subject: [PATCH 2/2] sched: fix warning in bandwidth distribution
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
 kernel/sched/fair.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8f4e63fc8900..de002dab28cf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5743,13 +5743,13 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 
 static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 {
-	struct cfs_rq *local_unthrottle = NULL;
 	int this_cpu = smp_processor_id();
 	u64 runtime, remaining = 1;
 	bool throttled = false;
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq, *tmp;
 	struct rq_flags rf;
 	struct rq *rq;
+	LIST_HEAD(local_unthrottle);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
@@ -5784,11 +5784,17 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
 		/* we check whether we're throttled above */
 		if (cfs_rq->runtime_remaining > 0) {
-			if (cpu_of(rq) != this_cpu ||
-			    SCHED_WARN_ON(local_unthrottle))
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
 		} else {
 			throttled = true;
 		}
@@ -5796,15 +5802,23 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 next:
 		rq_unlock_irqrestore(rq, &rf);
 	}
-	rcu_read_unlock();
 
-	if (local_unthrottle) {
-		rq = cpu_rq(this_cpu);
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
+
+	rcu_read_unlock();
 
 	return throttled;
 }
-- 
2.42.0.515.g380fc7ccd1-goog

