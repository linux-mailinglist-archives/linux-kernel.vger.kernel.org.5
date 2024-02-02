Return-Path: <linux-kernel+bounces-50634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A3C847BFB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D628AE45
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9855985940;
	Fri,  2 Feb 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H72KEJ6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F38529C;
	Fri,  2 Feb 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911502; cv=none; b=YL4+80gWlf2kwDVMiI2zDBfUcVQRY6nXPtZtAtBVeDq+m/PD2oN7afXx4vwNAMTJo0k5P3uML6Of5li1/UyDirTfk0Lx85U803R/Ep91m5wRovaKeJ0ydZj0MMaThPrMWESkKRL4GlarzcQQVXRI7RyPF2itNzdwN9RTxa5WN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911502; c=relaxed/simple;
	bh=aCy4fZif4NL+l3ntdf5UR0MbQ0NnUASsa/mDDkArAHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArzTYkB3JSTrVibx4cMjIb7NytD3N9lHpHWBoJrimBJk1YmtrtKGN+90HDbFVliqxPIvMdH4zfTv63f3V8Yq/KaaBuhCEBpY5g4Hj6N9pMrbM3zP4lJrD80N/lDXY43m8WArq5t01dvg6LFSgh8V/CGKDy0+hGn8Rs6YK7VurRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H72KEJ6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAB4C433B1;
	Fri,  2 Feb 2024 22:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911502;
	bh=aCy4fZif4NL+l3ntdf5UR0MbQ0NnUASsa/mDDkArAHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H72KEJ6eDvvnP8OCPT3PAVAh1TyHCir1mq44pogmZg7Wn1Ihk6tAKfuwL6wKfe3tD
	 Ediu9JFW8JZ9kc2us+fdXnpBPkUQ4zUY3gpY43F2nQ6RLy3jwRzUTl5xtiY5pUTa+3
	 iPMDb2rjwqQBSENbrQITBpnzr0tdWe414U7RAy9C5Pqvby6J52PYuKhslW3yl4668f
	 1CVdKDXb7w3WKh//L0REaNEQHRm7lP5tTQfzoUmYzvsN+NuD0fiPe6BZVuMPH9K8ji
	 mPiwwactW9CnctdW+iZaDVCrMtFeFqabilpv0v7j9ZUa7llhwXZNBhoKW7KFkD19Q5
	 AJoX1+PSH4eog==
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
Date: Fri,  2 Feb 2024 14:04:46 -0800
Message-ID: <20240202220459.527138-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202220459.527138-1-namhyung@kernel.org>
References: <20240202220459.527138-1-namhyung@kernel.org>
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
2.43.0.594.gd9cf4e227d-goog


