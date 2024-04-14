Return-Path: <linux-kernel+bounces-136032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24F89CF2E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDED1F23432
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F7D10E3;
	Tue,  9 Apr 2024 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz+HFaI1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589DC181;
	Tue,  9 Apr 2024 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621221; cv=none; b=syia55RwYGB7o9GFupU+vN7uGhqTSs2NA/VCsPUaTGpq46NdBZYuAkxDBgnjz6DHFj2mvB1fstqPiFAMPiWOdsA6s0XeCrrLPtHroHUVllsLSusmhqRBqDNHPOyrHxrz1N8o7gU3YVAcvjjo8mgWjT+KvABH4B61KEKJyogwqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621221; c=relaxed/simple;
	bh=hnbsX2qpaf7teU63lYgBX1t6T5W3Z3IYurbU6/sqTF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVmfsbmBrcYMJzZMuFcke8BKhVCeWtr4fZqnCQV2XAVyeTShLVL8N1/5Y4O2vfG88T363NiuIl6CHQ/qP01ypbOMrjM9tRlxhVm5DmJvA3XpkzpA6jeVbA8P8dfG90/bvlZDPLSC01+32sToUKQhEMFIuXt/lCmNhF+oof+K6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz+HFaI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFD6C433C7;
	Tue,  9 Apr 2024 00:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712621220;
	bh=hnbsX2qpaf7teU63lYgBX1t6T5W3Z3IYurbU6/sqTF8=;
	h=From:To:Cc:Subject:Date:From;
	b=Pz+HFaI15WuJTl0skg1ObQ6TWfPdoLV1fppH5DuDIwF4bdRrpPOd648w1rXxv+k5f
	 tqGkPa6tyYXum+jX1/r7KeS2guVEqlXx7+ma6h9XGUJ7UvUunTKUI/u2shDKQpGbhW
	 uQXU+JeFfZrU8n+SHsHXLs0FwHJVvfZb8lJRwD8iJao2T8FB8w/vFBT6SvAN94doLI
	 wrkv72fJv2EGu7xoHc0lhvoQAIGM4K4QN7HIP2aHKvwFNGZarzNxDdqpMF2stWhoW4
	 kRw9NxeB1Io71Td9m+GQCcULooOQ0YpP6ncgzOohh44mfg8DVVlyykN4C7wtMEBhEU
	 CUYbLTyaLZCXw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 1/3] perf hist: Move histogram related code to hist.h
Date: Mon,  8 Apr 2024 17:06:57 -0700
Message-ID: <20240409000659.1727785-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's strange that sort.h has the definition of struct hist_entry.  As
sort.h already includes hist.h, let's move the data structure to hist.h.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.h   | 191 +++++++++++++++++++++++++++++++++++++--
 tools/perf/util/sort.h   | 188 --------------------------------------
 tools/perf/util/values.h |   1 +
 3 files changed, 184 insertions(+), 196 deletions(-)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 4a0aea0c9e00..8f072f3749eb 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -4,21 +4,22 @@
 
 #include <linux/rbtree.h>
 #include <linux/types.h>
-#include "evsel.h"
+#include "callchain.h"
 #include "color.h"
 #include "events_stats.h"
+#include "evsel.h"
+#include "map_symbol.h"
 #include "mutex.h"
+#include "sample.h"
+#include "spark.h"
+#include "stat.h"
 
-struct hist_entry;
-struct hist_entry_ops;
 struct addr_location;
-struct map_symbol;
 struct mem_info;
 struct kvm_info;
 struct branch_info;
 struct branch_stack;
 struct block_info;
-struct symbol;
 struct ui_progress;
 
 enum hist_filter {
@@ -150,6 +151,159 @@ extern const struct hist_iter_ops hist_iter_branch;
 extern const struct hist_iter_ops hist_iter_mem;
 extern const struct hist_iter_ops hist_iter_cumulative;
 
+struct res_sample {
+	u64 time;
+	int cpu;
+	int tid;
+};
+
+struct he_stat {
+	u64			period;
+	u64			period_sys;
+	u64			period_us;
+	u64			period_guest_sys;
+	u64			period_guest_us;
+	u32			nr_events;
+};
+
+struct namespace_id {
+	u64			dev;
+	u64			ino;
+};
+
+struct hist_entry_diff {
+	bool	computed;
+	union {
+		/* PERF_HPP__DELTA */
+		double	period_ratio_delta;
+
+		/* PERF_HPP__RATIO */
+		double	period_ratio;
+
+		/* HISTC_WEIGHTED_DIFF */
+		s64	wdiff;
+
+		/* PERF_HPP_DIFF__CYCLES */
+		s64	cycles;
+	};
+	struct stats	stats;
+	unsigned long	svals[NUM_SPARKS];
+};
+
+struct hist_entry_ops {
+	void	*(*new)(size_t size);
+	void	(*free)(void *ptr);
+};
+
+/**
+ * struct hist_entry - histogram entry
+ *
+ * @row_offset - offset from the first callchain expanded to appear on screen
+ * @nr_rows - rows expanded in callchain, recalculated on folding/unfolding
+ */
+struct hist_entry {
+	struct rb_node		rb_node_in;
+	struct rb_node		rb_node;
+	union {
+		struct list_head node;
+		struct list_head head;
+	} pairs;
+	struct he_stat		stat;
+	struct he_stat		*stat_acc;
+	struct map_symbol	ms;
+	struct thread		*thread;
+	struct comm		*comm;
+	struct namespace_id	cgroup_id;
+	u64			cgroup;
+	u64			ip;
+	u64			transaction;
+	s32			socket;
+	s32			cpu;
+	u64			code_page_size;
+	u64			weight;
+	u64			ins_lat;
+	u64			p_stage_cyc;
+	u8			cpumode;
+	u8			depth;
+	int			mem_type_off;
+	struct simd_flags	simd_flags;
+
+	/* We are added by hists__add_dummy_entry. */
+	bool			dummy;
+	bool			leaf;
+
+	char			level;
+	u8			filtered;
+
+	u16			callchain_size;
+	union {
+		/*
+		 * Since perf diff only supports the stdio output, TUI
+		 * fields are only accessed from perf report (or perf
+		 * top).  So make it a union to reduce memory usage.
+		 */
+		struct hist_entry_diff	diff;
+		struct /* for TUI */ {
+			u16	row_offset;
+			u16	nr_rows;
+			bool	init_have_children;
+			bool	unfolded;
+			bool	has_children;
+			bool	has_no_entry;
+		};
+	};
+	char			*srcline;
+	char			*srcfile;
+	struct symbol		*parent;
+	struct branch_info	*branch_info;
+	long			time;
+	struct hists		*hists;
+	struct mem_info		*mem_info;
+	struct block_info	*block_info;
+	struct kvm_info		*kvm_info;
+	void			*raw_data;
+	u32			raw_size;
+	int			num_res;
+	struct res_sample	*res_samples;
+	void			*trace_output;
+	struct perf_hpp_list	*hpp_list;
+	struct hist_entry	*parent_he;
+	struct hist_entry_ops	*ops;
+	struct annotated_data_type *mem_type;
+	union {
+		/* this is for hierarchical entry structure */
+		struct {
+			struct rb_root_cached	hroot_in;
+			struct rb_root_cached   hroot_out;
+		};				/* non-leaf entries */
+		struct rb_root	sorted_chain;	/* leaf entry has callchains */
+	};
+	struct callchain_root	callchain[0]; /* must be last member */
+};
+
+static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
+{
+	return he->callchain_size != 0;
+}
+
+static inline bool hist_entry__has_pairs(struct hist_entry *he)
+{
+	return !list_empty(&he->pairs.node);
+}
+
+static inline struct hist_entry *hist_entry__next_pair(struct hist_entry *he)
+{
+	if (hist_entry__has_pairs(he))
+		return list_entry(he->pairs.node.next, struct hist_entry, pairs.node);
+	return NULL;
+}
+
+static inline void hist_entry__add_pair(struct hist_entry *pair,
+					struct hist_entry *he)
+{
+	list_add_tail(&pair->pairs.node, &he->pairs.head);
+}
+
 struct hist_entry *hists__add_entry(struct hists *hists,
 				    struct addr_location *al,
 				    struct symbol *parent,
@@ -186,6 +340,8 @@ int hist_entry__sort_snprintf(struct hist_entry *he, char *bf, size_t size,
 			      struct hists *hists);
 int hist_entry__snprintf_alignment(struct hist_entry *he, struct perf_hpp *hpp,
 				   struct perf_hpp_fmt *fmt, int printed);
+int hist_entry__sym_snprintf(struct hist_entry *he, char *bf, size_t size,
+			     unsigned int width);
 void hist_entry__delete(struct hist_entry *he);
 
 typedef int (*hists__resort_cb_t)(struct hist_entry *he, void *arg);
@@ -238,6 +394,20 @@ void hists__match(struct hists *leader, struct hists *other);
 int hists__link(struct hists *leader, struct hists *other);
 int hists__unlink(struct hists *hists);
 
+static inline float hist_entry__get_percent_limit(struct hist_entry *he)
+{
+	u64 period = he->stat.period;
+	u64 total_period = hists__total_period(he->hists);
+
+	if (unlikely(total_period == 0))
+		return 0;
+
+	if (symbol_conf.cumulate_callchain)
+		period = he->stat_acc->period;
+
+	return period * 100.0 / total_period;
+}
+
 struct hists_evsel {
 	struct evsel evsel;
 	struct hists	  hists;
@@ -460,15 +630,20 @@ struct hist_browser_timer {
 	int refresh;
 };
 
-struct res_sample;
-
 enum rstype {
 	A_NORMAL,
 	A_ASM,
 	A_SOURCE
 };
 
-struct block_hist;
+struct block_hist {
+	struct hists		block_hists;
+	struct perf_hpp_list	block_list;
+	struct perf_hpp_fmt	block_fmt;
+	int			block_idx;
+	bool			valid;
+	struct hist_entry	he;
+};
 
 #ifdef HAVE_SLANG_SUPPORT
 #include "../ui/keysyms.h"
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 6f6b4189a389..690892a92cf3 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -3,19 +3,9 @@
 #define __PERF_SORT_H
 #include <regex.h>
 #include <stdbool.h>
-#include <linux/list.h>
-#include <linux/rbtree.h>
-#include "map_symbol.h"
-#include "symbol_conf.h"
-#include "callchain.h"
-#include "values.h"
 #include "hist.h"
-#include "stat.h"
-#include "spark.h"
 
 struct option;
-struct thread;
-struct annotated_data_type;
 
 extern regex_t parent_regex;
 extern const char *sort_order;
@@ -39,175 +29,6 @@ extern struct sort_entry sort_type;
 extern const char default_mem_sort_order[];
 extern bool chk_double_cl;
 
-struct res_sample {
-	u64 time;
-	int cpu;
-	int tid;
-};
-
-struct he_stat {
-	u64			period;
-	u64			period_sys;
-	u64			period_us;
-	u64			period_guest_sys;
-	u64			period_guest_us;
-	u32			nr_events;
-};
-
-struct namespace_id {
-	u64			dev;
-	u64			ino;
-};
-
-struct hist_entry_diff {
-	bool	computed;
-	union {
-		/* PERF_HPP__DELTA */
-		double	period_ratio_delta;
-
-		/* PERF_HPP__RATIO */
-		double	period_ratio;
-
-		/* HISTC_WEIGHTED_DIFF */
-		s64	wdiff;
-
-		/* PERF_HPP_DIFF__CYCLES */
-		s64	cycles;
-	};
-	struct stats	stats;
-	unsigned long	svals[NUM_SPARKS];
-};
-
-struct hist_entry_ops {
-	void	*(*new)(size_t size);
-	void	(*free)(void *ptr);
-};
-
-/**
- * struct hist_entry - histogram entry
- *
- * @row_offset - offset from the first callchain expanded to appear on screen
- * @nr_rows - rows expanded in callchain, recalculated on folding/unfolding
- */
-struct hist_entry {
-	struct rb_node		rb_node_in;
-	struct rb_node		rb_node;
-	union {
-		struct list_head node;
-		struct list_head head;
-	} pairs;
-	struct he_stat		stat;
-	struct he_stat		*stat_acc;
-	struct map_symbol	ms;
-	struct thread		*thread;
-	struct comm		*comm;
-	struct namespace_id	cgroup_id;
-	u64			cgroup;
-	u64			ip;
-	u64			transaction;
-	s32			socket;
-	s32			cpu;
-	u64			code_page_size;
-	u64			weight;
-	u64			ins_lat;
-	u64			p_stage_cyc;
-	u8			cpumode;
-	u8			depth;
-	int			mem_type_off;
-	struct simd_flags	simd_flags;
-
-	/* We are added by hists__add_dummy_entry. */
-	bool			dummy;
-	bool			leaf;
-
-	char			level;
-	u8			filtered;
-
-	u16			callchain_size;
-	union {
-		/*
-		 * Since perf diff only supports the stdio output, TUI
-		 * fields are only accessed from perf report (or perf
-		 * top).  So make it a union to reduce memory usage.
-		 */
-		struct hist_entry_diff	diff;
-		struct /* for TUI */ {
-			u16	row_offset;
-			u16	nr_rows;
-			bool	init_have_children;
-			bool	unfolded;
-			bool	has_children;
-			bool	has_no_entry;
-		};
-	};
-	char			*srcline;
-	char			*srcfile;
-	struct symbol		*parent;
-	struct branch_info	*branch_info;
-	long			time;
-	struct hists		*hists;
-	struct mem_info		*mem_info;
-	struct block_info	*block_info;
-	struct kvm_info		*kvm_info;
-	void			*raw_data;
-	u32			raw_size;
-	int			num_res;
-	struct res_sample	*res_samples;
-	void			*trace_output;
-	struct perf_hpp_list	*hpp_list;
-	struct hist_entry	*parent_he;
-	struct hist_entry_ops	*ops;
-	struct annotated_data_type *mem_type;
-	union {
-		/* this is for hierarchical entry structure */
-		struct {
-			struct rb_root_cached	hroot_in;
-			struct rb_root_cached   hroot_out;
-		};				/* non-leaf entries */
-		struct rb_root	sorted_chain;	/* leaf entry has callchains */
-	};
-	struct callchain_root	callchain[0]; /* must be last member */
-};
-
-static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
-{
-	return he->callchain_size != 0;
-}
-
-int hist_entry__sym_snprintf(struct hist_entry *he, char *bf, size_t size, unsigned int width);
-
-static inline bool hist_entry__has_pairs(struct hist_entry *he)
-{
-	return !list_empty(&he->pairs.node);
-}
-
-static inline struct hist_entry *hist_entry__next_pair(struct hist_entry *he)
-{
-	if (hist_entry__has_pairs(he))
-		return list_entry(he->pairs.node.next, struct hist_entry, pairs.node);
-	return NULL;
-}
-
-static inline void hist_entry__add_pair(struct hist_entry *pair,
-					struct hist_entry *he)
-{
-	list_add_tail(&pair->pairs.node, &he->pairs.head);
-}
-
-static inline float hist_entry__get_percent_limit(struct hist_entry *he)
-{
-	u64 period = he->stat.period;
-	u64 total_period = hists__total_period(he->hists);
-
-	if (unlikely(total_period == 0))
-		return 0;
-
-	if (symbol_conf.cumulate_callchain)
-		period = he->stat_acc->period;
-
-	return period * 100.0 / total_period;
-}
-
 enum sort_mode {
 	SORT_MODE__NORMAL,
 	SORT_MODE__BRANCH,
@@ -299,15 +120,6 @@ struct sort_entry {
 	u8	se_width_idx;
 };
 
-struct block_hist {
-	struct hists		block_hists;
-	struct perf_hpp_list	block_list;
-	struct perf_hpp_fmt	block_fmt;
-	int			block_idx;
-	bool			valid;
-	struct hist_entry	he;
-};
-
 extern struct sort_entry sort_thread;
 
 struct evlist;
diff --git a/tools/perf/util/values.h b/tools/perf/util/values.h
index 8c41f22f42cf..791c1ad606c2 100644
--- a/tools/perf/util/values.h
+++ b/tools/perf/util/values.h
@@ -2,6 +2,7 @@
 #ifndef __PERF_VALUES_H
 #define __PERF_VALUES_H
 
+#include <stdio.h>
 #include <linux/types.h>
 
 struct perf_read_values {
-- 
2.44.0.478.gd926399ef9-goog


