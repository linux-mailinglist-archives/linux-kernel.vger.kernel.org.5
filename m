Return-Path: <linux-kernel+bounces-131921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A60898D94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580F028AD46
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945991311AB;
	Thu,  4 Apr 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJBsC324"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1295130A6C;
	Thu,  4 Apr 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253440; cv=none; b=usQCS0NVIiedSGaHLKhZVumEa7guWLwCI8Go4ko6RDlAcLUaXRI0992XN2jBPXeTxVe2XPyt99fPQAZrB+Fhee5VWjf34ETxfi2NlV+JVjn+IAZQVSLcuvFh+C4KTFmpoWA/AjABMbohQX5fs4OwzgzrJx2o10A7B7fJE8IewFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253440; c=relaxed/simple;
	bh=w9JrZi8TtmQvvS0sNkL9xIp3LrMjB1YasM8k1btFVTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9uFcHr/K74Urx6DIJRsjb+qoUmaCPyrFTlCD+oCY36fR2D9As/YJ0fA2EqtNiIdrGQPNiB7w1cZnR62zt8ntP3uoepBDtRYACiEax1H9DEnrExP4eQdaOYCjOo9DNPbRPoQIgdzVKaYb1+9qfm4l00ZZvNZp2M0Cz3VUF6J4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJBsC324; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1199BC433F1;
	Thu,  4 Apr 2024 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253440;
	bh=w9JrZi8TtmQvvS0sNkL9xIp3LrMjB1YasM8k1btFVTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJBsC324CSDL3+ca0TRJhGTnahMC6sR6RMg+U72D1Tt8K6C6g8LB9XuIJUKo57Wew
	 W8zs159IIiP1+oLG7DOLaywu3cDUHYOzqNynERUGsJmUA7ulyrfQQ+UP15grTcugSt
	 NDC1OJCGNSYs9T07LSh3B8Km5UEo2L95922PSB3I+SgMGchSN/ZHxsQYchBKQK93yK
	 A3sNlNAkpM3qFmPEBxcx8tPcEgEmw0rA/U5HfsbEB8kAJiMKTmCWieFMkb2mzMMh1t
	 D9ygG3GGzLWu1NJlbYCBwYZAFF17oxLb3XYWCwyUzrsTnbPAEBmPSdHlQXYf5axJ6z
	 1G3YG45h5v+FA==
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
Subject: [PATCH 3/9] perf annotate: Introduce annotated_source__get_line()
Date: Thu,  4 Apr 2024 10:57:10 -0700
Message-ID: <20240404175716.1225482-4-namhyung@kernel.org>
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

It's a helper function to get annotation_line at the given offset
without using the offsets array.  The goal is to get rid of the
offsets array altogether.  It just does the linear search but I
think it's better to save memory as it won't be called in a hot
path.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/util/annotate.c        | 26 +++++++++++++++++++++-----
 tools/perf/util/annotate.h        |  3 +++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ec5e21932876..e72583f37972 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -186,7 +186,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	 *  name right after the '<' token and probably treating this like a
 	 *  'call' instruction.
 	 */
-	target = notes->src->offsets[cursor->ops.target.offset];
+	target = annotated_source__get_line(notes->src, cursor->ops.target.offset);
 	if (target == NULL) {
 		ui_helpline__printf("WARN: jump target inconsistency, press 'o', notes->offsets[%#x] = NULL\n",
 				    cursor->ops.target.offset);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bbf4894b1309..2409d7424c71 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -369,13 +369,25 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 	return err;
 }
 
+struct annotation_line *annotated_source__get_line(struct annotated_source *src,
+						   s64 offset)
+{
+	struct annotation_line *al;
+
+	list_for_each_entry(al, &src->source, node) {
+		if (al->offset == offset)
+			return al;
+	}
+	return NULL;
+}
+
 static unsigned annotation__count_insn(struct annotation *notes, u64 start, u64 end)
 {
 	unsigned n_insn = 0;
 	u64 offset;
 
 	for (offset = start; offset <= end; offset++) {
-		if (notes->src->offsets[offset])
+		if (annotated_source__get_line(notes->src, offset))
 			n_insn++;
 	}
 	return n_insn;
@@ -405,8 +417,9 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 			return;
 
 		for (offset = start; offset <= end; offset++) {
-			struct annotation_line *al = notes->src->offsets[offset];
+			struct annotation_line *al;
 
+			al = annotated_source__get_line(notes->src, offset);
 			if (al && al->cycles && al->cycles->ipc == 0.0) {
 				al->cycles->ipc = ipc;
 				cover_insn++;
@@ -443,7 +456,7 @@ static int annotation__compute_ipc(struct annotation *notes, size_t size)
 		if (ch && ch->cycles) {
 			struct annotation_line *al;
 
-			al = notes->src->offsets[offset];
+			al = annotated_source__get_line(notes->src, offset);
 			if (al && al->cycles == NULL) {
 				al->cycles = zalloc(sizeof(*al->cycles));
 				if (al->cycles == NULL) {
@@ -466,7 +479,9 @@ static int annotation__compute_ipc(struct annotation *notes, size_t size)
 			struct cyc_hist *ch = &notes->branch->cycles_hist[offset];
 
 			if (ch && ch->cycles) {
-				struct annotation_line *al = notes->src->offsets[offset];
+				struct annotation_line *al;
+
+				al = annotated_source__get_line(notes->src, offset);
 				if (al)
 					zfree(&al->cycles);
 			}
@@ -1326,9 +1341,10 @@ annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 		return;
 
 	for (offset = 0; offset < size; ++offset) {
-		struct annotation_line *al = notes->src->offsets[offset];
+		struct annotation_line *al;
 		struct disasm_line *dl;
 
+		al = annotated_source__get_line(notes->src, offset);
 		dl = disasm_line(al);
 
 		if (!disasm_line__is_valid_local_jump(dl, sym))
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3f383f38f65f..aa3298c20300 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -270,6 +270,9 @@ struct annotated_source {
 	u16			max_line_len;
 };
 
+struct annotation_line *annotated_source__get_line(struct annotated_source *src,
+						   s64 offset);
+
 /**
  * struct annotated_branch - basic block and IPC information for a symbol.
  *
-- 
2.44.0.478.gd926399ef9-goog


