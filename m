Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF201768ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGaHcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGaHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA7F2D7E;
        Mon, 31 Jul 2023 00:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6C0560F1E;
        Mon, 31 Jul 2023 07:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CCAC433C7;
        Mon, 31 Jul 2023 07:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690788629;
        bh=SVaKMsm5wi9MtePH615CD5h2bQfFDb6xVagKrZjtk0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdZJ7fD3T+xhrnDmL+T7tHHUuFYDGmrM0yS8YzfN7su2DNxMmUwE6wd0weiynMwWM
         bZtsOuDuv09Q99o9hdOxijhLTUDclWHnM3cBEoOw5kIGaAZijCZrOpAqfIPG4ANZ+2
         Lv62sx5inwIHaXGJYAc3vjj4m2SLW4vZH6LFTL6IWyz8Wd9AxUNb24y8xWLWRkKrXw
         md/vTfZyIR3H2GN3e9nsdrJsR0DqveTwZ+9uOOwPfF0/ScgqnrE/sIHs48vzdeZAgr
         2SANoGKJTxFs+ncRbd5UV7l9YfrukVMYifnrtCenO1uU5LL3NlIv/oE0z2lcoM/6lL
         oqo1JY5YBc4OQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 2/9] bpf/btf: tracing: Move finding func-proto API and getting func-param API to BTF
Date:   Mon, 31 Jul 2023 16:30:24 +0900
Message-Id: <169078862446.173706.13484451284649857042.stgit@devnote2>
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

Move generic function-proto find API and getting function parameter API
to BTF library code from trace_probe.c. This will avoid redundant efforts
on different feature.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Remove perameter check.
  - Fix a typo.
  - Add a type check for btf_get_func_param() and add comment for that.
  - Use bpf_find_btf_id() and add bpf_put().
  - Move the code before btf_show() related code.
---
 include/linux/btf.h        |    4 ++++
 kernel/bpf/btf.c           |   47 +++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.c |   50 +++++++++-----------------------------------
 3 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index dbfe41a09c4b..20e3a07eef8f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -222,6 +222,10 @@ const struct btf_type *
 btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 		 u32 *type_size);
 const char *btf_type_str(const struct btf_type *t);
+const struct btf_type *btf_find_func_proto(const char *func_name,
+					   struct btf **btf_p);
+const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
+					   s32 *nr);
 
 #define for_each_member(i, struct_type, member)			\
 	for (i = 0, member = btf_type_member(struct_type);	\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b9b0eb1189bb..f7b25c615269 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -911,6 +911,53 @@ static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf,
 	return t;
 }
 
+/*
+ * Find a function proto type by name, and return the btf_type with its btf
+ * in *@btf_p. Return NULL if not found.
+ * Note that caller has to call btf_put(*@btf_p) after using the btf_type.
+ */
+const struct btf_type *btf_find_func_proto(const char *func_name, struct btf **btf_p)
+{
+	const struct btf_type *t;
+	s32 id;
+
+	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
+	if (id < 0)
+		return NULL;
+
+	/* Get BTF_KIND_FUNC type */
+	t = btf_type_by_id(*btf_p, id);
+	if (!t || !btf_type_is_func(t))
+		goto err;
+
+	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
+	t = btf_type_by_id(*btf_p, t->type);
+	if (!t || !btf_type_is_func_proto(t))
+		goto err;
+
+	return t;
+err:
+	btf_put(*btf_p);
+	return NULL;
+}
+
+/*
+ * Get function parameter with the number of parameters.
+ * This can return NULL if the function has no parameters.
+ * It can return -EINVAL if the @func_proto is not a function proto type.
+ */
+const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
+{
+	if (!btf_type_is_func_proto(func_proto))
+		return ERR_PTR(-EINVAL);
+
+	*nr = btf_type_vlen(func_proto);
+	if (*nr > 0)
+		return (const struct btf_param *)(func_proto + 1);
+	else
+		return NULL;
+}
+
 #define BTF_SHOW_MAX_ITER	10
 
 #define BTF_KIND_BIT(kind)	(1ULL << kind)
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ecbe28f8d676..21a228d88ebb 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -361,38 +361,6 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
 	return NULL;
 }
 
-static const struct btf_type *find_btf_func_proto(const char *funcname,
-						  struct btf **btf_p)
-{
-	const struct btf_type *t;
-	struct btf *btf = NULL;
-	s32 id;
-
-	if (!funcname)
-		return ERR_PTR(-EINVAL);
-
-	id = bpf_find_btf_id(funcname, BTF_KIND_FUNC, &btf);
-	if (id <= 0)
-		return ERR_PTR(-ENOENT);
-
-	/* Get BTF_KIND_FUNC type */
-	t = btf_type_by_id(btf, id);
-	if (!t || !btf_type_is_func(t))
-		goto err;
-
-	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
-	t = btf_type_by_id(btf, t->type);
-	if (!t || !btf_type_is_func_proto(t))
-		goto err;
-
-	*btf_p = btf;
-	return t;
-
-err:
-	btf_put(btf);
-	return ERR_PTR(-ENOENT);
-}
-
 static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
 						   struct btf **btf_p, bool tracepoint)
 {
@@ -403,12 +371,13 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
 	if (!funcname || !nr)
 		return ERR_PTR(-EINVAL);
 
-	t = find_btf_func_proto(funcname, &btf);
-	if (IS_ERR(t))
+	t = btf_find_func_proto(funcname, &btf);
+	if (!t)
 		return (const struct btf_param *)t;
 
-	*nr = btf_type_vlen(t);
-	param = (const struct btf_param *)(t + 1);
+	param = btf_get_func_param(t, nr);
+	if (IS_ERR_OR_NULL(param))
+		goto err;
 
 	/* Hide the first 'data' argument of tracepoint */
 	if (tracepoint) {
@@ -421,6 +390,7 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
 		return param;
 	}
 
+err:
 	btf_put(btf);
 	return NULL;
 }
@@ -496,8 +466,8 @@ static const struct fetch_type *parse_btf_retval_type(
 
 	if (ctx->funcname) {
 		/* Do not use ctx->btf, because it must be used with ctx->param */
-		t = find_btf_func_proto(ctx->funcname, &btf);
-		if (!IS_ERR(t)) {
+		t = btf_find_func_proto(ctx->funcname, &btf);
+		if (t) {
 			typestr = type_from_btf_id(btf, t->type);
 			btf_put(btf);
 		}
@@ -512,8 +482,8 @@ static bool is_btf_retval_void(const char *funcname)
 	struct btf *btf;
 	bool ret;
 
-	t = find_btf_func_proto(funcname, &btf);
-	if (IS_ERR(t))
+	t = btf_find_func_proto(funcname, &btf);
+	if (!t)
 		return false;
 
 	ret = (t->type == 0);

