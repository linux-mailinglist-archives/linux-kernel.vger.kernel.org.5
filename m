Return-Path: <linux-kernel+bounces-131919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84625898D92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB6B1F273B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435B1304B0;
	Thu,  4 Apr 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IapbwqgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037512F5BC;
	Thu,  4 Apr 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253439; cv=none; b=nxNJ9oFzgE0pgKYJuiqS5Y/HaBihE6AcTSRSdVYUAaUsYpTcAyFuNF3BoeYXjtFRjMxPal359OeFZLJ8jYn1B656ABFlpizVl9uY0Y9HcLRt4aNGATaY6B9lfYeAak1VDVTUr0CTZMGwnk51vDuM8TG7Uq2oWWNXjA/6vPMa/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253439; c=relaxed/simple;
	bh=GpzHHadLf3YosmcJ25cQdas5aywqFNxjfnYY+ULKu6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pq2o6m3vGRjflWdjxiBLUSw2rVlw3oPImnAcweTj/B8Mw12Jg9j+FXfJMBIr3ILFJCL4K562eRKr/jK6l+xgJ/oUK8ZQCYUZFw6KKAqp+jlpRWJMJKMtyMfsgaDHucF4cjggkibKSOyvvcQmGDKeIwQ4JTFSPIXKAw0RhGE7dRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IapbwqgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F7DC433B1;
	Thu,  4 Apr 2024 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253439;
	bh=GpzHHadLf3YosmcJ25cQdas5aywqFNxjfnYY+ULKu6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IapbwqgIG6nVtU4XbjbiafvS0yiobNrsyYLPd0Fl0YCdfNlToQymVKTID/Bve+jT6
	 dKvHnyqPeO+O8g8VpT5YzO2W3Jo6YsdoyM3g1IrdxLGKec2/9jlTjisCbMSzywNVY7
	 0MkPtZFruKk6SXi3faO6IjNmv8YvvzQIfaonX66dnVFe/AVQ3OMnBA3IU3RCX7kQNf
	 l8rneWG4zQE3eeU6E4vQAD8bcg//22oulCv1DFDB632PVmD0XheOSdTKH86qzfjbhP
	 3YAKTEHYm4ZtZaQObn6w+RvK49GdLrr4/cd2WdaMhIdHM+C3IXVRcmc3kX5Bu18QvE
	 pJVi+CdxCBy9Q==
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
Subject: [PATCH 1/9] perf annotate: Fix annotation_calc_lines()
Date: Thu,  4 Apr 2024 10:57:08 -0700
Message-ID: <20240404175716.1225482-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404175716.1225482-1-namhyung@kernel.org>
References: <20240404175716.1225482-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It should pass a proper address (i.e. suitable for objdump or addr2line)
to get_srcline() in order to work correctly.  It used to pass an address
with map__rip_2objdump() as the second argument but later it's changed
to use notes->start.  It's ok in normal cases but it can be changed when
annotate_opts.full_addr is set.  So let's convert the address directly
instead of using the notes->start.

Also the last argument is an IP to print symbol offset if requested.  So
it should pass symbol-relative address.

Fixes: 7d18a824b5e5 ("perf annotate: Toggle full address <-> offset display")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 35235147b111..a330e92c2552 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1440,7 +1440,7 @@ void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *m
 	annotation__update_column_widths(notes);
 }
 
-static void annotation__calc_lines(struct annotation *notes, struct map *map,
+static void annotation__calc_lines(struct annotation *notes, struct map_symbol *ms,
 				   struct rb_root *root)
 {
 	struct annotation_line *al;
@@ -1448,6 +1448,7 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 
 	list_for_each_entry(al, &notes->src->source, node) {
 		double percent_max = 0.0;
+		u64 addr;
 		int i;
 
 		for (i = 0; i < al->data_nr; i++) {
@@ -1463,8 +1464,9 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		if (percent_max <= 0.5)
 			continue;
 
-		al->path = get_srcline(map__dso(map), notes->start + al->offset, NULL,
-				       false, true, notes->start + al->offset);
+		addr = map__rip_2objdump(ms->map, ms->sym->start);
+		al->path = get_srcline(map__dso(ms->map), addr + al->offset, NULL,
+				       false, true, ms->sym->start + al->offset);
 		insert_source_line(&tmp_root, al);
 	}
 
@@ -1475,7 +1477,7 @@ static void symbol__calc_lines(struct map_symbol *ms, struct rb_root *root)
 {
 	struct annotation *notes = symbol__annotation(ms->sym);
 
-	annotation__calc_lines(notes, ms->map, root);
+	annotation__calc_lines(notes, ms, root);
 }
 
 int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel)
-- 
2.44.0.478.gd926399ef9-goog


