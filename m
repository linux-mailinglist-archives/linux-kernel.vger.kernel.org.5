Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE387E7567
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbjKJAA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjKJAAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:21 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8888344B8;
        Thu,  9 Nov 2023 16:00:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5bd6ac9833fso1120837a12.0;
        Thu, 09 Nov 2023 16:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574419; x=1700179219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey94DP/uelsbEgibz5QQXMU4gKyXrxF4jUDbY06eM9k=;
        b=Ephkuhv9YJ3flFd8uODkLImjUCiSTuItkx30J5PVBrnptk03z24GLYisdYEYXS953w
         SZsqr0hVWtPxbZ7kUrNo3SvVHwmj6qHSkeLjbAlUo5ZY0GM4b7RZqWn8HZELF71KTWC7
         lwr9qeW87FN2q3f4j6/H9j+YN5e1eQIscjOIxEL5fy4W1M9fulucSDzM/FTPDN8J8w5k
         yYeLCMwNAXTi2Kd+jHXBGBIdiGpz2/Rwkd1Dsb1m1SIfkLE77Msr4xSgJv5L+r+rJgKT
         1YDXUSSuQH17ldyeBxHwN+bb7VMAGBsSCRYMlVJaRn5BOe7prC4aD7aNB3343o9kLZzf
         UTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574419; x=1700179219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ey94DP/uelsbEgibz5QQXMU4gKyXrxF4jUDbY06eM9k=;
        b=uwmWVb8S1RxyiTZvlEatkp6oAZJ1GJUVu92gdrf1X2On9M18OEOR9rRs67CBR5rsma
         5v9ianRYtvZ3AntdvktFEnN272MwtmK6nTbA4Lg+835qZWNOkPVlT26Bh74idEdpI8TC
         MD2tdw2RuQoLY2ELpIPF9zDv+dUqG3ALsHap/8a/3n/WWrG2nAIwY1cz32T1Ng4otIsU
         JGYue1osHSa3kraglJdvmA5d5AQekpNPcRWjwV7ZWoBW8Ey5yzhlvLL+sVZPDpy5ZSmQ
         KDmd0nePTqVCBjEoNlpeYbqgVrxv+llRZrRDCZaaHeFIpTu0n9ZucLEvFpNxuvJgjS5v
         bmpw==
X-Gm-Message-State: AOJu0Ywe8yiBnvCpW4ueOBEJsZ4QVgG0QOsU06Bd13L4mPuMU/jPNoGw
        CJgDl4LwdGVKwYo8xO92Xw0=
X-Google-Smtp-Source: AGHT+IHXWtCX2mhFjyGobqMA7A87aXao3MRvg4Ed5XHGcG3lOAOTrWMfM0jz0XLmBzBfDwCv1WDy+Q==
X-Received: by 2002:a05:6a20:441a:b0:16b:f3b1:c040 with SMTP id ce26-20020a056a20441a00b0016bf3b1c040mr8149334pzb.38.1699574418918;
        Thu, 09 Nov 2023 16:00:18 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:18 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org,
        linux-toolchains@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Rui <wangrui@loongson.cn>
Subject: [PATCH 02/52] perf annotate: Move raw_comment and raw_func_start
Date:   Thu,  9 Nov 2023 15:59:21 -0800
Message-ID: <20231110000012.3538610-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 118195c787b9..3364edf30f50 100644
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
index de59c1aff08e..bc8b95e8b1be 100644
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
2.42.0.869.gea05f2083d-goog

