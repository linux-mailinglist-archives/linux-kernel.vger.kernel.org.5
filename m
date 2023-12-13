Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B507C81064F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377900AbjLMAOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378072AbjLMAOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:14:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF2F18B;
        Tue, 12 Dec 2023 16:13:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28aabe4a728so1595189a91.3;
        Tue, 12 Dec 2023 16:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426426; x=1703031226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kifl4SjCttpoE3YbA0HzyiKu/IX8gHekgWV4VdFJxM=;
        b=SjIihaHE2OJQ8fvMe6RBvQcqSQWws62Wse5gpuAx6aL+xvMap1SVS/e73+Gn96SRer
         odpiT25oHTXNmRSaHs3R5Ywe+PWPBClngO+oWCxXdv4F0uU23wMcootzdVFe7WZKCV6i
         L/7Pkycq3+sjplpLznApAK9nDTptSVPsZGgEknXfTo1R8U84eMgQgGLqgUsYycMYtlNR
         +HrmgoAdHJkEd3vKLfSptZ6JTohRVhBGNQDNr33Sj+j9iDHk0jji3AD1LbvcPOzJDZdS
         i9Z1Ovm9H8k4W0XYcBaRP9KChQjxq3iERW5xRSt9OnSDMvnux3aDqAnvGsAW3O4y4UN8
         CL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426426; x=1703031226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4kifl4SjCttpoE3YbA0HzyiKu/IX8gHekgWV4VdFJxM=;
        b=AQCdLlL9HIUuzTrgUcQ+fkoDpbkTE/yKYi6ohuZzs1tGkbKTXN0XzyYYUTRMaFdNab
         amJuo6exuARJEyqBFk2YBI1M3dLhV1mZX08QVf+Tx2NTNf7vsp2zi+t/mvflRTHSa62r
         y0114R5YiOt7tv9EpOGnchkhoxN7gMziKN06I4TRl+JXzlkgfwwv2rzZzNFAtT54S/dG
         zyJFQ/YHEX/cHW2fr5zIsh+fwmuWdK4tqQV0rL11JHwHdfOtsJU+szDshrBK+jFimPGU
         WO4S25q6uN0FE6Licofi0In3k2r0pNMwGTPb6x0JcqUtHh1w7i3Xjx7dnNVDQvA33MhM
         qE0w==
X-Gm-Message-State: AOJu0Yy/L2zelku0B4+IKTkDNq1E1kLqKerqwmWQHiUaa7M0GRasU+hO
        /AjvCMzXX/YjEt1r5K25EtU=
X-Google-Smtp-Source: AGHT+IG1vyHSG8awy8FoP43a7HAn2By+9Bt9p19PSjYoPFI4UElEaDsfqufGTRQODkT5OXsGnyrkMA==
X-Received: by 2002:a17:902:ec89:b0:1cf:b29d:3e8e with SMTP id x9-20020a170902ec8900b001cfb29d3e8emr4110430plg.58.1702426425811;
        Tue, 12 Dec 2023 16:13:45 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:45 -0800 (PST)
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
Subject: [PATCH 11/17] perf annotate-data: Update sample histogram for type
Date:   Tue, 12 Dec 2023 16:13:17 -0800
Message-ID: <20231213001323.718046-12-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213001323.718046-1-namhyung@kernel.org>
References: <20231213001323.718046-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The annotated_data_type__update_samples() to get histogram for data type
access.  It'll be called by perf annotate to show which fields in the
data type are accessed frequently.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 81 +++++++++++++++++++++++++++++++++
 tools/perf/util/annotate-data.h | 42 +++++++++++++++++
 tools/perf/util/annotate.c      |  9 +++-
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index d9c63e989b6e..9942a87b0664 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -12,6 +12,8 @@
 #include "debuginfo.h"
 #include "debug.h"
 #include "dso.h"
+#include "evsel.h"
+#include "evlist.h"
 #include "map.h"
 #include "map_symbol.h"
 #include "strbuf.h"
@@ -301,6 +303,44 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	return result;
 }
 
+static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_entries)
+{
+	int i;
+	size_t sz = sizeof(struct type_hist);
+
+	sz += sizeof(struct type_hist_entry) * adt->self.size;
+
+	/* Allocate a table of pointers for each event */
+	adt->nr_histograms = nr_entries;
+	adt->histograms = calloc(nr_entries, sizeof(*adt->histograms));
+	if (adt->histograms == NULL)
+		return -ENOMEM;
+
+	/*
+	 * Each histogram is allocated for the whole size of the type.
+	 * TODO: Probably we can move the histogram to members.
+	 */
+	for (i = 0; i < nr_entries; i++) {
+		adt->histograms[i] = zalloc(sz);
+		if (adt->histograms[i] == NULL)
+			goto err;
+	}
+	return 0;
+
+err:
+	while (--i >= 0)
+		free(adt->histograms[i]);
+	free(adt->histograms);
+	return -ENOMEM;
+}
+
+static void delete_data_type_histograms(struct annotated_data_type *adt)
+{
+	for (int i = 0; i < adt->nr_histograms; i++)
+		free(adt->histograms[i]);
+	free(adt->histograms);
+}
+
 void annotated_data_type__tree_delete(struct rb_root *root)
 {
 	struct annotated_data_type *pos;
@@ -311,7 +351,48 @@ void annotated_data_type__tree_delete(struct rb_root *root)
 		rb_erase(node, root);
 		pos = rb_entry(node, struct annotated_data_type, node);
 		delete_members(&pos->self);
+		delete_data_type_histograms(pos);
 		free(pos->self.type_name);
 		free(pos);
 	}
 }
+
+/**
+ * annotated_data_type__update_samples - Update histogram
+ * @adt: Data type to update
+ * @evsel: Event to update
+ * @offset: Offset in the type
+ * @nr_samples: Number of samples at this offset
+ * @period: Event count at this offset
+ *
+ * This function updates type histogram at @ofs for @evsel.  Samples are
+ * aggregated before calling this function so it can be called with more
+ * than one samples at a certain offset.
+ */
+int annotated_data_type__update_samples(struct annotated_data_type *adt,
+					struct evsel *evsel, int offset,
+					int nr_samples, u64 period)
+{
+	struct type_hist *h;
+
+	if (adt == NULL)
+		return 0;
+
+	if (adt->histograms == NULL) {
+		int nr = evsel->evlist->core.nr_entries;
+
+		if (alloc_data_type_histograms(adt, nr) < 0)
+			return -1;
+	}
+
+	if (offset < 0 || offset >= adt->self.size)
+		return -1;
+
+	h = adt->histograms[evsel->core.idx];
+
+	h->nr_samples += nr_samples;
+	h->addr[offset].nr_samples += nr_samples;
+	h->period += period;
+	h->addr[offset].period += period;
+	return 0;
+}
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 33748222e6aa..d2dc025b1934 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -7,6 +7,7 @@
 #include <linux/rbtree.h>
 #include <linux/types.h>
 
+struct evsel;
 struct map_symbol;
 
 /**
@@ -29,16 +30,42 @@ struct annotated_member {
 	int size;
 };
 
+/**
+ * struct type_hist_entry - Histogram entry per offset
+ * @nr_samples: Number of samples
+ * @period: Count of event
+ */
+struct type_hist_entry {
+	int nr_samples;
+	u64 period;
+};
+
+/**
+ * struct type_hist - Type histogram for each event
+ * @nr_samples: Total number of samples in this data type
+ * @period: Total count of the event in this data type
+ * @offset: Array of histogram entry
+ */
+struct type_hist {
+	u64			nr_samples;
+	u64			period;
+	struct type_hist_entry	addr[];
+};
+
 /**
  * struct annotated_data_type - Data type to profile
  * @node: RB-tree node for dso->type_tree
  * @self: Actual type information
+ * @nr_histogram: Number of histogram entries
+ * @histograms: An array of pointers to histograms
  *
  * This represents a data type accessed by samples in the profile data.
  */
 struct annotated_data_type {
 	struct rb_node node;
 	struct annotated_member self;
+	int nr_histograms;
+	struct type_hist **histograms;
 };
 
 extern struct annotated_data_type unknown_type;
@@ -49,6 +76,11 @@ extern struct annotated_data_type unknown_type;
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 					   int reg, int offset);
 
+/* Update type access histogram at the given offset */
+int annotated_data_type__update_samples(struct annotated_data_type *adt,
+					struct evsel *evsel, int offset,
+					int nr_samples, u64 period);
+
 /* Release all data type information in the tree */
 void annotated_data_type__tree_delete(struct rb_root *root);
 
@@ -61,6 +93,16 @@ find_data_type(struct map_symbol *ms __maybe_unused, u64 ip __maybe_unused,
 	return NULL;
 }
 
+static inline int
+annotated_data_type__update_samples(struct annotated_data_type *adt __maybe_unused,
+				    struct evsel *evsel __maybe_unused,
+				    int offset __maybe_unused,
+				    int nr_samples __maybe_unused,
+				    u64 period __maybe_unused)
+{
+	return -1;
+}
+
 static inline void annotated_data_type__tree_delete(struct rb_root *root __maybe_unused)
 {
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 8673eac4b9df..6747779ecef8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3679,6 +3679,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct disasm_line *dl;
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *op_loc;
+	struct annotated_data_type *mem_type;
 	u64 ip = he->ip;
 	int i;
 
@@ -3709,7 +3710,13 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		if (!op_loc->mem_ref)
 			continue;
 
-		return find_data_type(ms, ip, op_loc->reg, op_loc->offset);
+		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
+
+		annotated_data_type__update_samples(mem_type, evsel,
+						    op_loc->offset,
+						    he->stat.nr_events,
+						    he->stat.period);
+		return mem_type;
 	}
 	return NULL;
 }
-- 
2.43.0.472.g3155946c3a-goog

