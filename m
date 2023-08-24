Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E3C78653E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbjHXCTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbjHXCSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A185910D9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32FA863BC0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9259EC433A9;
        Thu, 24 Aug 2023 02:18:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvv-001hRm-13;
        Wed, 23 Aug 2023 22:18:51 -0400
Message-ID: <20230824021851.138306628@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:16 -0400
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
Subject: [for-next][PATCH 04/14] tracing/filters: Enable filtering the CPU common field by a cpumask
References: <20230824021812.938245293@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <vschneid@redhat.com>

The tracing_cpumask lets us specify which CPUs are traced in a buffer
instance, but doesn't let us do this on a per-event basis (unless one
creates an instance per event).

A previous commit added filtering scalar fields by a user-given cpumask,
make this work with the CPU common field as well.

This enables doing things like

$ trace-cmd record -e 'sched_switch' -f 'CPU & CPUS{12-52}' \
		   -e 'sched_wakeup' -f 'target_cpu & CPUS{12-52}'

Link: https://lkml.kernel.org/r/20230707172155.70873-5-vschneid@redhat.com

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
 kernel/trace/trace_events_filter.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1e14f801685a..3009d0c61b53 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -68,6 +68,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_PCHAR_USER,
 	FILTER_PRED_FN_PCHAR,
 	FILTER_PRED_FN_CPU,
+	FILTER_PRED_FN_CPU_CPUMASK,
 	FILTER_PRED_FN_CPUMASK,
 	FILTER_PRED_FN_FUNCTION,
 	FILTER_PRED_FN_,
@@ -937,6 +938,14 @@ static int filter_pred_cpu(struct filter_pred *pred, void *event)
 	}
 }
 
+/* Filter predicate for current CPU vs user-provided cpumask */
+static int filter_pred_cpu_cpumask(struct filter_pred *pred, void *event)
+{
+	int cpu = raw_smp_processor_id();
+
+	return do_filter_scalar_cpumask(pred->op, cpu, pred->mask);
+}
+
 /* Filter predicate for cpumask field vs user-provided cpumask */
 static int filter_pred_cpumask(struct filter_pred *pred, void *event)
 {
@@ -1440,6 +1449,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_pchar(pred, event);
 	case FILTER_PRED_FN_CPU:
 		return filter_pred_cpu(pred, event);
+	case FILTER_PRED_FN_CPU_CPUMASK:
+		return filter_pred_cpu_cpumask(pred, event);
 	case FILTER_PRED_FN_CPUMASK:
 		return filter_pred_cpumask(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
@@ -1659,6 +1670,7 @@ static int parse_pred(const char *str, void *data,
 
 		switch (field->filter_type) {
 		case FILTER_CPUMASK:
+		case FILTER_CPU:
 		case FILTER_OTHER:
 			break;
 		default:
@@ -1714,6 +1726,8 @@ static int parse_pred(const char *str, void *data,
 		i++;
 		if (field->filter_type == FILTER_CPUMASK) {
 			pred->fn_num = FILTER_PRED_FN_CPUMASK;
+		} else if (field->filter_type == FILTER_CPU) {
+			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
 		} else {
 			switch (field->size) {
 			case 8:
-- 
2.40.1
