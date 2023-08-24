Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760E4786549
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbjHXCTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbjHXCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A636C10C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9ACB64D73
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28911C43395;
        Thu, 24 Aug 2023 02:18:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvv-001hTS-35;
        Wed, 23 Aug 2023 22:18:51 -0400
Message-ID: <20230824021851.768193955@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:19 -0400
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
Subject: [for-next][PATCH 07/14] tracing/filters: Optimise CPU vs cpumask filtering when the user mask
 is a single CPU
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

Steven noted that when the user-provided cpumask contains a single CPU,
then the filtering function can use a scalar as input instead of a
full-fledged cpumask.

In this case we can directly re-use filter_pred_cpu(), we just need to
transform '&' into '==' before executing it.

Link: https://lkml.kernel.org/r/20230707172155.70873-8-vschneid@redhat.com

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
 kernel/trace/trace_events_filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 54d642fabb7f..fd72dacc5d1b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1750,7 +1750,7 @@ static int parse_pred(const char *str, void *data,
 		 * then we can treat it as a scalar input.
 		 */
 		single = cpumask_weight(pred->mask) == 1;
-		if (single && field->filter_type != FILTER_CPU) {
+		if (single) {
 			pred->val = cpumask_first(pred->mask);
 			kfree(pred->mask);
 		}
@@ -1760,7 +1760,12 @@ static int parse_pred(const char *str, void *data,
 				FILTER_PRED_FN_CPUMASK_CPU :
 				FILTER_PRED_FN_CPUMASK;
 		} else if (field->filter_type == FILTER_CPU) {
-			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
+			if (single) {
+				pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
+				pred->fn_num = FILTER_PRED_FN_CPU;
+			} else {
+				pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
+			}
 		} else if (single) {
 			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
 			pred->fn_num = select_comparison_fn(pred->op, field->size, false);
-- 
2.40.1
