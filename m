Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD72A810655
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377850AbjLMAOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378132AbjLMAOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:14:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD37810E;
        Tue, 12 Dec 2023 16:13:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d336760e72so12470045ad.3;
        Tue, 12 Dec 2023 16:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426431; x=1703031231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2XDRHe3hVdb0VRyKswuL5JnyalndJNwy6dou82qAxk=;
        b=fqxPwFAG8DhExsJoYn3nQi/ny3FB/oLe0adW+iecJjuZn5kxr3ApRqqlM8c5tWc7GM
         hBrhel7qMDcpIgW3Q6j4FYeWX0+Oq6Rs6rUfes5oreJEVuAB/2wXZ6qZlei43R/oVTph
         UObwS9FeTg7tQ2bBwQWCChR00CcfUdIjVgbvUXN/HizYjSIF2mSXl/IFkivL89jGg05e
         Xw0K+HdPstREIS5ZthO0+SB0Qe9MAnMUe/nFSULdnovNcr8n+E2ctqgThcOv66qcHfai
         gkCdsir6IGf6NgT9nMExkOOeh+sC/iceQHtpbKRmkiMOyb6mB1kr/5se1Ch4XlhSixkD
         EwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426431; x=1703031231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b2XDRHe3hVdb0VRyKswuL5JnyalndJNwy6dou82qAxk=;
        b=igOKGn7yJS2AuryyVINEbm4iHsSnnHvzrnyjzutfNF1HSWBN67YjbAH0/Pbv91r3n7
         v+cYPf3my1Bs1UFiz6Qt/lsSV3kNhgo1jQxDfz8hm5FVLdlqDQWs4b60GBp7jEo+F+ac
         Nu4FBpYALauKZcsZy2rX/XLoiQFo/iQHaPK639ZvKNMgfQUgCw7Nzyno4wySCdUR5My5
         Pio4zXixphkkJWbgmsVhx1RJZyj7F0QuWyJtkc7b8IjdFlSvxD6xB0MDzfCLb0+VRLdP
         derk9ftSww/+NHnE5Gz8OkVOQ6A6whEm9a3zknjNzM8K0JSuNjmkwlGbmMqaX05lNu1G
         n52w==
X-Gm-Message-State: AOJu0YyRZ5Fs7pzj2Kk/5Arz9tmIM1pK5wN6Nj+uFt4Y2Nb4GHL+IPyT
        IZQ+KSEoRur4Iw6U6JzjGx8=
X-Google-Smtp-Source: AGHT+IHWhmH+Hv19SHfk6K7ZVAnHZ7QxMYCRT0e6s5fQAqR/T2RX30oAsz7HpG715oWq+/f5xLb+LQ==
X-Received: by 2002:a17:903:2b0f:b0:1d3:44ad:2156 with SMTP id mc15-20020a1709032b0f00b001d344ad2156mr1490405plb.2.1702426431031;
        Tue, 12 Dec 2023 16:13:51 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:50 -0800 (PST)
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
Subject: [PATCH 14/17] perf annotate: Add --data-type option
Date:   Tue, 12 Dec 2023 16:13:20 -0800
Message-ID: <20231213001323.718046-15-namhyung@kernel.org>
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

Support data type annotation with new --data-type option.  It internally
uses type sort key to collect sample histogram for the type and display
every members like below.

  $ perf annotate --data-type
  ...
  Annotate type: 'struct cfs_rq' in [kernel.kallsyms] (13 samples):
  ============================================================================
      samples     offset       size  field
           13          0        640  struct cfs_rq         {
            2          0         16      struct load_weight       load {
            2          0          8          unsigned long        weight;
            0          8          4          u32  inv_weight;
                                         };
            0         16          8      unsigned long    runnable_weight;
            0         24          4      unsigned int     nr_running;
            1         28          4      unsigned int     h_nr_running;
  ...

For simplicity it prints the number of samples per field for now.
But it should be easy to show the overhead percentage instead.

The number at the outer struct is a sum of the numbers of the inner
members.  For example, struct cfs_rq got total 13 samples, and 2 came
from the load (struct load_weight) and 1 from h_nr_running.  Similarly,
the struct load_weight got total 2 samples and they all came from the
weight field.

I've added two new flags in the symbol_conf for this.  The
annotate_data_member is to get the members of the type.  This is also
needed for perf report with typeoff sort key.  The annotate_data_sample
is to update sample stats for each offset and used only in annotate.

Currently it only support stdio output mode, TUI support can be added
later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-annotate.txt |  8 ++
 tools/perf/builtin-annotate.c              | 97 +++++++++++++++++++++-
 tools/perf/util/annotate-data.c            |  8 +-
 tools/perf/util/annotate.c                 | 10 ++-
 tools/perf/util/sort.c                     |  2 +
 tools/perf/util/symbol_conf.h              |  4 +-
 6 files changed, 118 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index fe168e8165c8..0e6a49b7795c 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -155,6 +155,14 @@ include::itrace.txt[]
 	stdio or stdio2 (Default: 0).  Note that this is about selection of
 	functions to display, not about lines within the function.
 
+--data-type[=TYPE_NAME]::
+	Display data type annotation instead of code.  It infers data type of
+	samples (if they are memory accessing instructions) using DWARF debug
+	information.  It can take an optional argument of data type name.  In
+	that case it'd show annotation for the type only, otherwise it'd show
+	all data types it finds.
+
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index d880f1b039fd..8acfbbc1b9c2 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -20,6 +20,7 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/annotate.h"
+#include "util/annotate-data.h"
 #include "util/event.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
@@ -55,9 +56,11 @@ struct perf_annotate {
 	bool	   skip_missing;
 	bool	   has_br_stack;
 	bool	   group_set;
+	bool	   data_type;
 	float	   min_percent;
 	const char *sym_hist_filter;
 	const char *cpu_list;
+	const char *target_data_type;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 };
 
@@ -322,6 +325,32 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 	return symbol__tty_annotate2(&he->ms, evsel);
 }
 
+static void print_annotated_data_type(struct annotated_data_type *mem_type,
+				      struct annotated_member *member,
+				      struct evsel *evsel, int indent)
+{
+	struct annotated_member *child;
+	struct type_hist *h = mem_type->histograms[evsel->core.idx];
+	int i, samples = 0;
+
+	for (i = 0; i < member->size; i++)
+		samples += h->addr[member->offset + i].nr_samples;
+
+	printf(" %10d %10d %10d  %*s%s\t%s",
+	       samples, member->offset, member->size, indent, "", member->type_name,
+	       member->var_name ?: "");
+
+	if (!list_empty(&member->children))
+		printf(" {\n");
+
+	list_for_each_entry(child, &member->children, node)
+		print_annotated_data_type(mem_type, child, evsel, indent + 4);
+
+	if (!list_empty(&member->children))
+		printf("%*s}", 35 + indent, "");
+	printf(";\n");
+}
+
 static void hists__find_annotations(struct hists *hists,
 				    struct evsel *evsel,
 				    struct perf_annotate *ann)
@@ -361,6 +390,40 @@ static void hists__find_annotations(struct hists *hists,
 			continue;
 		}
 
+		if (ann->data_type) {
+			struct dso *dso = map__dso(he->ms.map);
+
+			/* skip unknown type */
+			if (he->mem_type->histograms == NULL)
+				goto find_next;
+
+			if (ann->target_data_type) {
+				const char *type_name = he->mem_type->self.type_name;
+
+				/* skip 'struct ' prefix in the type name */
+				if (strncmp(ann->target_data_type, "struct ", 7) &&
+				    !strncmp(type_name, "struct ", 7))
+					type_name += 7;
+
+				/* skip 'union ' prefix in the type name */
+				if (strncmp(ann->target_data_type, "union ", 6) &&
+				    !strncmp(type_name, "union ", 6))
+					type_name += 6;
+
+				if (strcmp(ann->target_data_type, type_name))
+					goto find_next;
+			}
+
+			printf("Annotate type: '%s' in %s (%d samples):\n",
+				he->mem_type->self.type_name, dso->name, he->stat.nr_events);
+			printf("============================================================================\n");
+			printf(" %10s %10s %10s  %s\n", "samples", "offset", "size", "field");
+
+			print_annotated_data_type(he->mem_type, &he->mem_type->self, evsel, 0);
+			printf("\n");
+			goto find_next;
+		}
+
 		if (use_browser == 2) {
 			int ret;
 			int (*annotate)(struct hist_entry *he,
@@ -496,6 +559,17 @@ static int parse_percent_limit(const struct option *opt, const char *str,
 	return 0;
 }
 
+static int parse_data_type(const struct option *opt, const char *str, int unset)
+{
+	struct perf_annotate *ann = opt->value;
+
+	ann->data_type = !unset;
+	if (str)
+		ann->target_data_type = strdup(str);
+
+	return 0;
+}
+
 static const char * const annotate_usage[] = {
 	"perf annotate [<options>]",
 	NULL
@@ -607,6 +681,9 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
 			    "Instruction Tracing options\n" ITRACE_HELP,
 			    itrace_parse_synth_opts),
+	OPT_CALLBACK_OPTARG(0, "data-type", &annotate, NULL, "name",
+			    "Show data type annotate for the memory accesses",
+			    parse_data_type),
 
 	OPT_END()
 	};
@@ -661,6 +738,13 @@ int cmd_annotate(int argc, const char **argv)
 	}
 #endif
 
+#ifndef HAVE_DWARF_GETLOCATIONS_SUPPORT
+	if (annotate.data_type) {
+		pr_err("Error: Data type profiling is disabled due to missing DWARF support\n");
+		return -ENOTSUP;
+	}
+#endif
+
 	ret = symbol__validate_sym_arguments();
 	if (ret)
 		return ret;
@@ -703,6 +787,14 @@ int cmd_annotate(int argc, const char **argv)
 		use_browser = 2;
 #endif
 
+	/* FIXME: only support stdio for now */
+	if (annotate.data_type) {
+		use_browser = 0;
+		annotate_opts.annotate_src = false;
+		symbol_conf.annotate_data_member = true;
+		symbol_conf.annotate_data_sample = true;
+	}
+
 	setup_browser(true);
 
 	/*
@@ -710,7 +802,10 @@ int cmd_annotate(int argc, const char **argv)
 	 * symbol, we do not care about the processes in annotate,
 	 * set sort order to avoid repeated output.
 	 */
-	sort_order = "dso,symbol";
+	if (annotate.data_type)
+		sort_order = "dso,type";
+	else
+		sort_order = "dso,symbol";
 
 	/*
 	 * Set SORT_MODE__BRANCH so that annotate display IPC/Cycle
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 9942a87b0664..06be6b279d6a 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -18,6 +18,7 @@
 #include "map_symbol.h"
 #include "strbuf.h"
 #include "symbol.h"
+#include "symbol_conf.h"
 
 /*
  * Compare type name and size to maintain them in a tree.
@@ -157,11 +158,8 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
 	result->self.size = size;
 	INIT_LIST_HEAD(&result->self.children);
 
-	/*
-	 * Fill member info unconditionally for now,
-	 * later perf annotate would need it.
-	 */
-	add_member_types(result, type_die);
+	if (symbol_conf.annotate_data_member)
+		add_member_types(result, type_die);
 
 	rb_add(&result->node, &dso->data_types, data_type_less);
 	return result;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f966e8f83c5e..68424ee0215e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3712,10 +3712,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
 		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
 
-		annotated_data_type__update_samples(mem_type, evsel,
-						    op_loc->offset,
-						    he->stat.nr_events,
-						    he->stat.period);
+		if (symbol_conf.annotate_data_sample) {
+			annotated_data_type__update_samples(mem_type, evsel,
+							    op_loc->offset,
+							    he->stat.nr_events,
+							    he->stat.period);
+		}
 		he->mem_type_off = op_loc->offset;
 		return mem_type;
 	}
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0cbbd5ba8175..30254eb63709 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3401,6 +3401,8 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 			list->thread = 1;
 		} else if (sd->entry == &sort_comm) {
 			list->comm = 1;
+		} else if (sd->entry == &sort_type_offset) {
+			symbol_conf.annotate_data_member = true;
 		}
 
 		return __sort_dimension__add(sd, list, level);
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 6040286e07a6..c114bbceef40 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -44,7 +44,9 @@ struct symbol_conf {
 			buildid_mmap2,
 			guest_code,
 			lazy_load_kernel_maps,
-			keep_exited_threads;
+			keep_exited_threads,
+			annotate_data_member,
+			annotate_data_sample;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-- 
2.43.0.472.g3155946c3a-goog

