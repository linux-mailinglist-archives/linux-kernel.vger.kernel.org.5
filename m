Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221C57FC1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbjK1RzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346548AbjK1Ryy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:54 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276F219AF;
        Tue, 28 Nov 2023 09:54:57 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cbbfdf72ecso5613944b3a.2;
        Tue, 28 Nov 2023 09:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701194096; x=1701798896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iYIWM/UlXRZlCA9cVhrbUV4rTFxAX3Gi8pVoWWkJAs=;
        b=P9e1GFazP7HOJj2+u4xiyhFqbgLhOw556xxawcQ2Cky9YiiDJbkRYaccO/QDp4K2Nj
         Tbzl9vX/Zv8Xrh9sh/MR4vtRB2vl6tFRVJZvh8vR1y/1KiBWAwxXU21Q1NoBap7pxnqM
         Ap2QS576yL2KGSc8eYP5wlJ5Y9ffeQfhZuV7V/KB68qrMQ6yhvF+kpXKmSBtK1qgcuv2
         z2ywu0etbUyUy/H0K9r0Icd4dfvBNGJ0TNfRmTv2iUOMuS2C9sDTEoQ6cg6e82wSX7pa
         U0AeZnqg5pleY78CA0/AU1IOkhBiaDupJgcnbA9xBmB+Gt/r40/Av7HqPx0cV5Uhf52P
         eRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194096; x=1701798896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8iYIWM/UlXRZlCA9cVhrbUV4rTFxAX3Gi8pVoWWkJAs=;
        b=h1U33TjRQbCyO+uxZzU3J7LCtET/e+C8eLErLr25c9GCXQgAEeEJjmMUcL6TD6QbR1
         1uKafAHi+1wPDTTVbKjTtqxGAtUIaJD4ZV6UeT4x+nbacN46fxnEZh1HGLy/ec+f8b1t
         jh3Gsg0ty1UetXWOr7jb9ETvoW6+lodzp7jO51NkKcuJod9ukn7Cu+opRCsMiGJ3nwz+
         wOFsf7Xnab/wCDVhv63kYIrxB3Kh2Zpl2xqXZvsc89/nH80jyo/6f78d0nFqkReMo1NE
         KcoVfF8K41mEb3Yv1xLHbtJcgk/2Jw07n9YrjKmLUpfCKq8Vc9ULRm/grXvsShC8vikU
         9kEA==
X-Gm-Message-State: AOJu0YwTB+s8YvoFYs1pRcoYpfUQ9eqLxhDAhWPaEdwwhWKoYu7QARKh
        HN4E3pZ0Q6UXOR2cehQ/Q9Q=
X-Google-Smtp-Source: AGHT+IFQUyfDSSmtChELxiWjF83ghOLLknw1c7bMS3vSZTNdjP7kut10gjiE6dROg8NZLn50FQZaiA==
X-Received: by 2002:a05:6a21:150b:b0:148:f952:552b with SMTP id nq11-20020a056a21150b00b00148f952552bmr22714469pzb.51.1701194096494;
        Tue, 28 Nov 2023 09:54:56 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:146f:6347:3bb4:8cf4])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78042000000b006cbbc07a1c0sm9224721pfm.156.2023.11.28.09.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:54:56 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 7/8] perf annotate: Remove remaining usages of local annotation options
Date:   Tue, 28 Nov 2023 09:54:40 -0800
Message-ID: <20231128175441.721579-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231128175441.721579-1-namhyung@kernel.org>
References: <20231128175441.721579-1-namhyung@kernel.org>
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

So that it can get rid of the unused data.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 14 ++++++--------
 tools/perf/util/annotate.c        |  2 +-
 tools/perf/util/annotate.h        |  6 +++---
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index fda17c1f2031..cb2eb6dcb532 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -37,11 +37,10 @@ static inline struct annotation *browser__annotation(struct ui_browser *browser)
 	return symbol__annotation(ms->sym);
 }
 
-static bool disasm_line__filter(struct ui_browser *browser, void *entry)
+static bool disasm_line__filter(struct ui_browser *browser __maybe_unused, void *entry)
 {
-	struct annotation *notes = browser__annotation(browser);
 	struct annotation_line *al = list_entry(entry, struct annotation_line, node);
-	return annotation_line__filter(al, notes);
+	return annotation_line__filter(al);
 }
 
 static int ui_browser__jumps_percent_color(struct ui_browser *browser, int nr, bool current)
@@ -269,7 +268,6 @@ static void disasm_rb_tree__insert(struct annotate_browser *browser,
 static void annotate_browser__set_top(struct annotate_browser *browser,
 				      struct annotation_line *pos, u32 idx)
 {
-	struct annotation *notes = browser__annotation(&browser->b);
 	unsigned back;
 
 	ui_browser__refresh_dimensions(&browser->b);
@@ -279,7 +277,7 @@ static void annotate_browser__set_top(struct annotate_browser *browser,
 	while (browser->b.top_idx != 0 && back != 0) {
 		pos = list_entry(pos->node.prev, struct annotation_line, node);
 
-		if (annotation_line__filter(pos, notes))
+		if (annotation_line__filter(pos))
 			continue;
 
 		--browser->b.top_idx;
@@ -498,7 +496,7 @@ struct disasm_line *annotate_browser__find_offset(struct annotate_browser *brows
 	list_for_each_entry(pos, &notes->src->source, al.node) {
 		if (pos->al.offset == offset)
 			return pos;
-		if (!annotation_line__filter(&pos->al, notes))
+		if (!annotation_line__filter(&pos->al))
 			++*idx;
 	}
 
@@ -542,7 +540,7 @@ struct annotation_line *annotate_browser__find_string(struct annotate_browser *b
 
 	*idx = browser->b.index;
 	list_for_each_entry_continue(al, &notes->src->source, node) {
-		if (annotation_line__filter(al, notes))
+		if (annotation_line__filter(al))
 			continue;
 
 		++*idx;
@@ -579,7 +577,7 @@ struct annotation_line *annotate_browser__find_string_reverse(struct annotate_br
 
 	*idx = browser->b.index;
 	list_for_each_entry_continue_reverse(al, &notes->src->source, node) {
-		if (annotation_line__filter(al, notes))
+		if (annotation_line__filter(al))
 			continue;
 
 		--*idx;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 626ff3baeb85..09c399ab0384 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2727,7 +2727,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 	struct annotation_line *al;
 
 	list_for_each_entry(al, &notes->src->source, node) {
-		if (annotation_line__filter(al, notes))
+		if (annotation_line__filter(al))
 			continue;
 		annotation_line__write(al, notes, &wops);
 		fputc('\n', fp);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 4283eb4522b2..6d5a6bb49a97 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -320,7 +320,7 @@ bool annotation__trylock(struct annotation *notes) EXCLUSIVE_TRYLOCK_FUNCTION(tr
 
 static inline int annotation__cycles_width(struct annotation *notes)
 {
-	if (notes->branch && notes->options->show_minmax_cycle)
+	if (notes->branch && annotate_opts.show_minmax_cycle)
 		return ANNOTATION__IPC_WIDTH + ANNOTATION__MINMAX_CYCLES_WIDTH;
 
 	return notes->branch ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
@@ -331,9 +331,9 @@ static inline int annotation__pcnt_width(struct annotation *notes)
 	return (symbol_conf.show_total_period ? 12 : 7) * notes->nr_events;
 }
 
-static inline bool annotation_line__filter(struct annotation_line *al, struct annotation *notes)
+static inline bool annotation_line__filter(struct annotation_line *al)
 {
-	return notes->options->hide_src_code && al->offset == -1;
+	return annotate_opts.hide_src_code && al->offset == -1;
 }
 
 void annotation__set_offsets(struct annotation *notes, s64 size);
-- 
2.43.0.rc1.413.gea7ed67945-goog

