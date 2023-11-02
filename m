Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2641B7DF676
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376370AbjKBPdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347499AbjKBPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E44184
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xk+4iMONbkXiTk0hS6u3U/Ijn5wg/Ea5KL9bAZzCxZc=; b=i+xBFng42EokmYQs8E3C2aCCNt
        LSR9otznbyM7qctRZPGk2veM5RMeYAnviUjiBi+cvtz8pi6EKQ1THOGe7hFXgYZcZgcLfrRZrcai9
        4qYWZgQm/EKq6HpWHXWiMMuDB7HEXuI8HI/Km9jPQ1LA/Tjwd+rmA8poBJITfQZZdrqurCRe8MCKn
        DeCjWFal0RmOtaVKlO07WMF32k3YpjokeRGgFGV+ZbtU8PJV1eIxA/WVDzbfoOvusZYKqkCVe+lZw
        DoPjVDgJ4ssLiV3pCs8XLXRhd8OuC6twA9k2bPVNse7KUCKX91ni2IB9foLt76C56OHuFRDD3GgP8
        Ft8+a9MA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyZgV-0005PL-Fp; Thu, 02 Nov 2023 15:32:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 5FF52302D87; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152018.878930233@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 10/13] perf: Simplify perf_event_context_sched_in()
References: <20231102150919.719936610@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -713,6 +713,9 @@ static void perf_ctx_enable(struct perf_
 	}
 }
 
+DEFINE_GUARD(perf_ctx_disable, struct perf_event_context *,
+	     perf_ctx_disable(_T, false), perf_ctx_enable(_T, false))
+
 static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
 static void ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type);
 
@@ -3903,31 +3906,27 @@ static void perf_event_context_sched_in(
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_context *ctx;
 
-	rcu_read_lock();
+	guard(rcu)();
+
 	ctx = rcu_dereference(task->perf_event_ctxp);
 	if (!ctx)
-		goto rcu_unlock;
-
-	if (cpuctx->task_ctx == ctx) {
-		perf_ctx_lock(cpuctx, ctx);
-		perf_ctx_disable(ctx, false);
-
-		perf_ctx_sched_task_cb(ctx, true);
-
-		perf_ctx_enable(ctx, false);
-		perf_ctx_unlock(cpuctx, ctx);
-		goto rcu_unlock;
-	}
+		return;
 
-	perf_ctx_lock(cpuctx, ctx);
+	guard(perf_ctx_lock)(cpuctx, ctx);
 	/*
 	 * We must check ctx->nr_events while holding ctx->lock, such
 	 * that we serialize against perf_install_in_context().
 	 */
 	if (!ctx->nr_events)
-		goto unlock;
+		return;
+
+	guard(perf_ctx_disable)(ctx);
+
+	if (cpuctx->task_ctx == ctx) {
+		perf_ctx_sched_task_cb(ctx, true);
+		return;
+	}
 
-	perf_ctx_disable(ctx, false);
 	/*
 	 * We want to keep the following priority order:
 	 * cpu pinned (that don't need to move), task pinned,
@@ -3947,13 +3946,6 @@ static void perf_event_context_sched_in(
 
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
 		perf_ctx_enable(&cpuctx->ctx, false);
-
-	perf_ctx_enable(ctx, false);
-
-unlock:
-	perf_ctx_unlock(cpuctx, ctx);
-rcu_unlock:
-	rcu_read_unlock();
 }
 
 /*


