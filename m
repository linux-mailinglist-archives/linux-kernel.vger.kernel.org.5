Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872257567D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjGQPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjGQPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B8E1735;
        Mon, 17 Jul 2023 08:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 893F0610F4;
        Mon, 17 Jul 2023 15:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECED0C433C8;
        Mon, 17 Jul 2023 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689607452;
        bh=HNw7NmAJWJoLfuOb7lcwr0tG/Yg91E6W1MXYrCfkES8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUWZzB8ih/Pn17MNMbs4bLT6F3qq7F/IIIg66MNQnM/DH93rG0K9UG221F0zupoZZ
         O8oW/qK3mGyNFuNNcZkDuie4iQeVW++xBPymTfa82sLjllXjEsGcNw5l2PsHu/PRvx
         wF05Fc0Ew3ZII0weMaCacrFY2FKt74DBReB0ND1/u87o8reC3fXiDsXcraOkeRYLGK
         GqGnDPhFHYD1elbCbub6fi9URBamkp6az5E8dpcjqCzL+r13FIzSxRRUbdxMHXsKyJ
         QnfxwukYukf9m52v9zeqdsOAM7niAy1zWZ0hxrqZEeaI5gtH3xyW8K9mb1kbkFMScI
         VYQVMZlWdIX6w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 5/9] tracing/probes: Support BTF field access from $retval
Date:   Tue, 18 Jul 2023 00:24:07 +0900
Message-Id: <168960744719.34107.443329109565685838.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168960739768.34107.15145201749042174448.stgit@devnote2>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Support BTF argument on '$retval' for function return events including
kretprobe and fprobe for accessing the return value.
This also allows user to access its fields if the return value is a
pointer of a data structure.

E.g.
 # echo 'f getname_flags%return +0($retval->name):string' \
   > dynamic_events
 # echo 1 > events/fprobes/getname_flags__exit/enable
 # ls > /dev/null
 # head -n 40 trace | tail
              ls-87      [000] ...1.  8067.616101: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./function_profile_enabled"
              ls-87      [000] ...1.  8067.616108: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./trace_stat"
              ls-87      [000] ...1.  8067.616115: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_graph_notrace"
              ls-87      [000] ...1.  8067.616122: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_graph_function"
              ls-87      [000] ...1.  8067.616129: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_notrace"
              ls-87      [000] ...1.  8067.616135: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_filter"
              ls-87      [000] ...1.  8067.616143: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./touched_functions"
              ls-87      [000] ...1.  8067.616237: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./enabled_functions"
              ls-87      [000] ...1.  8067.616245: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./available_filter_functions"
              ls-87      [000] ...1.  8067.616253: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_notrace_pid"


Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Use '$retval' instead of 'retval' because it is confusing.
---
 kernel/trace/trace_probe.c |   98 +++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 61 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index dd646d35637d..4442ff9c2728 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -536,6 +536,22 @@ static int parse_btf_arg(char *varname,
 		return -EOPNOTSUPP;
 	}
 
+	if (ctx->flags & TPARG_FL_RETURN) {
+		if (strcmp(varname, "$retval") != 0) {
+			trace_probe_log_err(ctx->offset, NO_BTFARG);
+			return -ENOENT;
+		}
+		/* Check whether the function return type is not void */
+		type = btf_find_func_proto(btf, ctx->funcname);
+		if (!IS_ERR_OR_NULL(type) && type->type == 0) {
+			trace_probe_log_err(ctx->offset, NO_RETVAL);
+			return -ENOENT;
+		}
+		code->op = FETCH_OP_RETVAL;
+		tid = type->type;
+		goto found;
+	}
+
 	if (!ctx->params) {
 		params = find_btf_func_param(ctx->funcname, &ctx->nr_params,
 					     ctx->flags & TPARG_FL_TPOINT);
@@ -556,7 +572,6 @@ static int parse_btf_arg(char *varname,
 				code->param = i + 1;
 			else
 				code->param = i;
-
 			tid = params[i].type;
 			goto found;
 		}
@@ -581,7 +596,7 @@ static int parse_btf_arg(char *varname,
 	return 0;
 }
 
-static const struct fetch_type *parse_btf_arg_type(
+static const struct fetch_type *find_fetch_type_from_btf_type(
 					struct traceprobe_parse_context *ctx)
 {
 	struct btf *btf = traceprobe_get_btf();
@@ -593,26 +608,6 @@ static const struct fetch_type *parse_btf_arg_type(
 	return find_fetch_type(typestr, ctx->flags);
 }
 
-static const struct fetch_type *parse_btf_retval_type(
-					struct traceprobe_parse_context *ctx)
-{
-	struct btf *btf = traceprobe_get_btf();
-	const char *typestr = NULL;
-	const struct btf_type *type;
-	s32 tid;
-
-	if (btf && ctx->funcname) {
-		type = btf_find_func_proto(btf, ctx->funcname);
-		if (!IS_ERR_OR_NULL(type)) {
-			type = btf_type_skip_modifiers(btf, type->type, &tid);
-			if (!IS_ERR_OR_NULL(type))
-				typestr = fetch_type_from_btf_type(btf, type, ctx);
-		}
-	}
-
-	return find_fetch_type(typestr, ctx->flags);
-}
-
 static int parse_btf_bitfield(struct fetch_insn **pcode,
 			      struct traceprobe_parse_context *ctx)
 {
@@ -635,20 +630,6 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 	return 0;
 }
 
-static bool is_btf_retval_void(const char *funcname)
-{
-	struct btf *btf = traceprobe_get_btf();
-	const struct btf_type *t;
-
-	if (!btf)
-		return false;
-
-	t = btf_find_func_proto(btf, funcname);
-	if (IS_ERR_OR_NULL(t))
-		return false;
-
-	return t->type == 0;
-}
 #else
 static struct btf *traceprobe_get_btf(void)
 {
@@ -676,24 +657,23 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 	return -EOPNOTSUPP;
 }
 
-#define parse_btf_arg_type(ctx)		\
-	find_fetch_type(NULL, ctx->flags)
-
-#define parse_btf_retval_type(ctx)		\
+#define find_fetch_type_from_btf_type(ctx)		\
 	find_fetch_type(NULL, ctx->flags)
 
-#define is_btf_retval_void(funcname)	(false)
-
 #endif
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
-static int parse_probe_vars(char *arg, const struct fetch_type *t,
-			    struct fetch_insn *code,
+/* Parse $vars. @orig_arg points '$', which syncs to @ctx->offset */
+static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
+			    struct fetch_insn **pcode,
+			    struct fetch_insn *end,
 			    struct traceprobe_parse_context *ctx)
 {
-	unsigned long param;
+	struct fetch_insn *code = *pcode;
 	int err = TP_ERR_BAD_VAR;
+	char *arg = orig_arg + 1;
+	unsigned long param;
 	int ret = 0;
 	int len;
 
@@ -712,18 +692,17 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 		goto inval;
 	}
 
-	if (strcmp(arg, "retval") == 0) {
-		if (ctx->flags & TPARG_FL_RETURN) {
-			if ((ctx->flags & TPARG_FL_KERNEL) &&
-			    is_btf_retval_void(ctx->funcname)) {
-				err = TP_ERR_NO_RETVAL;
-				goto inval;
-			}
+	if (str_has_prefix(arg, "retval")) {
+		if (!(ctx->flags & TPARG_FL_RETURN)) {
+			err = TP_ERR_RETVAL_ON_PROBE;
+			goto inval;
+		}
+		if (!(ctx->flags & TPARG_FL_KERNEL) ||
+		    !IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS)) {
 			code->op = FETCH_OP_RETVAL;
 			return 0;
 		}
-		err = TP_ERR_RETVAL_ON_PROBE;
-		goto inval;
+		return parse_btf_arg(orig_arg, pcode, end, ctx);
 	}
 
 	len = str_has_prefix(arg, "stack");
@@ -825,7 +804,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 	switch (arg[0]) {
 	case '$':
-		ret = parse_probe_vars(arg + 1, type, code, ctx);
+		ret = parse_probe_vars(arg, type, pcode, end, ctx);
 		break;
 
 	case '%':	/* named register */
@@ -1122,12 +1101,9 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		goto fail;
 
 	/* Update storing type if BTF is available */
-	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) && !t) {
-		if (ctx->last_type)
-			parg->type = parse_btf_arg_type(ctx);
-		else if (ctx->flags & TPARG_FL_RETURN)
-			parg->type = parse_btf_retval_type(ctx);
-	}
+	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
+	    !t && ctx->last_type)
+		parg->type = find_fetch_type_from_btf_type(ctx);
 
 	ret = -EINVAL;
 	/* Store operation */

