Return-Path: <linux-kernel+bounces-28528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B930E82FFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D151C23BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09E0747C;
	Wed, 17 Jan 2024 05:12:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A17465;
	Wed, 17 Jan 2024 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705468336; cv=none; b=aTRkT92Z8A9eq/eBC1EmgI1yz5MpTpLR2NmHs8OpGHxBX4CwJjLQTncBX1rFWQ56kvmghnCqlBBawuBR9gTfCbKyB5Y5h22CaCIZY+fgIOYL+8m89UjnBibA/W9U/SQWEMg1eyIHXJvmLmO0krL8iL56Y/iB26neg7k0dHHNCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705468336; c=relaxed/simple;
	bh=2uo0YO4RcrgYnAcP4CJ/AsayZIkKRqVq0cA8AwY4BqE=;
	h=Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy; b=WBDUmAEq8iIIiW6r64u4PgjAc/GQ+sb+UrRmxKAJS9tue2KEEwEo12VTmu4ncrSRDWIS2JoRdCAyRjQdH0IL54L42LqmonvzzoaBPo+kzmRT59lqNn4L8dFfdT4EBdVatl937cupe79YeOeEvZRhjMZL86K1kzfgc9sTznildVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TFDVF6c1FzvTxN;
	Wed, 17 Jan 2024 13:10:45 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A647140390;
	Wed, 17 Jan 2024 13:11:55 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Wed, 17 Jan 2024 13:11:26 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas
 Richter <tmricht@linux.ibm.com>, <changbin.du@gmail.com>, Changbin Du
	<changbin.du@huawei.com>
Subject: [PATCH v2 2/5] perf: util: use capstone disasm engine to show assembly instructions
Date: Wed, 17 Jan 2024 13:11:01 +0800
Message-ID: <20240117051104.2147643-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117051104.2147643-1-changbin.du@huawei.com>
References: <20240117051104.2147643-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100002.china.huawei.com (7.221.188.184)

Currently, the instructions of samples are shown as raw hex strings
which are hard to read. x86 has a special option '--xed' to disassemble
the hex string via intel XED tool.

Here we use capstone as our disassembler engine to give more friendly
instructions. We select libcapstone because capstone can provide more
insn details. Perf will fallback to raw instructions if libcapstone is
not available.

The advantages compared to XED tool:
 * Support arm, arm64, x86-32, x86_64 (more could be supported),
   xed only for x86_64.
 * Immediate address operands are shown as symbol+offs.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-script.c  |   8 +--
 tools/perf/util/Build        |   1 +
 tools/perf/util/print_insn.c | 123 +++++++++++++++++++++++++++++++++++
 tools/perf/util/print_insn.h |  14 ++++
 4 files changed, 141 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/util/print_insn.c
 create mode 100644 tools/perf/util/print_insn.h

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b1f57401ff23..4817a37f16e2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -34,6 +34,7 @@
 #include "util/event.h"
 #include "ui/ui.h"
 #include "print_binary.h"
+#include "print_insn.h"
 #include "archinsn.h"
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
@@ -1511,11 +1512,8 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 	if (PRINT_FIELD(INSNLEN))
 		printed += fprintf(fp, " ilen: %d", sample->insn_len);
 	if (PRINT_FIELD(INSN) && sample->insn_len) {
-		int i;
-
-		printed += fprintf(fp, " insn:");
-		for (i = 0; i < sample->insn_len; i++)
-			printed += fprintf(fp, " %02x", (unsigned char)sample->insn[i]);
+		printed += fprintf(fp, " insn: ");
+		printed += sample__fprintf_insn_raw(sample, fp);
 	}
 	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
 		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 988473bf907a..c33aab53d8dd 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -32,6 +32,7 @@ perf-y += perf_regs.o
 perf-y += perf-regs-arch/
 perf-y += path.o
 perf-y += print_binary.o
+perf-y += print_insn.o
 perf-y += rlimit.o
 perf-y += argv_split.o
 perf-y += rbtree.o
diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
new file mode 100644
index 000000000000..fe035efe8cf6
--- /dev/null
+++ b/tools/perf/util/print_insn.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Instruction binary disassembler based on capstone.
+ *
+ * Author(s): Changbin Du <changbin.du@huawei.com>
+ */
+#include "print_insn.h"
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include "util/debug.h"
+#include "util/symbol.h"
+#include "machine.h"
+
+size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
+{
+	int printed = 0;
+
+	for (int i = 0; i < sample->insn_len; i++)
+		printed += fprintf(fp, "%02x ", (unsigned char)sample->insn[i]);
+	return printed;
+}
+
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+#include <capstone/capstone.h>
+
+static int capstone_init(struct machine *machine, csh *cs_handle)
+{
+	cs_arch arch;
+	cs_mode mode;
+
+	if (machine__is(machine, "x86_64")) {
+		arch = CS_ARCH_X86;
+		mode = CS_MODE_64;
+	} else if (machine__normalized_is(machine, "x86")) {
+		arch = CS_ARCH_X86;
+		mode = CS_MODE_32;
+	} else if (machine__normalized_is(machine, "arm64")) {
+		arch = CS_ARCH_ARM64;
+		mode = CS_MODE_ARM;
+	} else if (machine__normalized_is(machine, "arm")) {
+		arch = CS_ARCH_ARM;
+		mode = CS_MODE_ARM + CS_MODE_V8;
+	} else if (machine__normalized_is(machine, "s390x")) {
+		arch = CS_ARCH_SYSZ;
+		mode = CS_MODE_BIG_ENDIAN;
+	} else {
+		return -1;
+	}
+
+	if (cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
+		pr_warning_once("cs_open failed\n");
+		return -1;
+	}
+
+	cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+	if (machine__normalized_is(machine, "x86"))
+		cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
+
+	return 0;
+}
+
+static size_t print_insn_x86(struct perf_sample *sample, struct thread *thread,
+			     cs_insn *insn, FILE *fp)
+{
+	struct addr_location al;
+	size_t printed = 0;
+
+	if (insn->detail && insn->detail->x86.op_count == 1) {
+		cs_x86_op *op = &insn->detail->x86.operands[0];
+
+		addr_location__init(&al);
+
+		/* TODO: Add support for other ISAs */
+		if (op->type == X86_OP_IMM &&
+		    thread__find_symbol(thread, sample->cpumode, op->imm, &al)) {
+			printed += fprintf(fp, "%s ", insn[0].mnemonic);
+			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
+			return printed;
+		}
+	}
+
+	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
+	return printed;
+}
+
+size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread,
+			    struct machine *machine, FILE *fp)
+{
+	static csh cs_handle;
+	cs_insn *insn;
+	size_t count;
+	size_t printed = 0;
+	int ret;
+
+	ret = capstone_init(machine, &cs_handle);
+	if (ret < 0) {
+		/* fallback */
+		return sample__fprintf_insn_raw(sample, fp);
+	}
+
+	count = cs_disasm(cs_handle, (uint8_t *)sample->insn, sample->insn_len,
+			  sample->ip, 1, &insn);
+	if (count > 0) {
+		if (machine__normalized_is(machine, "x86"))
+			printed += print_insn_x86(sample, thread, &insn[0], fp);
+		else
+			printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
+		cs_free(insn, count);
+	} else {
+		printed += fprintf(fp, "illegal instruction");
+	}
+
+	cs_close(&cs_handle);
+	return printed;
+}
+#else
+size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread __maybe_unused,
+			    struct machine *machine __maybe_unused, FILE *fp)
+{
+	return sample__fprintf_insn_raw(sample, fp);
+}
+#endif
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
new file mode 100644
index 000000000000..af8fa5d01fb7
--- /dev/null
+++ b/tools/perf/util/print_insn.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef PERF_PRINT_ISNS_H
+#define PERF_PRINT_ISNS_H
+
+#include <stddef.h>
+#include <stdio.h>
+#include "event.h"
+#include "util/thread.h"
+
+size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread,
+			    struct machine *machine, FILE *fp);
+size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp);
+
+#endif /* PERF_PRINT_ISNS_H */
-- 
2.25.1


