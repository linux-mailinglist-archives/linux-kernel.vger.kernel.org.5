Return-Path: <linux-kernel+bounces-107042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FB087F6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994591C2192A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758ED7FBCC;
	Tue, 19 Mar 2024 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2bnM4BR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3407F7ED;
	Tue, 19 Mar 2024 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827487; cv=none; b=tAX8vuN6/M5NGkOnyzOi3kOgQ8z9NMeB3hGYvBhUG5j3R7eaj9TD0zxKsFGplAPlgkZYOCMqebG9wU/Wjx9Iji4GK78cKcN25M7uTkpBz4Wj4OrY96DhfnrIXuG+ztwktRzFQ3oRcnrvd5DcVyQZMT7KULgMhrHGxjYmPrFHL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827487; c=relaxed/simple;
	bh=jI51wNRC8ThpORG4FB43LJXCrP24HAJo4LwhgE6X6a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBlkjpBh5ERW7fSwQCwEAE0+OyNVNh6D1m3s6zZ9WN8dpA5nUupe2V9U1FluR0k2TBtSMnAB6oG2f3thwmKbxJHGSOKrwU1omGS/6g0tmKKCrFSJ7Zedkv0KGD4/Z6w/bVuhX1OSC4pcRU14IOeTV4E7zS0LPHqr/etw2Q5z13Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2bnM4BR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07E1C43141;
	Tue, 19 Mar 2024 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827487;
	bh=jI51wNRC8ThpORG4FB43LJXCrP24HAJo4LwhgE6X6a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2bnM4BRrtGgEDVsxYbo5orCye0x5wVSUgu8HgO3sFRe7tvsS25eX7eP5JFlv0+/o
	 kBV82VbDcS+DGoQLniXj6Md1Wc8bZhs0/0NX5EYoasHJo1wrBWDRfipBXBGZ47kz2Z
	 l10HbUAcAJu6gKpPF71zomRnSvAvT/LEUdyNIK2d0UtBi2b5BnJMJ4jwdUdrUTJ0/X
	 yA4EGp3xfABR6E4Pu1WdqS3JRhQIbG/DvfWYhr3fhBr2+hzfEkNxnAlLFbm6TUmfJs
	 cgFHFbItXHZQpVhb7fBIc5wxV5aihLktl6k7J29TW/eXGJtHWuExw+goZWRtk+JFaT
	 8UGsj7+IBpc7Q==
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
Subject: [PATCH 16/23] perf annotate: Parse x86 segment register location
Date: Mon, 18 Mar 2024 22:51:08 -0700
Message-ID: <20240319055115.4063940-17-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
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
 tools/perf/util/annotate.c | 36 ++++++++++++++++++++++++++++++++----
 tools/perf/util/annotate.h | 15 +++++++++++++++
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index abb641aa8ec0..3aa3a3b987ad 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -94,6 +94,7 @@ struct arch {
 		char skip_functions_char;
 		char register_char;
 		char memory_ref_char;
+		char imm_char;
 	} objdump;
 };
 
@@ -211,6 +212,7 @@ static struct arch architectures[] = {
 			.comment_char = '#',
 			.register_char = '%',
 			.memory_ref_char = '(',
+			.imm_char = '$',
 		},
 	},
 	{
@@ -3585,6 +3587,12 @@ static int extract_reg_offset(struct arch *arch, const char *str,
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
@@ -3681,12 +3689,32 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 			op_loc->multi_regs = multi_regs;
 			extract_reg_offset(arch, insn_str, op_loc);
 		} else {
-			char *s = strdup(insn_str);
+			char *s, *p = NULL;
+
+			if (arch__is(arch, "x86")) {
+				/* FIXME: Handle other segment registers */
+				if (!strncmp(insn_str, "%gs:", 4)) {
+					op_loc->segment = INSN_SEG_X86_GS;
+					op_loc->offset = strtol(insn_str + 4,
+								&p, 0);
+					if (p && p != insn_str + 4)
+						op_loc->imm = true;
+					continue;
+				}
+			}
+
+			s = strdup(insn_str);
+			if (s == NULL)
+				return -1;
 
-			if (s) {
+			if (*s == arch->objdump.register_char)
 				op_loc->reg1 = get_dwarf_regnum(s, 0);
-				free(s);
+			else if (*s == arch->objdump.imm_char) {
+				op_loc->offset = strtol(s + 1, &p, 0);
+				if (p && p != s + 1)
+					op_loc->imm = true;
 			}
+			free(s);
 		}
 	}
 
@@ -3881,7 +3909,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 			.op = op_loc,
 		};
 
-		if (!op_loc->mem_ref)
+		if (!op_loc->mem_ref && op_loc->segment == INSN_SEG_NONE)
 			continue;
 
 		/* Recalculate IP because of LOCK prefix or insn fusion */
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0928663fddee..14980b65f812 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -511,15 +511,19 @@ int annotate_check_args(void);
  * @reg1: First register in the operand
  * @reg2: Second register in the operand
  * @offset: Memory access offset in the operand
+ * @segment: Segment selector register
  * @mem_ref: Whether the operand accesses memory
  * @multi_regs: Whether the second register is used
+ * @imm: Whether the operand is an immediate value (in offset)
  */
 struct annotated_op_loc {
 	int reg1;
 	int reg2;
 	int offset;
+	u8 segment;
 	bool mem_ref;
 	bool multi_regs;
+	bool imm;
 };
 
 enum annotated_insn_ops {
@@ -529,6 +533,17 @@ enum annotated_insn_ops {
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
2.44.0.291.gc1ea87d7ee-goog


