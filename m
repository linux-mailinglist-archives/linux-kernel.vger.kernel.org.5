Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90B7EBBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjKODX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjKODX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:23:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCDCD5;
        Tue, 14 Nov 2023 19:23:53 -0800 (PST)
Date:   Wed, 15 Nov 2023 03:23:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700018631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdCBWbh2ujnjFYIEsg2mtFEUG5LGXDTFpqB0nUoHOiA=;
        b=vkJoX7AQ367Y3jzFVsmGbaH+hcL0FsZrc1PtMBNAaisgFXgkGJQIGs3l6weRi61vxksxn1
        YBMP2IpeduQbZBK/ZaBmQ2fS4du73NWu3thm76MIQVCrmpEJBhxsCBWh5mq01DkBQZGVzf
        7gBX/pDXL5XaeTUxh4HdCAlta5ahBD1X7w9jxxeE4RMyA3/h5yyo2bOXFvZ0UhAF47J0ri
        Vae0nYN9TcOwL5vOFK4aALVUXo932lk0heRdbl7mQZUNrmpHVo8StJxLWb/hUJm6MYBROi
        SY41LjXC3vWYNxCJU3Qo30e+eHe2GZxrOY1kXQe4PyxQ3pjc+p9Eq6cJhX3oog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700018631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdCBWbh2ujnjFYIEsg2mtFEUG5LGXDTFpqB0nUoHOiA=;
        b=yKxcv1WyXTEMNfaNHFL6bEwzIC4/2fMpbd2DIAuXstYaOCobpezimWbrj8MhpHluQUSUW7
        Wh8TVJ0DPLx9dXCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix cpuctx refcounting
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, <stable@vger.kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230612093539.085862001@infradead.org>
References: <20230612093539.085862001@infradead.org>
MIME-Version: 1.0
Message-ID: <170001863083.391.17242045529374846563.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     889c58b3155ff4c8e8671c95daef63d6fabbb6b1
Gitweb:        https://git.kernel.org/tip/889c58b3155ff4c8e8671c95daef63d6fabbb6b1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 12:34:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 15 Nov 2023 04:18:31 +01:00

perf/core: Fix cpuctx refcounting

Audit of the refcounting turned up that perf_pmu_migrate_context()
fails to migrate the ctx refcount.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20230612093539.085862001@infradead.org
Cc: <stable@vger.kernel.org>
---
 include/linux/perf_event.h | 13 ++++++++-----
 kernel/events/core.c       | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index afb028c..5547ba6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -843,11 +843,11 @@ struct perf_event {
 };
 
 /*
- *           ,-----------------------[1:n]----------------------.
- *           V                                                  V
- * perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
- *           ^                      ^     |                     |
- *           `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
+ *           ,-----------------------[1:n]------------------------.
+ *           V                                                    V
+ * perf_event_context <-[1:n]-> perf_event_pmu_context <-[1:n]- perf_event
+ *                                        |                       |
+ *                                        `--[n:1]-> pmu <-[1:n]--'
  *
  *
  * struct perf_event_pmu_context  lifetime is refcount based and RCU freed
@@ -865,6 +865,9 @@ struct perf_event {
  * ctx->mutex pinning the configuration. Since we hold a reference on
  * group_leader (through the filedesc) it can't go away, therefore it's
  * associated pmu_ctx must exist and cannot change due to ctx->mutex.
+ *
+ * perf_event holds a refcount on perf_event_context
+ * perf_event holds a refcount on perf_event_pmu_context
  */
 struct perf_event_pmu_context {
 	struct pmu			*pmu;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 683dc08..b704d83 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4828,6 +4828,11 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 	void *task_ctx_data = NULL;
 
 	if (!ctx->task) {
+		/*
+		 * perf_pmu_migrate_context() / __perf_pmu_install_event()
+		 * relies on the fact that find_get_pmu_context() cannot fail
+		 * for CPU contexts.
+		 */
 		struct perf_cpu_pmu_context *cpc;
 
 		cpc = per_cpu_ptr(pmu->cpu_pmu_context, event->cpu);
@@ -12889,6 +12894,9 @@ static void __perf_pmu_install_event(struct pmu *pmu,
 				     int cpu, struct perf_event *event)
 {
 	struct perf_event_pmu_context *epc;
+	struct perf_event_context *old_ctx = event->ctx;
+
+	get_ctx(ctx); /* normally find_get_context() */
 
 	event->cpu = cpu;
 	epc = find_get_pmu_context(pmu, ctx, event);
@@ -12897,6 +12905,11 @@ static void __perf_pmu_install_event(struct pmu *pmu,
 	if (event->state >= PERF_EVENT_STATE_OFF)
 		event->state = PERF_EVENT_STATE_INACTIVE;
 	perf_install_in_context(ctx, event, cpu);
+
+	/*
+	 * Now that event->ctx is updated and visible, put the old ctx.
+	 */
+	put_ctx(old_ctx);
 }
 
 static void __perf_pmu_install(struct perf_event_context *ctx,
@@ -12935,6 +12948,10 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 	struct perf_event_context *src_ctx, *dst_ctx;
 	LIST_HEAD(events);
 
+	/*
+	 * Since per-cpu context is persistent, no need to grab an extra
+	 * reference.
+	 */
 	src_ctx = &per_cpu_ptr(&perf_cpu_context, src_cpu)->ctx;
 	dst_ctx = &per_cpu_ptr(&perf_cpu_context, dst_cpu)->ctx;
 
