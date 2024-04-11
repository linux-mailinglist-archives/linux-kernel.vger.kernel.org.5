Return-Path: <linux-kernel+bounces-139720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739998A06CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292401F21AED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A76013C900;
	Thu, 11 Apr 2024 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSJ6lXHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E113C3D0;
	Thu, 11 Apr 2024 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806381; cv=none; b=oK6Tg+Mlb+GruNZWGp2mbSrgWeq8MAqyXDSNh2/rRWUUPpXQ8dumSq1foofzlnzMH+VUBdD1YJY4HsNrBcCR5JrVzTsU7TEMufuQB5CqCrtiaVbHsszievb87b+Edvf6s5m0zBxdX1PlgPbTD0cDEbxGuJG4BOZAZ73wvBcpJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806381; c=relaxed/simple;
	bh=oLLdTTKJKvZGCT3VxJu2I0H1lKPF7WqOrG568ajKlas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgc33aAoDt1FaruYugLHwal2OKEtY6LHP1I36x2zsIZFf3BJOULhOS73gJVQLS/wfQ9b+yqk+PBw9XONWi1Uvj+fjJp2RWS9q1d5HfYY8+MlcNA/EMsPVbqGXEKLzEdm1Eyn+8ZBhGYEI/CGcGFrvQr9bEQYz+CZ0DdFCp5WvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSJ6lXHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6F7C433B2;
	Thu, 11 Apr 2024 03:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712806381;
	bh=oLLdTTKJKvZGCT3VxJu2I0H1lKPF7WqOrG568ajKlas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSJ6lXHSqpVia7i39B7tkei/wFKc3ImfQLi1p/LKSrZxHBonbM8fkzVOBmGUFL2JM
	 DbRYt6bxJNdcRBcmkH0yz4Uo+RsO0+2t1BQgBQxdb4tysPzkVGw6bEXSxw0e6SFFYt
	 QvasCY4bIaJkXqm806C8T9bitwJ/qBLvqPR1+CsNZyPAGOf/5gdkAaqkCv5+0+K2I3
	 qSkny1VjXI2pGTpeawAnOC5+V6g1tsMjeUoKbZ8g0fJK8Zo5bsETkpV1+6P64rO2hs
	 t0mD5emTuepJ6EtKFzes6k+f56f8r5uX4IQwF9e/qXY15hwfuOcHH/UXyZ2eYmvmRJ
	 KmlcVe1nrI4VA==
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
Subject: [PATCH 7/7] perf report: Do not collect sample histogram unnecessarily
Date: Wed, 10 Apr 2024 20:32:56 -0700
Message-ID: <20240411033256.2099646-8-namhyung@kernel.org>
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

The data type profiling alone doesn't need the sample histogram for
functions.  It only needs the histogram for the types.

Let's remove the condition in the report_callback to check if data type
profiling is selected and make sure the annotation has the 'struct
annotated_source' instantiated before calling symbol__disassemble().

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 2 +-
 tools/perf/util/annotate.c  | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index aaa6427a1224..dafba6e030ef 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -172,7 +172,7 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	struct mem_info *mi;
 	struct branch_info *bi;
 
-	if (!ui__has_annotation() && !rep->symbol_ipc && !rep->data_type)
+	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
 	if (sort__mode == SORT_MODE__BRANCH) {
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ec79c120a7d2..7595c8fbc2c5 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -908,6 +908,13 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 
 	args.arch = arch;
 	args.ms = *ms;
+
+	if (notes->src == NULL) {
+		notes->src = annotated_source__new();
+		if (notes->src == NULL)
+			return -1;
+	}
+
 	if (annotate_opts.full_addr)
 		notes->src->start = map__objdump_2mem(ms->map, ms->sym->start);
 	else
-- 
2.44.0.478.gd926399ef9-goog


