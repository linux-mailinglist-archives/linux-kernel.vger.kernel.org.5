Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E17CF274
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344918AbjJSIYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjJSIYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:24:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15014182;
        Thu, 19 Oct 2023 01:24:03 -0700 (PDT)
Date:   Thu, 19 Oct 2023 08:23:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697703840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATmV+shENxojKtOgLX8bX5Ko5VODxesMS6F+xBHm3TA=;
        b=IYCjluzwcIrVVHp6/It2Clz1236LclJy3xsuqgHEfrN1dWRCv/kqQFJAlLWQ9gXwQvogmG
        c2l19LdpXDT4L4MtKJ9WlezYgKV9q3ocCG9dBQSuXV1/FOdO7v6NHiNO92pKhbEMQGi6c3
        iCbDN9e3cGG0GiAt8ujYnljzVDx1LC07OtzTDy437bUmFwdurDVNxEymCBRY3K67/P6OYs
        tNcoaGPaDg3hc0pO91sbayQ/cxgpgT25P14vyeBcFq0ak0g8KtS0MyAtzg7iI4bbxaL9vh
        DXBPb6Vrjkpco3/ePc20HwVntP56rasFUlL0yVbFh5e2kJSvgOSNF9+q+8YCKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697703840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATmV+shENxojKtOgLX8bX5Ko5VODxesMS6F+xBHm3TA=;
        b=HHMawuVsLa5nSxJr+aRXzbbpTudgOMa5mvW5AigGl424YCceLV00ZfI+FFax9oQ3uKup0m
        vSFUQS/cgGfUweAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Disallow mis-matched inherited group reads
Cc:     Budimir Markovic <markovicbudimir@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231018115654.GK33217@noisy.programming.kicks-ass.net>
References: <20231018115654.GK33217@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169770383951.3135.17771457264387517954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     32671e3799ca2e4590773fd0e63aaa4229e50c06
Gitweb:        https://git.kernel.org/tip/32671e3799ca2e4590773fd0e63aaa4229e50c06
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 18 Oct 2023 13:56:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Oct 2023 10:09:42 +02:00

perf: Disallow mis-matched inherited group reads

Because group consistency is non-atomic between parent (filedesc) and children
(inherited) events, it is possible for PERF_FORMAT_GROUP read() to try and sum
non-matching counter groups -- with non-sensical results.

Add group_generation to distinguish the case where a parent group removes and
adds an event and thus has the same number, but a different configuration of
events as inherited groups.

This became a problem when commit fa8c269353d5 ("perf/core: Invert
perf_read_group() loops") flipped the order of child_list and sibling_list.
Previously it would iterate the group (sibling_list) first, and for each
sibling traverse the child_list. In this order, only the group composition of
the parent is relevant. By flipping the order the group composition of the
child (inherited) events becomes an issue and the mis-match in group
composition becomes evident.

That said; even prior to this commit, while reading of a group that is not
equally inherited was not broken, it still made no sense.

(Ab)use ECHILD as error return to indicate issues with child process group
composition.

Fixes: fa8c269353d5 ("perf/core: Invert perf_read_group() loops")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231018115654.GK33217@noisy.programming.kicks-ass.net
---
 include/linux/perf_event.h |  1 +-
 kernel/events/core.c       | 39 +++++++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e85cd1c..7b5406e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -704,6 +704,7 @@ struct perf_event {
 	/* The cumulative AND of all event_caps for events in this group. */
 	int				group_caps;
 
+	unsigned int			group_generation;
 	struct perf_event		*group_leader;
 	/*
 	 * event->pmu will always point to pmu in which this event belongs.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c72a41..d0663b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1954,6 +1954,7 @@ static void perf_group_attach(struct perf_event *event)
 
 	list_add_tail(&event->sibling_list, &group_leader->sibling_list);
 	group_leader->nr_siblings++;
+	group_leader->group_generation++;
 
 	perf_event__header_size(group_leader);
 
@@ -2144,6 +2145,7 @@ static void perf_group_detach(struct perf_event *event)
 	if (leader != event) {
 		list_del_init(&event->sibling_list);
 		event->group_leader->nr_siblings--;
+		event->group_leader->group_generation++;
 		goto out;
 	}
 
@@ -5440,7 +5442,7 @@ static int __perf_read_group_add(struct perf_event *leader,
 					u64 read_format, u64 *values)
 {
 	struct perf_event_context *ctx = leader->ctx;
-	struct perf_event *sub;
+	struct perf_event *sub, *parent;
 	unsigned long flags;
 	int n = 1; /* skip @nr */
 	int ret;
@@ -5450,6 +5452,33 @@ static int __perf_read_group_add(struct perf_event *leader,
 		return ret;
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
+	/*
+	 * Verify the grouping between the parent and child (inherited)
+	 * events is still in tact.
+	 *
+	 * Specifically:
+	 *  - leader->ctx->lock pins leader->sibling_list
+	 *  - parent->child_mutex pins parent->child_list
+	 *  - parent->ctx->mutex pins parent->sibling_list
+	 *
+	 * Because parent->ctx != leader->ctx (and child_list nests inside
+	 * ctx->mutex), group destruction is not atomic between children, also
+	 * see perf_event_release_kernel(). Additionally, parent can grow the
+	 * group.
+	 *
+	 * Therefore it is possible to have parent and child groups in a
+	 * different configuration and summing over such a beast makes no sense
+	 * what so ever.
+	 *
+	 * Reject this.
+	 */
+	parent = leader->parent;
+	if (parent &&
+	    (parent->group_generation != leader->group_generation ||
+	     parent->nr_siblings != leader->nr_siblings)) {
+		ret = -ECHILD;
+		goto unlock;
+	}
 
 	/*
 	 * Since we co-schedule groups, {enabled,running} times of siblings
@@ -5483,8 +5512,9 @@ static int __perf_read_group_add(struct perf_event *leader,
 			values[n++] = atomic64_read(&sub->lost_samples);
 	}
 
+unlock:
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
-	return 0;
+	return ret;
 }
 
 static int perf_read_group(struct perf_event *event,
@@ -5503,10 +5533,6 @@ static int perf_read_group(struct perf_event *event,
 
 	values[0] = 1 + leader->nr_siblings;
 
-	/*
-	 * By locking the child_mutex of the leader we effectively
-	 * lock the child list of all siblings.. XXX explain how.
-	 */
 	mutex_lock(&leader->child_mutex);
 
 	ret = __perf_read_group_add(leader, read_format, values);
@@ -13346,6 +13372,7 @@ static int inherit_group(struct perf_event *parent_event,
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
+	leader->group_generation = parent_event->group_generation;
 	return 0;
 }
 
