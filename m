Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB657C6374
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377358AbjJLDwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376992AbjJLDwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:11 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F08116;
        Wed, 11 Oct 2023 20:51:33 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7d532da4bso6895567b3.2;
        Wed, 11 Oct 2023 20:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082692; x=1697687492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwugeUz2Kizrt8bo2ssr4th1+PIs+ybthYkaJJ9iBxc=;
        b=fh/U7yOUJdScqGCTsxHDN6EaC7RXG4Di7DwztT/Vy8dYflmO6SJcSkrFQXnpDH1oGl
         nmdjP1LgWaO2EVjF70TBALpFbEOlhYiGnwMpvfzXgPTVuasbFK8lUaF4rDHXimvEM1ui
         F2jEtu8j8F0GwWPKtkzF3F7AouMZ+KDkJomVCNnrO3YNdV0UUWo6LQlV2gbTLxIYH55j
         bQBK0mOF+jVqOs806CMlr2P3nkDlUzMnrooiR+KsYXla9nqppo+lRj9Xjhrrq0lrCGpi
         FBMTHdGwHjkPYBBal2mCNfeMYW4uMRFz72sI76GCf4ZC28DOwSCe+J8Zoyip6z7c1znr
         XKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082692; x=1697687492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wwugeUz2Kizrt8bo2ssr4th1+PIs+ybthYkaJJ9iBxc=;
        b=SyEYSzBTWVdzKK+cNSJmNXnLrEoNaiVKJMgZln/5bbgS8wSYVm0SqxmdKuWqVKlj0h
         LVZv/TWpm3DCT76b1hCpUhVqBnab5IxcArR7uO2cqvAVz0yuCAizZs/bIl0eqlXTtAM8
         pYAU0XG7VbWTpwfrTV7erVK4+RhtcW+NHgZ0JH+0xP6UYmn98cKjSaR27LK+ePr/QbRV
         LlT/LlZtdH5EN9dHiAgW13DcxGWhyZ6UTusEpezzzsK3wxWVh8/bc07xEZgniX7P45nw
         6NTu4t9FehMsVJ9rWMqdh8qybgv95ulbu86sp/q76Oym56zk/Sd3NYV9LvuuV2VW4P5c
         e5Zw==
X-Gm-Message-State: AOJu0YwYh34OLfFo0eRsqg4t8AN6ap1xHPmM29/KF0uG4QkD6XIJRZYU
        RrWpXRDzUhXqDNTeQPdZXgU=
X-Google-Smtp-Source: AGHT+IHylZn0o9l2x1CECps0Fs/T61+2AgZHx3X6wLdIXl9pwLIFxKlIo0r01FrU6L/p+JpPh+pnuA==
X-Received: by 2002:a05:690c:3744:b0:5a7:d4a2:cd13 with SMTP id fw4-20020a05690c374400b005a7d4a2cd13mr5373990ywb.8.1697082692066;
        Wed, 11 Oct 2023 20:51:32 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:31 -0700 (PDT)
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
Subject: [PATCH 13/48] perf annotate: Add annotate_get_insn_location()
Date:   Wed, 11 Oct 2023 20:50:36 -0700
Message-ID: <20231012035111.676789-14-namhyung@kernel.org>
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
index 254cc9f224f4..9d653a1e84ce 100644
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
@@ -3484,3 +3485,109 @@ int annotate_check_args(struct annotation_options *args)
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
index c74f8f10f705..4adda492233d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -437,4 +437,40 @@ int annotate_parse_percent_type(const struct option *opt, const char *_str,
 
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
2.42.0.655.g421f12c284-goog

