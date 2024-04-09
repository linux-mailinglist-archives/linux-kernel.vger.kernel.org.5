Return-Path: <linux-kernel+bounces-137729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AF089E66A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB9D1C203D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14215958D;
	Tue,  9 Apr 2024 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo8+tsXU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AD159560;
	Tue,  9 Apr 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706604; cv=none; b=WEfbK2gqtVhDpSw9mJoJBLI2Z51hv8UHpAojFsaOUZB1rNjVMB0idSqSvwifKApFOXCH3QH3uodwmvBQ2bDqHBq6wd2oYAI1Wnsxl6Exx3sabUs9DaaYYKwqlx1RqAEwus1QFhNlwKC8ZcLrdJNxleMQCtV4xNLVyql3ONS5ZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706604; c=relaxed/simple;
	bh=AddK5ii9O630G6QxgsZ1OcL/iUmRt+ii1QXcHGqscqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhBlm3PSP4pic5e4tcPLDgloHF+WCsCtyFgagSCiYlDcWqVUqfwv2sA+6c1Yb75NkkeHNMh3EThtVEmVtNYPKjRvj0uBH/xFlFdigzDVotemkZf5Z44v/JnJkD7++13tZYF1UixZvmQbXlbE46XiTpe+fY2zQwQEWaKL8EQoAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo8+tsXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1E3C43330;
	Tue,  9 Apr 2024 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706603;
	bh=AddK5ii9O630G6QxgsZ1OcL/iUmRt+ii1QXcHGqscqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bo8+tsXU+e8TkJzx+YtKY8oFMS1I4U8lv7O6v83cfA52nC1GJrQVjSaW/TAL/Qp/K
	 R8MX2t8UR7+HNu8gk9ef8rVigArEYorQh9fBIfGVIxbrGUode+zW2dLk/Z3p2wKcCZ
	 9tHMaNmkR6kdsY904QEuHXm4TKa/aRWzqZ76t3tuVLAJKdgH/fHa11BU2Kras2mNkJ
	 oXguCgFx/UXDoVpdoFsVchnxglShkBcCWuM4HxKhUMwziSEHMs3bYR7LzwCNjxP0IP
	 Z6bMEQ+yXnaEpIgiiTpP+6v/oV8uQyPvi+58WksCf4EhOZ7coKM87eH+uRAMg9TfdN
	 0gXPwxgpUzbPg==
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
Subject: [PATCH 4/6] perf annotate-data: Support event group display in TUI
Date: Tue,  9 Apr 2024 16:49:58 -0700
Message-ID: <20240409235000.1893969-5-namhyung@kernel.org>
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

Like in stdio, it should print all events in a group together.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate-data.c | 50 ++++++++++++++++++++------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index fefacaaf16db..a4a0f042f201 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -10,20 +10,27 @@
 #include "util/annotate.h"
 #include "util/annotate-data.h"
 #include "util/evsel.h"
+#include "util/evlist.h"
 #include "util/sort.h"
 
 struct annotated_data_browser {
 	struct ui_browser b;
 	struct list_head entries;
+	int nr_events;
 };
 
 struct browser_entry {
 	struct list_head node;
 	struct annotated_member *data;
-	struct type_hist_entry hists;
+	struct type_hist_entry *hists;
 	int indent;
 };
 
+static struct annotated_data_browser *get_browser(struct ui_browser *uib)
+{
+	return container_of(uib, struct annotated_data_browser, b);
+}
+
 static void update_hist_entry(struct type_hist_entry *dst,
 			      struct type_hist_entry *src)
 {
@@ -33,17 +40,21 @@ static void update_hist_entry(struct type_hist_entry *dst,
 
 static int get_member_overhead(struct annotated_data_type *adt,
 			       struct browser_entry *entry,
-			       struct evsel *evsel)
+			       struct evsel *leader)
 {
 	struct annotated_member *member = entry->data;
-	int i;
+	int i, k;
 
 	for (i = 0; i < member->size; i++) {
 		struct type_hist *h;
+		struct evsel *evsel;
 		int offset = member->offset + i;
 
-		h = adt->histograms[evsel->core.idx];
-		update_hist_entry(&entry->hists, &h->addr[offset]);
+		for_each_group_evsel(evsel, leader) {
+			h = adt->histograms[evsel->core.idx];
+			k = evsel__group_idx(evsel);
+			update_hist_entry(&entry->hists[k], &h->addr[offset]);
+		}
 	}
 	return 0;
 }
@@ -61,6 +72,12 @@ static int add_child_entries(struct annotated_data_browser *browser,
 	if (entry == NULL)
 		return -1;
 
+	entry->hists = calloc(browser->nr_events, sizeof(*entry->hists));
+	if (entry->hists == NULL) {
+		free(entry);
+		return -1;
+	}
+
 	entry->data = member;
 	entry->indent = indent;
 	if (get_member_overhead(adt, entry, evsel) < 0) {
@@ -113,6 +130,7 @@ static void annotated_data_browser__delete_entries(struct annotated_data_browser
 
 	list_for_each_entry_safe(pos, tmp, &browser->entries, node) {
 		list_del_init(&pos->node);
+		free(pos->hists);
 		free(pos);
 	}
 }
@@ -126,6 +144,7 @@ static int browser__show(struct ui_browser *uib)
 {
 	struct hist_entry *he = uib->priv;
 	struct annotated_data_type *adt = he->mem_type;
+	struct annotated_data_browser *browser = get_browser(uib);
 	const char *help = "Press 'h' for help on key bindings";
 	char title[256];
 
@@ -146,7 +165,8 @@ static int browser__show(struct ui_browser *uib)
 	else
 		strcpy(title, "Percent");
 
-	ui_browser__printf(uib, " %10s %10s %10s  %s",
+	ui_browser__printf(uib, "%*s %10s %10s %10s  %s",
+			   11 * (browser->nr_events - 1), "",
 			   title, "Offset", "Size", "Field");
 	ui_browser__write_nstring(uib, "", uib->width);
 	return 0;
@@ -175,18 +195,20 @@ static void browser__write_overhead(struct ui_browser *uib,
 
 static void browser__write(struct ui_browser *uib, void *entry, int row)
 {
+	struct annotated_data_browser *browser = get_browser(uib);
 	struct browser_entry *be = entry;
 	struct annotated_member *member = be->data;
 	struct hist_entry *he = uib->priv;
 	struct annotated_data_type *adt = he->mem_type;
-	struct evsel *evsel = hists_to_evsel(he->hists);
+	struct evsel *leader = hists_to_evsel(he->hists);
+	struct evsel *evsel;
 
 	if (member == NULL) {
 		bool current = ui_browser__is_current_entry(uib, row);
 
 		/* print the closing bracket */
 		ui_browser__set_percent_color(uib, 0, current);
-		ui_browser__write_nstring(uib, "", 11);
+		ui_browser__write_nstring(uib, "", 11 * browser->nr_events);
 		ui_browser__printf(uib, " %10s %10s  %*s};",
 				   "", "", be->indent * 4, "");
 		ui_browser__write_nstring(uib, "", uib->width);
@@ -194,8 +216,12 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
 	}
 
 	/* print the number */
-	browser__write_overhead(uib, adt->histograms[evsel->core.idx],
-				&be->hists, row);
+	for_each_group_evsel(evsel, leader) {
+		struct type_hist *h = adt->histograms[evsel->core.idx];
+		int idx = evsel__group_idx(evsel);
+
+		browser__write_overhead(uib, h, &be->hists[idx], row);
+	}
 
 	/* print type info */
 	if (be->indent == 0 && !member->var_name) {
@@ -267,11 +293,15 @@ int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
 			.priv	 = he,
 			.extra_title_lines = 1,
 		},
+		.nr_events = 1,
 	};
 	int ret;
 
 	ui_helpline__push("Press ESC to exit");
 
+	if (evsel__is_group_event(evsel))
+		browser.nr_events = evsel->core.nr_members;
+
 	ret = annotated_data_browser__collect_entries(&browser);
 	if (ret == 0)
 		ret = annotated_data_browser__run(&browser, evsel, hbt);
-- 
2.44.0.478.gd926399ef9-goog


