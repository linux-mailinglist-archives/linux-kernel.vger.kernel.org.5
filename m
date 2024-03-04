Return-Path: <linux-kernel+bounces-91398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F438710EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057D6288AB7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F137E10D;
	Mon,  4 Mar 2024 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1yckOcp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC47D3F3;
	Mon,  4 Mar 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593698; cv=none; b=utlsfe5SEXaBVO8yXZGtZhrDINWO2SboOS3Z2TzCfR5xyKHZhW3U4oms7NzpH8k9JeF+fsXiO1HROdpObT0KL3753Z3OD5hL7+B9hz90sRIScpMZcr9Zo2gU9F2O5g0KdZemolx/8in/v8RRRNWBYJE6L3qYlyddklgdZ2dZydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593698; c=relaxed/simple;
	bh=nI/RKtUavLJDBHPe+FswyQfp864clxp3xe66Az3ofZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHY9M0QBd2PJ1y4mgpS4Qdwhyl6p5lB/CJlVrXTpE4mhPpR/1DmFlY/e0YF0Mwu4LsN8JQ8RvsdUegjvPwMihCzl1ICVtNKKCvpXcCz2GiC2vjYos0gmC5yBDlAIi/hTUupR9HE7GOy21ja/X21cGh9HkSc0V+wSxL9/BvPAgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1yckOcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32824C433A6;
	Mon,  4 Mar 2024 23:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709593698;
	bh=nI/RKtUavLJDBHPe+FswyQfp864clxp3xe66Az3ofZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1yckOcpDOfq2sN2uxM/sQgtjyTYxMI2l97eLjXP68rPbETQaezXSIj6xb+tXNbmQ
	 G88X1EiHFYH6ukA5FnqEES3jfkVKntLhGgbT33J80P1cTvFasobKjGm3r16vwqOw2R
	 dp233U4DolIbyfwXffVkrQPNS2boeFaxh96qVXmwNwsBymz60/w84RtDLHGOWarAOF
	 R1kS6HS+6gvrE/6zCbtV4/mf9MCHzs7Qz8s/3UCkg4ewLMUWAmTwg4rN+Rfm0YEheg
	 NGdORzwFPPvmt7vDSFSBBv3UEJCmbBr1gMMq+VW/al3F8EU4HNGmw/xsuKtGqrLN2W
	 i/Wo3+prgKRow==
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
Subject: [PATCH v2 3/4] perf annotate: Remove sym_hist.addr[] array
Date: Mon,  4 Mar 2024 15:08:14 -0800
Message-ID: <20240304230815.1440583-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240304230815.1440583-1-namhyung@kernel.org>
References: <20240304230815.1440583-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not used anymore and the code is coverted to use a hash map.  Now
sym_hist has a static size, so no need to have sizeof_sym_hist in the
struct annotated_source.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 36 +++++-------------------------------
 tools/perf/util/annotate.h |  4 +---
 2 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1451699d931d..ac002d907d81 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -896,33 +896,10 @@ static __maybe_unused void annotated_source__delete(struct annotated_source *src
 }
 
 static int annotated_source__alloc_histograms(struct annotated_source *src,
-					      size_t size, int nr_hists)
+					      int nr_hists)
 {
-	size_t sizeof_sym_hist;
-
-	/*
-	 * Add buffer of one element for zero length symbol.
-	 * When sample is taken from first instruction of
-	 * zero length symbol, perf still resolves it and
-	 * shows symbol name in perf report and allows to
-	 * annotate it.
-	 */
-	if (size == 0)
-		size = 1;
-
-	/* Check for overflow when calculating sizeof_sym_hist */
-	if (size > (SIZE_MAX - sizeof(struct sym_hist)) / sizeof(struct sym_hist_entry))
-		return -1;
-
-	sizeof_sym_hist = (sizeof(struct sym_hist) + size * sizeof(struct sym_hist_entry));
-
-	/* Check for overflow in zalloc argument */
-	if (sizeof_sym_hist > SIZE_MAX / nr_hists)
-		return -1;
-
-	src->sizeof_sym_hist = sizeof_sym_hist;
 	src->nr_histograms   = nr_hists;
-	src->histograms	     = calloc(nr_hists, sizeof_sym_hist) ;
+	src->histograms	     = calloc(nr_hists, sizeof(*src->histograms));
 
 	if (src->histograms == NULL)
 		return -1;
@@ -941,7 +918,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 	annotation__lock(notes);
 	if (notes->src != NULL) {
 		memset(notes->src->histograms, 0,
-		       notes->src->nr_histograms * notes->src->sizeof_sym_hist);
+		       notes->src->nr_histograms * sizeof(*notes->src->histograms));
 		hashmap__clear(notes->src->samples);
 	}
 	if (notes->branch && notes->branch->cycles_hist) {
@@ -1039,9 +1016,7 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	}
 
 	h->nr_samples++;
-	h->addr[offset].nr_samples++;
 	h->period += sample->period;
-	h->addr[offset].period += sample->period;
 	entry->nr_samples++;
 	entry->period += sample->period;
 
@@ -1094,8 +1069,7 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 
 	if (notes->src->histograms == NULL) {
 alloc_histograms:
-		annotated_source__alloc_histograms(notes->src, symbol__size(sym),
-						   nr_hists);
+		annotated_source__alloc_histograms(notes->src, nr_hists);
 	}
 
 	return notes->src;
@@ -2854,7 +2828,7 @@ void symbol__annotate_zero_histogram(struct symbol *sym, int evidx)
 	struct annotation *notes = symbol__annotation(sym);
 	struct sym_hist *h = annotation__histogram(notes, evidx);
 
-	memset(h, 0, notes->src->sizeof_sym_hist);
+	memset(h, 0, sizeof(*notes->src->histograms) * notes->src->nr_histograms);
 }
 
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3362980a5d3d..4bdc70a9d376 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -242,7 +242,6 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
 struct sym_hist {
 	u64		      nr_samples;
 	u64		      period;
-	struct sym_hist_entry addr[];
 };
 
 struct cyc_hist {
@@ -278,7 +277,6 @@ struct cyc_hist {
  */
 struct annotated_source {
 	struct list_head	source;
-	size_t			sizeof_sym_hist;
 	struct sym_hist		*histograms;
 	struct annotation_line	**offsets;
 	struct hashmap	   	*samples;
@@ -348,7 +346,7 @@ void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *m
 
 static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src, int idx)
 {
-	return ((void *)src->histograms) + (src->sizeof_sym_hist * idx);
+	return &src->histograms[idx];
 }
 
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
-- 
2.44.0.rc1.240.g4c46232300-goog


