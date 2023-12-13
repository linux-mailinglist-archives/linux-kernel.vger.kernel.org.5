Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414A9810658
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378048AbjLMAPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378088AbjLMAOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:14:25 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88ADD7F;
        Tue, 12 Dec 2023 16:13:55 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so5356312a12.3;
        Tue, 12 Dec 2023 16:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426434; x=1703031234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr891Vz5SQNxL8Og5romUrWd4YL5FuA0hfmf+OmYlyU=;
        b=VvPOwh2DAeUuySNWhCsJnkd6xJWGJdTzKxLRt2M23ZlNY5j95o8RzQuVXjKedmm2J3
         dhaa13jCmKC51BiJTkRAh57ZBzImBEossEEskaE+E7E4Jcq2UYNcN12TYBevSN+B2DDL
         aJARlg9qTU+ndBcXSlGMTn5K4tZ/2FL6xUV7UOl3TeoSEqL6rL0qg/0xYdalvud1AdhK
         fR/0mIllV+sY68jEjTFd+cobauJ2DeblykPpffh8hkgV6v3l63z/HnZs/htaqo3KbygV
         zrekOeOa1djZs8vXddG1BWG/sjPM01dAToBy3ce5HqY7jbv3V6AchZrVtyfigFIc6ZDz
         OcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426434; x=1703031234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xr891Vz5SQNxL8Og5romUrWd4YL5FuA0hfmf+OmYlyU=;
        b=H4zdyP1XcsUpOL8sIQ7jhbQidPmKmJ5+AvMZMT5Druura8xYsVr56fQF1xR+jwhpVH
         HEIPALu95otNnSSZfrryEv4tQ0rERPvyb0CvBlsd8H6qy7h/HjVP45Z3tOza3I8h4ucu
         knXehqayJ4kdWYnjeT1YGTmXg5E+NSQkHnSLBcwl4Xx9g1wAzMBgqwWa96rk1/ncElno
         gGabx4mFYIdatsRTgN0JdFLBK5Corg8+DdHAyaliCEutJ+nfq3hRh9LXHKTlMbhGvMeS
         PdcWiwkLyz+Mj9Aai1jCkcHXX9K6TcvbA5Yk9PboCVJZi1GL1N/nkah9hnFHmxMcqyF+
         CVrg==
X-Gm-Message-State: AOJu0YyT7aHvHDs+9J9cw0XmiSuAaf7rkr7K2Tq6Tqrr32qodALV4cnG
        MmLnZZIHexsZF/woqjAdvCE=
X-Google-Smtp-Source: AGHT+IE46oXXhVdBoTIveX4yK2e7/LYlmjd18PJR//mvVD/fTbDIBQPtLrXgUW4acvUGUDkth9W+rw==
X-Received: by 2002:a17:902:e84d:b0:1cc:548d:4252 with SMTP id t13-20020a170902e84d00b001cc548d4252mr8789872plg.57.1702426434212;
        Tue, 12 Dec 2023 16:13:54 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:53 -0800 (PST)
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
Subject: [PATCH 16/17] perf annotate: Add --type-stat option for debugging
Date:   Tue, 12 Dec 2023 16:13:22 -0800
Message-ID: <20231213001323.718046-17-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213001323.718046-1-namhyung@kernel.org>
References: <20231213001323.718046-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
 tools/perf/Documentation/perf-annotate.txt |  3 ++
 tools/perf/builtin-annotate.c              | 44 +++++++++++++++++++++-
 tools/perf/util/annotate-data.c            | 10 ++++-
 tools/perf/util/annotate-data.h            | 31 +++++++++++++++
 tools/perf/util/annotate.c                 | 27 ++++++++++---
 5 files changed, 108 insertions(+), 7 deletions(-)

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
index 3956ea1334cc..55f97ab1395b 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -57,6 +57,7 @@ struct perf_annotate {
 	bool	   has_br_stack;
 	bool	   group_set;
 	bool	   data_type;
+	bool	   type_stat;
 	float	   min_percent;
 	const char *sym_hist_filter;
 	const char *cpu_list;
@@ -396,6 +397,43 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
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
@@ -403,6 +441,9 @@ static void hists__find_annotations(struct hists *hists,
 	struct rb_node *nd = rb_first_cached(&hists->entries), *next;
 	int key = K_RIGHT;
 
+	if (ann->type_stat)
+		print_annotate_data_stat(&ann_data_stat);
+
 	while (nd) {
 		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
 		struct annotation *notes;
@@ -749,7 +790,8 @@ int cmd_annotate(int argc, const char **argv)
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
index 06be6b279d6a..2ef4daf6b12b 100644
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
index 68424ee0215e..9870257ce21e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -103,6 +103,9 @@ static struct ins_ops nop_ops;
 static struct ins_ops lock_ops;
 static struct ins_ops ret_ops;
 
+/* Data type collection debug statistics */
+struct annotated_data_stat ann_data_stat;
+
 static int arch__grow_instructions(struct arch *arch)
 {
 	struct ins *new_instructions;
@@ -3683,14 +3686,22 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	u64 ip = he->ip;
 	int i;
 
-	if (ms->map == NULL || ms->sym == NULL)
+	ann_data_stat.total++;
+
+	if (ms->map == NULL || ms->sym == NULL) {
+		ann_data_stat.no_sym++;
 		return NULL;
+	}
 
-	if (!symbol_conf.init_annotation)
+	if (!symbol_conf.init_annotation) {
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
@@ -3700,11 +3711,15 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
@@ -3721,5 +3736,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		he->mem_type_off = op_loc->offset;
 		return mem_type;
 	}
+
+	ann_data_stat.no_mem_ops++;
 	return NULL;
 }
-- 
2.43.0.472.g3155946c3a-goog

