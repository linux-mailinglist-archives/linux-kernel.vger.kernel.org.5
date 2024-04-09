Return-Path: <linux-kernel+bounces-137727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B84689E668
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D39B1C20FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA05615921B;
	Tue,  9 Apr 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naEbYt79"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521C1591F8;
	Tue,  9 Apr 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706603; cv=none; b=B9RoCtpW79tplCJXtV1YKOjNpIziaPcvAgDCpFdUsWfPISSC4KzYzAL6SX3mnDSoUMtfAFsdXuHZk2U70PJPlZiGq0NSuH+7iuZ36M9IxzIEe8peeHkaaTDOsSPlAfO3yXTOohtdRxouhVjzMqpbDwqIIfjjDpM3lmtBwLTslP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706603; c=relaxed/simple;
	bh=JniUIOtymtPSjR4nX8r1BDesYexwAvEo2n0TNtIdZes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYgND4sLw2RKbPuuEdNP2dik0UrCez+kkeURDJLlohcFO3K5hBHB+a1tZj9BcPPsxRiAbtICu2B1CWxlSOZu78ASBlV6PDr6J4Fa7Iv4N+vG9PR4eV790KOKp2xoggK58ZQeLV6fG8Ve1Rsu1TJEewV7wqk74Bf8yx/SeEUhwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naEbYt79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98072C433A6;
	Tue,  9 Apr 2024 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706602;
	bh=JniUIOtymtPSjR4nX8r1BDesYexwAvEo2n0TNtIdZes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naEbYt79Rt3g+TLI52IaGdEmcyGYXtoC3tux39xgok/DKT0JRk9AsU/EJiSfgsf8f
	 dLDPzD3kT4Zu9NdsSl7sYptIJqE4qk6nXoSNgbG66fDxk89d6FOqJKdQ2lrQSvuHr2
	 bkRsB0Apd7JM56BwCcN6dy0cGQcecWRx03iKx3AfBEDMmGW5xriF+170uyIwqVpHQJ
	 tZmxGsvToTbmNEg5QpLrWU1vJUEZuGyWNNL5xKT8pr2dgWNvoN56lnSQo5D5eTArGn
	 +XaMwlnm9L805riHlSjQKwns5fg5WVzLxQOh478yW/FbeuFs0VWX/DORDaV0/juA8b
	 edRe0U70D/BPw==
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
Subject: [PATCH 1/6] perf annotate: Show progress of sample processing
Date: Tue,  9 Apr 2024 16:49:55 -0700
Message-ID: <20240409235000.1893969-2-namhyung@kernel.org>
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

Like perf report, it can take a while to process samples.  Show the
progress window to inform users how long it'll take.

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


