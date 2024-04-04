Return-Path: <linux-kernel+bounces-131922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D458E898D95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CF51F21E3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C9B131BB9;
	Thu,  4 Apr 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/ErhSB9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA6130AD6;
	Thu,  4 Apr 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253441; cv=none; b=Ff8m0yiJ+7CNnqGWgtnMTovTZuZS1FXzJ3r/lB2cYmkpiqsrYH4JI30QnMv7jq0VL7sjg/TeZLnVytdL/rHozvJFqt4gkyh19e1LInCeVi8L0z0RdQU61IIYzAI/H8KSBFfpJzrpubF7qLsJwgWdCaDBgf358we6TrgNaPNqUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253441; c=relaxed/simple;
	bh=fv8+KGbOGn0vJth3f19KOjYOJnNdxCaQN7X8NxsFZaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhNgdpUPcMWQwURiXe3WoaxV0Qeyi/0fRAkI8NT174KwFhuU7qmKueji1dOQupaRWXy0nxywFn7+cP8IzjaMAXQfN7Yu7tYFrMvIBfYCHMROmyRoQwE3UZsFCV50L8kHnHtXTqvCcNKiSCw+Caf2rWJk7RustEs4znziqnA7Uo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/ErhSB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89856C433C7;
	Thu,  4 Apr 2024 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253440;
	bh=fv8+KGbOGn0vJth3f19KOjYOJnNdxCaQN7X8NxsFZaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/ErhSB9/JWesnoJaud1PgLIOFJdTGdy6nla3lvbvaEdlivSQQzR5e1WlKjpMkm6j
	 6Ll6ojkBFCp/vOHhg7NLro1t8xwJCxYtndcOtGzDGabrzR193eG5ZwdGZiNwZhfNKT
	 sQIVzaNlUUe6RtlqHogKOp6bxVCCtMbomvSVFaqsqbYEyPuj7iA21A2WaZXKBi6Ab1
	 F5nbA0tKhQKVeGIhspnDsLooivXyR0thTR6ZEUY20ee7yHZLuKKqp8gwl32dcmC+tE
	 VurtgaKsvTAxheDuJGcifvyOqUJZxO0OyFOmxdoJVyYhfzVb2BxfqWKp0ul5TYsThP
	 BNmlw0shmU0LQ==
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
Subject: [PATCH 4/9] perf annotate: Check annotation lines more efficiently
Date: Thu,  4 Apr 2024 10:57:11 -0700
Message-ID: <20240404175716.1225482-5-namhyung@kernel.org>
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

In some places, it checks annotated (disasm) lines for each byte.  But
as it already has a list of disasm lines, it'd be better to traverse the
list entries instead of checking every offset with linear search (by
annotated_source__get_line() helper).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 56 ++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2409d7424c71..d98fc248ba5b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -383,12 +383,19 @@ struct annotation_line *annotated_source__get_line(struct annotated_source *src,
 
 static unsigned annotation__count_insn(struct annotation *notes, u64 start, u64 end)
 {
+	struct annotation_line *al;
 	unsigned n_insn = 0;
-	u64 offset;
 
-	for (offset = start; offset <= end; offset++) {
-		if (annotated_source__get_line(notes->src, offset))
-			n_insn++;
+	al = annotated_source__get_line(notes->src, start);
+	if (al == NULL)
+		return 0;
+
+	list_for_each_entry_from(al, &notes->src->source, node) {
+		if (al->offset == -1)
+			continue;
+		if ((u64)al->offset > end)
+			break;
+		n_insn++;
 	}
 	return n_insn;
 }
@@ -405,10 +412,10 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 {
 	unsigned n_insn;
 	unsigned int cover_insn = 0;
-	u64 offset;
 
 	n_insn = annotation__count_insn(notes, start, end);
 	if (n_insn && ch->num && ch->cycles) {
+		struct annotation_line *al;
 		struct annotated_branch *branch;
 		float ipc = n_insn / ((double)ch->cycles / (double)ch->num);
 
@@ -416,11 +423,16 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 		if (ch->reset >= 0x7fff)
 			return;
 
-		for (offset = start; offset <= end; offset++) {
-			struct annotation_line *al;
+		al = annotated_source__get_line(notes->src, start);
+		if (al == NULL)
+			return;
 
-			al = annotated_source__get_line(notes->src, offset);
-			if (al && al->cycles && al->cycles->ipc == 0.0) {
+		list_for_each_entry_from(al, &notes->src->source, node) {
+			if (al->offset == -1)
+				continue;
+			if ((u64)al->offset > end)
+				break;
+			if (al->cycles && al->cycles->ipc == 0.0) {
 				al->cycles->ipc = ipc;
 				cover_insn++;
 			}
@@ -1268,13 +1280,16 @@ void symbol__annotate_decay_histogram(struct symbol *sym, int evidx)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct sym_hist *h = annotation__histogram(notes, evidx);
-	int len = symbol__size(sym), offset;
+	struct annotation_line *al;
 
 	h->nr_samples = 0;
-	for (offset = 0; offset < len; ++offset) {
+	list_for_each_entry(al, &notes->src->source, node) {
 		struct sym_hist_entry *entry;
 
-		entry = annotated_source__hist_entry(notes->src, evidx, offset);
+		if (al->offset == -1)
+			continue;
+
+		entry = annotated_source__hist_entry(notes->src, evidx, al->offset);
 		if (entry == NULL)
 			continue;
 
@@ -1334,33 +1349,32 @@ bool disasm_line__is_valid_local_jump(struct disasm_line *dl, struct symbol *sym
 static void
 annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 {
-	u64 offset, size = symbol__size(sym);
+	struct annotation_line *al;
 
 	/* PLT symbols contain external offsets */
 	if (strstr(sym->name, "@plt"))
 		return;
 
-	for (offset = 0; offset < size; ++offset) {
-		struct annotation_line *al;
+	list_for_each_entry(al, &notes->src->source, node) {
 		struct disasm_line *dl;
+		struct annotation_line *target;
 
-		al = annotated_source__get_line(notes->src, offset);
 		dl = disasm_line(al);
 
 		if (!disasm_line__is_valid_local_jump(dl, sym))
 			continue;
 
-		al = notes->src->offsets[dl->ops.target.offset];
-
+		target = annotated_source__get_line(notes->src,
+						    dl->ops.target.offset);
 		/*
 		 * FIXME: Oops, no jump target? Buggy disassembler? Or do we
 		 * have to adjust to the previous offset?
 		 */
-		if (al == NULL)
+		if (target == NULL)
 			continue;
 
-		if (++al->jump_sources > notes->max_jump_sources)
-			notes->max_jump_sources = al->jump_sources;
+		if (++target->jump_sources > notes->max_jump_sources)
+			notes->max_jump_sources = target->jump_sources;
 	}
 }
 
-- 
2.44.0.478.gd926399ef9-goog


