Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3987B3D25
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 02:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjI3AJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 20:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3AJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 20:09:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEFFAC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 17:09:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c6193d6bb4so63515ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696032573; x=1696637373; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XnkBwhBVdGH92DFEe08KUfWBiIIUHC8mm8r/BOxS7C0=;
        b=kWWanQLwxAj90qwc1vMaPCjzdasEy/c4yL1b12GQ04X26gDr25dC4vMQMooI4NX9M5
         Xu7tENYntbtcuUHl1BOUeas8ib26wRNeLh+RScZeT+S5CDPfwJdc8N9p1xxfiuR4mOW+
         F8Y69OjI3+1/ZfxYaQWg4UBMoiuHDA8eE0UcJYtCLABrI7yH9ZAEMfrALnvjUP0+CkcW
         AohHerJ6q85g6qSWdNh6ACyNqEM0YEgsyA1p93Q4R+fDqz7qSMuVrv0myH6ghxRic8YM
         yb1bV6wSbMNrUikVazlWbRuBkErgNdAsAIem6+ZAd8q1+WstpWjRz0xYMuxsYrgza8fr
         IAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696032573; x=1696637373;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnkBwhBVdGH92DFEe08KUfWBiIIUHC8mm8r/BOxS7C0=;
        b=Bf4ld2DNmZIbrIQLZGD/FiTPGpTaoiIwpUMof/FjDX8nPfqLfr5d8xBFEZpV0mcKBA
         aeGnIDfiydQhSV/CXJqrkYUe0KmveWEnyUbq98uz6Nd0k8BuzHVbFr5Cs6UD3saIRFVq
         dqTnDHGIdPMB0l6AfHHEJn6vqYOjZ+731HMUG8/45wNxTf6RNgI+4QZKe6UVor01MGsM
         V5I+1OM7HK3YXX7T3aldNsiJWXxSYqEARAhklP7unyZHlQ2J8RaGvl/Yynx/dpoS+GNY
         JMdvKewN1+ZnKWmNrr5D3H5UZom/B0rJqr3xoN2JrrmuZIZmbA9lCfmtqf7MwKkuwwPo
         +B0g==
X-Gm-Message-State: AOJu0YyCv7kyynOkUonq+YfOu/X5aRE21k+jkoo6zWcAWDVDcYlSeK11
        nYdKoSd07WewMHtVRCvQZ+rj1A==
X-Google-Smtp-Source: AGHT+IHo1+v7DzExvOBMHwkeKQsUftj+Pa0WAKVqvKbjFyD6IeBkhFE+GDjCP1o8Bn11hRN7Snqq0A==
X-Received: by 2002:a17:902:ea06:b0:1c6:20ca:2cb8 with SMTP id s6-20020a170902ea0600b001c620ca2cb8mr33478plg.22.1696032573248;
        Fri, 29 Sep 2023 17:09:33 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id jc4-20020a17090325c400b001bbdd44bbb6sm5850650plb.136.2023.09.29.17.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 17:09:32 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
In-Reply-To: <20230531124603.931005524@infradead.org> (Peter Zijlstra's
        message of "Wed, 31 May 2023 13:58:44 +0200")
References: <20230531115839.089944915@infradead.org>
        <20230531124603.931005524@infradead.org>
Date:   Fri, 29 Sep 2023 17:09:30 -0700
Message-ID: <xm261qego72d.fsf_-_@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old pick_eevdf could fail to find the actual earliest eligible
deadline when it descended to the right looking for min_deadline, but it
turned out that that min_deadline wasn't actually eligible. In that case
we need to go back and search through any left branches we skipped
looking for the actual best _eligible_ min_deadline.

This is more expensive, but still O(log n), and at worst should only
involve descending two branches of the rbtree.

I've run this through a userspace stress test (thank you
tools/lib/rbtree.c), so hopefully this implementation doesn't miss any
corner cases.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Ben Segall <bsegall@google.com>
---
 kernel/sched/fair.c | 72 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0c31cda0712f..77e9440b8ab3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -864,18 +864,20 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
  *
  *  se->min_deadline = min(se->deadline, se->{left,right}->min_deadline)
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
 	 * until it gets a new slice. See the HACK in set_next_entity().
 	 */
@@ -892,45 +894,87 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 			node = node->rb_left;
 			continue;
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
 			return left;
 		}
 	}
 
-	return best;
+	return se;
 }
 
 #ifdef CONFIG_SCHED_DEBUG
 struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 {
-- 
2.42.0.582.g8ccd20d70d-goog

