Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4C7FC164
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345733AbjK1Ryz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjK1Ryq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:46 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A467AB;
        Tue, 28 Nov 2023 09:54:51 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cb66f23eddso4704838b3a.0;
        Tue, 28 Nov 2023 09:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701194091; x=1701798891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edttZVwpAq7NVY2c6to78/JBhGZsepoZmj5Ka+4t3HY=;
        b=gOSAED0Eb1A0uf15zS+H4wUbJr/zdhzE2TlHFMHALYJzVnywSdIf/sC0zKEmrMYrZB
         PXpNTrammRgr7eAxvFCH9yotiHC0UpsNCK6QvBu+qg4cAXZAEelqKhZqJmTTsLdFp8J7
         koOqlGX8GnxGJ43ur7/HNkV0ncxfSd0N9F1EdSXTPM8dOfxzHLWTQaDuBreYFI182u4q
         kpxLlW7glH97Ubw4Zpu5dffj5hU4sJt0uqRFHlXnEkMLaYzJPoZ9nTnaGNvEUjgJEuqF
         OsEEiSGqNew/svk4iavuhkZOhKZqVq/cr0f9bb96uxt1ytBZVEI9P02Zi4n+yD6IeURW
         UlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194091; x=1701798891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=edttZVwpAq7NVY2c6to78/JBhGZsepoZmj5Ka+4t3HY=;
        b=jdsZOXfnbYat3JRPk4f3VjmnMRneVbzQ3egjJ7aOZDf7u2R8R3dvjQiRdIw7rwtgSm
         6tBabPYecK0jvxWvue7vGQxcGb2zBMmkQWiozadoGDDIY6AJZeGbrAZx6m353iWGQMDF
         Als7CUSGysZ4q+Qx37lPJCqxxomLTZAw7I5F4n/Rw0S2gOdmfvoVWOQPwjlWfn+JPDlk
         7U0SK5sHQWfwb3Koe6MkW46rqBx5ASMFPZYbc0KuTVT+sU5vv33Pkssdt0o2bhE9kWqq
         1fz7j6O+NcFs61wvMvjLdWsohzMghrbhRZSVCJYpjnjs/V75YPu77mxOsrVVmNKW9ARO
         lA8A==
X-Gm-Message-State: AOJu0YyBtRBJBO9YpibQ0J0s16WiCaX5S4YofNDncdjbqBXeKurAWpYq
        Sg02jzCJWjzR5t2WSWuhcfs=
X-Google-Smtp-Source: AGHT+IFVLB2WxrmNLthn/pc/vuiNNKYm7xcZecwFlkggaPFImFdjRHP3mv/T9Gzm27gNoQbAgRHVdA==
X-Received: by 2002:a05:6a00:1aca:b0:6cd:b865:ee57 with SMTP id f10-20020a056a001aca00b006cdb865ee57mr493804pfv.24.1701194090883;
        Tue, 28 Nov 2023 09:54:50 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:146f:6347:3bb4:8cf4])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78042000000b006cbbc07a1c0sm9224721pfm.156.2023.11.28.09.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:54:50 -0800 (PST)
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
Subject: [PATCH 2/8] perf report: Convert to the global annotation_options
Date:   Tue, 28 Nov 2023 09:54:35 -0800
Message-ID: <20231128175441.721579-3-namhyung@kernel.org>
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
 tools/perf/builtin-report.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 121a2781323c..90f98953587c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -98,7 +98,6 @@ struct report {
 	bool			skip_empty;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
-	struct annotation_options annotation_opts;
 	const char		*pretty_printing_style;
 	const char		*cpu_list;
 	const char		*symbol_filter_str;
@@ -542,7 +541,7 @@ static int evlist__tui_block_hists_browse(struct evlist *evlist, struct report *
 		ret = report__browse_block_hists(&rep->block_reports[i++].hist,
 						 rep->min_percent, pos,
 						 &rep->session->header.env,
-						 &rep->annotation_opts);
+						 &annotate_opts);
 		if (ret != 0)
 			return ret;
 	}
@@ -670,7 +669,7 @@ static int report__browse_hists(struct report *rep)
 		}
 
 		ret = evlist__tui_browse_hists(evlist, help, NULL, rep->min_percent,
-					       &session->header.env, true, &rep->annotation_opts);
+					       &session->header.env, true, &annotate_opts);
 		/*
 		 * Usually "ret" is the last pressed key, and we only
 		 * care if the key notifies us to switch data file.
@@ -745,7 +744,7 @@ static int hists__resort_cb(struct hist_entry *he, void *arg)
 	if (rep->symbol_ipc && sym && !sym->annotate2) {
 		struct evsel *evsel = hists_to_evsel(he->hists);
 
-		symbol__annotate2(&he->ms, evsel, &rep->annotation_opts, NULL);
+		symbol__annotate2(&he->ms, evsel, &annotate_opts, NULL);
 	}
 
 	return 0;
@@ -1341,15 +1340,15 @@ int cmd_report(int argc, const char **argv)
 		   "list of cpus to profile"),
 	OPT_BOOLEAN('I', "show-info", &report.show_full_info,
 		    "Display extended information about perf.data file"),
-	OPT_BOOLEAN(0, "source", &report.annotation_opts.annotate_src,
+	OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &report.annotation_opts.show_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &annotate_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
-	OPT_STRING(0, "prefix", &report.annotation_opts.prefix, "prefix",
+	OPT_STRING(0, "prefix", &annotate_opts.prefix, "prefix",
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
-	OPT_STRING(0, "prefix-strip", &report.annotation_opts.prefix_strip, "N",
+	OPT_STRING(0, "prefix-strip", &annotate_opts.prefix_strip, "N",
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
@@ -1401,7 +1400,7 @@ int cmd_report(int argc, const char **argv)
 		   "Time span of interest (start,stop)"),
 	OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
 		    "Show inline function"),
-	OPT_CALLBACK(0, "percent-type", &report.annotation_opts, "local-period",
+	OPT_CALLBACK(0, "percent-type", &annotate_opts, "local-period",
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
 	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs, "Show times in nanosecs"),
@@ -1433,7 +1432,7 @@ int cmd_report(int argc, const char **argv)
 	 */
 	symbol_conf.keep_exited_threads = true;
 
-	annotation_options__init(&report.annotation_opts);
+	annotation_options__init(&annotate_opts);
 
 	ret = perf_config(report__config, &report);
 	if (ret)
@@ -1452,13 +1451,13 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	if (disassembler_style) {
-		report.annotation_opts.disassembler_style = strdup(disassembler_style);
-		if (!report.annotation_opts.disassembler_style)
+		annotate_opts.disassembler_style = strdup(disassembler_style);
+		if (!annotate_opts.disassembler_style)
 			return -ENOMEM;
 	}
 	if (objdump_path) {
-		report.annotation_opts.objdump_path = strdup(objdump_path);
-		if (!report.annotation_opts.objdump_path)
+		annotate_opts.objdump_path = strdup(objdump_path);
+		if (!annotate_opts.objdump_path)
 			return -ENOMEM;
 	}
 	if (addr2line_path) {
@@ -1467,7 +1466,7 @@ int cmd_report(int argc, const char **argv)
 			return -ENOMEM;
 	}
 
-	if (annotate_check_args(&report.annotation_opts) < 0) {
+	if (annotate_check_args(&annotate_opts) < 0) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -1699,7 +1698,7 @@ int cmd_report(int argc, const char **argv)
 			 */
 			symbol_conf.priv_size += sizeof(u32);
 		}
-		annotation_config__init(&report.annotation_opts);
+		annotation_config__init(&annotate_opts);
 	}
 
 	if (symbol__init(&session->header.env) < 0)
@@ -1753,7 +1752,7 @@ int cmd_report(int argc, const char **argv)
 	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
 exit:
-	annotation_options__exit(&report.annotation_opts);
+	annotation_options__exit(&annotate_opts);
 	free(sort_order_help);
 	free(field_order_help);
 	return ret;
-- 
2.43.0.rc1.413.gea7ed67945-goog

