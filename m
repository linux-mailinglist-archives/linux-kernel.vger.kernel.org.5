Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B87E7575
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbjKJAB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345580AbjKJAAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:53 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813CC49CF;
        Thu,  9 Nov 2023 16:00:38 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bd85b1939aso1097043a12.2;
        Thu, 09 Nov 2023 16:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574438; x=1700179238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kl6qkwzmCb2Fb09U1AXlxKbKREoLSgao7N8IelzAMBg=;
        b=huE+tmGrENZq27PQZHbDXKv6PKMPRIOtN7Xqxmp0hx2BqD3mneWnaoPNo3K2fTc+BE
         QmIrJKTqku7Sg43Do4ltYgF+JZPgsqGNMBUTYAYsqXEj83zx0zRejw0M54eA/cB278da
         ZMKdTcOkwyd0yt87axOzKIVTWxBSM1u9tY7BwoCzS/P1YMZJbafHIz47kQODVhXWa2bu
         a9WLOLn+4Z7/wH7lA1TfVziWgnQy3oK6/Dkt9Espw9xEkr3SrohWX8YH/peTRiOzWytN
         vwmDMHM8JS2S+5FDUcC8i1QAaB8UBCvhSo0eCujORsX/iDttStGN5RUEY0anxeFDRMem
         XU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574438; x=1700179238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kl6qkwzmCb2Fb09U1AXlxKbKREoLSgao7N8IelzAMBg=;
        b=lVmljx6hu8aS8p0W/xqj3/hzSB5Cd8XH3z32JYG58kJ/tsWtPPrqQA7te7UPyKqhX8
         0W4LB8hYquNHvR/a5sSLcAMD0lPsdzpNka4PMFIwX5XrMQ+B3ZzGGOiU72xi9C98R1iU
         td9e7gcxTuO0pd/DyxcubFolyD7DV+r28JyyTvBl+/u4yKVHooh/oGEf0Hy6/C4NyySJ
         B0zbaXXoBnfTskLE6U50jKCuMO5ekP6eO4uJiR5g2yC9S5FCeW6NvBfZBQJZzbsBJRKV
         54y2+iT0xTQHNw57VR8bydYH2866aepxF2Ex8wO5AGWhwK502Bq0lRMEZ/cPPLn77L0Y
         Al5A==
X-Gm-Message-State: AOJu0YyRiV5c68eBD7SHdFoiyebVUrnm96k13rBUA7wVkI3sQ0uwCWaF
        DUXpdL5f08mxpncfCZMazXw=
X-Google-Smtp-Source: AGHT+IEl6Kg+Ce9xdTunRkPSVE+zc/L7j9/ec6svm1a9xENy5X2o+woa+hJIZpauMbUzihB8rs8FVQ==
X-Received: by 2002:a17:90a:4888:b0:280:1df1:cbc7 with SMTP id b8-20020a17090a488800b002801df1cbc7mr3334799pjh.19.1699574437858;
        Thu, 09 Nov 2023 16:00:37 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:37 -0800 (PST)
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
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 15/52] perf annotate: Check if operand has multiple regs
Date:   Thu,  9 Nov 2023 15:59:34 -0800
Message-ID: <20231110000012.3538610-16-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It needs to check all possible information in an instruction.  Let's add
a field indicating if the operand has multiple registers.  I'll be used
to search type information like in an array access on x86 like:

  mov    0x10(%rax,%rbx,8), %rcx
             -------------
                 here

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 36 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 83e0996992af..9e297adc8c59 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -85,6 +85,8 @@ struct arch {
 	struct		{
 		char comment_char;
 		char skip_functions_char;
+		char register_char;
+		char memory_ref_char;
 	} objdump;
 };
 
@@ -188,6 +190,8 @@ static struct arch architectures[] = {
 		.insn_suffix = "bwlq",
 		.objdump =  {
 			.comment_char = '#',
+			.register_char = '%',
+			.memory_ref_char = '(',
 		},
 	},
 	{
@@ -566,6 +570,34 @@ static struct ins_ops lock_ops = {
 	.scnprintf = lock__scnprintf,
 };
 
+/*
+ * Check if the operand has more than one registers like x86 SIB addressing:
+ *   0x1234(%rax, %rbx, 8)
+ *
+ * But it doesn't care segment selectors like %gs:0x5678(%rcx), so just check
+ * the input string after 'memory_ref_char' if exists.
+ */
+static bool check_multi_regs(struct arch *arch, const char *op)
+{
+	int count = 0;
+
+	if (arch->objdump.register_char == 0)
+		return false;
+
+	if (arch->objdump.memory_ref_char) {
+		op = strchr(op, arch->objdump.memory_ref_char);
+		if (op == NULL)
+			return false;
+	}
+
+	while ((op = strchr(op, arch->objdump.register_char)) != NULL) {
+		count++;
+		op++;
+	}
+
+	return count > 1;
+}
+
 static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms __maybe_unused)
 {
 	char *s = strchr(ops->raw, ','), *target, *comment, prev;
@@ -593,6 +625,8 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 	if (ops->source.raw == NULL)
 		return -1;
 
+	ops->source.multi_regs = check_multi_regs(arch, ops->source.raw);
+
 	target = skip_spaces(++s);
 	comment = strchr(s, arch->objdump.comment_char);
 
@@ -613,6 +647,8 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 	if (ops->target.raw == NULL)
 		goto out_free_source;
 
+	ops->target.multi_regs = check_multi_regs(arch, ops->target.raw);
+
 	if (comment == NULL)
 		return 0;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index e8b0173f5f00..4ebc6407c68a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -39,12 +39,14 @@ struct ins_operands {
 		s64	offset;
 		bool	offset_avail;
 		bool	outside;
+		bool	multi_regs;
 	} target;
 	union {
 		struct {
 			char	*raw;
 			char	*name;
 			u64	addr;
+			bool	multi_regs;
 		} source;
 		struct {
 			struct ins	    ins;
-- 
2.42.0.869.gea05f2083d-goog

