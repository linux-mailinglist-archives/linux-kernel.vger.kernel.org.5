Return-Path: <linux-kernel+bounces-69494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF17858A55
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D1F2898A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0814A096;
	Fri, 16 Feb 2024 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrFcSa2m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D2148FFF;
	Fri, 16 Feb 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127666; cv=none; b=sSfOLrH/Q3vWR6FE3Ej63oSZ2Pnpkhgv9iU7ZOXQcgr4K9RL17gzTTE4vo1hb5BpdlPahCdu/nKdHskEU51fcEoNvlo5oyuVMAVv1isEp3ZVKxU3a6rP1l3c5hAWchoxs058/uWrOMw1SDTORS6bo6UXQ5+jJ3TnscpSleJ4yl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127666; c=relaxed/simple;
	bh=Qw5in8yXru6XDR/MkCtSi5udF5OsSGUvfaaiz1BQ/Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpsXbPZG4elA9E0BSn+0Iaxmh+S3FO6MLvIJQkn9q1fivkFGqQ6rOoMk3NkSPAZrZOSjBizdNhxL4264pHcPNERtzA5oWifWxfNIVsItgc5bHvbbdO+JDd5QfH7X+RohpmA+zVKC7L27e8CMPMnJ1wcWkfX1/QcyzXDCLhk3H14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrFcSa2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2151BC433C7;
	Fri, 16 Feb 2024 23:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708127665;
	bh=Qw5in8yXru6XDR/MkCtSi5udF5OsSGUvfaaiz1BQ/Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrFcSa2mRpoWSX/v9+yZiSyZX8U54mmS1u1B7ANszJyVkrCyL0oxTOXL0Vu94WFqT
	 QYm4QgDfKMlQ3UPjrHvUCtRN2dmb8tQgha8RkZ/8PXUnMm6113IP7ZRtg+1ewWqDY/
	 Nb0OsPevP437xNFMXGlOQ5CV6ksbYFw80KPnOzNL+RpnxmlVhnsQvRHs0BS+qLy14v
	 jFXjLF+R1omwAtzj+MHh1nV5lEdncpiJP8ZepuNhipnnvi37Al2HElIP9YalSxDdjb
	 6B4cqH5ung2S5x5pdMf2G8eFi5NRF4dw+g7o0af8+EeIm8vDImvAGQ7SLWGE/Jf5ve
	 7jOnr+a7lTTaA==
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
Subject: [PATCH 01/14] perf dwarf-aux: Add die_collect_vars()
Date: Fri, 16 Feb 2024 15:54:10 -0800
Message-ID: <20240216235423.2343167-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216235423.2343167-1-namhyung@kernel.org>
References: <20240216235423.2343167-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The die_collect_vars() is to find all variable information in the scope
including function parameters.  The struct die_var_type is to save the
type of the variable with the location (reg and offset) as well as where
it's defined in the code (addr).

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 118 +++++++++++++++++++++++++++---------
 tools/perf/util/dwarf-aux.h |  17 ++++++
 2 files changed, 107 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 2791126069b4..f878014c9e27 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1136,6 +1136,40 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
 	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
 }
 
+#if defined(HAVE_DWARF_GETLOCATIONS_SUPPORT) || defined(HAVE_DWARF_CFI_SUPPORT)
+static int reg_from_dwarf_op(Dwarf_Op *op)
+{
+	switch (op->atom) {
+	case DW_OP_reg0 ... DW_OP_reg31:
+		return op->atom - DW_OP_reg0;
+	case DW_OP_breg0 ... DW_OP_breg31:
+		return op->atom - DW_OP_breg0;
+	case DW_OP_regx:
+	case DW_OP_bregx:
+		return op->number;
+	default:
+		break;
+	}
+	return -1;
+}
+
+static int offset_from_dwarf_op(Dwarf_Op *op)
+{
+	switch (op->atom) {
+	case DW_OP_reg0 ... DW_OP_reg31:
+	case DW_OP_regx:
+		return 0;
+	case DW_OP_breg0 ... DW_OP_breg31:
+		return op->number;
+	case DW_OP_bregx:
+		return op->number2;
+	default:
+		break;
+	}
+	return -1;
+}
+#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT || HAVE_DWARF_CFI_SUPPORT */
+
 #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 /**
  * die_get_var_innermost_scope - Get innermost scope range of given variable DIE
@@ -1479,41 +1513,69 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
 		*offset = data.offset;
 	return result;
 }
-#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
-#ifdef HAVE_DWARF_CFI_SUPPORT
-static int reg_from_dwarf_op(Dwarf_Op *op)
+static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 {
-	switch (op->atom) {
-	case DW_OP_reg0 ... DW_OP_reg31:
-		return op->atom - DW_OP_reg0;
-	case DW_OP_breg0 ... DW_OP_breg31:
-		return op->atom - DW_OP_breg0;
-	case DW_OP_regx:
-	case DW_OP_bregx:
-		return op->number;
-	default:
-		break;
-	}
-	return -1;
+	struct die_var_type **var_types = arg;
+	Dwarf_Die type_die;
+	int tag = dwarf_tag(die_mem);
+	Dwarf_Attribute attr;
+	Dwarf_Addr base, start, end;
+	Dwarf_Op *ops;
+	size_t nops;
+	struct die_var_type *vt;
+
+	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	/*
+	 * Only collect the first location as it can reconstruct the
+	 * remaining state by following the instructions.
+	 * start = 0 means it covers the whole range.
+	 */
+	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
+		return DIE_FIND_CB_SIBLING;
+
+	if (die_get_real_type(die_mem, &type_die) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	vt = malloc(sizeof(*vt));
+	if (vt == NULL)
+		return DIE_FIND_CB_END;
+
+	vt->die_off = dwarf_dieoffset(&type_die);
+	vt->addr = start;
+	vt->reg = reg_from_dwarf_op(ops);
+	vt->offset = offset_from_dwarf_op(ops);
+	vt->next = *var_types;
+	*var_types = vt;
+
+	return DIE_FIND_CB_SIBLING;
 }
 
-static int offset_from_dwarf_op(Dwarf_Op *op)
+/**
+ * die_collect_vars - Save all variables and parameters
+ * @sc_die: a scope DIE
+ * @var_types: a pointer to save the resulting list
+ *
+ * Save all variables and parameters in the @sc_die and save them to @var_types.
+ * The @var_types is a singly-linked list containing type and location info.
+ * Actual type can be retrieved using dwarf_offdie() with 'die_off' later.
+ *
+ * Callers should free @var_types.
+ */
+void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types)
 {
-	switch (op->atom) {
-	case DW_OP_reg0 ... DW_OP_reg31:
-	case DW_OP_regx:
-		return 0;
-	case DW_OP_breg0 ... DW_OP_breg31:
-		return op->number;
-	case DW_OP_bregx:
-		return op->number2;
-	default:
-		break;
-	}
-	return -1;
+	Dwarf_Die die_mem;
+
+	die_find_child(sc_die, __die_collect_vars_cb, (void *)var_types, &die_mem);
 }
+#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
+#ifdef HAVE_DWARF_CFI_SUPPORT
 /**
  * die_get_cfa - Get frame base information
  * @dwarf: a Dwarf info
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 85dd527ae1f7..efafd3a1f5b6 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -135,6 +135,15 @@ void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
 /* Get the list of including scopes */
 int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
 
+/* Variable type information */
+struct die_var_type {
+	struct die_var_type *next;
+	u64 die_off;
+	u64 addr;
+	int reg;
+	int offset;
+};
+
 #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 
 /* Get byte offset range of given variable DIE */
@@ -150,6 +159,9 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
 				     Dwarf_Addr addr, Dwarf_Die *die_mem,
 				     int *offset);
 
+/* Save all variables and parameters in this scope */
+void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
+
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
@@ -178,6 +190,11 @@ static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unu
 	return NULL;
 }
 
+static inline void die_collect_vars(Dwarf_Die *sc_die __maybe_unused,
+				    struct die_var_type **var_types __maybe_unused)
+{
+}
+
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 #ifdef HAVE_DWARF_CFI_SUPPORT
-- 
2.44.0.rc0.258.g7320e95886-goog


