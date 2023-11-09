Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94D37E7576
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbjKJABd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbjKJAAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A5A49D9;
        Thu,  9 Nov 2023 16:00:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6be0277c05bso1416748b3a.0;
        Thu, 09 Nov 2023 16:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574439; x=1700179239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yak7ZiK/orMJhPDQBjUATJ5nSnN4xhs60FDmugSdC0Y=;
        b=epgO4grcPCC0a815L1IXE8TZG4vtfnBNKBZNayuZNaTwwnUgwVYCLCI93K8zIxWW/h
         V7f8OtYXh664+D8NW1ET7tLT5uDD57OQEZkjCsquTNsfy7D5sxv82g/aHbTxeGfLSJq2
         xxcchVFAY2H3AwDEPFVI1fToWmWRBt48P7sP4R1JHOUDu5Ao2Sw7aEHsCr60QSm70ATv
         Oti+XumD0b4kG4MuHPSCWoxBHY1PjBw199BecboeiBvUNjMQ3chUBOtPYzm+U1BMA8Rb
         DxDXuBp9Rivu3QPrm7uLGGPIyqT2kgGwrKOxU0vMzRNHvU2xLTJPmM1hNQkcieXlYvK0
         GAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574439; x=1700179239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yak7ZiK/orMJhPDQBjUATJ5nSnN4xhs60FDmugSdC0Y=;
        b=cYn5IZqQ1VFH/HSiZgOfszMXrFNWIYRPr0dIwJSvzlMn7oHOx3TZfgbIcGTl+IY3ln
         jUUQi+v/T2y2iedulLPkyOGJ1SBts+BfZ1ECTk/NU3ztJUfsN+nEinrA6ewQV5peeiTJ
         +SX+SF8I6ofa7hfm6R1vbqgfiM+Bu1Jg6xcoU7Tml0Z4QYc0yBdF2VD/n8PdYvvBIXvV
         547EbOAlgzteekJpGQCPhtCEl/yEmhAh7fZInW5p5aDvmEzD3yhm9dwdpFwqRAw1ixIl
         kVDaZJzTxRvyixIc+YhmetL+RMaOkIwakV/Fs7vO2FSgS3zkCiYv3ZP3G0b+9kMskGsG
         wHDQ==
X-Gm-Message-State: AOJu0YyMrjj5i9tCk7j9p3RUXrc3RxDrTFbe2o0RJZn0BJFu0Tpqy1Tq
        pdwj9Jz85aOXW9eEv/BjsSA=
X-Google-Smtp-Source: AGHT+IHOnFmfzVnnX1rpOFEixG0qlHI9krjG5m81PSquo/G5LrU/uwO6UeBHn/iO+psTLRUHxwDLmA==
X-Received: by 2002:a05:6a21:187:b0:161:28e0:9abd with SMTP id le7-20020a056a21018700b0016128e09abdmr8060198pzb.16.1699574439336;
        Thu, 09 Nov 2023 16:00:39 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:38 -0800 (PST)
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
Subject: [PATCH 16/52] perf annotate: Add annotate_get_insn_location()
Date:   Thu,  9 Nov 2023 15:59:35 -0800
Message-ID: <20231110000012.3538610-17-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 9e297adc8c59..f0c89552087d 100644
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
@@ -3522,3 +3523,109 @@ int annotate_check_args(struct annotation_options *args)
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
index 4ebc6407c68a..10eefecf49c4 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -445,4 +445,40 @@ int annotate_parse_percent_type(const struct option *opt, const char *_str,
 
 int annotate_check_args(struct annotation_options *args);
 
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
2.42.0.869.gea05f2083d-goog

