Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180827E757F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345492AbjKJACR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbjKJABj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:39 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6325478B;
        Thu,  9 Nov 2023 16:00:52 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so2052782a12.0;
        Thu, 09 Nov 2023 16:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574452; x=1700179252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3p/0qsKuHXZ71nZRToEzeJmSxz+5PnmASt9/Ym8sAw=;
        b=QEmsw5IbPNVdeVM+E4OQ4Ow4pnYZdm6CoOAmjvApS45/Nw82jjXApR9q+f+LER8SGf
         +JD8VALlt//G//lTkF2L9pbGguCnzxQ4E9eBAZ+RIkhEnmvq8whxG8WmxwtSzMInIsYt
         EgHovb61zNo2Mt5lxDj17HeLjqZ79tXgIz5t+I3D6GLtpYSlcIYKGd+oSO3gwbKXJmuF
         4guCMZw1zTztwKnO7sI3VNIu9PuPOmoW6T2XDggFPqdaccaq4NRRNd3ha1iFdt3xYaS5
         g3ZwLJS0zCQcUBKC8B2igLy/vAL+5o0WFPqsrnQ4a71LoIjFeDyGGVENJ+NcV/4ESg3F
         6bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574452; x=1700179252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3p/0qsKuHXZ71nZRToEzeJmSxz+5PnmASt9/Ym8sAw=;
        b=QksSmjfcrZxMIwGLjSCz7BuVteUiDyEJVH+7/ew9yi3UxXKvUHDB3w7J7n7ewokcSo
         Jg4or0+e7Hc9PybuFf+Vv+wF6ViSWPZ5YiV2u45LEO9QnEz4n2M2PImD4khrJAoIlozy
         usPJzQ8Rz0JzvJ9nVPvlF7c/29ECxxNYNzdSInOzsXlRKQGNnX5IDeNODLpDbS+UTSfg
         7IJJUO7uGZs8jGcjww+QA5aWrzw957+5+RV6GolvvCrrdpjKRZ0NMZgTuPYrMA9pGGV6
         u78gNGsm6Dwv8ecrXSYXB3MNIjoP+6q2KgpWgUoITC4Z1ZsMXeoKYq2/u2G9WfebNqfr
         554g==
X-Gm-Message-State: AOJu0Yyr5PqEoKL2EcP4dz7oJVokgn6E39xCfRqYyasUaUKff2hQArJz
        jZVyrFLYqzlr7QxWHdflH9U=
X-Google-Smtp-Source: AGHT+IE7GjZMCJt+06XhSqkg7mgNP+8BVanL2EdM0Rmo1Tvvp4/L5bEoFMLOSvJsztFe3SNtnY5LGg==
X-Received: by 2002:a17:90b:11c1:b0:277:68c3:64b9 with SMTP id gv1-20020a17090b11c100b0027768c364b9mr1200733pjb.5.1699574451924;
        Thu, 09 Nov 2023 16:00:51 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:51 -0800 (PST)
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
Subject: [PATCH 24/52] perf annotate: Add --data-type option
Date:   Thu,  9 Nov 2023 15:59:43 -0800
Message-ID: <20231110000012.3538610-25-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 tools/perf/builtin-annotate.c              | 94 +++++++++++++++++++++-
 tools/perf/util/annotate-data.c            |  8 +-
 tools/perf/util/annotate.c                 | 10 ++-
 tools/perf/util/sort.c                     |  2 +
 tools/perf/util/symbol_conf.h              |  4 +-
 6 files changed, 115 insertions(+), 11 deletions(-)

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
index a9129b51d511..2290ce3bdc2e 100644
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
@@ -56,9 +57,11 @@ struct perf_annotate {
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
 
@@ -234,8 +237,12 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_entry *he;
+	struct annotation *notes = al->sym ? symbol__annotation(al->sym) : NULL;
 	int ret;
 
+	if (notes)
+		notes->options = &ann->opts;
+
 	if ((!ann->has_br_stack || !has_annotation(ann)) &&
 	    ann->sym_hist_filter != NULL &&
 	    (al->sym == NULL ||
@@ -323,6 +330,32 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 	return symbol__tty_annotate2(&he->ms, evsel, &ann->opts);
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
@@ -362,6 +395,40 @@ static void hists__find_annotations(struct hists *hists,
 			continue;
 		}
 
+		if (ann->data_type) {
+			struct map *map = he->ms.map;
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
+				he->mem_type->self.type_name, map->dso->name, he->stat.nr_events);
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
@@ -498,6 +565,17 @@ static int parse_percent_limit(const struct option *opt, const char *str,
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
@@ -609,6 +687,9 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
 			    "Instruction Tracing options\n" ITRACE_HELP,
 			    itrace_parse_synth_opts),
+	OPT_CALLBACK_OPTARG(0, "data-type", &annotate, NULL, "name",
+			    "Show data type annotate for the memory accesses",
+			    parse_data_type),
 
 	OPT_END()
 	};
@@ -705,6 +786,14 @@ int cmd_annotate(int argc, const char **argv)
 		use_browser = 2;
 #endif
 
+	/* FIXME: only support stdio for now */
+	if (annotate.data_type) {
+		use_browser = 0;
+		annotate.opts.annotate_src = false;
+		symbol_conf.annotate_data_member = true;
+		symbol_conf.annotate_data_sample = true;
+	}
+
 	setup_browser(true);
 
 	/*
@@ -712,7 +801,10 @@ int cmd_annotate(int argc, const char **argv)
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
index 3c452d037948..5326396b08ec 100644
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
index 76309f1e6e39..4d725562fd0a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3713,10 +3713,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
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
2.42.0.869.gea05f2083d-goog

