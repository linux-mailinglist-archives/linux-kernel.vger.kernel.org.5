Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4B77EBF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjKOJFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjKOJE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:04:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097D7118;
        Wed, 15 Nov 2023 01:04:56 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:04:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700039094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/QYSSvUOrr4LCCn0jOmwTPfiYTrF8t+LpJ/wwhjengA=;
        b=HnMEP2yAvdCP2XVOUaS4gJcXDPkXb9STLQW4Rp1YCmMiMg+KaoTU+Ftpbnzort3nsJBPV1
        W9S+VnZ/Gy0xzPBaCAsf8yBYFbBLErUhFxRx5de+ad0WAUxRGOvIcRMJzmA0wASgVAS33L
        iq+Qq5gSxpI9FanKABAVpHp8M99VSnExSIRgyOr92LESnLBSCWLj6/YoEnzOc79wyll2iz
        qdcfVGv98qc0iw+VUe5+8PFZnFmO2vIEldPB0GjlQK05Dj3CwpyjX7nsb+maNiihwL0rXY
        YDTKoI6IaVZR3yNYjhl9ybGQO5M36O9ajzJdPxIb03Qo0uQ0ByhdeEML0cao8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700039094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/QYSSvUOrr4LCCn0jOmwTPfiYTrF8t+LpJ/wwhjengA=;
        b=tRToTnKSDv21wezBGC3kFmF1ZuaW1yKHZLJKlvg/4+yUgJbh3fw90PIrVXnr0aScsB31me
        /Mjo3erfdSojWkAg==
From:   "tip-bot2 for Abel Wu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: O(1) fastpath for task selection
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231115033647.80785-4-wuyun.abel@bytedance.com>
References: <20231115033647.80785-4-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Message-ID: <170003909401.391.2052507290620204426.tip-bot2@tip-bot2>
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

Commit-ID:     ee4373dc902c0a403dd084b254ce70a78f95466f
Gitweb:        https://git.kernel.org/tip/ee4373dc902c0a403dd084b254ce70a78f95466f
Author:        Abel Wu <wuyun.abel@bytedance.com>
AuthorDate:    Wed, 15 Nov 2023 11:36:46 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 09:57:47 +01:00

sched/eevdf: O(1) fastpath for task selection

Since the RB-tree is now sorted by deadline, let's first try the
leftmost entity which has the earliest virtual deadline. I've done
some benchmarks to see its effectiveness.

All the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled, on a dual-CPU Intel Xeon(R)
Platinum 8260 with 2 NUMA nodes each of which has 24C/48T.

  hackbench: process/thread + pipe/socket + 1/2/4/8 groups
  netperf:   TCP/UDP + STREAM/RR + 24/48/72/96/192 threads
  tbench:    loopback 24/48/72/96/192 threads
  schbench:  1/2/4/8 mthreads

  direct:    cfs_rq has only one entity
  parity:    RUN_TO_PARITY
  fast:      O(1) fastpath
  slow:	     heap search

    (%)		direct	parity	fast	slow
  hackbench	92.95	2.02	4.91	0.12
  netperf	68.08	6.60	24.18	1.14
  tbench	67.55	11.22	20.61	0.62
  schbench	69.91	2.65	25.73	1.71

The above results indicate that this fastpath really makes task
selection more efficient.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231115033647.80785-4-wuyun.abel@bytedance.com
---
 kernel/sched/fair.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 31bca05..d3e045d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -878,6 +878,7 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
 	struct sched_entity *best = NULL;
 
@@ -886,7 +887,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	 * in this cfs_rq, saving some cycles.
 	 */
 	if (cfs_rq->nr_running == 1)
-		return curr && curr->on_rq ? curr : __node_2_se(node);
+		return curr && curr->on_rq ? curr : se;
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
@@ -898,9 +899,14 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
 		return curr;
 
+	/* Pick the leftmost entity if it's eligible */
+	if (se && entity_eligible(cfs_rq, se)) {
+		best = se;
+		goto found;
+	}
+
 	/* Heap search for the EEVD entity */
 	while (node) {
-		struct sched_entity *se = __node_2_se(node);
 		struct rb_node *left = node->rb_left;
 
 		/*
@@ -913,6 +919,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 			continue;
 		}
 
+		se = __node_2_se(node);
+
 		/*
 		 * The left subtree either is empty or has no eligible
 		 * entity, so check the current node since it is the one
@@ -925,7 +933,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 
 		node = node->rb_right;
 	}
-
+found:
 	if (!best || (curr && entity_before(curr, best)))
 		best = curr;
 
