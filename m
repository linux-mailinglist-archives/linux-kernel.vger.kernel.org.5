Return-Path: <linux-kernel+bounces-63065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB0852A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E1F1F22855
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3D1B7FE;
	Tue, 13 Feb 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaBzEzXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6518E37;
	Tue, 13 Feb 2024 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810779; cv=none; b=I2S4KfD89XVSxFw+fRhb1Pdvk7j77qNDQW93hnBqmgOAU7Vb1kYIuXMX/33RK2A1RRf1Rq3LagodtddqO+VJP1UW0xXRMb8qP7vntf5YI3vORJyzcmwWq1PkZBaNf7Wh9u17+bNyh1prrMana1Gsxv/72WYJhCKMf+pVCVev06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810779; c=relaxed/simple;
	bh=iBUiWDW8Ai4qSjFVJLHHIZ87HU0SArsopllQZXXyTrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIGdF0XCjwCMLbNdm648pA7qfvCohzEyD1IjeUfexrZcwBeoHaUx9/DDRbrOekXFmk3B3SdPGhhBaQ8+owpERmQegmYCca1amtXHmkq8lAaPN8GKIxedOu87vsT8uwsbxy/V2xDHbx7NI2dRqRFzuOy+XqHI3ci/V+uPA/A0PfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaBzEzXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD86C43330;
	Tue, 13 Feb 2024 07:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707810779;
	bh=iBUiWDW8Ai4qSjFVJLHHIZ87HU0SArsopllQZXXyTrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaBzEzXXW7jZhGtjT0gxCZeIIIhE6Lwb6H4dPRwJ6q1eZjb9RexYg508HRr2GfPDq
	 KvulJxx3AsqX6RyjTuELeZtDIGeO0MK2DGQ9pmgPMMu7shYprG6px+fV9Hnhw6JY3c
	 FDBuLrkBNjvZVXNU7FMgOUVp/TLq9H3GU1mwbhNREJIioP+cdWDGmkHbfctd7vF1J/
	 aLVp3mLYszLHvdmvQipSnmDNzsLy+EFAfayIYeLnKZhNchsVJ06EjPjoycPU4ICmEi
	 Us9s4LccIjtvHGzehkoBi+gApsL1Vj8BV+9z0kP3TaDpUoFfESwrpBwv417w7kjbgJ
	 L3zlI4I7AVDlw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] perf report: Do not show dummy events with --skip-empty
Date: Mon, 12 Feb 2024 23:52:56 -0800
Message-ID: <20240213075256.1983638-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240213075256.1983638-1-namhyung@kernel.org>
References: <20240213075256.1983638-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In system-wide mode, a dummy event was added during the perf record to
save various side-band events like FORK, MMAP and so on.  But this dummy
event doesn't have samples for itself so it just wastes the output with
all zero values.

When --skip-empty option is on (by default), it can skip those (dummy)
events without any samples by removing them from the evlist.  Users can
disable it using --no-skip-empty command line option or setting the
report.skip-empty config option to false.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  3 ++-
 tools/perf/builtin-report.c              | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index d8b863e01fe0..546af27d209c 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -609,7 +609,8 @@ include::itrace.txt[]
 	'Avg Cycles'      - block average sampled cycles
 
 --skip-empty::
-	Do not print 0 results in the --stat output.
+	Do not print 0 results in the output.  This means skipping dummy events
+	in the event list and the --stat output.
 
 include::callchain-overhead-calculation.txt[]
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 8e16fa261e6f..60e30f13c8f8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -752,10 +752,22 @@ static int hists__resort_cb(struct hist_entry *he, void *arg)
 static void report__output_resort(struct report *rep)
 {
 	struct ui_progress prog;
-	struct evsel *pos;
+	struct evsel *pos, *tmp;
 
 	ui_progress__init(&prog, rep->nr_entries, "Sorting events for output...");
 
+	if (rep->skip_empty) {
+		evlist__for_each_entry_safe(rep->session->evlist, tmp, pos) {
+			struct hists *hists = evsel__hists(pos);
+
+			if (hists->nr_entries != 0)
+				continue;
+
+			evlist__remove(rep->session->evlist, pos);
+			evsel__delete(pos);
+		}
+	}
+
 	evlist__for_each_entry(rep->session->evlist, pos) {
 		evsel__output_resort_cb(pos, &prog, hists__resort_cb, rep);
 	}
-- 
2.43.0.687.g38aa6559b0-goog


