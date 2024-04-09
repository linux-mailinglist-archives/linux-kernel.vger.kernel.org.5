Return-Path: <linux-kernel+bounces-137731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985589E66B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95401F231C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ED615991D;
	Tue,  9 Apr 2024 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC5ZdLtD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF115957A;
	Tue,  9 Apr 2024 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706604; cv=none; b=Ie1G4Q/29X0/p16n68O1sOO/I9YI44WzZNnyJnoCiAVKsz0aSd94ad1uTFGsLYR0/XFw2Y5Jg5gYhKmx5/wD7Jk1lGw6GRBSGym8yB+MAFHGGM01GKU016dGUgeqPri1OQpV8hBnGxEdcnrZqtnzUhg73TeTrW6rwuSlDu14cuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706604; c=relaxed/simple;
	bh=PHHmaY/dJfgbrb1xjAz7ZXHpkxQRYYdnC61SjjaGTOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVJ/lXhCmVe5wWFkge8i/723MpkpPfj3ZBC48+wysBlMW5cAEPumoetIYnv/+fZweJlGIaVR/gNh4Ff8GIC0EAe33YV928h0w4iNwzJjCCAHiObW4D+fK3Ev4RKaGefzeSja2kfyfW3XUIy8x4NS+vtYI78tqdcBuIqI3JMiWsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC5ZdLtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC44C43390;
	Tue,  9 Apr 2024 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706604;
	bh=PHHmaY/dJfgbrb1xjAz7ZXHpkxQRYYdnC61SjjaGTOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XC5ZdLtDw+8tQjRubaQDyZmQrtnywONrn24Tldeg7Mp/JM9IbN92e2Z4XpbdLElO8
	 nG4CXMkj5xiPsAUnFVrAW3wD14YhmuhvrtkwSJaBz77DHZksdXjHVD0p7oXoD2kjy9
	 PEEoWIwR6CqdL6vLCZQEhVRsSVXEZtblOPdmXfu9IpPHKJoGGeOzFAUuNJ59YSiYkc
	 3SORnlNxr20Ubt+mC59v3c6fc1S/AWPtHMucEbY4cxfMV7ioQqd84WANf0lE/zVfAO
	 qekqa8+TJN9pYmbROL9t0fJn4JmHPDn1Y0AsmULEiURLKA0n4imSeP7Es4Hcxw35gi
	 HFriir49I6P4w==
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
Subject: [PATCH 6/6] perf report: Do not collect sample histogram unnecessarily
Date: Tue,  9 Apr 2024 16:50:00 -0700
Message-ID: <20240409235000.1893969-7-namhyung@kernel.org>
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

The data type profiling alone doesn't need the sample histogram for
functions.  It only needs the histogram for the types.

Let's remove the condition in the report_callback to check the data type
profiling and make sure the annotation has the annotated_source before
calling symbol__disassemble().

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
index 11da27801d88..7e034d2f2adb 100644
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


