Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6868780FC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377918AbjLMANv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377913AbjLMANi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:13:38 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C769210A;
        Tue, 12 Dec 2023 16:13:37 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so3580230a12.0;
        Tue, 12 Dec 2023 16:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426417; x=1703031217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp0h3Jhclsi2kLqdk87eOr+U+R23NUw3mkweFdnS3Ow=;
        b=nYoss4tXJ3jaZGBmk5hJkYhv345Zb2SnqQ9ZFck22GJ1rBtWs8+TvB/2oaVThv1O3G
         bqjmh0r6WMOZHio7SofbueSm/f/2ezIzyF+MZ6iq5iIo3iMA8Z0SV59f9yjic/vdErMg
         VFGao+jY4oAhc/4arISdY/8t8VQZKKya1M5Mii7flwrCTXyJyKrxbhDmwj1XTuod1rUG
         ZuQFWsJ8Owu8q0/zanB1GlxRT349iT7Ih6CRCcxQy+NzapKXNJvWgCoT6plNrb5DTYv/
         TCTUy5RYsOLs0zYjoE9iWpdhFP3qxhtq4v+nHr4dXHoNYr/ma5VL5cTqv6hePE4IFCcO
         GP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426417; x=1703031217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gp0h3Jhclsi2kLqdk87eOr+U+R23NUw3mkweFdnS3Ow=;
        b=MDtwkkla6BerA+ZEk5Xz+Bs2WAvzJ1+TboW11FSxK9uQU7dLK4h9FcT08AHNyyjZcZ
         pONOrZQ9B14of9udVFXOZTZU1RLi/G930WsF/I8pImLKgJTLvjq48h2gzq92sf8Qd+M/
         ZzIAhJ8ilURei4oZBVLztPgZbqxWq0jJ9DE40edV0NdZtCGnjdCFfIg4cdD5SBA6+Ymi
         A6u2j+VY8ib4QHb7N2YFa0+2WHSW5f239ddJ4m8sU491jcE1oNjtC88S/vVuFl/t0o5h
         lxDiQCTA0rqrTPLcd5SmUeCZDNIH3R/ns8ehU8pYEWz3eqvN23AxBM2rGmSZOmEBUcuC
         5RuA==
X-Gm-Message-State: AOJu0Yzyc76hF0n56YzY7rTo9JUgWY9RCsCE7OQkRVU/cRLCwMadRn73
        gv9tEzOtQj/9yFpyL1POs9A=
X-Google-Smtp-Source: AGHT+IHzRDn6GU8IbdRuJYvsSYpwzmx2YxHCPr2HrAbVp5s+ia737jwwh3THZ7LMC3usEyO3K2xiBA==
X-Received: by 2002:a05:6a20:d41f:b0:18f:c2f6:8953 with SMTP id il31-20020a056a20d41f00b0018fc2f68953mr3544916pzb.10.1702426416915;
        Tue, 12 Dec 2023 16:13:36 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:36 -0800 (PST)
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
Subject: [PATCH 06/17] perf annotate: Add annotate_get_insn_location()
Date:   Tue, 12 Dec 2023 16:13:12 -0800
Message-ID: <20231213001323.718046-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213001323.718046-1-namhyung@kernel.org>
References: <20231213001323.718046-1-namhyung@kernel.org>
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

The annotate_get_insn_location() is to get the detailed information of
instruction locations like registers and offset.  It has source and
target operands locations in an array.  Each operand can have a
register and an offset.  The offset is meaningful when mem_ref flag is
set.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 107 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h |  36 +++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 27b2a9961cd5..7c597440dc2e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -31,6 +31,7 @@
 #include "bpf-utils.h"
 #include "block-range.h"
 #include "string2.h"
+#include "dwarf-regs.h"
 #include "util/event.h"
 #include "util/sharded_mutex.h"
 #include "arch/common.h"
@@ -3518,3 +3519,109 @@ int annotate_check_args(void)
 	}
 	return 0;
 }
+
+/*
+ * Get register number and access offset from the given instruction.
+ * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
+ * to revisit the format when it handles different architecture.
+ * Fills @reg and @offset when return 0.
+ */
+static int extract_reg_offset(struct arch *arch, const char *str,
+			      struct annotated_op_loc *op_loc)
+{
+	char *p;
+	char *regname;
+
+	if (arch->objdump.register_char == 0)
+		return -1;
+
+	/*
+	 * It should start from offset, but it's possible to skip 0
+	 * in the asm.  So 0(%rax) should be same as (%rax).
+	 *
+	 * However, it also start with a segment select register like
+	 * %gs:0x18(%rbx).  In that case it should skip the part.
+	 */
+	if (*str == arch->objdump.register_char) {
+		while (*str && !isdigit(*str) &&
+		       *str != arch->objdump.memory_ref_char)
+			str++;
+	}
+
+	op_loc->offset = strtol(str, &p, 0);
+
+	p = strchr(p, arch->objdump.register_char);
+	if (p == NULL)
+		return -1;
+
+	regname = strdup(p);
+	if (regname == NULL)
+		return -1;
+
+	op_loc->reg = get_dwarf_regnum(regname, 0);
+	free(regname);
+	return 0;
+}
+
+/**
+ * annotate_get_insn_location - Get location of instruction
+ * @arch: the architecture info
+ * @dl: the target instruction
+ * @loc: a buffer to save the data
+ *
+ * Get detailed location info (register and offset) in the instruction.
+ * It needs both source and target operand and whether it accesses a
+ * memory location.  The offset field is meaningful only when the
+ * corresponding mem flag is set.
+ *
+ * Some examples on x86:
+ *
+ *   mov  (%rax), %rcx   # src_reg = rax, src_mem = 1, src_offset = 0
+ *                       # dst_reg = rcx, dst_mem = 0
+ *
+ *   mov  0x18, %r8      # src_reg = -1, dst_reg = r8
+ */
+int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
+			       struct annotated_insn_loc *loc)
+{
+	struct ins_operands *ops;
+	struct annotated_op_loc *op_loc;
+	int i;
+
+	if (!strcmp(dl->ins.name, "lock"))
+		ops = dl->ops.locked.ops;
+	else
+		ops = &dl->ops;
+
+	if (ops == NULL)
+		return -1;
+
+	memset(loc, 0, sizeof(*loc));
+
+	for_each_insn_op_loc(loc, i, op_loc) {
+		const char *insn_str = ops->source.raw;
+
+		if (i == INSN_OP_TARGET)
+			insn_str = ops->target.raw;
+
+		/* Invalidate the register by default */
+		op_loc->reg = -1;
+
+		if (insn_str == NULL)
+			continue;
+
+		if (strchr(insn_str, arch->objdump.memory_ref_char)) {
+			op_loc->mem_ref = true;
+			extract_reg_offset(arch, insn_str, op_loc);
+		} else {
+			char *s = strdup(insn_str);
+
+			if (s) {
+				op_loc->reg = get_dwarf_regnum(s, 0);
+				free(s);
+			}
+		}
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 2ef7e7dda7bd..25ae8893d4f9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -439,4 +439,40 @@ int annotate_parse_percent_type(const struct option *opt, const char *_str,
 
 int annotate_check_args(void);
 
+/**
+ * struct annotated_op_loc - Location info of instruction operand
+ * @reg: Register in the operand
+ * @offset: Memory access offset in the operand
+ * @mem_ref: Whether the operand accesses memory
+ */
+struct annotated_op_loc {
+	int reg;
+	int offset;
+	bool mem_ref;
+};
+
+enum annotated_insn_ops {
+	INSN_OP_SOURCE = 0,
+	INSN_OP_TARGET = 1,
+
+	INSN_OP_MAX,
+};
+
+/**
+ * struct annotated_insn_loc - Location info of instruction
+ * @ops: Array of location info for source and target operands
+ */
+struct annotated_insn_loc {
+	struct annotated_op_loc ops[INSN_OP_MAX];
+};
+
+#define for_each_insn_op_loc(insn_loc, i, op_loc)			\
+	for (i = INSN_OP_SOURCE, op_loc = &(insn_loc)->ops[i];		\
+	     i < INSN_OP_MAX;						\
+	     i++, op_loc++)
+
+/* Get detailed location info in the instruction */
+int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
+			       struct annotated_insn_loc *loc);
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.43.0.472.g3155946c3a-goog

