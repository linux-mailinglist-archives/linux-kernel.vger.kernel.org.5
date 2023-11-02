Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384477DF672
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347566AbjKBPdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbjKBPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA2182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gJ0cDE/AWPvauqfBTyp4RE5Jcb6F1MLuevN6bVvwMR4=; b=E9j9R2VdzYpvPH7rwdpNxxMJZL
        Mc9Uj6K4UmJMbMKg2oBTNF6i6wR6vGVAtWk2bocVeGTSyak6Q+0BB7ILnNi0m3iO37oLJpqIg4XUt
        La3ST7Gss5YpASywS+2izd9ykg95moqR9MXiDwf2fm1k/qImKpzMOvG28ngIkGF5qweLTe2SWmhU8
        v7vJ96pRbrcuHvG+YWR/0Zo5UnaZbbW9iB/gAk3zta5iAMsK3cEB1CWVf8d0AUpzjZ+0f12XihsUw
        GqDigxj3W1t5lYUcVEHpHs5MwElyg6fUyJZd9H4Snik/8eRKymF61DRXGMNnaW0HsiEzmpo6a/y2J
        Dx9Xz99A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyZgV-006gQM-26;
        Thu, 02 Nov 2023 15:32:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 49CE63015B5; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152018.177137916@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 04/13] perf: Simplify event_function*()
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

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -214,6 +214,19 @@ struct event_function_struct {
 	void *data;
 };
 
+typedef struct {
+	struct perf_cpu_context *cpuctx;
+	struct perf_event_context *ctx;
+} class_perf_ctx_lock_t;
+
+static inline void class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
+{ perf_ctx_unlock(_T->cpuctx, _T->ctx); }
+
+static inline class_perf_ctx_lock_t
+class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
+				struct perf_event_context *ctx)
+{ perf_ctx_lock(cpuctx, ctx); return (class_perf_ctx_lock_t){ cpuctx, ctx }; }
+
 static int event_function(void *info)
 {
 	struct event_function_struct *efs = info;
@@ -221,20 +234,17 @@ static int event_function(void *info)
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
-	int ret = 0;
 
 	lockdep_assert_irqs_disabled();
+	guard(perf_ctx_lock)(cpuctx, task_ctx);
 
-	perf_ctx_lock(cpuctx, task_ctx);
 	/*
 	 * Since we do the IPI call without holding ctx->lock things can have
 	 * changed, double check we hit the task we set out to hit.
 	 */
 	if (ctx->task) {
-		if (ctx->task != current) {
-			ret = -ESRCH;
-			goto unlock;
-		}
+		if (ctx->task != current)
+			return -ESRCH;
 
 		/*
 		 * We only use event_function_call() on established contexts,
@@ -254,10 +264,8 @@ static int event_function(void *info)
 	}
 
 	efs->func(event, cpuctx, ctx, efs->data);
-unlock:
-	perf_ctx_unlock(cpuctx, task_ctx);
 
-	return ret;
+	return 0;
 }
 
 static void event_function_call(struct perf_event *event, event_f func, void *data)
@@ -329,11 +337,11 @@ static void event_function_local(struct
 		task_ctx = ctx;
 	}
 
-	perf_ctx_lock(cpuctx, task_ctx);
+	guard(perf_ctx_lock)(cpuctx, task_ctx);
 
 	task = ctx->task;
 	if (task == TASK_TOMBSTONE)
-		goto unlock;
+		return;
 
 	if (task) {
 		/*
@@ -343,18 +351,16 @@ static void event_function_local(struct
 		 */
 		if (ctx->is_active) {
 			if (WARN_ON_ONCE(task != current))
-				goto unlock;
+				return;
 
 			if (WARN_ON_ONCE(cpuctx->task_ctx != ctx))
-				goto unlock;
+				return;
 		}
 	} else {
 		WARN_ON_ONCE(&cpuctx->ctx != ctx);
 	}
 
 	func(event, cpuctx, ctx, data);
-unlock:
-	perf_ctx_unlock(cpuctx, task_ctx);
 }
 
 #define PERF_FLAG_ALL (PERF_FLAG_FD_NO_GROUP |\


