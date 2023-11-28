Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733577FC28D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346790AbjK1RzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346706AbjK1Ryy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:54 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133E310C3;
        Tue, 28 Nov 2023 09:54:56 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cd8ce7bf7fso2437236b3a.0;
        Tue, 28 Nov 2023 09:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701194095; x=1701798895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5g8LvRyYgkffKCHyddw+qlPQpUJhijbXPKeT9Y2vQY=;
        b=fv04DDEv/Pd6sUrV78Q8XmvVi1h5+mUD2B59ixCkuFV1I4vF0esED0P4N894yVXlj5
         O/LXU1VnvAx9+gBfBNjqr7MjSdxmJxDKMKxoy0muTXj32hjG/8mHAUV/obYDfm2ITebE
         oa5q1uhyGDFDui8Hs+ybZ4kTuWHls5PZY6NIze4rODefvJkTJWlQfda4hLvkwL+bmIDY
         HV/lL/Nt/X7RbZBKXSFMkzGSEBEAyP0EP68bss9mKPSpqNnLBEc31qcC9J1FTBP4H2t4
         y0+/Gk/xfoGcE9uwwI+ptIbIvUUGq1xOHW5fB/6JYMwzdKzsWQ4DjoZDSLN0WIpf+xAr
         pLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194095; x=1701798895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5g8LvRyYgkffKCHyddw+qlPQpUJhijbXPKeT9Y2vQY=;
        b=JhVUvzKf8SDCV3JpHdhMrnhfESlmUQYA+jjYA8qKlFT4f0hdm0fsfONNHwoXhJF9dp
         Ec4KQkoLHbwnjy/cORc0KPxxym6RpZ1tU20PqQ3yinl8CzPYPEoJgqVDRW+JdoS90pWm
         NcADTxoqW9sTjWOZaiHTP/uoriNVvxA8dN8xC5MuKrM6nCTRzHKbPrA6e4A1QNVtHfry
         pPx6EI38gwkK1MyH94KPv8xfvvxT2acu/r/+u46ojqvZnBttH8abKNu9wB/+g5Lmu91F
         6Cz6Ug4QXYJLKHADRU3E2I5JfIOs+X9LNUC9DCy7uV+CTc4rSJ2w0EMLwNZ9M0a8qOj3
         uOCA==
X-Gm-Message-State: AOJu0Yzp4S6VbYwoabTPKB0WQ6ULSG/PDrhX0b+7zxCmo0e5G3KPbB6T
        p3/HErhqnLIyyDAxXiHp8VLURIeauN8pZg==
X-Google-Smtp-Source: AGHT+IEJ5U3aGofl0GYAVJqpCMjZupp/JnTv2AaqzHTTge6gWMSQEyQNInzA2ZZgc14ibrCh8mnYIA==
X-Received: by 2002:a05:6a00:14c6:b0:6c4:dc5b:5b2b with SMTP id w6-20020a056a0014c600b006c4dc5b5b2bmr17534517pfu.20.1701194095420;
        Tue, 28 Nov 2023 09:54:55 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:146f:6347:3bb4:8cf4])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78042000000b006cbbc07a1c0sm9224721pfm.156.2023.11.28.09.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:54:54 -0800 (PST)
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
Subject: [PATCH 6/8] perf annotate: Ensure init/exit for global options
Date:   Tue, 28 Nov 2023 09:54:39 -0800
Message-ID: <20231128175441.721579-7-namhyung@kernel.org>
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

Now it only cares about the global options so it can just handle it
without the argument.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c |  8 ++++----
 tools/perf/builtin-report.c   |  8 ++++----
 tools/perf/builtin-top.c      |  8 ++++----
 tools/perf/util/annotate.c    | 19 +++++++++++--------
 tools/perf/util/annotate.h    |  8 ++++----
 5 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 87af95634879..9b3dd456a1ee 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -616,13 +616,13 @@ int cmd_annotate(int argc, const char **argv)
 	set_option_flag(options, 0, "show-total-period", PARSE_OPT_EXCLUSIVE);
 	set_option_flag(options, 0, "show-nr-samples", PARSE_OPT_EXCLUSIVE);
 
-	annotation_options__init(&annotate_opts);
+	annotation_options__init();
 
 	ret = hists__init();
 	if (ret < 0)
 		return ret;
 
-	annotation_config__init(&annotate_opts);
+	annotation_config__init();
 
 	argc = parse_options(argc, argv, options, annotate_usage, 0);
 	if (argc) {
@@ -652,7 +652,7 @@ int cmd_annotate(int argc, const char **argv)
 			return -ENOMEM;
 	}
 
-	if (annotate_check_args(&annotate_opts) < 0)
+	if (annotate_check_args() < 0)
 		return -EINVAL;
 
 #ifdef HAVE_GTK2_SUPPORT
@@ -733,7 +733,7 @@ int cmd_annotate(int argc, const char **argv)
 #ifndef NDEBUG
 	perf_session__delete(annotate.session);
 #endif
-	annotation_options__exit(&annotate_opts);
+	annotation_options__exit();
 
 	return ret;
 }
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index bc0d986c1e0c..17fb171e898b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1430,7 +1430,7 @@ int cmd_report(int argc, const char **argv)
 	 */
 	symbol_conf.keep_exited_threads = true;
 
-	annotation_options__init(&annotate_opts);
+	annotation_options__init();
 
 	ret = perf_config(report__config, &report);
 	if (ret)
@@ -1464,7 +1464,7 @@ int cmd_report(int argc, const char **argv)
 			return -ENOMEM;
 	}
 
-	if (annotate_check_args(&annotate_opts) < 0) {
+	if (annotate_check_args() < 0) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -1696,7 +1696,7 @@ int cmd_report(int argc, const char **argv)
 			 */
 			symbol_conf.priv_size += sizeof(u32);
 		}
-		annotation_config__init(&annotate_opts);
+		annotation_config__init();
 	}
 
 	if (symbol__init(&session->header.env) < 0)
@@ -1750,7 +1750,7 @@ int cmd_report(int argc, const char **argv)
 	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
 exit:
-	annotation_options__exit(&annotate_opts);
+	annotation_options__exit();
 	free(sort_order_help);
 	free(field_order_help);
 	return ret;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 60399e4233ee..0de963ca3196 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1608,7 +1608,7 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		return status;
 
-	annotation_options__init(&annotate_opts);
+	annotation_options__init();
 
 	annotate_opts.min_pcnt = 5;
 	annotate_opts.context  = 4;
@@ -1660,7 +1660,7 @@ int cmd_top(int argc, const char **argv)
 	if (status)
 		goto out_delete_evlist;
 
-	if (annotate_check_args(&annotate_opts) < 0)
+	if (annotate_check_args() < 0)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
@@ -1786,7 +1786,7 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		goto out_delete_evlist;
 
-	annotation_config__init(&annotate_opts);
+	annotation_config__init();
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
 	status = symbol__init(NULL);
@@ -1839,7 +1839,7 @@ int cmd_top(int argc, const char **argv)
 out_delete_evlist:
 	evlist__delete(top.evlist);
 	perf_session__delete(top.session);
-	annotation_options__exit(&annotate_opts);
+	annotation_options__exit();
 
 	return status;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index daff9af552f4..626ff3baeb85 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3416,8 +3416,10 @@ static int annotation__config(const char *var, const char *value, void *data)
 	return 0;
 }
 
-void annotation_options__init(struct annotation_options *opt)
+void annotation_options__init(void)
 {
+	struct annotation_options *opt = &annotate_opts;
+
 	memset(opt, 0, sizeof(*opt));
 
 	/* Default values. */
@@ -3428,16 +3430,15 @@ void annotation_options__init(struct annotation_options *opt)
 	opt->percent_type = PERCENT_PERIOD_LOCAL;
 }
 
-
-void annotation_options__exit(struct annotation_options *opt)
+void annotation_options__exit(void)
 {
-	zfree(&opt->disassembler_style);
-	zfree(&opt->objdump_path);
+	zfree(&annotate_opts.disassembler_style);
+	zfree(&annotate_opts.objdump_path);
 }
 
-void annotation_config__init(struct annotation_options *opt)
+void annotation_config__init(void)
 {
-	perf_config(annotation__config, opt);
+	perf_config(annotation__config, &annotate_opts);
 }
 
 static unsigned int parse_percent_type(char *str1, char *str2)
@@ -3491,8 +3492,10 @@ int annotate_parse_percent_type(const struct option *opt __maybe_unused, const c
 	return err;
 }
 
-int annotate_check_args(struct annotation_options *args)
+int annotate_check_args(void)
 {
+	struct annotation_options *args = &annotate_opts;
+
 	if (args->prefix_strip && !args->prefix) {
 		pr_err("--prefix-strip requires --prefix\n");
 		return -1;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 857c5fa0e6b1..4283eb4522b2 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -428,14 +428,14 @@ static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
 }
 #endif
 
-void annotation_options__init(struct annotation_options *opt);
-void annotation_options__exit(struct annotation_options *opt);
+void annotation_options__init(void);
+void annotation_options__exit(void);
 
-void annotation_config__init(struct annotation_options *opt);
+void annotation_config__init(void);
 
 int annotate_parse_percent_type(const struct option *opt, const char *_str,
 				int unset);
 
-int annotate_check_args(struct annotation_options *args);
+int annotate_check_args(void);
 
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.43.0.rc1.413.gea7ed67945-goog

