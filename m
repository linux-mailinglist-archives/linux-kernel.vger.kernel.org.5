Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB578653A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbjHXCTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbjHXCSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5839110D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E54D664AB2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FDEC433CC;
        Thu, 24 Aug 2023 02:18:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvv-001hRE-0N;
        Wed, 23 Aug 2023 22:18:51 -0400
Message-ID: <20230824021850.933540258@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [for-next][PATCH 03/14] tracing/filters: Enable filtering a scalar field by a cpumask
References: <20230824021812.938245293@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <vschneid@redhat.com>

Several events use a scalar field to denote a CPU:
o sched_wakeup.target_cpu
o sched_migrate_task.orig_cpu,dest_cpu
o sched_move_numa.src_cpu,dst_cpu
o ipi_send_cpu.cpu
o ...

Filtering these currently requires using arithmetic comparison functions,
which can be tedious when dealing with interleaved SMT or NUMA CPU ids.

Allow these to be filtered by a user-provided cpumask, which enables e.g.:

$ trace-cmd record -e 'sched_wakeup' -f 'target_cpu & CPUS{2,4,6,8-32}'

Link: https://lkml.kernel.org/r/20230707172155.70873-4-vschneid@redhat.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 92 ++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index cb1863dfa280..1e14f801685a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -46,15 +46,19 @@ static const char * ops[] = { OPS };
 enum filter_pred_fn {
 	FILTER_PRED_FN_NOP,
 	FILTER_PRED_FN_64,
+	FILTER_PRED_FN_64_CPUMASK,
 	FILTER_PRED_FN_S64,
 	FILTER_PRED_FN_U64,
 	FILTER_PRED_FN_32,
+	FILTER_PRED_FN_32_CPUMASK,
 	FILTER_PRED_FN_S32,
 	FILTER_PRED_FN_U32,
 	FILTER_PRED_FN_16,
+	FILTER_PRED_FN_16_CPUMASK,
 	FILTER_PRED_FN_S16,
 	FILTER_PRED_FN_U16,
 	FILTER_PRED_FN_8,
+	FILTER_PRED_FN_8_CPUMASK,
 	FILTER_PRED_FN_S8,
 	FILTER_PRED_FN_U8,
 	FILTER_PRED_FN_COMM,
@@ -643,6 +647,39 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	return ERR_PTR(ret);
 }
 
+static inline int
+do_filter_cpumask(int op, const struct cpumask *mask, const struct cpumask *cmp)
+{
+	switch (op) {
+	case OP_EQ:
+		return cpumask_equal(mask, cmp);
+	case OP_NE:
+		return !cpumask_equal(mask, cmp);
+	case OP_BAND:
+		return cpumask_intersects(mask, cmp);
+	default:
+		return 0;
+	}
+}
+
+/* Optimisation of do_filter_cpumask() for scalar fields */
+static inline int
+do_filter_scalar_cpumask(int op, unsigned int cpu, const struct cpumask *mask)
+{
+	switch (op) {
+	case OP_EQ:
+		return cpumask_test_cpu(cpu, mask) &&
+			cpumask_nth(1, mask) >= nr_cpu_ids;
+	case OP_NE:
+		return !cpumask_test_cpu(cpu, mask) ||
+			cpumask_nth(1, mask) < nr_cpu_ids;
+	case OP_BAND:
+		return cpumask_test_cpu(cpu, mask);
+	default:
+		return 0;
+	}
+}
+
 enum pred_cmp_types {
 	PRED_CMP_TYPE_NOP,
 	PRED_CMP_TYPE_LT,
@@ -686,6 +723,18 @@ static int filter_pred_##type(struct filter_pred *pred, void *event)	\
 	}								\
 }
 
+#define DEFINE_CPUMASK_COMPARISON_PRED(size)					\
+static int filter_pred_##size##_cpumask(struct filter_pred *pred, void *event)	\
+{										\
+	u##size *addr = (u##size *)(event + pred->offset);			\
+	unsigned int cpu = *addr;						\
+										\
+	if (cpu >= nr_cpu_ids)							\
+		return 0;							\
+										\
+	return do_filter_scalar_cpumask(pred->op, cpu, pred->mask);		\
+}
+
 #define DEFINE_EQUALITY_PRED(size)					\
 static int filter_pred_##size(struct filter_pred *pred, void *event)	\
 {									\
@@ -707,6 +756,11 @@ DEFINE_COMPARISON_PRED(u16);
 DEFINE_COMPARISON_PRED(s8);
 DEFINE_COMPARISON_PRED(u8);
 
+DEFINE_CPUMASK_COMPARISON_PRED(64);
+DEFINE_CPUMASK_COMPARISON_PRED(32);
+DEFINE_CPUMASK_COMPARISON_PRED(16);
+DEFINE_CPUMASK_COMPARISON_PRED(8);
+
 DEFINE_EQUALITY_PRED(64);
 DEFINE_EQUALITY_PRED(32);
 DEFINE_EQUALITY_PRED(16);
@@ -891,16 +945,7 @@ static int filter_pred_cpumask(struct filter_pred *pred, void *event)
 	const struct cpumask *mask = (event + loc);
 	const struct cpumask *cmp = pred->mask;
 
-	switch (pred->op) {
-	case OP_EQ:
-		return cpumask_equal(mask, cmp);
-	case OP_NE:
-		return !cpumask_equal(mask, cmp);
-	case OP_BAND:
-		return cpumask_intersects(mask, cmp);
-	default:
-		return 0;
-	}
+	return do_filter_cpumask(pred->op, mask, cmp);
 }
 
 /* Filter predicate for COMM. */
@@ -1351,24 +1396,32 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 	switch (pred->fn_num) {
 	case FILTER_PRED_FN_64:
 		return filter_pred_64(pred, event);
+	case FILTER_PRED_FN_64_CPUMASK:
+		return filter_pred_64_cpumask(pred, event);
 	case FILTER_PRED_FN_S64:
 		return filter_pred_s64(pred, event);
 	case FILTER_PRED_FN_U64:
 		return filter_pred_u64(pred, event);
 	case FILTER_PRED_FN_32:
 		return filter_pred_32(pred, event);
+	case FILTER_PRED_FN_32_CPUMASK:
+		return filter_pred_32_cpumask(pred, event);
 	case FILTER_PRED_FN_S32:
 		return filter_pred_s32(pred, event);
 	case FILTER_PRED_FN_U32:
 		return filter_pred_u32(pred, event);
 	case FILTER_PRED_FN_16:
 		return filter_pred_16(pred, event);
+	case FILTER_PRED_FN_16_CPUMASK:
+		return filter_pred_16_cpumask(pred, event);
 	case FILTER_PRED_FN_S16:
 		return filter_pred_s16(pred, event);
 	case FILTER_PRED_FN_U16:
 		return filter_pred_u16(pred, event);
 	case FILTER_PRED_FN_8:
 		return filter_pred_8(pred, event);
+	case FILTER_PRED_FN_8_CPUMASK:
+		return filter_pred_8_cpumask(pred, event);
 	case FILTER_PRED_FN_S8:
 		return filter_pred_s8(pred, event);
 	case FILTER_PRED_FN_U8:
@@ -1606,6 +1659,7 @@ static int parse_pred(const char *str, void *data,
 
 		switch (field->filter_type) {
 		case FILTER_CPUMASK:
+		case FILTER_OTHER:
 			break;
 		default:
 			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
@@ -1658,8 +1712,24 @@ static int parse_pred(const char *str, void *data,
 
 		/* Move along */
 		i++;
-		if (field->filter_type == FILTER_CPUMASK)
+		if (field->filter_type == FILTER_CPUMASK) {
 			pred->fn_num = FILTER_PRED_FN_CPUMASK;
+		} else {
+			switch (field->size) {
+			case 8:
+				pred->fn_num = FILTER_PRED_FN_64_CPUMASK;
+				break;
+			case 4:
+				pred->fn_num = FILTER_PRED_FN_32_CPUMASK;
+				break;
+			case 2:
+				pred->fn_num = FILTER_PRED_FN_16_CPUMASK;
+				break;
+			case 1:
+				pred->fn_num = FILTER_PRED_FN_8_CPUMASK;
+				break;
+			}
+		}
 
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
-- 
2.40.1
