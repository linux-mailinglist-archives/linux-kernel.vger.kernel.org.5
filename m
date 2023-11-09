Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE957E7581
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbjKJAC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345462AbjKJABo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A304C38;
        Thu,  9 Nov 2023 16:00:55 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso1368931a91.2;
        Thu, 09 Nov 2023 16:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574455; x=1700179255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLPs+b2+I6kBBMczH7djDlQ1eMDA2/OeXGnP74ag0eE=;
        b=VTF5oqgjc6sCxtGBZ/c6C7jpRK/6YllMRLSvjq+9fDGI1LqStvohOSuW4uRs4MWHB4
         bGvC1QeFSoBQzNZq3f/rH16ix4TpXChkV2DFtA7i8qOFyIVzfggfA7CMY2NSY++CcSp2
         bRPKw+QoR112jdGtZgjGl2FIv8pTp7ek63nRY5GG5IQP3ypMOWUxYk9W+JKOacY/lrWb
         l01PPXgeXWJJIpcjXqUTRKlxuuUvrm2lZHq+IlUTZ89NBfy5Rz65MMrBFAekAksPpifj
         YnatzJ9s8ayjPXpTf0vK0P0UJTuABP2MathpwJ5qvWNTwT68ojzcl0/yPFqRBDxdRKvJ
         b9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574455; x=1700179255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLPs+b2+I6kBBMczH7djDlQ1eMDA2/OeXGnP74ag0eE=;
        b=Fehc3BQlJW33R5QmwpdQWBgT8NMgMX3h1gk8t0dHM8HSnE/LOrpLGYD5HKaiU26GEv
         +dEuTMfE70bARWe7oXKwhATKMRbLQq6/EsQ07hLRNvmPu0KN5TFQGOH000XGT+Cg5km4
         MSJ79USwPea+S68Mx8/5MR9BOj97u8Xq2IC9BxsmrwMOFt4TAknA20CVABWbOvMpuidq
         Ac7Ho9FCU/fcHcCuppKezXqq7MeGLg4+I9ckXfAPTxY43ccYUUM/6J5sAQsm6CHGw3zD
         1tM5zUXAkFGAUVgERMTlIXg0EFVbm9gziXtDJRXyG+OG9A29sp+5fIQ59XjhlWKs3tLz
         ofQA==
X-Gm-Message-State: AOJu0YySkoT00GVwGePQle2gn679vA3r7uuyD5OfeBab2Oh0Pdxq9M87
        kNDpeMc/EMOAcbhL2Hz4xj+MmPW1oag=
X-Google-Smtp-Source: AGHT+IH+fHpN05CKnOv88A1cfYBYqtI5MFpXw2R3wlzt1SUmD3XDEVQyIN6gtJcOZ1ADzVKqWIMYng==
X-Received: by 2002:a17:90b:3909:b0:281:b37:2038 with SMTP id ob9-20020a17090b390900b002810b372038mr3291178pjb.1.1699574455054;
        Thu, 09 Nov 2023 16:00:55 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:54 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 26/52] perf annotate: Add --type-stat option for debugging
Date:   Thu,  9 Nov 2023 15:59:45 -0800
Message-ID: <20231110000012.3538610-27-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --type-stat option is to be used with --data-type and to print
detailed failure reasons for the data type annotation.

  $ perf annotate --data-type --type-stat
  Annotate data type stats:
  total 294, ok 116 (39.5%), bad 178 (60.5%)
  -----------------------------------------------------------
          30 : no_sym
          40 : no_insn_ops
          33 : no_mem_ops
          63 : no_var
           4 : no_typeinfo
           8 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-annotate.txt |  3 ++
 tools/perf/builtin-annotate.c              | 44 +++++++++++++++++++++-
 tools/perf/util/annotate-data.c            | 10 ++++-
 tools/perf/util/annotate-data.h            | 31 +++++++++++++++
 tools/perf/util/annotate.c                 | 23 +++++++++--
 5 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 0e6a49b7795c..b95524bea021 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -162,6 +162,9 @@ include::itrace.txt[]
 	that case it'd show annotation for the type only, otherwise it'd show
 	all data types it finds.
 
+--type-stat::
+	Show stats for the data type annotation.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 7e4ef93b19a0..e4fc00bc8fdf 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -58,6 +58,7 @@ struct perf_annotate {
 	bool	   has_br_stack;
 	bool	   group_set;
 	bool	   data_type;
+	bool	   type_stat;
 	float	   min_percent;
 	const char *sym_hist_filter;
 	const char *cpu_list;
@@ -401,6 +402,43 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 	printf(";\n");
 }
 
+static void print_annotate_data_stat(struct annotated_data_stat *s)
+{
+#define PRINT_STAT(fld) if (s->fld) printf("%10d : %s\n", s->fld, #fld)
+
+	int bad = s->no_sym +
+			s->no_insn +
+			s->no_insn_ops +
+			s->no_mem_ops +
+			s->no_reg +
+			s->no_dbginfo +
+			s->no_cuinfo +
+			s->no_var +
+			s->no_typeinfo +
+			s->invalid_size +
+			s->bad_offset;
+	int ok = s->total - bad;
+
+	printf("Annotate data type stats:\n");
+	printf("total %d, ok %d (%.1f%%), bad %d (%.1f%%)\n",
+		s->total, ok, 100.0 * ok / (s->total ?: 1), bad, 100.0 * bad / (s->total ?: 1));
+	printf("-----------------------------------------------------------\n");
+	PRINT_STAT(no_sym);
+	PRINT_STAT(no_insn);
+	PRINT_STAT(no_insn_ops);
+	PRINT_STAT(no_mem_ops);
+	PRINT_STAT(no_reg);
+	PRINT_STAT(no_dbginfo);
+	PRINT_STAT(no_cuinfo);
+	PRINT_STAT(no_var);
+	PRINT_STAT(no_typeinfo);
+	PRINT_STAT(invalid_size);
+	PRINT_STAT(bad_offset);
+	printf("\n");
+
+#undef PRINT_STAT
+}
+
 static void hists__find_annotations(struct hists *hists,
 				    struct evsel *evsel,
 				    struct perf_annotate *ann)
@@ -408,6 +446,9 @@ static void hists__find_annotations(struct hists *hists,
 	struct rb_node *nd = rb_first_cached(&hists->entries), *next;
 	int key = K_RIGHT;
 
+	if (ann->type_stat)
+		print_annotate_data_stat(&ann_data_stat);
+
 	while (nd) {
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
 		struct annotation *notes;
@@ -755,7 +796,8 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK_OPTARG(0, "data-type", &annotate, NULL, "name",
 			    "Show data type annotate for the memory accesses",
 			    parse_data_type),
-
+	OPT_BOOLEAN(0, "type-stat", &annotate.type_stat,
+		    "Show stats for the data type annotation"),
 	OPT_END()
 	};
 	int ret;
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 5326396b08ec..79f09ce92f15 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -198,6 +198,7 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 	/* Get the type of the variable */
 	if (die_get_real_type(var_die, type_die) == NULL) {
 		pr_debug("variable has no type\n");
+		ann_data_stat.no_typeinfo++;
 		return -1;
 	}
 
@@ -208,18 +209,21 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 	if (dwarf_tag(type_die) != DW_TAG_pointer_type ||
 	    die_get_real_type(type_die, type_die) == NULL) {
 		pr_debug("no pointer or no type\n");
+		ann_data_stat.no_typeinfo++;
 		return -1;
 	}
 
 	/* Get the size of the actual type */
 	if (dwarf_aggregate_size(type_die, &size) < 0) {
 		pr_debug("type size is unknown\n");
+		ann_data_stat.invalid_size++;
 		return -1;
 	}
 
 	/* Minimal sanity check */
 	if ((unsigned)offset >= size) {
 		pr_debug("offset: %d is bigger than size: %lu\n", offset, size);
+		ann_data_stat.bad_offset++;
 		return -1;
 	}
 
@@ -238,6 +242,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
 	/* Get a compile_unit for this address */
 	if (!find_cu_die(di, pc, &cu_die)) {
 		pr_debug("cannot find CU for address %lx\n", pc);
+		ann_data_stat.no_cuinfo++;
 		return -1;
 	}
 
@@ -252,9 +257,12 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
 
 		/* Found a variable, see if it's correct */
 		ret = check_variable(&var_die, type_die, offset);
-		break;
+		goto out;
 	}
+	if (ret < 0)
+		ann_data_stat.no_var++;
 
+out:
 	free(scopes);
 	return ret;
 }
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index d2dc025b1934..8e73096c01d1 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -70,6 +70,37 @@ struct annotated_data_type {
 
 extern struct annotated_data_type unknown_type;
 
+/**
+ * struct annotated_data_stat - Debug statistics
+ * @total: Total number of entry
+ * @no_sym: No symbol or map found
+ * @no_insn: Failed to get disasm line
+ * @no_insn_ops: The instruction has no operands
+ * @no_mem_ops: The instruction has no memory operands
+ * @no_reg: Failed to extract a register from the operand
+ * @no_dbginfo: The binary has no debug information
+ * @no_cuinfo: Failed to find a compile_unit
+ * @no_var: Failed to find a matching variable
+ * @no_typeinfo: Failed to get a type info for the variable
+ * @invalid_size: Failed to get a size info of the type
+ * @bad_offset: The access offset is out of the type
+ */
+struct annotated_data_stat {
+	int total;
+	int no_sym;
+	int no_insn;
+	int no_insn_ops;
+	int no_mem_ops;
+	int no_reg;
+	int no_dbginfo;
+	int no_cuinfo;
+	int no_var;
+	int no_typeinfo;
+	int invalid_size;
+	int bad_offset;
+};
+extern struct annotated_data_stat ann_data_stat;
+
 #ifdef HAVE_DWARF_SUPPORT
 
 /* Returns data type at the location (ip, reg, offset) */
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4d725562fd0a..c284a29979d6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -100,6 +100,9 @@ static struct ins_ops nop_ops;
 static struct ins_ops lock_ops;
 static struct ins_ops ret_ops;
 
+/* Data type collection debug statistics */
+struct annotated_data_stat ann_data_stat;
+
 static int arch__grow_instructions(struct arch *arch)
 {
 	struct ins *new_instructions;
@@ -3687,11 +3690,17 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	u64 ip = he->ip;
 	int i;
 
-	if (ms->map == NULL || ms->sym == NULL)
+	ann_data_stat.total++;
+
+	if (ms->map == NULL || ms->sym == NULL) {
+		ann_data_stat.no_sym++;
 		return NULL;
+	}
 
-	if (evsel__get_arch(evsel, &arch) < 0)
+	if (evsel__get_arch(evsel, &arch) < 0) {
+		ann_data_stat.no_insn++;
 		return NULL;
+	}
 
 	/* Make sure it runs objdump to get disasm of the function */
 	symbol__ensure_annotate(ms, evsel);
@@ -3701,11 +3710,15 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	 * This is too slow...
 	 */
 	dl = find_disasm_line(ms->sym, ip);
-	if (dl == NULL)
+	if (dl == NULL) {
+		ann_data_stat.no_insn++;
 		return NULL;
+	}
 
-	if (annotate_get_insn_location(arch, dl, &loc) < 0)
+	if (annotate_get_insn_location(arch, dl, &loc) < 0) {
+		ann_data_stat.no_insn_ops++;
 		return NULL;
+	}
 
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		if (!op_loc->mem_ref)
@@ -3722,5 +3735,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		he->mem_type_off = op_loc->offset;
 		return mem_type;
 	}
+
+	ann_data_stat.no_mem_ops++;
 	return NULL;
 }
-- 
2.42.0.869.gea05f2083d-goog

