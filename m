Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4267A6FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjITAGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjITAGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:06:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F4795
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:06:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e758d6236so39605527b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695168388; x=1695773188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5rd6RU3HRliBkUXGA7dvU4/oAlmDxBiQOYh5+rVz/qQ=;
        b=Sw0IzeNcJA2AtfNyV7zxGCxoHcj/0gaWvz4BYe52qWlZ9ZBjtdOcvfhju3HGSutNv8
         KoAe8Ank8mwqoWS0MHP8FUfTx55qZg+Sen6Xr0OIkR4n/dgzJgMypgUd3r1vgb9b4bQw
         bH/dyZbFuQIhvXUK/uGVRPsZQ5XW64lcZPe5w9DJMwDk0Cib0n7jlNtuS+4Z9Tktkrvr
         yVgzT6z7CEJoeUywdAyIeGBOMp/t1M3EOx35o4EPOKz4J/hP6dVtCb0eEawFkESvnRKp
         q8f/JGldH2lhcgJ0BY6NBJNci/8CVMYIOqXIaM0nermit6e18KOPtR3szDyDUE4t8dG2
         SVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695168388; x=1695773188;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rd6RU3HRliBkUXGA7dvU4/oAlmDxBiQOYh5+rVz/qQ=;
        b=rMjn5UVKh2qE2Riz2t8BQtsVtkPAYY/5lZdSN4ixSq1K+/ruHznTUkzQkVf/zzhvjx
         TJL4XB9b2S5WmCFM3vfpH7IZNpdo4MTdNYTTLdnjtuYcrDB2/HFhcE2ARUbVhXCN1LuB
         BpB5U2+q748wCRrpNfgqVc5ovX0PuwxfsY9oU2BUQSBd5IVx+tXFX0zazC8GZG9H/zpQ
         y4pQoUwLWVe2wr5tDVfW1MXaDeo2X1UFOFZB89jY4qtwkKAU9TPRnd+knAt9QgiHFPU1
         suQ0r1z0cQD8dha7RKA/DRd7z3+1Kfyfsb2mLHoSdgPKJFjMzzPXsktF+NjkQsUADa5b
         yKZA==
X-Gm-Message-State: AOJu0YzSQZLJI28Z2QobZYhB9XsgDJRoKerQTCWdBFG47TigVutKqXUO
        Ebo8epx6PmnZFIxKJ61zkQ2MpMm+vQ0C
X-Google-Smtp-Source: AGHT+IH4cs/oiZyDXv/ATj9aw5qsfHykk8ex8y+da30gXiWOt3s7LHwc/2ecXT5PvnqABQTXtj82FwJmLgOE
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2a3:200:abfd:1a0d:38de:e671])
 (user=joshdon job=sendgmr) by 2002:a81:b656:0:b0:59b:f493:813c with SMTP id
 h22-20020a81b656000000b0059bf493813cmr15081ywk.9.1695168388169; Tue, 19 Sep
 2023 17:06:28 -0700 (PDT)
Date:   Tue, 19 Sep 2023 17:05:59 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920000559.3872416-1-joshdon@google.com>
Subject: [PATCH] sched: fix warning in bandwidth distribution
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
index 384900bf87eb..509bc74262ad 100644
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
@@ -5786,11 +5786,17 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
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
@@ -5798,15 +5804,23 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
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
2.42.0.459.ge4e396fd5e-goog

