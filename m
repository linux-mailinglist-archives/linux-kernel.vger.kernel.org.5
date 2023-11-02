Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A787A7DFC61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377520AbjKBW1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377503AbjKBW1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:27:03 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BDDDC;
        Thu,  2 Nov 2023 15:27:00 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5b9a7357553so1177946a12.0;
        Thu, 02 Nov 2023 15:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698964020; x=1699568820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfeDJJAakAHGSmerBO7TwpTzcsIOcntyODz+PgBSHd0=;
        b=bY7wOe5yL0wwM16bJryT8fNXF/IGkTKfYUhpNQTfjwlwR9KwyheRZ3A06Up2/OTzou
         XDb4Q6FpXVeMFe0TP30JX9DLPXvunqqT0gz3vsJoBlfi29Heg31EdMM1+4EWHy0yRBwt
         EkataOAPqWPyEXZxyE3dboCzxk4RnZBU7EQD5XLZZeON7mK2cdQZd0yRsaPZwTzVR4o2
         Pm0cBtb/hcpr80JsG0u3MH692jS6pjwGPyfMpcXsRoECzALy89nN3kx+Ij4+QjrFPx0+
         9DdrQkrOFcgZTdniYUIbuQ5b4KDFrbqy37adK7BPBkshpETJwMYxx/iahiBe1z+B4Cll
         tbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698964020; x=1699568820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfeDJJAakAHGSmerBO7TwpTzcsIOcntyODz+PgBSHd0=;
        b=ldR3m3dPwn5cPP3rWhF/yiTOftU4qaSkfNW4t3XaS37vO4lASxvFlaTYWprc5FRaoP
         0HjLqirDzvG5EyzPLuxXJgHNvWirDxz42YQivPybVBYQaon0wmcZkbwzzGnAuW5aJWOd
         GEFrXD8EmW5GgojmCZrWL/bTB3unJx4FJKniA0emtQgLTXnck5weRbTeLg8vhwaeOSFp
         9h2HAIRhR8DY6D64r7BTidwrOi7hWGfFhDRusvXU2krY6ko4SEhf3lEPt7pbExpeCg5N
         HDAAj0raAH5h7y/8TvJLnpAEptshAQT3oStTPQB2NaQknQ6kdMeKegwh0WYtTpHZHCjn
         qDaQ==
X-Gm-Message-State: AOJu0Yw6dqBoBc6FD3rBnBnIgi48s4+6Jg/cyQb6o8YR6Ju0CC3j4dKb
        KCPQlhao3dg2UFW9gsI5LV4=
X-Google-Smtp-Source: AGHT+IGlA2OWaBEc278r3jXh2zxFzgpf7r9zPwwtr2tln8+9VT7rwZutZHOLKD06gUU/+/eMACFQbA==
X-Received: by 2002:a17:90a:3c86:b0:27c:fb84:101a with SMTP id g6-20020a17090a3c8600b0027cfb84101amr18099517pjc.29.1698964019924;
        Thu, 02 Nov 2023 15:26:59 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:ea22:bed1:d67b:af04])
        by smtp.gmail.com with ESMTPSA id cn18-20020a17090af09200b0027d015c365csm309894pjb.31.2023.11.02.15.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:26:59 -0700 (PDT)
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
Subject: [PATCH 4/5] perf annotate: Move some fields to annotated_source
Date:   Thu,  2 Nov 2023 15:26:52 -0700
Message-ID: <20231102222653.4165959-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231102222653.4165959-1-namhyung@kernel.org>
References: <20231102222653.4165959-1-namhyung@kernel.org>
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
index d8a221591926..c51ceb857bd6 100644
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
+	int    			nr_histograms;
+	size_t			sizeof_sym_hist;
+	struct sym_hist		*histograms;
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

