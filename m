Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568677C637C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347060AbjJLDxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377305AbjJLDwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECC1B2;
        Wed, 11 Oct 2023 20:51:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-578e33b6fb7so380474a12.3;
        Wed, 11 Oct 2023 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082702; x=1697687502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzzarU0Z4Z0jmC7pIDakAMpcrgTYGcG0+o/ody08WOk=;
        b=Yc5nS6vAHahHkopz8L1ivo7XRcLZ/xFlrTUyoHle+gqp+P+QHpc8rtxBygYGZMMwcH
         6ojzt4qnu+8X/zfI+vP7lvIZixS1qUSAO/E/qessmisrSXBsusKRhiLqcdxf3r5u10ls
         nM22aevomtTNK5Q6+KvyB17Gcez6qfuGfHnahtwmDNvZ6Xez/2BqgqUg8StLxYuwe1J6
         Fk2pHmDfRLV4WRRtkcg3Va68hQc/cVT+bsBQNrZkaVfQmVaWVlTlvwDRIfPdM/QUeKI2
         WbdOMQxTgyDqiwaPsP03Eh/6J3/B3Xn8hbnuGNOVbmadmcMfojNlAI3UZ+FoGHcWYyVG
         PkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082702; x=1697687502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EzzarU0Z4Z0jmC7pIDakAMpcrgTYGcG0+o/ody08WOk=;
        b=oJc7htKFivg5PHat6jD75jIhN7+7YDO0ulkNT5yq4bRH7/e/dLaSItVFmVdrFYIeYx
         NTD1EsJHfyqBN5VLBAfwyMD7Tc4jeITPuPTBgb8pmY+ny3qOvC/XabTH4ydkc4ZHE2mV
         /dyNmlnm7VW2pfqFml57xSbAfrc20a8OJmlbhXCyuTdPS6tG45bs5b3fugJaUxJUm2n8
         OdpZWmMaX8tZoZIM9pfk0Q19eyRQok6Na2wX/yncVoSeuee0rWB1vw4GEr4w5cHvPqO1
         1q59UqqVJvS7vps+8eTczobImVo3w3LKMocKIA6+NMznO/VCxZUscA5XVJr4GmPkvdYJ
         XJkw==
X-Gm-Message-State: AOJu0Yx9GJJu97EfguRWI26TK9qbKt5ZLOaSTO5FP+kKmseT79FoT32F
        yG8VsxJa6Nti7vHDDNepFq8=
X-Google-Smtp-Source: AGHT+IHx6Pj8xx72+mL0339BbM2hpIPuiXUgZ98E+U2RhBq0mFkTnrmoTIzG7//AggUp0LSYqNFnBQ==
X-Received: by 2002:a17:903:124d:b0:1bf:d92e:c5a7 with SMTP id u13-20020a170903124d00b001bfd92ec5a7mr24609415plh.28.1697082702409;
        Wed, 11 Oct 2023 20:51:42 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:42 -0700 (PDT)
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
Subject: [PATCH 21/48] perf annotate: Add --data-type option
Date:   Wed, 11 Oct 2023 20:50:44 -0700
Message-ID: <20231012035111.676789-22-namhyung@kernel.org>
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
 tools/perf/builtin-annotate.c   | 64 ++++++++++++++++++++++++++++++++-
 tools/perf/util/annotate-data.c |  8 ++---
 tools/perf/util/annotate.c      | 10 +++---
 tools/perf/util/sort.c          |  2 ++
 tools/perf/util/symbol_conf.h   |  4 ++-
 5 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index aeeb801f1ed7..6be15a37d2b7 100644
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
@@ -56,6 +57,7 @@ struct perf_annotate {
 	bool	   skip_missing;
 	bool	   has_br_stack;
 	bool	   group_set;
+	bool	   data_type;
 	float	   min_percent;
 	const char *sym_hist_filter;
 	const char *cpu_list;
@@ -231,8 +233,12 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
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
@@ -320,6 +326,32 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
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
@@ -359,6 +391,23 @@ static void hists__find_annotations(struct hists *hists,
 			continue;
 		}
 
+		if (ann->data_type) {
+			struct map *map = he->ms.map;
+
+			/* skip unknown type */
+			if (he->mem_type->histograms == NULL)
+				goto find_next;
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
@@ -606,6 +655,8 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
 			    "Instruction Tracing options\n" ITRACE_HELP,
 			    itrace_parse_synth_opts),
+	OPT_BOOLEAN(0, "data-type", &annotate.data_type,
+		    "Show data type annotate for the memory accesses"),
 
 	OPT_END()
 	};
@@ -702,6 +753,14 @@ int cmd_annotate(int argc, const char **argv)
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
@@ -709,7 +768,10 @@ int cmd_annotate(int argc, const char **argv)
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
index adeab45a3c63..ba7d35648b05 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -18,6 +18,7 @@
 #include "map_symbol.h"
 #include "strbuf.h"
 #include "symbol.h"
+#include "symbol_conf.h"
 
 /* Pseudo data types */
 struct annotated_data_type unknown_type = {
@@ -165,11 +166,8 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
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
index 49d5b61e19e6..3d9bb6b33e1a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3675,10 +3675,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
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
index e21bbd442637..35eb589c03ec 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -3394,6 +3394,8 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 			list->thread = 1;
 		} else if (sd->entry == &sort_comm) {
 			list->comm = 1;
+		} else if (sd->entry == &sort_type_offset) {
+			symbol_conf.annotate_data_member = true;
 		}
 
 		return __sort_dimension__add(sd, list, level);
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 0b589570d1d0..e6a1c48ca3bf 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -42,7 +42,9 @@ struct symbol_conf {
 			inline_name,
 			disable_add2line_warn,
 			buildid_mmap2,
-			guest_code;
+			guest_code,
+			annotate_data_member,
+			annotate_data_sample;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
-- 
2.42.0.655.g421f12c284-goog

