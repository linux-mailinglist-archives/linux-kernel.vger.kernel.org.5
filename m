Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF12786542
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbjHXCTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239328AbjHXCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C710DE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7134652C9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D67C433CC;
        Thu, 24 Aug 2023 02:18:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvw-001hU0-0X;
        Wed, 23 Aug 2023 22:18:52 -0400
Message-ID: <20230824021851.978619174@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:20 -0400
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
Subject: [for-next][PATCH 08/14] tracing/filters: Further optimise scalar vs cpumask comparison
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

Per the previous commits, we now only enter do_filter_scalar_cpumask() with
a mask of weight greater than one. Optimise the equality checks.

Link: https://lkml.kernel.org/r/20230707172155.70873-9-vschneid@redhat.com

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
 kernel/trace/trace_events_filter.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index fd72dacc5d1b..3a529214a21b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -667,6 +667,25 @@ do_filter_cpumask(int op, const struct cpumask *mask, const struct cpumask *cmp)
 /* Optimisation of do_filter_cpumask() for scalar fields */
 static inline int
 do_filter_scalar_cpumask(int op, unsigned int cpu, const struct cpumask *mask)
+{
+	/*
+	 * Per the weight-of-one cpumask optimisations, the mask passed in this
+	 * function has a weight >= 2, so it is never equal to a single scalar.
+	 */
+	switch (op) {
+	case OP_EQ:
+		return false;
+	case OP_NE:
+		return true;
+	case OP_BAND:
+		return cpumask_test_cpu(cpu, mask);
+	default:
+		return 0;
+	}
+}
+
+static inline int
+do_filter_cpumask_scalar(int op, const struct cpumask *mask, unsigned int cpu)
 {
 	switch (op) {
 	case OP_EQ:
@@ -966,12 +985,7 @@ static int filter_pred_cpumask_cpu(struct filter_pred *pred, void *event)
 	const struct cpumask *mask = (event + loc);
 	unsigned int cpu = pred->val;
 
-	/*
-	 * This inverts the usual usage of the function (field is first element,
-	 * user parameter is second), but that's fine because the (scalar, mask)
-	 * operations used are symmetric.
-	 */
-	return do_filter_scalar_cpumask(pred->op, cpu, mask);
+	return do_filter_cpumask_scalar(pred->op, mask, cpu);
 }
 
 /* Filter predicate for COMM. */
-- 
2.40.1
