Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15CC7EB8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjKNV46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjKNV4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:56:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70038D6;
        Tue, 14 Nov 2023 13:56:51 -0800 (PST)
Date:   Tue, 14 Nov 2023 21:56:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699999009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYr1U+hqW8z8NDe7fU2P96uRXyUsLHKUNnItYoIx7xA=;
        b=Lk1J4vqgTEn7LqP2S4wBYEPbbQihzELUr8yGdOzbWjhL8yNQcRosA8J2OJZgW14n1wOZs9
        tkPj3eYxG68l8WRGa5zpQC4s9r57RNMwEcxD7EWFT+ojRUjMs2V34mb2CL2SNXo1YeftJe
        5ozMosAPkdKpf8YcfRAXQvUx1Tup8WBHetvofTN50OWTCXwVQiuu1pToU4FSO9ffmpVc81
        Gwsc+u1lQlfE2hnaiqIrziUwQgfbB1Z5QfvfBk0BY8RwVpp/kv/u3oYHsqELJMwdpOXbrM
        xYCxol5InH7MLmTNI1sTwUxXxUl3BWJtaaBbdwj6CoAKSuT1KceUulnsADcstg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699999009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYr1U+hqW8z8NDe7fU2P96uRXyUsLHKUNnItYoIx7xA=;
        b=VznPNdtjmX8kkobLTTTJZVUqPIkuoqY4UTRZ6S/sRXg0a7K6AWyMfGnt7KJnwkDgfa8J5p
        MJ8LI7gE9vv9I+DQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix cpuctx refcounting
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230612093539.085862001@infradead.org>
References: <20230612093539.085862001@infradead.org>
MIME-Version: 1.0
Message-ID: <169999900905.391.7191385772913382509.tip-bot2@tip-bot2>
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

Commit-ID:     cfaf1b99ac72d339c586d053885554dbe169d276
Gitweb:        https://git.kernel.org/tip/cfaf1b99ac72d339c586d053885554dbe169d276
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 12:34:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Nov 2023 22:27:28 +01:00

perf: Fix cpuctx refcounting

Audit of the refcounting turned up that perf_pmu_migrate_context()
fails to migrate the ctx refcount.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230612093539.085862001@infradead.org
---
 include/linux/perf_event.h | 13 ++++++++-----
 kernel/events/core.c       | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4b93ff1..d2a15c0 100644
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
index ce984aa..0825098 100644
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
@@ -12897,6 +12902,9 @@ static void __perf_pmu_install_event(struct pmu *pmu,
 				     int cpu, struct perf_event *event)
 {
 	struct perf_event_pmu_context *epc;
+	struct perf_event_context *old_ctx = event->ctx;
+
+	get_ctx(ctx); /* normally find_get_context() */
 
 	event->cpu = cpu;
 	epc = find_get_pmu_context(pmu, ctx, event);
@@ -12905,6 +12913,11 @@ static void __perf_pmu_install_event(struct pmu *pmu,
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
@@ -12943,6 +12956,10 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 	struct perf_event_context *src_ctx, *dst_ctx;
 	LIST_HEAD(events);
 
+	/*
+	 * Since per-cpu context is persistent, no need to grab an extra
+	 * reference.
+	 */
 	src_ctx = &per_cpu_ptr(&perf_cpu_context, src_cpu)->ctx;
 	dst_ctx = &per_cpu_ptr(&perf_cpu_context, dst_cpu)->ctx;
 
