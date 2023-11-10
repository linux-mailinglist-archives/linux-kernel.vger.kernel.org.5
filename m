Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9F7E7594
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345671AbjKJAED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345553AbjKJADV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:03:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2FB55AC;
        Thu,  9 Nov 2023 16:01:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2802d218242so1366192a91.1;
        Thu, 09 Nov 2023 16:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574482; x=1700179282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cqeJZmBhtU/NkALu7mtebMrt9fMeiVjhj08pg6EDRw=;
        b=hPh5Nk7QObWRd8XWHd04eL1NaNyx5lRLDVoO0CH0Vdfbm8Bro41XmQdRGWdB445v4u
         oDFjse4i4DL65UU5ZhRr79XXy23H/MZ2D5lM+2j6v54bwqxmdFaM/0mPcj4rX7joBA42
         MDg7m0T6+AmuD1KR5TW6g7nx8ZKyrlzyNOzVtqYNjgdI9DtZU3dekyGNFayhvehBBT8W
         1ve1tJLy6Ppj+FiMh4hfnnpfemsdaIG+c58ZFLLIneX0l4sX7t1H2evwY9TK0Qh1Ff6b
         FVX18K8jvCkJjYMqlnzLNNMGb0uYC4eM1DQL1x7FEAARdX4IRZ9OruykyUhs0jqQI2kM
         gIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574482; x=1700179282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cqeJZmBhtU/NkALu7mtebMrt9fMeiVjhj08pg6EDRw=;
        b=JStcRFqRxLJBtUvIEdXsG8cf2vhvWvObFqGNvL65+RuXKh9J1yQ6cljx/3cm4XetH8
         7upFBZb1Ac5LX+Y4JyzFz7DYrL3gyDmVwM5wQTXS3ni/5wAe+mI+KN1ZLg2+6DlTnEp3
         EdSGo/Luboqs2iV+mjUoBpLWkgDDZw8MhFvk7yaTlfcvfj7F+yA0IkEYOVMoslndqgGR
         Q2D9eKE4zfx2r5PYkpvCYjmnEVt93tK+aqmLZge1n9mx89poUQc0U46MpNIlyrQEqahS
         4a3wWF3Nnf4ptEKrqzmqpXsBUknQ+Zn+09/4fk+drgV+XdLW3OGiz8O8ntIoYDeyhdGB
         z+2A==
X-Gm-Message-State: AOJu0YxHNqcRdFnpbuR1+XXsXv/NvcNGqLyCxK+DBtojNjbKTWRYBB2M
        yMUaFb1NYs87fpemUVDzD8Y=
X-Google-Smtp-Source: AGHT+IHV1RmD15dLsiIGYRIq5hnxkjmITt9lt1rndfkOLUyvzK6xHgLm+L2uYY/hRkRlFn1S/oCMEA==
X-Received: by 2002:a17:90b:2250:b0:27d:b811:2fe4 with SMTP id hk16-20020a17090b225000b0027db8112fe4mr3465564pjb.26.1699574481529;
        Thu, 09 Nov 2023 16:01:21 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:21 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 42/52] perf annotate: Add annotate_get_basic_blocks()
Date:   Thu,  9 Nov 2023 16:00:01 -0800
Message-ID: <20231110000012.3538610-43-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 136a00e17a5c..d54a9ec16af4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3690,7 +3690,8 @@ static void symbol__ensure_annotate(struct map_symbol *ms, struct evsel *evsel)
 	}
 }
 
-static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
+static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
+					    bool allow_update)
 {
 	struct disasm_line *dl;
 	struct annotation *notes;
@@ -3703,7 +3704,8 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
 			 * llvm-objdump places "lock" in a separate line and
 			 * in that case, we want to get the next line.
 			 */
-			if (!strcmp(dl->ins.name, "lock") && *dl->ops.raw == '\0') {
+			if (!strcmp(dl->ins.name, "lock") &&
+			    *dl->ops.raw == '\0' && allow_update) {
 				ip++;
 				continue;
 			}
@@ -3814,7 +3816,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	 * Get a disasm to extract the location from the insn.
 	 * This is too slow...
 	 */
-	dl = find_disasm_line(ms->sym, ip);
+	dl = find_disasm_line(ms->sym, ip, /*allow_update=*/true);
 	if (dl == NULL) {
 		ann_data_stat.no_insn++;
 		return NULL;
@@ -3908,3 +3910,217 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
index 79ccc65c9ff9..e1fa86341281 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -501,4 +501,20 @@ extern struct list_head ann_insn_stat;
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
2.42.0.869.gea05f2083d-goog

