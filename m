Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D17FC269
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346770AbjK1RzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346689AbjK1Ryu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:50 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B491701;
        Tue, 28 Nov 2023 09:54:53 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b709048f32so5060046b3a.0;
        Tue, 28 Nov 2023 09:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701194093; x=1701798893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLcJCzhXuaN2nhcRyi2rd1XI/B+Sn9vFEIDeuEJk/Fk=;
        b=bkSDSw2D7vh6xp4HRqpA+pLo3YXi6tj0IbyjCvlyJkGY8I1N/18gXnVwbCi/QqZv5I
         iEQTFrzFwuvss8hJF92NUOR+TQQFqLkgh42+4sT4Dhfu22c+EGoNfQ2cF42NdtI7AKfw
         QICeTd64NhI0y8cVtbjauxwqdtIbwV6UB7yvHccx+nFR8VggRyo36oTlhIL3wJktIg6G
         AqiSF/JGFx9/k96SLY98S7AnOsv2+8dAMhwX3ncHx4NZZlLa1TQKETlcLkHZJAGVcX+Z
         g7STjBKL/Qe5QUf15oh46Mj5Z+TJTOade5vjHspUYRNa/xYd3UygM9b39bLq5ipIGF6p
         /2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194093; x=1701798893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLcJCzhXuaN2nhcRyi2rd1XI/B+Sn9vFEIDeuEJk/Fk=;
        b=Yfm9i0BWu7OQecz6x9VKTeaVSCkJAIWdcQ25w0hJw/+SPb/aAqNlcLQQFzzq2GXYq0
         zQL92ZXBRNS4A6DNjooGfqI7jlymPdpA4OK9Nqz7/gUJvTq4Wy3DVOzDJ3RsdJu6qI8b
         u8SfYIIb7TYwNGnqkz+CdrVQf9ReQfZPi+1Cx40X83+OyvEDvqtQQVLtPvafDqjqWef/
         ALohCmjjAiYIqygcGUxo5ElnYIlxrboI8WAVPOuD9PibkenZxiPR7K9aTnskg55GUF4Y
         EEzyZO7JzKGYme9b9wS3b48k/QeiPblJKhPxZyPwYrWEisz7QtsjkjK6mnL/bSqrm7nr
         1Skg==
X-Gm-Message-State: AOJu0YzdRW0T1NHF5lSl41xWrhxOOGT5GW7xUygXlZ1vXzO+3b5shBGg
        e2ZzdjxkOpS5OdX+BarA8v7AFVGmWu2gNA==
X-Google-Smtp-Source: AGHT+IFZVLWwBQGDEDpU7zdXM0xRiwnCeKpu9h0DCWce1ekgl0nwxX5Dr2h5zqB9vsTgHM1n2XI2/w==
X-Received: by 2002:a05:6a00:1813:b0:6be:43f8:4e0b with SMTP id y19-20020a056a00181300b006be43f84e0bmr16155476pfa.24.1701194093123;
        Tue, 28 Nov 2023 09:54:53 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:146f:6347:3bb4:8cf4])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78042000000b006cbbc07a1c0sm9224721pfm.156.2023.11.28.09.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:54:52 -0800 (PST)
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
Subject: [PATCH 4/8] perf annotate: Use global annotation_options
Date:   Tue, 28 Nov 2023 09:54:37 -0800
Message-ID: <20231128175441.721579-5-namhyung@kernel.org>
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

Now it can directly use the global options and no need to pass it as an
argument.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c     |   4 +-
 tools/perf/builtin-report.c       |   2 +-
 tools/perf/builtin-top.c          |   4 +-
 tools/perf/ui/browsers/annotate.c |   6 +-
 tools/perf/util/annotate.c        | 118 ++++++++++++++----------------
 tools/perf/util/annotate.h        |  15 ++--
 6 files changed, 68 insertions(+), 81 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 67b36a7a12e3..a53a4e711899 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -317,9 +317,9 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_annotate *ann)
 {
 	if (!ann->use_stdio2)
-		return symbol__tty_annotate(&he->ms, evsel, &annotate_opts);
+		return symbol__tty_annotate(&he->ms, evsel);
 
-	return symbol__tty_annotate2(&he->ms, evsel, &annotate_opts);
+	return symbol__tty_annotate2(&he->ms, evsel);
 }
 
 static void hists__find_annotations(struct hists *hists,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 90f98953587c..2b86651615cd 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -744,7 +744,7 @@ static int hists__resort_cb(struct hist_entry *he, void *arg)
 	if (rep->symbol_ipc && sym && !sym->annotate2) {
 		struct evsel *evsel = hists_to_evsel(he->hists);
 
-		symbol__annotate2(&he->ms, evsel, &annotate_opts, NULL);
+		symbol__annotate2(&he->ms, evsel, NULL);
 	}
 
 	return 0;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 52930b71f660..80d126279208 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -147,7 +147,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(&he->ms, evsel, &annotate_opts, NULL);
+	err = symbol__annotate(&he->ms, evsel, NULL);
 	if (err == 0) {
 		top->sym_filter_entry = he;
 	} else {
@@ -263,7 +263,7 @@ static void perf_top__show_details(struct perf_top *top)
 	printf("Showing %s for %s\n", evsel__name(top->sym_evsel), symbol->name);
 	printf("  Events  Pcnt (>=%d%%)\n", annotate_opts.min_pcnt);
 
-	more = symbol__annotate_printf(&he->ms, top->sym_evsel, &annotate_opts);
+	more = symbol__annotate_printf(&he->ms, top->sym_evsel);
 
 	if (top->evlist->enabled) {
 		if (top->zero)
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 163f916fff68..ed0e692afdbe 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -114,7 +114,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (!browser->navkeypressed)
 		ops.width += 1;
 
-	annotation_line__write(al, notes, &ops, ab->opts);
+	annotation_line__write(al, notes, &ops);
 
 	if (ops.current_entry)
 		ab->selection = al;
@@ -884,7 +884,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		}
 		case 'P':
-			map_symbol__annotation_dump(ms, evsel, browser->opts);
+			map_symbol__annotation_dump(ms, evsel);
 			continue;
 		case 't':
 			if (symbol_conf.show_total_period) {
@@ -979,7 +979,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 		return -1;
 
 	if (not_annotated) {
-		err = symbol__annotate2(ms, evsel, opts, &browser.arch);
+		err = symbol__annotate2(ms, evsel, &browser.arch);
 		if (err) {
 			char msg[BUFSIZ];
 			dso->annotate_warned = true;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 77b78001b94d..daff9af552f4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1896,7 +1896,6 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 				   struct annotate_args *args)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	struct annotation_options *opts = args->options;
 	struct bpf_prog_linfo *prog_linfo = NULL;
 	struct bpf_prog_info_node *info_node;
 	int len = sym->end - sym->start;
@@ -2006,7 +2005,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 		prev_buf_size = buf_size;
 		fflush(s);
 
-		if (!opts->hide_src_code && srcline) {
+		if (!annotate_opts.hide_src_code && srcline) {
 			args->offset = -1;
 			args->line = strdup(srcline);
 			args->line_nr = 0;
@@ -2129,7 +2128,7 @@ static char *expand_tabs(char *line, char **storage, size_t *storage_len)
 
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
-	struct annotation_options *opts = args->options;
+	struct annotation_options *opts = &annotate_opts;
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
 	char *command;
@@ -2380,13 +2379,13 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 }
 
 int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
-		     struct annotation_options *options, struct arch **parch)
+		     struct arch **parch)
 {
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
 		.evsel		= evsel,
-		.options	= options,
+		.options	= &annotate_opts,
 	};
 	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
@@ -2414,7 +2413,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	}
 
 	args.ms = *ms;
-	if (notes->options && notes->options->full_addr)
+	if (annotate_opts.full_addr)
 		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
 	else
 		notes->start = map__rip_2objdump(ms->map, ms->sym->start);
@@ -2422,12 +2421,12 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	return symbol__disassemble(sym, &args);
 }
 
-static void insert_source_line(struct rb_root *root, struct annotation_line *al,
-			       struct annotation_options *opts)
+static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 {
 	struct annotation_line *iter;
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
+	unsigned int percent_type = annotate_opts.percent_type;
 	int i, ret;
 
 	while (*p != NULL) {
@@ -2438,7 +2437,7 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al,
 		if (ret == 0) {
 			for (i = 0; i < al->data_nr; i++) {
 				iter->data[i].percent_sum += annotation_data__percent(&al->data[i],
-										      opts->percent_type);
+										      percent_type);
 			}
 			return;
 		}
@@ -2451,7 +2450,7 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al,
 
 	for (i = 0; i < al->data_nr; i++) {
 		al->data[i].percent_sum = annotation_data__percent(&al->data[i],
-								   opts->percent_type);
+								   percent_type);
 	}
 
 	rb_link_node(&al->rb_node, parent, p);
@@ -2573,8 +2572,7 @@ static int annotated_source__addr_fmt_width(struct list_head *lines, u64 start)
 	return 0;
 }
 
-int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
-			    struct annotation_options *opts)
+int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
 {
 	struct map *map = ms->map;
 	struct symbol *sym = ms->sym;
@@ -2585,6 +2583,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
 	struct annotation *notes = symbol__annotation(sym);
 	struct sym_hist *h = annotation__histogram(notes, evsel->core.idx);
 	struct annotation_line *pos, *queue = NULL;
+	struct annotation_options *opts = &annotate_opts;
 	u64 start = map__rip_2objdump(map, sym->start);
 	int printed = 2, queue_len = 0, addr_fmt_width;
 	int more = 0;
@@ -2713,8 +2712,7 @@ static void FILE__write_graph(void *fp, int graph)
 	fputs(s, fp);
 }
 
-static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
-				     struct annotation_options *opts)
+static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotation_write_ops wops = {
@@ -2731,7 +2729,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 	list_for_each_entry(al, &notes->src->source, node) {
 		if (annotation_line__filter(al, notes))
 			continue;
-		annotation_line__write(al, notes, &wops, opts);
+		annotation_line__write(al, notes, &wops);
 		fputc('\n', fp);
 		wops.first_line = false;
 	}
@@ -2739,8 +2737,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 	return 0;
 }
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
-				struct annotation_options *opts)
+int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel)
 {
 	const char *ev_name = evsel__name(evsel);
 	char buf[1024];
@@ -2762,7 +2759,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 
 	fprintf(fp, "%s() %s\nEvent: %s\n\n",
 		ms->sym->name, map__dso(ms->map)->long_name, ev_name);
-	symbol__annotate_fprintf2(ms->sym, fp, opts);
+	symbol__annotate_fprintf2(ms->sym, fp);
 
 	fclose(fp);
 	err = 0;
@@ -2939,24 +2936,24 @@ void annotation__init_column_widths(struct annotation *notes, struct symbol *sym
 
 void annotation__update_column_widths(struct annotation *notes)
 {
-	if (notes->options->use_offset)
+	if (annotate_opts.use_offset)
 		notes->widths.target = notes->widths.min_addr;
-	else if (notes->options->full_addr)
+	else if (annotate_opts.full_addr)
 		notes->widths.target = BITS_PER_LONG / 4;
 	else
 		notes->widths.target = notes->widths.max_addr;
 
 	notes->widths.addr = notes->widths.target;
 
-	if (notes->options->show_nr_jumps)
+	if (annotate_opts.show_nr_jumps)
 		notes->widths.addr += notes->widths.jumps + 1;
 }
 
 void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms)
 {
-	notes->options->full_addr = !notes->options->full_addr;
+	annotate_opts.full_addr = !annotate_opts.full_addr;
 
-	if (notes->options->full_addr)
+	if (annotate_opts.full_addr)
 		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
 	else
 		notes->start = map__rip_2objdump(ms->map, ms->sym->start);
@@ -2965,8 +2962,7 @@ void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *m
 }
 
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
-				   struct rb_root *root,
-				   struct annotation_options *opts)
+				   struct rb_root *root)
 {
 	struct annotation_line *al;
 	struct rb_root tmp_root = RB_ROOT;
@@ -2979,7 +2975,7 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 			double percent;
 
 			percent = annotation_data__percent(&al->data[i],
-							   opts->percent_type);
+							   annotate_opts.percent_type);
 
 			if (percent > percent_max)
 				percent_max = percent;
@@ -2990,22 +2986,20 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 
 		al->path = get_srcline(map__dso(map), notes->start + al->offset, NULL,
 				       false, true, notes->start + al->offset);
-		insert_source_line(&tmp_root, al, opts);
+		insert_source_line(&tmp_root, al);
 	}
 
 	resort_source_line(root, &tmp_root);
 }
 
-static void symbol__calc_lines(struct map_symbol *ms, struct rb_root *root,
-			       struct annotation_options *opts)
+static void symbol__calc_lines(struct map_symbol *ms, struct rb_root *root)
 {
 	struct annotation *notes = symbol__annotation(ms->sym);
 
-	annotation__calc_lines(notes, ms->map, root, opts);
+	annotation__calc_lines(notes, ms->map, root);
 }
 
-int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
-			  struct annotation_options *opts)
+int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel)
 {
 	struct dso *dso = map__dso(ms->map);
 	struct symbol *sym = ms->sym;
@@ -3014,7 +3008,7 @@ int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
 	char buf[1024];
 	int err;
 
-	err = symbol__annotate2(ms, evsel, opts, NULL);
+	err = symbol__annotate2(ms, evsel, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 
@@ -3024,31 +3018,31 @@ int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
 		return -1;
 	}
 
-	if (opts->print_lines) {
-		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(ms, &source_line, opts);
+	if (annotate_opts.print_lines) {
+		srcline_full_filename = annotate_opts.full_path;
+		symbol__calc_lines(ms, &source_line);
 		print_summary(&source_line, dso->long_name);
 	}
 
 	hists__scnprintf_title(hists, buf, sizeof(buf));
 	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
-		buf, percent_type_str(opts->percent_type), sym->name, dso->long_name);
-	symbol__annotate_fprintf2(sym, stdout, opts);
+		buf, percent_type_str(annotate_opts.percent_type), sym->name,
+		dso->long_name);
+	symbol__annotate_fprintf2(sym, stdout);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
 	return 0;
 }
 
-int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
-			 struct annotation_options *opts)
+int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel)
 {
 	struct dso *dso = map__dso(ms->map);
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 	int err;
 
-	err = symbol__annotate(ms, evsel, opts, NULL);
+	err = symbol__annotate(ms, evsel, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 
@@ -3060,13 +3054,13 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 	symbol__calc_percent(sym, evsel);
 
-	if (opts->print_lines) {
-		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(ms, &source_line, opts);
+	if (annotate_opts.print_lines) {
+		srcline_full_filename = annotate_opts.full_path;
+		symbol__calc_lines(ms, &source_line);
 		print_summary(&source_line, dso->long_name);
 	}
 
-	symbol__annotate_printf(ms, evsel, opts);
+	symbol__annotate_printf(ms, evsel);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
@@ -3127,7 +3121,7 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 		obj__printf(obj, "  ");
 	}
 
-	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset, notes->widths.max_ins_name);
+	disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset, notes->widths.max_ins_name);
 }
 
 static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
@@ -3210,7 +3204,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		else
 			obj__printf(obj, "%*s ", ANNOTATION__IPC_WIDTH - 1, "IPC");
 
-		if (!notes->options->show_minmax_cycle) {
+		if (!annotate_opts.show_minmax_cycle) {
 			if (al->cycles && al->cycles->avg)
 				obj__printf(obj, "%*" PRIu64 " ",
 					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles->avg);
@@ -3254,7 +3248,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 	if (!*al->line)
 		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width, " ");
 	else if (al->offset == -1) {
-		if (al->line_nr && notes->options->show_linenr)
+		if (al->line_nr && annotate_opts.show_linenr)
 			printed = scnprintf(bf, sizeof(bf), "%-*d ", notes->widths.addr + 1, al->line_nr);
 		else
 			printed = scnprintf(bf, sizeof(bf), "%-*s  ", notes->widths.addr, " ");
@@ -3264,15 +3258,15 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		u64 addr = al->offset;
 		int color = -1;
 
-		if (!notes->options->use_offset)
+		if (!annotate_opts.use_offset)
 			addr += notes->start;
 
-		if (!notes->options->use_offset) {
+		if (!annotate_opts.use_offset) {
 			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
 		} else {
 			if (al->jump_sources &&
-			    notes->options->offset_level >= ANNOTATION__OFFSET_JUMP_TARGETS) {
-				if (notes->options->show_nr_jumps) {
+			    annotate_opts.offset_level >= ANNOTATION__OFFSET_JUMP_TARGETS) {
+				if (annotate_opts.show_nr_jumps) {
 					int prev;
 					printed = scnprintf(bf, sizeof(bf), "%*d ",
 							    notes->widths.jumps,
@@ -3286,9 +3280,9 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 				printed = scnprintf(bf, sizeof(bf), "%*" PRIx64 ": ",
 						    notes->widths.target, addr);
 			} else if (ins__is_call(&disasm_line(al)->ins) &&
-				   notes->options->offset_level >= ANNOTATION__OFFSET_CALL) {
+				   annotate_opts.offset_level >= ANNOTATION__OFFSET_CALL) {
 				goto print_addr;
-			} else if (notes->options->offset_level == ANNOTATION__MAX_OFFSET_LEVEL) {
+			} else if (annotate_opts.offset_level == ANNOTATION__MAX_OFFSET_LEVEL) {
 				goto print_addr;
 			} else {
 				printed = scnprintf(bf, sizeof(bf), "%-*s  ",
@@ -3310,19 +3304,18 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 }
 
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *wops,
-			    struct annotation_options *opts)
+			    struct annotation_write_ops *wops)
 {
 	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
 				 wops->change_color, wops->width, wops->obj,
-				 opts->percent_type,
+				 annotate_opts.percent_type,
 				 wops->set_color, wops->set_percent_color,
 				 wops->set_jumps_percent_color, wops->printf,
 				 wops->write_graph);
 }
 
 int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
-		      struct annotation_options *options, struct arch **parch)
+		      struct arch **parch)
 {
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
@@ -3336,11 +3329,11 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	if (evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
 
-	err = symbol__annotate(ms, evsel, options, parch);
+	err = symbol__annotate(ms, evsel, parch);
 	if (err)
 		goto out_free_offsets;
 
-	notes->options = options;
+	notes->options = &annotate_opts;
 
 	symbol__calc_percent(sym, evsel);
 
@@ -3468,10 +3461,9 @@ static unsigned int parse_percent_type(char *str1, char *str2)
 	return type;
 }
 
-int annotate_parse_percent_type(const struct option *opt, const char *_str,
+int annotate_parse_percent_type(const struct option *opt __maybe_unused, const char *_str,
 				int unset __maybe_unused)
 {
-	struct annotation_options *opts = opt->value;
 	unsigned int type;
 	char *str1, *str2;
 	int err = -1;
@@ -3490,7 +3482,7 @@ int annotate_parse_percent_type(const struct option *opt, const char *_str,
 	if (type == (unsigned int) -1)
 		type = parse_percent_type(str2, str1);
 	if (type != (unsigned int) -1) {
-		opts->percent_type = type;
+		annotate_opts.percent_type = type;
 		err = 0;
 	}
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 8c1a070725fa..7bf29baa43f5 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -224,8 +224,7 @@ struct annotation_write_ops {
 };
 
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *ops,
-			    struct annotation_options *opts);
+			    struct annotation_write_ops *ops);
 
 int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   char *bf, size_t size,
@@ -375,11 +374,9 @@ void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct map_symbol *ms,
 		     struct evsel *evsel,
-		     struct annotation_options *options,
 		     struct arch **parch);
 int symbol__annotate2(struct map_symbol *ms,
 		      struct evsel *evsel,
-		      struct annotation_options *options,
 		      struct arch **parch);
 
 enum symbol_disassemble_errno {
@@ -406,20 +403,18 @@ enum symbol_disassemble_errno {
 
 int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen);
 
-int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
-			    struct annotation_options *options);
+int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
 void annotated_source__purge(struct annotated_source *as);
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
-				struct annotation_options *opts);
+int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel);
 
 bool ui__has_annotation(void);
 
-int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel, struct annotation_options *opts);
+int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel);
 
-int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel, struct annotation_options *opts);
+int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel);
 
 #ifdef HAVE_SLANG_SUPPORT
 int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
-- 
2.43.0.rc1.413.gea7ed67945-goog

