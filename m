Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743C97DF67D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376832AbjKBPdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347638AbjKBPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B43418E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=R8zokz8HpLYR/tS6Df4K9QtMMliKooDPknNNGx1Aq0A=; b=V3eJxy3aHR8sSOdEp2w15Upf3d
        /3SI+v3WkjGk9NFqxZbFJcgZTvJ79bAaWRNVfLFnbTBafrkhG6t62hkQx0oOa30hg/CHkjhSTKs8T
        cUWG0PDkodBntmFopGQYrkx+PV1dRnXtnJM9cfwRyafcWNHWZSInWD3PWjf6L3pInbgNwtEodyh/r
        jvbAavQzJNrczRFhhIF08eaT/eWLXij8kmL47lj4Cop0Kvl1GhC2HqMzAxVQg3h4JAbPTV91m5nFo
        tt4Qg5y/dxqrNQM8HTUXLIUcM7R/Mv5kfFiB4vG5DsijKr4/Ow0TsTbb7u8CqbMTal5AaY71DpjC5
        Coafv0AQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyZgV-0005PK-Fo; Thu, 02 Nov 2023 15:32:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 5C2CA302D66; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152018.768730519@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 09/13] perf: Simplify perf_event_modify_attr()
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
 kernel/events/core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3172,7 +3172,7 @@ static int perf_event_modify_attr(struct
 
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 
-	mutex_lock(&event->child_mutex);
+	guard(mutex)(&event->child_mutex);
 	/*
 	 * Event-type-independent attributes must be copied before event-type
 	 * modification, which will validate that final attributes match the
@@ -3181,16 +3181,16 @@ static int perf_event_modify_attr(struct
 	perf_event_modify_copy_attr(&event->attr, attr);
 	err = func(event, attr);
 	if (err)
-		goto out;
+		return err;
+
 	list_for_each_entry(child, &event->child_list, child_list) {
 		perf_event_modify_copy_attr(&child->attr, attr);
 		err = func(child, attr);
 		if (err)
-			goto out;
+			return err;
 	}
-out:
-	mutex_unlock(&event->child_mutex);
-	return err;
+
+	return 0;
 }
 
 static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,


