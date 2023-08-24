Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253EA786539
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbjHXCTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239266AbjHXCSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D310C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C15B633C6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34E6C433C9;
        Thu, 24 Aug 2023 02:18:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYzvu-001hQ7-2H;
        Wed, 23 Aug 2023 22:18:50 -0400
Message-ID: <20230824021850.515849153@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Aug 2023 22:18:13 -0400
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
Subject: [for-next][PATCH 01/14] tracing/filters: Dynamically allocate filter_pred.regex
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

Every predicate allocation includes a MAX_FILTER_STR_VAL (256) char array
in the regex field, even if the predicate function does not use the field.

A later commit will introduce a dynamically allocated cpumask to struct
filter_pred, which will require a dedicated freeing function. Bite the
bullet and make filter_pred.regex dynamically allocated.

While at it, reorder the fields of filter_pred to fill in the byte
holes. The struct now fits on a single cacheline.

No change in behaviour intended.

The kfree()'s were patched via Coccinelle:
  @@
  struct filter_pred *pred;
  @@

  -kfree(pred);
  +free_predicate(pred);

Link: https://lkml.kernel.org/r/20230707172155.70873-2-vschneid@redhat.com

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
 kernel/trace/trace_events_filter.c | 64 ++++++++++++++++++------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1dad64267878..91fc9990107f 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -70,15 +70,15 @@ enum filter_pred_fn {
 };
 
 struct filter_pred {
-	enum filter_pred_fn 	fn_num;
-	u64 			val;
-	u64 			val2;
-	struct regex		regex;
+	struct regex		*regex;
 	unsigned short		*ops;
 	struct ftrace_event_field *field;
-	int 			offset;
+	u64			val;
+	u64			val2;
+	enum filter_pred_fn	fn_num;
+	int			offset;
 	int			not;
-	int 			op;
+	int			op;
 };
 
 /*
@@ -186,6 +186,14 @@ enum {
 	PROCESS_OR	= 4,
 };
 
+static void free_predicate(struct filter_pred *pred)
+{
+	if (pred) {
+		kfree(pred->regex);
+		kfree(pred);
+	}
+}
+
 /*
  * Without going into a formal proof, this explains the method that is used in
  * parsing the logical expressions.
@@ -623,7 +631,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	kfree(inverts);
 	if (prog_stack) {
 		for (i = 0; prog_stack[i].pred; i++)
-			kfree(prog_stack[i].pred);
+			free_predicate(prog_stack[i].pred);
 		kfree(prog_stack);
 	}
 	return ERR_PTR(ret);
@@ -750,7 +758,7 @@ static int filter_pred_string(struct filter_pred *pred, void *event)
 	char *addr = (char *)(event + pred->offset);
 	int cmp, match;
 
-	cmp = pred->regex.match(addr, &pred->regex, pred->regex.field_len);
+	cmp = pred->regex->match(addr, pred->regex, pred->regex->field_len);
 
 	match = cmp ^ pred->not;
 
@@ -763,7 +771,7 @@ static __always_inline int filter_pchar(struct filter_pred *pred, char *str)
 	int len;
 
 	len = strlen(str) + 1;	/* including tailing '\0' */
-	cmp = pred->regex.match(str, &pred->regex, len);
+	cmp = pred->regex->match(str, pred->regex, len);
 
 	match = cmp ^ pred->not;
 
@@ -813,7 +821,7 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
 	char *addr = (char *)(event + str_loc);
 	int cmp, match;
 
-	cmp = pred->regex.match(addr, &pred->regex, str_len);
+	cmp = pred->regex->match(addr, pred->regex, str_len);
 
 	match = cmp ^ pred->not;
 
@@ -836,7 +844,7 @@ static int filter_pred_strrelloc(struct filter_pred *pred, void *event)
 	char *addr = (char *)(&item[1]) + str_loc;
 	int cmp, match;
 
-	cmp = pred->regex.match(addr, &pred->regex, str_len);
+	cmp = pred->regex->match(addr, pred->regex, str_len);
 
 	match = cmp ^ pred->not;
 
@@ -874,7 +882,7 @@ static int filter_pred_comm(struct filter_pred *pred, void *event)
 {
 	int cmp;
 
-	cmp = pred->regex.match(current->comm, &pred->regex,
+	cmp = pred->regex->match(current->comm, pred->regex,
 				TASK_COMM_LEN);
 	return cmp ^ pred->not;
 }
@@ -1004,7 +1012,7 @@ enum regex_type filter_parse_regex(char *buff, int len, char **search, int *not)
 
 static void filter_build_regex(struct filter_pred *pred)
 {
-	struct regex *r = &pred->regex;
+	struct regex *r = pred->regex;
 	char *search;
 	enum regex_type type = MATCH_FULL;
 
@@ -1169,7 +1177,7 @@ static void free_prog(struct event_filter *filter)
 		return;
 
 	for (i = 0; prog[i].pred; i++)
-		kfree(prog[i].pred);
+		free_predicate(prog[i].pred);
 	kfree(prog);
 }
 
@@ -1553,9 +1561,12 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
-		pred->regex.len = len;
-		strncpy(pred->regex.pattern, str + s, len);
-		pred->regex.pattern[len] = 0;
+		pred->regex = kzalloc(sizeof(*pred->regex), GFP_KERNEL);
+		if (!pred->regex)
+			goto err_mem;
+		pred->regex->len = len;
+		strncpy(pred->regex->pattern, str + s, len);
+		pred->regex->pattern[len] = 0;
 
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
@@ -1597,9 +1608,12 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
-		pred->regex.len = len;
-		strncpy(pred->regex.pattern, str + s, len);
-		pred->regex.pattern[len] = 0;
+		pred->regex = kzalloc(sizeof(*pred->regex), GFP_KERNEL);
+		if (!pred->regex)
+			goto err_mem;
+		pred->regex->len = len;
+		strncpy(pred->regex->pattern, str + s, len);
+		pred->regex->pattern[len] = 0;
 
 		filter_build_regex(pred);
 
@@ -1608,7 +1622,7 @@ static int parse_pred(const char *str, void *data,
 
 		} else if (field->filter_type == FILTER_STATIC_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRING;
-			pred->regex.field_len = field->size;
+			pred->regex->field_len = field->size;
 
 		} else if (field->filter_type == FILTER_DYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRLOC;
@@ -1691,10 +1705,10 @@ static int parse_pred(const char *str, void *data,
 	return i;
 
 err_free:
-	kfree(pred);
+	free_predicate(pred);
 	return -EINVAL;
 err_mem:
-	kfree(pred);
+	free_predicate(pred);
 	return -ENOMEM;
 }
 
@@ -2287,8 +2301,8 @@ static int ftrace_function_set_filter_pred(struct filter_pred *pred,
 		return ret;
 
 	return __ftrace_function_set_filter(pred->op == OP_EQ,
-					    pred->regex.pattern,
-					    pred->regex.len,
+					    pred->regex->pattern,
+					    pred->regex->len,
 					    data);
 }
 
-- 
2.40.1
