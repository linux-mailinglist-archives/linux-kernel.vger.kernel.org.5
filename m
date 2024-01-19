Return-Path: <linux-kernel+bounces-31058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFC83282B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270F01F21701
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799FE4E1A0;
	Fri, 19 Jan 2024 10:49:23 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF54D12A;
	Fri, 19 Jan 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661363; cv=none; b=ZMSsB2+NQyB1X+XKQQWvhfRUQhanJh9330WDWyElcoILCXJivQ4OcL+EOJ5rd5eHXy+XOODbUAucII8b70yEgtUiJ7XQxw5MVgsF2f9mXy8P84Oo8XuyP5me0JTNXsdRwC3lz92sjna7+Jxke6A/JxibUZNiLKnPRPbGy4XzKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661363; c=relaxed/simple;
	bh=bdgZAi3dBtuCIiCD/ocOwY507QHlFxFOeM9OZcRjZbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOGdxb8e8YNvK+sy2OEzVYX6nVlPMS/XRh0uUgcRoT/P/VEegsweugUzwhx/m6D0pXFUlGXoXTt8M/RR/SE4Vksdca+cP+8NYj9+cLifw/DnT80A87KQZtrpF2raNvFdYfqekgWX6lmq2sRerGHFtpFa2b25/sbmnHo1U9QUDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TGbtj5YN5zXgVg;
	Fri, 19 Jan 2024 18:48:13 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B38C180077;
	Fri, 19 Jan 2024 18:49:18 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 19 Jan 2024 18:49:17 +0800
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
Subject: [PATCH v4 4/5] perf: script: add raw|disasm arguments to --insn-trace option
Date: Fri, 19 Jan 2024 18:48:55 +0800
Message-ID: <20240119104856.3617986-5-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119104856.3617986-1-changbin.du@huawei.com>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100002.china.huawei.com (7.221.188.184)

Now '--insn-trace' accept a argument to specify the output format:
  - raw: display raw instructions.
  - disasm: display mnemonic instructions (if capstone is installed).

$ sudo perf script --insn-trace=raw
              ls 1443864 [006] 2275506.209908875:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: 48 89 e7
              ls 1443864 [006] 2275506.209908875:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: e8 e8 0c 00 00
              ls 1443864 [006] 2275506.209908875:      7f216b426df0 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: f3 0f 1e fa

$ sudo perf script --insn-trace=disasm
              ls 1443864 [006] 2275506.209908875:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rdi
              ls 1443864 [006] 2275506.209908875:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: callq _dl_start+0x0
              ls 1443864 [006] 2275506.209908875:      7f216b426df0 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: illegal instruction
              ls 1443864 [006] 2275506.209908875:      7f216b426df4 _dl_start+0x4 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: pushq %rbp
              ls 1443864 [006] 2275506.209908875:      7f216b426df5 _dl_start+0x5 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rbp
              ls 1443864 [006] 2275506.209908875:      7f216b426df8 _dl_start+0x8 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: pushq %r15

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/Documentation/perf-script.txt |  6 +++---
 tools/perf/builtin-script.c              | 17 +++++++++++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index fc79167c6bf8..9ae54f5bcb4d 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -442,9 +442,9 @@ include::itrace.txt[]
 	will be printed. Each entry has function name and file/line. Enabled by
 	default, disable with --no-inline.
 
---insn-trace::
-	Show instruction stream for intel_pt traces. Combine with --xed to
-	show disassembly.
+--insn-trace[=<raw|disasm>]::
+	Show raw or mnemonic instruction stream for intel_pt traces. You can
+	also combine raw instructions with --xed to show disassembly.
 
 --xed::
 	Run xed disassembler on output. Requires installing the xed disassembler.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 12d886694f6c..2e3752b3b65a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3769,10 +3769,19 @@ static int perf_script__process_auxtrace_info(struct perf_session *session,
 #endif
 
 static int parse_insn_trace(const struct option *opt __maybe_unused,
-			    const char *str __maybe_unused,
-			    int unset __maybe_unused)
+			    const char *str, int unset __maybe_unused)
 {
-	parse_output_fields(NULL, "+insn,-event,-period", 0);
+	const char *fields = "+insn,-event,-period";
+
+	if (str) {
+		if (strcmp(str, "disasm") == 0)
+			fields = "+disasm,-event,-period";
+		else if (strlen(str) != 0 && strcmp(str, "raw") != 0) {
+			fprintf(stderr, "Only accept raw|disasm\n");
+			return -EINVAL;
+		}
+	}
+	parse_output_fields(NULL, fields, 0);
 	itrace_parse_synth_opts(opt, "i0ns", 0);
 	symbol_conf.nanosecs = true;
 	return 0;
@@ -3918,7 +3927,7 @@ int cmd_script(int argc, const char **argv)
 		   "only consider these symbols"),
 	OPT_INTEGER(0, "addr-range", &symbol_conf.addr_range,
 		    "Use with -S to list traced records within address range"),
-	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
+	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, "raw|disasm",
 			"Decode instructions from itrace", parse_insn_trace),
 	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
 			"Run xed disassembler on output", parse_xed),
-- 
2.25.1


