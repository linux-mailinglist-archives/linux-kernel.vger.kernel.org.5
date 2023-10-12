Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D467C637A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377141AbjJLDxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377242AbjJLDw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD9C18E;
        Wed, 11 Oct 2023 20:51:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9de3f66e5so3202605ad.3;
        Wed, 11 Oct 2023 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082698; x=1697687498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbDdqJ+JUJe9Qdp9iUp/VIlsxYDDvTeRSoEAhVAMMI4=;
        b=X/S3vEoIukE4rmSJkWbpPUv4LSUwRtBcUyAnRifc9iUppowhDzVwyzef7BsZ8WiNYP
         NB9Un1UEoC5xFPOxHp8p1EQ9gZxjbhbFdl5Ix2Ll/emaD8SDsLROPO/iPJJZ2soGA9km
         u4BGTWzM3m7eBh9dLSXvoR7cEI6SBSR3Grg7xGr3bSKRmfnHcj2wNh1MgEICBEx3TIPx
         DwxBunCiHS1+9RMyntyGRpSI4vrRew6YGVwzwiSOcRdlhGLqZHbvEOljnygIXvyC6mEo
         xWR/bqzWQuKRfuX5GCfIm2R8LTFhaIxkWn43qz3N3f1iC06j5RQM+O1izA15NhKT0bAo
         Y6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082698; x=1697687498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DbDdqJ+JUJe9Qdp9iUp/VIlsxYDDvTeRSoEAhVAMMI4=;
        b=maiw+rJKlwu9YeHXXaBI8eVBF6jK6dE0vagXfHMyuiJQJgfdb6kKqnP8I9EN8toL6z
         4Pn5TdzCXNBMxq7bEH2yiyeUn3Qwb0HOtB+I+xPduUwSIM2E9fSSfpNQjsN9gsPJh0Sq
         GlFlmdvb/ISUSqepDFw2VDvDBI9z/Uwi4wMuEDFrOEgiOTLIVw+TwhYdiR9gVCjxJED7
         ngiY7QAcNmHKYYn91XxxbRTHx8Wp1lJEV+iXSLeOgD7LJVxDg3oBXp4JBqJA8Rx1Tbko
         iYvSjBXuAlOm9Sv2NeHA7VIxa1LrALJ3rDrbw7Y4qmTkYibrAQS/X/h8VxANWPbOW/yI
         o8wg==
X-Gm-Message-State: AOJu0YwSbTWg64x+qHPQJwyDd44/MZ6mgGOLfPoPQqr9HS3HUtQKe5jY
        mlxqxibCBK5h21vwPD3Zm+E=
X-Google-Smtp-Source: AGHT+IGpi+TcAYZLFeKw3EN4+89W1pNtJto3tPl+MOGpTadU047nEO63AjGeDzUfKNzYYI3mbIYE6g==
X-Received: by 2002:a17:902:e809:b0:1c0:6e92:8cc5 with SMTP id u9-20020a170902e80900b001c06e928cc5mr21221783plg.17.1697082698543;
        Wed, 11 Oct 2023 20:51:38 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:38 -0700 (PDT)
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
Subject: [PATCH 18/48] perf annotate-data: Update sample histogram for type
Date:   Wed, 11 Oct 2023 20:50:41 -0700
Message-ID: <20231012035111.676789-19-namhyung@kernel.org>
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
index 63205506b9fe..adeab45a3c63 100644
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
@@ -309,6 +311,44 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
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
@@ -319,7 +359,48 @@ void annotated_data_type__tree_delete(struct rb_root *root)
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
index e5dc3d6fc6d0..ab942331720d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3645,6 +3645,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct disasm_line *dl;
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *op_loc;
+	struct annotated_data_type *mem_type;
 	u64 ip = he->ip;
 	int i;
 
@@ -3672,7 +3673,13 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
2.42.0.655.g421f12c284-goog

