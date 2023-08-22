Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE6F78474F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbjHVQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbjHVQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CCC137;
        Tue, 22 Aug 2023 09:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A973365A09;
        Tue, 22 Aug 2023 16:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16352C433C7;
        Tue, 22 Aug 2023 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692721557;
        bh=Z8G/Q1ZOJmJqXnVe9PMMB8lk/cxt+JLjfH3zVdKl+Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jV9RagfIbe5jpmghdKO5v/LxIjt8GwWpCGuprl30MODYyHZ9vhUVvdfq0fpNfyX0S
         f7Wt7gUCxdvnGrwpjABhStXo4kuNJCNG0lYvuaX9DiiacLm59lZC+QhAWaL7H3gXZ0
         zK41jytaNaBFmJ8wq5ZcKK4oWvIlRwi4evHSJ7OIIW/4HdhFg5nsJ5jOPlOl0MKbem
         MicKjo2yqBggA2t8+a+dwvZ7OBfbCv4oCPbfGaA7N3KtonyryHd/nw4q5Cq5q+Esxt
         MCTgpqrzJhBMx7jCl9UfUb3UTeZeHJm4HKSIW3TfZ2cei38Bqk4vA225oIcwxzbR/i
         J5so7XhsZ5jBQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v6 2/9] tracing/probes: Move finding func-proto API and getting func-param API to trace_btf
Date:   Wed, 23 Aug 2023 01:25:52 +0900
Message-Id: <169272155255.160970.719426926348706349.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169272153143.160970.15584603734373446082.stgit@devnote2>
References: <169272153143.160970.15584603734373446082.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Changes in v3:
  - Remove perameter check.
  - Fix a typo.
  - Add a type check for btf_get_func_param() and add comment for that.
  - Use bpf_find_btf_id() and add bpf_put().
  - Move the code before btf_show() related code.
 Changes in v5:
  - Move the generic functions into a new file, trace_btf.c, for avoiding
    tree-merge conflict.
 Changes in v6:
  - Fix SPDX tag.
---
 kernel/trace/Makefile      |    1 +
 kernel/trace/trace_btf.c   |   53 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_btf.h   |    7 ++++++
 kernel/trace/trace_probe.c |   51 +++++++++---------------------------------
 4 files changed, 72 insertions(+), 40 deletions(-)
 create mode 100644 kernel/trace/trace_btf.c
 create mode 100644 kernel/trace/trace_btf.h

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 64b61f67a403..057cd975d014 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
 endif
 obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
+obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) += trace_btf.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
new file mode 100644
index 000000000000..d70b8ee9af37
--- /dev/null
+++ b/kernel/trace/trace_btf.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/btf.h>
+#include <linux/kernel.h>
+
+#include "trace_btf.h"
+
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
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
new file mode 100644
index 000000000000..98685e9a556c
--- /dev/null
+++ b/kernel/trace/trace_btf.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/btf.h>
+
+const struct btf_type *btf_find_func_proto(const char *func_name,
+					   struct btf **btf_p);
+const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
+					   s32 *nr);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ecbe28f8d676..c3ac5698e80b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
 #include <linux/bpf.h>
+#include "trace_btf.h"
 
 #include "trace_probe.h"
 
@@ -361,38 +362,6 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
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
@@ -403,12 +372,13 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
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
@@ -421,6 +391,7 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
 		return param;
 	}
 
+err:
 	btf_put(btf);
 	return NULL;
 }
@@ -496,8 +467,8 @@ static const struct fetch_type *parse_btf_retval_type(
 
 	if (ctx->funcname) {
 		/* Do not use ctx->btf, because it must be used with ctx->param */
-		t = find_btf_func_proto(ctx->funcname, &btf);
-		if (!IS_ERR(t)) {
+		t = btf_find_func_proto(ctx->funcname, &btf);
+		if (t) {
 			typestr = type_from_btf_id(btf, t->type);
 			btf_put(btf);
 		}
@@ -512,8 +483,8 @@ static bool is_btf_retval_void(const char *funcname)
 	struct btf *btf;
 	bool ret;
 
-	t = find_btf_func_proto(funcname, &btf);
-	if (IS_ERR(t))
+	t = btf_find_func_proto(funcname, &btf);
+	if (!t)
 		return false;
 
 	ret = (t->type == 0);

