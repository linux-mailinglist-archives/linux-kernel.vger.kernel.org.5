Return-Path: <linux-kernel+bounces-139715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684758A06C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21039283767
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A6113BC15;
	Thu, 11 Apr 2024 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngVvk5vq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7313BAE5;
	Thu, 11 Apr 2024 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806378; cv=none; b=cTpEoCtCwk43FGuRNT4vYlLWQNYfTKnuvB1aP48EbNXGTRuG78mWUfZWBGEpcFMlCS2gXVIa3gUG5ATzqZuYshkMmfRbH1VOylx0diFHQNejr2FS8ErSgd0b3G+ZoXM2qeuiMs/1nd8lJ11fVpaxJTbQJbcBnoobw3Y/MzwULXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806378; c=relaxed/simple;
	bh=E7MUbHglg5iWys9JXYDObrTkAuoigHes409w9J6EGEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjo0uOOpsakFSVn6nTbzuLX+h1xKQ2bbQ5oC2vN2HJvVNdnMG+ktMJCeaeHozdqGE+HX+it/1f9/cKOPypJneyZtxHsyQ1FSRe9dwPyCIZAs6o1RgIl0NR8T1hZpMaJ6I3AuPM49zM8dobl2Hu8vnhIgvG4CQpunZqbRbGGWjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngVvk5vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F85CC43399;
	Thu, 11 Apr 2024 03:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712806378;
	bh=E7MUbHglg5iWys9JXYDObrTkAuoigHes409w9J6EGEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ngVvk5vq9Y6CbMgZjWWsYxjtjK4/EdUjH75o2kERRsv0x6/5KAAJDjK8ZLxY2z/rW
	 EyvE/G1p9gwBqVTqgGfS6Bq9iRVSlVP0ei6SxFEG85UwgnVGhYB3jOcW+ssj2CNjmQ
	 QiIyTgFB/u0peIdYJXlJO9/gLfLjN3MYlDaEDtiHgVTt6dAWb1sCNszrY+amBYJ7xh
	 98h2w71Y2oB+cW7ZRiZYeHWuhznhi9CT7ACS5/XxOuyb00O+ddpNNln+kocglkpdpY
	 /BvMYFQ5OUelsOV7wZk8YcXZPIx0oDh10viB9okTmGoNqt6z9M10AL44wy3MbENgQU
	 2BppXXCHiILig==
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
Subject: [PATCH 2/7] perf annotate: Show progress of sample processing
Date: Wed, 10 Apr 2024 20:32:51 -0700
Message-ID: <20240411033256.2099646-3-namhyung@kernel.org>
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

Like 'perf report', it can take a while to process samples.

Show a progress window to inform users how that it is not stuck.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 16e1581207c9..332e1ddcacbd 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -37,6 +37,7 @@
 #include "util/map_symbol.h"
 #include "util/branch.h"
 #include "util/util.h"
+#include "ui/progress.h"
 
 #include <dlfcn.h>
 #include <errno.h>
@@ -665,13 +666,23 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	evlist__for_each_entry(session->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 		u32 nr_samples = hists->stats.nr_samples;
+		struct ui_progress prog;
 
 		if (nr_samples > 0) {
 			total_nr_samples += nr_samples;
-			hists__collapse_resort(hists, NULL);
+
+			ui_progress__init(&prog, nr_samples,
+					  "Merging related events...");
+			hists__collapse_resort(hists, &prog);
+			ui_progress__finish();
+
 			/* Don't sort callchain */
 			evsel__reset_sample_bit(pos, CALLCHAIN);
-			evsel__output_resort(pos, NULL);
+
+			ui_progress__init(&prog, nr_samples,
+					  "Sorting events for output...");
+			evsel__output_resort(pos, &prog);
+			ui_progress__finish();
 
 			/*
 			 * An event group needs to display other events too.
-- 
2.44.0.478.gd926399ef9-goog


