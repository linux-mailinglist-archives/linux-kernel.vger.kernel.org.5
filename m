Return-Path: <linux-kernel+bounces-137728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8189E669
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08261F22443
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DD515956A;
	Tue,  9 Apr 2024 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjEEVxw9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193811591F9;
	Tue,  9 Apr 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706603; cv=none; b=IoBrWo64V4bUoa2Mtn3XFMZYFXTkey7UtJ89BbU44931JxY+KoBBd9pYQYXvJFrRgPAlTHTiI0I3zfUB9YiXv/mjy2U8YERa+GYYiuHMGb2ZvAff8/dijd68EZ8fVN35pW9y33PFSh0VqWDn8xCuy906q/9m6VSVErXDhJHKZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706603; c=relaxed/simple;
	bh=3TpVmLFJVURZBCiS1i9FyAIxWtUR0uuUCXuJi1xdk/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2/+770mTHwCgoGf72ZkaPOkHKPN6DaSOCA9stAV5W548RxN+TGLrGI9kVrxWjMUA1/hfH47pGavdtAt9391+uUfK2WKJL9dYOAIFCM9YKi5T8bbj1+G0YlMyT7Tu+7O6rXkaVTxlSx/Ey627545KFX/qiwqludujQE3mlBCJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjEEVxw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95683C43601;
	Tue,  9 Apr 2024 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706603;
	bh=3TpVmLFJVURZBCiS1i9FyAIxWtUR0uuUCXuJi1xdk/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjEEVxw9MSsvDY/GE9cQsovBRKGFFAe6aYh6/pon3DWpdqf4QOY8ph5sWbp/gKFUc
	 l+JKzhVNgPJtuOa+6keaeQ4OHuY4DvqDLN0bQ9v10K3+Kii/q9KMtgv5BwdlT1TRhf
	 vEFL0ZahYesv2CDOXpP6GOSjYEDe15SeZbNFEtxL6zs/yD/inVl9hlIgn2SwJbR/fj
	 eUgzhcDUhBwUbS4YdsOrRkaTyCuvu+zDhANdaIkCbhek3YlI+gUBA2bpjnuzeLQUHm
	 jljH3TQcdf27/dpmxUMVjEue5qNmsZwE3tjwrXOGXYcryL6TuAjjF/pEaXCQxG4sHw
	 JpBA7SbPW4yYw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/6] perf annotate-data: Add hist_entry__annotate_data_tui()
Date: Tue,  9 Apr 2024 16:49:57 -0700
Message-ID: <20240409235000.1893969-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240409235000.1893969-1-namhyung@kernel.org>
References: <20240409235000.1893969-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support data type profiling output on TUI.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c          |  30 ++-
 tools/perf/ui/browsers/Build           |   1 +
 tools/perf/ui/browsers/annotate-data.c | 282 +++++++++++++++++++++++++
 tools/perf/util/annotate-data.c        |   5 +-
 tools/perf/util/annotate-data.h        |   5 +-
 5 files changed, 317 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/ui/browsers/annotate-data.c

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 0812664faa54..6f7104f06c42 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -469,8 +469,32 @@ static void hists__find_annotations(struct hists *hists,
 					goto find_next;
 			}
 
-			hist_entry__annotate_data_tty(he, evsel);
-			goto find_next;
+			if (use_browser == 1)
+				key = hist_entry__annotate_data_tui(he, evsel, NULL);
+			else
+				key = hist_entry__annotate_data_tty(he, evsel);
+
+			switch (key) {
+			case -1:
+				if (!ann->skip_missing)
+					return;
+				/* fall through */
+			case K_RIGHT:
+			case '>':
+				next = rb_next(nd);
+				break;
+			case K_LEFT:
+			case '<':
+				next = rb_prev(nd);
+				break;
+			default:
+				return;
+			}
+
+			if (next != NULL)
+				nd = next;
+
+			continue;
 		}
 
 		if (use_browser == 2) {
@@ -873,9 +897,7 @@ int cmd_annotate(int argc, const char **argv)
 		use_browser = 2;
 #endif
 
-	/* FIXME: only support stdio for now */
 	if (annotate.data_type) {
-		use_browser = 0;
 		annotate_opts.annotate_src = false;
 		symbol_conf.annotate_data_member = true;
 		symbol_conf.annotate_data_sample = true;
diff --git a/tools/perf/ui/browsers/Build b/tools/perf/ui/browsers/Build
index 7a1d5ddaf688..2608b5da3167 100644
--- a/tools/perf/ui/browsers/Build
+++ b/tools/perf/ui/browsers/Build
@@ -1,4 +1,5 @@
 perf-y += annotate.o
+perf-y += annotate-data.o
 perf-y += hists.o
 perf-y += map.o
 perf-y += scripts.o
diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
new file mode 100644
index 000000000000..fefacaaf16db
--- /dev/null
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
+#include <string.h>
+#include <sys/ttydefaults.h>
+
+#include "ui/browser.h"
+#include "ui/helpline.h"
+#include "ui/keysyms.h"
+#include "ui/ui.h"
+#include "util/annotate.h"
+#include "util/annotate-data.h"
+#include "util/evsel.h"
+#include "util/sort.h"
+
+struct annotated_data_browser {
+	struct ui_browser b;
+	struct list_head entries;
+};
+
+struct browser_entry {
+	struct list_head node;
+	struct annotated_member *data;
+	struct type_hist_entry hists;
+	int indent;
+};
+
+static void update_hist_entry(struct type_hist_entry *dst,
+			      struct type_hist_entry *src)
+{
+	dst->nr_samples += src->nr_samples;
+	dst->period += src->period;
+}
+
+static int get_member_overhead(struct annotated_data_type *adt,
+			       struct browser_entry *entry,
+			       struct evsel *evsel)
+{
+	struct annotated_member *member = entry->data;
+	int i;
+
+	for (i = 0; i < member->size; i++) {
+		struct type_hist *h;
+		int offset = member->offset + i;
+
+		h = adt->histograms[evsel->core.idx];
+		update_hist_entry(&entry->hists, &h->addr[offset]);
+	}
+	return 0;
+}
+
+static int add_child_entries(struct annotated_data_browser *browser,
+			     struct annotated_data_type *adt,
+			     struct annotated_member *member,
+			     struct evsel *evsel, int indent)
+{
+	struct annotated_member *pos;
+	struct browser_entry *entry;
+	int nr_entries = 0;
+
+	entry = zalloc(sizeof(*entry));
+	if (entry == NULL)
+		return -1;
+
+	entry->data = member;
+	entry->indent = indent;
+	if (get_member_overhead(adt, entry, evsel) < 0) {
+		free(entry);
+		return -1;
+	}
+
+	list_add_tail(&entry->node, &browser->entries);
+	nr_entries++;
+
+	list_for_each_entry(pos, &member->children, node) {
+		int nr = add_child_entries(browser, adt, pos, evsel, indent + 1);
+
+		if (nr < 0)
+			return nr;
+
+		nr_entries += nr;
+	}
+
+	/* add an entry for the closing bracket ("}") */
+	if (!list_empty(&member->children)) {
+		entry = zalloc(sizeof(*entry));
+		if (entry == NULL)
+			return -1;
+
+		entry->indent = indent;
+		list_add_tail(&entry->node, &browser->entries);
+		nr_entries++;
+	}
+
+	return nr_entries;
+}
+
+static int annotated_data_browser__collect_entries(struct annotated_data_browser *browser)
+{
+	struct hist_entry *he = browser->b.priv;
+	struct annotated_data_type *adt = he->mem_type;
+	struct evsel *evsel = hists_to_evsel(he->hists);
+
+	INIT_LIST_HEAD(&browser->entries);
+	browser->b.entries = &browser->entries;
+	browser->b.nr_entries = add_child_entries(browser, adt, &adt->self,
+						  evsel, /*indent=*/0);
+	return 0;
+}
+
+static void annotated_data_browser__delete_entries(struct annotated_data_browser *browser)
+{
+	struct browser_entry *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &browser->entries, node) {
+		list_del_init(&pos->node);
+		free(pos);
+	}
+}
+
+static unsigned int browser__refresh(struct ui_browser *uib)
+{
+	return ui_browser__list_head_refresh(uib);
+}
+
+static int browser__show(struct ui_browser *uib)
+{
+	struct hist_entry *he = uib->priv;
+	struct annotated_data_type *adt = he->mem_type;
+	const char *help = "Press 'h' for help on key bindings";
+	char title[256];
+
+	snprintf(title, sizeof(title), "Annotate type: '%s' (%d samples)",
+		 adt->self.type_name, he->stat.nr_events);
+
+	if (ui_browser__show(uib, title, help) < 0)
+		return -1;
+
+	/* second line header */
+	ui_browser__gotorc_title(uib, 0, 0);
+	ui_browser__set_color(uib, HE_COLORSET_ROOT);
+
+	if (symbol_conf.show_total_period)
+		strcpy(title, "Period");
+	else if (symbol_conf.show_nr_samples)
+		strcpy(title, "Samples");
+	else
+		strcpy(title, "Percent");
+
+	ui_browser__printf(uib, " %10s %10s %10s  %s",
+			   title, "Offset", "Size", "Field");
+	ui_browser__write_nstring(uib, "", uib->width);
+	return 0;
+}
+
+static void browser__write_overhead(struct ui_browser *uib,
+				    struct type_hist *total,
+				    struct type_hist_entry *hist, int row)
+{
+	u64 period = hist->period;
+	double percent = total->period ? (100.0 * period / total->period) : 0;
+	bool current = ui_browser__is_current_entry(uib, row);
+	int nr_samples = 0;
+
+	ui_browser__set_percent_color(uib, percent, current);
+
+	if (symbol_conf.show_total_period)
+		ui_browser__printf(uib, " %10" PRIu64, period);
+	else if (symbol_conf.show_nr_samples)
+		ui_browser__printf(uib, " %10d", nr_samples);
+	else
+		ui_browser__printf(uib, " %10.2f", percent);
+
+	ui_browser__set_percent_color(uib, 0, current);
+}
+
+static void browser__write(struct ui_browser *uib, void *entry, int row)
+{
+	struct browser_entry *be = entry;
+	struct annotated_member *member = be->data;
+	struct hist_entry *he = uib->priv;
+	struct annotated_data_type *adt = he->mem_type;
+	struct evsel *evsel = hists_to_evsel(he->hists);
+
+	if (member == NULL) {
+		bool current = ui_browser__is_current_entry(uib, row);
+
+		/* print the closing bracket */
+		ui_browser__set_percent_color(uib, 0, current);
+		ui_browser__write_nstring(uib, "", 11);
+		ui_browser__printf(uib, " %10s %10s  %*s};",
+				   "", "", be->indent * 4, "");
+		ui_browser__write_nstring(uib, "", uib->width);
+		return;
+	}
+
+	/* print the number */
+	browser__write_overhead(uib, adt->histograms[evsel->core.idx],
+				&be->hists, row);
+
+	/* print type info */
+	if (be->indent == 0 && !member->var_name) {
+		ui_browser__printf(uib, " %10d %10d  %s%s",
+				   member->offset, member->size,
+				   member->type_name,
+				   list_empty(&member->children) ? ";" : " {");
+	} else {
+		ui_browser__printf(uib, " %10d %10d  %*s%s\t%s%s",
+				   member->offset, member->size,
+				   be->indent * 4, "", member->type_name,
+				   member->var_name ?: "",
+				   list_empty(&member->children) ? ";" : " {");
+	}
+	/* fill the rest */
+	ui_browser__write_nstring(uib, "", uib->width);
+}
+
+static int annotated_data_browser__run(struct annotated_data_browser *browser,
+				       struct evsel *evsel __maybe_unused,
+				       struct hist_browser_timer *hbt)
+{
+	int delay_secs = hbt ? hbt->refresh : 0;
+	int key;
+
+	if (browser__show(&browser->b) < 0)
+		return -1;
+
+	while (1) {
+		key = ui_browser__run(&browser->b, delay_secs);
+
+		switch (key) {
+		case K_TIMER:
+			if (hbt)
+				hbt->timer(hbt->arg);
+			continue;
+		case K_F1:
+		case 'h':
+			ui_browser__help_window(&browser->b,
+		"UP/DOWN/PGUP\n"
+		"PGDN/SPACE    Navigate\n"
+		"</>           Move to prev/next symbol\n"
+		"q/ESC/CTRL+C  Exit\n\n");
+			continue;
+		case K_LEFT:
+		case '<':
+		case '>':
+		case K_ESC:
+		case 'q':
+		case CTRL('c'):
+			goto out;
+		default:
+			continue;
+		}
+	}
+out:
+	ui_browser__hide(&browser->b);
+	return key;
+}
+
+int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
+				  struct hist_browser_timer *hbt)
+{
+	struct annotated_data_browser browser = {
+		.b = {
+			.refresh = browser__refresh,
+			.seek	 = ui_browser__list_head_seek,
+			.write	 = browser__write,
+			.priv	 = he,
+			.extra_title_lines = 1,
+		},
+	};
+	int ret;
+
+	ui_helpline__push("Press ESC to exit");
+
+	ret = annotated_data_browser__collect_entries(&browser);
+	if (ret == 0)
+		ret = annotated_data_browser__run(&browser, evsel, hbt);
+
+	annotated_data_browser__delete_entries(&browser);
+
+	return ret;
+}
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 99c5dcdfc9df..1cd857400038 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1814,9 +1814,12 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 	printf(";\n");
 }
 
-void hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel)
+int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel)
 {
 	print_annotated_data_header(he, evsel);
 	print_annotated_data_type(he->mem_type, &he->mem_type->self, evsel, 0);
 	printf("\n");
+
+	/* move to the next entry */
+	return '>';
 }
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 037e2622b7a3..9a6d9b519724 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -11,6 +11,7 @@ struct annotated_op_loc;
 struct debuginfo;
 struct evsel;
 struct hist_entry;
+struct hist_browser_timer;
 struct map_symbol;
 struct thread;
 
@@ -141,7 +142,9 @@ struct annotated_data_stat {
 };
 extern struct annotated_data_stat ann_data_stat;
 
-void hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
+int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
+int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
+				  struct hist_browser_timer *hbt);
 
 #ifdef HAVE_DWARF_SUPPORT
 
-- 
2.44.0.478.gd926399ef9-goog


