Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0307DFC60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377510AbjKBW1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377501AbjKBW1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:27:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA2191;
        Thu,  2 Nov 2023 15:26:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c34e87b571so473335b3a.3;
        Thu, 02 Nov 2023 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698964018; x=1699568818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhC5Yt36t3sxJcc1M7cNnf45Xz8JZXT4W0GtB3DI7Is=;
        b=mnE0F07FY0Za8yTyGgdOi52OJu1pZxiEPX1zPn533Aa76cKVayaqWD27vMo07zLYp7
         PBRpaS6VWyy/HsBhfc3sKKNoKF1ChNwwsxTBmO0N9YSlD65jiKcBoW3asKT+N1U5OyNQ
         QfrCMPnNWV5x7t9wlsUYfSLsUFaTUksnimhFyoxhADToGOiyD6wvPBnCJGWyLXhgAq7m
         zL++YmAVYWFbZwaRwvnSxiHtqzBztxO4l4qpi/BWEiSGCoVwWzsFzF4C+tk8UuLenSXC
         Q4JFmkO+CwzSDsHHedWfWZU9p61KsmX8qwHPBW/lHBknmbE6jk+TFaeHdYl6JkVju2Ge
         fWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698964018; x=1699568818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HhC5Yt36t3sxJcc1M7cNnf45Xz8JZXT4W0GtB3DI7Is=;
        b=mfk08OINe6Bs6XeYaJuaYO7Hk0ELLoc95Um0XEfGOZ7LRHCZGDTmKoMxaCI4JNjF9s
         S96gxKGMSr3hBRVLAbC9xET/mix6kwReHH4J9C/vR6bdCNWUqG5qVZogkjEwzCouf/AO
         LRL4ny6U01m4d/pTiujK2ywvd/WGF5fA1WY523FWQkQnLAnmaXV0qOopVeLYX2GjRm4H
         k2roTRcr67OSVUm3C1UBCTD653djmaePsqrH5AIKUhXwVwUR/qZDUyElp7mGkCs2q2tP
         weCTRi1EGDgnwWVnJj1wcmNkVROGWDKCS/GNBZ0jeCopWPA7RxLbZkJ8fCXLmTddLbcN
         qbQQ==
X-Gm-Message-State: AOJu0YxroJy54PpJedZ8qsetQidBnkh8UPNmXooaNj7xWAhoQrhtpfnQ
        7zUMwSgdkH3iOJWJ7ytKeQg=
X-Google-Smtp-Source: AGHT+IGT1ags1hfz25BW9jK5Qd9jhX86ThvgjpuDoet3EU+1FneLPQaR2NNnWFOefKGv/YYXfWeR2w==
X-Received: by 2002:a05:6a21:9994:b0:15e:dc75:66a7 with SMTP id ve20-20020a056a21999400b0015edc7566a7mr20765379pzb.24.1698964017700;
        Thu, 02 Nov 2023 15:26:57 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:ea22:bed1:d67b:af04])
        by smtp.gmail.com with ESMTPSA id cn18-20020a17090af09200b0027d015c365csm309894pjb.31.2023.11.02.15.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:26:57 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/5] perf annotate: Split struct annotated_branch
Date:   Thu,  2 Nov 2023 15:26:50 -0700
Message-ID: <20231102222653.4165959-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231102222653.4165959-1-namhyung@kernel.org>
References: <20231102222653.4165959-1-namhyung@kernel.org>
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

The cycles info is only meaninful when sample has branch stacks.  To
save the memory for normal cases, move those fields to annotated_branch
and dynamically allocate it when needed.  Also move cycles_hist from
annotated_source as it's related here.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c   | 97 ++++++++++++++++++++----------------
 tools/perf/util/annotate.h   | 17 ++++---
 tools/perf/util/block-info.c |  4 +-
 tools/perf/util/sort.c       | 14 +++---
 4 files changed, 72 insertions(+), 60 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3e7f75827270..2fa1ce3a0858 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -810,7 +810,6 @@ static __maybe_unused void annotated_source__delete(struct annotated_source *src
 	if (src == NULL)
 		return;
 	zfree(&src->histograms);
-	zfree(&src->cycles_hist);
 	free(src);
 }
 
@@ -845,18 +844,6 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 	return src->histograms ? 0 : -1;
 }
 
-/* The cycles histogram is lazily allocated. */
-static int symbol__alloc_hist_cycles(struct symbol *sym)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	const size_t size = symbol__size(sym);
-
-	notes->src->cycles_hist = calloc(size, sizeof(struct cyc_hist));
-	if (notes->src->cycles_hist == NULL)
-		return -1;
-	return 0;
-}
-
 void symbol__annotate_zero_histograms(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
@@ -865,9 +852,10 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 	if (notes->src != NULL) {
 		memset(notes->src->histograms, 0,
 		       notes->src->nr_histograms * notes->src->sizeof_sym_hist);
-		if (notes->src->cycles_hist)
-			memset(notes->src->cycles_hist, 0,
-				symbol__size(sym) * sizeof(struct cyc_hist));
+	}
+	if (notes->branch && notes->branch->cycles_hist) {
+		memset(notes->branch->cycles_hist, 0,
+		       symbol__size(sym) * sizeof(struct cyc_hist));
 	}
 	annotation__unlock(notes);
 }
@@ -958,23 +946,33 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	return 0;
 }
 
+static struct annotated_branch *annotation__get_branch(struct annotation *notes)
+{
+	if (notes == NULL)
+		return NULL;
+
+	if (notes->branch == NULL)
+		notes->branch = zalloc(sizeof(*notes->branch));
+
+	return notes->branch;
+}
+
 static struct cyc_hist *symbol__cycles_hist(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
+	struct annotated_branch *branch;
 
-	if (notes->src == NULL) {
-		notes->src = annotated_source__new();
-		if (notes->src == NULL)
-			return NULL;
-		goto alloc_cycles_hist;
-	}
+	branch = annotation__get_branch(notes);
+	if (branch == NULL)
+		return NULL;
+
+	if (branch->cycles_hist == NULL) {
+		const size_t size = symbol__size(sym);
 
-	if (!notes->src->cycles_hist) {
-alloc_cycles_hist:
-		symbol__alloc_hist_cycles(sym);
+		branch->cycles_hist = calloc(size, sizeof(struct cyc_hist));
 	}
 
-	return notes->src->cycles_hist;
+	return branch->cycles_hist;
 }
 
 struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
@@ -1083,6 +1081,14 @@ static unsigned annotation__count_insn(struct annotation *notes, u64 start, u64
 	return n_insn;
 }
 
+static void annotated_branch__delete(struct annotated_branch *branch)
+{
+	if (branch) {
+		free(branch->cycles_hist);
+		free(branch);
+	}
+}
+
 static void annotation__count_and_fill(struct annotation *notes, u64 start, u64 end, struct cyc_hist *ch)
 {
 	unsigned n_insn;
@@ -1091,6 +1097,7 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 
 	n_insn = annotation__count_insn(notes, start, end);
 	if (n_insn && ch->num && ch->cycles) {
+		struct annotated_branch *branch;
 		float ipc = n_insn / ((double)ch->cycles / (double)ch->num);
 
 		/* Hide data when there are too many overlaps. */
@@ -1106,10 +1113,11 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 			}
 		}
 
-		if (cover_insn) {
-			notes->hit_cycles += ch->cycles;
-			notes->hit_insn += n_insn * ch->num;
-			notes->cover_insn += cover_insn;
+		branch = annotation__get_branch(notes);
+		if (cover_insn && branch) {
+			branch->hit_cycles += ch->cycles;
+			branch->hit_insn += n_insn * ch->num;
+			branch->cover_insn += cover_insn;
 		}
 	}
 }
@@ -1118,19 +1126,19 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 {
 	s64 offset;
 
-	if (!notes->src || !notes->src->cycles_hist)
+	if (!notes->branch || !notes->branch->cycles_hist)
 		return;
 
-	notes->total_insn = annotation__count_insn(notes, 0, size - 1);
-	notes->hit_cycles = 0;
-	notes->hit_insn = 0;
-	notes->cover_insn = 0;
+	notes->branch->total_insn = annotation__count_insn(notes, 0, size - 1);
+	notes->branch->hit_cycles = 0;
+	notes->branch->hit_insn = 0;
+	notes->branch->cover_insn = 0;
 
 	annotation__lock(notes);
 	for (offset = size - 1; offset >= 0; --offset) {
 		struct cyc_hist *ch;
 
-		ch = &notes->src->cycles_hist[offset];
+		ch = &notes->branch->cycles_hist[offset];
 		if (ch && ch->cycles) {
 			struct annotation_line *al;
 
@@ -1147,7 +1155,6 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 				al->cycles->max = ch->cycles_max;
 				al->cycles->min = ch->cycles_min;
 			}
-			notes->have_cycles = true;
 		}
 	}
 	annotation__unlock(notes);
@@ -1305,6 +1312,7 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
 void annotation__exit(struct annotation *notes)
 {
 	annotated_source__delete(notes->src);
+	annotated_branch__delete(notes->branch);
 }
 
 static struct sharded_mutex *sharded_mutex;
@@ -3058,13 +3066,14 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
 {
 	double ipc = 0.0, coverage = 0.0;
+	struct annotated_branch *branch = annotation__get_branch(notes);
 
-	if (notes->hit_cycles)
-		ipc = notes->hit_insn / ((double)notes->hit_cycles);
+	if (branch && branch->hit_cycles)
+		ipc = branch->hit_insn / ((double)branch->hit_cycles);
 
-	if (notes->total_insn) {
-		coverage = notes->cover_insn * 100.0 /
-			((double)notes->total_insn);
+	if (branch && branch->total_insn) {
+		coverage = branch->cover_insn * 100.0 /
+			((double)branch->total_insn);
 	}
 
 	scnprintf(bf, size, "(Average IPC: %.2f, IPC Coverage: %.1f%%)",
@@ -3089,7 +3098,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 	int printed;
 
 	if (first_line && (al->offset == -1 || percent_max == 0.0)) {
-		if (notes->have_cycles && al->cycles) {
+		if (notes->branch && al->cycles) {
 			if (al->cycles->ipc == 0.0 && al->cycles->avg == 0)
 				show_title = true;
 		} else
@@ -3126,7 +3135,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		}
 	}
 
-	if (notes->have_cycles) {
+	if (notes->branch) {
 		if (al->cycles && al->cycles->ipc)
 			obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->cycles->ipc);
 		else if (!show_title)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 16d27952fd5c..9c199629305d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -271,17 +271,20 @@ struct annotated_source {
 	struct list_head   source;
 	int    		   nr_histograms;
 	size_t		   sizeof_sym_hist;
-	struct cyc_hist	   *cycles_hist;
 	struct sym_hist	   *histograms;
 };
 
-struct LOCKABLE annotation {
-	u64			max_coverage;
-	u64			start;
+struct annotated_branch {
 	u64			hit_cycles;
 	u64			hit_insn;
 	unsigned int		total_insn;
 	unsigned int		cover_insn;
+	struct cyc_hist		*cycles_hist;
+};
+
+struct LOCKABLE annotation {
+	u64			max_coverage;
+	u64			start;
 	struct annotation_options *options;
 	struct annotation_line	**offsets;
 	int			nr_events;
@@ -297,8 +300,8 @@ struct LOCKABLE annotation {
 		u8		max_addr;
 		u8		max_ins_name;
 	} widths;
-	bool			have_cycles;
 	struct annotated_source *src;
+	struct annotated_branch *branch;
 };
 
 static inline void annotation__init(struct annotation *notes __maybe_unused)
@@ -312,10 +315,10 @@ bool annotation__trylock(struct annotation *notes) EXCLUSIVE_TRYLOCK_FUNCTION(tr
 
 static inline int annotation__cycles_width(struct annotation *notes)
 {
-	if (notes->have_cycles && notes->options->show_minmax_cycle)
+	if (notes->branch && notes->options->show_minmax_cycle)
 		return ANNOTATION__IPC_WIDTH + ANNOTATION__MINMAX_CYCLES_WIDTH;
 
-	return notes->have_cycles ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
+	return notes->branch ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
 }
 
 static inline int annotation__pcnt_width(struct annotation *notes)
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 591fc1edd385..08f82c1f166c 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -129,9 +129,9 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 	al.sym = he->ms.sym;
 
 	notes = symbol__annotation(he->ms.sym);
-	if (!notes || !notes->src || !notes->src->cycles_hist)
+	if (!notes || !notes->branch || !notes->branch->cycles_hist)
 		return 0;
-	ch = notes->src->cycles_hist;
+	ch = notes->branch->cycles_hist;
 	for (unsigned int i = 0; i < symbol__size(he->ms.sym); i++) {
 		if (ch[i].num_aggr) {
 			struct block_info *bi;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 80e4f6132740..27b123ccd2d1 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -583,21 +583,21 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 {
 
 	struct symbol *sym = he->ms.sym;
-	struct annotation *notes;
+	struct annotated_branch *branch;
 	double ipc = 0.0, coverage = 0.0;
 	char tmp[64];
 
 	if (!sym)
 		return repsep_snprintf(bf, size, "%-*s", width, "-");
 
-	notes = symbol__annotation(sym);
+	branch = symbol__annotation(sym)->branch;
 
-	if (notes->hit_cycles)
-		ipc = notes->hit_insn / ((double)notes->hit_cycles);
+	if (branch && branch->hit_cycles)
+		ipc = branch->hit_insn / ((double)branch->hit_cycles);
 
-	if (notes->total_insn) {
-		coverage = notes->cover_insn * 100.0 /
-			((double)notes->total_insn);
+	if (branch && branch->total_insn) {
+		coverage = branch->cover_insn * 100.0 /
+			((double)branch->total_insn);
 	}
 
 	snprintf(tmp, sizeof(tmp), "%-5.2f [%5.1f%%]", ipc, coverage);
-- 
2.42.0.869.gea05f2083d-goog

