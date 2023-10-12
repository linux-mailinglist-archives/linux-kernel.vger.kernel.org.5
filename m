Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4B7C6373
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377176AbjJLDwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377055AbjJLDwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:01 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADD5111;
        Wed, 11 Oct 2023 20:51:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9a1762b43so4586725ad.1;
        Wed, 11 Oct 2023 20:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082691; x=1697687491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbaN0yRuaza8BL6icLDagknshS4zfy6sspTNGP7mdKc=;
        b=SGXUrJOW/DMwXuopDy0AWGqPqDVkwNDtGo99RtyLx17yqtplD0hGQfo1pYmzEuu3wQ
         2jzyFGLorTIp/HaavUAWee+JYvpkOlVS9MG5UyHPwobOEvSLYeXEYwCII9Gsg3FvVGbe
         j8/SBNx63+MzHca1T83ZBlXwAfJ8E4CyrotzSX4UZmYaeS658RD6qXemYsHzjlKyZ4yH
         kQObvA1OfzUmhYFRD4apoxOjikQew2ut5sfJwt4jGfhyvxeG3gz8fuQNByealAZzO2cB
         tmgIuDCsNSgZyMoGjReVxOUZyHZrKc3X4wwBSnOvi67sustvhdxA42kGOFI5UUOQL/sd
         0nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082691; x=1697687491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DbaN0yRuaza8BL6icLDagknshS4zfy6sspTNGP7mdKc=;
        b=Lpd7lbB0ZfYauvazvZWpCOh0KP4OtvWfo4QRMZchaLZUajmNt0txPCN2qZBbPqfhyU
         fybAv1Nt9d2XEkq/sBxyL6OH/o6y/1qg/oTBXpuiHR7dKYfdknzNszhbnzeWjL0qHriz
         /TuRlaZvnVUcU1+vbIEF+k0lauBp9Q4925p7YPNepG5yoFXZw/pDRoKTXp2eiF/38bDq
         U5dSf+hnh7+HpZdbXNSkNotjkWq7okcS9mYngk/zrsBKu1QpXtEHLMfr7PBa/TxGdedL
         u176lxbMSzih8N6dxEYH00AsWPAVzhm+xeFvKDGMHPmdD/ODcSQYOdTqo7TMwGQ8yFrx
         Z0eQ==
X-Gm-Message-State: AOJu0Ywpe10DmDOyyE7o8PApIzW22ZdWEJ2V3ap48uXlwSOJ/CHneaZI
        5HD+/faZjm0kGWOtj3QgS/Y=
X-Google-Smtp-Source: AGHT+IEheQbgSpqZROi/n4uDdh6jZhcA+SuMT7pxBEGYErtpNcfwWcfp7IM0f+AV2I97ngR3oxSuCw==
X-Received: by 2002:a17:902:ec91:b0:1c8:9d32:3392 with SMTP id x17-20020a170902ec9100b001c89d323392mr16052935plg.63.1697082690648;
        Wed, 11 Oct 2023 20:51:30 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:30 -0700 (PDT)
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
Subject: [PATCH 12/48] perf annotate: Factor out evsel__get_arch()
Date:   Wed, 11 Oct 2023 20:50:35 -0700
Message-ID: <20231012035111.676789-13-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evsel__get_arch() is to get architecture info from the environ.
It'll be used by other places later so let's factor it out.

Also add arch__is() to check the arch info by name.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 44 +++++++++++++++++++++++++++-----------
 tools/perf/util/annotate.h |  2 ++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 605298410ed4..254cc9f224f4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -840,6 +840,11 @@ static struct arch *arch__find(const char *name)
 	return bsearch(name, architectures, nmemb, sizeof(struct arch), arch__key_cmp);
 }
 
+bool arch__is(struct arch *arch, const char *name)
+{
+	return !strcmp(arch->name, name);
+}
+
 static struct annotated_source *annotated_source__new(void)
 {
 	struct annotated_source *src = zalloc(sizeof(*src));
@@ -2344,15 +2349,8 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
-		     struct annotation_options *options, struct arch **parch)
+static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
 {
-	struct symbol *sym = ms->sym;
-	struct annotation *notes = symbol__annotation(sym);
-	struct annotate_args args = {
-		.evsel		= evsel,
-		.options	= options,
-	};
 	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
 	struct arch *arch;
@@ -2361,23 +2359,43 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (!arch_name)
 		return errno;
 
-	args.arch = arch = arch__find(arch_name);
+	*parch = arch = arch__find(arch_name);
 	if (arch == NULL) {
 		pr_err("%s: unsupported arch %s\n", __func__, arch_name);
 		return ENOTSUP;
 	}
 
-	if (parch)
-		*parch = arch;
-
 	if (arch->init) {
 		err = arch->init(arch, env ? env->cpuid : NULL);
 		if (err) {
-			pr_err("%s: failed to initialize %s arch priv area\n", __func__, arch->name);
+			pr_err("%s: failed to initialize %s arch priv area\n",
+			       __func__, arch->name);
 			return err;
 		}
 	}
+	return 0;
+}
+
+int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
+		     struct annotation_options *options, struct arch **parch)
+{
+	struct symbol *sym = ms->sym;
+	struct annotation *notes = symbol__annotation(sym);
+	struct annotate_args args = {
+		.evsel		= evsel,
+		.options	= options,
+	};
+	struct arch *arch = NULL;
+	int err;
+
+	err = evsel__get_arch(evsel, &arch);
+	if (err < 0)
+		return err;
+
+	if (parch)
+		*parch = arch;
 
+	args.arch = arch;
 	args.ms = *ms;
 	if (notes->options && notes->options->full_addr)
 		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index e33a55431bad..c74f8f10f705 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -61,6 +61,8 @@ struct ins_operands {
 
 struct arch;
 
+bool arch__is(struct arch *arch, const char *name);
+
 struct ins_ops {
 	void (*free)(struct ins_operands *ops);
 	int (*parse)(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms);
-- 
2.42.0.655.g421f12c284-goog

