Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD79D7B669E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjJCKmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjJCKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:42:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4170B4;
        Tue,  3 Oct 2023 03:42:39 -0700 (PDT)
Date:   Tue, 03 Oct 2023 10:42:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696329758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9ftg0JpBJiHaMhlIbJUcgMI8xyvm5PQSTdqLJVFKz8=;
        b=HsjtQn6sY+Uu1njmyST3TlmSi4K+fkU6XS+P1MSJcuXgH0VLxcR9ZNGxX3fgnICHvDfr+3
        WwBaBH2kaO/JC62LXFWeRidfLnwfFlM9hRrYbfp8frbBl43kW3u0mUriUo8RRGqCfBel/o
        7bATTnPSpbFo54ivO/xMR17/0oDNzQro12uH7tDW6nO43HORMAqAFolqdTKzkXg9ykMhUg
        mDe86KIeB2Bv18ZwVf2x0RHVesYaOp0Ns27lUbT2WddZ7EEnO3jv6dUncECGR/oQHhkyuX
        v3NS+mzyJwAXWMjChp7/2v/4aw6+nbhqQSQdgg/+rjQpet5NDcLECXjC6wNqhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696329758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9ftg0JpBJiHaMhlIbJUcgMI8xyvm5PQSTdqLJVFKz8=;
        b=Q156DRbVBEdSef9Eix2GX4vhTT3t9BOg2GC0v99IaTa2dEWjjuW8WdAeOJLqvK4n4QsyBK
        xT5xaRyTpA6Ou9Cg==
From:   "tip-bot2 for Benjamin Segall" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix pick_eevdf()
Cc:     Ben Segall <bsegall@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <xm261qego72d.fsf_-_@google.com>
References: <xm261qego72d.fsf_-_@google.com>
MIME-Version: 1.0
Message-ID: <169632975707.3135.15953962497014148115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     561c58efd2394d76a32254d91e4b1de8ecdeb5c8
Gitweb:        https://git.kernel.org/tip/561c58efd2394d76a32254d91e4b1de8ecdeb5c8
Author:        Benjamin Segall <bsegall@google.com>
AuthorDate:    Fri, 29 Sep 2023 17:09:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Oct 2023 12:32:30 +02:00

sched/fair: Fix pick_eevdf()

The old pick_eevdf() could fail to find the actual earliest eligible
deadline when it descended to the right looking for min_deadline, but
it turned out that that min_deadline wasn't actually eligible. In that
case we need to go back and search through any left branches we
skipped looking for the actual best _eligible_ min_deadline.

This is more expensive, but still O(log n), and at worst should only
involve descending two branches of the rbtree.

I've run this through a userspace stress test (thank you
tools/lib/rbtree.c), so hopefully this implementation doesn't miss any
corner cases.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Ben Segall <bsegall@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/xm261qego72d.fsf_-_@google.com
---
 kernel/sched/fair.c | 72 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef7490c..929d21d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -872,14 +872,16 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
  *
  * Which allows an EDF like search on (sub)trees.
  */
-static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *curr = cfs_rq->curr;
 	struct sched_entity *best = NULL;
+	struct sched_entity *best_left = NULL;
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
+	best = curr;
 
 	/*
 	 * Once selected, run a task until it either becomes non-eligible or
@@ -900,33 +902,75 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 		}
 
 		/*
-		 * If this entity has an earlier deadline than the previous
-		 * best, take this one. If it also has the earliest deadline
-		 * of its subtree, we're done.
+		 * Now we heap search eligible trees for the best (min_)deadline
 		 */
-		if (!best || deadline_gt(deadline, best, se)) {
+		if (!best || deadline_gt(deadline, best, se))
 			best = se;
-			if (best->deadline == best->min_deadline)
-				break;
-		}
 
 		/*
-		 * If the earlest deadline in this subtree is in the fully
-		 * eligible left half of our space, go there.
+		 * Every se in a left branch is eligible, keep track of the
+		 * branch with the best min_deadline
 		 */
+		if (node->rb_left) {
+			struct sched_entity *left = __node_2_se(node->rb_left);
+
+			if (!best_left || deadline_gt(min_deadline, best_left, left))
+				best_left = left;
+
+			/*
+			 * min_deadline is in the left branch. rb_left and all
+			 * descendants are eligible, so immediately switch to the second
+			 * loop.
+			 */
+			if (left->min_deadline == se->min_deadline)
+				break;
+		}
+
+		/* min_deadline is at this node, no need to look right */
+		if (se->deadline == se->min_deadline)
+			break;
+
+		/* else min_deadline is in the right branch. */
+		node = node->rb_right;
+	}
+
+	/*
+	 * We ran into an eligible node which is itself the best.
+	 * (Or nr_running == 0 and both are NULL)
+	 */
+	if (!best_left || (s64)(best_left->min_deadline - best->deadline) > 0)
+		return best;
+
+	/*
+	 * Now best_left and all of its children are eligible, and we are just
+	 * looking for deadline == min_deadline
+	 */
+	node = &best_left->run_node;
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		/* min_deadline is the current node */
+		if (se->deadline == se->min_deadline)
+			return se;
+
+		/* min_deadline is in the left branch */
 		if (node->rb_left &&
 		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
 			node = node->rb_left;
 			continue;
 		}
 
+		/* else min_deadline is in the right branch */
 		node = node->rb_right;
 	}
+	return NULL;
+}
 
-	if (!best || (curr && deadline_gt(deadline, best, curr)))
-		best = curr;
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *se = __pick_eevdf(cfs_rq);
 
-	if (unlikely(!best)) {
+	if (!se) {
 		struct sched_entity *left = __pick_first_entity(cfs_rq);
 		if (left) {
 			pr_err("EEVDF scheduling fail, picking leftmost\n");
@@ -934,7 +978,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 		}
 	}
 
-	return best;
+	return se;
 }
 
 #ifdef CONFIG_SCHED_DEBUG
