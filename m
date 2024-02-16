Return-Path: <linux-kernel+bounces-69498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E5858A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019651C22507
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F27B14D433;
	Fri, 16 Feb 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeLCMDV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793514A4F3;
	Fri, 16 Feb 2024 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127668; cv=none; b=frS1Xanpp6sFM++bMnVjWW2jdBA7B6fnjAPxuDOxKINPaKwenUKgU0tIYCSJnoQRHNd6ILHMUrW+w/qF7fI1xHTUzGjxNzX6DLQcMVGPINqf70fMF9vyYIRfTAgm+SkaXmmsXCYArwhK4BxceJKKVqu0HTBoGv+uRL2BuO0HF5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127668; c=relaxed/simple;
	bh=7EAn2Z7hh95QVpxT5LLVg3XrS1iSEiXohUgQ6njH8Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJDdRo58u9MrQN2TEuECg/UKcq92Z17wCavTT/xBjy5lZMB24NXtHRoJ/Oh1gDgikMMaXsyYBXofRUAODvIYuxSYN8OZfC018B7x7tHh7QinzuU7H95ZoFcHyCwho4s1hxE529R7Q9U0cne8v9yOSUYAsgl8e/A2BhplWuTfwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeLCMDV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC2AC433B1;
	Fri, 16 Feb 2024 23:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708127668;
	bh=7EAn2Z7hh95QVpxT5LLVg3XrS1iSEiXohUgQ6njH8Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZeLCMDV7bHtdsFi8sCylsREmrW9tSE3m0vzGLdXQI0OC1VxfLN81/lMqFjVzT2DpS
	 mQqvRLFyDJut08I1lYqvTfBqf2EyCzVPeC3B63aMK2CtBSILhAz/CwXEObNRhXAP6S
	 Y6Pc3SqQOoLYjNx2VQzj0jV9euTr3TUgLqhWFCXpbxNZTlC48BBiN7IDqfPz9HHhWQ
	 WMUSTki/oEvwNq3LcenYTN6m6tBCxXy8nv605+fn44WeeypIakSbvNzkTatIPh4toT
	 HFN/Y76xhbe1W4AbXKR3eX2uPtVkAOGP+uZhxKiA1PD6UVw9EUx8CoCriP/JPFyG2x
	 ej3V0tPVkmGIA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org
Subject: [PATCH 05/14] perf annotate: Add annotate_get_basic_blocks()
Date: Fri, 16 Feb 2024 15:54:14 -0800
Message-ID: <20240216235423.2343167-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216235423.2343167-1-namhyung@kernel.org>
References: <20240216235423.2343167-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The annotate_get_basic_blocks() is to find a list of basic blocks from
the source instruction to the destination instruction in a function.

It'll be used to find variables in a scope.  Use BFS (Breadth First
Search) to find a shortest path to carry the variable/register state
minimally.

Also change find_disasm_line() to be used in annotate_get_basic_blocks()
and add 'allow_update' argument to control if it can update the IP.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 222 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/annotate.h |  16 +++
 2 files changed, 235 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index cb5d4c517a4d..4ef14b3f49e4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3686,7 +3686,8 @@ static void symbol__ensure_annotate(struct map_symbol *ms, struct evsel *evsel)
 	}
 }
 
-static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
+static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
+					    bool allow_update)
 {
 	struct disasm_line *dl;
 	struct annotation *notes;
@@ -3699,7 +3700,8 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
 			 * llvm-objdump places "lock" in a separate line and
 			 * in that case, we want to get the next line.
 			 */
-			if (!strcmp(dl->ins.name, "lock") && *dl->ops.raw == '\0') {
+			if (!strcmp(dl->ins.name, "lock") &&
+			    *dl->ops.raw == '\0' && allow_update) {
 				ip++;
 				continue;
 			}
@@ -3815,7 +3817,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	 * Get a disasm to extract the location from the insn.
 	 * This is too slow...
 	 */
-	dl = find_disasm_line(ms->sym, ip);
+	dl = find_disasm_line(ms->sym, ip, /*allow_update=*/true);
 	if (dl == NULL) {
 		ann_data_stat.no_insn++;
 		return NULL;
@@ -3909,3 +3911,217 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	istat->bad++;
 	return NULL;
 }
+
+/* Basic block traversal (BFS) data structure */
+struct basic_block_data {
+	struct list_head queue;
+	struct list_head visited;
+};
+
+/*
+ * During the traversal, it needs to know the parent block where the current
+ * block block started from.  Note that single basic block can be parent of
+ * two child basic blocks (in case of condition jump).
+ */
+struct basic_block_link {
+	struct list_head node;
+	struct basic_block_link *parent;
+	struct annotated_basic_block *bb;
+};
+
+/* Check any of basic block in the list already has the offset */
+static bool basic_block_has_offset(struct list_head *head, s64 offset)
+{
+	struct basic_block_link *link;
+
+	list_for_each_entry(link, head, node) {
+		s64 begin_offset = link->bb->begin->al.offset;
+		s64 end_offset = link->bb->end->al.offset;
+
+		if (begin_offset <= offset && offset <= end_offset)
+			return true;
+	}
+	return false;
+}
+
+static bool is_new_basic_block(struct basic_block_data *bb_data,
+			       struct disasm_line *dl)
+{
+	s64 offset = dl->al.offset;
+
+	if (basic_block_has_offset(&bb_data->visited, offset))
+		return false;
+	if (basic_block_has_offset(&bb_data->queue, offset))
+		return false;
+	return true;
+}
+
+/* Add a basic block starting from dl and link it to the parent */
+static int add_basic_block(struct basic_block_data *bb_data,
+			   struct basic_block_link *parent,
+			   struct disasm_line *dl)
+{
+	struct annotated_basic_block *bb;
+	struct basic_block_link *link;
+
+	if (dl == NULL)
+		return -1;
+
+	if (!is_new_basic_block(bb_data, dl))
+		return 0;
+
+	bb = zalloc(sizeof(*bb));
+	if (bb == NULL)
+		return -1;
+
+	bb->begin = dl;
+	bb->end = dl;
+	INIT_LIST_HEAD(&bb->list);
+
+	link = malloc(sizeof(*link));
+	if (link == NULL) {
+		free(bb);
+		return -1;
+	}
+
+	link->bb = bb;
+	link->parent = parent;
+	list_add_tail(&link->node, &bb_data->queue);
+	return 0;
+}
+
+/* Returns true when it finds the target in the current basic block */
+static bool process_basic_block(struct basic_block_data *bb_data,
+				struct basic_block_link *link,
+				struct symbol *sym, u64 target)
+{
+	struct disasm_line *dl, *next_dl, *last_dl;
+	struct annotation *notes = symbol__annotation(sym);
+	bool found = false;
+
+	dl = link->bb->begin;
+	/* Check if it's already visited */
+	if (basic_block_has_offset(&bb_data->visited, dl->al.offset))
+		return false;
+
+	last_dl = list_last_entry(&notes->src->source,
+				  struct disasm_line, al.node);
+
+	list_for_each_entry_from(dl, &notes->src->source, al.node) {
+		/* Found the target instruction */
+		if (sym->start + dl->al.offset == target) {
+			found = true;
+			break;
+		}
+		/* End of the function, finish the block */
+		if (dl == last_dl)
+			break;
+		/* 'return' instruction finishes the block */
+		if (dl->ins.ops == &ret_ops)
+			break;
+		/* normal instructions are part of the basic block */
+		if (dl->ins.ops != &jump_ops)
+			continue;
+		/* jump to a different function, tail call or return */
+		if (dl->ops.target.outside)
+			break;
+		/* jump instruction creates new basic block(s) */
+		next_dl = find_disasm_line(sym, sym->start + dl->ops.target.offset,
+					   /*allow_update=*/false);
+		add_basic_block(bb_data, link, next_dl);
+
+		/*
+		 * FIXME: determine conditional jumps properly.
+		 * Conditional jumps create another basic block with the
+		 * next disasm line.
+		 */
+		if (!strstr(dl->ins.name, "jmp")) {
+			next_dl = list_next_entry(dl, al.node);
+			add_basic_block(bb_data, link, next_dl);
+		}
+		break;
+
+	}
+	link->bb->end = dl;
+	return found;
+}
+
+/*
+ * It founds a target basic block, build a proper linked list of basic blocks
+ * by following the link recursively.
+ */
+static void link_found_basic_blocks(struct basic_block_link *link,
+				    struct list_head *head)
+{
+	while (link) {
+		struct basic_block_link *parent = link->parent;
+
+		list_move(&link->bb->list, head);
+		list_del(&link->node);
+		free(link);
+
+		link = parent;
+	}
+}
+
+static void delete_basic_blocks(struct basic_block_data *bb_data)
+{
+	struct basic_block_link *link, *tmp;
+
+	list_for_each_entry_safe(link, tmp, &bb_data->queue, node) {
+		list_del(&link->node);
+		free(link->bb);
+		free(link);
+	}
+
+	list_for_each_entry_safe(link, tmp, &bb_data->visited, node) {
+		list_del(&link->node);
+		free(link->bb);
+		free(link);
+	}
+}
+
+/**
+ * annotate_get_basic_blocks - Get basic blocks for given address range
+ * @sym: symbol to annotate
+ * @src: source address
+ * @dst: destination address
+ * @head: list head to save basic blocks
+ *
+ * This function traverses disasm_lines from @src to @dst and save them in a
+ * list of annotated_basic_block to @head.  It uses BFS to find the shortest
+ * path between two.  The basic_block_link is to maintain parent links so
+ * that it can build a list of blocks from the start.
+ */
+int annotate_get_basic_blocks(struct symbol *sym, s64 src, s64 dst,
+			      struct list_head *head)
+{
+	struct basic_block_data bb_data = {
+		.queue = LIST_HEAD_INIT(bb_data.queue),
+		.visited = LIST_HEAD_INIT(bb_data.visited),
+	};
+	struct basic_block_link *link;
+	struct disasm_line *dl;
+	int ret = -1;
+
+	dl = find_disasm_line(sym, src, /*allow_update=*/false);
+	if (dl == NULL)
+		return -1;
+
+	if (add_basic_block(&bb_data, /*parent=*/NULL, dl) < 0)
+		return -1;
+
+	/* Find shortest path from src to dst using BFS */
+	while (!list_empty(&bb_data.queue)) {
+		link = list_first_entry(&bb_data.queue, struct basic_block_link, node);
+
+		if (process_basic_block(&bb_data, link, sym, dst)) {
+			link_found_basic_blocks(link, head);
+			ret = 0;
+			break;
+		}
+		list_move(&link->node, &bb_data.visited);
+	}
+	delete_basic_blocks(&bb_data);
+	return ret;
+}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 94435607c958..83afbe294ab7 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -495,4 +495,20 @@ extern struct list_head ann_insn_stat;
 u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 			struct disasm_line *dl);
 
+/**
+ * struct annotated_basic_block - Basic block of instructions
+ * @list: List node
+ * @begin: start instruction in the block
+ * @end: end instruction in the block
+ */
+struct annotated_basic_block {
+	struct list_head list;
+	struct disasm_line *begin;
+	struct disasm_line *end;
+};
+
+/* Get a list of basic blocks from src to dst addresses */
+int annotate_get_basic_blocks(struct symbol *sym, s64 src, s64 dst,
+			      struct list_head *head);
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.44.0.rc0.258.g7320e95886-goog


