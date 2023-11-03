Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A17E0961
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377675AbjKCTTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377348AbjKCTTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:19:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE2D52;
        Fri,  3 Nov 2023 12:19:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-28019b66ad5so2185244a91.3;
        Fri, 03 Nov 2023 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699039152; x=1699643952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmFivyb8v0w5waZiQyZwSre0AC5T9ucB7JHzxYcIEWg=;
        b=ZBQLddQpdCTqY/cW+KhwQ4H6ogZHJNLCGit/1eMGPq8wjALl32YNTM77Jii2FaDxdh
         mDNEt2AJNKdwzMi2Ahi1wlfzUjGXHpfugRwiv9V/lJIMHUis8kzUOrXfBeebP3M5w7or
         sRIPHd8aJG8hSpgL/Jb/oR6unDrYKY/a/USxHrb7cbcgAESMLGMYtM2hiK8YLfknejvi
         yYPSUplylecyOsiJ14Cb81EjeF/YrwGkxFmZHVhtK+LhGtZZUofVOTUEkzuXi1t0Xt9w
         GkjE6H/tX1VOKA4/5zNuqQ3KcEqIO+LZBp8o9Q9OcUQ5N7I/uctPI4eLJYLK9YoSwf9W
         rEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699039152; x=1699643952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmFivyb8v0w5waZiQyZwSre0AC5T9ucB7JHzxYcIEWg=;
        b=gAdpBZBJxTIgg2YSzf6bsJ3VVqrJI4DOlSZZBKppt3gmyTj7m4fQzidOjxok+2gGhB
         IDpjiDeHT1+kWVXtrq/wZQOFOaAZXMMTxCk4+HQvpJt+vxHTJt4JA9zSCjfx5KuU1Z+n
         2WmJ7MEPjE4+WoCyRcfoF0GCoPH1LXOxlX0EvlFjEgBi30+EELe2APHR5g/ixvPpYZwg
         d/GA6a7lxKiSIU17VgL74T1mQriOaEMzgWtqvRfDehDZoQqZd0W+qh5gYq+lxotgOVw6
         WTuoVzLSTr72sR+K2mwyPWIcfzfhvnU8mPXhCyHKnLUcLlApNX9Z0TDs0C335udlqcNm
         tBwA==
X-Gm-Message-State: AOJu0Ywe2mXp4tZgLlQZQhffuWQdcn8N89rNgelvf5jyig1RmKEiiYRd
        DoC7litacMGS1jZj/AdBiRc=
X-Google-Smtp-Source: AGHT+IEQS+c5IhRpfmWeduPais44QF4qkKenzqWpssZ6zHdRe1JannrnYvlKxZx2VjwPiKthPB2STg==
X-Received: by 2002:a17:90a:53c7:b0:27d:63c:34f2 with SMTP id y65-20020a17090a53c700b0027d063c34f2mr21148621pjh.41.1699039152460;
        Fri, 03 Nov 2023 12:19:12 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:8234:4ed3:2635:c9d6])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090aca9100b0027cf4c554dasm1761349pjt.11.2023.11.03.12.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 12:19:12 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/5] perf annotate: Split struct cycles_info
Date:   Fri,  3 Nov 2023 12:19:03 -0700
Message-ID: <20231103191907.54531-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231103191907.54531-1-namhyung@kernel.org>
References: <20231103191907.54531-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cycles info is used only when branch stack is provided.  Split them
into a separate struct and lazy allocate them to save some memory.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/util/annotate.c        | 34 ++++++++++++++++++-------------
 tools/perf/util/annotate.h        | 14 ++++++++-----
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ccdb2cd11fbf..d2470f87344d 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -337,7 +337,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 				max_percent = percent;
 		}
 
-		if (max_percent < 0.01 && pos->al.ipc == 0) {
+		if (max_percent < 0.01 && (!pos->al.cycles || pos->al.cycles->ipc == 0)) {
 			RB_CLEAR_NODE(&pos->al.rb_node);
 			continue;
 		}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 82956adf9963..3e7f75827270 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1100,8 +1100,8 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 		for (offset = start; offset <= end; offset++) {
 			struct annotation_line *al = notes->offsets[offset];
 
-			if (al && al->ipc == 0.0) {
-				al->ipc = ipc;
+			if (al && al->cycles && al->cycles->ipc == 0.0) {
+				al->cycles->ipc = ipc;
 				cover_insn++;
 			}
 		}
@@ -1134,13 +1134,18 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 		if (ch && ch->cycles) {
 			struct annotation_line *al;
 
+			al = notes->offsets[offset];
+			if (al && al->cycles == NULL) {
+				al->cycles = zalloc(sizeof(*al->cycles));
+				if (al->cycles == NULL)
+					continue;
+			}
 			if (ch->have_start)
 				annotation__count_and_fill(notes, ch->start, offset, ch);
-			al = notes->offsets[offset];
 			if (al && ch->num_aggr) {
-				al->cycles = ch->cycles_aggr / ch->num_aggr;
-				al->cycles_max = ch->cycles_max;
-				al->cycles_min = ch->cycles_min;
+				al->cycles->avg = ch->cycles_aggr / ch->num_aggr;
+				al->cycles->max = ch->cycles_max;
+				al->cycles->min = ch->cycles_min;
 			}
 			notes->have_cycles = true;
 		}
@@ -1225,6 +1230,7 @@ static void annotation_line__exit(struct annotation_line *al)
 {
 	zfree_srcline(&al->path);
 	zfree(&al->line);
+	zfree(&al->cycles);
 }
 
 static size_t disasm_line_size(int nr)
@@ -3083,8 +3089,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 	int printed;
 
 	if (first_line && (al->offset == -1 || percent_max == 0.0)) {
-		if (notes->have_cycles) {
-			if (al->ipc == 0.0 && al->cycles == 0)
+		if (notes->have_cycles && al->cycles) {
+			if (al->cycles->ipc == 0.0 && al->cycles->avg == 0)
 				show_title = true;
 		} else
 			show_title = true;
@@ -3121,17 +3127,17 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 	}
 
 	if (notes->have_cycles) {
-		if (al->ipc)
-			obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->ipc);
+		if (al->cycles && al->cycles->ipc)
+			obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->cycles->ipc);
 		else if (!show_title)
 			obj__printf(obj, "%*s", ANNOTATION__IPC_WIDTH, " ");
 		else
 			obj__printf(obj, "%*s ", ANNOTATION__IPC_WIDTH - 1, "IPC");
 
 		if (!notes->options->show_minmax_cycle) {
-			if (al->cycles)
+			if (al->cycles && al->cycles->avg)
 				obj__printf(obj, "%*" PRIu64 " ",
-					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles);
+					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles->avg);
 			else if (!show_title)
 				obj__printf(obj, "%*s",
 					    ANNOTATION__CYCLES_WIDTH, " ");
@@ -3145,8 +3151,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 
 				scnprintf(str, sizeof(str),
 					"%" PRIu64 "(%" PRIu64 "/%" PRIu64 ")",
-					al->cycles, al->cycles_min,
-					al->cycles_max);
+					al->cycles->avg, al->cycles->min,
+					al->cycles->max);
 
 				obj__printf(obj, "%*s ",
 					    ANNOTATION__MINMAX_CYCLES_WIDTH - 1,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 962780559176..16d27952fd5c 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -130,6 +130,13 @@ struct annotation_data {
 	struct sym_hist_entry	 he;
 };
 
+struct cycles_info {
+	float			 ipc;
+	u64			 avg;
+	u64			 max;
+	u64			 min;
+};
+
 struct annotation_line {
 	struct list_head	 node;
 	struct rb_node		 rb_node;
@@ -137,12 +144,9 @@ struct annotation_line {
 	char			*line;
 	int			 line_nr;
 	char			*fileloc;
-	int			 jump_sources;
-	float			 ipc;
-	u64			 cycles;
-	u64			 cycles_max;
-	u64			 cycles_min;
 	char			*path;
+	struct cycles_info	*cycles;
+	int			 jump_sources;
 	u32			 idx;
 	int			 idx_asm;
 	int			 data_nr;
-- 
2.42.0.869.gea05f2083d-goog

