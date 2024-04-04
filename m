Return-Path: <linux-kernel+bounces-131923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D53898D96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C241C28889
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3B513280F;
	Thu,  4 Apr 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzYuVDxR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8913119B;
	Thu,  4 Apr 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253441; cv=none; b=byd3oi66oiLlY04sK92bah2Yh3H1DkXXAin1WVtUMr12shqT5He/h9rqDlvagM0u8CoVUpGEaUwn9ZU6XAj4jtdSAk1ETtL7N+uz4kKp1hAIg84dcolxWAyRYLKMTk5Ttp6ofiVtCWYGL4PtuDP29EAHrp79RdqFDzwT+3w6YKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253441; c=relaxed/simple;
	bh=rx0Er1u712mtimPPRUKohpR7c9tBI51uTJQRc2Ubw6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyXrb/b4tTgOpEgK15dyXWq+HhC+CclheL7dmzmLHd+Z3aSBhUQWPfUYEadr/ofLUtm/6IrjxS2/B4xlXv+yAAlVyntwpOP2JqrU2BXcnJaNrlmNoPBcxgn6irnMnHBV9CGruk2g5dOZPS4Ryj9iq3Hy4VWZRghdcuoGBF3I4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzYuVDxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06896C43394;
	Thu,  4 Apr 2024 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253441;
	bh=rx0Er1u712mtimPPRUKohpR7c9tBI51uTJQRc2Ubw6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RzYuVDxR1uQ1L8XzQWRu3/+Ow9mDheUg1IMpGxSAclmTROSDwUd706w0PQsF+83Gt
	 xQL2OIR9mduxPy060SYX2l/tMk75oytWeIVbCmDsXanLpEmRNPxS7n+HWFyqZ+LDNw
	 2N3DFaeQ3FD9xBkZinOxe/rQYEMMPJFIkuRQLWVs+9g3LsQEFtXWZUkrx6h48A2nhY
	 endIfjVblhs/DTZvy2/tu1MYUV6kj9lPV6aodNqqFuwHDkrCwgByPxatYa6G7zDuyJ
	 CUuFHUkXYIcB8V///Fv7zhkBxPujEUrg7gpw2sh96ODPjILynjUz4mxAhtG1E4+mHd
	 mIClGonep7zhg==
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
Subject: [PATCH 5/9] perf annotate: Get rid of offsets array
Date: Thu,  4 Apr 2024 10:57:12 -0700
Message-ID: <20240404175716.1225482-6-namhyung@kernel.org>
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

The struct annotated_source.offsets[] is to save pointers to
annotation_line at each offset.  We can use annotated_source__get_line()
helper instead and let's get rid of the array.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c |  5 +----
 tools/perf/util/annotate.c        | 29 ++++++-----------------------
 tools/perf/util/annotate.h        |  2 --
 3 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e72583f37972..c93da2ce727f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -977,7 +977,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 			dso->annotate_warned = true;
 			symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
 			ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
-			goto out_free_offsets;
+			return -1;
 		}
 	}
 
@@ -996,8 +996,5 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 	if(not_annotated)
 		annotated_source__purge(notes->src);
 
-out_free_offsets:
-	if(not_annotated)
-		zfree(&notes->src->offsets);
 	return ret;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d98fc248ba5b..0e8319835986 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1378,7 +1378,7 @@ annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 	}
 }
 
-static void annotation__set_offsets(struct annotation *notes, s64 size)
+static void annotation__set_index(struct annotation *notes)
 {
 	struct annotation_line *al;
 	struct annotated_source *src = notes->src;
@@ -1393,18 +1393,9 @@ static void annotation__set_offsets(struct annotation *notes, s64 size)
 		if (src->max_line_len < line_len)
 			src->max_line_len = line_len;
 		al->idx = src->nr_entries++;
-		if (al->offset != -1) {
+		if (al->offset != -1)
 			al->idx_asm = src->nr_asm_entries++;
-			/*
-			 * FIXME: short term bandaid to cope with assembly
-			 * routines that comes with labels in the same column
-			 * as the address in objdump, sigh.
-			 *
-			 * E.g. copy_user_generic_unrolled
- 			 */
-			if (al->offset < size)
-				notes->src->offsets[al->offset] = al;
-		} else
+		else
 			al->idx_asm = -1;
 	}
 }
@@ -1835,25 +1826,21 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	size_t size = symbol__size(sym);
 	int nr_pcnt = 1, err;
 
-	notes->src->offsets = zalloc(size * sizeof(struct annotation_line *));
-	if (notes->src->offsets == NULL)
-		return ENOMEM;
-
 	if (evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
 
 	err = symbol__annotate(ms, evsel, parch);
 	if (err)
-		goto out_free_offsets;
+		return err;
 
 	symbol__calc_percent(sym, evsel);
 
-	annotation__set_offsets(notes, size);
+	annotation__set_index(notes);
 	annotation__mark_jump_targets(notes, sym);
 
 	err = annotation__compute_ipc(notes, size);
 	if (err)
-		goto out_free_offsets;
+		return err;
 
 	annotation__init_column_widths(notes, sym);
 	notes->nr_events = nr_pcnt;
@@ -1862,10 +1849,6 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	sym->annotate2 = 1;
 
 	return 0;
-
-out_free_offsets:
-	zfree(&notes->src->offsets);
-	return err;
 }
 
 static int annotation__config(const char *var, const char *value, void *data)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index aa3298c20300..d61184499bda 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -246,7 +246,6 @@ struct cyc_hist {
  * 		  we have more than a group in a evlist, where we will want
  * 		  to see each group separately, that is why symbol__annotate2()
  * 		  sets src->nr_histograms to evsel->nr_members.
- * @offsets: Array of annotation_line to be accessed by offset.
  * @samples: Hash map of sym_hist_entry.  Keyed by event index and offset in symbol.
  * @nr_entries: Number of annotated_line in the source list.
  * @nr_asm_entries: Number of annotated_line with actual asm instruction in the
@@ -262,7 +261,6 @@ struct cyc_hist {
 struct annotated_source {
 	struct list_head	source;
 	struct sym_hist		*histograms;
-	struct annotation_line	**offsets;
 	struct hashmap	   	*samples;
 	int    			nr_histograms;
 	int			nr_entries;
-- 
2.44.0.478.gd926399ef9-goog


