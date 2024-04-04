Return-Path: <linux-kernel+bounces-131925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CFA898D97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5000028AD2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC911339B8;
	Thu,  4 Apr 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLRMwyqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D812F37C;
	Thu,  4 Apr 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253442; cv=none; b=FAWdaB29uc4+Im7J/FS8LSiQXxg7ZWgKvnAYjxcWHdmf6HGX1HB8sCNxoBORk/J4IeLoV0pZKGZKyEflwxFzwWmnr/UMy4kbsE11bDRH0fZQtu2ltzaklTmbjtUb7GRymr98mqnzU+IjSTtSjcSD1drh2URHHdKHxD+H4UPiP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253442; c=relaxed/simple;
	bh=JWXX9PYo6AsnQWhyMkd6vlh4yGAwW5IMqqn8kgE6iFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGR04CR+RXcIK3H83iTja5Usv7TDdNXt9/XqWq+dtI5aIiZYp4M0IP02jDvFCB1nx8ypIFn+px6FhiBIJ35EjAEsV8JXeC5QKlF6fTAcMPAb3T2C7xu8G9MZ+KvU4ACMhwl6sG6XVE0LPMrYNktQIbnvEZ4XWA9DD2wxh1VOTIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLRMwyqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE72BC433F1;
	Thu,  4 Apr 2024 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253442;
	bh=JWXX9PYo6AsnQWhyMkd6vlh4yGAwW5IMqqn8kgE6iFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLRMwyqH4kak3eAT7K0+hug8hKn0h1WpNFwrJXxzwD0p4cAVn+iNBvlz2ahGWqJlX
	 Ampw/0yoVStwFaloX+t37hENnS1MKsHjt2EBWyrYexkOlB+0egA4KinVuM6dZt7TJv
	 RnliIv1pNDwCxB3qTU/H+OusUAwY0buY9nRoltKsQ0vpbdkrZBy9+5xZf9KBmtrU4S
	 SE1+j6Ofbf0QAUOV9Ta8Wbyry936Fqqn8g/Rg5ICv4UockMSpZZJu1Rq9xnpAh7Rls
	 1ZqFJqnh7B9O9xpoTpaIoi2i6jQ4cpAjWYbiiC2qrg5sbHSzJVVIeIf5Pd7FD0F8zv
	 8FoJRUh8TR4qA==
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
Subject: [PATCH 7/9] perf annotate: Move max_jump_sources struct to annotated_source
Date: Thu,  4 Apr 2024 10:57:14 -0700
Message-ID: <20240404175716.1225482-8-namhyung@kernel.org>
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
 tools/perf/ui/browsers/annotate.c | 2 +-
 tools/perf/util/annotate.c        | 6 +++---
 tools/perf/util/annotate.h        | 4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 032642a0b4b6..0e16c268e329 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -49,7 +49,7 @@ static int ui_browser__jumps_percent_color(struct ui_browser *browser, int nr, b
 
 	if (current && (!browser->use_navkeypressed || browser->navkeypressed))
 		return HE_COLORSET_SELECTED;
-	if (nr == notes->max_jump_sources)
+	if (nr == notes->src->max_jump_sources)
 		return HE_COLORSET_TOP;
 	if (nr > 1)
 		return HE_COLORSET_MEDIUM;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0be744bb529c..1fd51856d78f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1373,8 +1373,8 @@ annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 		if (target == NULL)
 			continue;
 
-		if (++target->jump_sources > notes->max_jump_sources)
-			notes->max_jump_sources = target->jump_sources;
+		if (++target->jump_sources > notes->src->max_jump_sources)
+			notes->src->max_jump_sources = target->jump_sources;
 	}
 }
 
@@ -1432,7 +1432,7 @@ annotation__init_column_widths(struct annotation *notes, struct symbol *sym)
 	notes->src->widths.addr = notes->src->widths.target =
 		notes->src->widths.min_addr = hex_width(symbol__size(sym));
 	notes->src->widths.max_addr = hex_width(sym->end);
-	notes->src->widths.jumps = width_jumps(notes->max_jump_sources);
+	notes->src->widths.jumps = width_jumps(notes->src->max_jump_sources);
 	notes->src->widths.max_ins_name = annotation__max_ins_name(notes);
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 402ae774426b..382705311d28 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -250,6 +250,8 @@ struct cyc_hist {
  * @nr_entries: Number of annotated_line in the source list.
  * @nr_asm_entries: Number of annotated_line with actual asm instruction in the
  * 		    source list.
+ * @max_jump_sources: Maximum number of jump instructions targeting to the same
+ * 		      instruction.
  * @widths: Precalculated width of each column in the TUI output.
  *
  * disasm_lines are allocated, percentages calculated and all sorted by percentage
@@ -265,6 +267,7 @@ struct annotated_source {
 	int    			nr_histograms;
 	int			nr_entries;
 	int			nr_asm_entries;
+	int			max_jump_sources;
 	struct {
 		u8		addr;
 		u8		jumps;
@@ -309,7 +312,6 @@ struct annotated_branch {
 struct LOCKABLE annotation {
 	u64			start;
 	int			nr_events;
-	int			max_jump_sources;
 	struct annotated_source *src;
 	struct annotated_branch *branch;
 };
-- 
2.44.0.478.gd926399ef9-goog


