Return-Path: <linux-kernel+bounces-50644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF28847C06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413EB1F2C64C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3139130AFE;
	Fri,  2 Feb 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqLKpGXh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F1130AD0;
	Fri,  2 Feb 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911509; cv=none; b=ZP0+nZx7n+l+rpjNugtQ9reEmb/EhGbF7l+NGtRTEytOdkLxnBxo+3qEaUr/E1P0nxwpgPeOBPxsUTzKfJ8Qtt1kiznDB+O2SGJpkt37+CqeE863fm7b8D4ukEk8Btrpd+Pw44nUa3urYWWpomQi9GfLkLNZJgo0CJqEzb164qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911509; c=relaxed/simple;
	bh=i+cKdwWRkc3VtQ3wGRnNjPZEDzZov+iNSpO+Ws+UzjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMxGw2oR+YWeHJWW+IjbzId5mibAhEXvwhDV2J7P57BPVzl9hqnMEIDTEXncnQtBE51ATJvAgF8Yx0lJ25KtSDcTuS7cK/qHnBE++dZkdshiLTFoBJ22BgLXmShENfEB9gL7iU5xvEA6cfqFv7iehYU440aLNYTkQUqDiYrxuIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqLKpGXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE65C41679;
	Fri,  2 Feb 2024 22:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911508;
	bh=i+cKdwWRkc3VtQ3wGRnNjPZEDzZov+iNSpO+Ws+UzjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BqLKpGXhq8rFfojJ1pgADczuOdLkKNvIeoR/LVYkVr8+ZN6+aN/xXJ2oBkhTUI5/C
	 5b48DsMgzZMkkdDfclDizZwt2OkZxK+92L33dI05CrPBJFCnBEMvBhZbFkueOTyNy0
	 +NoVr0UGLWfofIN720AIZbD8lASOKBefTCvTbWI1yz7f2tlGPX7zWP0n2ferWkxlJG
	 ivJPKCYVXxEa7sh2k5Y6OEwDT4CYCJK+55gMtsOw1NRVb2Tg3FClAB5IQBG/MpJBG2
	 76//JXP+KV4KGc6oLhTSVqaE60dgdpiyJFsiotpAUeOIoEEKfMjjLEPMRomnoo5ZGN
	 crA5j+EbrPbHw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org
Subject: [PATCH 11/14] perf annotate: Parse x86 segment register location
Date: Fri,  2 Feb 2024 14:04:56 -0800
Message-ID: <20240202220459.527138-12-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202220459.527138-1-namhyung@kernel.org>
References: <20240202220459.527138-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a segment field in the struct annotated_insn_loc and save it for the
segment based addressing like %gs:0x28.  For simplicity it now handles
%gs register only.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 21 +++++++++++++++++++--
 tools/perf/util/annotate.h | 13 +++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 89a8d57b1bf7..86ac44c476bf 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3557,6 +3557,12 @@ static int extract_reg_offset(struct arch *arch, const char *str,
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
@@ -3653,8 +3659,19 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
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
@@ -3875,7 +3892,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 			.op = op_loc,
 		};
 
-		if (!op_loc->mem_ref)
+		if (!op_loc->mem_ref && op_loc->segment == INSN_SEG_NONE)
 			continue;
 
 		/* Recalculate IP because of LOCK prefix or insn fusion */
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index b460785111a1..2bd654620de3 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -446,6 +446,7 @@ int annotate_check_args(void);
  * @reg1: First register in the operand
  * @reg2: Second register in the operand
  * @offset: Memory access offset in the operand
+ * @segment: Segment selector register
  * @mem_ref: Whether the operand accesses memory
  * @multi_regs: Whether the second register is used
  */
@@ -453,6 +454,7 @@ struct annotated_op_loc {
 	int reg1;
 	int reg2;
 	int offset;
+	u8 segment;
 	bool mem_ref;
 	bool multi_regs;
 };
@@ -464,6 +466,17 @@ enum annotated_insn_ops {
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
2.43.0.594.gd9cf4e227d-goog


