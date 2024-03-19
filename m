Return-Path: <linux-kernel+bounces-107048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365DD87F6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A53E1C2178B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616C98172D;
	Tue, 19 Mar 2024 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGFHIoyq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89780C1D;
	Tue, 19 Mar 2024 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827491; cv=none; b=DGV7/pUNTO+1Onr3Arh6dUSreAXHXMw/jmpKWIK3StisbDC6uPK3EWgf6P2AUkB9E7uZz9b3r5CA0oJHE+mOCFvzmg4ARAPG21C9OqZebAQawln/EgPtDDtffzd1MB9WyZ5Bm1H3SrymEHQGcXg+Ee5IYG7HvH67SwtKWkBjXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827491; c=relaxed/simple;
	bh=naVgs0IaGcSuV0neyN2FEHTQAFcy2q0bj4mSjLjwK7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr6MRbi+LFDO2x3Kzr1Tk7trui8vkmtkc+mrkLU+Aq49iZ5nqc3Bwoc2tPsx60whxZ5GPn+ujviTCTb9MW4pn3khjqG50OQDxASbB510AjLfe1JXxvKpvauMkOWIka7xgAoahn3rfyWXtgQSwjc1Mk4oP+cmy+uzkmWWX9JpsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGFHIoyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D427C433F1;
	Tue, 19 Mar 2024 05:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827491;
	bh=naVgs0IaGcSuV0neyN2FEHTQAFcy2q0bj4mSjLjwK7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGFHIoyqyhu0lvfxer4tVFf0p+VItIrqaN1eu7eSvQysIe2WOLF34E1cSD2H4XWDz
	 fiCoCzl5nDOXGtoQevHcPBtCMsSnnteekgalQtoLY8gjnpjS000wbgwmeZIyf1Ng6m
	 xAXl3VzM/Mw1JisljIcoscYYdCi3mIn/bviOuUuvCnhQopnYB2Vims8suGAovXrex4
	 /r09/YxAObKfMnnLiy42/4G+HQuni/yAk2Colaper27l1X6eYb/Fgpa5cP3Le8kDr9
	 5xtrsXV7u7p/txKOVH2o7r6XpkfijCtMCHvkWXXnMb/oTq8RfzmmhLH4CAy1UbuzXA
	 67/C92jNY0wvw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org
Subject: [PATCH 22/23] perf annotate-data: Add a cache for global variable types
Date: Mon, 18 Mar 2024 22:51:14 -0700
Message-ID: <20240319055115.4063940-23-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They are often searched by many different places.  Let's add a cache
for them to reduce the duplicate DWARF access.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 107 +++++++++++++++++++++++++++++++-
 tools/perf/util/annotate-data.h |   7 +++
 tools/perf/util/dso.c           |   2 +
 tools/perf/util/dso.h           |   6 +-
 4 files changed, 118 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 633fe125fcd8..4b3184b7c799 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -433,6 +433,91 @@ static struct type_state_stack *findnew_stack_state(struct type_state *state,
 	return stack;
 }
 
+/* Maintain a cache for quick global variable lookup */
+struct global_var_entry {
+	struct rb_node node;
+	char *name;
+	u64 start;
+	u64 end;
+	u64 die_offset;
+};
+
+static int global_var_cmp(const void *_key, const struct rb_node *node)
+{
+	const u64 addr = (uintptr_t)_key;
+	struct global_var_entry *gvar;
+
+	gvar = rb_entry(node, struct global_var_entry, node);
+
+	if (gvar->start <= addr && addr < gvar->end)
+		return 0;
+	return gvar->start > addr ? -1 : 1;
+}
+
+static bool global_var_less(struct rb_node *node_a, const struct rb_node *node_b)
+{
+	struct global_var_entry *gvar_a, *gvar_b;
+
+	gvar_a = rb_entry(node_a, struct global_var_entry, node);
+	gvar_b = rb_entry(node_b, struct global_var_entry, node);
+
+	return gvar_a->start < gvar_b->start;
+}
+
+static struct global_var_entry *global_var__find(struct data_loc_info *dloc, u64 addr)
+{
+	struct dso *dso = map__dso(dloc->ms->map);
+	struct rb_node *node;
+
+	node = rb_find((void *)addr, &dso->global_vars, global_var_cmp);
+	if (node == NULL)
+		return NULL;
+
+	return rb_entry(node, struct global_var_entry, node);
+}
+
+static bool global_var__add(struct data_loc_info *dloc, u64 addr,
+			    const char *name, Dwarf_Die *type_die)
+{
+	struct dso *dso = map__dso(dloc->ms->map);
+	struct global_var_entry *gvar;
+	Dwarf_Word size;
+
+	if (dwarf_aggregate_size(type_die, &size) < 0)
+		return false;
+
+	gvar = malloc(sizeof(*gvar));
+	if (gvar == NULL)
+		return false;
+
+	gvar->name = strdup(name);
+	if (gvar->name == NULL) {
+		free(gvar);
+		return false;
+	}
+
+	gvar->start = addr;
+	gvar->end = addr + size;
+	gvar->die_offset = dwarf_dieoffset(type_die);
+
+	rb_add(&gvar->node, &dso->global_vars, global_var_less);
+	return true;
+}
+
+void global_var_type__tree_delete(struct rb_root *root)
+{
+	struct global_var_entry *gvar;
+
+	while (!RB_EMPTY_ROOT(root)) {
+		struct rb_node *node = rb_first(root);
+
+		rb_erase(node, root);
+		gvar = rb_entry(node, struct global_var_entry, node);
+		free(gvar->name);
+		free(gvar);
+	}
+}
+
 static bool get_global_var_info(struct data_loc_info *dloc, u64 addr,
 				const char **var_name, int *var_offset)
 {
@@ -467,14 +552,25 @@ static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 	u64 pc;
 	int offset;
 	bool is_pointer = false;
-	const char *var_name;
+	const char *var_name = NULL;
+	struct global_var_entry *gvar;
 	Dwarf_Die var_die;
 
+	gvar = global_var__find(dloc, var_addr);
+	if (gvar) {
+		if (!dwarf_offdie(dloc->di->dbg, gvar->die_offset, type_die))
+			return false;
+
+		*var_offset = var_addr - gvar->start;
+		return true;
+	}
+
 	/* Try to get the variable by address first */
 	if (die_find_variable_by_addr(cu_die, var_addr, &var_die, &offset) &&
 	    check_variable(&var_die, type_die, offset, is_pointer) == 0) {
+		var_name = dwarf_diename(&var_die);
 		*var_offset = offset;
-		return true;
+		goto ok;
 	}
 
 	if (!get_global_var_info(dloc, var_addr, &var_name, var_offset))
@@ -485,9 +581,14 @@ static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 	/* Try to get the name of global variable */
 	if (die_find_variable_at(cu_die, var_name, pc, &var_die) &&
 	    check_variable(&var_die, type_die, *var_offset, is_pointer) == 0)
-		return true;
+		goto ok;
 
 	return false;
+
+ok:
+	/* The address should point to the start of the variable */
+	global_var__add(dloc, var_addr - *var_offset, var_name, type_die);
+	return true;
 }
 
 /**
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 1b5a152163b5..fe1e53d6e8c7 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -153,6 +153,9 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
 /* Release all data type information in the tree */
 void annotated_data_type__tree_delete(struct rb_root *root);
 
+/* Release all global variable information in the tree */
+void global_var_type__tree_delete(struct rb_root *root);
+
 #else /* HAVE_DWARF_SUPPORT */
 
 static inline struct annotated_data_type *
@@ -175,6 +178,10 @@ static inline void annotated_data_type__tree_delete(struct rb_root *root __maybe
 {
 }
 
+static inline void global_var_type__tree_delete(struct rb_root *root __maybe_unused)
+{
+}
+
 #endif /* HAVE_DWARF_SUPPORT */
 
 #endif /* _PERF_ANNOTATE_DATA_H */
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 22fd5fa806ed..6e2a7198b382 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1329,6 +1329,7 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 		dso->inlined_nodes = RB_ROOT_CACHED;
 		dso->srclines = RB_ROOT_CACHED;
 		dso->data_types = RB_ROOT;
+		dso->global_vars = RB_ROOT;
 		dso->data.fd = -1;
 		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
@@ -1373,6 +1374,7 @@ void dso__delete(struct dso *dso)
 	dso->symbol_names_len = 0;
 	zfree(&dso->symbol_names);
 	annotated_data_type__tree_delete(&dso->data_types);
+	global_var_type__tree_delete(&dso->global_vars);
 
 	if (dso->short_name_allocated) {
 		zfree((char **)&dso->short_name);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ce9f3849a773..2cdcd1e2ef8b 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -154,7 +154,8 @@ struct dso {
 	size_t		 symbol_names_len;
 	struct rb_root_cached inlined_nodes;
 	struct rb_root_cached srclines;
-	struct rb_root	data_types;
+	struct rb_root	 data_types;
+	struct rb_root	 global_vars;
 
 	struct {
 		u64		addr;
@@ -411,4 +412,7 @@ int dso__strerror_load(struct dso *dso, char *buf, size_t buflen);
 
 void reset_fd_limit(void);
 
+u64 dso__find_global_type(struct dso *dso, u64 addr);
+u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
+
 #endif /* __PERF_DSO */
-- 
2.44.0.291.gc1ea87d7ee-goog


