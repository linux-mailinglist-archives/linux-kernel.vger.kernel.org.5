Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3E784780
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjHVQ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbjHVQ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB9CCDF;
        Tue, 22 Aug 2023 09:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA93765A66;
        Tue, 22 Aug 2023 16:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2E3C433CA;
        Tue, 22 Aug 2023 16:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692721607;
        bh=3tArSSgLBVUpSApZ3ckVBhaESejOigfqYy9S4v1G3b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMuuJ+eJ9KvwevOTqNRKFaQoy//X33dDhuYpwZO9m+fhgx06t6CwHTr9bH0yEP3b+
         GZ7ZVDNnBozeY8bELji1HrKYFzp/VeToolY9ctyepNXUvEHa0ICxDYkfsF1EgDspjn
         9tY7YEoOt54+UIY1kEv7bIQUh0yEDmLzJsJQL3ypeDrWjRWctFizoZ4uTEbOvdQh85
         YJa3r8WvTJlNO3nFLHCRtkI94WYU35ZvIrUdNcgZKdGbmYgfdu1njLCqh5XpM6TE9n
         BCgDJKRAOhyhmq9lYWgyAZzJOGs5UC9CBrPA6pKBo93Se2+xTQPEc2Mk0dd+GkdSqn
         /LUBG+GVS/Y2Q==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v6 7/9] tracing/fprobe-event: Assume fprobe is a return event by $retval
Date:   Wed, 23 Aug 2023 01:26:42 +0900
Message-Id: <169272160261.160970.13613040161560998787.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169272153143.160970.15584603734373446082.stgit@devnote2>
References: <169272153143.160970.15584603734373446082.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Assume the fprobe event is a return event if there is $retval is
used in the probe's argument without %return. e.g.

echo 'f:myevent vfs_read $retval' >> dynamic_events

then 'myevent' is a return probe event.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_fprobe.c                        |   58 +++++++++++++++-----
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    2 -
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 8f43f1f65b1b..8bfe23af9c73 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -898,6 +898,46 @@ static struct tracepoint *find_tracepoint(const char *tp_name)
 	return data.tpoint;
 }
 
+static int parse_symbol_and_return(int argc, const char *argv[],
+				   char **symbol, bool *is_return,
+				   bool is_tracepoint)
+{
+	char *tmp = strchr(argv[1], '%');
+	int i;
+
+	if (tmp) {
+		int len = tmp - argv[1];
+
+		if (!is_tracepoint && !strcmp(tmp, "%return")) {
+			*is_return = true;
+		} else {
+			trace_probe_log_err(len, BAD_ADDR_SUFFIX);
+			return -EINVAL;
+		}
+		*symbol = kmemdup_nul(argv[1], len, GFP_KERNEL);
+	} else
+		*symbol = kstrdup(argv[1], GFP_KERNEL);
+	if (!*symbol)
+		return -ENOMEM;
+
+	if (*is_return)
+		return 0;
+
+	/* If there is $retval, this should be a return fprobe. */
+	for (i = 2; i < argc; i++) {
+		tmp = strstr(argv[i], "$retval");
+		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
+			*is_return = true;
+			/*
+			 * NOTE: Don't check is_tracepoint here, because it will
+			 * be checked when the argument is parsed.
+			 */
+			break;
+		}
+	}
+	return 0;
+}
+
 static int __trace_fprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -927,7 +967,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	struct trace_fprobe *tf = NULL;
 	int i, len, new_argc = 0, ret = 0;
 	bool is_return = false;
-	char *symbol = NULL, *tmp = NULL;
+	char *symbol = NULL;
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
 	const char **new_argv = NULL;
 	int maxactive = 0;
@@ -983,20 +1023,10 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	trace_probe_log_set_index(1);
 
 	/* a symbol(or tracepoint) must be specified */
-	symbol = kstrdup(argv[1], GFP_KERNEL);
-	if (!symbol)
-		return -ENOMEM;
+	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
+	if (ret < 0)
+		goto parse_error;
 
-	tmp = strchr(symbol, '%');
-	if (tmp) {
-		if (!is_tracepoint && !strcmp(tmp, "%return")) {
-			*tmp = '\0';
-			is_return = true;
-		} else {
-			trace_probe_log_err(tmp - symbol, BAD_ADDR_SUFFIX);
-			goto parse_error;
-		}
-	}
 	if (!is_return && maxactive) {
 		trace_probe_log_set_index(0);
 		trace_probe_log_err(1, BAD_MAXACT_TYPE);
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 812f5b3f6055..72563b2e0812 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -30,11 +30,11 @@ check_error 'f:^ vfs_read'		# NO_EVENT_NAME
 check_error 'f:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
 check_error 'f:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
 
-check_error 'f vfs_read ^$retval'	# RETVAL_ON_PROBE
 check_error 'f vfs_read ^$stack10000'	# BAD_STACK_NUM
 
 check_error 'f vfs_read ^$arg10000'	# BAD_ARG_NUM
 
+check_error 'f vfs_read $retval ^$arg1' # BAD_VAR
 check_error 'f vfs_read ^$none_var'	# BAD_VAR
 check_error 'f vfs_read ^'$REG		# BAD_VAR
 

