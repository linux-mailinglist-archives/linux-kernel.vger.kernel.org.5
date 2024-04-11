Return-Path: <linux-kernel+bounces-139719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B68A06CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D8E283767
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4113C8EE;
	Thu, 11 Apr 2024 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glgSGqwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB813C692;
	Thu, 11 Apr 2024 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806381; cv=none; b=MuGM7JcnV0qBXg+y/Dq2OO2TIVxbCz8bju7op4Cgkx+/V18wsz8xfe+l+QAYuBtXpb/2Hf2NWFNo+20wG5RE7fBOJ6n59F9quh2B3z/TD5fybu9yZ/YW9PvHSknJ6VltTs+XtexjjpbnE/WtlZUk8bqo0MYC0CLdpkgJbnlkdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806381; c=relaxed/simple;
	bh=X8Vye17HjHIRPgRNBcNLpbPpftNemU1wC0X5p4n1gMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAjT6h/E5VoeSCklOk5CRgThMLR7rWpM1zcYuSL/pFfr04nFpOkMOGSaZkdl/M7cRpC2P5NuA6kKkYlGXrgNEUEwuk2YI/TWjy7MEZsqKb3kGtYh4Ej4KCuVoTakK/tUHX0VvJLAZg7WSLf1wD36QZMI7kOFGVdUXfx8knciN+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glgSGqwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1D0C43142;
	Thu, 11 Apr 2024 03:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712806380;
	bh=X8Vye17HjHIRPgRNBcNLpbPpftNemU1wC0X5p4n1gMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glgSGqwOM+PaCygU3nDa340Py0E8vFzoYST8n1zGW8cvyNeMJ9ZwWW5xuQSR0Ranl
	 Y5exrZITgC4800TosD/jMTMK2QqqDlpmG6zveIdVTdVpeJKT26BsPHaDDYxXQIulKY
	 19AKjW2htg2lnpasuUHq/3RQ58bQj4vZFmxBHlwWpZSPICifKau4Ts2Lo02esJfFDy
	 epyqjWOpPK+PeoBqDi0i7diWDURFbs7wtcR6kVbnCxYQhkpxfL8ccRGn3X6Iij5AJK
	 bFWVNMwO4N0OH6S8RwfmYBiHeMIU6pL+GIG0xmfvlvZLb2MhRDkuDs554Ans3DUHcf
	 y9AGNV/EHtTPg==
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
Subject: [PATCH 6/7] perf report: Add a menu item to annotate data type in TUI
Date: Wed, 10 Apr 2024 20:32:55 -0700
Message-ID: <20240411033256.2099646-7-namhyung@kernel.org>
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

When the hist entry has the type info, it should be able to display the
annotation browser for the type like in `perf annotate --data-type`.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c    |  5 +++++
 tools/perf/ui/browsers/hists.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dcd93ee5fc24..aaa6427a1224 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1694,6 +1694,11 @@ int cmd_report(int argc, const char **argv)
 	else
 		use_browser = 0;
 
+	if (report.data_type && use_browser == 1) {
+		symbol_conf.annotate_data_member = true;
+		symbol_conf.annotate_data_sample = true;
+	}
+
 	if (sort_order && strstr(sort_order, "ipc")) {
 		parse_options_usage(report_usage, options, "s", 1);
 		goto error;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 0c02b3a8e121..71b32591d61a 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -38,6 +38,7 @@
 #include "../ui.h"
 #include "map.h"
 #include "annotate.h"
+#include "annotate-data.h"
 #include "srcline.h"
 #include "string2.h"
 #include "units.h"
@@ -2505,6 +2506,32 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
 	return 1;
 }
 
+static int
+do_annotate_type(struct hist_browser *browser, struct popup_action *act)
+{
+	struct hist_entry *he = browser->he_selection;
+
+	hist_entry__annotate_data_tui(he, act->evsel, browser->hbt);
+	ui_browser__handle_resize(&browser->b);
+	return 0;
+}
+
+static int
+add_annotate_type_opt(struct hist_browser *browser,
+		      struct popup_action *act, char **optstr,
+		      struct hist_entry *he)
+{
+	if (he == NULL || he->mem_type == NULL || he->mem_type->histograms == NULL)
+		return 0;
+
+	if (asprintf(optstr, "Annotate type %s", he->mem_type->self.type_name) < 0)
+		return 0;
+
+	act->evsel = hists_to_evsel(browser->hists);
+	act->fn = do_annotate_type;
+	return 1;
+}
+
 static int
 do_zoom_thread(struct hist_browser *browser, struct popup_action *act)
 {
@@ -3307,6 +3334,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 						       browser->he_selection->ip);
 		}
 skip_annotation:
+		nr_options += add_annotate_type_opt(browser,
+						    &actions[nr_options],
+						    &options[nr_options],
+						    browser->he_selection);
 		nr_options += add_thread_opt(browser, &actions[nr_options],
 					     &options[nr_options], thread);
 		nr_options += add_dso_opt(browser, &actions[nr_options],
-- 
2.44.0.478.gd926399ef9-goog


