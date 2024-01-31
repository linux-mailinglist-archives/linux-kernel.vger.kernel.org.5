Return-Path: <linux-kernel+bounces-46395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B8843F18
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19051F303C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0E37690F;
	Wed, 31 Jan 2024 12:04:03 +0000 (UTC)
Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105076905
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702643; cv=none; b=m8GKp9YW5NAS4Ax06V9CNZ6jR4Rkl+aXIXXDZOd04fesioZJhE9x9zM4NPSPfk8wBmAZ1vHGmpIYAUbZGPOb8VHDNKBv6EcUZyYMBiQdZDQWfMRfr+O9yBcwTYIqQ+7Sp0eF6RXnh4MFTVrKSIeRc8itlTNcZUOxxBpz48zMNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702643; c=relaxed/simple;
	bh=IN90uWH2gKJ9vO4bKf8+8xSF4Zj8oAe2pWZ1Il9B05Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A7h7PDk5pbla7zwsx9hsBJYtVYZMpYgWLyilKbw69QrQpBxTr+pjWda27Wqngj3Q+vrqbvfrrBJ9xhgac8De10KqNtaWit8lKLDSY7ZluiqfNZOEE5DxwpokBcNtEWd8XrDjcUCI+Ewac1XGR/g+S3G39u2h85qPylJB0oqXa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.WKHfWWO_1706702630;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WKHfWWO_1706702630)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 20:03:55 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	wuyun.abel@bytedance.com
Cc: "Tiwei Bie" <tiwei.btw@antgroup.com>,
  "Juri Lelli" <juri.lelli@redhat.com>,
  "Vincent Guittot" <vincent.guittot@linaro.org>,
  "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
  "Steven Rostedt" <rostedt@goodmis.org>,
  "Ben Segall" <bsegall@google.com>,
  "Mel Gorman" <mgorman@suse.de>,
  "Daniel Bristot de Oliveira" <bristot@redhat.com>,
  "Valentin Schneider" <vschneid@redhat.com>,
   <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] sched/fair: Sanity check 'best' in pick_eevdf()
Date: Wed, 31 Jan 2024 20:03:40 +0800
Message-Id: <20240131120340.76461-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before commit 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual
deadline"), there was a sanity check to catch unexpected failures in the
EEVDF scheduling, which was helpful in identifying problems. It would
be better to restore its previous capability.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
Refer:
https://lore.kernel.org/lkml/23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com/

v1 -> v2:
- improve commit log and error message;

 kernel/sched/fair.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..aeb3b8fee641 100644
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
@@ -937,6 +938,16 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (!best || (curr && entity_before(curr, best)))
 		best = curr;
 
+	/* This is not expected to happen. */
+	if (unlikely(!best)) {
+		if (printk_ratelimit()) {
+			printk_deferred(KERN_ERR
+				"EEVDF scheduling failed on CPU%d, picking leftmost\n",
+				cpu_of(rq_of(cfs_rq)));
+		}
+		best = first;
+	}
+
 	return best;
 }
 
-- 
2.34.1


