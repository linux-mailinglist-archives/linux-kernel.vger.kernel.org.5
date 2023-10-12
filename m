Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8537C6371
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377122AbjJLDwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377075AbjJLDvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:52 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E410FB;
        Wed, 11 Oct 2023 20:51:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5859b2eaa55so389896a12.1;
        Wed, 11 Oct 2023 20:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082689; x=1697687489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rVW03rOwjSZP2z69A2JhUmzH1YR4e60f99Uil62L7k=;
        b=Yb86W2f0tG1zUIP9ufxVG7NSuJ3nGR18BGE6RWUZOR03IQTZnH7V5uNIj403Hre9zs
         ET4/crZ4qirTi74U5gNuhTLrskrJY62zsWY/8xpzgQH3SFnBTDOXdpLlmLGzftL7I5IH
         wHrpwvLggxVhb2lDNmYvlNBx33JqLeFRVs38pxeENGUyBiewRdWhbnnC6CioWL4g6kxN
         b9y15KVxyNHIedAgpiRH0Kz411yGK3dgv6GliVCVMr4vq9wjozRuGXecxpd2v7QnUpj6
         aek4Ngf+oA7J7S76e8pIXtMYEt6J/WVwN09Vp9eOVyVtT9K+XUFpSAmZZlZcj3k3rQoj
         ZduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082689; x=1697687489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0rVW03rOwjSZP2z69A2JhUmzH1YR4e60f99Uil62L7k=;
        b=dZ7jog7OKA6/ZYtiKR/p8Ohb/R9H50J79wGOKBii83nqawI2ciTXbZUZGf98cLlUDt
         zkjuGHGHvSFv6MJxWQPPOpzZamtXH5aduMYSBTSXxAJbriD/KCbYl2vUXub4/O+sVNGV
         Q9VrdrIvUElTz3yZkgENCDLJK0KFOnUFGMESnk+DBkcnQu2TNFgUq8A6xy6lVR6SszHP
         p05kURyQUFVujJbc3uzB0tQoFLud96vN3mgjmmA8HjldNyh9J845pYGj2v8rS/XN9X1U
         24wZ7O1RpkhUzksJce3zx96GG//KwSDuDaNfDv31JipKf7NNGiRD3tj+7eMpsvql/svA
         Jv2A==
X-Gm-Message-State: AOJu0YzSstcd83qva3KiJuCPTcGf3F7Zoa1HR/G7s8wGEpPfVEl6jzho
        1OqbNK9l1nmXt5HFbet448HXwhR6EqE=
X-Google-Smtp-Source: AGHT+IH8ujh/4bbYJYVL//tpIwkrgIUKdJURj1ThDc//wfn3ffSDugZFYP9KcXN0vYrC738yiQcFwA==
X-Received: by 2002:a17:903:110d:b0:1c7:37e2:13ff with SMTP id n13-20020a170903110d00b001c737e213ffmr23895591plh.6.1697082689403;
        Wed, 11 Oct 2023 20:51:29 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 11/48] perf annotate-data: Add dso->data_types tree
Date:   Wed, 11 Oct 2023 20:50:34 -0700
Message-ID: <20231012035111.676789-12-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To aggregate accesses to the same data type, add 'data_types' tree in
DSO to maintain data types and find it by name and size.  It might have
different data types that happen to have the same name.  So it also
compares the size of the type.  Even if it doesn't 100% guarantee, it'd
reduce the possiblility of mis-handling of such conflicts.  And I don't
think it's common to have different types with the same name.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 95 +++++++++++++++++++++++++++++----
 tools/perf/util/annotate-data.h |  9 ++++
 tools/perf/util/dso.c           |  4 ++
 tools/perf/util/dso.h           |  2 +
 4 files changed, 100 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index b3d519b7514b..23381c0a5d38 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -17,6 +17,76 @@
 #include "strbuf.h"
 #include "symbol.h"
 
+/*
+ * Compare type name and size to maintain them in a tree.
+ * I'm not sure if DWARF would have information of a single type in many
+ * different places (compilation units).  If not, it could compare the
+ * offset of the type entry in the .debug_info section.
+ */
+static int data_type_cmp(const void *_key, const struct rb_node *node)
+{
+	const struct annotated_data_type *key = _key;
+	struct annotated_data_type *type;
+
+	type = rb_entry(node, struct annotated_data_type, node);
+
+	if (key->type_size != type->type_size)
+		return key->type_size - type->type_size;
+	return strcmp(key->type_name, type->type_name);
+}
+
+static bool data_type_less(struct rb_node *node_a, const struct rb_node *node_b)
+{
+	struct annotated_data_type *a, *b;
+
+	a = rb_entry(node_a, struct annotated_data_type, node);
+	b = rb_entry(node_b, struct annotated_data_type, node);
+
+	if (a->type_size != b->type_size)
+		return a->type_size < b->type_size;
+	return strcmp(a->type_name, b->type_name) < 0;
+}
+
+static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
+							  Dwarf_Die *type_die)
+{
+	struct annotated_data_type *result = NULL;
+	struct annotated_data_type key;
+	struct rb_node *node;
+	struct strbuf sb;
+	char *type_name;
+	Dwarf_Word size;
+
+	strbuf_init(&sb, 32);
+	if (__die_get_typename(type_die, &sb) < 0)
+		strbuf_add(&sb, "(unknown type)", 14);
+	type_name = strbuf_detach(&sb, NULL);
+	dwarf_aggregate_size(type_die, &size);
+
+	/* Check existing nodes in dso->data_types tree */
+	key.type_name = type_name;
+	key.type_size = size;
+	node = rb_find(&key, &dso->data_types, data_type_cmp);
+	if (node) {
+		result = rb_entry(node, struct annotated_data_type, node);
+		free(type_name);
+		return result;
+	}
+
+	/* If not, add a new one */
+	result = zalloc(sizeof(*result));
+	if (result == NULL) {
+		free(type_name);
+		return NULL;
+	}
+
+	result->type_name = type_name;
+	result->type_size = size;
+
+	rb_add(&result->node, &dso->data_types, data_type_less);
+	return result;
+}
+
 static bool find_cu_die(struct debuginfo *di, u64 pc, Dwarf_Die *cu_die)
 {
 	Dwarf_Off off, next_off;
@@ -129,7 +199,6 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	struct dso *dso = ms->map->dso;
 	struct debuginfo *di;
 	Dwarf_Die type_die;
-	struct strbuf sb;
 	u64 pc;
 
 	di = debuginfo__new(dso->long_name);
@@ -147,17 +216,23 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	if (find_data_type_die(di, pc, reg, offset, &type_die) < 0)
 		goto out;
 
-	result = zalloc(sizeof(*result));
-	if (result == NULL)
-		goto out;
-
-	strbuf_init(&sb, 32);
-	if (__die_get_typename(&type_die, &sb) < 0)
-		strbuf_add(&sb, "(unknown type)", 14);
-
-	result->type_name = strbuf_detach(&sb, NULL);
+	result = dso__findnew_data_type(dso, &type_die);
 
 out:
 	debuginfo__delete(di);
 	return result;
 }
+
+void annotated_data_type__tree_delete(struct rb_root *root)
+{
+	struct annotated_data_type *pos;
+
+	while (!RB_EMPTY_ROOT(root)) {
+		struct rb_node *node = rb_first(root);
+
+		rb_erase(node, root);
+		pos = rb_entry(node, struct annotated_data_type, node);
+		free(pos->type_name);
+		free(pos);
+	}
+}
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 633147f78ca5..ab9f187bd7f1 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -4,6 +4,7 @@
 
 #include <errno.h>
 #include <linux/compiler.h>
+#include <linux/rbtree.h>
 #include <linux/types.h>
 
 struct map_symbol;
@@ -16,6 +17,7 @@ struct map_symbol;
  * This represents a data type accessed by samples in the profile data.
  */
 struct annotated_data_type {
+	struct rb_node node;
 	char *type_name;
 	int type_size;
 };
@@ -26,6 +28,9 @@ struct annotated_data_type {
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 					   int reg, int offset);
 
+/* Release all data type information in the tree */
+void annotated_data_type__tree_delete(struct rb_root *root);
+
 #else /* HAVE_DWARF_SUPPORT */
 
 static inline struct annotated_data_type *
@@ -35,6 +40,10 @@ find_data_type(struct map_symbol *ms __maybe_unused, u64 ip __maybe_unused,
 	return NULL;
 }
 
+static inline void annotated_data_type__tree_delete(struct rb_root *root __maybe_unused)
+{
+}
+
 #endif /* HAVE_DWARF_SUPPORT */
 
 #endif /* _PERF_ANNOTATE_DATA_H */
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1f629b6fb7cf..22fd5fa806ed 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -31,6 +31,7 @@
 #include "debug.h"
 #include "string2.h"
 #include "vdso.h"
+#include "annotate-data.h"
 
 static const char * const debuglink_paths[] = {
 	"%.0s%s",
@@ -1327,6 +1328,7 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		dso->data.cache = RB_ROOT;
 		dso->inlined_nodes = RB_ROOT_CACHED;
 		dso->srclines = RB_ROOT_CACHED;
+		dso->data_types = RB_ROOT;
 		dso->data.fd = -1;
 		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
@@ -1370,6 +1372,8 @@ void dso__delete(struct dso *dso)
 	symbols__delete(&dso->symbols);
 	dso->symbol_names_len = 0;
 	zfree(&dso->symbol_names);
+	annotated_data_type__tree_delete(&dso->data_types);
+
 	if (dso->short_name_allocated) {
 		zfree((char **)&dso->short_name);
 		dso->short_name_allocated = false;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3759de8c2267..ce9f3849a773 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -154,6 +154,8 @@ struct dso {
 	size_t		 symbol_names_len;
 	struct rb_root_cached inlined_nodes;
 	struct rb_root_cached srclines;
+	struct rb_root	data_types;
+
 	struct {
 		u64		addr;
 		struct symbol	*symbol;
-- 
2.42.0.655.g421f12c284-goog

