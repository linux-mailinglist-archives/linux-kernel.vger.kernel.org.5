Return-Path: <linux-kernel+bounces-84287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC4486A493
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20484B273B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685A120F1;
	Wed, 28 Feb 2024 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayNfeHRt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A5EA4;
	Wed, 28 Feb 2024 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081552; cv=none; b=NEjvJRTZvPkBnzLqJIcqfzLidn/kHK6ecM06F5d54OdBFdGpeYFkEO2rXHBjyYNf3sr02YKcJrl1M6ESA//47QhC+B+2Z2vSmt/t1XHcAoiCqcPG7ykDgtXpSs1C4fTK0Y9e96Boa/xdpSLZ7zWNsiUuesyOfuv2Q301RoisqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081552; c=relaxed/simple;
	bh=+m3kd5Z7Kmf1Mj9lEd0zN/MsAmvTX0/FfPUZA4vXFoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR6r1wvy2dZlAlH1+xOklZWRG8hBSOQNonbZazqYJLKovMQJrCUVcJyUIpO8qQyu6BBWixl1nSejqfqB+uJ+kafZ+VIZsP5hmtshZuFYvpaoi05frQPPmO9ueLpY50MixeNJMd9ixb3SbZkfGkjtfuhN7GIUdArbF+gIMJtJmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayNfeHRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157A0C43390;
	Wed, 28 Feb 2024 00:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709081552;
	bh=+m3kd5Z7Kmf1Mj9lEd0zN/MsAmvTX0/FfPUZA4vXFoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ayNfeHRtAIhY6qlGvEeVBw/GKfAvT7jyq9OGoGPBWklJZYQ4F9rKawa+uOAjSEj7I
	 n2Uo5Y0BSZQwM3r+mr9tMYWAHK9Cv7Z0RHK11N63x07yYZCzTYRmi5HSpK4nQeDikE
	 kgap5QyS+4MI0Q5hnRwdPrfNjn5xWGc4Z+/Wz1oDE1NVfG6k2me5tQzJXr02BAhSpF
	 yCDCfu1VE4cMl3K5utdoDyoHz4/ACWuBRJDIGGooOfs+ZGh8smLF4OtkLqQM7zrrx5
	 O3HOAJb21/PO3odzZxkw1wtGEXwigOnllFeQGKRPnU6SvAw3huDiQjHdWEGYakFsT7
	 sPY0nrRyDqmsw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/4] perf annotate: Add a hashmap for symbol histogram
Date: Tue, 27 Feb 2024 16:52:27 -0800
Message-ID: <20240228005230.287113-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240228005230.287113-1-namhyung@kernel.org>
References: <20240228005230.287113-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now symbol histogram uses an array to save per-offset sample counts.
But it wastes a lot of memory if the symbol has a few samples only.
Add a hashmap to save values only for actual samples.

For now, it has duplicate histogram (one in the existing array and
another in the new hash map).  Once it can convert to use the hash
in all places, we can get rid of the array later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 40 +++++++++++++++++++++++++++++++++++++-
 tools/perf/util/annotate.h |  2 ++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 107b264fa41e..7a70e4d35c9b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -38,6 +38,7 @@
 #include "arch/common.h"
 #include "namespaces.h"
 #include "thread.h"
+#include "hashmap.h"
 #include <regex.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
@@ -863,6 +864,17 @@ bool arch__is(struct arch *arch, const char *name)
 	return !strcmp(arch->name, name);
 }
 
+/* symbol histogram: key = offset << 16 | evsel->core.idx */
+static size_t sym_hist_hash(long key, void *ctx __maybe_unused)
+{
+	return (key >> 16) + (key & 0xffff);
+}
+
+static bool sym_hist_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
 static struct annotated_source *annotated_source__new(void)
 {
 	struct annotated_source *src = zalloc(sizeof(*src));
@@ -877,6 +889,8 @@ static __maybe_unused void annotated_source__delete(struct annotated_source *src
 {
 	if (src == NULL)
 		return;
+
+	hashmap__free(src->samples);
 	zfree(&src->histograms);
 	free(src);
 }
@@ -909,6 +923,14 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 	src->sizeof_sym_hist = sizeof_sym_hist;
 	src->nr_histograms   = nr_hists;
 	src->histograms	     = calloc(nr_hists, sizeof_sym_hist) ;
+
+	if (src->histograms == NULL)
+		return -1;
+
+	src->samples = hashmap__new(sym_hist_hash, sym_hist_equal, NULL);
+	if (src->samples == NULL)
+		zfree(&src->histograms);
+
 	return src->histograms ? 0 : -1;
 }
 
@@ -920,6 +942,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 	if (notes->src != NULL) {
 		memset(notes->src->histograms, 0,
 		       notes->src->nr_histograms * notes->src->sizeof_sym_hist);
+		hashmap__clear(notes->src->samples);
 	}
 	if (notes->branch && notes->branch->cycles_hist) {
 		memset(notes->branch->cycles_hist, 0,
@@ -983,8 +1006,10 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 				      struct perf_sample *sample)
 {
 	struct symbol *sym = ms->sym;
+	long hash_key;
 	unsigned offset;
 	struct sym_hist *h;
+	struct sym_hist_entry *entry;
 
 	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, map__unmap_ip(ms->map, addr));
 
@@ -1002,15 +1027,28 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 			 __func__, __LINE__, sym->name, sym->start, addr, sym->end, sym->type == STT_FUNC);
 		return -ENOMEM;
 	}
+
+	hash_key = offset << 16 | evidx;
+	if (!hashmap__find(src->samples, hash_key, &entry)) {
+		entry = zalloc(sizeof(*entry));
+		if (entry == NULL)
+			return -ENOMEM;
+
+		if (hashmap__add(src->samples, hash_key, entry) < 0)
+			return -ENOMEM;
+	}
+
 	h->nr_samples++;
 	h->addr[offset].nr_samples++;
 	h->period += sample->period;
 	h->addr[offset].period += sample->period;
+	entry->nr_samples++;
+	entry->period += sample->period;
 
 	pr_debug3("%#" PRIx64 " %s: period++ [addr: %#" PRIx64 ", %#" PRIx64
 		  ", evidx=%d] => nr_samples: %" PRIu64 ", period: %" PRIu64 "\n",
 		  sym->start, sym->name, addr, addr - sym->start, evidx,
-		  h->addr[offset].nr_samples, h->addr[offset].period);
+		  entry->nr_samples, entry->period);
 	return 0;
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 94435607c958..a2b0c8210740 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -12,6 +12,7 @@
 #include "symbol_conf.h"
 #include "mutex.h"
 #include "spark.h"
+#include "hashmap.h"
 
 struct hist_browser_timer;
 struct hist_entry;
@@ -280,6 +281,7 @@ struct annotated_source {
 	size_t			sizeof_sym_hist;
 	struct sym_hist		*histograms;
 	struct annotation_line	**offsets;
+	struct hashmap	   	*samples;
 	int    			nr_histograms;
 	int			nr_entries;
 	int			nr_asm_entries;
-- 
2.44.0.rc1.240.g4c46232300-goog


