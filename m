Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE06D7C6367
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376867AbjJLDvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjJLDvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C1B6;
        Wed, 11 Oct 2023 20:51:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692ada71d79so452814b3a.1;
        Wed, 11 Oct 2023 20:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082676; x=1697687476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8mPnOK6VoW5tNOXDdi1hzajrHQSpWzCPNZ87J7UJ64=;
        b=ALjs+XS1Kz0sClTobra4U5PV9UrE2IjMPhahd0cfd/HqJjnZSh2FrSHEACnsc9t7yn
         +1cHh/uOvGTXvNJQ5kv743BlQd/ppgcfxxwAIiT0fr/yeAEDcdqzwmy9YgTMqqLcwbo7
         +AesIL8qFbkndAGJxS+mtluL2hz/LAIBv5jbgyTdbkyEh5eDNmkQ84DFUpEPHn+b5UQq
         HJkIneGx7UcWxAl7bsRZE+JZigoGyKK/2nThHEb0Nkn3MTG8Npq1dVa2pwJsvKmvQDNa
         t/M66NhOUFjJosS7QC9ndSe9hzC4JN9sZYbPN0aVIiG34+v9GgE6NfYhSn5ymiXdtEWX
         NLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082676; x=1697687476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8mPnOK6VoW5tNOXDdi1hzajrHQSpWzCPNZ87J7UJ64=;
        b=DjeVDtDeg0Cc5s6WaAKKSbQ7l8tColYEWfWjY8G7ISQQgRWOGLpCEIX6nFCFZP+hhy
         AqbwcVbkYYmH+abxDh5puF8ILYKcOkcPg2GBssCgH9nlEaksm4tr9SAQ2+a6/7ljsqVJ
         NH0IgIum7ub5NBZhCCRBVr9xBKYSHkznAcdcWBaOOx3w3MNxYzQ3hfQo7NsHxisk8Wx1
         qKoKkR2Fb5mM/X5JQcL5A6Z5imqdPpjIG9gKaWjKW66UOnMqOQ4L2lBeDFveE7YSnALv
         75LJK1qJxOoXcqkEuEOkLvV0DDtaz/9Of/ft6JCPyf7RU+85afhUwGQUvNjx7InH0XG/
         R0YA==
X-Gm-Message-State: AOJu0YyIn0fgy+KJqoEZn6ZjiivTsGfOV+Ud4Dj930J853SdNeK/1bvT
        KVFEs0O3YS91PUGquHKauhQ=
X-Google-Smtp-Source: AGHT+IEtXTilcE+YdrmkNnQSEjjz2LKgJCM4syB+3wA5/leydBOIEJn2PbGBohrDIFs6szMMzXEObA==
X-Received: by 2002:a05:6a20:1047:b0:16b:79b3:2b43 with SMTP id gt7-20020a056a20104700b0016b79b32b43mr13926984pzc.37.1697082675621;
        Wed, 11 Oct 2023 20:51:15 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:15 -0700 (PDT)
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
        linux-toolchains@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Rui <wangrui@loongson.cn>
Subject: [PATCH 01/48] perf annotate: Move raw_comment and raw_func_start
Date:   Wed, 11 Oct 2023 20:50:24 -0700
Message-ID: <20231012035111.676789-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thoese two fields are used only for the jump_ops, so move them into the
union to save some bytes.  Also add jump__delete() callback not to free
the fields as they didn't allocate new strings.

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../perf/arch/loongarch/annotate/instructions.c |  6 +++---
 tools/perf/util/annotate.c                      | 17 +++++++++++++----
 tools/perf/util/annotate.h                      |  6 ++++--
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/arch/loongarch/annotate/instructions.c
index 98e19c5366ac..21cc7e4149f7 100644
--- a/tools/perf/arch/loongarch/annotate/instructions.c
+++ b/tools/perf/arch/loongarch/annotate/instructions.c
@@ -61,10 +61,10 @@ static int loongarch_jump__parse(struct arch *arch, struct ins_operands *ops, st
 	const char *c = strchr(ops->raw, '#');
 	u64 start, end;
 
-	ops->raw_comment = strchr(ops->raw, arch->objdump.comment_char);
-	ops->raw_func_start = strchr(ops->raw, '<');
+	ops->jump.raw_comment = strchr(ops->raw, arch->objdump.comment_char);
+	ops->jump.raw_func_start = strchr(ops->raw, '<');
 
-	if (ops->raw_func_start && c > ops->raw_func_start)
+	if (ops->jump.raw_func_start && c > ops->jump.raw_func_start)
 		c = NULL;
 
 	if (c++ != NULL)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 82956adf9963..211636e65b03 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -340,10 +340,10 @@ bool ins__is_call(const struct ins *ins)
  */
 static inline const char *validate_comma(const char *c, struct ins_operands *ops)
 {
-	if (ops->raw_comment && c > ops->raw_comment)
+	if (ops->jump.raw_comment && c > ops->jump.raw_comment)
 		return NULL;
 
-	if (ops->raw_func_start && c > ops->raw_func_start)
+	if (ops->jump.raw_func_start && c > ops->jump.raw_func_start)
 		return NULL;
 
 	return c;
@@ -359,8 +359,8 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	const char *c = strchr(ops->raw, ',');
 	u64 start, end;
 
-	ops->raw_comment = strchr(ops->raw, arch->objdump.comment_char);
-	ops->raw_func_start = strchr(ops->raw, '<');
+	ops->jump.raw_comment = strchr(ops->raw, arch->objdump.comment_char);
+	ops->jump.raw_func_start = strchr(ops->raw, '<');
 
 	c = validate_comma(c, ops);
 
@@ -462,7 +462,16 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			 ops->target.offset);
 }
 
+static void jump__delete(struct ins_operands *ops __maybe_unused)
+{
+	/*
+	 * The ops->jump.raw_comment and ops->jump.raw_func_start belong to the
+	 * raw string, don't free them.
+	 */
+}
+
 static struct ins_ops jump_ops = {
+	.free	   = jump__delete,
 	.parse	   = jump__parse,
 	.scnprintf = jump__scnprintf,
 };
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 962780559176..9d8b4199e3bd 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -31,8 +31,6 @@ struct ins {
 
 struct ins_operands {
 	char	*raw;
-	char	*raw_comment;
-	char	*raw_func_start;
 	struct {
 		char	*raw;
 		char	*name;
@@ -52,6 +50,10 @@ struct ins_operands {
 			struct ins	    ins;
 			struct ins_operands *ops;
 		} locked;
+		struct {
+			char	*raw_comment;
+			char	*raw_func_start;
+		} jump;
 	};
 };
 
-- 
2.42.0.655.g421f12c284-goog

