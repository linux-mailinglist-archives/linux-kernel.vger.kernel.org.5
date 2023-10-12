Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CD07C637D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376758AbjJLDx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377321AbjJLDwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012A31BC;
        Wed, 11 Oct 2023 20:51:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c7373cff01so13468115ad.1;
        Wed, 11 Oct 2023 20:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082704; x=1697687504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7uHYDAA9VeGr5WawxBTNd1cNrO0i4L2JxTGBE9KuJA=;
        b=SYBGsavkf2j8fYuXqZ52WfAZmmA6uPPSK5+o0zp/0KdREleQfJjFWcZ0rYXTvkNlrj
         O6m4i6imbqmqJA1ZecH6LLyYnCZt+yzs4JK2tXNR8RGNcYObo3rUNQiBXeplluKVP1RC
         A+mNxzOhEu1q1ZNtkUIXlgzWGRvZkSN6qOFbJ32bmHqtGGjDgeY37LGrB7RPaiInNCJ2
         1BDXOfHm9dnGP90WnQ6MvkAqAq9WCwoPb+tmexZQ0pF7Mr8wc2vEup32QkPl5yD8XWVN
         /k0O2BpJA/AU5jSvk7zm492dpb3L463B4vG+QI20oQDOD7Cay+cdrvXXYIJdBxqsF4Vz
         lDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082704; x=1697687504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7uHYDAA9VeGr5WawxBTNd1cNrO0i4L2JxTGBE9KuJA=;
        b=osKpf6jppDBBfhl19j+CufMfl5ll6NRztM18ebjI5VEnJNz9qpf7Bs65XDXr/io/KO
         uXbapO7XX1SVusDMZ3LtKa5hly5PJiY6y37seIL5l1r1elolM83kJTY8vq7WPmd4PPKE
         4IdoPnkz0iv7zlGcEn/tdcejdp8ndyNBsjLvbz6O/f7w92gyaAmKs5OPvpSOA58KV5p8
         Oo/mxLfCrRvs5KEE+587fh6cte4LAUNKOEo0LuExtrPgWmY+5Qazwt5WAuNSVLMXU8rr
         OaaHikyW26nNcdGwWZLpzHWaleUB6uTOnT/ky6jkaS8pO1xZIdvHbLkfmhpNwtaJBxem
         /CuQ==
X-Gm-Message-State: AOJu0YxFbpLy6WhyAqQ0Dc81mNeZfz/L2w1EwGix/S6Fu4xheYIi/+5K
        rVfBbyh9FB9w/dcEviW7UOl/c5BBx0Q=
X-Google-Smtp-Source: AGHT+IHeHSnw9TLEbJ0MI7Fq9W8cuetn3/gjN1gWOClQAo8ncAu6ZbymRdNheGi78nbxg0Q9OCX2zA==
X-Received: by 2002:a17:902:a387:b0:1c9:c32e:c9a0 with SMTP id x7-20020a170902a38700b001c9c32ec9a0mr7750338pla.2.1697082703674;
        Wed, 11 Oct 2023 20:51:43 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:43 -0700 (PDT)
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
Subject: [PATCH 22/48] perf annotate: Add --type-stat option for debugging
Date:   Wed, 11 Oct 2023 20:50:45 -0700
Message-ID: <20231012035111.676789-23-namhyung@kernel.org>
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
 tools/perf/builtin-annotate.c   | 44 ++++++++++++++++++++++++++++++++-
 tools/perf/util/annotate-data.c | 13 +++++++++-
 tools/perf/util/annotate-data.h | 31 +++++++++++++++++++++++
 tools/perf/util/annotate.c      | 20 ++++++++++++---
 4 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6be15a37d2b7..645acaba63f1 100644
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
@@ -352,6 +353,43 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
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
@@ -359,6 +397,9 @@ static void hists__find_annotations(struct hists *hists,
 	struct rb_node *nd = rb_first_cached(&hists->entries), *next;
 	int key = K_RIGHT;
 
+	if (ann->type_stat)
+		print_annotate_data_stat(&ann_data_stat);
+
 	while (nd) {
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
 		struct annotation *notes;
@@ -657,7 +698,8 @@ int cmd_annotate(int argc, const char **argv)
 			    itrace_parse_synth_opts),
 	OPT_BOOLEAN(0, "data-type", &annotate.data_type,
 		    "Show data type annotate for the memory accesses"),
-
+	OPT_BOOLEAN(0, "type-stat", &annotate.type_stat,
+		    "Show stats for the data type annotation"),
 	OPT_END()
 	};
 	int ret;
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index ba7d35648b05..3e30e6855ba8 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -28,6 +28,9 @@ struct annotated_data_type unknown_type = {
 	},
 };
 
+/* Data type collection debug statistics */
+struct annotated_data_stat ann_data_stat;
+
 /*
  * Compare type name and size to maintain them in a tree.
  * I'm not sure if DWARF would have information of a single type in many
@@ -206,6 +209,7 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 	/* Get the type of the variable */
 	if (die_get_real_type(var_die, type_die) == NULL) {
 		pr_debug("variable has no type\n");
+		ann_data_stat.no_typeinfo++;
 		return -1;
 	}
 
@@ -216,18 +220,21 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
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
 
@@ -246,6 +253,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
 	/* Get a compile_unit for this address */
 	if (!find_cu_die(di, pc, &cu_die)) {
 		pr_debug("cannot find CU for address %lx\n", pc);
+		ann_data_stat.no_cuinfo++;
 		return -1;
 	}
 
@@ -260,9 +268,12 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
 
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
index 3d9bb6b33e1a..72b867001e22 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3649,11 +3649,17 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
@@ -3663,11 +3669,15 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
@@ -3684,5 +3694,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		he->mem_type_off = op_loc->offset;
 		return mem_type;
 	}
+
+	ann_data_stat.no_mem_ops++;
 	return NULL;
 }
-- 
2.42.0.655.g421f12c284-goog

