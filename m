Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB637E58F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjKHOaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbjKHO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:29:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5602587
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:29:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7287C433C8;
        Wed,  8 Nov 2023 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453780;
        bh=VzChugqmxn2FZXPNNk2q4QjwiB/rKZhvHsJJiY0UHmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8huhepXEVQvNMNpwWfEIX9wzOFTV1QEUN+oYoQwLdTgIddsB7oMiIybr2+lzpPfD
         rUDDNltUn6IhK9XI89AtW8eiNGo1V+ldonu5ycngh6tWc5BvrcDDFA6L3R8y6da5Ic
         1N+QwS0U8sa6Z1EsUy/oKfKtJvxjsIpiv71KzEE+Va6DkegMln6KxQqapcDI2QqvgZ
         jQNS/Gnig11abhGs92yaYfaHwwQfpNmvXXBG3AZ0KMsm0Tm2bhZmZ4Afzg2AbOe+xH
         AHQJWoff/XL0lCZZhUdaBS28zD612mHpNbTcw1c0zUxy7QbQpdlYDgXnDR7e5OLQIM
         wNPF1QH2j+wtw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH v2 27/31] tracing/fprobe: Remove nr_maxactive from fprobe
Date:   Wed,  8 Nov 2023 23:29:34 +0900
Message-Id: <169945377377.55307.15759792710892266775.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Remove depercated fprobe::nr_maxactive. This involves fprobe events to
rejects the maxactive number.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Newly added.
---
 include/linux/fprobe.h      |    2 --
 kernel/trace/trace_fprobe.c |   44 ++++++-------------------------------------
 2 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 08b37b0d1d05..c28d06ddfb8e 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -47,7 +47,6 @@ struct fprobe_hlist {
  * @nmissed: The counter for missing events.
  * @flags: The status flag.
  * @entry_data_size: The private data storage size.
- * @nr_maxactive: The max number of active functions. (*deprecated)
  * @entry_handler: The callback function for function entry.
  * @exit_handler: The callback function for function exit.
  * @hlist_array: The fprobe_hlist for fprobe search from IP hash table.
@@ -56,7 +55,6 @@ struct fprobe {
 	unsigned long		nmissed;
 	unsigned int		flags;
 	size_t			entry_data_size;
-	int			nr_maxactive;
 
 	int (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
 			     unsigned long ret_ip, struct ftrace_regs *regs,
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index c60d0d9f1a95..59d2ef8d9552 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -375,7 +375,6 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 					       const char *event,
 					       const char *symbol,
 					       struct tracepoint *tpoint,
-					       int maxactive,
 					       int nargs, bool is_return)
 {
 	struct trace_fprobe *tf;
@@ -395,7 +394,6 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 		tf->fp.entry_handler = fentry_dispatcher;
 
 	tf->tpoint = tpoint;
-	tf->fp.nr_maxactive = maxactive;
 
 	ret = trace_probe_init(&tf->tp, event, group, false);
 	if (ret < 0)
@@ -973,12 +971,11 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
 	struct trace_fprobe *tf = NULL;
-	int i, len, new_argc = 0, ret = 0;
+	int i, new_argc = 0, ret = 0;
 	bool is_return = false;
 	char *symbol = NULL;
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
 	const char **new_argv = NULL;
-	int maxactive = 0;
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char sbuf[KSYM_NAME_LEN];
@@ -999,33 +996,13 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
 	trace_probe_log_init("trace_fprobe", argc, argv);
 
-	event = strchr(&argv[0][1], ':');
-	if (event)
-		event++;
-
-	if (isdigit(argv[0][1])) {
-		if (event)
-			len = event - &argv[0][1] - 1;
-		else
-			len = strlen(&argv[0][1]);
-		if (len > MAX_EVENT_NAME_LEN - 1) {
-			trace_probe_log_err(1, BAD_MAXACT);
-			goto parse_error;
-		}
-		memcpy(buf, &argv[0][1], len);
-		buf[len] = '\0';
-		ret = kstrtouint(buf, 0, &maxactive);
-		if (ret || !maxactive) {
+	if (argv[0][1] != '\0') {
+		if (argv[0][1] != ':') {
+			trace_probe_log_set_index(0);
 			trace_probe_log_err(1, BAD_MAXACT);
 			goto parse_error;
 		}
-		/* fprobe rethook instances are iterated over via a list. The
-		 * maximum should stay reasonable.
-		 */
-		if (maxactive > RETHOOK_MAXACTIVE_MAX) {
-			trace_probe_log_err(1, MAXACT_TOO_BIG);
-			goto parse_error;
-		}
+		event = &argv[0][2];
 	}
 
 	trace_probe_log_set_index(1);
@@ -1035,12 +1012,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	if (ret < 0)
 		goto parse_error;
 
-	if (!is_return && maxactive) {
-		trace_probe_log_set_index(0);
-		trace_probe_log_err(1, BAD_MAXACT_TYPE);
-		goto parse_error;
-	}
-
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
@@ -1094,8 +1065,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	}
 
 	/* setup a probe */
-	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
-				argc, is_return);
+	tf = alloc_trace_fprobe(group, event, symbol, tpoint, argc, is_return);
 	if (IS_ERR(tf)) {
 		ret = PTR_ERR(tf);
 		/* This must return -ENOMEM, else there is a bug */
@@ -1171,8 +1141,6 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
 		seq_putc(m, 't');
 	else
 		seq_putc(m, 'f');
-	if (trace_fprobe_is_return(tf) && tf->fp.nr_maxactive)
-		seq_printf(m, "%d", tf->fp.nr_maxactive);
 	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
 				trace_probe_name(&tf->tp));
 

