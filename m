Return-Path: <linux-kernel+bounces-125469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D0892684
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550C52836FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732013C67C;
	Fri, 29 Mar 2024 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR4P5TBn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81B113DDBF;
	Fri, 29 Mar 2024 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749496; cv=none; b=nId620mtjzAdW7H+10m/Q6qa1aPTuoaSfCJKccP25//boXz0b9S33UXktReweAbKc4q7J9HVdxYoh31O+fsnczjba7WdSqPYHp/jYWaHjtX9B/bX025UEgSmu51/mPIbkYUMYREY/AnAblxAl61l+wpeNH616Bl0s16ZtsdtERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749496; c=relaxed/simple;
	bh=QoRt4dDlyk6Qc373mTQGAGRFy3PgED1qUI4SMerdU04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/qSuK2A6nt3cJj3VLhKVqofX2fzdhpqNj4M6e6FiewbRdvbMvVvbuGLqtt7aEhWMTSJgQf+bLnlDPs4YclqvZ7E6LI97xgkHjCvTAzgtRtUin2pC1/US4ZHOWrTsYeJAZZDgXyoNQrKNoDwL43YcZduOxicWLWi+3/wtM9Bphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR4P5TBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BD5C433F1;
	Fri, 29 Mar 2024 21:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749496;
	bh=QoRt4dDlyk6Qc373mTQGAGRFy3PgED1qUI4SMerdU04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QR4P5TBndjMmucdQ+S0YcqEc3R5yO+Oy7mrTGZPeF46oY3upldeDykL2Mth/LFKMj
	 l48nvGkcbGWm0bz6Gm9Cliewexn6ts4P51I+kUJfgpIC7QRLRBucEwav91KzRxBAST
	 0ZyS6x9mt4zqkAk8r5xT+r89Ny9pU6kQ4ren/jAUgf7+a+PXyoLc3ldKallXX7bITi
	 4y2faHlG+xd7EnbEtYG1Lr2emy6UqzWZAkMglZeaI5ghs6KsB9QG7TeIMOLeJLxCwn
	 3pE0GKK1NIiRpun61LbUMLFyV9wp3tFc9a8VFKTkdW0LlwxHgeh00D1TBxXWZ+o0Dh
	 rXvdS6gGJ41gg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v2 5/5] perf annotate: Add symbol name when using capstone
Date: Fri, 29 Mar 2024 14:58:12 -0700
Message-ID: <20240329215812.537846-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240329215812.537846-1-namhyung@kernel.org>
References: <20240329215812.537846-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to keep the existing behavior with objdump.  It needs to show
symbol information of global variables like below:

   Percent |      Source code & Disassembly of elf for cycles:P (1 samples, percent: local period)
  ------------------------------------------------------------------------------------------------
           : 0                0xffffffff81338f70 <vm_normal_page>:
      0.00 :   ffffffff81338f70:       endbr64
      0.00 :   ffffffff81338f74:       callq   0xffffffff81083a40
      0.00 :   ffffffff81338f79:       movq    %rdi, %r8
      0.00 :   ffffffff81338f7c:       movq    %rdx, %rdi
      0.00 :   ffffffff81338f7f:       callq   *0x17021c3(%rip)   # ffffffff82a3b148 <pv_ops+0x1e8>
      0.00 :   ffffffff81338f85:       movq    0xffbf3c(%rip), %rdx       # ffffffff82334ec8 <physical_mask>
      0.00 :   ffffffff81338f8c:       testq   %rax, %rax                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      0.00 :   ffffffff81338f8f:       je      0xffffffff81338fd0                         here
      0.00 :   ffffffff81338f91:       movq    %rax, %rcx
      0.00 :   ffffffff81338f94:       andl    $1, %ecx

Cc: Changbin Du <changbin.du@huawei.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/disasm.c | 74 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index cd2f7d67f423..1148153ea94f 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1363,6 +1363,12 @@ static int open_capstone_handle(struct annotate_args *args, bool is_64bit,
 	    !strcmp(opt->disassembler_style, "att"))
 		cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
 
+	/*
+	 * Resolving address operands to symbols is implemented
+	 * on x86 by investigating instruction details.
+	 */
+	cs_option(*handle, CS_OPT_DETAIL, CS_OPT_ON);
+
 	return 0;
 }
 
@@ -1383,6 +1389,63 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	return 0;
 }
 
+static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
+				  struct annotate_args *args, u64 addr)
+{
+	int i;
+	struct map *map = args->ms.map;
+	struct symbol *sym;
+
+	/* TODO: support more architectures */
+	if (!arch__is(args->arch, "x86"))
+		return;
+
+	if (insn->detail == NULL)
+		return;
+
+	for (i = 0; i < insn->detail->x86.op_count; i++) {
+		cs_x86_op *op = &insn->detail->x86.operands[i];
+		u64 orig_addr;
+
+		if (op->type != X86_OP_MEM)
+			continue;
+
+		/* only print RIP-based global symbols for now */
+		if (op->mem.base != X86_REG_RIP)
+			continue;
+
+		/* get the target address */
+		orig_addr = addr + insn->size + op->mem.disp;
+		addr = map__objdump_2mem(map, orig_addr);
+
+		if (map__dso(map)->kernel) {
+			/*
+			 * The kernel maps can be splitted into sections,
+			 * let's find the map first and the search the symbol.
+			 */
+			map = maps__find(map__kmaps(map), addr);
+			if (map == NULL)
+				continue;
+		}
+
+		/* convert it to map-relative address for search */
+		addr = map__map_ip(map, addr);
+
+		sym = map__find_symbol(map, addr);
+		if (sym == NULL)
+			continue;
+
+		if (addr == sym->start) {
+			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
+				  orig_addr, sym->name);
+		} else {
+			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
+				  orig_addr, sym->name, addr - sym->start);
+		}
+		break;
+	}
+}
+
 static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 					struct annotate_args *args)
 {
@@ -1453,9 +1516,14 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 
 	count = cs_disasm(handle, buf, len, start, len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
-		scnprintf(disasm_buf, sizeof(disasm_buf),
-			  "       %-7s %s",
-			  insn[i].mnemonic, insn[i].op_str);
+		int printed;
+
+		printed = scnprintf(disasm_buf, sizeof(disasm_buf),
+				    "       %-7s %s",
+				    insn[i].mnemonic, insn[i].op_str);
+		print_capstone_detail(&insn[i], disasm_buf + printed,
+				      sizeof(disasm_buf) - printed, args,
+				      start + offset);
 
 		args->offset = offset;
 		args->line = disasm_buf;
-- 
2.44.0.478.gd926399ef9-goog


