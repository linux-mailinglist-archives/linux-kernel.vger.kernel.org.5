Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F007E095B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377743AbjKCTTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377769AbjKCTTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:19:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5BCD67;
        Fri,  3 Nov 2023 12:19:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-280351c32afso2252119a91.1;
        Fri, 03 Nov 2023 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699039158; x=1699643958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK7/Vu7YH8dZxR5x2CkJTVBZe4LUtXaxIieL0X9K9+w=;
        b=OUVIj6nutYLvkTNbu/HiCVV59r2nyqy9PwZZGAR+Oevagbe6yOo13pvId/mM9ppaah
         4G46XqE3SIfjbo8sXhnoYRGZ/d1otp/W4oc58n17Lhlw3dr2ay4TGNcpzw8LreM/5KH6
         LnfeymqyKK52qSBc4tj1ysBMLK1LyZG3NpLdIeZJU6ntkaSHPLQCe7DodL9793HNdNwF
         fCogd2zB4+h0qKoeb2hLoESRylDMto8TAdGSlROawvtRO5+KGwg28acEGI+XcsvO/0+j
         MrOcCXe/SeLDcpvE5ZSgA0AKcGOf/nO1GqayGdijV8vlfEdEUaJsxel1Zjb/0rzYv1FU
         ltcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699039158; x=1699643958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rK7/Vu7YH8dZxR5x2CkJTVBZe4LUtXaxIieL0X9K9+w=;
        b=MMfTko1HdB6feTD27fE5NYyOTuLvzImlhqFS3tFPD+YKK0TxE2rreoTK6sPlbkKDxR
         H/pB5xP9uEH8rPuz405c24ls95XrSDOTCWfZnuNsVB8VkIS7YvEJ01DgX1uLWH/7Oidi
         Gy4IyO4KgWzgZzlamjRZH8LOINbn1hCoEQQqG5qvrIeZsdfLZ2NGofwVztTBbuFoEyYy
         sNUICyLrGV0M0GelFiAf2QCl5ICm0ElaK7lO11b0qda6SfVCJdC9AudN87uAAPXHj5KK
         qe7S+Ke8H9ayPa0CDuytcHVxJSIulIU/+aem5joVD3t9EoMQxO2s/3yecEJms2+FOb0W
         RNwA==
X-Gm-Message-State: AOJu0Yxs2sbpNIL9dSJcxaJ/pMT9PFkGZmbsM7CwX1w3aTwV2YfgSU6H
        yxOPONT5dQq0jDX/ElOaHjw=
X-Google-Smtp-Source: AGHT+IH8AEftuzhnRZq6j8WASpQ5uF86n3+LgN7ATj0vN3yrfJWEQxf5B9O7Lu2uonOZPCiS6vbcaA==
X-Received: by 2002:a17:90b:111:b0:27d:97e5:f3fa with SMTP id p17-20020a17090b011100b0027d97e5f3famr20695564pjz.29.1699039157504;
        Fri, 03 Nov 2023 12:19:17 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:8234:4ed3:2635:c9d6])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090aca9100b0027cf4c554dasm1761349pjt.11.2023.11.03.12.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 12:19:17 -0700 (PDT)
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
Subject: [PATCH 4/5] perf annotate: Move some fields to annotated_source
Date:   Fri,  3 Nov 2023 12:19:06 -0700
Message-ID: <20231103191907.54531-5-namhyung@kernel.org>
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

Some fields in the struct annotation are only used with annotated_source
so better to be moved there in order to reduce memory consumption for
other symbols.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 12 ++++++------
 tools/perf/util/annotate.c        | 17 +++++++++--------
 tools/perf/util/annotate.h        | 14 +++++++-------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d2470f87344d..1b42db70c998 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -384,7 +384,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 		if (al->idx_asm < offset)
 			offset = al->idx;
 
-		browser->b.nr_entries = notes->nr_entries;
+		browser->b.nr_entries = notes->src->nr_entries;
 		notes->options->hide_src_code = false;
 		browser->b.seek(&browser->b, -offset, SEEK_CUR);
 		browser->b.top_idx = al->idx - offset;
@@ -402,7 +402,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 		if (al->idx_asm < offset)
 			offset = al->idx_asm;
 
-		browser->b.nr_entries = notes->nr_asm_entries;
+		browser->b.nr_entries = notes->src->nr_asm_entries;
 		notes->options->hide_src_code = true;
 		browser->b.seek(&browser->b, -offset, SEEK_CUR);
 		browser->b.top_idx = al->idx_asm - offset;
@@ -435,7 +435,7 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
 {
 	struct annotation *notes = browser__annotation(browser);
 	ui_browser__reset_index(browser);
-	browser->nr_entries = notes->nr_asm_entries;
+	browser->nr_entries = notes->src->nr_asm_entries;
 }
 
 static int sym_title(struct symbol *sym, struct map *map, char *title,
@@ -860,7 +860,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 					   browser->b.height,
 					   browser->b.index,
 					   browser->b.top_idx,
-					   notes->nr_asm_entries);
+					   notes->src->nr_asm_entries);
 		}
 			continue;
 		case K_ENTER:
@@ -991,8 +991,8 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 	ui_helpline__push("Press ESC to exit");
 
-	browser.b.width = notes->max_line_len;
-	browser.b.nr_entries = notes->nr_entries;
+	browser.b.width = notes->src->max_line_len;
+	browser.b.nr_entries = notes->src->nr_entries;
 	browser.b.entries = &notes->src->source,
 	browser.b.width += 18; /* Percentage */
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 92a9adf9d5eb..ee7b8e1848a8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2808,19 +2808,20 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 void annotation__set_offsets(struct annotation *notes, s64 size)
 {
 	struct annotation_line *al;
+	struct annotated_source *src = notes->src;
 
-	notes->max_line_len = 0;
-	notes->nr_entries = 0;
-	notes->nr_asm_entries = 0;
+	src->max_line_len = 0;
+	src->nr_entries = 0;
+	src->nr_asm_entries = 0;
 
-	list_for_each_entry(al, &notes->src->source, node) {
+	list_for_each_entry(al, &src->source, node) {
 		size_t line_len = strlen(al->line);
 
-		if (notes->max_line_len < line_len)
-			notes->max_line_len = line_len;
-		al->idx = notes->nr_entries++;
+		if (src->max_line_len < line_len)
+			src->max_line_len = line_len;
+		al->idx = src->nr_entries++;
 		if (al->offset != -1) {
-			al->idx_asm = notes->nr_asm_entries++;
+			al->idx_asm = src->nr_asm_entries++;
 			/*
 			 * FIXME: short term bandaid to cope with assembly
 			 * routines that comes with labels in the same column
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d8a221591926..022fa7ea0f22 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -268,10 +268,13 @@ struct cyc_hist {
  * returns.
  */
 struct annotated_source {
-	struct list_head   source;
-	int    		   nr_histograms;
-	size_t		   sizeof_sym_hist;
-	struct sym_hist	   *histograms;
+	struct list_head	source;
+	size_t			sizeof_sym_hist;
+	struct sym_hist		*histograms;
+	int    			nr_histograms;
+	int			nr_entries;
+	int			nr_asm_entries;
+	u16			max_line_len;
 };
 
 struct annotated_branch {
@@ -289,9 +292,6 @@ struct LOCKABLE annotation {
 	struct annotation_line	**offsets;
 	int			nr_events;
 	int			max_jump_sources;
-	int			nr_entries;
-	int			nr_asm_entries;
-	u16			max_line_len;
 	struct {
 		u8		addr;
 		u8		jumps;
-- 
2.42.0.869.gea05f2083d-goog

