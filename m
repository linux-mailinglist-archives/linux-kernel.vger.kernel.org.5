Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ACC77BC80
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjHNPIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjHNPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED84CE7E;
        Mon, 14 Aug 2023 08:08:05 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXW3nEL89Mir6fGJGZqajlU5D4KgXtIKswXzxsAVJzo=;
        b=KHqU2slLkfsUC4RggfUWf5z7sJ2QX9o5qnGyVMG+Ph2jVk/FyZeXPvjjDs8ZaHXJ+w2FWU
        B7QoB9V9R3vaN6iRnqVEzlbvqAHz5/fFMGLC0GDsvH7xsYf6SLw9gvQVPcOpSzLkZinfuA
        4iHv3KGaS9kFsINFe2Bo3ZMviER0seceZqByULLybmO25RAYXwWEbxRAp9bwwyz8rkMwjL
        vDik1sPsrM+tOfuNIt18zpbYxSkHssUwF7L39y6C4f/FeclSjw/tpo4qxOsoUVZovdy+V8
        25tq64KbENyV2HnyEi4hYdQzEstx+6pJZ4I960V+d5Ql/bfA5NRy0m+Ufyu44w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXW3nEL89Mir6fGJGZqajlU5D4KgXtIKswXzxsAVJzo=;
        b=8nVIKfvKYx7AvwGMu4quNbW6pqNX4GMRez0yjf5EhuAqKma8lJbLjgueJiDPimUEUJzEd/
        WGNoETfV9QZNwoAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify try_steal_cookie()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801211812.304154828@infradead.org>
References: <20230801211812.304154828@infradead.org>
MIME-Version: 1.0
Message-ID: <169202568401.27769.4393082329666794461.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b4e1fa1e14286f7a825b10d8ebb2e9c0f77c241b
Gitweb:        https://git.kernel.org/tip/b4e1fa1e14286f7a825b10d8ebb2e9c0f77c241b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Aug 2023 22:41:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:27 +02:00

sched: Simplify try_steal_cookie()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230801211812.304154828@infradead.org
---
 kernel/sched/core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1b2fa91..f113a44 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6298,19 +6298,19 @@ static bool try_steal_cookie(int this, int that)
 	unsigned long cookie;
 	bool success = false;
 
-	local_irq_disable();
-	double_rq_lock(dst, src);
+	guard(irq)();
+	guard(double_rq_lock)(dst, src);
 
 	cookie = dst->core->core_cookie;
 	if (!cookie)
-		goto unlock;
+		return false;
 
 	if (dst->curr != dst->idle)
-		goto unlock;
+		return false;
 
 	p = sched_core_find(src, cookie);
 	if (!p)
-		goto unlock;
+		return false;
 
 	do {
 		if (p == src->core_pick || p == src->curr)
@@ -6322,9 +6322,10 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 		/*
-		 * sched_core_find() and sched_core_next() will ensure that task @p
-		 * is not throttled now, we also need to check whether the runqueue
-		 * of the destination CPU is being throttled.
+		 * sched_core_find() and sched_core_next() will ensure
+		 * that task @p is not throttled now, we also need to
+		 * check whether the runqueue of the destination CPU is
+		 * being throttled.
 		 */
 		if (sched_task_is_throttled(p, this))
 			goto next;
@@ -6342,10 +6343,6 @@ next:
 		p = sched_core_next(p, cookie);
 	} while (p);
 
-unlock:
-	double_rq_unlock(dst, src);
-	local_irq_enable();
-
 	return success;
 }
 
