Return-Path: <linux-kernel+bounces-139718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7018A06C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17A51C21EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C310213C8E1;
	Thu, 11 Apr 2024 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGNWH53l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9613C68C;
	Thu, 11 Apr 2024 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806380; cv=none; b=TvxG1ouqzYFrIpoTSEkyjIxj8IjsuuNoOOu5+n+gwi40cLmCQ8JAsIqdiLj6bulO+BXgHdZ4pxpp7TsyRHs8An9alU41CAsDaVTbr0fbP2sPV3Kd66NPPmmxikUaENEkjIm/pbSyrf4Y/8faMAvXVHtKA+/gUzKafgfYTkuCYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806380; c=relaxed/simple;
	bh=RsRsNfw4aoHVLYuPLAJZgwVsTZcCjELiYSQfWvHMjgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m717kWvR665zHIfGxxZNYAqTGA1TGa99K/aO9nB6wzqJSwAohdVaW5PMhTXsxrhHn+jf2kgMHWhG2vZGT2R/smMK3hvYZ174byRVBzfIySfUjjTOLOzn4E9TiG7zVmdmbLtPXcLhlb3cbDTiXculkFx07Ld5tiYtHngu1I2gaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGNWH53l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB749C43390;
	Thu, 11 Apr 2024 03:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712806380;
	bh=RsRsNfw4aoHVLYuPLAJZgwVsTZcCjELiYSQfWvHMjgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGNWH53lCJcrYRMGy/j84N9YR9qiiEWWQkGqxLhUDuTk8EEao/rYf7kfaPR+F+jX1
	 Ood/sSk/GJNLXqJWV+A3LyG7ivJT3scOLkQ6kCanjJ+WR/Qqoy4XuLAt1s1aYrzMqU
	 7fRyTh7hV43hQJ+hADlC2Tkbl/PkCbBcyyb8QRzkIipXrx5BAKFbJ/5pEFYKb6VhQY
	 C8jq8PQ9MTI42mB3jnaUbYxy+Fy8TF88oEPwKUhDOqs4EcvLo3gQ4lXiig695wnWZk
	 OQvHabroe/G2Mg3hIobcabeA7w1ydBXbwrSxyhiQwYAqSt249KIei3Vpzp5vWST2zL
	 uLDTFd6Mw7Rdg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/7] perf annotate-data: Support event group display in TUI
Date: Wed, 10 Apr 2024 20:32:54 -0700
Message-ID: <20240411033256.2099646-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240411033256.2099646-1-namhyung@kernel.org>
References: <20240411033256.2099646-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like in stdio, it should print all events in a group together.

Committer notes:

Collect it:

  root@number:~# perf record -a -e '{cpu_core/mem-loads,ldlat=30/P,cpu_core/mem-stores/P}'
  ^C[ perf record: Woken up 8 times to write data ]
  [ perf record: Captured and wrote 4.980 MB perf.data (55825 samples) ]
  root@number:~#

Then do it in stdio:

  root@number:~# perf annotate --stdio --data-type

  Annotate type: 'union ' in /usr/lib64/libc.so.6 (1131 samples):
   event[0] = cpu_core/mem-loads,ldlat=30/P
   event[1] = cpu_core/mem-stores/P
  ============================================================================
           Percent     offset       size  field
    100.00  100.00          0         40  union    {
    100.00  100.00          0         40      struct __pthread_mutex_s    __data {
     48.61   23.46          0          4          int     __lock;
      0.00    0.48          4          4          unsigned int    __count;
      6.38   41.32          8          4          int     __owner;
      8.74   34.02         12          4          unsigned int    __nusers;
     35.66    0.26         16          4          int     __kind;
      0.61    0.45         20          2          short int       __spins;
      0.00    0.00         22          2          short int       __elision;
      0.00    0.00         24         16          __pthread_list_t        __list {
      0.00    0.00         24          8              struct __pthread_internal_list*     __prev;
      0.00    0.00         32          8              struct __pthread_internal_list*     __next;
                                                  };
                                              };
      0.00    0.00          0          0      char*       __size;
     48.61   23.94          0          8      long int    __align;
                                          };

Now with TUI before this patch:

  root@number:~# perf annotate --tui --data-type
  Annotate type: 'union ' (790 samples)
      Percent     Offset       Size  Field
       100.00          0         40  union  {
       100.00          0         40      struct __pthread_mutex_s __data {
        48.61          0          4          int  __lock;
         0.00          4          4          unsigned int __count;
         6.38          8          4          int  __owner;
         8.74         12          4          unsigned int __nusers;
        35.66         16          4          int  __kind;
         0.61         20          2          short int    __spins;
         0.00         22          2          short int    __elision;
         0.00         24         16          __pthread_list_t     __list {
         0.00         24          8              struct __pthread_internal_list*  __prev;
         0.00         32          8              struct __pthread_internal_list*  __next;

         0.00          0          0      char*    __size;
        48.61          0          8      long int __align;
                                     };

And now after this patch:

Annotate type: 'union ' (790 samples)
               Percent     Offset       Size  Field
     100.00     100.00          0         40  union  {
     100.00     100.00          0         40      struct __pthread_mutex_s      __data {
      48.61      23.46          0          4          int       __lock;
       0.00       0.48          4          4          unsigned int      __count;
       6.38      41.32          8          4          int       __owner;
       8.74      34.02         12          4          unsigned int      __nusers;
      35.66       0.26         16          4          int       __kind;
       0.61       0.45         20          2          short int __spins;
       0.00       0.00         22          2          short int __elision;
       0.00       0.00         24         16          __pthread_list_t  __list {
       0.00       0.00         24          8              struct __pthread_internal_list*       __prev;
       0.00       0.00         32          8              struct __pthread_internal_list*       __next;
                                                      };
                                                  };
       0.00       0.00          0          0      char* __size;
      48.61      23.94          0          8      long int      __align;
                                              };

On a followup patch the --tui output should have this that is present in
--stdio:

  And the --stdio has all the missing info in TUI:

    Annotate type: 'union ' in /usr/lib64/libc.so.6 (1131 samples):
     event[0] = cpu_core/mem-loads,ldlat=30/P
     event[1] = cpu_core/mem-stores/P

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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


