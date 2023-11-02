Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC17DF67B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376818AbjKBPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347591AbjKBPdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A415B187
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vBUL+P10jAOvg5j6kSlF2qo+oprvGK1yGYCCYSiAqlM=; b=sZEQnqGXe7KSXx/yVjySpREPrn
        0QnaDtfJ4YE6CUOXoCoN8KNoCOu8lcspocLrKrgaugUK4GSm+mvfllmLeN/Sk8ePDXVi14V28PqPu
        swe3JNG+QFhta7azvPzQDhUsBmYHOYZvWV81qUGSURgqFmzBCl/bbj2Ju21q43AWoKbV0hsNZgkVc
        5aJ25OIwHdVcZdMmFDUSqr0/feccxlzH71QSjwPdy8wDQBwh5kMASmhhAmZ6+11tzn9n3oOSVJZrj
        MaGlVb6zrAeiPe6+ODTLQcrwrSGEUym0qiNqyGHhY8TQBpbYymFq1rjuJAA2OOUkPZIQKxnCAKIJV
        iRcWyoRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyZgV-0005PJ-Et; Thu, 02 Nov 2023 15:32:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 54ACC3021E1; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152018.499897182@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 07/13] perf: Simplify: __perf_install_in_context()
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
 kernel/events/core.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2732,13 +2732,13 @@ static int  __perf_install_in_context(vo
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 	bool reprogram = true;
-	int ret = 0;
 
-	raw_spin_lock(&cpuctx->ctx.lock);
-	if (ctx->task) {
-		raw_spin_lock(&ctx->lock);
+	if (ctx->task)
 		task_ctx = ctx;
 
+	guard(perf_ctx_lock)(cpuctx, task_ctx);
+
+	if (ctx->task) {
 		reprogram = (ctx->task == current);
 
 		/*
@@ -2748,14 +2748,10 @@ static int  __perf_install_in_context(vo
 		 * If its not running, we don't care, ctx->lock will
 		 * serialize against it becoming runnable.
 		 */
-		if (task_curr(ctx->task) && !reprogram) {
-			ret = -ESRCH;
-			goto unlock;
-		}
+		if (task_curr(ctx->task) && !reprogram)
+			return -ESRCH;
 
 		WARN_ON_ONCE(reprogram && cpuctx->task_ctx && cpuctx->task_ctx != ctx);
-	} else if (task_ctx) {
-		raw_spin_lock(&task_ctx->lock);
 	}
 
 #ifdef CONFIG_CGROUP_PERF
@@ -2778,10 +2774,7 @@ static int  __perf_install_in_context(vo
 		add_event_to_ctx(event, ctx);
 	}
 
-unlock:
-	perf_ctx_unlock(cpuctx, task_ctx);
-
-	return ret;
+	return 0;
 }
 
 static bool exclusive_event_installable(struct perf_event *event,


