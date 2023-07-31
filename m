Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5614768ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGaHc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjGaHbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:31:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5B010CC;
        Mon, 31 Jul 2023 00:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEFE660F32;
        Mon, 31 Jul 2023 07:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A096C433C8;
        Mon, 31 Jul 2023 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690788667;
        bh=QCbDVf1VPNh57Ufpzf7xem7rI1/giuALEFEtHjhBjWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrNR1tgQgrdgasqTE6MuVSLiszRgirrlY3roSxl4LcL4xqQZaSjxnsJl3gxlDMcxN
         3CqmQLrhVC73A4A398nIK5O49ocamGPUHzFv7vUsj3YaZxATgbTMQgTFFx+7nYQic7
         IuR97qGalBhx/Iwwgpx8FJkGOTZ3W90Y+G/i6CISKyVYXmLJ8caqLvEpvk4GDOfyIy
         tEAOfuMbuJy2V3W4FgT9xUPp54QivJl5T49kw5LWY37tNZy3+9ykiIMjsORI9U7/hg
         FbJsfVNpYT23EliqObc/bPoKWrXvC1HMm+Db6vfdyJIz6yvZKF6Pc13oCvkoWyCVBL
         DlnBFTIc13DHg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 6/9] tracing/probes: Add string type check with BTF
Date:   Mon, 31 Jul 2023 16:31:03 +0900
Message-Id: <169078866330.173706.18430839904581751211.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169078860386.173706.3091034523220945605.stgit@devnote2>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
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

Add a string type checking with BTF information if possible.
This will check whether the given BTF argument (and field) is
signed char array or pointer to signed char. If not, it reject
the 'string' type. If it is pointer to signed char, it adds
a dereference opration so that it can correctly fetch the
string data from memory.

 # echo 'f getname_flags%return retval->name:string' >> dynamic_events
 # echo 't sched_switch next->comm:string' >> dynamic_events

The above cases, 'struct filename::name' is 'char *' and
'struct task_struct::comm' is 'char []'. But in both case,
user can specify ':string' to fetch the string data.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Use ctx->btf instead of traceprobe_get_btf().
---
 kernel/trace/trace_probe.c |   89 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h |    3 +
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8ce7d8f04849..46a604f786c5 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -309,6 +309,77 @@ static u32 btf_type_int(const struct btf_type *t)
 	return *(u32 *)(t + 1);
 }
 
+static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
+{
+	const struct btf_type *real_type;
+	u32 intdata;
+	s32 tid;
+
+	real_type = btf_type_skip_modifiers(btf, type->type, &tid);
+	if (!real_type)
+		return false;
+
+	if (BTF_INFO_KIND(real_type->info) != BTF_KIND_INT)
+		return false;
+
+	intdata = btf_type_int(real_type);
+	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
+		&& BTF_INT_BITS(intdata) == 8;
+}
+
+static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
+{
+	const struct btf_type *real_type;
+	const struct btf_array *array;
+	u32 intdata;
+	s32 tid;
+
+	if (BTF_INFO_KIND(type->info) != BTF_KIND_ARRAY)
+		return false;
+
+	array = (const struct btf_array *)(type + 1);
+
+	real_type = btf_type_skip_modifiers(btf, array->type, &tid);
+
+	intdata = btf_type_int(real_type);
+	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
+		&& BTF_INT_BITS(intdata) == 8;
+}
+
+static int check_prepare_btf_string_fetch(char *typename,
+				struct fetch_insn **pcode,
+				struct traceprobe_parse_context *ctx)
+{
+	struct btf *btf = ctx->btf;
+
+	if (!btf || !ctx->last_type)
+		return 0;
+
+	/* char [] does not need any change. */
+	if (btf_type_is_char_array(btf, ctx->last_type))
+		return 0;
+
+	/* char * requires dereference the pointer. */
+	if (btf_type_is_char_ptr(btf, ctx->last_type)) {
+		struct fetch_insn *code = *pcode + 1;
+
+		if (code->op == FETCH_OP_END) {
+			trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
+			return -E2BIG;
+		}
+		if (typename[0] == 'u')
+			code->op = FETCH_OP_UDEREF;
+		else
+			code->op = FETCH_OP_DEREF;
+		code->offset = 0;
+		*pcode = code;
+		return 0;
+	}
+	/* Other types are not available for string */
+	trace_probe_log_err(ctx->offset, BAD_TYPE4STR);
+	return -EINVAL;
+}
+
 static const char *fetch_type_from_btf_type(struct btf *btf,
 					const struct btf_type *type,
 					struct traceprobe_parse_context *ctx)
@@ -670,6 +741,13 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 #define find_fetch_type_from_btf_type(ctx)		\
 	find_fetch_type(NULL, ctx->flags)
 
+static int check_prepare_btf_string_fetch(char *typename,
+				struct fetch_insn **pcode,
+				struct traceprobe_parse_context *ctx)
+{
+	return 0;
+}
+
 #endif
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
@@ -1112,8 +1190,15 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 
 	/* Update storing type if BTF is available */
 	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
-	    !t && ctx->last_type)
-		parg->type = find_fetch_type_from_btf_type(ctx);
+	    ctx->last_type) {
+		if (!t) {
+			parg->type = find_fetch_type_from_btf_type(ctx);
+		} else if (strstr(t, "string")) {
+			ret = check_prepare_btf_string_fetch(t, &code, ctx);
+			if (ret)
+				goto fail;
+		}
+	}
 
 	ret = -EINVAL;
 	/* Store operation */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 9184c84833f8..7f929482e8d4 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -513,7 +513,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NOSUP_DAT_ARG,	"Non pointer structure/union argument is not supported."),\
 	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
 	C(NO_BTF_FIELD,		"This field is not found."),	\
-	C(BAD_BTF_TID,		"Failed to get BTF type info."),
+	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
+	C(BAD_TYPE4STR,		"This type does not fit for string."),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

