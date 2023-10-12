Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035567C638A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377305AbjJLDz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbjJLDxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:53:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACA3171A;
        Wed, 11 Oct 2023 20:52:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-58d261807e8so383513a12.2;
        Wed, 11 Oct 2023 20:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082724; x=1697687524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoNrgrTYCFhmQWw/dMn/hk+rVy7/lvgQA+Rba8TK9Aw=;
        b=TvB1WPlswUHoMWa3lXsVY8CplYmUfqoTf9Mk8bYcE+NB2hicUFuELlTX68nYerrv20
         8G8gXCigLZHo3+idPiipGEYjU8vRkWBNj7WHpymiJOE4t3JeR0c/GhYrFD8kXZQXX33w
         kUxn4RQj2qlKp5VaEGyCoCJQuH6YjIsiU3U1Ss5PKTW4d+pLY+yHzcQRqgB9W+PT/7Le
         LAUkymTLkiSlVLQZTKCDfZnmosIHo+DJYliJp87NAOgr/Z8Vc+mxfsSaBzh6elOr1oHd
         2b+U9MPemW7/R9fgK50hY3Spa0BLJ4Nk9lBh3A0B/ttLrPbZ36fUmwbyuHXOfs4maZ3K
         jmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082724; x=1697687524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NoNrgrTYCFhmQWw/dMn/hk+rVy7/lvgQA+Rba8TK9Aw=;
        b=LIgIkCK4Ss918AmS0KG0Vu7j0FFw/cjuTQhty108nCV2s07odg1AE1CSGLtsHn5IPY
         IlUkMMea1XKBhlJJDrV9Irsc6rkiYH4ySdHy39OLkXQObEDXzL297CHxIKBPk+hQ6AGo
         Cn1HAKvv0jbyhs2AJZGyuSh8ot9Y17D9O3E3tEmyt3y2CR1VqvBaTC0rY7qsBuXj999c
         nzPFxtgpdMUnHaKjpo8Y+Ba5cJWFW6MSDwhjDZqLsDKBvnX118DNeIHawI/DTyo0pqCo
         xEEX10E95CWEFAk/vakHTlzI7WGT3JqekdHFn9mu9wDnd8eGroCebD/vP20oS3G71oQZ
         B7Cg==
X-Gm-Message-State: AOJu0YzPgY1MpZXgO2wgFd+VpC01oUf7WcYWwzUykcMwku8/fnrnbA+P
        z0V+gnP6i0oVd3bRiYH/Qok=
X-Google-Smtp-Source: AGHT+IHp+5v8TvQ4w+OkmVq7Q10RkNSsylihPWkJ6Iz21p7k40Ucn4vL3rQcv9YJjmHjq+QJ3tBu+g==
X-Received: by 2002:a17:903:184:b0:1c8:8f61:967b with SMTP id z4-20020a170903018400b001c88f61967bmr15783049plg.3.1697082724523;
        Wed, 11 Oct 2023 20:52:04 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:04 -0700 (PDT)
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
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 38/48] perf annotate: Add annotate_get_basic_blocks()
Date:   Wed, 11 Oct 2023 20:51:01 -0700
Message-ID: <20231012035111.676789-39-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 tools/perf/util/annotate.c | 219 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/annotate.h |  16 +++
 2 files changed, 232 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1cf55f903ee4..8384bc37831c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3642,7 +3642,8 @@ static void symbol__ensure_annotate(struct map_symbol *ms, struct evsel *evsel)
 	}
 }
 
-static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
+static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
+					    bool allow_update)
 {
 	struct disasm_line *dl;
 	struct annotation *notes;
@@ -3655,7 +3656,8 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
 			 * llvm-objdump places "lock" in a separate line and
 			 * in that case, we want to get the next line.
 			 */
-			if (!strcmp(dl->ins.name, "lock") && *dl->ops.raw == '\0') {
+			if (!strcmp(dl->ins.name, "lock") &&
+			    *dl->ops.raw == '\0' && allow_update) {
 				ip++;
 				continue;
 			}
@@ -3766,7 +3768,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	 * Get a disasm to extract the location from the insn.
 	 * This is too slow...
 	 */
-	dl = find_disasm_line(ms->sym, ip);
+	dl = find_disasm_line(ms->sym, ip, /*allow_update=*/true);
 	if (dl == NULL) {
 		ann_data_stat.no_insn++;
 		return NULL;
@@ -3860,3 +3862,214 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
index 99c8d30a2fa7..c2cc9baf08be 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -493,4 +493,20 @@ extern struct list_head ann_insn_stat;
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
2.42.0.655.g421f12c284-goog

