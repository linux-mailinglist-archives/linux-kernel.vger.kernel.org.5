Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FD47FC29E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346552AbjK1Ry6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346536AbjK1Rys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:48 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB344C1;
        Tue, 28 Nov 2023 09:54:52 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso4618182b3a.1;
        Tue, 28 Nov 2023 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701194092; x=1701798892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbDETm39yPy9ivdCrv9tT3TumYyyvc8Q6J6bGbZ/1k4=;
        b=PXNebXA8/+y54edZaxEEsr5VweE4i6v4VX/XbCuCWfYztUrynSyIXDTo4DNGO/yhEX
         AQNCU0rYecqo10MlVgSl7cXOeOsXc0j4B/19HjUFoOq4XCAoAQ8a02R48wv2CQOjYlvb
         7npBLXXg9KtYvcYhjrhU2bdtki8LQZ37o1fm7ol10FpBgJFLvau62qLMRhCKRf4Cfeos
         FKSf9TbHCmP9U8DoGUbBoYpYySBhRmkjPHpkPX2pZL1rBkPq009eZbSNxA3wcbyovoaC
         QtGJu8HrZPe6TtS66y5SqSn/WUqniyu9HovtssXNJbbIr9Hk5VISUHCvC49AwgFOEqcz
         /2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194092; x=1701798892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbDETm39yPy9ivdCrv9tT3TumYyyvc8Q6J6bGbZ/1k4=;
        b=mNfAjc/EK1SWiaitepkUY78W2s+w6Ye0mkGXNd1mbfPycEjkozCyikJ69YAvmgkr3t
         mW6Pp+U6XpdBUVw5AmLu9Dme+DxngdJg1zP5D/tm8uSMQ9+SHZ1Ba1K02fS2xlqOgV7G
         Go9+FN1IoaPm3eH+Lg9F6gt3uwvwqhWfvuwSLlaId5a1DfX79AVWMXmwkegAV7Cmibbg
         /uz9qVSwGgGUhIb6+umBl4N2HdGTv1MLyHMexm7ppqih4U1PzgnTkDr7mYW5bJsf7/2e
         Z0rJLwI6F9ftZhFd4VzqI87dt8bFX3D/ROzuJX0bAhQqnqtXj5gT1zErPvPYcMREUs7o
         YWww==
X-Gm-Message-State: AOJu0YwPfZM/zhmfhlGfZOQNVJ8SSoyGeBZ15mX3Ifcp2e6On7ByFbID
        HIcp5ivfOBoZbHr6Rvc4FBg=
X-Google-Smtp-Source: AGHT+IG6wGV3EC6RdwUsd6baJFAEqm1nrCcUmWajJM/3xxfNInQxiSOkvmcfw3Y8BAJ+kMI8qvKUZA==
X-Received: by 2002:a05:6a20:2451:b0:18b:90fc:c266 with SMTP id t17-20020a056a20245100b0018b90fcc266mr18394510pzc.38.1701194091890;
        Tue, 28 Nov 2023 09:54:51 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:146f:6347:3bb4:8cf4])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78042000000b006cbbc07a1c0sm9224721pfm.156.2023.11.28.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:54:51 -0800 (PST)
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
Subject: [PATCH 3/8] perf top: Convert to the global annotation_options
Date:   Tue, 28 Nov 2023 09:54:36 -0800
Message-ID: <20231128175441.721579-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231128175441.721579-1-namhyung@kernel.org>
References: <20231128175441.721579-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the global option and drop the local copy.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-top.c | 44 ++++++++++++++++++++--------------------
 tools/perf/util/top.h    |  1 -
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ea8c7eca5eee..52930b71f660 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -147,7 +147,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(&he->ms, evsel, &top->annotation_opts, NULL);
+	err = symbol__annotate(&he->ms, evsel, &annotate_opts, NULL);
 	if (err == 0) {
 		top->sym_filter_entry = he;
 	} else {
@@ -261,9 +261,9 @@ static void perf_top__show_details(struct perf_top *top)
 		goto out_unlock;
 
 	printf("Showing %s for %s\n", evsel__name(top->sym_evsel), symbol->name);
-	printf("  Events  Pcnt (>=%d%%)\n", top->annotation_opts.min_pcnt);
+	printf("  Events  Pcnt (>=%d%%)\n", annotate_opts.min_pcnt);
 
-	more = symbol__annotate_printf(&he->ms, top->sym_evsel, &top->annotation_opts);
+	more = symbol__annotate_printf(&he->ms, top->sym_evsel, &annotate_opts);
 
 	if (top->evlist->enabled) {
 		if (top->zero)
@@ -450,7 +450,7 @@ static void perf_top__print_mapped_keys(struct perf_top *top)
 
 	fprintf(stdout, "\t[f]     profile display filter (count).    \t(%d)\n", top->count_filter);
 
-	fprintf(stdout, "\t[F]     annotate display filter (percent). \t(%d%%)\n", top->annotation_opts.min_pcnt);
+	fprintf(stdout, "\t[F]     annotate display filter (percent). \t(%d%%)\n", annotate_opts.min_pcnt);
 	fprintf(stdout, "\t[s]     annotate symbol.                   \t(%s)\n", name?: "NULL");
 	fprintf(stdout, "\t[S]     stop annotation.\n");
 
@@ -553,7 +553,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 			prompt_integer(&top->count_filter, "Enter display event count filter");
 			break;
 		case 'F':
-			prompt_percent(&top->annotation_opts.min_pcnt,
+			prompt_percent(&annotate_opts.min_pcnt,
 				       "Enter details display event filter (percent)");
 			break;
 		case 'K':
@@ -647,7 +647,7 @@ static void *display_thread_tui(void *arg)
 
 	ret = evlist__tui_browse_hists(top->evlist, help, &hbt, top->min_percent,
 				       &top->session->header.env, !top->record_opts.overwrite,
-				       &top->annotation_opts);
+				       &annotate_opts);
 	if (ret == K_RELOAD) {
 		top->zero = true;
 		goto repeat;
@@ -1241,9 +1241,9 @@ static int __cmd_top(struct perf_top *top)
 	pthread_t thread, thread_process;
 	int ret;
 
-	if (!top->annotation_opts.objdump_path) {
+	if (!annotate_opts.objdump_path) {
 		ret = perf_env__lookup_objdump(&top->session->header.env,
-					       &top->annotation_opts.objdump_path);
+					       &annotate_opts.objdump_path);
 		if (ret)
 			return ret;
 	}
@@ -1536,9 +1536,9 @@ int cmd_top(int argc, const char **argv)
 		   "only consider symbols in these comms"),
 	OPT_STRING(0, "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
 		   "only consider these symbols"),
-	OPT_BOOLEAN(0, "source", &top.annotation_opts.annotate_src,
+	OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &top.annotation_opts.show_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &annotate_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
@@ -1549,9 +1549,9 @@ int cmd_top(int argc, const char **argv)
 		   "addr2line binary to use for line numbers"),
 	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
-	OPT_STRING(0, "prefix", &top.annotation_opts.prefix, "prefix",
+	OPT_STRING(0, "prefix", &annotate_opts.prefix, "prefix",
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
-	OPT_STRING(0, "prefix-strip", &top.annotation_opts.prefix_strip, "N",
+	OPT_STRING(0, "prefix-strip", &annotate_opts.prefix_strip, "N",
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
 	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
@@ -1609,10 +1609,10 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		return status;
 
-	annotation_options__init(&top.annotation_opts);
+	annotation_options__init(&annotate_opts);
 
-	top.annotation_opts.min_pcnt = 5;
-	top.annotation_opts.context  = 4;
+	annotate_opts.min_pcnt = 5;
+	annotate_opts.context  = 4;
 
 	top.evlist = evlist__new();
 	if (top.evlist == NULL)
@@ -1642,13 +1642,13 @@ int cmd_top(int argc, const char **argv)
 		usage_with_options(top_usage, options);
 
 	if (disassembler_style) {
-		top.annotation_opts.disassembler_style = strdup(disassembler_style);
-		if (!top.annotation_opts.disassembler_style)
+		annotate_opts.disassembler_style = strdup(disassembler_style);
+		if (!annotate_opts.disassembler_style)
 			return -ENOMEM;
 	}
 	if (objdump_path) {
-		top.annotation_opts.objdump_path = strdup(objdump_path);
-		if (!top.annotation_opts.objdump_path)
+		annotate_opts.objdump_path = strdup(objdump_path);
+		if (!annotate_opts.objdump_path)
 			return -ENOMEM;
 	}
 	if (addr2line_path) {
@@ -1661,7 +1661,7 @@ int cmd_top(int argc, const char **argv)
 	if (status)
 		goto out_delete_evlist;
 
-	if (annotate_check_args(&top.annotation_opts) < 0)
+	if (annotate_check_args(&annotate_opts) < 0)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
@@ -1787,7 +1787,7 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		goto out_delete_evlist;
 
-	annotation_config__init(&top.annotation_opts);
+	annotation_config__init(&annotate_opts);
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
 	status = symbol__init(NULL);
@@ -1840,7 +1840,7 @@ int cmd_top(int argc, const char **argv)
 out_delete_evlist:
 	evlist__delete(top.evlist);
 	perf_session__delete(top.session);
-	annotation_options__exit(&top.annotation_opts);
+	annotation_options__exit(&annotate_opts);
 
 	return status;
 }
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index a8b0d79bd96c..4c5588dbb131 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -21,7 +21,6 @@ struct perf_top {
 	struct perf_tool   tool;
 	struct evlist *evlist, *sb_evlist;
 	struct record_opts record_opts;
-	struct annotation_options annotation_opts;
 	struct evswitch	   evswitch;
 	/*
 	 * Symbols will be added here in perf_event__process_sample and will
-- 
2.43.0.rc1.413.gea7ed67945-goog

