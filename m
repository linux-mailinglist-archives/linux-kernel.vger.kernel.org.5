Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFF47E759D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345490AbjKJAEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjKJADw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:03:52 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1206259EC;
        Thu,  9 Nov 2023 16:01:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-280cc5f3fdcso1333627a91.1;
        Thu, 09 Nov 2023 16:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574490; x=1700179290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0yOHOAq2UksaEKkQj6eSLR4JX7ylWQzwIPxJpm20xg=;
        b=c+VfexW65ZEebHKtDPlF+UjTtrxO72HsToiCOJQnkqBrC6rup7yZELOQolEigYhhvZ
         fWlUv0GAY/4tRGfn3VlCcWUQBphIFtfsVjMZI8Al45m7961Cg3hdI9KA4EjKy1yjPSep
         ovNyOFnPiI3GPUNKnFBKlKzd/dnFD8+jtObOqHmqFT/x5lZkoGWlQkYg37W6P0lwcMx5
         b8mFhZgMKUzmEXRDG9aaHel6BSxHJEwSpREeXnKiOrhfG+M2jHbIwd/ek4W/3AkA6cB6
         jDySlwP+4etvoHzcq+WOP8gdwlpb8U/kAymGywBmAU1bRD/tTDk4H6iYtN2uBJ+03+bV
         WJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574490; x=1700179290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j0yOHOAq2UksaEKkQj6eSLR4JX7ylWQzwIPxJpm20xg=;
        b=bVPZ94Qdl1/si3E5OlboMUy0IZ2IMeNV6JWTIzmHyRhhqSmGTEvoEqAsl952qjF9Jl
         QuzMHaKVGkyvlGQEcZAqKP5XjBf+SUxf5+NAxjbKr9drywRell8oxWX+RpQvNgR7IRB+
         jMuxrZbtxK7vVHIo/vxCfkl51gBhR0TSuqfzgn6DJlCnzrYtXR4cuRXS6jRR/pfc0d51
         vu5rkpKs9419iw6wB9TVPVJuSKM8wGbY5KhEo4Mumn4RlfyJxx7ZkJrIGb2kVihKX2j3
         QsUWtkE8ZlcEoylT6p+QNG3556LNrAVapK5wK1q+JgoiOLc4+9WAaMdisA3ljdsHnL23
         HTZg==
X-Gm-Message-State: AOJu0Yxig2Mv3EAZ5VfS2o8MrL/Fzqm1jXqiePvQ/LuG1of9mbZeaBJl
        3sZT51/sBcNk8tflgFvHIxA=
X-Google-Smtp-Source: AGHT+IF+88KdonlCki49GFMVxctkL0pwwYI/XQUw7DKdjSyociTWztm1J1KuUHnNSzTxmrgeLIXagg==
X-Received: by 2002:a17:90b:1bc3:b0:280:1ffe:5930 with SMTP id oa3-20020a17090b1bc300b002801ffe5930mr2998201pjb.14.1699574490226;
        Thu, 09 Nov 2023 16:01:30 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:29 -0800 (PST)
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
Subject: [PATCH 48/52] perf annotate: Parse x86 segment register location
Date:   Thu,  9 Nov 2023 16:00:07 -0800
Message-ID: <20231110000012.3538610-49-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a segment field in the struct annotated_insn_loc and save it for the
segment based addressing like %gs:0x28.  For simplicity it now handles
%gs register only.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 21 +++++++++++++++++++--
 tools/perf/util/annotate.h | 13 +++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 33fd032bf463..a9075af10d24 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3561,6 +3561,12 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 	 * %gs:0x18(%rbx).  In that case it should skip the part.
 	 */
 	if (*str == arch->objdump.register_char) {
+		if (arch__is(arch, "x86")) {
+			/* FIXME: Handle other segment registers */
+			if (!strncmp(str, "%gs:", 4))
+				op_loc->segment = INSN_SEG_X86_GS;
+		}
+
 		while (*str && !isdigit(*str) &&
 		       *str != arch->objdump.memory_ref_char)
 			str++;
@@ -3657,8 +3663,19 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 			op_loc->multi_regs = multi_regs;
 			extract_reg_offset(arch, insn_str, op_loc);
 		} else {
-			char *s = strdup(insn_str);
+			char *s;
+
+			if (arch__is(arch, "x86")) {
+				/* FIXME: Handle other segment registers */
+				if (!strncmp(insn_str, "%gs:", 4)) {
+					op_loc->segment = INSN_SEG_X86_GS;
+					op_loc->offset = strtol(insn_str + 4,
+								NULL, 0);
+					continue;
+				}
+			}
 
+			s = strdup(insn_str);
 			if (s) {
 				op_loc->reg1 = get_dwarf_regnum(s, 0);
 				free(s);
@@ -3874,7 +3891,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 			.op = op_loc,
 		};
 
-		if (!op_loc->mem_ref)
+		if (!op_loc->mem_ref && op_loc->segment == INSN_SEG_NONE)
 			continue;
 
 		/* Recalculate IP because of LOCK prefix or insn fusion */
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 13c9b6a30b15..21a0947ed5e9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -452,6 +452,7 @@ int annotate_check_args(struct annotation_options *args);
  * @reg1: First register in the operand
  * @reg2: Second register in the operand
  * @offset: Memory access offset in the operand
+ * @segment: Segment selector register
  * @mem_ref: Whether the operand accesses memory
  * @multi_regs: Whether the second register is used
  */
@@ -459,6 +460,7 @@ struct annotated_op_loc {
 	int reg1;
 	int reg2;
 	int offset;
+	u8 segment;
 	bool mem_ref;
 	bool multi_regs;
 };
@@ -470,6 +472,17 @@ enum annotated_insn_ops {
 	INSN_OP_MAX,
 };
 
+enum annotated_x86_segment {
+	INSN_SEG_NONE = 0,
+
+	INSN_SEG_X86_CS,
+	INSN_SEG_X86_DS,
+	INSN_SEG_X86_ES,
+	INSN_SEG_X86_FS,
+	INSN_SEG_X86_GS,
+	INSN_SEG_X86_SS,
+};
+
 /**
  * struct annotated_insn_loc - Location info of instruction
  * @ops: Array of location info for source and target operands
-- 
2.42.0.869.gea05f2083d-goog

