Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4A380A212
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjLHLVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjLHLVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:21:15 -0500
Received: from out0-196.mail.aliyun.com (out0-196.mail.aliyun.com [140.205.0.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B229C1736
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:21:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047203;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.VfpW3Bq_1702034472;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.VfpW3Bq_1702034472)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 19:21:17 +0800
From:   "Tiwei Bie" <tiwei.btw@antgroup.com>
To:     peterz@infradead.org, mingo@kernel.org, wuyun.abel@bytedance.com
Cc:     "Tiwei Bie" <tiwei.btw@antgroup.com>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -tip] sched/fair: gracefully handle EEVDF scheduling failures
Date:   Fri, 08 Dec 2023 19:20:59 +0800
Message-Id: <20231208112100.18141-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EEVDF scheduling might fail due to unforeseen issues. Previously,
it handled such situations gracefully, which was helpful in identifying
problems, but it no longer does so. Therefore, it would be better to
restore its previous capability.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 kernel/sched/fair.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..1b83b3a8e630 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -878,7 +878,7 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
-	struct sched_entity *se = __pick_first_entity(cfs_rq);
+	struct sched_entity *first = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
 	struct sched_entity *best = NULL;
 
@@ -887,7 +887,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	 * in this cfs_rq, saving some cycles.
 	 */
 	if (cfs_rq->nr_running == 1)
-		return curr && curr->on_rq ? curr : se;
+		return curr && curr->on_rq ? curr : first;
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
@@ -900,14 +900,15 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
-	if (se && entity_eligible(cfs_rq, se)) {
-		best = se;
+	if (first && entity_eligible(cfs_rq, first)) {
+		best = first;
 		goto found;
 	}
 
 	/* Heap search for the EEVD entity */
 	while (node) {
 		struct rb_node *left = node->rb_left;
+		struct sched_entity *se;
 
 		/*
 		 * Eligible entities in left subtree are always better
@@ -937,6 +938,9 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (!best || (curr && entity_before(curr, best)))
 		best = curr;
 
+	if (WARN_ONCE(!best, "EEVDF scheduling failed, picking leftmost\n"))
+		best = first;
+
 	return best;
 }
 
-- 
2.34.1

