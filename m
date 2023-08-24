Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84035786546
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbjHXCTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbjHXCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842BE6D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D73F651F5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A9AC433C9;
        Thu, 24 Aug 2023 02:18:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvv-001hSK-1i;
        Wed, 23 Aug 2023 22:18:51 -0400
Message-ID: <20230824021851.347395220@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:17 -0400
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
Subject: [for-next][PATCH 05/14] tracing/filters: Optimise cpumask vs cpumask filtering when user mask
 is a single CPU
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

Steven noted that when the user-provided cpumask contains a single CPU,
then the filtering function can use a scalar as input instead of a
full-fledged cpumask.

Reuse do_filter_scalar_cpumask() when the input mask has a weight of one.

Link: https://lkml.kernel.org/r/20230707172155.70873-6-vschneid@redhat.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 35 +++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3009d0c61b53..2fe65ddeb34e 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -70,6 +70,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_CPU,
 	FILTER_PRED_FN_CPU_CPUMASK,
 	FILTER_PRED_FN_CPUMASK,
+	FILTER_PRED_FN_CPUMASK_CPU,
 	FILTER_PRED_FN_FUNCTION,
 	FILTER_PRED_FN_,
 	FILTER_PRED_TEST_VISITED,
@@ -957,6 +958,22 @@ static int filter_pred_cpumask(struct filter_pred *pred, void *event)
 	return do_filter_cpumask(pred->op, mask, cmp);
 }
 
+/* Filter predicate for cpumask field vs user-provided scalar  */
+static int filter_pred_cpumask_cpu(struct filter_pred *pred, void *event)
+{
+	u32 item = *(u32 *)(event + pred->offset);
+	int loc = item & 0xffff;
+	const struct cpumask *mask = (event + loc);
+	unsigned int cpu = pred->val;
+
+	/*
+	 * This inverts the usual usage of the function (field is first element,
+	 * user parameter is second), but that's fine because the (scalar, mask)
+	 * operations used are symmetric.
+	 */
+	return do_filter_scalar_cpumask(pred->op, cpu, mask);
+}
+
 /* Filter predicate for COMM. */
 static int filter_pred_comm(struct filter_pred *pred, void *event)
 {
@@ -1453,6 +1470,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_cpu_cpumask(pred, event);
 	case FILTER_PRED_FN_CPUMASK:
 		return filter_pred_cpumask(pred, event);
+	case FILTER_PRED_FN_CPUMASK_CPU:
+		return filter_pred_cpumask_cpu(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
 		return filter_pred_function(pred, event);
 	case FILTER_PRED_TEST_VISITED:
@@ -1666,6 +1685,7 @@ static int parse_pred(const char *str, void *data,
 
 	} else if (!strncmp(str + i, "CPUS", 4)) {
 		unsigned int maskstart;
+		bool single;
 		char *tmp;
 
 		switch (field->filter_type) {
@@ -1724,8 +1744,21 @@ static int parse_pred(const char *str, void *data,
 
 		/* Move along */
 		i++;
+
+		/*
+		 * Optimisation: if the user-provided mask has a weight of one
+		 * then we can treat it as a scalar input.
+		 */
+		single = cpumask_weight(pred->mask) == 1;
+		if (single && field->filter_type == FILTER_CPUMASK) {
+			pred->val = cpumask_first(pred->mask);
+			kfree(pred->mask);
+		}
+
 		if (field->filter_type == FILTER_CPUMASK) {
-			pred->fn_num = FILTER_PRED_FN_CPUMASK;
+			pred->fn_num = single ?
+				FILTER_PRED_FN_CPUMASK_CPU :
+				FILTER_PRED_FN_CPUMASK;
 		} else if (field->filter_type == FILTER_CPU) {
 			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
 		} else {
-- 
2.40.1
