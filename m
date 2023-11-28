Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78D07FC246
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbjK1Ryw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjK1Ryp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:45 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE010C3;
        Tue, 28 Nov 2023 09:54:50 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cdcd790f42so29975b3a.3;
        Tue, 28 Nov 2023 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701194090; x=1701798890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIHPU/HDnMC3rOs5eNWXjIqs+uKyjgI2mVCIW5GY/lk=;
        b=Zp+iB2HvagCRPgosU3CipxnC7STMu1ghafKW1PCztd7mHSbpQQ2MPKOM1XT2+6GeYv
         r/S0MURVFkBTZ86bHDvIG9mTjto+8kvQu3OMcK2DUnMrIEyPUQFKD1zchg/470jIOq2G
         NBhFZ7TAZ4ayydjjmAYO9l4I+zfySGT1Txs55z6bawvB8TSKwohoWR3WyOR2s9wuqjaR
         CVJKNlMPQ+x+sKi4aQNu7/NtmfQ/imXW+/VoCr3c7zmz8srkQTI7bsGchAOqltU4o0F6
         3oykZYZiMLJphK+0cZXXP7AwNzdYcivA/m+mJhULnq+IakkxUGdVFTATTZi/TB0lIf/Y
         1OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194090; x=1701798890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sIHPU/HDnMC3rOs5eNWXjIqs+uKyjgI2mVCIW5GY/lk=;
        b=iKheDFWxsWgbyJuxSB4ksRFOGEHz5fu1MzZMvsJcE5BybuB120nhgB0uQrOJVjv/pH
         F+0ek4oGUHXurriz4dIGrvg4r1Wmm+AdRLjPPQ/MaHd1RmLasx4mRwtM2AWHStZduzcB
         cGQdfFMp7TCnS5TaDwWdNNj/apeqBEZsN5R0ydr+FQDCIfaDWf56/TLKoRE7jUPkQdTh
         5QN+jbsoJLB/SHE0O+HvRt9j6+avafl+y9YW37FgxAxCXYv5PMlEghucNH8+970fcgVH
         gqF10a9OHdoE1bjMRVhl6vohLFB+BDcrz9rHYCZdLTmduf5Tx4cJUDDxx0YVPR61c6lM
         fHxQ==
X-Gm-Message-State: AOJu0Yy2T3EzqTSvSMXKBBJJHIoh6RoC55UAoSiygbe8sJopR0uZBkx6
        Rxa0pfiRDN21ESrJKBx1SZo=
X-Google-Smtp-Source: AGHT+IE2QUJmEolqgE/4NqQAgbtxEpQmJ0TU8JRZAlBI1wZqvGLoMPZ/fif2tP06eEMvhgTnq13yBA==
X-Received: by 2002:a05:6a00:1953:b0:693:3be8:feba with SMTP id s19-20020a056a00195300b006933be8febamr15377691pfk.19.1701194089904;
        Tue, 28 Nov 2023 09:54:49 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:146f:6347:3bb4:8cf4])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78042000000b006cbbc07a1c0sm9224721pfm.156.2023.11.28.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:54:49 -0800 (PST)
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
Subject: [PATCH 1/8] perf annotate: Introduce global annotation_options
Date:   Tue, 28 Nov 2023 09:54:34 -0800
Message-ID: <20231128175441.721579-2-namhyung@kernel.org>
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

The annotation options are to control the behavior of objdump and the
output.  It's basically used by perf annotate but perf report and perf
top can call it on TUI dynamically.  But it doesn't need to have a copy
of annotation options in many places.  As most of the work is done in
the util/annotate.c file, add a global variable and set/use it instead
of having their own copies.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 43 +++++++++++++++++------------------
 tools/perf/util/annotate.c    |  3 +++
 tools/perf/util/annotate.h    |  2 ++
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index a9129b51d511..67b36a7a12e3 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -45,7 +45,6 @@
 struct perf_annotate {
 	struct perf_tool tool;
 	struct perf_session *session;
-	struct annotation_options opts;
 #ifdef HAVE_SLANG_SUPPORT
 	bool	   use_tui;
 #endif
@@ -318,9 +317,9 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_annotate *ann)
 {
 	if (!ann->use_stdio2)
-		return symbol__tty_annotate(&he->ms, evsel, &ann->opts);
+		return symbol__tty_annotate(&he->ms, evsel, &annotate_opts);
 
-	return symbol__tty_annotate2(&he->ms, evsel, &ann->opts);
+	return symbol__tty_annotate2(&he->ms, evsel, &annotate_opts);
 }
 
 static void hists__find_annotations(struct hists *hists,
@@ -376,14 +375,14 @@ static void hists__find_annotations(struct hists *hists,
 				return;
 			}
 
-			ret = annotate(he, evsel, &ann->opts, NULL);
+			ret = annotate(he, evsel, &annotate_opts, NULL);
 			if (!ret || !ann->skip_missing)
 				return;
 
 			/* skip missing symbols */
 			nd = rb_next(nd);
 		} else if (use_browser == 1) {
-			key = hist_entry__tui_annotate(he, evsel, NULL, &ann->opts);
+			key = hist_entry__tui_annotate(he, evsel, NULL, &annotate_opts);
 
 			switch (key) {
 			case -1:
@@ -425,9 +424,9 @@ static int __cmd_annotate(struct perf_annotate *ann)
 			goto out;
 	}
 
-	if (!ann->opts.objdump_path) {
+	if (!annotate_opts.objdump_path) {
 		ret = perf_env__lookup_objdump(&session->header.env,
-					       &ann->opts.objdump_path);
+					       &annotate_opts.objdump_path);
 		if (ret)
 			goto out;
 	}
@@ -561,9 +560,9 @@ int cmd_annotate(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
 		    "load module symbols - WARNING: use only with -k and LIVE kernel"),
-	OPT_BOOLEAN('l', "print-line", &annotate.opts.print_lines,
+	OPT_BOOLEAN('l', "print-line", &annotate_opts.print_lines,
 		    "print matching source lines (may be slow)"),
-	OPT_BOOLEAN('P', "full-paths", &annotate.opts.full_path,
+	OPT_BOOLEAN('P', "full-paths", &annotate_opts.full_path,
 		    "Don't shorten the displayed pathnames"),
 	OPT_BOOLEAN(0, "skip-missing", &annotate.skip_missing,
 		    "Skip symbols that cannot be annotated"),
@@ -574,15 +573,15 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK(0, "symfs", NULL, "directory",
 		     "Look for files with symbols relative to this directory",
 		     symbol__config_symfs),
-	OPT_BOOLEAN(0, "source", &annotate.opts.annotate_src,
+	OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &annotate.opts.show_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &annotate_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
-	OPT_STRING(0, "prefix", &annotate.opts.prefix, "prefix",
+	OPT_STRING(0, "prefix", &annotate_opts.prefix, "prefix",
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
-	OPT_STRING(0, "prefix-strip", &annotate.opts.prefix_strip, "N",
+	OPT_STRING(0, "prefix-strip", &annotate_opts.prefix_strip, "N",
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
 	OPT_STRING(0, "objdump", &objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
@@ -601,7 +600,7 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
 			     "'always' (default), 'never' or 'auto' only applicable to --stdio mode",
 			     stdio__config_color, "always"),
-	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
+	OPT_CALLBACK(0, "percent-type", &annotate_opts, "local-period",
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
 	OPT_CALLBACK(0, "percent-limit", &annotate, "percent",
@@ -617,13 +616,13 @@ int cmd_annotate(int argc, const char **argv)
 	set_option_flag(options, 0, "show-total-period", PARSE_OPT_EXCLUSIVE);
 	set_option_flag(options, 0, "show-nr-samples", PARSE_OPT_EXCLUSIVE);
 
-	annotation_options__init(&annotate.opts);
+	annotation_options__init(&annotate_opts);
 
 	ret = hists__init();
 	if (ret < 0)
 		return ret;
 
-	annotation_config__init(&annotate.opts);
+	annotation_config__init(&annotate_opts);
 
 	argc = parse_options(argc, argv, options, annotate_usage, 0);
 	if (argc) {
@@ -638,13 +637,13 @@ int cmd_annotate(int argc, const char **argv)
 	}
 
 	if (disassembler_style) {
-		annotate.opts.disassembler_style = strdup(disassembler_style);
-		if (!annotate.opts.disassembler_style)
+		annotate_opts.disassembler_style = strdup(disassembler_style);
+		if (!annotate_opts.disassembler_style)
 			return -ENOMEM;
 	}
 	if (objdump_path) {
-		annotate.opts.objdump_path = strdup(objdump_path);
-		if (!annotate.opts.objdump_path)
+		annotate_opts.objdump_path = strdup(objdump_path);
+		if (!annotate_opts.objdump_path)
 			return -ENOMEM;
 	}
 	if (addr2line_path) {
@@ -653,7 +652,7 @@ int cmd_annotate(int argc, const char **argv)
 			return -ENOMEM;
 	}
 
-	if (annotate_check_args(&annotate.opts) < 0)
+	if (annotate_check_args(&annotate_opts) < 0)
 		return -EINVAL;
 
 #ifdef HAVE_GTK2_SUPPORT
@@ -734,7 +733,7 @@ int cmd_annotate(int argc, const char **argv)
 #ifndef NDEBUG
 	perf_session__delete(annotate.session);
 #endif
-	annotation_options__exit(&annotate.opts);
+	annotation_options__exit(&annotate_opts);
 
 	return ret;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9a828dc601c7..77b78001b94d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -57,6 +57,9 @@
 
 #include <linux/ctype.h>
 
+/* global annotation options */
+struct annotation_options annotate_opts;
+
 static regex_t	 file_lineno;
 
 static struct ins_ops *ins__find(struct arch *arch, const char *name);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index b64a2be287b3..8c1a070725fa 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -105,6 +105,8 @@ struct annotation_options {
 	unsigned int percent_type;
 };
 
+extern struct annotation_options annotate_opts;
+
 enum {
 	ANNOTATION__OFFSET_JUMP_TARGETS = 1,
 	ANNOTATION__OFFSET_CALL,
-- 
2.43.0.rc1.413.gea7ed67945-goog

