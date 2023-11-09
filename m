Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56F7E757B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345524AbjKJACA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345582AbjKJAB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:26 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C084C25;
        Thu,  9 Nov 2023 16:00:47 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b44befac59so2029360b3a.0;
        Thu, 09 Nov 2023 16:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574447; x=1700179247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTfqQAAd/5CGutPceOaWOmUfDAEvCDKelyByybftScQ=;
        b=WnyNYorj7WJz73tPkjAjyVYjXziAiGpTJKDzZPiZaKtGC9Tbv6KOc0sOz8sgRq8q6F
         cEdEvPfCWKy6jQ5AFxU3hoj6ZMN1riDbvXGyTNwJlRviUxvJlnwxgLA19KwVLuA+1q2M
         3IwmQRjwFQ9N360uZrcqBUmsJ5AJq7knWONQdFpy+ApBzE0HBwoGt+aQWIel22zmjlTQ
         6afjgIRt3ZlGPn9vetoVwY3aR5lv4G4zJjQkjRk9CJdj7+iMqwc9VyFp0WfGMcLFqx9U
         TecK04pU+SdExhxeFVsZpXH2OiEzfzfCycsmztdYYw31pEXnjdasfIGe/DEBQQMymqhN
         r3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574447; x=1700179247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WTfqQAAd/5CGutPceOaWOmUfDAEvCDKelyByybftScQ=;
        b=RoyY4vwwdqH9LbKAspJtV52FvEAYjYRH0Wkoiu4E0fbHoL8cxtCazvSDdc3HnL6xWQ
         0fathkQeH47qm+Krm6wLihQgIT+8e+l40R6rSnMCPNZqtUqsjo2vW9e5HjKY46KiOnj2
         hdY8oO28OOrUwYa0C0pmzXyS8llMSGplscL7X6eZiGUQonfXp0fJuFk1uQD82mTEvQIs
         x8eJecq2a0TJ+fONVH5C82OTo1MseeBv3pBvlyiTlJk+isKZ7McK6/haixA5o9ADGwwy
         klhWRTc8AUkG4YeuXMpHhCaygCpVymggzz6NvahGzcmw2QRwUSDjmEr/5KEXRYVd7d2B
         cb0Q==
X-Gm-Message-State: AOJu0YzPgymmxz4HUJ1CUYh49Vp6u3nB0slXkpROtQexsF/U+QActAnk
        IN6/rAByJo23R4C+Enz9sJI=
X-Google-Smtp-Source: AGHT+IFDtVzKmhOafEaeGQXeKZ1pEB4GVk6NvLzvWbA7yxBkF0CE2fw7vmUNngao1c/RW1Qccn3CUA==
X-Received: by 2002:a17:90a:b803:b0:280:37a0:69d4 with SMTP id n3-20020a17090ab80300b0028037a069d4mr1181822pjr.19.1699574446942;
        Thu, 09 Nov 2023 16:00:46 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:46 -0800 (PST)
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
Subject: [PATCH 21/52] perf annotate-data: Update sample histogram for type
Date:   Thu,  9 Nov 2023 15:59:40 -0800
Message-ID: <20231110000012.3538610-22-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 107e3248a541..3c452d037948 100644
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
index c08686b91861..049d6ba394bd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3683,6 +3683,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct disasm_line *dl;
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *op_loc;
+	struct annotated_data_type *mem_type;
 	u64 ip = he->ip;
 	int i;
 
@@ -3710,7 +3711,13 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
2.42.0.869.gea05f2083d-goog

