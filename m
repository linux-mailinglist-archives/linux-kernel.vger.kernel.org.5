Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE8375639F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGQM6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGQM6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:58:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC138170B;
        Mon, 17 Jul 2023 05:57:42 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrGWQ/SozKA2U/gSKpFPzjk/3d7CNDWfjif8ObmuI28=;
        b=PeN6jkpP/oXhePh57AvoDMbHlOGh5QGXo60ob7SOC7InBH2TWBE63srX0zFlqDWZm/3Kx0
        4CtxBVrrHX1gTVZjaunZ0Ozh1upqhtbkMZljInf4Lvo4DYtEF3GLAzY27edj4dlIVfB5tO
        mZeDRnqwnxj0TxyJUheF1WfsL8Pii4RjEbp3M+1int2REfZTXFIEFq6zANs0e73vQjhFre
        V8yMrzQS/+tLs2J7qHrHOU+XerxSvsr82Gn9ci4ieAhfGybH9s1vE3SkuNx8C6aT7FHLnJ
        qEvjHGPCLc47iqj2x/nYyiEPRJeJbRx73EwrUzJvG5ipYUzEC2YvqkpuHNV7sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrGWQ/SozKA2U/gSKpFPzjk/3d7CNDWfjif8ObmuI28=;
        b=+FEzc7mIiYQPGgyuh6txMJJAC3Lh/LYPTLg5larEBdCuphjVmaAoXLnO1VXks80LwzLyr+
        LHYh1JDzUc+GWZAg==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: don't account throttle time for empty groups
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230620183247.737942-1-joshdon@google.com>
References: <20230620183247.737942-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <168959857560.28540.2230904092099852239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     79462e8c879afc7895b30014d31e2c1fd629bb1f
Gitweb:        https://git.kernel.org/tip/79462e8c879afc7895b30014d31e2c1fd629bb1f
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Tue, 20 Jun 2023 11:32:46 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:49 +02:00

sched: don't account throttle time for empty groups

It is easy for a cfs_rq to become throttled even when it has no enqueued
entities (for example, if we have just put_prev()'d the last runnable
task of the cfs_rq, and the cfs_rq is out of quota).

Avoid accounting this time towards total throttle time, since it
otherwise falsely inflates the stats.

Note that the dequeue path is special, since we normally disallow
migrations when a task is in a throttled hierarchy (see
throttled_lb_pair()).

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230620183247.737942-1-joshdon@google.com
---
 kernel/sched/fair.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a739..51ccae7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4787,6 +4787,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
+static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
 static inline bool cfs_bandwidth_used(void);
 
@@ -4873,8 +4874,14 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if (cfs_rq->nr_running == 1) {
 		check_enqueue_throttle(cfs_rq);
-		if (!throttled_hierarchy(cfs_rq))
+		if (!throttled_hierarchy(cfs_rq)) {
 			list_add_leaf_cfs_rq(cfs_rq);
+		} else {
+#ifdef CONFIG_CFS_BANDWIDTH
+			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
+				cfs_rq->throttled_clock = rq_clock(rq_of(cfs_rq));
+#endif
+		}
 	}
 }
 
@@ -5480,7 +5487,9 @@ done:
 	 * throttled-list.  rq->lock protects completion.
 	 */
 	cfs_rq->throttled = 1;
-	cfs_rq->throttled_clock = rq_clock(rq);
+	SCHED_WARN_ON(cfs_rq->throttled_clock);
+	if (cfs_rq->nr_running)
+		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
 }
 
@@ -5498,7 +5507,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	update_rq_clock(rq);
 
 	raw_spin_lock(&cfs_b->lock);
-	cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
+	if (cfs_rq->throttled_clock) {
+		cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
+		cfs_rq->throttled_clock = 0;
+	}
 	list_del_rcu(&cfs_rq->throttled_list);
 	raw_spin_unlock(&cfs_b->lock);
 
