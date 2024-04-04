Return-Path: <linux-kernel+bounces-131926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F58898D99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F47F28266C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7E13441F;
	Thu,  4 Apr 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFL5JYvJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD631339B1;
	Thu,  4 Apr 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253443; cv=none; b=S4aV/Hl31oeCo0DsM+LGk38d7N58Li3nVa9WWhbqPJsSW/vNiHdn1SDlIUfOrUL1mnzM+mfNpWajYOTR43ctq46WlvebmTiRLz0KVAZYR12+Hj5g0tq+BoXYRmVYICf2krz2HpEwc/HJimq3z610MfbFePv6+LOo++7GqPXwA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253443; c=relaxed/simple;
	bh=zOkpmF2bfwe8D5R+ONfcu1WFleIDXUSyCE14ZC5NB/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcj06WOfqEwcv64qh3HWQ8+01AZhGdD4Z5v5yM37e0L/nZPPxBafXaD06GvmgPxUt7mTzNPF3oBgCDtxIOwaQ5FwYfbzYqaH1LSmrhZ/K5UjSKhYZRBQbtc1JBuR79NevCdZJopWqGnwKkoyoG4AJHI4ToG1P4ilwTO/ulf1zcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFL5JYvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD8BC43330;
	Thu,  4 Apr 2024 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253442;
	bh=zOkpmF2bfwe8D5R+ONfcu1WFleIDXUSyCE14ZC5NB/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFL5JYvJQKECvIkWeaD9FDcy67MEtBVJdlLjvsd93jDYlHXxE7GyoneUqbQviyS3Y
	 OxSDbzIL0r5rrxUgfbvZHGikfw63P9vFcbByrvWZ5rgqThJgR0LX/nrJbFRpDBzCcU
	 p1sIvkrwEfiYxEWFi71ZPz0N+ET67nVz5UvuGOeI6STjtQjm5jWJZ8s57En60n7FgX
	 x8KPyuW+x93vohjQui3fSPSqKoRRvhVgR/PGFjqibr8Les4k0hxP3WPIGPvJGUy6uB
	 SA/DixozWwQxLIy3AzT0+W7yb8AujY8GlFEYEQDs+XL6qw9zKpcz1OmbJ5Tt6RSixp
	 ZdyOhr0NV2dOQ==
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
Subject: [PATCH 8/9] perf annotate: Move nr_events struct to annotated_source
Date: Thu,  4 Apr 2024 10:57:15 -0700
Message-ID: <20240404175716.1225482-9-namhyung@kernel.org>
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

It's only used in perf annotate output which means functions with actual
samples.  No need to consume memory for every symbol (annotation).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 6 +++---
 tools/perf/util/annotate.h | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1fd51856d78f..5f79ae0bccfd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1584,7 +1584,7 @@ static double annotation_line__max_percent(struct annotation_line *al,
 	double percent_max = 0.0;
 	int i;
 
-	for (i = 0; i < notes->nr_events; i++) {
+	for (i = 0; i < notes->src->nr_events; i++) {
 		double percent;
 
 		percent = annotation_data__percent(&al->data[i],
@@ -1674,7 +1674,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 	if (al->offset != -1 && percent_max != 0.0) {
 		int i;
 
-		for (i = 0; i < notes->nr_events; i++) {
+		for (i = 0; i < notes->src->nr_events; i++) {
 			double percent;
 
 			percent = annotation_data__percent(&al->data[i], percent_type);
@@ -1846,7 +1846,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 		return err;
 
 	annotation__init_column_widths(notes, sym);
-	notes->nr_events = nr_pcnt;
+	notes->src->nr_events = nr_pcnt;
 
 	annotation__update_column_widths(notes);
 	sym->annotate2 = 1;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 382705311d28..d22b9e9a2fad 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -247,6 +247,7 @@ struct cyc_hist {
  * 		  to see each group separately, that is why symbol__annotate2()
  * 		  sets src->nr_histograms to evsel->nr_members.
  * @samples: Hash map of sym_hist_entry.  Keyed by event index and offset in symbol.
+ * @nr_events: Number of events in the current output.
  * @nr_entries: Number of annotated_line in the source list.
  * @nr_asm_entries: Number of annotated_line with actual asm instruction in the
  * 		    source list.
@@ -265,6 +266,7 @@ struct annotated_source {
 	struct sym_hist		*histograms;
 	struct hashmap	   	*samples;
 	int    			nr_histograms;
+	int    			nr_events;
 	int			nr_entries;
 	int			nr_asm_entries;
 	int			max_jump_sources;
@@ -311,7 +313,6 @@ struct annotated_branch {
 
 struct LOCKABLE annotation {
 	u64			start;
-	int			nr_events;
 	struct annotated_source *src;
 	struct annotated_branch *branch;
 };
@@ -335,7 +336,7 @@ static inline int annotation__cycles_width(struct annotation *notes)
 
 static inline int annotation__pcnt_width(struct annotation *notes)
 {
-	return (symbol_conf.show_total_period ? 12 : 7) * notes->nr_events;
+	return (symbol_conf.show_total_period ? 12 : 7) * notes->src->nr_events;
 }
 
 static inline bool annotation_line__filter(struct annotation_line *al)
-- 
2.44.0.478.gd926399ef9-goog


